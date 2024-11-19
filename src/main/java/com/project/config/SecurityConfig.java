package com.project.config;

import java.io.IOException;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpMethod;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.core.Authentication;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.security.web.authentication.SimpleUrlAuthenticationSuccessHandler;
import org.springframework.security.web.csrf.CookieCsrfTokenRepository;

import com.project.service.CustomOAuth2UserService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;

@Configuration
@EnableWebSecurity
@RequiredArgsConstructor
public class SecurityConfig {
    private final CustomOAuth2UserService customOAuth2UserService;
    //private final CustomOAuth2SuccessHandler customOAuth2SuccessHandler;
    private final CustomOAuth2FailureHandler customOAuth2FailureHandler;
	
	// 비밀번호 암호화
    @Bean
    public BCryptPasswordEncoder bCryptPasswordEncoder() {
        return new BCryptPasswordEncoder();
    }

    // 유저의 계층 관계 지정 (활성화 시 높은 권한 하나만 명시해도 됨)
    //@Bean
    //public RoleHierarchy roleHierarchy() {
    //    return RoleHierarchyImpl.fromHierarchy("ROLE_ADMIN > ROLE_USER");
    //}

    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {

        // 각 경로별 요청을 사용자의 권한, 역할에 따라 제어
        http.authorizeHttpRequests(auth -> auth
        		.requestMatchers("/css", "/js", "/images").permitAll()  // 정적 파일 접근 허용
        		.requestMatchers("/upload", "/WEB-INF/views").permitAll()  // webapp 하위 파일 접근 허용
        		.requestMatchers("/", "/login", "/loginProc").permitAll()
        		.requestMatchers("/admin/**").hasRole("ADMIN")
                .requestMatchers("/mypage", "/profile", "/account").hasAnyRole("ADMIN", "MEMBER")
                .anyRequest().permitAll()  // 이외의 요청은 인증(로그인)된 사용자만 허가
        );

        // 인증되지 않은 사용자가 권한이 없는 페이지에 접속하면 자동으로 로그인 페이지로 리다이렉트
        http.formLogin(auth -> auth
                .loginPage("/login")  // 로그인 페이지 경로
//                .loginProcessingUrl("/loginProc")  // 로그인 데이터를 보내는 경로 (기본 경로: POST /login)
                .usernameParameter("memberId")  // 유저 아이디 네이밍을 memberId로 커스텀
                .passwordParameter("passwd")    // 유저 패스워드 네이밍을 passwd로 커스텀
                .defaultSuccessUrl("/")  // 로그인 성공 시 기본 리다이렉트 URL
                .permitAll()  // 로그인 경로는 아무나 접근 가능
                .failureHandler((request, response, exception) -> {  // 로그인 실패 시 클라이언트에게 해당 데이터 전송
                    response.setContentType("application/json");
                    response.setCharacterEncoding("UTF-8");
                    response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
                    response.getWriter().write("{\"message\": \"로그인 실패. 아이디와 비밀번호를 확인하세요.\"}");
                })
        );
        
        // 권한이 없는 페이지에 접근할 시 에러 페이지 출력
        http.exceptionHandling(auth -> auth
        		// 인증되지 않은 경우 실행 (로그인되지 않은 경우)
                .authenticationEntryPoint((request, response, authException) -> {
                	response.sendRedirect("/login?message=nonAuthn");
//                    response.setContentType("application/json");  // 로그인하지 않으면 클라이언트에게 해당 데이터 전송
//                    response.setCharacterEncoding("UTF-8");
//                    response.setStatus(HttpServletResponse.SC_UNAUTHORIZED); // 401 상태 코드
//                    response.getWriter().write("{\"message\": \"로그인이 필요합니다.\"}");
                })
                // 권한이 없는 경우 실행 (MEMBER가 admin 페이지로 접근할 경우)
                .accessDeniedHandler((request, response, accessDeniedException) -> {
                    response.sendRedirect("/error/403");  // 요청에 대한 권한이 없을시 해당 경로로 리다이렉트
                })
        );

        // CSRF (사이트 위변조 방지 설정)는 기본값이 enable (enable 시 서버, 클라이언트가 CSRF 토큰을 주고받는 코드가 필요함)
        http.csrf(csrf -> csrf
        	    .ignoringRequestMatchers(request -> "GET".equalsIgnoreCase(request.getMethod())) // GET 요청에 대한 CSRF 보호 비활성화
        	);

//        http.csrf(auth -> auth
//                .disable()  // CSRF 보호 비활성화
//            );

        // 다중 로그인 설정
        http.sessionManagement(auth -> auth
                .maximumSessions(1)  // 다중 로그인 불가 (한 계정은 1명만 로그인)
                .maxSessionsPreventsLogin(true)  // 다중 로그인 시도 시 새로운 로그인 차단 (false 시 기존 세션 무효화)
            );

        // 세션 고정 공격 보호
        http.sessionManagement(auth -> auth
                .sessionFixation().changeSessionId()  // 로그인 시 동일한 세션의 id 변경
            );
        
        // 간편로그인 관련 설정
        http.oauth2Login(oauth2 -> oauth2
                .userInfoEndpoint(userInfo -> userInfo
                    .userService(customOAuth2UserService)
                )
                .successHandler(customAuthenticationSuccessHandler())  // 간편로그인 성공 시 실행되는 로직
                .failureHandler(customOAuth2FailureHandler)  		   // 간편로그인 실패 시 실행되는 로직
            );

        // 로그아웃
        http.logout(auth -> auth
//        	    .logoutUrl("/logout")  // 로그아웃 요청 경로 (기본 경로: POST /logout)
        	    .logoutSuccessUrl("/") // 로그아웃 성공 후 리다이렉트 경로 (기본 경로: GET /)
        	    .deleteCookies("JSESSIONID", "remember-me") // 로그아웃 시 해당 쿠키 삭제
        	    .invalidateHttpSession(true) // 세션 무효화
        	    .clearAuthentication(true)	 // 인증 정보 삭제
//        	    .logoutSuccessHandler((request, response, authentication) -> {  // 로그아웃 성공 시 실행되는 로직
//        	        response.sendRedirect("/customLogoutSuccess"); // 커스텀 로직을 여기에 구현하면 됩니다.
//        	    })
                .permitAll()
        	);

        return http.build();
    }
    
    // 커스텀 핸들러(API) 
    @Bean
    public AuthenticationSuccessHandler customAuthenticationSuccessHandler() {
        return new SimpleUrlAuthenticationSuccessHandler() {
            @Override
            public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
                                                Authentication authentication) throws IOException {
            	
            	String redirectUrl = (String) request.getSession().getAttribute("redirectUrl");
                
                if (redirectUrl != null) {
                    getRedirectStrategy().sendRedirect(request, response, redirectUrl); // 브라우저에 302 리디렉션 응답을 보내서 사용자가 redirectUrl로 이동하도록 함.
                    request.getSession().removeAttribute("redirectUrl"); // 다음 로그인시 이전 리디렉션 URL이 남아있지 않게함.
                } else {
                    // 기본 리디렉션 URL (초기 로그인 성공 시)
                    getRedirectStrategy().sendRedirect(request, response, "/"); // 기본 로그인 화면에서 사용자 선택으로 넘어가는 부분
                }
            }
        };
    }
}

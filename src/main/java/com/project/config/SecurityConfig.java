package com.project.config;

import java.io.IOException;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.core.Authentication;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.security.web.authentication.SimpleUrlAuthenticationSuccessHandler;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Configuration
@EnableWebSecurity
public class SecurityConfig {
	
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
//        		.requestMatchers("/css", "js", "images").permitAll()  // 정적 파일 접근 허용
//        		.requestMatchers("/upload", "WEB-INF/views").permitAll()  // webapp 하위 파일 접근 허용
                .requestMatchers("/", "/login", "/loginProc").permitAll()
                .requestMatchers("/mypage", "/profile", "/accountSettings").hasAnyRole("ADMIN", "MEMBER")
                .requestMatchers("/admin/**").hasRole("ADMIN")
                .anyRequest().permitAll()  // 이외의 요청은 인증(로그인)된 사용자만 허가
        );

        // 권한이 없는 페이지에 접속하면 자동으로 로그인 페이지로 리다이렉트
        http.formLogin(auth -> auth
                .loginPage("/login")  // 로그인 페이지 경로
                .loginProcessingUrl("/loginProc")  // 로그인 데이터를 보내는 경로
                .usernameParameter("memberId")  // 유저 아이디 네이밍을 memberId로 커스텀
                .passwordParameter("passwd")    // 유저 패스워드 네이밍을 passwd로 커스텀
                .defaultSuccessUrl("/")  // 로그인 성공 시 기본 리다이렉트 URL
                .permitAll()  // 로그인 경로는 아무나 접근 가능
//                .failureHandler((request, response, exception) -> {  // 로그인 실패 시 클라이언트로 데이터 전송
//                    response.setContentType("application/json");
//                    response.setCharacterEncoding("UTF-8");
//                    response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
//                    response.getWriter().write("{\"message\": \"로그인 실패. 아이디와 비밀번호를 확인하세요.\"}");
//                })
        );
        
        // 권한이 없는 페이지에 접근할 시 에러 페이지 출력
        http.exceptionHandling(auth -> auth
        		// 인증되지 않은 경우 실행 (로그인되지 않은 경우)
                .authenticationEntryPoint((request, response, authException) -> {
                	response.sendRedirect("/login?message=nonAuthn");
//                    response.setContentType("application/json");  // 로그인하지 않으면 클라이언트로 데이터 전송
//                    response.setCharacterEncoding("UTF-8");
//                    response.setStatus(HttpServletResponse.SC_UNAUTHORIZED); // 401 상태 코드
//                    response.getWriter().write("{\"message\": \"로그인이 필요합니다.\"}");
                })
                // 권한이 없는 경우 실행 (MEMBER가 admin 페이지로 접근할 경우)
                .accessDeniedHandler((request, response, accessDeniedException) -> {
                    response.sendRedirect("/accessDenied");  // 요청에 대한 권한이 없을시 해당 경로로 리다이렉트
                })
        );

        // csrf (사이트 위변조 방지 설정)는 기본값이 enable (enable 시 서버, 클라이언트가 csrf 토큰을 주고받는 코드가 필요함)
        http.csrf(auth -> auth
                .disable()
        );

        // 다중 로그인 설정
        http.sessionManagement(auth -> auth
                .maximumSessions(1)  // 다중 로그인 불가 (한 계정은 1명만 로그인)
                .maxSessionsPreventsLogin(true));  // 다중 로그인 시도 시 새로운 로그인 차단 (false 시 기존 세션 무효화)

        // 세션 고정 공격 보호
        http.sessionManagement(auth -> auth
                .sessionFixation().changeSessionId());  // 로그인 시 동일한 세션의 id 변경

        return http.build();
    }

//    @Bean
//    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
//        http.authorizeHttpRequests((requests) -> 
//                requests
//                    .dispatcherTypeMatchers(DispatcherType.FORWARD).permitAll()
//                    .requestMatchers("/", "/**", "/login", "/logout").permitAll() // 경로를 인증 없이 접근 가능하도록 설	 
//                    .anyRequest().authenticated() // 그 외 모든 요청은 인증 필요
//        ) 
//        .formLogin((form) -> 
//                form
//                    .loginPage("/loginForm")
//                    .permitAll()
//                    .successHandler(customAuthenticationSuccessHandler())
//        )
//        .logout((logout) -> 
//                logout
//                    .logoutSuccessUrl("/")
//                    .permitAll()
//        )
//        .oauth2Login(oauth2 -> 
//                oauth2
//                .successHandler(customAuthenticationSuccessHandler()) // 커스텀 성공 핸들러 사용 -> 간편로그인 성공후
//        )
//        .csrf(csrf -> csrf.disable()); // CSRF 비활성화
//
//        return http.build();
//    }
//    
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
                    getRedirectStrategy().sendRedirect(request, response, "/logincheck.do"); // 기본 로그인 화면에서 사용자 선택으로 넘어가는 부분
                }
            }
        };
    }
//    
//    @Bean
//    public PasswordEncoder passwordEncoder() {
//        return new BCryptPasswordEncoder();  // 비밀번호 암호화를 위한 BCrypt
//    }
}

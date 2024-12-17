package com.project.config;

import java.io.IOException;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.session.SessionRegistry;
import org.springframework.security.core.session.SessionRegistryImpl;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.security.web.authentication.SimpleUrlAuthenticationSuccessHandler;
import org.springframework.security.web.session.HttpSessionEventPublisher;
import org.springframework.web.cors.CorsConfiguration;
import org.springframework.web.cors.reactive.CorsConfigurationSource;
import org.springframework.web.cors.reactive.UrlBasedCorsConfigurationSource;

import com.project.service.CustomOAuth2UserService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;

@Configuration
@EnableWebSecurity
@RequiredArgsConstructor
public class SecurityConfig {
    private final CustomOAuth2UserService customOAuth2UserService;
    private final CustomOAuth2FailureHandler customOAuth2FailureHandler;

    // 비밀번호 암호화
    @Bean
    public BCryptPasswordEncoder bCryptPasswordEncoder() {
        return new BCryptPasswordEncoder();
    }

    // 세션 만료 이벤트를 관리하기 위한 Bean
    @Bean
    public SessionRegistry sessionRegistry() {
        return new SessionRegistryImpl();
    }

    @Bean
    public HttpSessionEventPublisher httpSessionEventPublisher() {
        return new HttpSessionEventPublisher();
    }

    @Bean
    public CorsConfigurationSource corsConfigurationSource() {
        CorsConfiguration configuration = new CorsConfiguration();
        configuration.addAllowedOriginPattern("*");
        configuration.addAllowedMethod("*");
        configuration.addAllowedHeader("*");
        configuration.setAllowCredentials(true);

        UrlBasedCorsConfigurationSource source = new UrlBasedCorsConfigurationSource();
        source.registerCorsConfiguration("/**", configuration);
        return source;
    }

    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
        // 각 경로별 요청을 사용자의 권한, 역할에 따라 제어
        http.authorizeHttpRequests(auth -> auth
                .requestMatchers("/css", "/js", "/images").permitAll() // 정적 파일 접근 허용
                .requestMatchers("/upload", "/WEB-INF/views").permitAll() // webapp 하위 파일 접근 허용
                .requestMatchers("/", "/login", "/memberForm", "/ownerForm", "/signup", "/loginProc", "/community").permitAll()
                .requestMatchers("/proxy/**").permitAll() // 프록시 경로 인증 없이 허용
                .requestMatchers("/admin/**").hasRole("ADMIN")
                .requestMatchers("/mypage", "/profile", "/account").hasAnyRole("ADMIN", "MEMBER")
                .anyRequest().permitAll() // 이외의 요청은 인증(로그인)된 사용자만 허가
        );

        // 인증되지 않은 사용자가 권한이 없는 페이지에 접속하면 자동으로 로그인 페이지로 리다이렉트
        http.formLogin(auth -> auth
                .loginPage("/login") // 로그인 페이지 경로
                .usernameParameter("memberId") // 유저 아이디 네이밍을 memberId로 커스텀
                .passwordParameter("passwd") // 유저 패스워드 네이밍을 passwd로 커스텀
                .defaultSuccessUrl("/") // 로그인 성공 시 기본 리다이렉트 URL
                .permitAll() // 로그인 경로는 아무나 접근 가능
                .failureHandler((request, response, exception) -> {
                    response.setContentType("application/json");
                    response.setCharacterEncoding("UTF-8");
                    response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
                    response.getWriter().write("{\"message\": \"로그인 실패. 아이디와 비밀번호를 확인하세요.\"}");
                })
        );

        // 권한이 없는 페이지에 접근할 시 에러 페이지 출력
        http.exceptionHandling(auth -> auth
                .authenticationEntryPoint((request, response, authException) -> {
                    response.sendRedirect("/login?message=nonAuthn");
                })
                .accessDeniedHandler((request, response, accessDeniedException) -> {
                    response.sendRedirect("/error/403");
                })
        );

        // CSRF 보호 설정
        http.csrf(csrf -> csrf
        		.ignoringRequestMatchers(request -> "GET".equalsIgnoreCase(request.getMethod()))
                .ignoringRequestMatchers("/proxy/**") // 프록시 경로에 대한 CSRF 보호 비활성화
                .ignoringRequestMatchers("/sendVerificationEmail")
        );

        // sessionManagement 설정
        http.sessionManagement(sessionManagement -> {
             // 세션 고정 공격 보호
             sessionManagement.sessionFixation(sessionFixationConfigurer ->
                     sessionFixationConfigurer.changeSessionId()
             );

            // 다중 로그인 방지
             sessionManagement.maximumSessions(1)
                     .maxSessionsPreventsLogin(true)
                     .sessionRegistry(sessionRegistry());
        });

        // 간편로그인 관련 설정
        http.oauth2Login(oauth2 -> oauth2
                .userInfoEndpoint(userInfo -> userInfo
                        .userService(customOAuth2UserService)
                )
                .successHandler(customAuthenticationSuccessHandler())
                .failureHandler(customOAuth2FailureHandler)
        );

        // 로그아웃
        http.logout(auth -> auth
                .logoutSuccessUrl("/")
                .deleteCookies("JSESSIONID", "remember-me")
                .invalidateHttpSession(true)
                .clearAuthentication(true)
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
                    getRedirectStrategy().sendRedirect(request, response, redirectUrl);
                    request.getSession().removeAttribute("redirectUrl");
                } else {
                    getRedirectStrategy().sendRedirect(request, response, "/");
                }
            }
        };
    }
}

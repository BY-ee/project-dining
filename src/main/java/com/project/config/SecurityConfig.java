package com.project.config;

import java.io.IOException;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.core.Authentication;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.oauth2.client.authentication.OAuth2AuthenticationToken;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.security.web.authentication.SimpleUrlAuthenticationSuccessHandler;

import jakarta.servlet.DispatcherType;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Configuration
public class SecurityConfig {

    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
        http.authorizeHttpRequests((requests) -> 
                requests
                    .dispatcherTypeMatchers(DispatcherType.FORWARD).permitAll()
                    .requestMatchers("/", "/**", "/login", "/logout").permitAll() // 경로를 인증 없이 접근 가능하도록 설	 
                    .anyRequest().authenticated() // 그 외 모든 요청은 인증 필요
        ) 
        .formLogin((form) -> 
                form
                    .loginPage("/loginForm")
                    .permitAll()
                    .successHandler(customAuthenticationSuccessHandler())
        )
        .logout((logout) -> 
                logout
                    .logoutSuccessUrl("/")
                    .permitAll()
        )
        .oauth2Login(oauth2 -> 
                oauth2
                .successHandler(customAuthenticationSuccessHandler()) // 커스텀 성공 핸들러 사용 -> 간편로그인 성공후
        )
        .csrf(csrf -> csrf.disable()); // CSRF 비활성화

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
                    getRedirectStrategy().sendRedirect(request, response, "/logincheck.do"); // 기본 로그인 화면에서 사용자 선택으로 넘어가는 부분
                }
            }
        };
    }
    
    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();  // 비밀번호 암호화를 위한 BCrypt
    }
}
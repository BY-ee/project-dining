package com.project.config;

import java.io.IOException;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.core.Authentication;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;

import jakarta.servlet.DispatcherType;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Configuration
public class SecurityConfig {

    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
        http
            .authorizeRequests(authorize -> authorize
                .dispatcherTypeMatchers(DispatcherType.FORWARD).permitAll()
                .requestMatchers("/", "/stateLogin.do", "/stateMypage.do" , "/loginForm.do", "/mypageForm.do", "/oauth2/**", "/css/**", "/images/**").permitAll()
                .anyRequest().authenticated()
            )
            .oauth2Login(oauth2 -> 
                oauth2
                    .loginPage("/loginForm.do")
                    .successHandler(customAuthenticationSuccessHandler()) // 내부 핸들러 호출
            )
            .csrf(csrf -> csrf.disable());

        return http.build();
    }

    // CustomAuthenticationSuccessHandler 클래스 정의
    public CustomAuthenticationSuccessHandler customAuthenticationSuccessHandler() {
        return new CustomAuthenticationSuccessHandler();
    }
    

    public class CustomAuthenticationSuccessHandler implements AuthenticationSuccessHandler {
        @Override
        public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
                                            Authentication authentication
                                            ) throws IOException {
            // 요청에서 state 파라미터 가져오기
            HttpSession session = request.getSession();
            String rootLogin = (String) session.getAttribute("rootLogin"); 
              
            System.out.println("rootLogin: " + rootLogin);
            
            // state 값에 따라 리디렉션 경로 결정
            if ("mypage".equals(rootLogin)) {
                response.sendRedirect("/moveMyPage.do"); // mypage로 리디렉션
            } else {
                response.sendRedirect("/home.do"); // 기본 리디렉션
            }
        }
    }

    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder(); // 비밀번호 암호화를 위한 BCryptPasswordEncoder 설정
    }
}

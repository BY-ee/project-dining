package com.project.config;

import java.io.IOException;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.security.web.authentication.SimpleUrlAuthenticationSuccessHandler;
import org.springframework.security.web.firewall.HttpFirewall;
import org.springframework.security.web.firewall.StrictHttpFirewall;

import jakarta.servlet.DispatcherType;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Configuration
public class SecurityConfig {

    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
        http.authorizeHttpRequests((requests) -> 
                requests
                    .dispatcherTypeMatchers(DispatcherType.FORWARD).permitAll()
                    .requestMatchers("/", "/**", "/login", "/logout").permitAll() // 경로를 인증 없이 접근 가능하도록 설정 
                    .anyRequest().authenticated() // 그 외 모든 요청은 인증 필요
        )
        .formLogin((form) -> 
                form
                    .loginPage("/login")
                    .permitAll()
                    .defaultSuccessUrl("/")
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
                // 인증된 사용자 정보 가져오기
                UserDetails userDetails = (UserDetails) authentication.getPrincipal();
                String member_id = userDetails.getUsername(); // userDetails에서 member_id 또는 username 추출

                // 세션에 member_id 추가
                HttpSession session = request.getSession();
                session.setAttribute("member_id", member_id );

                String redirectUrl = (String) session.getAttribute("redirectUrl");

                if (redirectUrl != null) {
                    getRedirectStrategy().sendRedirect(request, response, redirectUrl);
                    session.removeAttribute("redirectUrl");
                } else {
                    getRedirectStrategy().sendRedirect(request, response, "/chooseUserType");
                }
            }
        };
    }

    // PasswordEncoder 설정
    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();  // 비밀번호 암호화를 위한 BCrypt
    }
    
    @Bean
    public HttpFirewall allowUrlEncodedSlashHttpFirewall() {
        StrictHttpFirewall firewall = new StrictHttpFirewall();
        firewall.setAllowUrlEncodedSlash(true);
        firewall.setAllowUrlEncodedDoubleSlash(true); // 이 설정이 필요함
        return firewall;
    }
}

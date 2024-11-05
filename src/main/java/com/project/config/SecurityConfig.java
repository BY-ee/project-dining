package com.project.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.firewall.HttpFirewall;
import org.springframework.security.web.firewall.StrictHttpFirewall;

import jakarta.servlet.DispatcherType;

//spring security 관련 설정 파일

@Configuration
@EnableWebSecurity
public class SecurityConfig {

    @Bean // Security의 StrictHttpFirewall에서 "//" 와 같은 "잠재적으로 악의적인 문자열"이 포함된 URL을
    public HttpFirewall allowUrlEncodedDoubleSlash() {
        StrictHttpFirewall firewall = new StrictHttpFirewall();
        firewall.setAllowUrlEncodedDoubleSlash(true);
        return firewall;
    }

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
//        .oauth2Login(oauth2 -> 
//                oauth2
//                    .defaultSuccessUrl("/loginSuccess") // 네이버 로그인 성공 시 리디렉션할 URL
//        )
        .csrf(csrf -> csrf.disable()); // CSRF 비활성화

        return http.build();
    }
    
    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();  // 비밀번호 암호화를 위한 BCrypt
    }
}
package com.project.config;

import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;

public class SecurityContextUtil {

	// 생성자 방식으로 유틸리티 클래스의 객체가 생성되는 것을 방지
    private SecurityContextUtil() {
    }

    public static void reloadUserDetails(String username, UserDetailsService userDetailsService) {
        // UserDetailsService를 통해 사용자 정보 재로딩
        UserDetails updatedUserDetails = userDetailsService.loadUserByUsername(username);

        // 기존 Authentication 가져오기
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();

        // 새로운 Authentication 생성
        Authentication newAuthentication = new UsernamePasswordAuthenticationToken(
            updatedUserDetails,
            authentication.getCredentials(),
            updatedUserDetails.getAuthorities()
        );

        // Security Context 갱신
        SecurityContextHolder.getContext().setAuthentication(newAuthentication);
    }
}

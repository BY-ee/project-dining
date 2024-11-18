package com.project.dto;
import java.util.Collection;
import java.util.List;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.oauth2.core.user.OAuth2User;

public class UnifiedPrincipal {
    private final String memberId; // 사용자 이름
    private final String email;    // 사용자 이메일
    private final Collection<? extends GrantedAuthority> authorities; // 권한 목록

    // **폼 로그인**용 생성자
    public UnifiedPrincipal(CustomUserDetails userDetails) {
        this.memberId = userDetails.getUsername(); // ID
        this.email = userDetails.getMember().getEmail(); // 이메일
        this.authorities = userDetails.getAuthorities(); // 권한
    }

    // **간편 로그인(OAuth2)**용 생성자
    public UnifiedPrincipal(OAuth2User oauth2User) {
        this.memberId = oauth2User.getAttribute("id"); // 제공자의 이름 속성
        this.email = oauth2User.getAttribute("email");   // 제공자의 이메일 속성
        this.authorities = List.of(() -> "ROLE_USER");   // 기본 권한 설정
    }

    // Getter 메서드
    public String getMemberId() {
        return memberId;
    }

    public String getEmail() {
        return email;
    }

    public Collection<? extends GrantedAuthority> getAuthorities() {
        return authorities;
    }
}
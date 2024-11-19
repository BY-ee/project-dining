package com.project.dto;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.oauth2.core.user.OAuth2User;

import com.project.domain.Member;

import java.util.Map;

public class CustomUserDetails implements UserDetails, OAuth2User {
    private final Member member;
    private Map<String, Object> attributes; // OAuth2User의 속성

    // 일반 로그인 생성자
    public CustomUserDetails(Member member) {
        this.member = member;
    }
    
    // OAuth2User 전용 생성자
    public CustomUserDetails(Member member, Map<String, Object> attributes) {
        this.member = member;
        this.attributes = attributes;
    }

	@Override
    public String getUsername() {
        return member.getMemberId();
    }

    @Override
    public String getPassword() {
        return member.getPasswd();
    }

    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        List<GrantedAuthority> authorities = new ArrayList<>();
        authorities.add(new SimpleGrantedAuthority(member.getRole()));
        return authorities;
    }
    
    // member 객체를 세션에서 가져오기 위한 커스텀 메서드
    public Member getMember() {
    	return member;
    }

    // OAuth2User 메서드
    @Override
    public Map<String, Object> getAttributes() {
        return attributes;
    }

    @Override
    public String getName() {
        return member.getMemberId(); // OAuth2User의 고유 식별자
    }

	@Override
    public boolean isAccountNonExpired() {
        return true;
    }

    @Override
    public boolean isAccountNonLocked() {
        return true;
    }

    @Override
    public boolean isCredentialsNonExpired() {
        return true;
    }

    @Override
    public boolean isEnabled() {
        return true;
    }

}


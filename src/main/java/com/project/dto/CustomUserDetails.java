package com.project.dto;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import com.project.domain.Member;

public class CustomUserDetails implements UserDetails {
    private final Member member;

    // 일반 로그인 생성자
    public CustomUserDetails(Member member) {
        this.member = member;
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


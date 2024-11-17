package com.project.service;

import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.project.domain.Member;
import com.project.dto.CustomUserDetails;
import com.project.mapper.MemberMapper;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class CustomUserDetailsService implements UserDetailsService {
    private final MemberMapper memberMapper;

    @Override
    public UserDetails loadUserByUsername(String memberId) {
        Member member = memberMapper.selectMemberByMemberId(memberId);

        if (member == null) {
            // 로그인할 때 아이디가 존재하지 않으면 예외를 던지고 Spring Security가 해당 예외를 처리
            throw new UsernameNotFoundException("User not found with username: " + memberId);
        }

        return new CustomUserDetails(member);
    }
}

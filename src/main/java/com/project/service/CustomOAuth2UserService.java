package com.project.service;

import java.util.Map;
import java.util.Map.Entry;
import java.util.UUID;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.oauth2.client.userinfo.DefaultOAuth2UserService;
import org.springframework.security.oauth2.client.userinfo.OAuth2UserRequest;
import org.springframework.security.oauth2.core.OAuth2AuthenticationException;
import org.springframework.security.oauth2.core.user.OAuth2User;
import org.springframework.stereotype.Service;

import com.project.domain.Member;
import com.project.dto.CustomUserDetails;
import com.project.mapper.MemberMapper;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class CustomOAuth2UserService extends DefaultOAuth2UserService {

    private final MemberMapper memberMapper;

    @Override
    public OAuth2User loadUser(OAuth2UserRequest userRequest) throws OAuth2AuthenticationException {
        OAuth2User oauth2User = super.loadUser(userRequest);

        // 제공자 식별
        String registrationId = userRequest.getClientRegistration().getRegistrationId();
        Map<String, Object> attributes = oauth2User.getAttributes();

        // 이메일 추출
        String email = extractEmailByProvider(registrationId, attributes);
        if (email == null) {
            throw new OAuth2AuthenticationException("Email not found for provider: " + registrationId);
        }

        Member member = findOrCreateMember(registrationId, email, attributes);

        return new CustomUserDetails(member, attributes);
    }

    /**
     * 이메일을 통해 회원을 찾거나 신규 회원을 생성합니다.
     */
    private Member findOrCreateMember(String registrationId, String email, Map<String, Object> attributes) {
        // 기존 회원 검색
        Member member = memberMapper.selectMemberByRegisteration(email, registrationId);
        if (member != null) {
            return member;
        }

        // 세션에서 로그인 사용자 정보 확인
        try {
            Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
            if (authentication != null && authentication.isAuthenticated()) {
                CustomUserDetails userDetails = (CustomUserDetails) authentication.getPrincipal();
                return memberMapper.selectMember(userDetails.getId());
            }
        } catch (Exception e) {
            // 인증되지 않은 경우 신규 회원 등록
            System.out.println("User not logged in. Registering new member.");
        }

        // 신규 회원 생성
        return registerNewMember(registrationId, email, attributes);
    }

    /**
     * 신규 회원 등록 로직
     */
    private Member registerNewMember(String registrationId, String email, Map<String, Object> attributes) {
        Member member = new Member();
        member.setEmail(email);
        member.setMemberId(email); // 이메일을 기본 ID로 사용
        member.setRole("ROLE_MEMBER");
        // 고유 닉네임 생성
        String randomNickname = "User_" + UUID.randomUUID().toString().substring(0, 8);
        member.setNickname(randomNickname);

        // 추가 정보 저장 및 DB 등록
        switch (registrationId) {
            case "kakao":
                memberMapper.insertMemberForKakao(member);
                break;
            case "naver":
                Map<String, Object> response = (Map<String, Object>) attributes.get("response");
                System.out.println("Naver response attributes:");
                for (Entry<String, Object> res : attributes.entrySet()) {
                    System.out.println("key: " + res.getKey() + " value: " + res.getValue());
                }
                memberMapper.insertMemberForNaver(member);
                break;
            case "google":
                memberMapper.insertMemberForGoogle(member);
                break;
            default:
                throw new OAuth2AuthenticationException("Unsupported provider: " + registrationId);
        }

        return memberMapper.selectMemberByMemberId(email);
    }

    /**
     * 제공자별 이메일 추출
     */
    private String extractEmailByProvider(String registrationId, Map<String, Object> attributes) {
        switch (registrationId) {
            case "google":
                return (String) attributes.get("email");
            case "kakao":
                return extractKakaoEmail(attributes);
            case "naver":
                return extractNaverEmail(attributes);
            default:
                throw new OAuth2AuthenticationException("Unsupported provider: " + registrationId);
        }
    }

    private String extractKakaoEmail(Map<String, Object> attributes) {
        Map<String, Object> kakaoAccount = (Map<String, Object>) attributes.get("kakao_account");
        return kakaoAccount != null ? (String) kakaoAccount.get("email") : null;
    }

    private String extractNaverEmail(Map<String, Object> attributes) {
        Map<String, Object> response = (Map<String, Object>) attributes.get("response");
        return response != null ? (String) response.get("email") : null;
    }
}
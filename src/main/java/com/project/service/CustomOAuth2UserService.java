package com.project.service;

import java.util.Map;
import java.util.Map.Entry;

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
        System.out.println(userRequest.getClientRegistration());
        Map<String, Object> attributes = oauth2User.getAttributes();

        // 이메일 추출
        String email = extractEmailByProvider(registrationId, attributes);
        if (email == null) {
            throw new OAuth2AuthenticationException("Email not found for provider: " + registrationId);
        }

        System.out.println("Provider: " + registrationId + ", Email: " + email);

        // DB에서 사용자 검색
        Member member = memberMapper.selectMemberByMemberId(email);
        
        if (member == null) {
            // 새 사용자 등록
            member = registerNewMember(registrationId, email, attributes);
        }

        return new CustomUserDetails(member, attributes);
    }

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

    private Member registerNewMember(String registrationId, String email, Map<String, Object> attributes) {
        Member member = new Member();
        member.setEmail(email);
        member.setMemberId(email); // 이메일을 기본 ID로 사용
        member.setRole("ROLE_MEMBER");

        // 추가 정보 저장
        if ("kakao".equals(registrationId)) {
            member.setNickname((String) ((Map<String, Object>) attributes.get("properties")).get("nickname") + ".k");
            memberMapper.insertMemberForKakao(member);
        } else if ("naver".equals(registrationId)) {
            Map<String, Object> response = (Map<String, Object>) attributes.get("response");
            member.setNickname(((String) response.get("id")).substring(3, 9) + ".n");
            
            System.out.println("response ---------------- rrrrrrrrrr");
            for (Entry<String, Object> res : attributes.entrySet()) {
            	System.out.println("key: " + res.getKey() + "////// value: " + res.getValue() + "-----------");
            }
            memberMapper.insertMemberForNaver(member);
        } else if ("google".equals(registrationId)) {
            member.setNickname((String) attributes.get("name") + ".g");
            memberMapper.insertMemberForGoogle(member);
        }
        
        return member;
    }
}

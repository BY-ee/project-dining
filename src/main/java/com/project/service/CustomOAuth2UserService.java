package com.project.service;

import java.util.Map;
import java.util.Map.Entry;
import java.util.UUID;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.oauth2.client.userinfo.DefaultOAuth2UserService;
import org.springframework.security.oauth2.client.userinfo.OAuth2UserRequest;
import org.springframework.security.oauth2.core.OAuth2AuthenticationException;
import org.springframework.security.oauth2.core.OAuth2Error;
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

        // DB에서 사용자 검색
        //Member member = memberMapper.selectMemberByMemberId(email,registrationId);
        Member member = memberMapper.selectMemberByRegisteration(email,registrationId);

        // 세션으로 로그인, 비로그인 구분
        try {
        	 Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        	 CustomUserDetails userDetails = (CustomUserDetails) authentication.getPrincipal();
        }catch(Exception e) {
        	// 로그인 안했을때 새 사용자 등록 
            if (member == null) {
    		member = registerNewMember(registrationId, email, attributes);
            }
            return new CustomUserDetails(member, attributes);
        }
        
        // 로그인 했는데 기본아이디만 등록되어있고 연동아이디가 없을 시
        if (member == null) {
        	// 세션에서 기본아이디가 저장된 값을 활용해 db에서 값 가져오기
        	try {
        		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        		CustomUserDetails userDetails = (CustomUserDetails) authentication.getPrincipal();  
                Member existMember = memberMapper.selectMember(userDetails.getId());
                return new CustomUserDetails(existMember,attributes);
        	}catch(Exception e){
        		System.out.println("오류");
        	}
    	}else {
    		throw new OAuth2AuthenticationException(
    		        new OAuth2Error("invalid_request"),
    		        "해당 이메일은 이미 다른 계정에 연동되어 있습니다."
    		    );
    	}
     
        return new CustomUserDetails(member, attributes);
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
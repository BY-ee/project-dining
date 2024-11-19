package com.project.service;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.project.config.SecurityContextUtil;
import com.project.dto.Login;
import com.project.mapper.LoginMapper;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class LoginService {
	
	private final LoginMapper loginMapper;
	private final BCryptPasswordEncoder bCryptPasswordEncoder; // 비밀번호 암호화를 위한 PasswordEncoder 주입
	private final SecurityContextUtil securityContextUtil;

	// 아이디 중복조회
	public int isUserIdCheck(String memberId) {
		 return loginMapper.isUserIdCheck(memberId);
	}
	
	// 닉네임 중복조회
	public int isUserNicknameCheck(String nickname) {
		return loginMapper.isUserNicknameCheck(nickname);
	}
	
	// 회원가입
	public int joinMember(Login login) {
		login.setPasswd(bCryptPasswordEncoder.encode(login.getPasswd()));
		login.setRole("ROLE_MEMBER");
		return loginMapper.joinMember(login);
	}
	
	// 사용자 조회
	public Login getUser(String memberId) {
		return loginMapper.getUser(memberId);
	}
	
	// 네이버, 카카오, 구글 SNS 유무 계정 조회
	public Login getNaverUser(String tempId) {
		return loginMapper.getNaverUser(tempId);
	} 
	public Login getKakaoUser(String tempId) {
		return loginMapper.getKakaoUser(tempId);
	}
	public Login getGoogleUser(String tempId) {
		return loginMapper.getGoogleUser(tempId);
	}

	// 네이버, 카카오, 구글 SNS 최초 회원가입
	public void insertNaverJoin(String tempId, String tempEmail, String randomNickname) {
	    Login login = new Login();
	    login.setMemberId(tempId);      // memberId에 tempId 저장
	    login.setEmail(tempEmail);
	    login.setNickname(randomNickname);
	    login.setStatus("active");

	   loginMapper.insertNaverJoin(login);
	}
	
	public void insertKakaoJoin(String tempId, String tempEmail, String randomNickname) {
		 Login login = new Login();
		 login.setMemberId(tempId);      
		 login.setEmail(tempEmail);
		 login.setNickname(randomNickname);
		 login.setStatus("active");

		 loginMapper.insertKakaoJoin(login);
	}
	
	public void insertGoogleJoin(String tempId, String tempEmail, String randomNickname) {
		 Login login = new Login();
		 login.setMemberId(tempId);      
		 login.setEmail(tempEmail);
		 login.setNickname(randomNickname);
		 login.setStatus("active");

		 loginMapper.insertGoogleJoin(login);
	}

	// 비밀번호 변경
	public void updatePassword(Login login) {
		login.setPasswd(bCryptPasswordEncoder.encode(login.getPasswd()));
		loginMapper.updatePassword(login);
		securityContextUtil.reloadUserDetails(login.getMemberId());  // spring security context의 상태 수정
	}

	public Login getFindId(String email) {
		return loginMapper.getFindId(email);
	}
	
	// 도메인에 따른 유저 조회
    public Login getUserByProvider(String provider, String tempId) {
        switch (provider) {
            case "naver":
                return loginMapper.getNaverUser(tempId);
            case "kakao":
                return loginMapper.getKakaoUser(tempId);
            case "google":
                return loginMapper.getGoogleUser(tempId);
            default:
                throw new IllegalArgumentException("Unsupported provider: " + provider);
        }
    }

    // 
    public void createUser(String provider, String tempId, String tempEmail, String randomNickname) {
        Login login = new Login();
        login.setMemberId(tempId);
        login.setEmail(tempEmail);
        login.setNickname(randomNickname);
        login.setStatus("active");

        switch (provider) {
            case "naver":
                loginMapper.insertNaverJoin(login);
                break;
            case "kakao":
                loginMapper.insertKakaoJoin(login);
                break;
            case "google":
                loginMapper.insertGoogleJoin(login);
                break;
        }
    }
}





	 

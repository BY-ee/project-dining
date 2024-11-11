package com.project.service;

import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.project.domain.LoginDomain;
import com.project.mapper.LoginMapper;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class LoginService {

	private final LoginMapper loginMapper;
	private final PasswordEncoder passwordEncoder; // 비밀번호 암호화를 위한 PasswordEncoder 주입
	
	// memberId 중복조회
	public int isUserIdCheck(String member_id) {
		 return loginMapper.isUserIdCheck(member_id);
	}

	public int isUserNicknameCheck(String nickname) {
		return loginMapper.isUserNicknameCheck(nickname);
	}

	public int joinMember(LoginDomain login) {
		login.setPasswd(passwordEncoder.encode(login.getPasswd()));
		return loginMapper.joinMember(login);
	}

	 
	 	
//	 
//	    // 사용자 조회
//	    public LoginDomain getUser(String memberId) {
//	        return loginMapper.getUser(memberId);
//	    }
//	    



	    
//	    @Transactional
//	    public void insertUser(LoginDomain login) {
//	        try {
//	        	// passwd는 암호화된 값이 저장
//	        	login.setPasswd(passwordEncoder.encode(login.getPasswd()));
//	            loginMapper.insertUser(login);
//	        } catch (Exception e) {
//	            System.err.println("회원가입 중 오류 발생: " + e.getMessage());
//	            e.printStackTrace();
//	        }
//	    }


	 
}

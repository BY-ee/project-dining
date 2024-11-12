package com.project.service;

import java.util.Map;

import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.project.domain.Login;
import com.project.mapper.LoginMapper;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class LoginService {

	private final LoginMapper loginMapper;
	private final PasswordEncoder passwordEncoder; // 비밀번호 암호화를 위한 PasswordEncoder 주입

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
		login.setPasswd(passwordEncoder.encode(login.getPasswd()));
		return loginMapper.joinMember(login);
	}
	
	// 사용자 조회
	public Login getUser(String memberId) {
		return loginMapper.getUser(memberId);
	}

	public Login getNaverUser(String tempId) {
		return loginMapper.getNaverUser(tempId);
	} 

	public Login insertNaverJoin(String tempId, String tempEmail, String randomNickname) {
	    Login login = new Login();
	    login.setMemberId(tempId);      // memberId에 tempId 저장
	    login.setEmail(tempEmail);
	    login.setNickname(randomNickname);
	    login.setStatus("active");

	    // 데이터베이스에 새 사용자 삽입
	    loginMapper.insertNaverJoin(login);

	    // 삽입 후, 저장된 사용자의 정보를 다시 조회하여 반환
	    return loginMapper.getUser(tempId); // getUser 메서드로 저장된 사용자 반환
	} 




	}





	 


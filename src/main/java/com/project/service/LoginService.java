package com.project.service;

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
	public int isUserIdCheck(String member_id) {
		 return loginMapper.isUserIdCheck(member_id);
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

  




	 
}

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




	}





	 
package com.project.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.project.domain.LoginDomain;

@Mapper
public interface LoginMapper {
    LoginDomain getUser(String member_id);  // 사용자 조회
    void insertUser(LoginDomain user);     // 사용자 등록

	
	// 아이디 중복조회
	int isUserIdCheck(String member_id);
	
	// 닉네임 증복조회
	int isUserNicknameCheck(String nickname);
	
	// 회원가입
	int joinMember(LoginDomain login);
	

	
//	LoginDomain getUser(String memberId);






}

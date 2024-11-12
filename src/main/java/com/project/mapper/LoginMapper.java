package com.project.mapper;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.project.domain.Login;

@Mapper
public interface LoginMapper {
	
	// 아이디 중복조회
	int isUserIdCheck(String memberId);
	
	// 닉네임 증복조회
	int isUserNicknameCheck(String nickname);
	
	// 회원가입
	int joinMember(Login login);
	
	// 회원조회
	Login getUser(String memberId);

	Login getNaverUser(String tempId);

	Login insertNaverJoin(Login login);

	




}

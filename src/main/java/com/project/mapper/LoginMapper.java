package com.project.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.project.domain.LoginDomain;

@Mapper
public interface LoginMapper {
	
	// 아이디 중복조회
	int isUserIdCheck(String member_id);
	
	// 닉네임 증복조회
	int isUserNicknameCheck(String nickname);
	
//
//	LoginDomain getUser(String memberId);






}

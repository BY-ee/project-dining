package com.project.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.project.domain.LoginDomain;

@Mapper
public interface LoginMapper {
	
	// 아이디 중복 조회
	boolean isUserIdCheck(String memberId);


	
	// 회원가입
	void insertUser(LoginDomain login);
	
	LoginDomain getUser(String memberId);


}

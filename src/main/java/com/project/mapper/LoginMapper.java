package com.project.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.project.domain.LoginDomain;

@Mapper
public interface LoginMapper {
    LoginDomain getUser(String member_id);  // 사용자 조회
    void insertUser(LoginDomain user);     // 사용자 등록
}
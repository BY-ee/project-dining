package com.project.disable;

import com.project.disable.UserDomain;
import org.apache.ibatis.annotations.Mapper;


@Mapper // 매퍼 인터페이스로 인식되도록 설정
@Deprecated
public interface UserMapper{
	
    void insertUser(UserDomain user);
    UserDomain findUserByEmail(String email); // 비밀번호 없이 email로만 조회
}
package com.project.mapper;

import com.project.model.User;
import org.apache.ibatis.annotations.Mapper;


@Mapper // 매퍼 인터페이스로 인식되도록 설정
public interface UserMapper {
	
    void insertUser(User user);
    User findUserByEmail(String email); // 비밀번호 없이 email로만 조회
}
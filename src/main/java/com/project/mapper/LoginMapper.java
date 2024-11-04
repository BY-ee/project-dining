package com.project.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.project.domain.LoginDomain;

@Mapper
public interface LoginMapper {

	LoginDomain getUser(String userid);

}

package com.project.service;

import org.springframework.stereotype.Service;

import com.project.mapper.LoginMapper;
import com.project.domain.LoginDomain;

import lombok.RequiredArgsConstructor;
//import lombok.Value;

@Service
@RequiredArgsConstructor
public class LoginService {

	private final LoginMapper loginMapper;

	    
	public LoginDomain getUser(String userid) {
		return loginMapper.getUser(userid);
	}
	
    public void registerUser(LoginDomain user) {
        loginMapper.insertUser(user);
    }
}
	
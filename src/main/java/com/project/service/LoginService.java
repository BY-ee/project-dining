package com.project.service;

import java.util.Random;

import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;

import com.project.domain.LoginDomain;
import com.project.mapper.LoginMapper;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class LoginService {

	private final LoginMapper loginMapper;
    private final JavaMailSender mailSender;
	    
	public LoginDomain getUser(String userid) {
		return loginMapper.getUser(userid);
	}


	public String generateVerificationCode() {
		Random random = new Random();
        int code = 100000 + random.nextInt(900000); // 6자리 숫자 생성
        return String.valueOf(code);
	}
	
	@Async
	public void sendVerificationEmail(String toEmail, String code) {
	        SimpleMailMessage message = new SimpleMailMessage();
	        message.setTo(toEmail);
	        message.setSubject("냐미냐미 이메일 인증 코드");
	        message.setText("인증 코드: " + code + "\n\n해당 인증번호는 10분간 유효합니다.");
	        mailSender.send(message);
	    }

	 
}

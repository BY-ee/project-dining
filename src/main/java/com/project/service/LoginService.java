package com.project.service;

import java.util.Random;

import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.scheduling.annotation.Async;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.project.domain.LoginDomain;
import com.project.mapper.LoginMapper;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class LoginService {

    private final LoginMapper loginMapper;
    private final JavaMailSender mailSender;
    private final PasswordEncoder passwordEncoder; // 비밀번호 암호화를 위한 PasswordEncoder 주입

    // 사용자 조회
    public LoginDomain getUser(String memberId) {
        return loginMapper.getUser(memberId);
    }
    
    public boolean isMemberIdExists(String memberId) {
        return loginMapper.getUser(memberId) != null;
    }

    // 회원가입 로직
    @Transactional
    public void insertUser(LoginDomain user) {
        try {
            user.setPasswd(passwordEncoder.encode(user.getPasswd()));
            loginMapper.insertUser(user);
        } catch (Exception e) {
            System.err.println("회원가입 중 오류 발생: " + e.getMessage());
            e.printStackTrace();
        }
    }

    // 이메일 인증 코드 생성
    public String generateVerificationCode() {
        Random random = new Random();
        int code = 100000 + random.nextInt(900000); // 6자리 숫자 생성
        return String.valueOf(code);
    }
    
    // 이메일 인증 코드 전송
    @Async
    public void sendVerificationEmail(String toEmail, String code) {
        SimpleMailMessage message = new SimpleMailMessage();
        message.setTo(toEmail);
        message.setSubject("냐미냐미 이메일 인증 코드");
        message.setText("인증 코드: " + code + "\n\n해당 인증번호는 10분간 유효합니다.");
        mailSender.send(message);
    }
}
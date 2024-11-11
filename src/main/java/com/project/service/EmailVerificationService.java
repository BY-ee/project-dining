package com.project.service;

import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;

import jakarta.mail.MessagingException;
import jakarta.mail.internet.MimeMessage;

@Service
public class EmailVerificationService {

    @Autowired
    private JavaMailSender mailSender;

    // 인증번호 생성 및 이메일 전송
    @Async
    public String sendVerificationCode(String userEmail) {
        String verificationCode = generateVerificationCode();	// 이 구문 추가로 이 메서드에서 한번에 인증번호 생성 + 전송 가능
        
     // HTML 이메일 템플릿
        String htmlContent = "<div style='font-family: Arial, sans-serif; max-width: 600px; margin: 0 auto; border: 1px solid #ddd; padding: 20px;'>" +
                             "  <h2 style='color: #333;'>냐미냐미</h2>" +
                             "  <p style='font-size: 16px; color: #555;'>안녕하세요! 이메일 인증 요청을 받았습니다. 아래의 인증 코드를 입력하여 인증을 완료해 주세요.</p>" +
                             "  <div style='text-align: center; margin: 20px 0;'>" +
                             "    <span style='font-size: 24px; font-weight: bold; color: #007bff;'>" + verificationCode + "</span>" +
                             "  </div>" +
                             "  <p style='font-size: 14px; color: #999;'>이 인증 코드는 10분간 유효합니다.</p>" +
                             "  <hr style='border: none; border-top: 1px solid #eee; margin: 20px 0;'>" +
                             "  <p style='font-size: 12px; color: #999;'>본 메일을 요청하지 않으셨다면, 이 이메일을 무시하셔도 됩니다.</p>" +
                             "</div>";

        // HTML 형식 이메일 전송
        try {
            MimeMessage message = mailSender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");
            helper.setTo(userEmail);
            helper.setSubject("냐미냐미 이메일 인증 코드");
            helper.setText(htmlContent, true); // HTML 형식 활성화
            mailSender.send(message);
        } catch (MessagingException e) {
            e.printStackTrace(); // 예외 처리
        }
		/*
		 * // 이메일 생성 및 전송 SimpleMailMessage email = new SimpleMailMessage();
		 * email.setTo(userEmail); email.setSubject("냐미냐미 이메일 인증 코드");
		 * email.setText(message); mailSender.send(email);
		 */

        return verificationCode; // 생성된 인증번호 반환
    }

    // 인증번호 생성 (6자리)
    private String generateVerificationCode() {
    	Random random = new Random();
    	int code = 100000 + random.nextInt(900000); // 6자리 숫자 생성
        return String.valueOf(code);
    }
}
package com.project.service;

import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import jakarta.mail.MessagingException;
import jakarta.mail.internet.MimeMessage;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class SendEmailService implements EmailService {

    private final JavaMailSender mailSender;

    // 이메일 인증 이메일
    @Override
    public void sendEmail(String userEmail, String subject, String content) {
        try {
            MimeMessage message = mailSender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");
            helper.setTo(userEmail);
            helper.setSubject(subject);
            helper.setText(content, true); // HTML 형식 활성화
            mailSender.send(message);
        } catch (MessagingException e) {
            // 예외 처리 로직
            e.printStackTrace();
        }
    }






}

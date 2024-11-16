package com.project.service;

import java.util.Random;

import org.springframework.stereotype.Service;

@Service
public class SendEmailContentService implements EmailContentService {
	
	@Override
    public String generateVerificationCode() {
        Random random = new Random();
        int code = 100000 + random.nextInt(900000); // 6자리 숫자 생성
        return String.valueOf(code);
    }

    @Override
    public String generateEmailConfirmContent(String verificationCode) {
        return "<div style='font-family: Arial, sans-serif; max-width: 600px; margin: 0 auto; border: 1px solid #ddd; padding: 20px;'>" +
               "  <h2 style='color: #333;'>이메일 인증</h2>" +
               "  <p style='font-size: 16px; color: #555;'>안녕하세요! 이메일 인증 요청을 받았습니다. 아래의 인증 코드를 입력하여 인증을 완료해 주세요.</p>" +
               "  <div style='text-align: center; margin: 20px 0;'>" +
               "    <span style='font-size: 24px; font-weight: bold; color: #007bff;'>" + verificationCode + "</span>" +
               "  </div>" +
               "  <p style='font-size: 14px; color: #999;'>이 인증 코드는 10분간 유효합니다.</p>" +
               "  <hr style='border: none; border-top: 1px solid #eee; margin: 20px 0;'>" +
               "  <p style='font-size: 12px; color: #999;'>본 메일을 요청하지 않으셨다면, 이 이메일을 무시하셔도 됩니다.</p>" +
               "</div>";
    }

    @Override
    public String generatePasswordResetContent(String resetLink) {
        return "<div style='font-family: Arial, sans-serif; max-width: 600px; margin: 0 auto; border: 1px solid #ddd; padding: 20px;'>" +
               "  <h2 style='color: #333;'>비밀번호 재설정</h2>" +
               "  <p style='font-size: 16px; color: #555;'>아래를 클릭하여 비밀번호를 재설정해 주세요.</p>" +
               "  <div style='text-align: center; margin: 20px 0;'>" +
               "    <a href='" + resetLink + "' style='font-size: 14px; color: #007bff;'>비밀번호 재설정하기</a>" +
               "  </div>" +
               "  <p style='font-size: 14px; color: #999;'>이 링크는 24시간 동안 유효합니다.</p>" +
               "  <hr style='border: none; border-top: 1px solid #eee; margin: 20px 0;'>" +
               "  <p style='font-size: 12px; color: #999;'>본 메일을 요청하지 않으셨다면, 이 이메일을 무시하셔도 됩니다.</p>" +
               "</div>";
    }
}
package com.project.controller;

import java.time.LocalDateTime;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.service.EmailContentService;
import com.project.service.EmailService;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class EmailController {


    private final EmailService emailService;
    private final EmailContentService emailContentService;
	
//    @PostMapping("/verifyCode")
//    @ResponseBody
//    public String verifyCode(@RequestParam("userEmail") String userEmail, @RequestParam("code") String code, HttpSession session) {
//    	String savedCode = (String) session.getAttribute("verificationCode");
//    	String savedEmail = (String) session.getAttribute("userEmail");
//    	LocalDateTime expiryTime = (LocalDateTime) session.getAttribute("expiryTime");
//
//    	if (savedCode == null || savedEmail == null || expiryTime == null) {
//
//    	    return "인증 코드가 만료되었거나 존재하지 않습니다.";
//    	}
//
//    	// 만료 시간 확인
//    	if (LocalDateTime.now().isAfter(expiryTime)) {
//    	    session.removeAttribute("verificationCode");
//    	    session.removeAttribute("userEmail");
//    	    session.removeAttribute("expiryTime");
//    	    return "인증 코드가 만료되었습니다.";
//    	}
//
//    	// 수정된 부분: verificationCode를 code로 변경
//    	if (savedEmail.equals(userEmail) && savedCode.equals(code)) {
//    	    session.removeAttribute("verificationCode");
//    	    session.removeAttribute("userEmail");
//    	    return "인증에 성공했습니다.";
//    	} else {
//    	    return "인증 코드가 올바르지 않습니다.";
//    	}}
	
    @PostMapping("/send-verification-email")
    @ResponseBody
    public String sendVerificationEmail(@RequestParam("userEmail") String userEmail, HttpSession session) {
        String verificationCode = emailContentService.generateVerificationCode();
        String emailContent = emailContentService.generateEmailConfirmContent(verificationCode);
        emailService.sendEmail(userEmail, "이메일 인증 코드", emailContent);
        
        session.setAttribute("verificationCode", verificationCode);
        session.setAttribute("userEmail", userEmail);
        session.setAttribute("expiryTime", LocalDateTime.now().plusMinutes(10)); // 예: 10분 후 만료
        
        
        return "인증 이메일이 발송되었습니다.";
    }

    @PostMapping("/send-password-reset-email")
    @ResponseBody
    public String sendPasswordResetEmail(@RequestParam("userEmail") String userEmail) {
        String resetLink = "https://yourdomain.com/reset-password?token=exampleToken";
        String emailContent = emailContentService.generatePasswordResetContent(resetLink);
        emailService.sendEmail(userEmail, "비밀번호 재설정", emailContent);
        return "비밀번호 재설정 이메일이 발송되었습니다.";
    }
    
	
    
	
    
    
}

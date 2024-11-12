package com.project.controller;

import java.time.LocalDateTime;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.project.service.EmailVerificationService;

import jakarta.servlet.http.HttpSession;

@RestController
public class EmailVerificationController {
	@Autowired
	private EmailVerificationService emailVerificationService;
	
	// 회원가입 - 이메일 인증
		@PostMapping("sendVerificationEmail")
		public String sendVerificationEmail(@RequestParam("email") String email, HttpSession session) {
		    // 인증 코드 생성 및 전송
	        String verificationCode = emailVerificationService.sendVerificationCode(email);

	        // 만료 시간 설정 (현재 시간 + 10분)
	        LocalDateTime expiryTime = LocalDateTime.now().plusMinutes(10);
	        
	        // 세션에 인증 코드 저장
	        session.setAttribute("verificationCode", verificationCode);
	        session.setAttribute("email", email);
	        session.setAttribute("expiryTime", expiryTime);

	        return "인증 코드가 이메일로 전송되었습니다 (10분간 유효)";
		}
		
		@PostMapping("verifyCode")
	    public String verifyCode(@RequestParam("email") String email, @RequestParam("code") String code, HttpSession session) {
	        String savedCode = (String) session.getAttribute("verificationCode");
	        String savedEmail = (String) session.getAttribute("email");
	        LocalDateTime expiryTime = (LocalDateTime) session.getAttribute("expiryTime");

	        if (savedCode == null || savedEmail == null || expiryTime == null) {
	        	System.out.println(savedCode);
	        	System.out.println(savedEmail);
	            return "인증 코드가 만료되었거나 존재하지 않습니다.";
	        }
	        
	        // 만료 시간 확인
	        if (LocalDateTime.now().isAfter(expiryTime)) {
	            // 만료된 경우 세션에서 데이터 제거
	            session.removeAttribute("verificationCode");
	            session.removeAttribute("email");
	            session.removeAttribute("expiryTime");
	            return "인증 코드가 만료되었습니다.";
	        }

	        if (savedEmail.equals(email) && savedCode.equals(code)) {
	            session.removeAttribute("verificationCode"); // 인증 후 세션에서 코드 제거
	            session.removeAttribute("email");
	            return "인증에 성공했습니다.";
	        } else {
	            return "인증 코드가 올바르지 않습니다.";
	        }
	    }
}

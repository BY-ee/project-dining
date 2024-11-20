package com.project.controller;

import java.time.LocalDateTime;
import java.util.UUID;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.config.SecurityContextUtil;
import com.project.domain.Member;
import com.project.dto.CustomUserDetails;
import com.project.dto.Login;
import com.project.service.LoginService;
import com.project.service.MypageService;
import com.project.service.SendEmailContentService;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class EmailController {
	
    private final SendEmailContentService emailContentService;
	private final LoginService loginService;
	private final MypageService mypageService;
	private final SecurityContextUtil securityContextUtil;

	private static final Logger logger = LoggerFactory.getLogger(EmailController.class);
	
    
    // 이메일 인증코드 인증
    @PostMapping("/verifyCode")
    @ResponseBody
    public String verifyCode(@AuthenticationPrincipal CustomUserDetails userDetails ,@RequestParam("userEmail") String userEmail, @RequestParam("code") String code, HttpSession session) {
    	String savedCode = (String) session.getAttribute("verificationCode");
    	String savedEmail = (String) session.getAttribute("userEmail");
    	LocalDateTime expiryTime = (LocalDateTime) session.getAttribute("expiryTime");

    	if (savedCode == null || savedEmail == null || expiryTime == null) {

    	    return "인증 코드가 만료되었거나 존재하지 않습니다.";
    	}

    	// 만료 시간 확인
    	if (LocalDateTime.now().isAfter(expiryTime)) {
    	    session.removeAttribute("verificationCode");
    	    session.removeAttribute("userEmail");
    	    session.removeAttribute("expiryTime");
    	    return "인증 코드가 만료되었습니다.";
    	}

    	if (savedEmail.equals(userEmail) && savedCode.equals(code)) {
    		
    		try {
    			Member member = userDetails.getMember();
    			System.out.println(member);    			
    		}catch(Exception e) {
    			session.removeAttribute("verificationCode");
        	    session.removeAttribute("userEmail");
        	    return "인증에 성공했습니다.";
    		}
    		if(userDetails.getMember() != null) {    			
    			Member member = userDetails.getMember();
    			member.setEmail(userEmail);
    			mypageService.updateEmail(member);
    			securityContextUtil.reloadUserDetails(member.getMemberId());
    		}
    	    session.removeAttribute("verificationCode");
    	    session.removeAttribute("userEmail");
    	    return "인증에 성공했습니다.";
    	} else {
    	    return "인증 코드가 올바르지 않습니다.";
    		}
    	}
	
    // 이메일 인증코드 전송
    @PostMapping("/sendVerificationEmail")
    @ResponseBody
    public ResponseEntity<String> sendVerificationEmail(@RequestParam("userEmail") String userEmail,HttpSession session) {
        String verificationCode = emailContentService.generateVerificationCode();
        String emailContent = emailContentService.generateEmailConfirmContent(verificationCode);
        emailContentService.sendEmail(userEmail, "이메일 인증 코드", emailContent);
		session.setAttribute("verificationCode", verificationCode);
		session.setAttribute("userEmail", userEmail);
		session.setAttribute("expiryTime", LocalDateTime.now().plusMinutes(10));
		
		logger.info("(EmailController) 이메일 전송 성공");
		
        return ResponseEntity.ok("이메일 전송에 성공했습니다.");
    }
 
    // 비밀번호 찾기 (이메일 링크)
    @PostMapping("/sendPwdResetEmail")
    @ResponseBody
    public String sendPwdResetEmail(@ModelAttribute("login") Login login, @RequestParam("userEmail") String userEmail, HttpSession session) {
    	
    	// 입력한 아이디의 정보를 db에 저장
    	Login db = loginService.getUser(login.getMemberId());

    	if(db == null) { // 입력한 아이디가 존재하지않을 경우
    		return "입력한 아이디가 존재하지 않습니다.";
    	} else {
    		if(db.getEmail().equals(userEmail)) { // 입력한 아이디가 존재하고 이메일 데이터와도 일치할 경우
    		
				String token = UUID.randomUUID().toString(); // 예시로 UUID 사용
				session.setAttribute("passwordResetToken", token);
				session.setAttribute("memberId", login.getMemberId());
				
				// 토큰은 24시간 뒤 만료됨
				long tokenExpiration = System.currentTimeMillis() + 24 * 60 * 60 * 1000;
				session.setAttribute("tokenExpiration", tokenExpiration);
				
				// 비밀번호 재설정 링크 생성
				String resetLink = "http://localhost:80/reset-password?token=" + token + "&memberId="
						+ login.getMemberId();
    			
				// 이메일 전송 method 실행
				String emailContent = emailContentService.generatePasswordResetContent(resetLink);
		        emailContentService.sendEmail(userEmail, "냐미냐미 비밀번호 재설정", emailContent);
    			
    			return " 해당 이메일 주소로 보낸 링크를 통해 비밀번호를 재설정하십시오. ";
    		}else {  // 입력한 아이디는 존재하는데 이메일 데이터와 일치하지 않을 경우
    			return "이메일 정보가 가입정보와 일치하지 않습니다.";
    		}
    	}
    }
    
	
    
	
    
    
}

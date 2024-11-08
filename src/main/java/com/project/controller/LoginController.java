package com.project.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.domain.LoginDomain;
import com.project.service.LoginService;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class LoginController {

	private final LoginService loginService;
	


    
    
	@RequestMapping("/loginForm.do")
	public String loginForm() {
		return "login/loginForm";
	}
	
	@RequestMapping("signUp.do")
	public String signUp() {
		return "login/signup";
	}
	
	@RequestMapping("memberForm.do")
	public String signForm() {
		return "login/memberForm";
	}
	
	@RequestMapping("ownerForm.do")
	public String onwerForm() {
		return "login/ownerForm";
	}
	
	@RequestMapping("home.do")
	public String home() {
		return "home/home-category";
	}
	
	@RequestMapping("findPwd.do")
	public String findPwd() {
		return "login/findPwd";
	}
	
	@PostMapping("/idCheck")
	@ResponseBody
	public ResponseEntity<Integer> idCheck(@RequestParam("member_id") String member_id)  {
	    int result = loginService.isUserIdCheck(member_id); // 중복이면 1, 아니면 0 반환
	    return ResponseEntity.ok(result);
	}
	
	@PostMapping("/nicknameCheck")
	@ResponseBody
	public ResponseEntity<Integer> nicknameCheck(@RequestParam("nickname") String nickname)  {
	    int result = loginService.isUserNicknameCheck(nickname); // 중복이면 1, 아니면 0 반환
	    return ResponseEntity.ok(result);
	}
	
	
	
    
//    // 회원가입
//    public String joinMember(LoginDomain login) {
//    	
//    	// 비밀번호 확인
//    	int pwdResult = 0;
//    	
//    	if(login.getPasswd().equals(login.getPasswdCheck())) {
//    		pwdResult = 1;
//    	}else pwdResult = -1;
//    
//    	
//    
//    }
	
	
//	@RequestMapping("/login_ok.do")
//	public String login_ok(@ModelAttribute LoginDomain login,
//	                       HttpSession session,
//	                       Model model) {
//	    
//	    // 입력한 아이디의 특정 유저 정보를 조회해서 db 객체에 저장
//	    LoginDomain db = loginService.getUser(login.getMemberId());
//	    
//	    int result = 0;
//
//	    // 아이디 존재 여부 확인 (null error 방지)
//	    if (db == null) {
//	        // 아이디가 존재하지 않는 경우
//	        result = -1;
//	    } else {
//	        // 아이디가 존재하면 비밀번호 비교
//	        if (db.getPasswd().equals(login.getPasswd())) {
//	            result = 1;  // 로그인 성공
//	        } else {
//	            result = -1;  // 비밀번호 불일치
//	        }
//	    }
//
//	    model.addAttribute("result", result);
//	    model.addAttribute("login", login);
//	    
//	    return "login/loginResult";
//	}
	
}

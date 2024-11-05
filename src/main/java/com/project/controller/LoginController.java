package com.project.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

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

	
	@RequestMapping("goLoginMyPage.do")
	public String goLoginMyPage() {
		return "login/mypagelogin";
	}
	
	
	@RequestMapping("moveMyPage.do")
	public String moveMyPage() {
		return "login/mypagelogin";
	}
	
	@RequestMapping("stateLogin.do")
	public String stateLogin(@RequestParam(value = "rootLogin", required = false) String rootLogin, HttpSession session) {
		
		 session.setAttribute("rootLogin", rootLogin);
		    
		  return "redirect:/oauth2/authorization/naver";
	}
	
	@RequestMapping("stateMypage.do")
	public String stateMypage(@RequestParam(value = "rootLogin", required = false) String rootLogin, HttpSession session) {
		
		 session.setAttribute("rootLogin", rootLogin);
		    
		  return "redirect:/oauth2/authorization/naver";
	}
	
	
	
	
	// 로그인
	@RequestMapping("login_ok.do")
	public String login_ok(@ModelAttribute LoginDomain login,
						   HttpSession session,
						   Model model) {
		
		//입력한 아이디의 특정 유저 정보를 조회해서 db 객체에 저장
		LoginDomain db = loginService.getUser(login.getUserid());
		
		int result = 0;

		
		 // 아이디 존재 여부 확인 (null error 방지)
		if (db == null) {
	        // 아이디가 존재하지 않는 경우
	        result = -1;
	    } else {
	        // 아이디가 존재하면 비밀번호 비교
	        if (db.getUserpwd().equals(login.getUserpwd())) {
	            result = 1;  // 로그인 성공
	            session.setAttribute("loginUser", db);
	        } else {
	            result = -1;  // 비밀번호 불일치
	        }
	    }
	
		model.addAttribute("result", result);
		model.addAttribute("login", login);
		
		return "login/loginResult";
	}
	
	
}

package com.project.controller;

import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.domain.Login;
import com.project.service.LoginService;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class LoginController {

	private final LoginService loginService;
	private final PasswordEncoder passwordEncoder;


    
    
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
	
	// 아이디 중복검사
	@PostMapping("/idCheck")
	@ResponseBody
	public ResponseEntity<Integer> idCheck(@RequestParam("memberId") String memberId)  {
	    int result = loginService.isUserIdCheck(memberId); 
	    return ResponseEntity.ok(result);
	}
	
	// 닉네임 중복검사
	@PostMapping("/nicknameCheck")
	@ResponseBody
	public ResponseEntity<Integer> nicknaCheck(@RequestParam("nickname") String nickname)  {
	    int result = loginService.isUserNicknameCheck(nickname); 
	    return ResponseEntity.ok(result);
	}
	
	@PostMapping("/joinMember")
	public String joinMember(@ModelAttribute("Login") Login login, Model model) {
		int result = 0;
		result = loginService.joinMember(login);

		model.addAttribute("result", result);

		if (result == 1) {
			return "login/joinResult";
		} else {
			return "login/joinResult";
		}

	}

	// 일반 로그인
	@RequestMapping("/login_ok.do")
	public String login_ok(@ModelAttribute("login") Login login,
			 							HttpSession session
			 							,Model model) {
	    
	    // 입력한 아이디의 특정 유저 정보를 조회해서 db 객체에 저장
	    Login db = loginService.getUser(login.getMemberId());
	    
	    int result = 0;

	    // 아이디 존재 여부 확인 (null error 방지)
	    if (db == null) {
	        // 아이디가 존재하지 않는 경우
	        result = -1;
	    } else {
	    	 if (passwordEncoder.matches(login.getPasswd(), db.getPasswd())) {
	             result = 1;  // 로그인 성공
	             session.setAttribute("memberId", db.getMemberId());
	         } else {
	             result = -1;  // 비밀번호 불일치
	         }
	    }

	    model.addAttribute("result", result);
	    model.addAttribute("login", login);
	    
	    return "login/loginResult";
	}
	
	
	
	
	
	
}

package com.project.controller;

import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.oauth2.core.user.OAuth2User;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.project.service.MypageService;

@Controller
public class MypageController {
	@Autowired
	MypageService mypageService;

	@GetMapping("/login")
	public String login() {
		return "mypage/login"; // 로그인 페이지 반환
	}

	@GetMapping("/join")
	public String joinForm() {
		return "mypage/join";
	}
	/*
	 * @PostMapping("/join") public String join(User user) { userService.join(user);
	 * return "redirect:/"; }
	 */

	/*
	 * @GetMapping("/myPage") public String myPage() { return "mypage/myPage"; }
	 */

	@GetMapping("/myPage2")
	public String myPage2() {
		return "mypage/myPage2";
	}

	/*
	 * @GetMapping("/loginSuccess") public String
	 * loginSuccess(@AuthenticationPrincipal OAuth2User oauth2User) {
	 * System.out.println("User Attributes: " + oauth2User.getAttributes()); return
	 * "index"; // loginSuccess.html로 이동 }
	 */
}

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
	
	@GetMapping("/mypage")
    public String myPage(Model model) {
    	return "mypage/mypage";
    }
	
	@GetMapping("/accountSettings")
    public String accountSettings(@AuthenticationPrincipal OAuth2User oauth2User) {
    	if(oauth2User!=null) System.out.println("User Attributes: " + oauth2User.getAttributes());
    	return "mypage/accountSettings";
    }
}

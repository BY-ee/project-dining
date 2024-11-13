package com.project.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.oauth2.core.user.OAuth2User;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.project.domain.Member;
import com.project.domain.MypageLike;
import com.project.domain.PageRequest;
import com.project.service.MypageService;

@Controller
public class MypageController {
	@Autowired
	MypageService mypageService;
	
	@GetMapping("/mypage")
    public String myPage(@RequestParam(defaultValue="1") int likePage,
    					@RequestParam(defaultValue="1") int reviewPage,
    					@RequestParam(defaultValue="5") int size,
    		Model model) {
		Member member = mypageService.getMember("test2");
		
		// 좋아요와 리뷰 각각의 PageRequest 객체 생성
		PageRequest likePageRequest = new PageRequest(reviewPage, size, null, null);
		PageRequest reviewPageRequest = new PageRequest(reviewPage, size, null, null);
		
		// 서비스에서 각각의 PageRequest로 데이터 조회 후 PageResponse로 감싸기
		
		List<MypageLike> mypageLike = mypageService.getMypageLike(22);
		model.addAttribute("member",member);
		model.addAttribute("mypageLike",mypageLike);
    	return "mypage/mypage";
    }
	
	@GetMapping("/profile")
    public String profile(@AuthenticationPrincipal OAuth2User oauth2User,Model model) {
		Member member = mypageService.getMember("test2");
		model.addAttribute("member",member);
    	return "mypage/profile";
    }
	
	@GetMapping("/accountSettings")
    public String accountSettings(@AuthenticationPrincipal OAuth2User oauth2User,Model model) {
		Member member = mypageService.getMember("test2");
		model.addAttribute("member",member);
    	if(oauth2User!=null) System.out.println("User Attributes: " + oauth2User.getAttributes());
    	return "mypage/accountSettings";
    }
}

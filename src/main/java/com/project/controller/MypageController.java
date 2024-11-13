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
import com.project.domain.PageResponse;
import com.project.service.MypageService;

@Controller
public class MypageController {
	@Autowired
	MypageService mypageService;
	
	@GetMapping("/mypage")
    public String myPage(@RequestParam(name = "likePage",defaultValue="1") int likePage,
    					@RequestParam(name = "reviewPage",defaultValue="1") int reviewPage,
    					@RequestParam(name = "size",defaultValue="5") int size,
    		Model model) {
		Member member = mypageService.getMember("test2");
		
		// 좋아요와 리뷰 각각의 PageRequest 객체 생성
		PageRequest likePageRequest = new PageRequest(22,likePage, size);
		PageRequest reviewPageRequest = new PageRequest(22,reviewPage, size);
		
		// 서비스에서 각각의 PageRequest로 데이터 조회 후 PageResponse로 감싸기
		
		PageResponse<MypageLike> likePageResponse = mypageService.getMypageLike(likePageRequest);
		//PageResponse<MypageReview> reviewPageResponse = mypageService.getMypageReview(reviewPageRequest);
		
		model.addAttribute("member",member);
		model.addAttribute("likePageResponse",likePageResponse);
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

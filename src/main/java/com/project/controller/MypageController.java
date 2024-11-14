package com.project.controller;

import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.oauth2.core.user.OAuth2User;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.project.domain.Member;
import com.project.domain.MypageLike;
import com.project.domain.MypageReview;
import com.project.domain.PageRequest;
import com.project.domain.PageResponse;
import com.project.domain.Store;
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
		
		// 세션으로 id받기

		// 멤버값 하나 구해오기
		Member member = mypageService.getMember(24);
		System.out.println(member.getCategory());
		if(member.getCategory().equals("사업자")) {
			Store store =  mypageService.getStore(24);
			model.addAttribute("store",store);
			System.out.println(store.getEnrollStatus());
		}
		
		// 좋아요와 리뷰 각각의 PageRequest 객체 생성
		PageRequest likePageRequest = new PageRequest(22,likePage, size);
		PageRequest reviewPageRequest = new PageRequest(24,reviewPage, size);
		
		// 서비스에서 각각의 PageRequest로 데이터 조회 후 PageResponse로 감싸기
		
		PageResponse<MypageLike> likePageResponse = mypageService.getMypageLike(likePageRequest);
		PageResponse<MypageReview> reviewPageResponse = mypageService.getMypageReview(reviewPageRequest);
		
		model.addAttribute("member",member);
		model.addAttribute("likePageResponse",likePageResponse);
		model.addAttribute("reviewPageResponse",reviewPageResponse);
		
    	return "mypage/mypage";
    }
	
	@GetMapping("/profile")
    public String profile(@AuthenticationPrincipal OAuth2User oauth2User,Model model) {
		Member member = mypageService.getMember(24);
		model.addAttribute("member",member);
    	return "mypage/profile";
    }
	
	@PostMapping("/profile")
	public String profileEdit(Member member,RedirectAttributes redirectAttributes) {
		int i = mypageService.updateMember(member);
		if(i != 1)redirectAttributes.addFlashAttribute("message","변경에 실패하였습니다.");
		else redirectAttributes.addFlashAttribute("message","변경에 성공하였습니다.");
		return "redirect:/profile";
	}
	
	
	@GetMapping("/accountSettings")
    public String accountSettings(@AuthenticationPrincipal OAuth2User oauth2User,Model model) {
		Member member = mypageService.getMember(24);
		model.addAttribute("member",member);
    	if(oauth2User!=null) System.out.println("User Attributes: " + oauth2User.getAttributes());
    	return "mypage/accountSettings";
    }
	
	@PostMapping("/accountSettings")
	public String accountUpdate(@RequestParam(value="current_password",required = false) String currentPassword,
								@RequestParam(value="new_password",required = false) String newPassword
			,RedirectAttributes redirectAttributes) {
		
		System.out.println("현재 = " + currentPassword);
		boolean b = mypageService.changePassword(24,currentPassword,newPassword);
		if(b) redirectAttributes.addFlashAttribute("message","비밀번호가 변경 되었습니다.");
		else redirectAttributes.addFlashAttribute("message","비밀번호가 맞지 않습니다.");
		return "redirect:/accountSettings";
	}
}

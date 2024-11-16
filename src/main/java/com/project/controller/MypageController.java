package com.project.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.oauth2.core.user.OAuth2User;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.domain.Login;
import com.project.domain.Point;
import com.project.service.MypageService;
import com.project.service.PointService;
import com.project.service.ReviewService;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class MypageController {
	@Autowired
	MypageService mypageService;
	
	private final PointService pointService;

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
	
	@GetMapping("/findPointByMemberId")
    @ResponseBody
	public List<Point> getPointByMember(@RequestParam("member_id") long memberId) {
		return pointService.findPointByuserId(memberId);
	}
	
	@GetMapping("/myPage")
	public String myPage(HttpSession session, Model model) {
	    Login loginUser = (Login) session.getAttribute("loginUser");

	    if (loginUser != null) {
	        System.out.println("로그인된 유저 정보: " + loginUser);	     
            int totalPoints = pointService.getTotalPoints(loginUser.getId());

	        model.addAttribute("user", loginUser);
            model.addAttribute("totalPoints", totalPoints);
	    } else {
	        System.out.println("로그인된 유저가 없습니다.");
	        return "redirect:/"; 
	    }

	    return "mypage/myPage"; 
	}
	
}

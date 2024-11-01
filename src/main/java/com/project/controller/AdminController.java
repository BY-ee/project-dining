package com.project.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/admin")
public class AdminController {
	
	// 회원관리 페이지
	@GetMapping("/members")
	public String member() {
		return "adminMembers";
	}
	
	// 게시글 관리 페이지
	@GetMapping("/posts")
	public String post() {
		return "adminPosts";
	}
	
	// 리뷰 관리 페이지
	@GetMapping("/reviews")
	public String review() {
		return "adminReviews";
	}
	
	// 게시글 승인 페이지
	@GetMapping("/approve")
	public String approve() {
		return "adminApprove";
	}
	
	// 공지사항 관리 페이지
	@GetMapping("/notice")
	public String notice() {
		return "adminNotice";
	}
	
	// 공지사항 작성폼 페이지
	@GetMapping("/notice/write")
	public String noticeForm() {
		return "adminNoticeForm";
	}
	
	// 공지사항 작성
	@PostMapping("/notice")
	public String writeNotice() {
		return "adminNotice";
	}
	
	// 이벤트 관리 페이지
	@GetMapping("/event")
	public String event() {
		return "adminEvent";
	}
	
	// 이벤트 작성폼 페이지
	@GetMapping("/event/write")
	public String eventForm() {
		return "adminEventForm";
	}
}

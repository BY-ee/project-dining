package com.project.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.domain.NoticeDomain;
import com.project.service.AdminService;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
@RequestMapping("/admin")
public class AdminController {
	private final AdminService adminService;
	
	// 회원관리 페이지
	@GetMapping("/members")
	public String member() {
		return "admin/adminMembers";
	}
	
	// 게시글 관리 페이지
	@GetMapping("/posts")
	public String post() {
		return "admin/adminPosts";
	}
	
	// 리뷰 관리 페이지
	@GetMapping("/reviews")
	public String review() {
		return "admin/adminReviews";
	}
	
	// 게시글 승인 페이지
	@GetMapping("/approve")
	public String approve() {
		return "admin/adminApprove";
	}
	
	// 공지사항 관리 페이지
	@GetMapping("/notice")
	public String notice() {
		return "admin/adminNotice";
	}
	
	// 공지사항 상세 페이지
	@GetMapping("/notice/id")
	public String noticeDetail() {
		return "admin/adminNoticeDetail";
	}
	
	// 공지사항 작성폼 페이지
	@GetMapping("/notice/write")
	public String noticeForm() {
		return "admin/adminNoticeWrite";
	}
	
	// 공지사항 작성
	@PostMapping("/notice/write")
	@ResponseBody
	public String writeNotice(@RequestBody NoticeDomain notice) {
		adminService.insertNotice(notice);
		return "admin/adminNotice";
	}
	
	// 공지사항 수정폼 페이지
	@GetMapping("/notice/edit/id")
	public String editNoticePage() {
		return "admin/adminNoticeEdit";
	}
	
	// 공지사항 수정
	@PostMapping("/notice/edit")
	public String EditNotice() {
		return "admin/adminNotice";
	}
}

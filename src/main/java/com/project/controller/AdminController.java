package com.project.controller;

import java.util.List;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.domain.Member;
import com.project.domain.Menu;
import com.project.domain.Notice;
import com.project.domain.Review;
import com.project.domain.Store;
import com.project.dto.Pagination;
import com.project.dto.RequestData;
import com.project.service.AdminService;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
@RequestMapping("/admin")
public class AdminController {
	private final AdminService adminService;
	
	// 회원관리 페이지
	@GetMapping("/members")
	public String members(RequestData requestData, Model model) {
		Pagination<Member> members = adminService.selectMembers(requestData);
		model.addAttribute("pagination", members);
		
		return "admin/adminMembers";
	}
	
	// 회원 상세정보 출력
	@GetMapping("/members/{id}")
	@ResponseBody
	public Member memberDetail(@PathVariable("id") long id) {
		return adminService.selectMember(id);
	}
	
	// 회원 차단
	@PostMapping("/members/{id}/block")
	@ResponseBody
	public String blockMember(@PathVariable("id") long id) {
		adminService.blockMember(id);
		
		return "inactive";
	}
	
	// 회원 차단해제
	@PostMapping("/members/{id}/unblock")
	@ResponseBody
	public String unblockMember(@PathVariable("id") long id) {
		adminService.unblockMember(id);
		
		return "active";
	}
	
	// 게시글 관리 페이지
	@GetMapping("/posts")
	public String posts(RequestData requestData, Model model) {
		Pagination<Store> stores = adminService.selectStores(requestData);
		model.addAttribute("pagination", stores);
		
		return "admin/adminPosts";
	}
	
	// 메뉴 조회
	@GetMapping("/menus/{storeId}")
	@ResponseBody
	public List<Menu> selectMenus(@PathVariable("storeId") long storeId) {
		return adminService.selectMenus(storeId);
	}
	
	// 리뷰 관리 페이지
	@GetMapping("/reviews")
	public String reviews(RequestData requestData, Model model) {
		Pagination<Review> reviews = adminService.selectReviews(requestData);
		model.addAttribute("pagination", reviews);
		
		return "admin/adminReviews";
	}
	
	// 게시글 승인 페이지
	@GetMapping("/approval")
	public String showApprovalPage(RequestData requestData, Model model) {
	    Pagination<Store> enrolledStores = adminService.selectEnrolledStores(requestData);
	    model.addAttribute("pagination", enrolledStores);

	    return "admin/adminApproval";
	}

	
	// 공지사항 관리 페이지
	@GetMapping("/notice")
	public String notice(RequestData requestData, Model model) {
		Pagination<Notice> notice = adminService.selectNotice(requestData);
		model.addAttribute("pagination", notice);
		
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
	public ResponseEntity<String> writeNotice(@RequestBody Notice notice) {
		adminService.insertNotice(notice);
		return ResponseEntity.ok("성공");
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

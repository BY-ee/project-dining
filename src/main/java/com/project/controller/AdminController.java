package com.project.controller;

import java.util.List;

import org.springframework.http.MediaType;
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
import org.springframework.web.multipart.MultipartFile;

import com.project.domain.Member;
import com.project.domain.Menu;
import com.project.domain.Notice;
import com.project.domain.Review;
import com.project.domain.Store;
import com.project.dto.Pagination;
import com.project.dto.RequestData;
import com.project.dto.ReviewMemberDTO;
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
	public ResponseEntity<String> blockMember(@PathVariable("id") long id) {
		adminService.blockMember(id);
		
		return ResponseEntity.ok("inactive");
	}
	
	// 회원 차단해제
	@PostMapping("/members/{id}/unblock")
	@ResponseBody
	public ResponseEntity<String> unblockMember(@PathVariable("id") long id) {
		adminService.unblockMember(id);
		
		return ResponseEntity.ok("active");
	}
	
	// 가게 관리 페이지
	@GetMapping("/stores")
	public String stores(RequestData requestData, Model model) {
		Pagination<Store> stores = adminService.selectStores(requestData);
		model.addAttribute("pagination", stores);
		
		return "admin/adminStores";
	}
	
	// 가게 게시글 게시중단
	@PostMapping("/stores/{id}/inactivate")
	@ResponseBody
	public ResponseEntity<String> inactivateStore(@PathVariable("id") long id) {
		adminService.inactivateStore(id);
		
		return ResponseEntity.ok("inactive");
	}
	
	// 가게 게시글 재게시
	@PostMapping("/stores/{id}/reactivate")
	@ResponseBody
	public ResponseEntity<String> reactivateStore(@PathVariable("id") long id) {
		adminService.reactivateStore(id);
		
		return ResponseEntity.ok("active");
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
	
	// 상세리뷰 조회
	@GetMapping("/reviews/detail/{id}")
	@ResponseBody
	public ResponseEntity<Review> detailReview(@PathVariable("id") long id) {
		Review review = adminService.selectDetailReview(id);
		
		return ResponseEntity.ok(review);
	}
	
	// 작성자 정보가 추가된 상세리뷰 조회
	@GetMapping("/reviews/detail-with-member/{id}")
	@ResponseBody
	public ResponseEntity<ReviewMemberDTO> detailReviewMember(@PathVariable("id") long id) {
		ReviewMemberDTO review = adminService.selectDetailReviewMember(id);
		
		return ResponseEntity.ok(review);
	}
	
	// 리뷰 게시중단
	@PostMapping("/reviews/{id}/inactivate")
	@ResponseBody
	public ResponseEntity<String> inactivateReview(@PathVariable("id") long id) {
		adminService.inactivateReview(id);
		
		return ResponseEntity.ok("inactive");
	}
	
	// 리뷰 재게시
	@PostMapping("/reviews/{id}/reactivate")
	@ResponseBody
	public ResponseEntity<String> reactivateReview(@PathVariable("id") long id) {
		adminService.reactivateReview(id);
		
		return ResponseEntity.ok("active");
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
	@GetMapping("/notice/{id}")
	public String noticeDetail(@PathVariable("id") long id, Model model) {
		Notice notice = adminService.selectNoticeById(id);
		model.addAttribute("notice", notice);
		
		return "admin/adminNoticeDetail";
	}
	
	// 공지사항 작성폼 페이지
	@GetMapping("/notice/write")
	public String noticeForm() {
		return "admin/adminNoticeWrite";
	}
	
	// 공지사항 작성
	@PostMapping(value = "/notice/write", consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
	public ResponseEntity<String> writeNotice(
	        @RequestParam("title") String title,
	        @RequestParam("content") String content,
	        @RequestParam(value = "noticeImage", required = false) MultipartFile noticeImage) {
		
	    // 파일을 저장할 경로 설정 (예: /uploads/)
	    String filePath = null;
	    if (noticeImage != null && !noticeImage.isEmpty()) {
	        String fileName = System.currentTimeMillis() + "_" + noticeImage.getOriginalFilename();
	        filePath = "/uploads/" + fileName;
	        File file = new File(filePath);
	        
	        try {
	            // 파일 저장
	            noticeImage.transferTo(file);
	        } catch (IOException e) {
	            e.printStackTrace();
	            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("파일 저장 실패");
	        }
	    }

	    // Notice 객체 생성 후 데이터베이스에 저장
	    Notice notice = new Notice();
	    notice.setTitle(title);
	    notice.setContent(content);
	    notice.setNoticeImage(filePath); // 파일 경로를 Notice 객체에 설정
	    
	    // 데이터베이스에 Notice 객체 저장 (서비스 호출 예시)
	    adminService.insertNotice(notice);
	    
//	    adminService.insertNotice(null);
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
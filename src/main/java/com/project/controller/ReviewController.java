package com.project.controller;

import java.io.File;
import java.io.IOException;
import java.sql.Timestamp;
import java.util.List;
import java.util.Map;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.project.domain.ReviewDomain;
import com.project.service.ReviewService;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class ReviewController {

    private final ReviewService reviewService;

    @RequestMapping("/getReviews")
    @ResponseBody
    public List<ReviewDomain> getReviews(@RequestParam("store_id") long storeId) {
    	
        System.out.println("Getting reviews for store ID: " + storeId);

        return reviewService.getReviewsByStoreId(storeId);
    }

    @PostMapping("/submitReview")
    public String submitReview(
            @RequestParam("storeId") long storeId,
            @RequestParam("score") double score,
            @RequestParam("content") String content,
            @RequestParam(value = "images", required = false) List<MultipartFile> images,
            HttpSession session,
            Model model) {

		// 세션에서 user_ID 가져오기
		Long memberId = (Long) session.getAttribute("user_ID");

		// ReviewDomain 객체 생성 및 값 설정
		ReviewDomain newReview = new ReviewDomain();
		newReview.setMemberId(memberId);
		newReview.setStoreId(storeId);
		newReview.setScore(score);
		newReview.setContent(content);
		newReview.setCreatedAt(new Timestamp(System.currentTimeMillis())); // 현재 시간 설정

		// 이미지가 존재할 경우에만 파일 처리 수행
	    if (images != null && !images.isEmpty()) {
	        StringBuilder imagePaths = new StringBuilder();
	        String uploadDir = session.getServletContext().getRealPath("upload");

	        // 업로드 디렉토리가 존재하지 않으면 생성
	        new File(uploadDir).mkdirs();

	        // images 리스트에서 각 파일 처리
	        for (MultipartFile image : images) {
	            if (!image.isEmpty()) {  // 빈 파일 체크
	                try {
	                    String safeFileName = System.currentTimeMillis() + "_" +
	                            image.getOriginalFilename().replaceAll("[^a-zA-Z0-9.]", "_");
	                    String filePath = uploadDir + "/" + safeFileName;

	                    image.transferTo(new File(filePath));  // 파일 저장
	                    imagePaths.append(safeFileName).append(",");  // 파일명 추가
	                } catch (IOException e) {
	                    e.printStackTrace();  // 파일 저장 실패 시 오류 출력
	                }
	            }
	        }

	        // 이미지 경로 설정 (마지막 쉼표 제거)
	        newReview.setReviewImage(imagePaths.length() > 0 ? imagePaths.substring(0, imagePaths.length() - 1) : null);
	    } else {
	        newReview.setReviewImage(null);  // 이미지가 없을 경우 null 설정
	    }

	    // 리뷰 저장
	    reviewService.submitReview(newReview);

	    // 다시 원래 페이지로 리디렉션
	    return "redirect:/storeDetail?store_ID=" + storeId;
	}
    
    
    // 리뷰 수정 요청 처리
    @PostMapping("/updateReview")
    public ResponseEntity<String> updateReview(@RequestBody ReviewDomain reviewDomain) {
        try {
            reviewService.updateReview(reviewDomain);
            return ResponseEntity.ok("리뷰가 수정되었습니다.");
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("리뷰 수정에 실패했습니다.");
        }
    }

    
    
    // 리뷰 삭제 요청 처리
    @PostMapping("/deleteReview")
    public ResponseEntity<?> deleteReview(@RequestBody Map<String, Object> reviewDetails) {
        try {
            reviewService.deleteReview(reviewDetails); // 서비스에서 삭제 메서드 호출
            return ResponseEntity.ok().build(); // 성공적인 응답 반환
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("리뷰 삭제에 실패했습니다.");
        }
    }
}
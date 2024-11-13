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

		if (images != null && !images.isEmpty()) {
			StringBuilder imagePaths = new StringBuilder();

			String uploadDir = session.getServletContext().getRealPath("upload");

			// 디렉토리가 존재하지 않으면 생성
			File dir = new File(uploadDir);
			if (!dir.exists()) {
				dir.mkdirs();
			}

			for (MultipartFile image : images) {
				try {
					String originalFileName = image.getOriginalFilename();
					System.out.println("originalFileName:" + originalFileName);

					// 파일 이름에서 특수 문자 및 공백을 제거하여 안전하게 처리
					String safeFileName = originalFileName.replaceAll("[^a-zA-Z0-9.]", "_");
					String fileName = System.currentTimeMillis() + "_" + safeFileName;
					String filePath = uploadDir + "/" + fileName;

					System.out.println("filePath: " + filePath);
					// 파일 저장
					image.transferTo(new File(filePath));

					// 웹에서 접근할 수 있는 경로 설정
					String webPath = fileName;
					imagePaths.append(webPath).append(",");
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
			// 마지막 쉼표 제거
			if (imagePaths.length() > 0) {
				imagePaths.setLength(imagePaths.length() - 1);
			}
			newReview.setReviewImage(imagePaths.toString());
		}

		// 리뷰 저장
		reviewService.submitReview(newReview);

		// 다시 원래 페이지로 리디렉션
		return "redirect:/storeDetail?store_ID=" + storeId;
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
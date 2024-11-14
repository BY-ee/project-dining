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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.project.domain.PointDomain;
import com.project.domain.ReviewDomain;
import com.project.service.PointService;
import com.project.service.ReviewService;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class ReviewController {

    private final ReviewService reviewService;
    private final PointService pointService;

    @RequestMapping("/getReviews")
    @ResponseBody
    public List<ReviewDomain> getReviews(@RequestParam("store_id") long storeId) {
    	
        System.out.println("Getting reviews for store ID: " + storeId);
        return reviewService.getReviewsByStoreId(storeId);
    }

    // ================================================================================================
    // => 1. 리뷰 직성 버튼을 누름
    // => 2. 내가 작성한 리뷰가 없을 경우 포인트 지급 및 리뷰 저장 및 목록 출력
    // => 3. 내가 작성한 리뷰가 있고, status가 active로 리뷰 목록에 보일 경우 중복 알람
    // => 4. 내가 작성한 리뷰가 있지만, 이미 삭제 버튼을 통해 status가 active가 아닌 hidden일 경우 이전 리뷰 삭제 후 재 등록
    // => 4-1. 가장 중요한 포인트는 지급되지 않음
    // ==============================================================================================
    
    @PostMapping("/submitReview")
    public String submitReview(
            @RequestParam("storeId") long storeId,
            @RequestParam("score") double score,
            @RequestParam("content") String content,
            HttpSession session,
            Model model,
            RedirectAttributes redirectAttributes) {

        Long memberId = (Long) session.getAttribute("user_ID");
     
        if (memberId == null) {
            return "redirect:/loginForm.do";
        }
        
        ReviewDomain existingReview = reviewService.findReviewByUserAndStore(memberId, storeId);
        boolean pointGiven = false; // 포인트 지급 여부를 저장할 변수
        
        if (existingReview != null) {
            if ("active".equals(existingReview.getStatus())) {
                redirectAttributes.addFlashAttribute("duplicateReviewMessage", "이미 리뷰를 작성하셨습니다.");
                return "redirect:/storeDetail?store_ID=" + storeId;
            } else if("hidden".equals(existingReview.getStatus())) {
                reviewService.deleteReview(existingReview.getId());
            }
        } else {        	
        	PointDomain newPoint = new PointDomain();
            newPoint.setMemberId(memberId);
            newPoint.setCategory("일반리뷰");  // 지급 유형 설정
            newPoint.setPoint(100L);  // 지급할 포인트 설정 (예: 100포인트)
            newPoint.setType("지급");  // 포인트 지급 타입
            newPoint.setCreatedAt(new Timestamp(System.currentTimeMillis())); // 현재 시간 설정
            newPoint.setStatus("active");
            
            pointService.insertPoint(newPoint);
            pointGiven = true; // 포인트 지급됨
        }

        // ReviewDomain 객체 생성 및 값 설정
        ReviewDomain newReview = new ReviewDomain();
        newReview.setMemberId(memberId);
        newReview.setStoreId(storeId);
        newReview.setScore(score);
        newReview.setContent(content);
        newReview.setCreatedAt(new Timestamp(System.currentTimeMillis())); // 현재 시간 설정

        
        // 리뷰 저장
        reviewService.insertReview(newReview);
        
        if (pointGiven) {
            redirectAttributes.addFlashAttribute("pointMessage", "리뷰 작성으로 100포인트가 지급되었습니다!");
        }

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

//    리뷰 삭제 요청 처리
//    @PostMapping("/deleteReview")
//    public ResponseEntity<?> deleteReview(@RequestBody Map<String, Object> reviewDetails) {
//        try {
//            reviewService.deleteReview(reviewDetails); // 서비스에서 삭제 메서드 호출
//            return ResponseEntity.ok().build(); // 성공적인 응답 반환
//        } catch (Exception e) {
//            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("리뷰 삭제에 실패했습니다.");
//        }
//    }
    
    
    @PostMapping("/hiddenReview")
    public ResponseEntity<?> hiddenReview(@RequestBody Map<String, Object> reviewDetails) {
    	try {
    		Long reviewId = Long.parseLong(reviewDetails.get("id").toString());
            reviewService.hiddenReview(reviewId); // 숨김 처리 메서드 호출
            return ResponseEntity.ok().build();
    	} catch(Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("리뷰 삭제에 실패했습니다.");
    	}
    }
}
package com.project.controller;

import java.sql.Timestamp;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.domain.ReviewDomain;
import com.project.service.ReviewService;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class ReviewController {

	private final ReviewService reviewService;
	
//	@RequestMapping("/reviews")
//    public String showReviewsPage() {
//        return "store/reviews";
//    }
	
	@RequestMapping("/getReviews")
	@ResponseBody
	public List<ReviewDomain> getReviews(@RequestParam("storeId") int storeId) {
		
		List<ReviewDomain> reviews = reviewService.getReviewsByStoreId(storeId); 
		
		return reviews;
	}
	
	@PostMapping("/submitReview")
    public String submitReview(
            @RequestParam("storeId") int storeId,
            @RequestParam("score") double score,
            @RequestParam("review") String review,
            HttpSession session,
            Model model) {
        
		// 세션에서 user_ID와 nickname 가져오기
	    Object userIdObj = session.getAttribute("user_ID");
	    String nickname = (String) session.getAttribute("nickname");

	    Integer userId = null;
	    if (userIdObj instanceof String) {
	        // user_ID가 String으로 저장된 경우 Integer로 변환
	        userId = Integer.parseInt((String) userIdObj);
	    } else if (userIdObj instanceof Integer) {
	        userId = (Integer) userIdObj;
	    }
	    
	    if (userId == null) {
	        // 로그인되지 않은 경우 로그인 페이지로 리다이렉트
	        return "redirect:/loginForm.do";
	    }
		
        // ReviewDomain 객체 생성 및 값 설정
        ReviewDomain newReview = new ReviewDomain();
        newReview.setUserId(userId);
        newReview.setStoreId(storeId);
        newReview.setNickname(nickname);
        newReview.setScore(score);
        newReview.setReview(review);  // DTO의 review 필드에 값 설정
        newReview.setCreatedAt(new Timestamp(System.currentTimeMillis())); // 현재 시간 설정
        
        // 리뷰 저장
        reviewService.insertReview(newReview);

        // 다시 원래 페이지로 리디렉션
        return "redirect:/storeDetail?store_ID=" + storeId;
    }
	
}
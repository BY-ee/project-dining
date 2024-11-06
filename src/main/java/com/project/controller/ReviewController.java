package com.project.controller;
import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import com.project.domain.ReviewDomain;
import com.project.service.ReviewService;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestBody;

@Controller
@RequiredArgsConstructor
public class ReviewController {
	private final ReviewService reviewService;
	
//	@RequestMapping("/getReviews")
//	@ResponseBody
//	public List<ReviewDomain> getReviews() {
//		List<ReviewDomain> reviews = reviewService.getAllReviews(); 
//		return reviews;
//	}
	
	@RequestMapping("/getReviews")
	@ResponseBody
	public List<ReviewDomain> getReviews() {
		return reviewService.getAllReviews();
	}
	
	
	@RequestMapping("/submitReview")
	@ResponseBody
	public String submitReview(@RequestBody Map<String, Object> payload) {
	    int userId = (int) payload.get("user_id");
	    int storeId = (int) payload.get("store_id");
	    BigDecimal score = new BigDecimal(String.valueOf(payload.get("score")));
	    String reviewText = (String) payload.get("review");

	    ReviewDomain review = new ReviewDomain();
	    review.setUser_id(userId);
	    review.setStore_id(storeId);
	    review.setScore(score);
	    review.setReview(reviewText);

	    reviewService.saveReview(review);

	    return "리뷰가 성공적으로 저장되었습니다!";
	}
	
//	@GetMapping("/reviews")
//    @ResponseBody // JSON으로 응답하도록 설정
//    public List<ReviewDomain> getReviewsByStoreId(@RequestParam("store_id") int storeId) {
//        return reviewService.getReviewsByStoreId(storeId);
//    }
	
}

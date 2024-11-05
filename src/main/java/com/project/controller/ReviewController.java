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

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class ReviewController {

	private final ReviewService reviewService;
	
	@RequestMapping("/reviews")
    public String showReviewsPage() {
        return "store/reviews";
    }
	
	@RequestMapping("/getReviews")
	@ResponseBody
	public List<ReviewDomain> getReviews() {
		
		List<ReviewDomain> reviews = reviewService.getAllReviews(); 
		
		return reviews;
	}
	
	@PostMapping("/submitReview")
    public String submitReview(
            @RequestParam("userId") int userId,
            @RequestParam("storeId") int storeId,
            @RequestParam("score") double score,
            @RequestParam("review") String review,  // review 필드 사용
            Model model) {
        
        // ReviewDomain 객체 생성 및 값 설정
        ReviewDomain newReview = new ReviewDomain();
        newReview.setUserId(userId);
        newReview.setStoreId(storeId);
        newReview.setScore(score);
        newReview.setReview(review);  // DTO의 review 필드에 값 설정
        newReview.setCreatedAt(new Timestamp(System.currentTimeMillis())); // 현재 시간 설정
        
        // 리뷰 저장
        reviewService.insertReview(newReview);

        // 리뷰 목록 다시 조회
        List<ReviewDomain> reviewList = reviewService.getAllReviews();
        model.addAttribute("reviews", reviewList);

        // 다시 원래 페이지로 리디렉션
        return "redirect:store"; // store.jsp로 리디렉션
    }
	
	
	
	
	
}


package com.project.controller;
import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

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
	
	// @PostMapping("/submitReview")
  //   public String submitReview(
  //           @RequestParam("userId") int userId,
  //           @RequestParam("storeId") int storeId,
  //           @RequestParam("score") double score,
  //           @RequestParam("review") String review,  // review 필드 사용
  //           Model model) {
        
  //       // ReviewDomain 객체 생성 및 값 설정
  //       ReviewDomain newReview = new ReviewDomain();
  //       newReview.setUserId(userId);
  //       newReview.setStoreId(storeId);
  //       newReview.setScore(score);
  //       newReview.setReview(review);  // DTO의 review 필드에 값 설정
  //       newReview.setCreatedAt(new Timestamp(System.currentTimeMillis())); // 현재 시간 설정
        
  //       // 리뷰 저장
  //       reviewService.insertReview(newReview);

  //       // 리뷰 목록 다시 조회
  //       List<ReviewDomain> reviewList = reviewService.getAllReviews();
  //       model.addAttribute("reviews", reviewList);

  //       // 다시 원래 페이지로 리디렉션
  //       return "redirect:store"; // store.jsp로 리디렉션
  //   }
	
	
	
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

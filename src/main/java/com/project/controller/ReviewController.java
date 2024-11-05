package com.project.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
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
		System.out.println("reviews:" + reviews);
		
		return reviews;
	}
}


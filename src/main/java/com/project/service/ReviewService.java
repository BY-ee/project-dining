package com.project.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.project.domain.ReviewDomain;
import com.project.mapper.ReviewMapper;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class ReviewService {

	private final ReviewMapper reviewMapper;

	// 리뷰 조회
	public List<ReviewDomain> getReviewsByStoreId(int store_id) {
	    return reviewMapper.getReviewsByStoreId(store_id);
	}

	// 리뷰저장
	public void insertReview(ReviewDomain newReview) {
		reviewMapper.insertReview(newReview);
	}
	
	
}
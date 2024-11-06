package com.project.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.project.domain.ReviewDomain;
import com.project.mapper.ReviewMapper;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class ReviewService {

	private final ReviewMapper reviewMapper;

	// 모든 리뷰 조회
	public List<ReviewDomain> getReviewsByStoreId(int storeId) {
		return reviewMapper.getReviewsByStoreId(storeId);
	}

	// 리뷰저장
	public void insertReview(ReviewDomain newReview) {
		reviewMapper.insertReview(newReview);
	}
	
	
}
package com.project.service;

import java.io.File;
import java.io.IOException;
import java.sql.Timestamp;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.project.domain.ReviewDomain;
import com.project.mapper.ReviewMapper;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class ReviewService {

	private final ReviewMapper reviewMapper;

	// 리뷰 조회
	public List<ReviewDomain> getReviewsByStoreId(long store_id) {
	    return reviewMapper.getReviewsByStoreId(store_id);
	}

	// 리뷰 저장
	public void submitReview(ReviewDomain newReview) {
        reviewMapper.insertReview(newReview);
    }

	
	// 리뷰 삭제
    public void deleteReview(Map<String, Object> reviewDetails) {
        reviewMapper.deleteReview(reviewDetails);
    }

	
}
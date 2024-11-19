package com.project.service;

import java.util.List;
import org.springframework.stereotype.Service;
import com.project.domain.Review;
import com.project.dto.ReviewWithNicknameDTO;
import com.project.mapper.ReviewMapper;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class ReviewService {

	private final ReviewMapper reviewMapper;

	// 리뷰 조회
	public List<ReviewWithNicknameDTO> getReviewsByStoreId(long storeId) {
	    return reviewMapper.getReviewsByStoreId(storeId);
	}

	// 리뷰 저장
	public void submitReview(Review newReview) {
        reviewMapper.insertReview(newReview);
    }

	
	// 리뷰 삭제
//    public void deleteReview(Map<String, Object> reviewDetails) {
//        reviewMapper.deleteReview(reviewDetails);
//    }
	
	// 리뷰 삭제
	public void deleteReview(long reviewId) {
	    reviewMapper.deleteReview(reviewId);
	}
	
    
    public void hiddenReview(long reviewId) {
    	reviewMapper.updateReviewStatusToHidden(reviewId);
    }
    
    public Review findReviewByUserAndStore(Long memberId, Long storeId) {
        return reviewMapper.findReviewByUserAndStore(memberId, storeId);
    }

    // 리뷰 수정
	public void updateReview(Review review) {
		reviewMapper.updateReview(review);
	}

	
}
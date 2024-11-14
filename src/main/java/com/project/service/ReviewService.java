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
	public List<ReviewDomain> getReviewsByStoreId(long store_id) {
	    return reviewMapper.getReviewsByStoreId(store_id);
	}

	// 리뷰 저장
	public void insertReview(ReviewDomain newReview) {
		reviewMapper.insertReview(newReview);
	}
	
	public void submitReview(ReviewDomain newReview) {
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
    
    public ReviewDomain findReviewByUserAndStore(Long memberId, Long storeId) {
        return reviewMapper.findReviewByUserAndStore(memberId, storeId);
    }

    // 리뷰 수정
	public void updateReview(ReviewDomain reviewDomain) {
		reviewMapper.updateReview(reviewDomain);
	}

    // 리뷰 수정
	public void updateReview(ReviewDomain reviewDomain) {
		reviewMapper.updateReview(reviewDomain);
	}

	
}
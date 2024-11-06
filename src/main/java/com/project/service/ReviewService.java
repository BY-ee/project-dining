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
	
	public List<ReviewDomain> getAllReviews() {
		return reviewMapper.getAllReviews();
	}
	
	public void saveReview(ReviewDomain review) {
		reviewMapper.insertReview(review);
	}
	
//    public List<ReviewDomain> getReviewsByStoreId(int storeId) {
//        return reviewMapper.getReviewsByStoreId(storeId);
//    }
//	
	
}
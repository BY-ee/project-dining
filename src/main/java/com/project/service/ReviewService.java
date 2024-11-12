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
	public void submitReview(long memberId, long storeId,
			double score, String content, List<MultipartFile> images) {
		
		// ReviewDomain 객체 생성 및 값 설정
        ReviewDomain newReview = new ReviewDomain();
        newReview.setMemberId(memberId);
        newReview.setStoreId(storeId);
        newReview.setScore(score);
        newReview.setContent(content);
        newReview.setCreatedAt(new Timestamp(System.currentTimeMillis())); // 현재 시간 설정
        
        if (images != null && !images.isEmpty()) {
            StringBuilder imagePaths = new StringBuilder(); // 쉼표로 이미지 경로 연결
            for (MultipartFile image : images) {
                try {
                    String fileName = System.currentTimeMillis() + "_" + image.getOriginalFilename();
                    String filePath = "/images/store/review/" + fileName;
                    
                    System.out.println("filePath:" + filePath);
                    
                    image.transferTo(new File(filePath));
                    imagePaths.append(filePath).append(",");
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
            newReview.setReviewImage(imagePaths.toString());
        }
		reviewMapper.insertReview(newReview);
	}
	
	// 리뷰 삭제
    public void deleteReview(Map<String, Object> reviewDetails) {
        reviewMapper.deleteReview(reviewDetails);
    }

	
}
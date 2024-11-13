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
            StringBuilder imagePaths = new StringBuilder();

            // 실제 파일이 저장될 경로 (절대 경로로 설정)
            String uploadDir = "src/main/resources/static/images/store/";

            // 디렉토리가 존재하지 않으면 생성
            File dir = new File(uploadDir);
            if (!dir.exists()) {
                dir.mkdirs();
            }

            for (MultipartFile image : images) {
                try {
                    String originalFileName = image.getOriginalFilename();
                    // 파일 이름에서 특수 문자 및 공백을 제거하여 안전하게 처리
                    String safeFileName = originalFileName.replaceAll("[^a-zA-Z0-9.]", "_");
                    String fileName = System.currentTimeMillis() + "_" + safeFileName;
                    String filePath = uploadDir + fileName;

                    // 파일 저장
                    image.transferTo(new File(filePath));

                    // 웹에서 접근할 수 있는 경로 설정
                    String webPath = "/images/store/" + fileName;
                    imagePaths.append(webPath).append(",");
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
            // 마지막 쉼표 제거
            if (imagePaths.length() > 0) {
                imagePaths.setLength(imagePaths.length() - 1);
            }
            newReview.setReviewImage(imagePaths.toString());
        }

        // 리뷰를 데이터베이스에 저장
        reviewMapper.insertReview(newReview);
    }

	
	// 리뷰 삭제
    public void deleteReview(Map<String, Object> reviewDetails) {
        reviewMapper.deleteReview(reviewDetails);
    }

	
}
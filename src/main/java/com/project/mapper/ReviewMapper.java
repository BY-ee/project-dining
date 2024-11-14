package com.project.mapper;

import java.util.List;
import java.util.Map;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import com.project.domain.Review;
import com.project.domain.ReviewDomain;
import com.project.dto.RequestData;
import com.project.dto.ReviewMemberDTO;


@Mapper
public interface ReviewMapper {

	// 리뷰 조회
	public List<ReviewDomain> getReviewsByStoreId(long storeId);

	// 리뷰 삽입
	void insertReview(ReviewDomain newReview);
	
	// 리뷰 조회
	List<Review> selectReviews(
			@Param("start") int start,
			@Param("end") int end,
			@Param("requestData") RequestData requestData);

	// 리뷰 삭제
	// void deleteReview(Map<String, Object> reviewDetails); 
	
	
	// 리뷰 삭제 (포인트 추가작업에 따른 로직)
    void deleteReview(@Param("reviewId") Long reviewId);


	// 총 리뷰 개수
	long countReviews(RequestData requestData);

	// 특정 리뷰 확인
	public Review selectReviewById(long id);
	
	// 작성자 정보가 추가된 상세리뷰 조회
	public ReviewMemberDTO selectReviewMemberById(long id);

	// 리뷰 게시중단
	public void inactivateReview(long id);

	// 리뷰 재게시
	public void reactivateReview(long id);
	long countReviews();
	
	// 리뷰 숨김 처리 메서드
    int updateReviewStatusToHidden(@Param("id") long id);
    
    
    ReviewDomain findReviewByUserAndStore(@Param("memberId") Long memberId, @Param("storeId") Long storeId);

	// 리뷰 수정
	void updateReview(ReviewDomain reviewDomain);
}

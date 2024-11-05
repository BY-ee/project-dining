package com.project.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.project.domain.ReviewDomain;

@Mapper
public interface ReviewMapper {

	// 모든 리뷰 조회
	List<ReviewDomain> getAllReviews();

	// 리뷰 삽입
	void insertReview(ReviewDomain newReview);

}

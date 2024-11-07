package com.project.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.project.domain.ReviewDomain;

@Mapper
public interface ReviewMapper {

	// 리뷰 조회
	List<Map<String, Object>> getReviewsByStoreId(int storeId);

	// 리뷰 삽입
	void insertReview(ReviewDomain newReview);

}

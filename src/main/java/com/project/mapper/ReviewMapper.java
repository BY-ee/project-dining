package com.project.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.project.domain.Review;

@Mapper
public interface ReviewMapper {
	// 리뷰 조회
	List<Review> selectReviews(@Param("start") int start, @Param("end") int end);

}

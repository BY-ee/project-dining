package com.project.mapper;
import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.project.domain.ReviewDomain;

@Mapper
public interface ReviewMapper {
	List<ReviewDomain> getAllReviews();
	void insertReview(ReviewDomain review);
//    List<ReviewDomain> getReviewsByStoreId(@Param("storeId") int storeId);

}
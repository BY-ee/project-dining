package com.project.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.project.domain.ReviewDomain;

@Mapper
public interface ReviewMapper {

	List<ReviewDomain> getAllReviews();

}

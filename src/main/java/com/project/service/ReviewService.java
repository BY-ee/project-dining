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
	
	
}

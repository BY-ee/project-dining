package com.project.service;

import org.springframework.stereotype.Service;

import com.project.domain.PointDomain;
import com.project.mapper.PointMapper;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class PointService {

	private final PointMapper pointMapper;
	
	public void insertPoint(PointDomain newPoint) {
		pointMapper.insertPoint(newPoint);
	}
}

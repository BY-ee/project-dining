package com.project.service;

import org.springframework.stereotype.Service;

import com.project.domain.Point;
import com.project.mapper.PointMapper;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class PointService {

	private final PointMapper pointMapper;
	
	public void insertPoint(Point newPoint) {
		pointMapper.insertPoint(newPoint);
	}
}

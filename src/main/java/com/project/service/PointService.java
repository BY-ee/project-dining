package com.project.service;

import java.util.List;

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
	
	public List<Point> findPointByuserId(Long memberId) {
		return pointMapper.findPointByUser(memberId);
	}
	
    public int getTotalPoints(Long memberId) {
        Integer totalPoints = pointMapper.getTotalPoints(memberId);
        return totalPoints != null ? totalPoints : 0;
    }
	
}

package com.project.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.project.domain.Point;
import com.project.dto.Pagination;
import com.project.dto.RequestData;
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
    
    public Pagination<Point> selectPoints(RequestData requestData) {
        int page = requestData.getPage();
        int size = requestData.getSize();
        
        int start = (page - 1) * size + 1;
        int end = start + size - 1;

        // MyBatis에 전달할 파라미터 맵 구성
        Map<String, Object> params = new HashMap<>();
        params.put("start", start);
        params.put("end", end);
        params.put("requestData", requestData);

        long totalCount = pointMapper.countPoints(requestData);
        List<Point> points = pointMapper.selectPoints(params);

        return new Pagination<>(points, page, size, totalCount);
    }
    
    public List<Point> searchPoints(String column, String keyword) {
        Map<String, Object> params = new HashMap<>();
        params.put("column", column);
        params.put("keyword", keyword);
        return pointMapper.searchPoints(params); // Mapper XML에서 `parameterType="map"` 사용
    }
    
    
    
	
}

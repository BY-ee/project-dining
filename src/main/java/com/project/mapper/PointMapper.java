package com.project.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.project.domain.Point;
import com.project.dto.RequestData;


@Mapper
public interface PointMapper {
	
	// 포인트 지급
	void insertPoint(Point newPoint);
	
	// 포인트 검색(Member_id)
    List<Point> findPointByUser(@Param("memberId") Long memberId);
    
    int getTotalPoints(Long memberId);
    
	long countPoints(RequestData requestData);

	List<Point> selectPoints(Map<String, Object> params);

	List<Point> searchPoints(Map<String, Object> params);
}

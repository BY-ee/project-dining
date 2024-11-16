package com.project.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.project.domain.Point;


@Mapper
public interface PointMapper {
	
	// 포인트 지급
	void insertPoint(Point newPoint);
	
	// 포인트 검색(Member_id)
    List<Point> findPointByUser(@Param("memberId") Long memberId);
    
    //
    int getTotalPoints(Long memberId);

}

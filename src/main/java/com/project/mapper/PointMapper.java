package com.project.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.project.domain.PointDomain;


@Mapper
public interface PointMapper {
	
	// 포인트 지급
	void insertPoint(PointDomain newPoint);

}

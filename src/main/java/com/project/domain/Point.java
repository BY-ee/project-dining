package com.project.domain;

import java.sql.Timestamp;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Data
@Alias("point")
public class Point {
	public Long id;
	public Long memberId;
	public String category;
    private Long point = 0L; // 기본값을 설정하여 null 문제 방지
	public String type;
	public Timestamp createdAt;
	public Timestamp deletedAt;
	public String status;
	
	public String joinMemberId;
	public String joinNickname;
	
    public static Point insertPoint(Long memberId, String category, Long pointValue, String type, String status) {
        Point newPoint = new Point();
        newPoint.setId(System.currentTimeMillis()); // 고유 ID 생성
        newPoint.setMemberId(memberId);
        newPoint.setCategory(category);
        newPoint.setPoint(pointValue);
        newPoint.setType("지급");
        newPoint.setStatus("active");
        newPoint.setCreatedAt(new Timestamp(System.currentTimeMillis())); // 현재 시간
        return newPoint;
    }

    
}

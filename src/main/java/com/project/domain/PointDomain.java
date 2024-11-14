package com.project.domain;

import java.sql.Timestamp;
import lombok.Data;

@Data
public class PointDomain {
	
	public Long id;
	public Long memberId;
	public String category;
    private Long point = 0L; // 기본값을 설정하여 null 문제 방지
	public String type;
	public Timestamp createdAt;
	public Timestamp deletedAt;
	public String status;
}

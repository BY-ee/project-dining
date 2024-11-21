package com.project.dto;

import java.sql.Timestamp;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Data
@Alias("reviewDTO")
public class ReviewDTO {
	// Review
    private Long id;
    private long memberId;
    private long storeId;
    private double score;
    private String content;
    private Timestamp createdAt;
    private String reviewImage;
    private String status;
    
    // Member
    private String nickname;
    
    // Store
    private String storeName;
}

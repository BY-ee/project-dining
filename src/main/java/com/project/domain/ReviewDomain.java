package com.project.domain;

import java.sql.Timestamp;
import java.util.Date;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Data
public class ReviewDomain {
	private int id;
    private Long member_id;
    private int store_id;
    private double score;
    private String content;
    private Timestamp created_at;
    private String nickname; // 추가된 필드

}

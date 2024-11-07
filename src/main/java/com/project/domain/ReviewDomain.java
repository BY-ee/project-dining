package com.project.domain;

import java.sql.Timestamp;
import java.util.Date;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Data
@Alias("ReviewDomain")
public class ReviewDomain {
	private int id;
    private int userId;
    private int storeId;
    private double score;
    private String review;
    private Timestamp createdAt;
}

package com.project.domain;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Data
@Alias("Reviews")
public class ReviewDomain {

	private int id;
	private int user_id;
	private int store_id;
	private double score;
	private String review;
	private String created_at;
}

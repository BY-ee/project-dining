package com.project.domain;

import java.util.Date;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Data
@Alias("ReviewDomain")
public class ReviewDomain {

	private int id;
	private int user_id;
	private int store_id;
	private double score;
	private String review;
	private Date created_at;
}

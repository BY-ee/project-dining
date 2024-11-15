package com.project.domain;

import java.sql.Timestamp;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class MypageReview {
	private Long id;
	private int storeId;
	private int memberId;
	private Timestamp createdAt;
	private String mainImage1;
	private String storeName;
}

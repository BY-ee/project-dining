package com.project.dto;

import java.sql.Timestamp;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class MypageLike {
	private Long id;
	private int storeId;
	private int memberId;
	private Timestamp createdAt;
	private String mainImage1;
	private String storeName;
}

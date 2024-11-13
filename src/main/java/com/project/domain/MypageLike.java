package com.project.domain;

import java.sql.Timestamp;
import java.util.List;

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
}

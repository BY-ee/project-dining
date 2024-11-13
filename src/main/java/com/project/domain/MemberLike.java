package com.project.domain;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class MemberLike {

	private long id;
	private long storeId;
	private long memberId;	
	private Timestamp createdAt;
	public boolean isLiked;
	
	public long likeCount;
}

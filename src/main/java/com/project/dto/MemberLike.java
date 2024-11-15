package com.project.dto;

import java.sql.Timestamp;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Data
@Alias("memberLike")
public class MemberLike {

	private long id;
	private long storeId;
	private long memberId;	
	private Timestamp createdAt;
	public boolean liked;
	public boolean isLiked;
	
	public long likeCount;
}

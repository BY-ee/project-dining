package com.project.domain;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class NoticePageRequest {
	private int page;
	private int size;
	private String category;

	public NoticePageRequest() {
		this.page = 1;
		this.size = 10;
		this.category = "공지";
	}

	// 요청값 범위가 벗어날시 기본값 지정
	public NoticePageRequest(int page, int size,String category) {
		this.page = (page > 0) ? page : 1;
		this.size = (size > 0) ? size : 10;
		this.category = (category == "공지" || category == "이벤트") ? category : "공지";
	}

}

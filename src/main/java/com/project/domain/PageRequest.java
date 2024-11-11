package com.project.domain;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class PageRequest {
	private int page;
	private int size;

	public PageRequest() {
		this.page = 1;
		this.size = 10;
	}

	// 요청값 범위가 벗어날시 기본값 지정
	public PageRequest(int page, int size) {
		this.page = (page > 0) ? page : 1;
		this.size = (size > 0) ? size : 10;
	}

}

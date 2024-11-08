package com.project.domain;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class NoticePageRequest {
	private int page;
	private int size;
	
	public NoticePageRequest() {
        this.page = 1;
        this.size = 10;
    }
	/*
	 * public NoticePageRequest(int page, int size) { this.page = page > 0 ? page :
	 * 1; this.size = size > 0 ? size : 10; }
	 */
	
}

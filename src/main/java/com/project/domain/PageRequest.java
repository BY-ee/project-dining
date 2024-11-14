package com.project.domain;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class PageRequest {
	private int page;
	private int size;
	private String status;
	private String category;
	private String searchKeyword;
	private String searchType;

	public PageRequest() {
		this.page = 1;
		this.size = 10;
		this.status = "active";
		this.category = "";
		this.searchKeyword = "";
		this.searchType = "제목";
	}

	// 요청값 범위가 벗어날시 기본값 지정
	public PageRequest(int page, int size,String status,String category) {
		this.page = (page > 0) ? page : 1;
		this.size = (size > 0) ? size : 10;
		this.status = (status.equals("active") || status.equals("deleted")) ? status : "active" ;
		this.category = (category.equals("") || category.equals("포인트") || category.equals("할인") || category.equals("기타")) ? category : "";
		this.searchType = (searchType.equals("") || searchType.equals("제목") || searchType.equals("내용") || searchType.equals("제목+내용")) ? searchType : "";
	}

}

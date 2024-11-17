package com.project.dto;

import java.util.List;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class PageResponse<T> {
	private List<T> list;
	private int currentPage;
	private int totalPage;
	private int startPage;
	private int endPage;
	private String category;
	private String searchKeyword;
	private String searchType;
	


	public PageResponse(List<T> list, int currentPage, int totalPage, int startPage, int endPage) {
		this.list = list;
		this.currentPage = currentPage;
		this.totalPage = totalPage;
		this.startPage = startPage;
		this.endPage = endPage;
	}
	
	
	
	public PageResponse(List<T> list, int currentPage, int totalPage, int startPage, int endPage,String category,String searchType,String searchKeyword) {
		this.list = list;
		this.currentPage = currentPage;
		this.totalPage = totalPage;
		this.startPage = startPage;
		this.endPage = endPage;
		this.category = category;
		this.searchKeyword = searchKeyword;
		this.searchType = searchType;
	}

}

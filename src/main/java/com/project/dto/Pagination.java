package com.project.dto;

import java.util.List;

import lombok.Getter;

/*
 * 페이징 처리를 위한 객체
 * 생성자에 (출력 데이터의 List, 현재 페이지, 페이지 당 요소 개수, 총 데이터 개수) 입력
 */
@Getter
public class Pagination<T> {
	private final List<T> content;
	private final int currentPage;
	private final int limit;
	private final int start;
	private final int end;
	private final long totalCount;
	private final int totalPages;
	
	public Pagination(List<T> content, int currentPage, int limit, long totalCount) {
		this.content = content;
		this.currentPage = currentPage;
		this.limit = limit;
		
		this.start = (currentPage - 1) * limit + 1;
		this.end = Math.min(start + limit - 1, (int) totalCount);
		this.totalCount = totalCount;
		this.totalPages = (int) Math.ceil((double) totalCount / limit);
	}
}
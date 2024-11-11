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
	private final int page;
	private final int size;
	private final int start;
	private final int end;
	private final long totalCount;
	private final int totalPages;
	
	public Pagination(List<T> content, int page, int size, long totalCount) {
		this.content = content;
		this.page = page;
		this.size = size;
		
		this.start = (page - 1) * size + 1;
		this.end = Math.min(start + size - 1, (int) totalCount);
		this.totalCount = totalCount;
		this.totalPages = (int) Math.ceil((double) totalCount / size);
	}
}
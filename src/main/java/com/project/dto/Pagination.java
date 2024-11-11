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
	private final long totalCount;
	private final int totalPages;
	private final int start;
	private final int end;

	public Pagination(List<T> content, int page, int size, long totalCount) {
		this.content = content;
		this.page = page;
		this.size = size;
		
		this.totalCount = totalCount;
		this.totalPages = (int) Math.ceil((double) totalCount / size);
		
		this.start = ((int) Math.ceil((double) page / 10) - 1) * size + 1;
		this.end = Math.min(start + size - 1, (int) totalPages);
	}

	// 처음 페이지 버튼 출력여부 확인 메서드
	public boolean isFirstPageBtnVisible() {
	    int StartPageRange = this.size;

	    return StartPageRange < this.page;
	}

	// 마지막 페이지 버튼 출력여부 확인 메서드
	public boolean isLastPageBtnVisible() {
	    // 현재 페이지 구간의 끝 번호 계산
	    int endPageRange = ((this.page - 1) / 10 + 1) * 10;
	    
	    return endPageRange < this.totalPages;
	}
}
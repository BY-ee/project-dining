package com.project.domain;

import java.util.List;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class NoticePageResponse {
	private List<Notice> noticeList;
	private int currentPage;
	private int totalPage;
	private int startPage;
	private int endPage;
	
	public NoticePageResponse(List<Notice> noticeList, int currentPage, int totalPage, int startPage, int endPage) {
		this.noticeList = noticeList;
		this.currentPage = currentPage;
		this.totalPage = totalPage;
		this.startPage = startPage;
		this.endPage = endPage;
	}
	
}

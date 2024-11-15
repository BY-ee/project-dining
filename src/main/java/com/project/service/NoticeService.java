package com.project.service;

import java.util.List;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.domain.Event;
import com.project.domain.Notice;
import com.project.dto.PageRequest;
import com.project.dto.PageResponse;
import com.project.mapper.NoticeMapper;

@Service
public class NoticeService {
	@Autowired
	private NoticeMapper noticeMapper;
	
	public PageResponse<Notice> getNoticeList(PageRequest pageRequest) {
		
		// DB에서 페이징 후 size 만큼 데이터를 가져와서 List에 담기 
		int startRow = pageRequest.getSize() * (pageRequest.getPage()-1) + 1 ;
		int endRow = pageRequest.getSize() * (pageRequest.getPage());
		List<Notice> list = noticeMapper.getNoticeList(startRow,endRow,pageRequest);
		
		// 총 게시물 갯수 가져오기 and 총 페이지 갯수 계산
		int countList = noticeMapper.getNoticeCountList(pageRequest);
		int totalPage = (int)Math.ceil((double)countList / pageRequest.getSize());
		
		System.out.print("totalPage = " + totalPage);
		
		// 한번에 10개의 페이지번호만 보여주기 and 이전 버튼과 다음 버튼을 위한 startPage,endPage
		int startPage =  (((pageRequest.getPage()-1)/10)*10) + 1;
		int endPage = Math.min(totalPage,startPage+9);
		
		System.out.println(" startPage = " + startPage + " endPage="  + endPage);
		
		return new PageResponse<>(list,pageRequest.getPage(),totalPage,startPage,endPage,pageRequest.getCategory(),pageRequest.getSearchType(),pageRequest.getSearchKeyword());
	}
	
	public PageResponse<Event> getEventOnList(PageRequest pageRequest) {
		
		// DB에서 페이징 후 size 만큼 데이터를 가져와서 List에 담기 
		int startRow = pageRequest.getSize() * (pageRequest.getPage()-1) + 1 ;
		int endRow = pageRequest.getSize() * (pageRequest.getPage());
		List<Event> list = noticeMapper.getEventList(startRow,endRow,pageRequest.getStatus(),pageRequest.getCategory());
		
		// 총 게시물 갯수 가져오기 and 총 페이지 갯수 계산
		int countList = noticeMapper.getEventCountList(pageRequest.getStatus(),pageRequest.getCategory());
		int totalPage =(int)Math.ceil((double)countList / pageRequest.getSize());
		
		System.out.print("totalPage = " + totalPage);
		
		// 한번에 10개의 페이지번호만 보여주기 and 이전 버튼과 다음 버튼을 위한 startPage,endPage
		int startPage =  (((pageRequest.getPage()-1)/10)*10) + 1;
		int endPage = Math.min(totalPage,startPage+9);
		
		
		System.out.println(" startPage = " + startPage + " endPage="  + endPage);
		
		return new PageResponse<>(list,pageRequest.getPage(),totalPage,startPage,endPage,pageRequest.getCategory(),pageRequest.getSearchType(),pageRequest.getSearchKeyword());
	}

	public Event getEvent(Long id) {
		return noticeMapper.getEvent(id);
	}

	public Notice getNotice(Long id) {
		return noticeMapper.getNotice(id);
	}
	public Notice getPreNotice(Long id) {
		return noticeMapper.getPreNotice(id);
	}
	public Notice getNextNotice(Long id) {
		return noticeMapper.getNextNotice(id);
	}
	
}

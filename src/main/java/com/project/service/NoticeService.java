package com.project.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.domain.Notice;
import com.project.domain.NoticePageRequest;
import com.project.domain.NoticePageResponse;
import com.project.mapper.NoticeMapper;

@Service
public class NoticeService {
	@Autowired
	private NoticeMapper noticeMapper;
	
	public NoticePageResponse getNoticeList(NoticePageRequest noticePageRequest) {
		
		// DB에서 페이징 후 size 만큼 데이터를 가져와서 List에 담기 
		int startRow = 1;
		int endRow = 10;
		List<Notice> noticeList = noticeMapper.getNoticeList(startRow,endRow);
		
		
		
		return new NoticePageResponse(noticeList,1,1,1,1);
	}
	
}

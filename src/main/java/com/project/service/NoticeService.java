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
		int startRow = noticePageRequest.getSize() * (noticePageRequest.getPage()-1) + 1 ;
		int endRow = noticePageRequest.getSize() * (noticePageRequest.getPage());
		List<Notice> noticeList = noticeMapper.getNoticeList(startRow,endRow,noticePageRequest.getCategory());
		
		// 총 게시물 갯수 가져오기 and 총 페이지 갯수 계산
		int countList = noticeMapper.getCountList(noticePageRequest.getCategory());
		int totalPage = countList / noticePageRequest.getSize();
		
		System.out.print("totalPage = " + totalPage);
		
		// 한번에 10개의 페이지번호만 보여주기 and 이전 버튼과 다음 버튼을 위한 startPage,endPage
		int startPage =  (((noticePageRequest.getPage()-1)/10)*10) + 1;
		int endPage = startPage + 9 ;
		
		System.out.println(" startPage = " + startPage + " endPage="  + endPage);
		
		return new NoticePageResponse(noticeList,noticePageRequest.getPage(),totalPage,startPage,endPage);
	}
	
}

package com.project.mapper;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.project.domain.Event;
import com.project.domain.Notice;
import com.project.dto.PageRequest;
import com.project.dto.RequestData;

@Mapper
public interface NoticeMapper {
	// 공지글 조회
	List<Notice> selectNotice(
			@Param("start") int start,
			@Param("end") int end,
			@Param("requestData") RequestData requestData);
	
	// 특정 공지 조회
	Notice selectNoticeById(long id);
	
	// 공지 작성
	void insertNotice(Notice notice);
	
	// 공지 수정
	void updateNotice(@Param("notice") Notice notice, @Param("id") int id);
	
	// 공지 게시중단
	void inactivateNotice(long id);
	
	// 공지 재게시
	void reactivateNotice(long id);
	
	// 총 공지글 개수
	long countNotice(RequestData requestData);
	
	// @Param을 사용하면 XML 파일에서 파라미터를 명확하게 이름으로 참조할 수 있음 
	// @Param 사용하지 않을 시 xml에서 {0},{1} 처럼 순서로 적어야 해 보기 어려울 수 있음.
	List<Notice> getNoticeList(@Param("startRow") int startRow,@Param("endRow") int endRow,@Param("category") String category);

	int getCountList(String category);


	// 이벤트 조회
	List<Event> selectEvents(
			@Param("start") int start,
			@Param("end") int end,
			@Param("requestData") RequestData requestData);

	// 특정 이벤트 조회
	Event selectEventById(long id);
	
	// 이벤트 작성
	void insertEvent(Event event);
	
	// 이벤트 글 수정
	void updateEvent(@Param("event") Event event, @Param("id") int id);
	
	// 이벤트 글 게시중단
	void inactivateEvent(long id);
	
	// 이벤트 글 재게시
	void reactivateEvent(long id);
	
	// 총 이벤트글 개수
	long countEvents(RequestData requestData);

	List<Notice> getNoticeList(@Param("startRow") int startRow,@Param("endRow") int endRow,@Param("pageRequest") PageRequest pageRequest);
	List<Event> getEventList(@Param("startRow") int startRow,@Param("endRow") int endRow,@Param("status") String status,@Param("category") String category);	
	int getNoticeCountList(@Param("pageRequest") PageRequest pageRequest);
	int getEventCountList(@Param("status") String status, @Param("category") String category);
	Notice getNotice(Long id);
	Notice getPreNotice(Long id);
	Notice getNextNotice(Long id);
	Event getEvent(Long id);
	Event getPreEvent(Long id);
	Event getNextEvent(Long id);

	int updateNoticeViews(Notice notice);
	int updateEventViews(Event event);
}

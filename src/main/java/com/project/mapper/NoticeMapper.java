package com.project.mapper;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.project.domain.Event;
import com.project.domain.Notice;

@Mapper
public interface NoticeMapper {
	void insertNotice(Notice notice);
	
	// @Param을 사용하면 XML 파일에서 파라미터를 명확하게 이름으로 참조할 수 있음 
	// @Param 사용하지 않을 시 xml에서 {0},{1} 처럼 순서로 적어야 해 보기 어려울 수 있음.
	List<Notice> getNoticeList(@Param("startRow") int startRow,@Param("endRow") int endRow);
	List<Event> getEventList(@Param("startRow") int startRow,@Param("endRow") int endRow);
	
	int getNoticeCountList();
	int getEventCountList();
}

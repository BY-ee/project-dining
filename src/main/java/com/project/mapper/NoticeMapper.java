package com.project.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.project.domain.Notice;

@Mapper
public interface NoticeMapper {
	// 공지 작성
	void insertNotice(Notice notice);

	// 공지글 조회
	List<Notice> selectNotice(@Param("start") int start, @Param("end") int end);
	
	// 총 공지글 개수
	long countNotice();
}

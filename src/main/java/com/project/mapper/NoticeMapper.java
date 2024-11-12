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
	
	// @Param을 사용하면 XML 파일에서 파라미터를 명확하게 이름으로 참조할 수 있음 
	// @Param 사용하지 않을 시 xml에서 {0},{1} 처럼 순서로 적어야 해 보기 어려울 수 있음.
	List<Notice> getNoticeList(@Param("startRow") int startRow,@Param("endRow") int endRow,@Param("category") String category);

	int getCountList(String category);

	// 특정 공지 조회
	Notice selectNoticeById(long id);
}

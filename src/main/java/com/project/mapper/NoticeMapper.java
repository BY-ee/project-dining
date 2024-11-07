package com.project.mapper;

import org.apache.ibatis.annotations.Mapper;


import com.project.domain.Notice;

@Mapper
public interface NoticeMapper {
	void insertNotice(Notice notice);
}

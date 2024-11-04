package com.project.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.project.domain.NoticeDomain;

@Mapper
public interface NoticeMapper {
	void insertNotice(NoticeDomain notice);
}

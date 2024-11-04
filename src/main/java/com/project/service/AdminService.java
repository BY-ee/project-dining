package com.project.service;

import org.springframework.stereotype.Service;

import com.project.domain.NoticeDomain;
import com.project.mapper.NoticeMapper;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class AdminService {
	private final NoticeMapper noticeMapper;

	public void insertNotice(NoticeDomain notice) {
		noticeMapper.insertNotice(notice);
	}
}

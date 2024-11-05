package com.project.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.project.domain.Member;
import com.project.domain.NoticeDomain;
import com.project.mapper.MemberMapper;
import com.project.mapper.NoticeMapper;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class AdminService {
	private final NoticeMapper noticeMapper;
	private final MemberMapper memberMapper;

	// 공지 작성
	public void insertNotice(NoticeDomain notice) {
		noticeMapper.insertNotice(notice);
	}
	
	// 유저 조회
	public List<Member> selectMembers(int page, int limit) {
		int start = (page - 1) * limit + 1;
		int end = start + limit - 1;
		
		return memberMapper.selectMembers(start, end);
	}
	
	// 특정 유저 조회
	public Member selectMember(long id) {
		return memberMapper.selectMember(id);
	}
}

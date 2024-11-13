package com.project.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.domain.Member;
import com.project.domain.MypageLike;
import com.project.mapper.MypageMapper;

@Service
public class MypageService {
	@Autowired
	MypageMapper mypageMapper;
	
	public Member getMember(String memberId) {
		return mypageMapper.getMember(memberId);
	}

	public List<MypageLike> getMypageLike(int memberId) {
		return mypageMapper.getMypageLike(memberId);
	}
}

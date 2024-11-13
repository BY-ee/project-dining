package com.project.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.domain.Member;
import com.project.domain.MypageLike;
import com.project.domain.PageRequest;
import com.project.domain.PageResponse;
import com.project.mapper.MypageMapper;

@Service
public class MypageService{
	@Autowired
	MypageMapper mypageMapper;
	
	public Member getMember(String memberId) {
		return mypageMapper.getMember(memberId);
	}

	public PageResponse<MypageLike> getMypageLike(PageRequest pageRequest) {
		
		int startRow = pageRequest.getSize() * (pageRequest.getPage()-1);
		int endRow = pageRequest.getSize() * pageRequest.getPage() ;
		
		List<MypageLike> list = mypageMapper.getMypageLike(pageRequest,startRow,endRow);
		
		int countList = mypageMapper.getCountMypageLike(pageRequest.getMemberId());
		int totalPage = (int)Math.ceil((double)countList/pageRequest.getSize());
		int startPage = (pageRequest.getPage()-1)/5*5 + 1;
		int endPage = Math.min(totalPage, startPage);
		return new PageResponse<>(list,pageRequest.getPage(),totalPage,startPage,endPage);
	}
}

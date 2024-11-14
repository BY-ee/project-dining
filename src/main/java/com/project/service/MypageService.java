package com.project.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import com.project.domain.Member;
import com.project.domain.MypageLike;
import com.project.domain.MypageReview;
import com.project.domain.PageRequest;
import com.project.domain.PageResponse;
import com.project.domain.Store;
import com.project.mapper.MypageMapper;

@Service
public class MypageService{
	@Autowired
	MypageMapper mypageMapper;
	@Autowired
	PasswordEncoder passwordEncoder;
	
	public Member getMember(long id) {
		return mypageMapper.getMember(id);
	}

	public PageResponse<MypageLike> getMypageLike(PageRequest pageRequest) {
		
		int startRow = pageRequest.getSize() * (pageRequest.getPage()-1) +1;
		int endRow = pageRequest.getSize() * pageRequest.getPage() ;
		
		List<MypageLike> list = mypageMapper.getMypageLike(pageRequest,startRow,endRow);
		
		int countList = mypageMapper.getCountMypageLike(pageRequest.getMemberId());
		int totalPage = (int)Math.ceil((double)countList/pageRequest.getSize());
		int startPage = (pageRequest.getPage()-1)/5*5 + 1;
		int endPage = Math.min(totalPage, startPage+4);
		return new PageResponse<>(list,pageRequest.getPage(),totalPage,startPage,endPage);
	}

	public PageResponse<MypageReview> getMypageReview(PageRequest pageRequest) {
		int startRow = pageRequest.getSize() * (pageRequest.getPage()-1) +1;
		int endRow = pageRequest.getSize() * pageRequest.getPage() ;
		
		List<MypageReview> list = mypageMapper.getMypageReview(pageRequest,startRow,endRow);
		
		int countList = mypageMapper.getCountMypageReview(pageRequest.getMemberId());
		int totalPage = (int)Math.ceil((double)countList/pageRequest.getSize());
		int startPage = (pageRequest.getPage()-1)/5*5 + 1;
		int endPage = Math.min(totalPage, startPage+4);
		return new PageResponse<>(list,pageRequest.getPage(),totalPage,startPage,endPage);
	}

	public Store getStore(long memberId) {
		return mypageMapper.getStore(memberId);
	}

	public int updateMember(Member member) {
		return mypageMapper.updateMember(member);
	}

	public boolean changePassword(long id,String currentPassword,String newPassword) {
		Member member = mypageMapper.getMember(id);
		
		if(!(passwordEncoder.matches(currentPassword,member.getPasswd()))) return false;
		
		member.setPasswd(passwordEncoder.encode(newPassword));
		int i = mypageMapper.updatePassword(member);
		return true;
	}
}

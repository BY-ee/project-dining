package com.project.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.oauth2.core.user.OAuth2User;
import org.springframework.stereotype.Service;

import com.project.domain.Member;
import com.project.domain.Store;
import com.project.dto.MypageLike;
import com.project.dto.MypageReview;
import com.project.dto.PageRequest;
import com.project.dto.PageResponse;
import com.project.mapper.MypageMapper;

import jakarta.servlet.http.HttpSession;

@Service
public class MypageService{
	@Autowired
	MypageMapper mypageMapper;
	@Autowired
	PasswordEncoder passwordEncoder;
	
	
	public Member getMember(String memberId) { return mypageMapper.getMember(memberId); }
	 

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

	public boolean changePassword(Member member,String currentPassword,String newPassword) {
		if(!(passwordEncoder.matches(currentPassword,member.getPasswd()))) return false;
		
		member.setPasswd(passwordEncoder.encode(newPassword));
		int i = mypageMapper.updatePassword(member);
		return true;
	}

	public int deleteMember(long id) {
		return mypageMapper.deleteMember(id);
	}

	public int fileUpload(Member member) {
		return mypageMapper.fileUpload(member);
	}

	public int updateSocialId(@AuthenticationPrincipal OAuth2User oauth2User,HttpSession session) {
		String socialName = (String)session.getAttribute("socialName");
		Map<String,Object> attributes = oauth2User.getAttributes();
		
		if(socialName.equals("네이버")) {
			return mypageMapper.updateSocialId(24L, socialName,(String)((Map<String, Object>) attributes.get("response")).get("id"));
		}
		
	    if(socialName.equals("카카오")) { 
	    	return mypageMapper.updateSocialId(24L,socialName, String.valueOf(attributes.get("id"))); 
	    }
		
		if(socialName.equals("구글")) {
			return mypageMapper.updateSocialId(24L, socialName, String.valueOf(attributes.get("sub")));
		}
		return 0;
	}
	
	public int updateEmail(Member member) {
		return mypageMapper.updateEmail(member);
	}
}

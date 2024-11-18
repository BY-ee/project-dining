package com.project.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.oauth2.core.user.OAuth2User;
import org.springframework.stereotype.Service;

import com.project.config.SecurityContextUtil;
import com.project.domain.Member;
import com.project.domain.Store;
import com.project.dto.MypageLike;
import com.project.dto.MypageReview;
import com.project.dto.PageRequest;
import com.project.dto.PageResponse;
import com.project.mapper.MemberMapper;
import com.project.mapper.MypageMapper;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class MypageService {
	
	private final MypageMapper mypageMapper;
	private final PasswordEncoder passwordEncoder;
	private final SecurityContextUtil securityContextUtil;
	private final MemberMapper memberMapper;
	
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
		int result = mypageMapper.updateMember(member);
		securityContextUtil.reloadUserDetails(member.getMemberId());  // spring security context의 상태 수정
		
		return result;
	}

	public boolean changePassword(long id,String currentPassword,String newPassword) {
		Member member = mypageMapper.getMember(id);
		
		if(!(passwordEncoder.matches(currentPassword, member.getPasswd()))) {
			return false;
		}
		
		member.setPasswd(passwordEncoder.encode(newPassword));
		int i = mypageMapper.updatePassword(member);
		securityContextUtil.reloadUserDetails(member.getMemberId());  // spring security context의 상태 수정
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
		long id = 24L;
		int result = 0;
		
		if(socialName.equals("네이버")) {
			result = mypageMapper.updateSocialId(id, socialName,(String)((Map<String, Object>) attributes.get("response")).get("id"));
		} else if(socialName.equals("카카오")) { 
	    	result = mypageMapper.updateSocialId(id,socialName, String.valueOf(attributes.get("id")));
	    } else if(socialName.equals("구글")) {
			result = mypageMapper.updateSocialId(24L, socialName, String.valueOf(attributes.get("sub")));
		}
		
		Member member = memberMapper.selectMember(id);
		securityContextUtil.reloadUserDetails(member.getMemberId());  // spring security context의 상태 수정
		
		return result;
	}
	
	public int updateEmail(Member member) {
		return mypageMapper.updateEmail(member);
	}
}

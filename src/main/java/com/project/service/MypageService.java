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
import com.project.dto.CustomUserDetails;
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
		int result = mypageMapper.updateMember(member);
		securityContextUtil.reloadUserDetails(member.getMemberId());  // spring security context의 상태 수정
		
		return result;
	}

	public boolean changePassword(Member member,String currentPassword,String newPassword) {
		if(currentPassword != null) {
			if(!(passwordEncoder.matches(currentPassword,member.getPasswd()))) return false;			
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
		int i = mypageMapper.fileUpload(member);
		securityContextUtil.reloadUserDetails(member.getMemberId());
		return i;
	}

	// 전체적으로 고치기
	public int updateSocialId(@AuthenticationPrincipal CustomUserDetails userDetails,HttpSession session) {
		String socialName = (String)session.getAttribute("socialName");
		Map<String,Object> attributes = userDetails.getAttributes();
		int result = 0;
		
		if(socialName.equals("네이버")) {
			result = mypageMapper.updateSocialId(userDetails.getId(), socialName,(String)((Map<String, Object>) attributes.get("response")).get("email"));
		} else if(socialName.equals("카카오")) { 
	    	result = mypageMapper.updateSocialId(userDetails.getId(),socialName, (String)((Map<String, Object>)attributes.get("kakao_account")).get("email"));
	    } else if(socialName.equals("구글")) {
			result = mypageMapper.updateSocialId(userDetails.getId(), socialName, String.valueOf(attributes.get("email")));
		}
		
		securityContextUtil.reloadUserDetails(userDetails.getName());  // spring security context의 상태 수정
		
		return result;
	}
	
	public int updateEmail(Member member) {
		int i = mypageMapper.updateEmail(member);
		securityContextUtil.reloadUserDetails(member.getMemberId());
		return i;
	}


	public boolean updateToBusinessMember(String memberId, String registrationNumber) {
	    int rowsAffected = mypageMapper.updateToBusinessMember(memberId, registrationNumber);
	    if (rowsAffected > 0) {
	        securityContextUtil.reloadUserDetails(memberId);
	        return true; // 업데이트 성공
	    } else {
	        return false; // 업데이트 실패
	    }
	}
}

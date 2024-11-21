package com.project.mapper;

import java.util.List;


import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.project.domain.Member;
import com.project.dto.MypageReview;
import com.project.domain.Store;
import com.project.dto.MypageLike;
import com.project.dto.PageRequest;

@Mapper
public interface MypageMapper {
	Member getMember(String memberId);

	List<MypageLike> getMypageLike(@Param("pageRequest")PageRequest pageRequest,@Param("startRow")int startRow , @Param("endRow")int endRow);
	List<MypageReview> getMypageReview(@Param("pageRequest")PageRequest pageRequest,@Param("startRow")int startRow , @Param("endRow")int endRow);
	int getCountMypageLike(long memberId);
	int getCountMypageReview(long memberId);
	
	Store getStore(long memberId);

	int updateMember(Member member);

	int updatePassword(Member member);

	int deleteMember(long id);

	int fileUpload(Member member);

	int updateSocialId(@Param("id")Long id, @Param("socialName")String socialName,@Param("socialId") String socialId);

	int updateEmail(Member member);

	int updateToBusinessMember(@Param("memberId") String memberId, @Param("registrationNumber") String registrationNumber);
}

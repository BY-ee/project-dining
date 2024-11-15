package com.project.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.project.domain.Member;
import com.project.domain.MypageLike;
import com.project.domain.MypageReview;
import com.project.domain.PageRequest;
import com.project.domain.Store;

@Mapper
public interface MypageMapper {
	Member getMember(long id);

	List<MypageLike> getMypageLike(@Param("pageRequest")PageRequest pageRequest,@Param("startRow")int startRow , @Param("endRow")int endRow);
	List<MypageReview> getMypageReview(@Param("pageRequest")PageRequest pageRequest,@Param("startRow")int startRow , @Param("endRow")int endRow);
	int getCountMypageLike(long memberId);
	int getCountMypageReview(long memberId);
	
	Store getStore(long memberId);

	int updateMember(Member member);

	int updatePassword(Member member);

	int deleteMember(long id);

	int fileUpload(Member member);
}

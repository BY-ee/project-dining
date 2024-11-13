package com.project.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.project.domain.Member;
import com.project.domain.MypageLike;
import com.project.domain.PageRequest;

@Mapper
public interface MypageMapper {
	Member getMember(String memberId);

	List<MypageLike> getMypageLike(@Param("pageRequest")PageRequest pageRequest,@Param("startRow")int startRow , @Param("endRow")int endRow);
	
	int getCountMypageLike(long memberId);
}

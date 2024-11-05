package com.project.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.project.domain.Member;

@Mapper
public interface MemberMapper {

	// 유저 조회
	List<Member> selectMembers(@Param("start") int start, @Param("end") int end);
	
	// 특정 유저 조회
	Member selectMember(long id);
}

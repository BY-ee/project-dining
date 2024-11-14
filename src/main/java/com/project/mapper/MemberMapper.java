package com.project.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.project.domain.Member;
import com.project.dto.RequestData;

@Mapper
public interface MemberMapper {

	// 유저 조회
	List<Member> selectMembers(
			@Param("start") int start,
			@Param("end") int end,
			@Param("requestData") RequestData requestData);
	
	// 특정 유저 조회
	Member selectMember(long id);
	
	// 총 회원수
	long countMembers(RequestData requestData);
	
	// 회원 차단
	void blockMember(@Param("id") long id, @Param("banTime") int banTime);

	// 회원 차단해제
	void unblockMember(long id);
}

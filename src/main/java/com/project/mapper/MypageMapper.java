package com.project.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.project.domain.Member;
import com.project.domain.MypageLike;

@Mapper
public interface MypageMapper {
	Member getMember(String memberId);

	List<MypageLike> getMypageLike(int memberId);
}

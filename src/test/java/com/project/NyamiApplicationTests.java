package com.project;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import com.project.domain.Member;

@SpringBootTest
class NyamiApplicationTests {

	@Autowired
	private SqlSession sqlSession;

	@Test
	public void 유저_조회() {
	    String sql = "SELECT * FROM member WHERE id=10";
	    List<Member> members = sqlSession.selectList("selectMember", sql);
	    System.out.println(members.size());
	}
}

package com.project.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import com.project.domain.Menu;

@Mapper
public interface MenuMapper{
	// 메뉴 조회
	List<Menu> selectMenus(@Param("storeId") long storeId);

	 void insertMenu(Menu menu);
	 
}

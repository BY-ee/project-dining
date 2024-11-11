package com.project.mapper;

import java.util.List;


import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.project.domain.StoreDomain;
import com.project.domain.Menu;
import com.project.domain.Store;


@Mapper
public interface StoreMapper{
	
	// 가게정보 가져오기
    StoreDomain getStoreDetailById(int store_ID);
    
    // 메뉴정보 가져오기
    Menu getMenuById(int storeId);
    
    
	List<Store> selectStores(@Param("start") int start, @Param("end") int end);

	// 총 가게 개수
	long countStores();
	
	List<Store> findAllStores();
	
	
    List<Store> findStoresByLocation(String location);
    
}

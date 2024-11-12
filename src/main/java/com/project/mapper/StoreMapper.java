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
    
    // 가게 조회
	List<Store> selectStores(@Param("start") int start, @Param("end") int end);

	// 게시 신청한 가게 목록 조회
	List<Store> selectEnrolledStores(@Param("start") int start, @Param("end") int end);
	
	// 총 가게 개수
	long countStores();

	// 게시 신청한 가게의 총 개수
	long countEnrolledStores();

	// 가게 게시글 게시중단
	void inactivateStore(long id);

	// 가게 게시글 재게시
	void reactivateStore(long id);
}

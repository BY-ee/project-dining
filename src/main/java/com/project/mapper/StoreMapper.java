package com.project.mapper;

import java.util.List;


import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.project.domain.StoreDomain;
import com.project.domain.MemberLike;
import com.project.domain.Menu;
import com.project.domain.Store;


@Mapper
public interface StoreMapper{
	
	// 가게정보 가져오기
    StoreDomain getStoreDetailById(long store_ID);
    
    // 메뉴정보 가져오기
    List<Menu> getMenuById(long storeId);
    
    
	List<Store> selectStores(@Param("start") int start, @Param("end") int end);

	// 총 가게 개수
	long countStores();

	// 찜 추가
	void save(MemberLike like);

	// 찜 취소
	void deleteByMemberIdAndStoreId(@Param("memberId") long memberId, @Param("storeId") long storeId);
	
	List<Store> findAllStores();
	
    List<Store> findStoresByLocation(String location);
    
    List<Store> findStoresByFilters(
            @Param("location") String location,
            @Param("industry") String industry,
            @Param("subCategory") String subCategory,
            @Param("themeArray") List<String> themeArray
        );
    
}

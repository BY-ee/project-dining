package com.project.mapper;

import java.util.List;


import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.project.domain.StoreDomain;
import com.project.domain.Store;


@Mapper
public interface StoreMapper{
    StoreDomain getStoreDetailById(int storeId);
	List<Store> selectStores(@Param("start") int start, @Param("end") int end);

}

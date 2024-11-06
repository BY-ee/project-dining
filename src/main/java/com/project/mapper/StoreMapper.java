package com.project.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.project.domain.StoreDomain;

@Mapper
public interface StoreMapper{

	StoreDomain getStoreDetailById(int storeId);

}

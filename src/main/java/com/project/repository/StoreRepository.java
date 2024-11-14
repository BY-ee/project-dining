package com.project.repository;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.project.domain.Store;

import java.util.List;

@Mapper
public interface StoreRepository {

    // SQL 쿼리 또는 XML 파일에서 정의된 쿼리를 실행하는 메서드
    List<Store> findStoresByFilters(
            @Param("location") String location,
            @Param("industry") String industry,
            @Param("subCategory") String subCategory,
            @Param("themeArray") String[] themeArray
    );
}
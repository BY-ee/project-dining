package com.project.service;

import org.springframework.stereotype.Service;

import com.project.domain.StoreDomain;
import com.project.mapper.StoreMapper;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class StoreService {

	private final StoreMapper storeMapper;
	
    public StoreDomain getStoreDetailById(int storeId) {
        return storeMapper.getStoreDetailById(storeId); // Mapper 호출
    }
	
}

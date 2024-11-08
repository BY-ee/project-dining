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
		return storeMapper.getStoreDetailById(storeId);
	}
	
    public StoreDomain getStoreDetailById(int store_ID) {
        return storeMapper.getStoreDetailById(store_ID); // Mapper 호출
    }
	
}

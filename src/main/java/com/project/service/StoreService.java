package com.project.service;

import java.util.List;
import com.project.domain.Store;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.project.domain.Menu;
import com.project.domain.StoreDomain;
import com.project.mapper.StoreMapper;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class StoreService {

	private final StoreMapper storeMapper;

	public StoreDomain getStoreDetailById(int store_ID) {
		return storeMapper.getStoreDetailById(store_ID);
	}

	public Menu getMenulById(int storeId) {
		return storeMapper.getMenuById(storeId);
	}
	
	public List<Store> findAllStores() {
        return storeMapper.findAllStores();
	}
	
	@Transactional(readOnly = true)
    public List<Store> findStoresByLocation(String location) {
        return storeMapper.findStoresByLocation(location); // StoreMapper에서 특정 지역의 가게 목록 가져오기
    }
	
}

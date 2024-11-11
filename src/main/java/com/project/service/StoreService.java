package com.project.service;

import java.sql.Timestamp;
import java.util.List;

import org.springframework.stereotype.Service;

import com.project.domain.MemberLike;
import com.project.domain.Menu;
import com.project.domain.StoreDomain;
import com.project.mapper.StoreMapper;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class StoreService {

	private final StoreMapper storeMapper;

	public StoreDomain getStoreDetailById(long store_ID) {
		return storeMapper.getStoreDetailById(store_ID);
	}

	public List<Menu> getMenuById(long storeId) {
		return storeMapper.getMenuById(storeId);
	}

	public void addLike(long memberId, long storeId) {
		MemberLike like = new MemberLike();
		like.setMemberId(memberId);
		like.setStoreId(storeId);
		like.setCreatedAt(new Timestamp(System.currentTimeMillis()));
		
		storeMapper.save(like);
	}

	public void removeLike(long memberId, long storeId) {
		storeMapper.deleteByMemberIdAndStoreId(memberId, storeId);
	}
	
}

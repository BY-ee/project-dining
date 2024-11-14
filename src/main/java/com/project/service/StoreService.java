package com.project.service;

import java.sql.Timestamp;
import java.util.Arrays;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.project.domain.MemberLike;
import com.project.domain.Menu;
import com.project.domain.Store;
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
		if (storeMapper.isMemberLikedStore(storeId, memberId) == 0) { // 중복 확인
	        MemberLike like = new MemberLike();
	        like.setMemberId(memberId);
	        like.setStoreId(storeId);
	        like.setCreatedAt(new Timestamp(System.currentTimeMillis()));
	        
	        storeMapper.save(like);
	    } else {
	        System.out.println("이미 찜한 상태입니다.");
	    }
	}

	public void removeLike(long memberId, long storeId) {
		storeMapper.deleteByMemberIdAndStoreId(memberId, storeId);
	}
	
	public List<Store> findAllStores() {
        return storeMapper.findAllStores();
	}
	
	@Transactional(readOnly = true)
    public List<Store> findStoresByLocation(String location) {
        return storeMapper.findStoresByLocation(location); // StoreMapper에서 특정 지역의 가게 목록 가져오기
    }

	// 찜좋아요 수 가져오기
	public long getLikeCountByStoreId(Long storeId) {
	    Long count = storeMapper.getLikeCountByStoreId(storeId);
	    return (count != null) ? count : 0;
	}
	
	// 특정 사용자가 특정 가게를 찜했는지 확인
	public boolean isMemberLikedStore(Long storeId, Long memberId) {
		return storeMapper.isMemberLikedStore(storeId, memberId) > 0;
	}
	
    @Transactional // 트랜잭션 활성화
    public List<Store> getStoresByFilters(String location, String industry, String subCategory, String[] themeArray) {
        // String[]을 List<String>으로 변환
        List<String> themeList = (themeArray != null) ? Arrays.asList(themeArray) : null;
        return storeMapper.findStoresByFilters(location, industry, subCategory, themeList);
    }
	
}

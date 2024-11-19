package com.project.service;

import java.sql.Timestamp;
import java.util.Arrays;
import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.project.domain.Menu;
import com.project.domain.Store;
import com.project.dto.IndustryDTO;
import com.project.dto.MemberLike;
import com.project.dto.StoreWithLocationDTO;
import com.project.mapper.StoreMapper;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class StoreService {

	private final StoreMapper storeMapper;

	public Store getStoreDetailById(long store_ID) {
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
	
    @Transactional(readOnly = true)
    public List<Store> getStoresByFilters(String location, String industry, String subCategory, String[] themeArray) {
        // String[]을 List<String>으로 변환
        List<String> themeList = (themeArray != null) ? Arrays.asList(themeArray) : null;
        return storeMapper.findStoresByFilters(location, industry, subCategory, themeList);
    }

    // 카테고리 가져오기
	public List<StoreWithLocationDTO> getStoreCategory(long storeId) {
		return storeMapper.getStoreCategory(storeId);
	}
    
    @Transactional(readOnly = true)
    public List<Store> getStoresByOrder(String order, String location, String industry, String subCategory, String[] themeArray) {
        // 기존의 필터와 정렬을 결합하여 결과를 반환
        List<String> themeList = (themeArray != null) ? Arrays.asList(themeArray) : null;
        return storeMapper.findStoresByOrder(order, location, industry, subCategory, themeList);
    }

	@Transactional
	public void registerStore(StoreWithLocationDTO store) {
		// 1. store 테이블 삽입 및 ID 생성
        storeMapper.insertStore(store);
        Long storeId = store.getId();

        // 2. 지역 정보 삽입
        storeMapper.insertRegion(storeId, store.getRegion());

        // 3. 업종 정보 삽입
        IndustryDTO industryDTO = new IndustryDTO();
        industryDTO.setStoreId(storeId);
        industryDTO.setIndustry(store.getIndustry());
        
        storeMapper.insertIndustry(industryDTO);

        // 자동 생성된 industryId를 가져와서 설정
        Long industryId = industryDTO.getId();
        store.setIndustryId(industryId);
        
        // 4. 음식점, 카페, 술집 중 해당하는 세부 업종 삽입
        String subcategory = store.getSubcategory(); // subcategory 값 가져오기
        
        if (store.getIndustry().equals("음식점")) {
            storeMapper.insertRestaurant(industryId, storeId, subcategory);
        } else if (store.getIndustry().equals("카페")) {
            storeMapper.insertCafe(industryId, storeId, subcategory);
        } else if (store.getIndustry().equals("술집")) {
            storeMapper.insertBar(industryId, storeId, subcategory);
        }

        // 5. 테마 정보 삽입
        storeMapper.insertTheme(storeId, store.getTheme());
		
	}

}

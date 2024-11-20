package com.project.service;

import java.io.File;
import java.io.IOException;
import java.sql.Timestamp;
import java.util.Arrays;
import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.project.domain.Menu;
import com.project.domain.Store;
import com.project.dto.IndustryDTO;
import com.project.dto.MemberLike;
import com.project.dto.StoreWithLocationDTO;
import com.project.mapper.MenuMapper;
import com.project.mapper.StoreMapper;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class StoreService {

	private final StoreMapper storeMapper;
	private final MenuMapper menuMapper;

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
	public void registerStore(StoreWithLocationDTO store, List<MultipartFile> storePhotos, List<MultipartFile> menuPhotos) {
		// 1. storePhotos 처리 및 mainImage1, mainImage2 설정
		if (storePhotos != null && !storePhotos.isEmpty()) {
			String mainImage1Path = saveFile(storePhotos.get(0));
			store.setMainImage1(mainImage1Path);

			if (storePhotos.size() > 1) {
				String mainImage2Path = saveFile(storePhotos.get(1));
				store.setMainImage2(mainImage2Path);
			}
		}

		// 2. store 테이블 삽입 및 ID 생성
		storeMapper.insertStore(store);
		Long storeId = store.getId();

		// 3. 지역 정보 삽입
		storeMapper.insertRegion(storeId, store.getLocation());

		// 4. 업종 정보 삽입
		IndustryDTO industryDTO = new IndustryDTO();
		industryDTO.setStoreId(storeId);
		industryDTO.setIndustry(store.getIndustry());

		storeMapper.insertIndustry(industryDTO);

		// 자동 생성된 industryId를 가져와서 설정
		Long industryId = industryDTO.getId();
		store.setIndustryId(industryId);

		// 5. 음식점, 카페, 술집 중 해당하는 세부 업종 삽입
		String subcategory = store.getSubcategory(); // subcategory 값 가져오기

		if (store.getIndustry().equals("음식점")) {
			storeMapper.insertRestaurant(industryId, storeId, subcategory);
		} else if (store.getIndustry().equals("카페")) {
			storeMapper.insertCafe(industryId, storeId, subcategory);
		} else if (store.getIndustry().equals("술집")) {
			storeMapper.insertBar(industryId, storeId, subcategory);
		}

		// 6. 테마 정보 삽입
		storeMapper.insertTheme(storeId, store.getTheme());

		// 7. 메뉴 사진 처리 및 메뉴 정보 삽입
		if (menuPhotos != null && !menuPhotos.isEmpty()) {
			for (MultipartFile menuPhoto : menuPhotos) {
				String menuImagePath = saveFile(menuPhoto);

				// 메뉴 객체 생성 및 설정
				Menu menu = new Menu();
				menu.setStoreId(storeId); // 동일한 storeId로 저장
				menu.setMenuImage(menuImagePath);

				// 필요에 따라 추가 정보 설정
				menu.setMenuName("메뉴 이름"); // 필요 시 업데이트
				menu.setMenuDescription("메뉴 설명"); // 필요 시 업데이트
				menu.setMenuPrice("0"); // 필요 시 업데이트

				// 메뉴 정보 삽입
				menuMapper.insertMenu(menu);
			}
		}
	}

	// 파일 저장 메서드 추가
	private String saveFile(MultipartFile file) {
		String filePath = null;
	    String fileName = null;

	    if (file != null && !file.isEmpty()) {
	        // 경로 지정: 프로젝트 내부 static 폴더
	        String staticImagePath = new File("src/main/resources/static/images/store").getAbsolutePath();
	        fileName = System.currentTimeMillis() + "_" + file.getOriginalFilename();
	        filePath = staticImagePath + "/" + fileName;

	        File dest = new File(filePath);

	        try {
	            // 파일 저장
	            file.transferTo(dest);
	        } catch (IOException e) {
	            e.printStackTrace();
	        }
	    }

		return fileName;

	}

}

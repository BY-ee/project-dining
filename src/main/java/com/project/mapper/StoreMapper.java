package com.project.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.project.domain.Menu;
import com.project.domain.Store;
import com.project.dto.IndustryDTO;
import com.project.dto.MemberLike;
import com.project.dto.RequestData;
import com.project.dto.StoreDetailDTO;
import com.project.dto.StoreWithDetailDTO;
import com.project.dto.StoreWithLocationDTO;


@Mapper
public interface StoreMapper{
	
	// 가게정보 가져오기
    Store getStoreDetailById(long store_ID);
    
    // 가게 조회
    StoreDetailDTO selectStoreById(long id);
    
    // 메뉴정보 가져오기
    List<Menu> getMenuById(long storeId);
    
    // 가게 조회
	List<Store> selectStores(
			@Param("start") int start,
			@Param("end") int end, 
			@Param("requestData") RequestData requestData);

	// 게시 신청한 가게 목록 조회
	List<Store> selectEnrolledStores(
			@Param("start") int start,
			@Param("end") int end,
			@Param("requestData") RequestData requestData);
	
	// 테마를 제외한 가게 데이터
	StoreWithDetailDTO selectStoreWithDetailById(long id);
	
	// 메뉴 이미지 링크 조회
	List<String> selectMenuImagesById(long id);
	
	// 테마 조회
	List<String> selectThemesById(long id);
	
	// 총 가게 개수
	long countStores(RequestData requestData);

	// 게시 신청한 가게의 총 개수
	long countEnrolledStores(RequestData requestData);

	// 가게 게시글 게시중단
	void inactivateStore(long id);

	// 가게 게시글 재게시
	void reactivateStore(long id);
	
	// 게시글 검토
	void updateReadStatus(long id);
	
	// 게시글 승인
	void enrollStore(long id);
	
	// 게시글 반려
	void withdrawStore(long id);
	
	long countStores();

	// 찜 추가
	void save(MemberLike like);

	// 찜 취소
	void deleteByMemberIdAndStoreId(@Param("memberId") long memberId, @Param("storeId") long storeId);
	
	List<Store> getActiveStores();
	
    List<Store> findStoresByLocation(String location);

    // 찜 좋아요 수 가져오기
	Long getLikeCountByStoreId(@Param("storeId") Long storeId);

	// 특정 사용자가 특정 가게를 찜했는지 확인
	int isMemberLikedStore(@Param("storeId") Long storeId, @Param("memberId") Long memberId);

    List<Store> findStoresByFilters(
            @Param("location") String location,
            @Param("industry") String industry,
            @Param("subCategory") String subCategory,
            @Param("themeArray") List<String> themeArray
        );

    // 카테고리 가져오기
	List<StoreWithLocationDTO> getStoreCategory(long storeId);
    
    List<Store> findStoresByOrder(
            @Param("order") String order,
            @Param("location") String location,
            @Param("industry") String industry,
            @Param("subCategory") String subCategory,
            @Param("themeArray") List<String> themeArray
    );

    // store 테이블 삽입
    void insertStore(StoreWithLocationDTO store);

    // 지역 정보 삽입
    void insertRegion(@Param("storeId") Long storeId, @Param("location") String location);

    // 업종 정보 삽입
    void insertIndustry(IndustryDTO industryDTO);

    // 음식점 정보 삽입
    void insertRestaurant(@Param("industryId") Long industryId, @Param("storeId") Long storeId, @Param("subcategory") String subcategory);

    // 카페 정보 삽입
    void insertCafe(@Param("industryId") Long industryId, @Param("storeId") Long storeId, @Param("subcategory") String subcategory);

    // 술집 정보 삽입
    void insertBar(@Param("industryId") Long industryId, @Param("storeId") Long storeId, @Param("subcategory") String subcategory);

    // 테마 정보 삽입
    void insertTheme(@Param("storeId") Long storeId, @Param("theme") String theme);
}

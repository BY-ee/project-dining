package com.project.controller;

import java.util.List;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import com.project.domain.Menu;
import com.project.domain.Store;
import com.project.dto.MemberLike;
import com.project.service.StoreService;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;


@Controller
@RequiredArgsConstructor
public class StoreController {
    
	private final StoreService storeService;
	
	// 가게정보 불러오기
	@GetMapping("/storeDetail")
	public String getStoreDetail(@RequestParam("store_ID") long storeId,
			HttpSession session,
			Model model) {
		
		System.out.println("storeId: " + storeId);
		
		// 세션에서 user_ID 가져오기 (로그인하지 않은 경우 null일 수 있음)
		Long userId = (Long) session.getAttribute("user_ID");
		
		// userId가 null인 경우, 기본 값으로 설정하거나 예외 처리를 수행
	    if (userId == null) {
	        System.out.println("로그인하지 않은 사용자입니다.");
	    } else {
	        System.out.println("userId: " + userId);
	    }
		
		// 가게 및 메뉴 정보 가져오기
        Store storeDetail = storeService.getStoreDetailById(storeId);
        List<Menu> menuList = storeService.getMenuById(storeId);
        
        // 가게 카테고리값 가져오기
    	List<Store> categoryList = storeService.getStoreCategory(storeId);
    	
        System.out.println("category값:" + categoryList);
    	System.out.println("storeDetail값:"+ storeDetail);

        
        // 가게 이미지 경로 앞에 /img/를 붙이기
        if (storeDetail.getMainImage1() != null) {
            storeDetail.setMainImage1("/images/store/" + storeDetail.getMainImage1());
        }
        if (storeDetail.getMainImage2() != null) {
            storeDetail.setMainImage2("/images/store/" + storeDetail.getMainImage2());
        }

        // 각 메뉴의 이미지 경로에 "/img/" 추가
        for (Menu menu : menuList) {
            if (menu.getMenuImage() != null) {
                menu.setMenuImage("/images/store/" + menu.getMenuImage());
            }
        }

        // MemberLike DTO에 likeCount 설정
        MemberLike memberLike = new MemberLike();
        memberLike.setStoreId(storeId);
        if (userId != null) {
            memberLike.setMemberId(userId);
        }
        
        // 찜 좋아요 수 가져오기
        long likeCount = storeService.getLikeCountByStoreId(storeId); // DB에서 likeCount 가져오기
        memberLike.setLikeCount(likeCount);

        
		model.addAttribute("user_ID", userId);
		model.addAttribute("store_ID", storeId);
		model.addAttribute("storeDetail", storeDetail);
		model.addAttribute("menuList", menuList);
		model.addAttribute("memberLike", memberLike);
		model.addAttribute("categoryList", categoryList);
		
		return "store/store"; 
	}
	
	// 찜상태
	@GetMapping("/getLikeStatus")
	public ResponseEntity<MemberLike> getLikeStatus(@RequestParam("user_ID") Long memberId,
	                                                @RequestParam("store_ID") Long storeId) {
	    boolean isLiked = storeService.isMemberLikedStore(storeId, memberId);
	    long likeCount = storeService.getLikeCountByStoreId(storeId);
	    
	    // MemberLike 객체 생성 및 반환
	    MemberLike memberLike = new MemberLike();
	    memberLike.setStoreId(storeId);
	    memberLike.setMemberId(memberId);
	    memberLike.setLikeCount(likeCount);
	    memberLike.setLiked(isLiked);

	    return ResponseEntity.ok(memberLike);
	}

    // 찜기능
    @PostMapping("/likeStore")
    public ResponseEntity<?> likeStore(@RequestBody MemberLike memberLike) {
        
        boolean isLiked = memberLike.isLiked();

        // isLiked 상태에 따라 찜 추가 또는 삭제
        if (isLiked) {
            storeService.addLike(memberLike.getMemberId(), memberLike.getStoreId());
        } else {
            storeService.removeLike(memberLike.getMemberId(), memberLike.getStoreId());
        }

        // 업데이트된 찜 수 반환
        long updatedLikeCount = storeService.getLikeCountByStoreId(memberLike.getStoreId());
        memberLike.setLikeCount(updatedLikeCount);

        return ResponseEntity.ok(memberLike);
	}
	
}


    
// ============================================================================================    
    
//    @GetMapping("/store3")
//    public String store3(
//    		@RequestParam(value = "region", required = false) String region,
//    		@RequestParam(value = "category", required = false) String category,
//    		@RequestParam(value = "theme", required = false) String theme,
//    		@RequestParam(value = "storeName", required = false) String storeName,
//    		Model model) {
//    	
//    	model.addAttribute("region", region);
//    	model.addAttribute("category", category);
//    	model.addAttribute("theme", theme);
//    	model.addAttribute("storeName", storeName);
//    	
//    	return "store/store3"; // store3.jsp로 이동
//    }
    
    
// ===========================================================================================    
    
//    @RequestMapping("/login")
//    public String login() {	
//        return "login";
//    }
    
    
//    @RequestMapping("/businessJoin")
//    public String businessJoin() {
//    	return "businessJoin";
//    }


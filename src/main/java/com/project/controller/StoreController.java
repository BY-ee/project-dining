package com.project.controller;

import java.util.List;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.nimbusds.oauth2.sdk.Request;
import com.project.domain.MemberLike;
import com.project.domain.Menu;
import com.project.domain.StoreDomain;
import com.project.service.StoreService;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;


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
		
		// 가게 및 메뉴 정보 가져오기
        StoreDomain storeDetail = storeService.getStoreDetailById(storeId);
        List<Menu> menuList = storeService.getMenuById(storeId);
        
        System.out.println("storeDetail값:"+ storeDetail);

        // 가게 이미지 경로 앞에 /img/를 붙이기
        if (storeDetail.getMainImage1() != null) {
            storeDetail.setMainImage1("/img/" + storeDetail.getMainImage1());
        }
        if (storeDetail.getMainImage2() != null) {
            storeDetail.setMainImage2("/img/" + storeDetail.getMainImage2());
        }

        // 각 메뉴의 이미지 경로에 "/img/" 추가
        for (Menu menu : menuList) {
            if (menu.getMenuImage() != null) {
                menu.setMenuImage("/img/" + menu.getMenuImage());
            }
        }
		
		model.addAttribute("user_ID", userId);
		model.addAttribute("store_ID", storeId);
		model.addAttribute("storeDetail", storeDetail);
		model.addAttribute("menuList", menuList);
		
		return "store/store"; 
	}
	
	// 찜기능
	@PostMapping("/likeStore")
	public ResponseEntity<?> likekStore(@RequestBody MemberLike memberlike) {
		
		boolean isLiked = memberlike.isLiked();
		
		// 이미 좋아요가 되어있으면 삭제, 아니면 추가
		if (isLiked) {
			storeService.addLike(memberlike.getMemberId(), memberlike.getStoreId());
		} else {
			storeService.removeLike(memberlike.getMemberId(), memberlike.getStoreId());
		}
		
		return ResponseEntity.ok().body("찜 상태가 변경되었습니다.");
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


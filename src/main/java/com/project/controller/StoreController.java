package com.project.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.project.domain.Menu;
import com.project.domain.StoreDomain;
import com.project.service.StoreService;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class StoreController {
    
	private final StoreService storeService;
	
	@GetMapping("/storeDetail")
	public String getStoreDetail(@RequestParam("store_ID") int storeId,
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
		
		// user_ID를 모델에 추가 (필요한 경우)
		model.addAttribute("user_ID", userId);
		model.addAttribute("store_ID", storeId);
		model.addAttribute("storeDetail", storeDetail);
		model.addAttribute("menuList", menuList);
		
		return "store/store"; 
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


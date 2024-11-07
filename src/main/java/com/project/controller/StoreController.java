package com.project.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

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
		
		// StoreService를 통해 가게 상세 정보 가져오기
		StoreDomain storeDetail = storeService.getStoreDetailById(storeId);
		
		// 세션에서 user_ID 가져오기 (로그인하지 않은 경우 null일 수 있음)
		String userId = (String) session.getAttribute("user_ID");        
		
		// user_ID를 모델에 추가 (필요한 경우)
		model.addAttribute("user_ID", userId);
		model.addAttribute("store_ID", storeId);
		model.addAttribute("storeDetail", storeDetail);
		
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


package com.project.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.project.domain.StoreDomain;
import com.project.service.StoreService;

@Controller
public class StoreController {
	
    @Autowired
    private StoreService storeService;
    
//    @RequestMapping("/")
//    public String home() {
//        return "home";
//    }
    
    @RequestMapping("store")
    public String store() {
    	return "store/store";
    }
    
    @GetMapping("/store2")
    public String store2(
        @RequestParam(value = "region", required = false) String region,
        @RequestParam(value = "category", required = false) String category,
        @RequestParam(value = "theme", required = false) String theme,
        @RequestParam(value = "storeName", required = false) String storeName,
        Model model) {
        
        model.addAttribute("region", region);
        model.addAttribute("category", category);
        model.addAttribute("theme", theme);
        model.addAttribute("storeName", storeName);
        
        return "store/store2"; // store2.jsp로 이동
    }
    
    
    @GetMapping("/storeDetail")
    public String getStoreDetail(@RequestParam("store_ID") int storeId,
                                 @RequestParam("user_ID") int userId, // user_ID를 받음
                                 Model model) {
        // StoreService를 통해 가게 상세 정보 가져오기
        StoreDomain storeDetail = storeService.getStoreDetailById(storeId);
        
        // user_ID를 모델에 추가 (필요한 경우)
        model.addAttribute("user_ID", userId);
        model.addAttribute("store_ID", storeId);
        model.addAttribute("storeDetail", storeDetail);
        
        return "/store/store3"; // 가게 상세 페이지로 이동
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
}

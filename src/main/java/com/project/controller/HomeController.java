package com.project.controller;

import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.oauth2.core.user.OAuth2User;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.project.service.StoreService;
import com.project.domain.Store;

import java.net.URLDecoder;
import java.nio.charset.StandardCharsets;

import java.util.List;

@Controller
public class HomeController {
	
    private final StoreService storeService;

    public HomeController(StoreService storeService) {
        this.storeService = storeService;
    }
    
    @GetMapping("/")
    public String home(Model model) {
        List<Store> stores = storeService.findAllStores(); // 모든 가게 목록을 가져옴
        model.addAttribute("stores", stores); // 모델에 stores 속성으로 추가
        System.out.println("Number of stores found in first home: " + stores.size());
        return "home/home-category";
    }
    
    @GetMapping("/storesByLocation")
    @ResponseBody 
    public List<Store> getStoresByLocation(@RequestParam("location") String location) {
        try {
            location = URLDecoder.decode(location, StandardCharsets.UTF_8.toString());
            System.out.println("Decoded location in Controller: " + location);
            
            List<Store> stores = storeService.findStoresByLocation(location);
            System.out.println("Number of stores found: " + stores.size()); // 결과 개수 출력
            return stores;
        } catch (Exception e) {
            System.err.println("URL decoding error: " + e.getMessage());
            return List.of(); // 오류 발생 시 빈 리스트 반환
        }
    }
    
    @GetMapping("/storesByCategory")
    public ResponseEntity<List<Store>> getStoresByCategory(
            @RequestParam(value = "location", required = false) String location,
            @RequestParam(value = "industry", required = false) String industry,
            @RequestParam(value = "subCategory", required = false) String subCategory,
            @RequestParam(value = "theme", required = false) String theme) {
    	
    	

        // theme 값을 split하여 배열로 변환
        String[] themeArray = (theme != null && !theme.isEmpty()) ? theme.split(",") : new String[0];
        
        System.out.println("사용자 선택 필터 값 - Location: " + location +
                ", Industry: " + industry +
                ", SubCategory: " + subCategory +
                ", Themes: " + themeArray);

        // 필터링 로직
        List<Store> filteredStores = storeService.getStoresByFilters(location, industry, subCategory, themeArray);

        return ResponseEntity.ok(filteredStores);
    }
    		

    @GetMapping("/csr")
    public String csr() {
    	return "home/csr";
    }
    
    
    @GetMapping("/terms")
    public String terms() {
    	return "home/terms";
    }
    
    @GetMapping("/emailInquery")
    public String emailInquery() {
    	return "home/emailInquery";
    }
    
    @GetMapping("/storeRegistration")
    public String storeRegistration() {
    	return "home/storeRegistration";
    }
    
//    @GetMapping("/myPage")
//    public String myPage(@AuthenticationPrincipal OAuth2User oauth2User) {
//    	if(oauth2User!=null) System.out.println("User Attributes: " + oauth2User.getAttributes());
//    	return "mypage/myPage";
//    }

}
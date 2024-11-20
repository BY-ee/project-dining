package com.project.controller;

import java.net.URLDecoder;
import java.nio.charset.StandardCharsets;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.project.domain.Store;
import com.project.dto.CustomUserDetails;
import com.project.dto.StoreWithLocationDTO;
import com.project.service.StoreService;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class HomeController {
	
    private final StoreService storeService;
    
    private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
    
    @GetMapping("/")
    public String home(@AuthenticationPrincipal CustomUserDetails userDetails, Model model) {
    	// Spring Security가 관리하는 세션 데이터를 가져옴 (매개변수로 주입)
//        if (userDetails != null) {
//            String id = userDetails.getUsername();
//            String role = userDetails.getAuthorities().iterator().next().getAuthority();
//            model.addAttribute("id", id);
//            model.addAttribute("role", role);
//        } else {
//        	// 로그인되어 있지 않으면 id, role 데이터를 임의로 클라이언트에게 전송
//            model.addAttribute("id", "anonymousUser");
//            model.addAttribute("role", "ROLE_ANONYMOUS");
//        }
        
        List<Store> stores = storeService.getActiveStores(); // 모든 가게 목록을 가져옴
        model.addAttribute("stores", stores); // 모델에 stores 속성으로 추가
        logger.debug("(HomeController) 가게 수: {}", stores.size());
        return "home/homeCategory";
    }
    
    @GetMapping("/storesByLocation")
    @ResponseBody 
    public List<Store> getStoresByLocation(@RequestParam("location") String location) {
        try {
            location = URLDecoder.decode(location, StandardCharsets.UTF_8.toString());
            logger.debug("(HomeController) 디코딩된 장소명: {}", location);

            List<Store> stores;
            if (location.isEmpty()) {
                // location이 빈 문자열일 경우 모든 가게를 조회
                stores = storeService.getActiveStores();
            } else {
                // 특정 지역 가게 조회
                stores = storeService.findStoresByLocation(location);
            }

            logger.debug("(HomeController) 가게 개수: {}", stores.size()); // 결과 개수 출력
            return stores;
        } catch (Exception e) {
            logger.info("(HomeController) URL 디코딩 에러: {}", e.getMessage());
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
        
        logger.info("사용자 선택 필터 값 - Location: {}, Industry: {}, SubCategory: {}, Themes: {}",
        		location, industry, subCategory, themeArray);

        // 필터링 로직
        List<Store> filteredStores = storeService.getStoresByFilters(location, industry, subCategory, themeArray);

        return ResponseEntity.ok(filteredStores);
    }
    
    @GetMapping("/storeOrdering")
    @ResponseBody
    public List<Store> orderStores(@RequestParam(value = "order") String order,
                                   @RequestParam(value = "location", required = false) String location,
                                   @RequestParam(value = "industry", required = false) String industry,
                                   @RequestParam(value = "subCategory", required = false) String subCategory,
                                   @RequestParam(value = "theme", required = false) String theme) {
        // theme 값을 split하여 배열로 변환
        String[] themeArray = (theme != null && !theme.isEmpty()) ? theme.split(",") : new String[0];
        
        System.out.println("정렬 기준: " + order);
        System.out.println("필터 조건 - Location: " + location +
                ", Industry: " + industry +
                ", SubCategory: " + subCategory +
                ", Themes: " + String.join(", ", themeArray));
        
        // 필터링과 정렬된 결과를 반환
        return storeService.getStoresByOrder(order, location, industry, subCategory, themeArray);
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
    public String storeRegistration(@AuthenticationPrincipal CustomUserDetails userDetails,
    								@ModelAttribute StoreWithLocationDTO store) {
    	
    	if (userDetails == null) {
    		throw new AccessDeniedException("로그인 후 접근 가능합니다.");
    	}
    	
    	try {
    		store.setMemberId(userDetails.getId());
    	}catch(Exception e) {
    		e.printStackTrace();
    	}
    	return "home/storeRegistration";
    }
    
    @PostMapping("/registerStore")    	
    public String registerStore(@AuthenticationPrincipal CustomUserDetails userDetails,
                                @ModelAttribute StoreWithLocationDTO store,
    							@RequestParam("storePhotos") List<MultipartFile> storePhotos,
    							@RequestParam("menuPhotos") List<MultipartFile> menuPhotos,
    							Model model) {
    	
    	try {
            // Service 호출하여 여러 테이블에 데이터 저장
            store.setMemberId(userDetails.getId());
    		storeService.registerStore(store, storePhotos, menuPhotos);
    		
            // 성공 메시지 전달
            model.addAttribute("message", "가게 등록이 완료되었습니다.");
            return "home/success";
        } catch (Exception e) {
        	e.printStackTrace();
            // 에러 처리
            model.addAttribute("message", e.getMessage());
            return "home/errorPage";
        }
        
    }
    
}
package com.project.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class ProjectController {
    
    @RequestMapping("/")
    public String home() {
        return "home";
    }
    
    @RequestMapping("store")
    public String store() {
    	return "store";
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
        
        return "store2"; // store2.jsp로 이동
    }
    @GetMapping("/store3")
    public String store3(
    		@RequestParam(value = "region", required = false) String region,
    		@RequestParam(value = "category", required = false) String category,
    		@RequestParam(value = "theme", required = false) String theme,
    		@RequestParam(value = "storeName", required = false) String storeName,
    		Model model) {
    	
    	model.addAttribute("region", region);
    	model.addAttribute("category", category);
    	model.addAttribute("theme", theme);
    	model.addAttribute("storeName", storeName);
    	
    	return "store3"; // store3.jsp로 이동
    }
    
    @RequestMapping("/login")
    public String login() {
        return "login";
    }
    
    
    @RequestMapping("/businessJoin")
    public String businessJoin() {
    	return "businessJoin";
    }
}

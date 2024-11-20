package com.project.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.oauth2.core.user.OAuth2User;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import com.project.domain.Member;
import com.project.service.MypageService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@RestController
@RequiredArgsConstructor
public class RedirectController {
	
	@PostMapping("/setRedirectUrl")
    public void setRedirectUrl(@RequestBody Map<String, String> payload, HttpServletRequest request) {
		System.out.println("payload 내용: " + payload);
		System.out.println("setRedirectUrl 의 redirectUrl = " + payload.get("redirectUrl"));
        request.getSession().setAttribute("redirectUrl", payload.get("redirectUrl"));
        request.getSession().setAttribute("socialName", payload.get("socialName"));
    }
}

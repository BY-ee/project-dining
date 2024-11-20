package com.project.controller;

import java.util.Map;

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import jakarta.servlet.http.HttpServletRequest;
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

package com.project.controller;

import java.util.Map;

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import jakarta.servlet.http.HttpServletRequest;

@RestController
public class RedirectController {
	@PostMapping("/setRedirectUrl")
    public void setRedirectUrl(@RequestBody Map<String, String> payload, HttpServletRequest request) {
        String redirectUrl = payload.get("redirectUrl");
        request.getSession().setAttribute("redirectUrl", redirectUrl);
    }
}

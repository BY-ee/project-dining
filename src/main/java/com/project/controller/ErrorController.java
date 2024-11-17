package com.project.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class ErrorController {
	// 접근 제한 페이지
	@GetMapping("/accessDenied")
	public String errorPage() {
		return "error/accessDenied";
	}
}
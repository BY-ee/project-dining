package com.project.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/error")
public class ErrorController {
	// 접근 제한 페이지
	@GetMapping("/403")
	public String forbidden() {
		return "error/forbidden";
	}
}
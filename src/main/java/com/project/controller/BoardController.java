package com.project.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class BoardController {

	@GetMapping("/noticeList")
	public String noticeList() {
		return "board/noticeList";
	}
	
	@GetMapping("/notice")
	public String notice() {
		return "board/notice";
	}
	
	@GetMapping("/eventList")
	public String eventList() {
		return "board/eventList";
	}
	
	@GetMapping("/event")
	public String event() {
		return "board/event";
	}
}

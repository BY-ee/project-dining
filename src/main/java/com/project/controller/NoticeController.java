package com.project.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class NoticeController {

	@GetMapping("/noticeList")
	public String noticeList() {
		return "notice/noticeList";
	}
	
	@GetMapping("/notice")
	public String notice() {
		return "notice/notice";
	}
	
	@GetMapping("/eventList")
	public String eventList() {
		return "notice/eventList";
	}
	
	@GetMapping("/event")
	public String event() {
		return "notice/event";
	}
}

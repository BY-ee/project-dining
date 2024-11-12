package com.project.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.project.domain.NoticePageRequest;
import com.project.domain.NoticePageResponse;
import com.project.service.NoticeService;

@Controller
public class NoticeController {
	@Autowired
	NoticeService noticeService;

	@GetMapping("/noticeList")
	public String noticeList(Model model, NoticePageRequest noticePageRequest) {
		NoticePageResponse noticePageResponse = noticeService.getNoticeList(noticePageRequest);
		model.addAttribute("noticePageResponse",noticePageResponse);
		return "notice/noticeList";
	}
	
	@GetMapping("/notice")
	public String notice() {
		return "notice/notice";
	}
	
	@GetMapping("/eventOnList")
	public String eventList() {
		return "notice/eventOnList";
	}
	
	@GetMapping("/eventOffList")
	public String eventOffList() {
		return "notice/eventOffList";
	}
	
	@GetMapping("/event")
	public String event() {
		return "notice/event";
	}
}

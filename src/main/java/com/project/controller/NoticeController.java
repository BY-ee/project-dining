package com.project.controller;

import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.project.domain.Event;
import com.project.domain.Notice;
import com.project.domain.PageRequest;
import com.project.domain.PageResponse;
import com.project.service.NoticeService;

@Controller
public class NoticeController {
	@Autowired
	NoticeService noticeService;

	@GetMapping("/noticeList")
	public String noticeList(Model model, PageRequest noticePageRequest) {
		PageResponse<Notice> noticePageResponse = noticeService.getNoticeList(noticePageRequest);
		model.addAttribute("noticePageResponse",noticePageResponse);
		return "notice/noticeList";
	}
	
	@GetMapping("/notice")
	public String notice() {
		return "notice/notice";
	}
	
	@GetMapping("/eventOnList")
	public String eventList(Model model, PageRequest eventPageRequest) {
		PageResponse<Event> eventPageResponse = noticeService.getEventOnList(eventPageRequest);
		model.addAttribute("eventPageResponse",eventPageResponse);
		return "notice/eventOnList";
	}
	
	@GetMapping("/eventOffList")
	public String eventOffList(Model model,PageRequest eventPageRequest) {
		eventPageRequest.setStatus("deleted");
		PageResponse<Event> eventPageResponse = noticeService.getEventOnList(eventPageRequest);
		model.addAttribute("eventPageResponse",eventPageResponse);
		return "notice/eventOffList";
	}
	
	@GetMapping("/event")
	public String event() {
		return "notice/event";
	}
}

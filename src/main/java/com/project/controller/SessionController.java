package com.project.controller;

import org.springframework.web.bind.annotation.ControllerAdvice;

// 컨트롤러의 공통 동작을 분리해서 각 요청마다 해당 로직을 실행하도록 하는 애노테이션
@ControllerAdvice
public class SessionController {
	/*
	 * @ModelAttribute public void addAttributes(Model
	 * model, @AuthenticationPrincipal CustomUserDetails userDetails) {
	 * System.out.println("ㅇㅇㅇㅇㅇㅇㅇㅇ"); if (userDetails != null) { Member member =
	 * userDetails.getMember(); model.addAttribute(member); } else {
	 * System.out.println("ㅇㅇ널"); model.addAttribute("id", "anonymousUser");
	 * model.addAttribute("role", "ROLE_ANONYMOUS"); } }
	 */
}

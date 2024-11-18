package com.project.controller;

import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ModelAttribute;

import com.project.domain.Member;
import com.project.dto.CustomUserDetails;

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

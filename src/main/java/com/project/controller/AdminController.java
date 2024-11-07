package com.project.controller;

import java.util.List;


import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.domain.Member;
import com.project.domain.Menu;
import com.project.domain.NoticeDomain;
import com.project.domain.Review;
import com.project.domain.Store;
import com.project.service.AdminService;

import lombok.RequiredArgsConstructor;

/*
 * @Controller
 * 
 * @RequiredArgsConstructor
 * 
 * @RequestMapping("/admin") public class AdminController { private final
 * AdminService adminService;
 * 
 * // 회원관리 페이지
 * 
 * @GetMapping("/members") public String members(@RequestParam(value="page",
 * defaultValue = "1") int page, Model model) { int limit = 10; List<Member>
 * members = adminService.selectMembers(page, limit);
 * model.addAttribute("members", members);
 * 
 * return "admin/adminMembers"; }
 * 
 * // 회원 상세정보 출력
 * 
 * @GetMapping("/members/{id}")
 * 
 * @ResponseBody public Member memberDetail(@PathVariable("id") long id) {
 * return adminService.selectMember(id); }
 * 
 * // 게시글 관리 페이지
 * 
 * @GetMapping("/posts") public String posts(@RequestParam(value="page",
 * defaultValue = "1") int page, Model model) { int limit = 10; List<Store>
 * stores = adminService.selectStores(page, limit); model.addAttribute("stores",
 * stores);
 * 
 * return "admin/adminPosts"; }
 * 
 * // 메뉴 조회
 * 
 * @GetMapping("/menus/{storeId}")
 * 
 * @ResponseBody public List<Menu> selectMenus(@PathVariable("storeId") long
 * storeId) { return adminService.selectMenus(storeId); }
 * 
 * // 리뷰 관리 페이지
 * 
 * @GetMapping("/reviews") public String reviews(@RequestParam(value="page",
 * defaultValue = "1") int page, Model model) { int limit = 10; //List<Review>
 * reviews = adminService.selectReviews(page, limit);
 * //model.addAttribute("reviews", reviews);
 * 
 * return "admin/adminReviews"; }
 * 
 * // 게시글 승인 페이지
 * 
 * @GetMapping("/approve") public String approve() { return
 * "admin/adminApprove"; }
 * 
 * // 공지사항 관리 페이지
 * 
 * @GetMapping("/notice") public String notice() { return "admin/adminNotice"; }
 * 
 * // 공지사항 상세 페이지
 * 
 * @GetMapping("/notice/id") public String noticeDetail() { return
 * "admin/adminNoticeDetail"; }
 * 
 * // 공지사항 작성폼 페이지
 * 
 * @GetMapping("/notice/write") public String noticeForm() { return
 * "admin/adminNoticeWrite"; }
 * 
 * // 공지사항 작성
 * 
 * @PostMapping("/notice/write")
 * 
 * @ResponseBody public String writeNotice(@RequestBody NoticeDomain notice) {
 * adminService.insertNotice(notice); return "admin/adminNotice"; }
 * 
 * // 공지사항 수정폼 페이지
 * 
 * @GetMapping("/notice/edit/id") public String editNoticePage() { return
 * "admin/adminNoticeEdit"; }
 * 
 * // 공지사항 수정
 * 
 * @PostMapping("/notice/edit") public String EditNotice() { return
 * "admin/adminNotice"; } }
 */
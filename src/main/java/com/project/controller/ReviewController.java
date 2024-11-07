package com.project.controller;

import java.sql.Timestamp;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.domain.ReviewDomain;
import com.project.service.ReviewService;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class ReviewController {

    private final ReviewService reviewService;

    @RequestMapping("/getReviews")
    @ResponseBody
    public List<ReviewDomain> getReviews(@RequestParam("store_id") int storeId) {
        return reviewService.getReviewsByStoreId(storeId);
    }

    @PostMapping("/submitReview")
    public String submitReview(
            @RequestParam("storeId") int storeId,
            @RequestParam("score") double score,
            @RequestParam("content") String content,
            HttpSession session,
            Model model) {

        // 세션에서 user_ID 가져오기
        Long memberId = (Long) session.getAttribute("user_ID");

        // 디버깅용 출력
        System.out.println("submitReview 메서드에서 가져온 memberId: " + memberId);

        if (memberId == null) {
            // 로그인되지 않은 경우 로그인 페이지로 리다이렉트
            return "redirect:/loginForm.do";
        }

        // ReviewDomain 객체 생성 및 값 설정
        ReviewDomain newReview = new ReviewDomain();
        newReview.setMember_id(memberId);
        newReview.setStore_id(storeId);
        newReview.setScore(score);
        newReview.setContent(content);
        newReview.setCreated_at(new Timestamp(System.currentTimeMillis())); // 현재 시간 설정

        // 리뷰 저장
        reviewService.insertReview(newReview);

        // 다시 원래 페이지로 리디렉션
        return "redirect:/storeDetail?store_ID=" + storeId;
    }
}
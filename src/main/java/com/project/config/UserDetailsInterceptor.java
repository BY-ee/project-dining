package com.project.config;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import com.project.domain.Member;
import com.project.dto.CustomUserDetails;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Component
public class UserDetailsInterceptor implements HandlerInterceptor {
	private static final Logger logger = LoggerFactory.getLogger(UserDetailsInterceptor.class);

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) {
        // 컨트롤러로 요청이 가기 전에 실행됩니다.
        return true; // 다음 핸들러로 요청을 전달
    }

    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) {
        if (modelAndView != null) {
            // SecurityContext에서 현재 사용자 정보 가져오기
            Authentication authentication = SecurityContextHolder.getContext().getAuthentication();

            if (authentication != null && authentication.isAuthenticated() && !(authentication.getPrincipal() instanceof String)) {
                // CustomUserDetails 객체 가져오기
                CustomUserDetails userDetails = (CustomUserDetails) authentication.getPrincipal();
                modelAndView.addObject("sessionMember", userDetails.getMember());
                logger.debug("(UserDetailsInterceptor) 인증된 유저: {}", userDetails.getMember().getMemberId());
            } else {
                // 비인증 사용자의 경우 기본값 설정
                Member anonymousMember = new Member();
                anonymousMember.setMemberId("anonymousUser");
                anonymousMember.setRole("ROLE_ANONYMOUS");
                modelAndView.addObject("sessionMember", anonymousMember);
                logger.debug("(UserDetailsInterceptor) 인증되지 않은 유저: anonymousUser");
            }
        }
    }

    @Override
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) {
        // 요청 완료 후 실행됩니다.
    }
}


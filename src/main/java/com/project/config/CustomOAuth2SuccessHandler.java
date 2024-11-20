//package com.project.config;
//
//import java.io.IOException;
//
//import org.slf4j.Logger;
//import org.slf4j.LoggerFactory;
//import org.springframework.security.core.Authentication;
//import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
//import org.springframework.stereotype.Component;
//
//import com.project.dto.CustomUserDetails;
//
//import jakarta.servlet.ServletException;
//import jakarta.servlet.http.HttpServletRequest;
//import jakarta.servlet.http.HttpServletResponse;
//
//@Component
//public class CustomOAuth2SuccessHandler implements AuthenticationSuccessHandler {
//
//    private final Logger logger = LoggerFactory.getLogger(CustomOAuth2SuccessHandler.class);
//
//    @Override
//    public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
//                                        Authentication authentication) throws IOException, ServletException {
//        
//    	// 사용자 정보 로깅
//        CustomUserDetails userDetails = (CustomUserDetails) authentication.getPrincipal();
//        logger.info("OAuth2 로그인 성공: {}", userDetails.getUsername());
//
//        String redirectUrl = (String) request.getSession().getAttribute("redirectUrl");
//        
//        // 사용자의 Role에 따라 리다이렉트
//        if (userDetails.getAuthorities().stream()
//                .anyMatch(auth -> auth
//                		.getAuthority()
//                		.equals("ROLE_ADMIN"))) {
//            redirectUrl = "/admin/members";
//        }
//
//        // 이전 페이지로 리다이렉트 (없으면 기본 URL로 이동)
//        String prevPage = (String) request.getSession().getAttribute("prevPage");
//        if (prevPage != null) {
//            redirectUrl = prevPage;
//            request.getSession().removeAttribute("prevPage");
//        }
//        
//        
//        response.sendRedirect(redirectUrl);
//    }
//}

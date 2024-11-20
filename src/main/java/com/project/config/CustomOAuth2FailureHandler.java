package com.project.config;

import java.io.IOException;
import java.net.URLEncoder;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;
import org.springframework.stereotype.Component;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Component
public class CustomOAuth2FailureHandler implements AuthenticationFailureHandler {

    private final Logger logger = LoggerFactory.getLogger(CustomOAuth2FailureHandler.class);

    @Override
    public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response,
                                        AuthenticationException exception) throws IOException, ServletException {
        // 실패 원인 로깅
        logger.error("OAuth2 로그인 실패: {}", exception.getMessage());

        // 실패 메시지를 쿼리 파라미터로 전달
        String errorMessage = "FailureLogin";
        if (exception.getMessage().contains("Bad credentials")) {
            errorMessage = "BadCredentials";
        }
        
        if ("해당 이메일은 이미 다른 계정에 연동되어 있습니다.".equals(exception.getMessage())) {
            response.sendRedirect("/account?error=" + URLEncoder.encode(exception.getMessage(), "UTF-8").replaceAll("\\+", "%20"));
        }else response.sendRedirect("/login?error=" + errorMessage);
    }
}

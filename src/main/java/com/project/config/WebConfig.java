package com.project.config;

import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

//@Configuration
public class WebConfig implements WebMvcConfigurer {

    private final UserDetailsInterceptor userDetailsInterceptor;

    public WebConfig(UserDetailsInterceptor userDetailsInterceptor) {
        this.userDetailsInterceptor = userDetailsInterceptor;
    }

    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor(userDetailsInterceptor)
                .addPathPatterns("/**") // 모든 경로에 대해 적용
                .excludePathPatterns("/static/**", "/error"); // 정적 리소스와 에러 페이지는 제외
    }
}

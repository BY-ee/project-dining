package com.project.security;

import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Configuration;

import lombok.Getter;
import lombok.Setter;

  @Configuration
  
  @ConfigurationProperties(prefix = "naver.client")
  
  @Getter
  
  @Setter public class Api {
  
  // Naver 간편 로그인 API Key private String naverLoginClientKey; // clientId
  private String naverLoginSecret; // clientSecret
  
  
  }
 
package com.project.controller;

import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestTemplate;
@RestController
@RequestMapping("/proxy")
public class ProxyController {

    @PostMapping("/nts-businessman")
    public ResponseEntity<?> forwardRequest(@RequestBody String requestData) {
        String url = "https://api.odcloud.kr/api/nts-businessman/v1/status?serviceKey=rRihs6JnqaaYkUbbfStMwMCA6AwVuUPm/NHIPgwNuVAITcLYj6AVaZbN7KCeTwzLzca2qEQKBG7YXSpsEXXkRg==";

        System.out.println("Received Request Data: " + requestData); // 요청 데이터 로깅

        RestTemplate restTemplate = new RestTemplate();
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);

        HttpEntity<String> entity = new HttpEntity<>(requestData, headers);

        try {
            ResponseEntity<String> response = restTemplate.exchange(url, HttpMethod.POST, entity, String.class);
            System.out.println("External API Response: " + response.getBody()); // 응답 데이터 로깅
            return ResponseEntity.status(response.getStatusCode()).body(response.getBody());
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(500).body("Internal Server Error: " + e.getMessage());
        }
    }
}
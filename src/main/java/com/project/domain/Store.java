package com.project.domain;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Data
@Alias("store")
public class Store {
    private Long id;
    private Long memberId;
    private String storeName;
    private String address;
    private String detailAddress;
    private String tel;
    private String phoneNumber;
    private String mainImage1;
    private String mainImage2;
    private Double latitude;
    private Double longitude;
    private Integer views;
    private String openTime;
    private String storeDescription;
    private String postStatus;
    private String enrollStatus;
    
    private String region; // 지역
    private String industry; // 업종
    private String restaurant; // 음식점
    private String cafe; // 카페
    private String bar; // 술집
    private String theme; // 테마
}

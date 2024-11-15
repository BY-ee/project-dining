package com.project.dto;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Data
@Alias("storeWithLocationDTO")
public class StoreWithLocationDTO {

    private Long id; // STORE의 고유 ID
    private Long memberId; // MEMBER_ID, 사용자 ID를 참조
    private String storeName; // STORE_NAME, 가게 이름
    private String address; // ADDRESS, 가게 주소
    private String detailAddress; // DETAIL_ADDRESS, 상세 주소
    private String tel; // TEL, 전화번호
    private String phoneNumber; // PHONE_NUMBER, 휴대폰 번호
    private String mainImage1; // MAIN_IMAGE1, 메인 이미지 1
    private String mainImage2; // MAIN_IMAGE2, 메인 이미지 2
    private Double latitude; // LATITUDE, 위도
    private Double longitude; // LONGITUDE, 경도
    private Integer views; // VIEWS, 조회수
    private String openTime; // OPEN_TIME, 오픈 시간
    private String storeDescription; // STORE_DESCRIPTION, 가게 설명
    private String postStatus; // POST_STATUS, 게시 상태
    private String enrollStatus; // ENROLL_STATUS, 등록 상태
    private String location; // 지역 정보

}
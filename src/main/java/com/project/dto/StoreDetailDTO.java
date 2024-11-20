package com.project.dto;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Data
@Alias("storeDetailDTO")
public class StoreDetailDTO {
	// Store
    private Long id;
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
    private String ceoName;

    // Menu
	public String menuImage;
	public String menuDescription;
	public String menuName;
	public String menuPrice;
}

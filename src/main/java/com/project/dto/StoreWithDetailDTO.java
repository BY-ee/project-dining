package com.project.dto;

import java.util.List;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Data
@Alias("storeWithDetailDTO")
public class StoreWithDetailDTO {
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
    
    // Local
    private String local;
    
    // Industry
    private String industry;
    
    // Theme
    private List<String> themes;
  
}

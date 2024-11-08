package com.project.domain;

import java.math.BigDecimal;

import org.apache.ibatis.type.Alias;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Alias("Store")
public class Store {

    private Long id;
    private String storeName;
    private String address;
    private String detailAddress;
    private String phoneNumber;
    private String ownerPhoneNumber;
    private String mainImage1;
    private String mainImage2;
    private BigDecimal latitude;
    private BigDecimal longitude;
    private Integer views;
    private String openTime;
    private String storeDescription;
}

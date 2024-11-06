package com.project.domain;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Data
@Alias("storeDatail")
public class StoreDomain {

	private int id;
    private String store_name;
    private String address;
    private String detail_address;
    private String phone_number;
    private String oner_phone_number;
    private String main_image_1;
    private String main_image_2;
    private double latitude;
    private double longitude;
    private int views;
    private String open_time;
    private String store_desciption;
}

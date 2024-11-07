package com.project.domain;

import java.util.Date;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Data
@Alias("login")
public class LoginDomain {

    private Long id;
    private String category;
    private String registration_number;
    private String member_id;
    private String naver_id;
    private String google_id;
    private String kakao_id;
    private String passwd;
    private String nickname;
    private String introduction;
    private String email;
    private String status;
    private Date created_at;
    private Date inactive_date;
    private Date reactive_date;
    private Date deleted_date;
    private String profile_image;
    private Integer point;
}
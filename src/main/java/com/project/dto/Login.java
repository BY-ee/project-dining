package com.project.dto;

import java.util.Date;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Data
@Alias("login")
public class Login {
    private Long id;
    private String category;
    private String registrationNumber;
    private String memberId;
    private String naverId;
    private String googleId;
    private String kakaoId;
    private String passwd;
    private String nickname;
    private String introduction;
    private String email;
    private String status;
    private Date createdAt;
    private Date inactiveDate;
    private Date reactiveDate;
    private Date deletedDate;
    private String profileImage;
    private int age;
    private String residence;
    private String mbti;
    private String role;
    
    // 비밀번호 체크
    private String passwdCheck;
    private String mailid;
    private String domain;
}


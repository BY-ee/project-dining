package com.project.domain;

import java.util.Date;
import org.apache.ibatis.type.Alias;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Alias("member")
public class Member {
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
}

package com.project.domain;

import java.sql.Timestamp;

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
    private Timestamp createdAt;
    private Timestamp inactiveDate;
    private Timestamp reactiveDate;
    private Timestamp deletedDate;
    private String profileImage;
}

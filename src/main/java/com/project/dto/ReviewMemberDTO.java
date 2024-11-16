package com.project.dto;

import java.sql.Timestamp;

import org.apache.ibatis.type.Alias;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Alias("reviewMemberDTO")
public class ReviewMemberDTO {
    private Long reviewId;
    private long memberId;
    private long storeId;
    private double score;
    private String content;
    private Timestamp createdAt;
    private String reviewImage;
    private String reviewStatus;
    private String category;
    private String registrationNumber;
    private String naverId;
    private String googleId;
    private String kakaoId;
    private String passwd;
    private String nickname;
    private String introduction;
    private String email;
    private String memberStatus;
    private Timestamp inactiveDate;
    private Timestamp reactiveDate;
    private Timestamp deletedDate;
    private String profileImage;
    private Integer point;
}

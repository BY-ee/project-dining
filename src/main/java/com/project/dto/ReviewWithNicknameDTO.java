package com.project.dto;

import java.sql.Timestamp;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Data
@Alias("reviewWithNicknameDTO")
public class ReviewWithNicknameDTO {
    private long id;
    private long memberId;
    private long storeId;
    private double score;
    private String content;
    private Timestamp createdAt;
    private String nickname;
    private String reviewImage;
    private String status;
}

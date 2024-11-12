package com.project.domain;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class ReviewDomain {
    private long id;
    private long memberId;
    private long storeId;
    private double score;
    private String content;
    private Timestamp createdAt;
    private String nickname;
    private String reviewImage;
}

package com.project.domain;

import java.sql.Timestamp;

import org.apache.ibatis.type.Alias;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Alias("review")
public class Review {
    private Long id;
    private long memberId;
    private long storeId;
    private double score;
    private String content;
    private Timestamp createdAt;
    private String reviewImage;
    private String status;
}

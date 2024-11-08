package com.project.domain;

import java.sql.Timestamp;
import java.util.Date;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Data
public class ReviewDomain {
    private int id;
    private Long memberId;
    private int storeId;
    private double score;
    private String content;
    private Timestamp createdAt;
    private String nickname;
}

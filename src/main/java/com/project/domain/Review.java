package com.project.domain;

import java.util.Date;

import org.apache.ibatis.type.Alias;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Alias("Review")
public class Review {
    private Long id;
    private long memberId;
    private long storeId;
    private double score;
    private String content;
    private Date createdAt;
}

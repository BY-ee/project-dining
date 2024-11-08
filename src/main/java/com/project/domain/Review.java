package com.project.domain;

import org.apache.ibatis.type.Alias;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Alias("Review")
public class Review {
    private long id;
    private long userId;
    private long storeId;
    private double score;
    private String review;
}

package com.project.domain;

import java.sql.Timestamp;

import org.apache.ibatis.type.Alias;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Alias("Notice")
public class Notice {
    private int id;
    private String category;
    private String title;
    private String content;
    private Timestamp createdAt;
    private Timestamp startDate;
    private Timestamp endDate;
    private String status;
    private String noticeImage;
    private int views;
}

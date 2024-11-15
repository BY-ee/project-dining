package com.project.domain;

import java.sql.Timestamp;

import org.apache.ibatis.type.Alias;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Alias("notice")
public class Notice {
    private int id;
    private String title;
    private String content;
    private Timestamp createdAt;
    private String status;
    private String noticeImage;
    private int views;
}

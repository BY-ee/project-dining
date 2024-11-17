package com.project.domain;

import java.util.Date;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Data
@Alias("event")
public class Event {
    private int id;
    private String category;
    private String title;
    private String content;
    private Date createdAt;
    private Date startDate;
    private Date endDate;
    private String status;
    private String eventImage;
    private int views;
}

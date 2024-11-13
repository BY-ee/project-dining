package com.project.dto;

import java.sql.Timestamp;

import org.springframework.web.multipart.MultipartFile;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class EventDTO {
    private String category;
    private String title;
    private String content;
    private Timestamp startDate;
    private Timestamp endDate;
    private MultipartFile imagePath;
}

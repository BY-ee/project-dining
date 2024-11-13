package com.project.dto;

import java.time.LocalDateTime;
import java.util.Date;

import org.springframework.web.multipart.MultipartFile;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class EventDTO {
    private String category;
    private String title;
    private String content;
    private LocalDateTime startDate;
    private LocalDateTime endDate;
    private MultipartFile imagePath;
}

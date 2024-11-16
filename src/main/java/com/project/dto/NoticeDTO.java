package com.project.dto;

import org.springframework.web.multipart.MultipartFile;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class NoticeDTO {
    private String title;
    private String content;
    private MultipartFile imagePath;
}

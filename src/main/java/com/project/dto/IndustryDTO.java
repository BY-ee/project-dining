package com.project.dto;

import lombok.Data;

@Data
public class IndustryDTO {
	private Long id; // industryId가 매핑될 필드
    private Long storeId;
    private String industry;
}

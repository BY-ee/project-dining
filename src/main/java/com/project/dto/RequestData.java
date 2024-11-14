package com.project.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class RequestData {
    private int page;
    private int size;
    private String column;
    private String keyword;
    
    private RequestData() {
    	this.page = 1;
    	this.size = 10;
    	this.column = "";
    	this.keyword = "";
    }
}

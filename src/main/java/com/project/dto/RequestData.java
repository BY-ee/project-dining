package com.project.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class RequestData {
    private int page;
    private int limit;
    private String category;
    
    private RequestData() {
    	this.page = 1;
    	this.limit = 10;
    	this.category = "";
    }
}

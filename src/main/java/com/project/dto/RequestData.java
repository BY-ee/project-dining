package com.project.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class RequestData<T> {
    private int page;
    private int size;
    private String category;
    
    private RequestData() {
    	this.page = 1;
    	this.size = 10;
    	this.category = "";
    }
}

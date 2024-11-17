package com.project.domain;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Data
@Alias("menu")
public class Menu {
	public Long id;
	public Long storeId;
	public String menuImage;
	public String menuDescription;
	public String menuName;
	public String menuPrice;
}

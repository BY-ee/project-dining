package com.project.domain;

import org.apache.ibatis.type.Alias;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Alias("Menu")
public class Menu {
	public Long storeId;
	public String menuImage;
	public String menuName;
	public String menuDescription;
	public String menuPrice;
}

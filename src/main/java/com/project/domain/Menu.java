package com.project.domain;

import org.apache.ibatis.type.Alias;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Alias("Menu")
public class Menu {
	public Long storeId;
	public String menuImage1;
	public String menuImage2;
	public String menuImage3;
	public String menuImage4;
	public String menuName;
	public String menuDescription;
	public String menuPrice;
}

package com.project.domain;

import java.security.Timestamp;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Data
@Alias("login")
public class LoginDomain {

	private String id;
	private String registration_number;
	private String nickname;
	private String userid;
	private String userpwd;
	private String profile_image;
	private String introduction;
	private String email;
	private Integer status;
	private Timestamp join_date;
	private Timestamp leave_date;

}

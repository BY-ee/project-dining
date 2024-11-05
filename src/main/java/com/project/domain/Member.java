package com.project.domain;

import java.util.Date;

import org.apache.ibatis.type.Alias;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Alias("Member")
public class Member {
	
    private Long id;	
    private String category;
    private String registrationNumber;
    private String userid;
    private String naverId;
    private String googleId;
    private String kakaoId;
    private String userpwd;
    private String nickname;
    private String introduction;
    private String email;
    private String status;
    private Date joinDate;
    private Date leaveDate;
    private String profileImage;
    private Integer point;
}

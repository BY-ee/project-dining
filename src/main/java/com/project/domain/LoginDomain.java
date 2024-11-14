package com.project.domain;

import java.time.LocalDateTime;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Data
@Alias("LoginDomain")
public class LoginDomain {

	private Long id;
    private String category;
    private String registrationNumber;
    private String memberId;
    private String naverId;
    private String googleId;
    private String kakaoId;
    private String passwd;
    private String nickname;
    private String introduction;
    private String email;
    private String status;
    private LocalDateTime createdAt;
    private LocalDateTime inactiveDate;
    private LocalDateTime reactiveDate;
    private LocalDateTime deletedDate;
    private String profileImage;
    private Long point;
    
    // 비밀번호 체크
    private String passwdCheck;
    private String mailid;
    private String domain;
}


package com.project.domain;

import java.time.LocalDateTime;

import lombok.Data;

@Data
public class User {
	private Long id;
	private String email;
	private String password;
	private String username;
	private LocalDateTime created_at;
	private String status;
}

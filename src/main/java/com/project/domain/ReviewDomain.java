	package com.project.domain;
	import java.math.BigDecimal;
import java.security.Timestamp;

import org.apache.ibatis.type.Alias;
	import lombok.Data;
	
	@Data
	@Alias("Reviews")
	public class ReviewDomain {
		private int id;
		private int user_id;
		private int store_id;
		private BigDecimal score;
		private String review;
		private Timestamp created_at;
	}
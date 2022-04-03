package com.azrecord.member.vo;

import lombok.Data;

@Data
public class LoginVO {
	
	private String id, pw, nickname, name, photo;
	private int gradeNo;
	private String gradeName;

}

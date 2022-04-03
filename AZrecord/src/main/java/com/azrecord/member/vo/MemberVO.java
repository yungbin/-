package com.azrecord.member.vo;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class MemberVO {
	private String id;
	private String pw;
	private String nickname;
	private String name;
	private String gender;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date birth;
	private String tel;
	private String email;
	private Date regDate;
	private Date conDate;
	private String status;
	private String photo;
	private long gradeNo;
	private String gradeName;
	private MultipartFile photoFile;
	private String oldPhoto;
}

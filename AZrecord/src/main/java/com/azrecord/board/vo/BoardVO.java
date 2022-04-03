package com.azrecord.board.vo;

import java.util.Date;

import lombok.Data;

@Data
public class BoardVO {
	 
	private long no;
	private String title;
	private String theme;
	private String content;
	private String nickname;
	private String id;
	private Date writeDate;
	private long hit;
	
}

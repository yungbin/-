package com.azrecord.latest.vo;

import java.util.Date;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class LatestVO {
	
	private long code;
	private String id;
	private String songName;
	// 이미지 절대경로
	private String songImage;
	// 음원 절대경로
	private String song;
	private String nickname;
	private String genre;
	private String content;
	private Date writeDate;
	private long recom;
	private long hit;
	// 음원 multi 객체
	private MultipartFile songFileName;
	// 이미지 multi 객체
	private MultipartFile imageFileName;
	// 음원 삭제전용
	private String deleteSong;
	// 이미지 삭제전용
	private String deleteImage;
	// 순위번호
	private long rnum;
	
}

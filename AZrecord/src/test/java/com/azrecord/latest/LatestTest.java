package com.azrecord.latest;

import javax.inject.Inject;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.azrecord.latest.mapper.LatestMapper;
import com.azrecord.latest.vo.LatestVO;
import com.webjjang.util.PageObject;

import lombok.extern.log4j.Log4j;

//test 실행 클래스 지정
@RunWith(SpringJUnit4ClassRunner.class)
//DB 설정 파일 지정
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
//로그 출력 객체
@Log4j
public class LatestTest {

	// mapper 자동 DI
	@Inject
	private LatestMapper mapper;
	
	@Test
	public void testDI() {
		log.info("==============================자동 DI test================================");
		log.info(mapper + "\n");
	}
	
	// 음원 리스트 mapper 테스트
	@Test
	public void testList() throws Exception{
		PageObject pageObject = new PageObject();
		pageObject.setTotalRow(mapper.getTotalRow(pageObject));
		log.info("==============================게시판 리스트 mapper test================================");
		log.info(mapper.list(pageObject) + "\n");
	}
	
	// 음원 보기 - 음원 코드
	@Test
	public void testView() throws Exception{
		long code = 9;
		log.info("==============================게시판 글보기 mapper test================================");
		log.info(mapper.view(code) + "\n");
	}
	
	// 음원 등록 - 음원명, 장르, 아이디, 닉네임, 내용, 음원, 이미지
	@Test
	public void testWrite() throws Exception{
		LatestVO vo = new LatestVO();
		vo.setSongName("테스트 진행");
		vo.setGenre("rock");
		vo.setId("test");
		vo.setNickname("엘레멘탈");
		vo.setContent("호이호이");
		vo.setSong("/upload/song/feeling.mp3");
		vo.setSongImage("/upload/image/noImage.jpg");
		log.info("==============================게시판 글쓰기 mapper test================================");
		log.info(mapper.write(vo) + "\n");
	}
	
	// 음원 수정 - 음원명, 장르, 내용, 음원, 이미지
	@Test
	public void testUpdate() throws Exception{
		LatestVO vo = new LatestVO();
		vo.setCode(9);
		vo.setSongName("테스트 수정 진행");
		vo.setGenre("ballad");
		vo.setId("test");
		vo.setNickname("엘레멘탈");
		vo.setContent("호이오이");
		vo.setSong("/upload/song/feeling.mp3");
		vo.setSongImage("/upload/image/noImage.jpg");
		log.info("==============================게시판 글수정 mapper test================================");
		log.info(mapper.update(vo) + "\n");
	}
	
	// 음원 삭제 - 음원코드
	@Test
	public void testDelete() throws Exception{
		long code = 8;
		log.info("==============================게시판 글삭제 mapper test================================");
		log.info(mapper.delete(code) + "\n");
	}
	
}
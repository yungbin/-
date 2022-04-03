package com.azrecord.board;

import javax.inject.Inject;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.azrecord.board.mapper.BoardMapper;
import com.azrecord.board.vo.BoardVO;
import com.webjjang.util.PageObject;

import lombok.extern.log4j.Log4j;

//test 실행 클래스 지정
@RunWith(SpringJUnit4ClassRunner.class)
//DB 설정 파일 지정
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
//로그 출력 객체
@Log4j
public class BoardTest {

	// mapper 자동 DI
	@Inject
	private BoardMapper mapper;
	
	@Test
	public void testDI() {
		log.info("==============================자동 DI test================================");
		log.info(mapper + "\n");
	}
	
	// 게시판 리스트 mapper 테스트
	@Test
	public void testList() throws Exception{
		PageObject pageObject = new PageObject();
		pageObject.setTotalRow(mapper.getTotalRow(pageObject));
		log.info("==============================게시판 리스트 mapper test================================");
		log.info(mapper.list(pageObject) + "\n");
	}
	
	// 게시판 글보기 - 글번호
	@Test
	public void testView() throws Exception{
		long no = 1;
		log.info("==============================게시판 글보기 mapper test================================");
		log.info(mapper.view(no) + "\n");
	}
	
	// 게시판 글쓰기 - 제목, 내용, 작성자 -> vo
	@Test
	public void testWrite() throws Exception{
		BoardVO vo = new BoardVO();
		vo.setTitle("테스트 진행");
		vo.setContent("테스트 진행 중입니다.");
		vo.setNickname("개발자YB");
		log.info("==============================게시판 글쓰기 mapper test================================");
		log.info(mapper.write(vo) + "\n");
	}
	
	// 게시판 글수정 - 글번호, 제목, 내용, 작성자 -> vo
	@Test
	public void testUpdate() throws Exception{
		BoardVO vo = new BoardVO();
		vo.setNo(1);
		vo.setTitle("업데이트 테스트 진행");
		vo.setContent("업데이트 테스트 진행 중입니다.");
		vo.setNickname("개발자YB");
		log.info("==============================게시판 글수정 mapper test================================");
		log.info(mapper.update(vo) + "\n");
	}
	
	// 게시판 글삭제 - 글번호
	@Test
	public void testDelete() throws Exception{
		long no = 1;
		log.info("==============================게시판 글삭제 mapper test================================");
		log.info(mapper.delete(no) + "\n");
	}
	
}

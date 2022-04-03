package com.azrecord.board.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.azrecord.board.mapper.BoardMapper;
import com.azrecord.board.vo.BoardVO;
import com.webjjang.util.PageObject;

@Service
@Qualifier("BoardService")
public class BoardService {
	
	@Inject
	private BoardMapper mapper;
	
	// 1. list
	public List<BoardVO> list(PageObject pageObject) throws Exception{
		pageObject.setTotalRow(mapper.getTotalRow(pageObject));
		return mapper.list(pageObject);
	}
	// 1-1. boardList
	public List<BoardVO> boardList(PageObject pageObject) throws Exception{
		pageObject.setTotalRow(mapper.getTotalMainRow(pageObject));
		return mapper.boardList(pageObject);
	}
	// 2. view
	public BoardVO view(long no, int inc) throws Exception{
		System.out.println("BoardController.view(). no, inc - " + no + " / " + inc);
		if(inc == 1) mapper.increase(no);
		return mapper.view(no);
	}
	// 3. write
	public int write(BoardVO vo) throws Exception{
		return mapper.write(vo);
	}
	// 4. update
	public int update(BoardVO vo) throws Exception{
		return mapper.update(vo);
	}
	// 5. delete
	public int delete(long no) throws Exception{
		return mapper.delete(no);
	}
	
}

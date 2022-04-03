package com.azrecord.latest.mapper;

import java.util.List;

import com.azrecord.latest.vo.LatestVO;
import com.webjjang.util.PageObject;

public interface LatestMapper {
	
	public List<LatestVO> list(PageObject pageObject) throws Exception;
	
	public List<LatestVO> latestList(PageObject pageObject) throws Exception;
	
	public List<LatestVO> chartList(PageObject pageObject) throws Exception;
	
	public long getTotalRow(PageObject pageObject) throws Exception;
	
	public long getTotalChartRow(PageObject pageObject) throws Exception;
	
	public LatestVO view(long code) throws Exception;
	
	public int increase(long code) throws Exception;
	
	public int write(LatestVO vo) throws Exception;
	
	public int update(LatestVO vo) throws Exception;
	
	public int delete(long code) throws Exception;
}

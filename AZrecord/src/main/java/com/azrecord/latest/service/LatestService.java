package com.azrecord.latest.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.azrecord.latest.mapper.LatestMapper;
import com.azrecord.latest.vo.LatestVO;
import com.webjjang.util.PageObject;

@Service
@Qualifier("LatestService")
public class LatestService {
	
	@Inject
	private LatestMapper mapper;
	
	public List<LatestVO> list(PageObject pageObject) throws Exception{
		pageObject.setTotalRow(mapper.getTotalRow(pageObject));
		return mapper.list(pageObject);
	}
	
	public List<LatestVO> latestList(PageObject pageObject) throws Exception{
		pageObject.setTotalRow(mapper.getTotalRow(pageObject));
		return mapper.latestList(pageObject);
	}
	
	public List<LatestVO> chartList(PageObject pageObject) throws Exception{
		pageObject.setTotalRow(mapper.getTotalChartRow(pageObject));
		return mapper.chartList(pageObject);
	}
	
	public LatestVO view(int inc, long code) throws Exception{
		if(inc == 1) mapper.increase(code);
		return mapper.view(code);
	}
	public int write(LatestVO vo) throws Exception{
		return mapper.write(vo);
	}
	public int update(LatestVO vo) throws Exception{
		return mapper.update(vo);
	}
	public int delete(long code) throws Exception{
		return mapper.delete(code);
	}
}

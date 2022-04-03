package com.azrecord.chart.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import com.azrecord.latest.service.LatestService;
import com.webjjang.util.PageObject;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/chart")
@Log4j
public class ChartController {
	
	@Autowired
	@Qualifier("LatestService")
	private LatestService service;
	
	@GetMapping("/list.do")
	public String list(@ModelAttribute PageObject pageObject, Model model) throws Exception{
		// 한페이지에 20개 뿌리기
		pageObject.setPerPageNum(20);
		
		// Period 상태가 pre인 경우 (아무 셋팅없는 상태) all 로 바꾼다.
		if(pageObject.getPeriod().equals("pre")) {
			pageObject.setPeriod("hit");
		}
		log.info("차트리스트의 list 값들 >> " + service.chartList(pageObject));
		model.addAttribute("list", service.chartList(pageObject));
		return "chart/list";
	}
}

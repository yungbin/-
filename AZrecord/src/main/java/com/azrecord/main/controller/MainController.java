package com.azrecord.main.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import com.azrecord.board.service.BoardService;
import com.azrecord.latest.service.LatestService;
import com.webjjang.util.PageObject;

@Controller
@RequestMapping("/main")
public class MainController {
	
	@Autowired
	@Qualifier("LatestService")
	private LatestService latestService;
	
	@Autowired
	@Qualifier("BoardService")
	private BoardService boardService;
	
	@GetMapping("/main.do")
	public String main(@ModelAttribute PageObject pageObject, Model model) throws Exception{
		if(pageObject.getPeriod().equals("pre") || pageObject.getPeriod().equals("")) {
			pageObject.setPeriod("all");
		}
		
		latestService.latestList(pageObject);
        model.addAttribute("latestList", latestService.latestList(pageObject));
        
        boardService.boardList(pageObject);
        model.addAttribute("boardList", boardService.boardList(pageObject));

        return "main/main";
	}
}

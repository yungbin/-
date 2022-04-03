package com.azrecord.board.controller;

import java.net.URLEncoder;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.azrecord.board.service.BoardService;
import com.azrecord.board.vo.BoardVO;
import com.webjjang.util.PageObject;

@Controller
@RequestMapping("/board")
public class BoardController {
	
	@Autowired
	private BoardService service;
	
	@GetMapping("/list.do")
	public String list(@ModelAttribute PageObject pageObject, Model model) throws Exception{
		// Period 상태가 pre인 경우 (아무 셋팅없는 상태) all 로 바꾼다.
		if(pageObject.getPeriod().equals("pre") || pageObject.getPeriod().equals("")) {
			pageObject.setPeriod("all");
		}
		model.addAttribute("list", service.list(pageObject));
		
		return "board/list";
	}
	
	// 2. view
	@GetMapping("/view.do")
	public String view(long no, int inc, Model model) throws Exception{
		
		BoardVO vo = service.view(no, inc);
		vo.setContent(vo.getContent().replace("\n", "<br>"));
		model.addAttribute("vo", vo);
			
		System.out.println("BoardController.view()" + no + " / " + inc);
			
		return "board/view";
	}
		
	// 3-1. writeForm
	@GetMapping("/write.do")
	public String writeForm() throws Exception{
		return "board/write"; 
	}
		
	// 3-2. write
	@PostMapping("/write.do")
	public String write(BoardVO vo, int perPageNum) throws Exception{
		System.out.println("BoardController.write() vo " + vo);
		service.write(vo);
		return "redirect:list.do?page=1&perPageNum=" + perPageNum;
	}
	// 4-1. updateForm
	@GetMapping("/update.do")
	public String updateForm(long no, Model model) throws Exception{
		System.out.println("BoardController.updateForm() no " + no);
		model.addAttribute("vo", service.view(no, 0));
		return "board/update";
	}
	// 4-2. update
	@PostMapping("/update.do")
	public String update(PageObject pageObject, BoardVO vo, RedirectAttributes rttr) throws Exception{
		System.out.println("BoardController.update() vo " + vo);
		service.update(vo);
		rttr.addFlashAttribute("msg", "글수정이 성공적으로 되었습니다.");
		return "redirect:view.do?no=" + vo.getNo() + "&inc=0&page=" + pageObject.getPage() + "&perPageNum="
				// 자바 부분의 한글 코드와 운영 한글 코드가 다르므로 자바에서 꺼내서 넣으면 깨진다. 엔코딩을 해야한다.
				+ pageObject.getPerPageNum() + "&key=" + pageObject.getKey() + "&word=" +
				URLEncoder.encode(pageObject.getWord(), "utf-8")
				+ "&period=" + pageObject.getPeriod();
		}
	// 5. delete
	@GetMapping("/delete.do")
	public String delete(long no, RedirectAttributes rttr) throws Exception{
		System.out.println("BoardController.delete() no " + no);
		service.delete(no);
		rttr.addFlashAttribute("msg", "글삭제가 성공적으로 되었습니다.");
		return "redirect:list.do";
	}

}

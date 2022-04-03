package com.azrecord.latest.controller;

import java.net.URLEncoder;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.azrecord.latest.service.LatestService;
import com.azrecord.latest.vo.LatestVO;
import com.webjjang.util.PageObject;
import com.webjjang.util.file.FileUtil;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/latest")
@Log4j
public class LatestController {
	
	@Autowired
	private LatestService service;
	
	@GetMapping("/list.do")
	public String list(PageObject pageObject, Model model) throws Exception{
		// 한 페이지당 12개 까지 보이도록 한다.
		pageObject.setPerPageNum(12);
		// Period 상태가 pre인 경우 (아무 셋팅없는 상태) all 로 바꾼다.
		if(pageObject.getPeriod().equals("pre") || pageObject.getPeriod().equals("")) {
			pageObject.setPeriod("all");
		}
		model.addAttribute("list", service.list(pageObject));
		return "latest/list";
	}
	
	@GetMapping("/view.do")
	public String view(int inc, long code, Model model) throws Exception{
		LatestVO vo = service.view(inc, code);
		vo.setContent(vo.getContent().replace("\n", "<br>"));
		model.addAttribute("vo", vo);
		return "latest/view";
	}
	
	@GetMapping("/write.do")
	public String writeForm() throws Exception{
		return "latest/write";
	}
	
	@PostMapping("/write.do")
	public String write(LatestVO vo, PageObject pageObject, HttpServletRequest request) throws Exception{
		String imagePath = "/upload/image";
		String songPath = "/upload/song";
		
		String realImageName = FileUtil.upload(imagePath, vo.getImageFileName(), request);
		String realSongName = FileUtil.upload(songPath, vo.getSongFileName(), request);
		
		log.info("음원 등록시 perPageNum은 얼마? " + pageObject.getPerPageNum());
		vo.setSongImage(realImageName);
		vo.setSong(realSongName);
		
		service.write(vo);
		return "redirect:list.do?perPageNum=" + pageObject.getPerPageNum();
	}
	
	@GetMapping("/update.do")
	public String updateForm(long code, Model model) throws Exception{
		log.info("updateForm >> " + service.view(0, code));
		model.addAttribute("vo", service.view(0, code));
		return "latest/update";
	}
	
	@PostMapping("/update.do")
	public String update(PageObject pageObject, LatestVO vo, HttpServletRequest request, RedirectAttributes rttr) throws Exception{
		// FileUtil 에서 multiPartFile객체를 넣어서 upload 메소드를 실행시
		// 파일을 수정했으면 파일 수정한 절대경로가 리턴되지만, 파일을 수정하지않으면 noImage로 절대경로가 변경된다.
		// 이 점을 이용하여 조건문을 만들었다. imageFile.equals(noImage)
		log.info("업데이트 폼에서 가져온 vo >> " + vo);
		
		String noImage = "/upload/image/noImage.jpg";
		String noSong = "/upload/song/noImage.jpg";
		String imagePath = "/upload/image";
		String songPath = "/upload/song";
		
		////////////////////////이미지 처리 ////////////////////////
		// 이전 이미지파일이 noImage인 경우에 수정처리를 하지않으면 어차피 이전파일이 noImage이기에 이전파일을 현재파일에 붙여넣는다.
		// 만약에 수정처리가 이뤄지면 noImage는 공용파일이기 때문에 삭제처리 소스를 넣지 않는다.
		
		// 이전 이미지파일이 noImage.jpg 인경우.
		if(vo.getDeleteImage().equals(noImage)) {
			
			String imageFile = FileUtil.upload(imagePath, vo.getImageFileName(), request);
			// 파일 업로드처리가 이뤄진 경우
			if(!(imageFile.equals(noImage))) {
				log.info("파일 업로드 어떻게 진행되는거죠? " + imageFile);
				vo.setSongImage(imageFile);
				log.info("A구간을 지났습니다.");
				// 이전 이미지는 삭제하면 안된다. ( noImage.jpg는 공용파일이기 땜문에 )
			}
			// 파일 업로드처리가 이뤄지지 않은경우 이전파일경로를 현재경로에 붙여넣는다.
			else {
				vo.setSongImage(vo.getDeleteImage());
				log.info("B구간을 지났습니다.");
			}
		}
		// 이전 이미지파일이 noImage가 아닌경우에 수정처리를 할때 이전 파일은 공용파일이 아니기때문에 삭제처리 소스를 넣는다.
		
		// 이전 이미지파일이 noImage가 아닌 경우.
		else {
			
			String imageFile = FileUtil.upload(imagePath, vo.getImageFileName(), request);
			// 파일 업로드 처리가 이뤄진 경우
			if(!(imageFile.equals(noImage))) {
				log.info("파일 업로드 어떻게 진행되는거죠? " + imageFile);
				vo.setSongImage(imageFile);
				// 이전 이미지는 공용이 아니므로 삭제해도 무방하다.
				FileUtil.remove(FileUtil.getRealPath("", vo.getDeleteImage(), request));
				log.info("C구간을 지났습니다.");
			}
			// 파일 업로드 처리가 이뤄지지 않은 경우
			else {
				vo.setSongImage(vo.getDeleteImage());
				log.info("D구간을 지났습니다.");
			}
		}// image noimage if문 end
		//////////////////////// 음원 처리 ////////////////////////
		
		// 음원은 필수항목이라 noImage가 나오는 경우는 극히 드물지만 소스를 넣어놨다.
		// 이전 음원파일이 noImage인 경우 파일 업로드처리가 이뤄지면 이전 파일은 공용파일이기에 삭제소스를 넣지 않는다.
		
		// 이전 음원파일이 noImage.jpg 인경우.
		if(vo.getDeleteSong().equals(noSong)) {
			
			String songFile = FileUtil.upload(songPath, vo.getSongFileName(), request);
			
			// 파일 업로드처리가 이뤄진 경우
			if(!(songFile.equals(noSong))) {
				log.info("파일 업로드 어떻게 진행되는거죠? " + songFile);
				vo.setSong(songFile);
				log.info("E구간을 지났습니다.");
			}
			// 파일 업로드처리가 이뤄지지 않은경우 song이 noImage로 변환되어서 이전 파일로 바꿔서 넣어줘야한다.
			// 이전 음원파일이 noImage인경우는 극히 드물기때문에 원래는 오류처리를 내야한다.
			else {
				System.exit(0);
				vo.setSong(vo.getDeleteSong());
				log.info("F구간을 지났습니다.");
			}
		}
		// 이전 음원파일이 noImage가 아닌 경우.
		else {
			
			String songFile = FileUtil.upload(songPath, vo.getSongFileName(), request);
			// 파일 업로드 처리가 이뤄진 경우
			if(!(songFile.equals(noSong))) {
				log.info("파일 업로드 어떻게 진행되는거죠? " + songFile);
				vo.setSong(songFile);
				// 이전 음원 파일은 공용이 아니므로 삭제해도 무방하다.
				FileUtil.remove(FileUtil.getRealPath("", vo.getDeleteSong(), request));
				log.info("G구간을 지났습니다.");
			}
			// 파일 업로드 처리가 이뤄지지 않은 경우
			else {
				songFile = vo.getDeleteSong();
				vo.setSong(songFile);
				log.info("H구간을 지났습니다.");
			}
		}// song noImage if문 end
		
		log.info("FileUtil 처리 후 vo >> " + vo);
		service.update(vo);
		rttr.addFlashAttribute("msg", "음원 수정이 성공적으로 되었습니다.");
		
		return "redirect:view.do?code=" + vo.getCode() + 
				"&inc=0" + 
				"&page=" + pageObject.getPage() + 
				"&perPageNum=" + pageObject.getPerPageNum() + 
				"&key=" + pageObject.getKey() + 
				"&word=" + URLEncoder.encode(pageObject.getWord(), "utf-8") + 
				"&period=" + pageObject.getPeriod();
	}
	
	@GetMapping("/delete.do")
	public String delete(long code, PageObject pageObject, String deleteImage, String deleteSong, HttpServletRequest request, RedirectAttributes rttr) throws Exception{
		String noImage = "/upload/image/noImage.jpg";
		service.delete(code);
		// 만약 이전 이미지파일이 noImage이면 song만 삭제한다. ( noImage는 삭제하면 안된다. )
		if(deleteImage.equals(noImage)) {
			FileUtil.remove(FileUtil.getRealPath("", deleteSong, request));
		}
		// 이전 이미지파일이 noImage가 아니면 둘다 삭제한다.
		else {
			FileUtil.remove(FileUtil.getRealPath("", deleteImage, request));
			FileUtil.remove(FileUtil.getRealPath("", deleteSong, request));
		}
		rttr.addFlashAttribute("msg", "음원 삭제가 성공적으로 되었습니다.");
		return "redirect:list.do?perPageNum=" + pageObject.getPerPageNum();
	}
}// controller end

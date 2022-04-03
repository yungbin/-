package com.azrecord.member.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.azrecord.member.service.MemberService;
import com.azrecord.member.vo.LoginVO;
import com.azrecord.member.vo.MemberVO;
import com.webjjang.util.PageObject;
import com.webjjang.util.file.FileUtil;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/member")
@Log4j
public class MemberController {
	
	@Autowired
	private MemberService service;
	
	// 회원 관리 리스트
	@GetMapping("/list.do")
	public String list(@ModelAttribute PageObject pageObject, Model model) throws Exception{
		model.addAttribute("list", service.list(pageObject));
		return "member/list";
	}
	
	// 회원 정보 보기
	@GetMapping("/view.do")
	public String view(String id, Model model, HttpSession session) throws Exception{
		if(id == null) {
			model.addAttribute("title", "내 정보 보기");
			id = ((LoginVO) session.getAttribute("login")).getId();
		}
		else {
			model.addAttribute("title", "회원 정보 보기");
		}
		model.addAttribute("vo", service.view(id));
		return "member/view";
	}
	
	// 회원 가입 폼
	@GetMapping("/write.do")
	public String writeForm() throws Exception{
		return "member/write";
	}
	
	// 회원 가입 처리
	@PostMapping("/write.do")
	public String write(MemberVO vo, HttpServletRequest request, RedirectAttributes rttr) throws Exception{
		String path = "/upload/member";
		vo.setPhoto(FileUtil.upload(path, vo.getPhotoFile(), request));
		service.write(vo);
		rttr.addFlashAttribute("msg", "성공적으로 회원가입이 완료됬습니다!");
		return "redirect:/member/login.do";
	}
	
	// 수정 입력 폼
	@GetMapping("/update.do")
	public String updateForm(String id, Model model) throws Exception{
		model.addAttribute("vo", service.view(id));
		return "member/update";
	}
	// 수정 처리
	@PostMapping("/update.do")
	public String update(MemberVO vo, LoginVO lovo, HttpServletRequest request, RedirectAttributes rttr) throws Exception{
		String path = "/upload/member";
		String noImage = "/upload/member/noImage.jpg";
		log.info("업데이트폼에서 받은 VO " + vo);
		
		// 이전 사진파일이 noImage 인경우.
		if(vo.getOldPhoto().equals(noImage)) {
			
			String imageFile = FileUtil.upload(path, vo.getPhotoFile(), request);
			// 파일 업로드처리가 이뤄진 경우
			if(!(imageFile.equals(noImage))) {
				log.info("파일 업로드 어떻게 진행되는거죠? " + imageFile);
				vo.setPhoto(imageFile);
				log.info("A구간을 지났습니다.");
				// 이전 사진파일은 삭제하면 안된다. ( noImage.jpg는 공용파일이기 때문에 )
			}
			// 파일 업로드처리가 이뤄지지 않은경우 이전파일경로를 현재경로에 붙여넣는다.
			else {
				vo.setPhoto(vo.getOldPhoto());
				log.info("B구간을 지났습니다.");
			}
		}
		// 이전 사진파일이 noImage가 아닌경우에 수정처리를 할때 이전 파일은 공용파일이 아니기때문에 삭제처리 소스를 넣는다.
		// 이전 사진파일이 noImage가 아닌 경우.
		else {
			String imageFile = FileUtil.upload(path, vo.getPhotoFile(), request);
			// 파일 업로드 처리가 이뤄진 경우
			if(!(imageFile.equals(noImage))) {
				log.info("파일 업로드 어떻게 진행되는거죠? " + imageFile);
				vo.setPhoto(imageFile);
				// 이전 이미지는 공용이 아니므로 삭제해도 무방하다.
				FileUtil.remove(FileUtil.getRealPath("", vo.getOldPhoto(), request));
				log.info("C구간을 지났습니다.");
			}
			// 파일 업로드 처리가 이뤄지지 않은 경우
			else {
				vo.setPhoto(vo.getOldPhoto());
				log.info("D구간을 지났습니다.");
			}
		}// image noimage if문 end
		
		log.info("MemberController - update() >> " + vo);
		lovo.setPhoto(vo.getPhoto());
		service.update(vo);
		return "redirect:view.do";
	}
	
	// 회원 탈퇴
	@GetMapping("/delete.do")
	public String delete(MemberVO vo, HttpSession session, HttpServletRequest request, RedirectAttributes rttr) throws Exception{
		log.info(session);
		service.delete(vo);
		FileUtil.remove(FileUtil.getRealPath("", vo.getOldPhoto(), request));
		session.removeAttribute("login");
		rttr.addFlashAttribute("msg", "탈퇴가 완료되었습니다. 다음에 또오세요!");
		
		return "redirect:/main/main.do";
	}
	
	// 아이디 중복 체크
	@GetMapping("/idCheck")
	public String idCheck(String id, Model model) throws Exception{
		model.addAttribute("id", service.idCheck(id));
		return "member/idCheck";
	}
	// 닉네임 중복 체크
	@GetMapping("/nickCheck")
	public String nickCheck(String nickname, Model model) throws Exception{
		model.addAttribute("nickname", service.nickCheck(nickname));
		return "member/nickCheck";
	}
	
	// 로그인 폼
	@GetMapping("/login.do")
	public String loginForm() throws Exception{
		return "member/login";
	}
	// 로그인
	@PostMapping("/login.do")
	public String login(LoginVO invo, HttpSession session, RedirectAttributes rttr) throws Exception{
		
		if(service.login(invo) == null) {
			rttr.addFlashAttribute("msg", "아이디나 비밀번호를 확인해주세요.");
			return "redirect:/member/login.do";
		} else {
			invo = service.login(invo);
			session.setAttribute("login", invo);
			rttr.addFlashAttribute("msg", "환영합니다! " + invo.getName() + " 님 !");
			return "redirect:/main/main.do";
		}
	}
	// 로그아웃
	@GetMapping("/logout.do")
	public String logout(HttpSession session) throws Exception{
		session.removeAttribute("login");
		return "redirect:/main/main.do";
	}
	// 상태변경
	@PostMapping("/changeStatus.do")
	public String changeStatus(PageObject pageObject, MemberVO vo) throws Exception{
		service.changeStatus(vo);
		return "redirect:view.do?id=" + vo.getId() + "&page=" + 
		pageObject.getPage() + "&perPageNum=" + pageObject.getPerPageNum();
	}
	// 등급변경
	@PostMapping("/changeGradeNo.do")
	public String changeGradeNo(PageObject pageObject, MemberVO vo) throws Exception{
		service.changeGradeNo(vo);
		
		return "redirect:view.do?id=" + vo.getId() + "&page=" + 
		pageObject.getPage() + "&perPageNum=" + pageObject.getPerPageNum();
	}
}

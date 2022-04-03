package com.azrecord.member.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.azrecord.member.mapper.MemberMapper;
import com.azrecord.member.vo.LoginVO;
import com.azrecord.member.vo.MemberVO;
import com.webjjang.util.PageObject;

@Service
public class MemberService {
	
	@Inject
	private MemberMapper mapper;
	
	// 멤버 리스트
	public List<MemberVO> list(PageObject pageObject) throws Exception{
		pageObject.setTotalRow(mapper.getTotalRow(pageObject));
		return mapper.list(pageObject);
	}
	// 회원 정보 보기
	public MemberVO view(String id) throws Exception{
		return mapper.view(id);
	}
	// 회원가입
	public int write(MemberVO vo) throws Exception{
		return mapper.write(vo);
	}
	// 회원수정
	public int update(MemberVO vo) throws Exception{
		return mapper.update(vo);
	}
	// 회원탈퇴
	public int delete(MemberVO vo) throws Exception{
		return mapper.delete(vo);
	}
	// 아이디 중복 체크 -> 아이디를 가져오자
	public String idCheck(String id) throws Exception{
		return mapper.idCheck(id);
	}
	// 닉네임 중복 체크 -> 닉네임을 가져오자
	public String nickCheck(String nickname) throws Exception{
		return mapper.nickCheck(nickname);
	}
	// 로그인
	public LoginVO login(LoginVO invo) throws Exception{
		return mapper.login(invo);
	}
	// 상태변경
	public int changeStatus(MemberVO vo) throws Exception{
		return mapper.changeStatus(vo);
	}
	// 등급변경
	public int changeGradeNo(MemberVO vo) throws Exception{
		return mapper.changeGradeNo(vo);
	}
		
}

package com.azrecord.member.mapper;

import java.util.List;

import com.azrecord.member.vo.LoginVO;
import com.azrecord.member.vo.MemberVO;
import com.webjjang.util.PageObject;

public interface MemberMapper {
	// 1. 리스트
	public List<MemberVO> list(PageObject pageObject) throws Exception;
	// 1-1. 페이지 세기
	public long getTotalRow(PageObject pageObject) throws Exception;
	// 2. 보기
	public MemberVO view(String id) throws Exception;
	// 3. 가입
	public int write(MemberVO vo) throws Exception;
	// 4. 수정
	public int update(MemberVO vo) throws Exception;
	// 5. 탈퇴
	public int delete(MemberVO vo) throws Exception;
	// 6. 로그인처리
	public LoginVO login(LoginVO invo) throws Exception;
	// 7. 아이디 중복 체크
	public String idCheck(String id) throws Exception;
	// 7-1. 닉네임 중복 체크
	public String nickCheck(String nickname) throws Exception;
	// 8. 상태 변경
	public int changeStatus(MemberVO vo) throws Exception;
	// 9. 등급 변경
	public int changeGradeNo(MemberVO vo) throws Exception;
}

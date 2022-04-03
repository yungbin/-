<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 정보 수정</title>
<script type="text/javascript">
$(function(){
	// 이메일 및 전화번호 정규표현식
	var reg_email = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
	var reg_tel = /^\d{2,3}-\d{3,4}-\d{4}$/;
	
	// datepicker 클래스 이벤트 - 적정한 옵션을 넣어서 초기화 시켜 준다. 기본 datepicker()로 사용 가능
	$(".datepicker").datepicker({
		changeMonth: true,
		changeYear: true,
		dateFormat: "yy-mm-dd",
		dayNamesMin: [ "일", "월", "화", "수", "목", "금", "토" ],
		monthNamesShort: [ "1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월" ]
	});
	
	// datepicker 클래스 이벤트
	var now = new Date();
	var startYear = now.getFullYear();
	var yearRange = (startYear - 100) + ":" + startYear;
	// datepicker - 초기값으로 셋팅하는 방법을 사용하면 2번째는 무시 당한다.
	//원래 있던 datepicker에 option을 추가하는 방법이다.
	$(".datepicker").datepicker("option", {
		"maxDate" : new Date(),
		yearRange : yearRange
	}); // datepicker
	
	// 회원 가입 submit 이벤트 후 처리
	$("#updateForm").submit(function(){
		// 전화번호 패턴 체크
		if(!reg_tel.test($("#tel").val())){
			alert("패턴에 맞지 않는다! \n" + "ex) 000-0000-0000 을(를) 입력하셔야 합니다.");
			$("#tel").focus();
			return false;
		}
		// 이메일 패턴 체크
		if(!reg_email.test($("#email").val())){
			alert("패턴에 맞지 않는다! \n" + "test@naver.com 형식의 이메일 을(를) 입력하셔야 합니다.");
			$("#email").focus();
			return false;
		}
		
	}); // updateForm submit function
	
});
</script>
</head>
<body>
<div class="container">
	<h2>회원 정보 수정</h2>
	<form action="update.do" method="post" enctype="multipart/form-data" id="updateForm">
		<input type="hidden" name="oldPhoto" value="${param.oldPhoto }">
		<div class="form-group">
			<label for="name">아이디</label>
			<input name="id" id="id" class="form-control" value="${vo.id }" readonly="readonly">
		</div>
		<div class="form-group">
			<label for="name">패스워드(본인확인용)</label>
			<input name="pw" id="pw" class="form-control" required="required" placeholder="본인 확인용 패스워드">
		</div>
		<div class="form-group">
			<label for="nickname">닉네임</label>
			<input name="nickname" id="nickname" class="form-control" required="required" pattern=".{4,20}" placeholder="이름 입력"
			value="${vo.nickname }" readonly="readonly" >
		</div>
		<div class="form-group">
			<label for="name">이름</label>
			<input name="name" id="name" class="form-control" required="required" pattern="[가-힣]{2,10}" placeholder="이름 입력"
			value="${vo.name }">
		</div>
		<div class="form-group">
			<label>성별</label>
			<div>
				<label class="radio-inline"><input name="gender" type="radio" value="남자" ${(vo.gender == "남자")?"checked":"" }>남자</label>
				<label class="radio-inline"><input name="gender" type="radio" value="여자" ${(vo.gender == "여자")?"checked":"" }>여자</label>
			</div>
		</div>
		<div class="form-group">
			<label for="birth">생년월일</label>
			<input name="birth" id="birth" class="form-control datepicker" required="required" placeholder="yyyy-mm-dd" autocomplete="off"
			value="<fmt:formatDate value="${vo.birth }" pattern="yyyy-MM-dd"/>">
		</div>
		<div class="form-group">
			<label for="tel">연락처</label>
			<input name="tel" id="tel" class="form-control" placeholder="연락처 입력" value="${vo.tel }">
		</div>
		<div class="form-group">
			<label for="email">이메일</label>
			<input name="email" id="email" class="form-control" placeholder="이메일 입력" value="${vo.email }">
		</div>
		<div class="form-group">
			<label for="photoFile">사진</label>
			<input id="photoFile" name="photoFile" type="file">
		</div>
		<button class="btn btn-default">수정</button>
		<button type="button" class="btn btn-default" onclick="history.back()">취소</button>
	</form>
</div>
</body>
</html>
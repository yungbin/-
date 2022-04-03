<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입 폼</title>
<script type="text/javascript">
	$(function(){
		
		// id중복체크 변수, 비밀번호와 비밀번호 확인이 같은지 체크 변수 -> 전역 변수 선언
		var idCheck = false;
		var pwCheck = false;
		var nickCheck = false;
		
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
		
		// 닉네임 체크 이벤트
		$("#nickname").keyup(function(){
			//alert("호호이");
			nickCheck = false;
			
			var nick = $("#nickname").val();
			// 공백문자 처리
			nick = $.trim(nick);
			$("#nickname").val(nick);
			//alert("알러지0 " + $("#nickname").val());
			
			// 2자 이상 처리
			if(nick.length < 2){		
				$("#nickCheckDiv").removeClass("alert-success");
				$("#nickCheckDiv").addClass("alert-danger");
				$("#nickCheckDiv").text("닉네임은 2자 이상이어야 합니다.");
				return;
			}
			// 20자 초과 처리
			if(nick.length > 20){		
				$("#nickCheckDiv").removeClass("alert-success");
				$("#nickCheckDiv").addClass("alert-danger");
				$("#nickCheckDiv").text("닉네임은 20자 미만이여야 합니다.");
				return;
			}
			
			// ajax를 이용하여 닉네임 반복 체크
			$("#nickCheckDiv").load("/member/nickCheck?nickname=" + nick, function(result){
				// 결과에 따른 배경색 처리
				var msg = $("#nickCheckDiv").text();
				// 클래스 다 지우기
				$("#nickCheckDiv").removeClass("alert-success alert-danger");
				if(msg.indexOf("가능한") == -1){
					// 중복된 아이디 인 경우 배경은 빨간색
					$("#nickCheckDiv").addClass("alert-danger");
					nickCheck = false;
				} else{
					// 사용가능한 아이디 인 경우 배경은 파란색
					$("#nickCheckDiv").addClass("alert-success");
					nickCheck = true;
				}
				
			}); // ajax function
			

		});// nickname function end
		
		// 아이디 체크 이벤트
		$("#id").keyup(function(){
			
			idCheck = false;
			
			var id = $("#id").val();
			// 공백문자 처리
			id = $.trim(id);
			$("#id").val(id);
			// alert("입력한 아이디 : " + id);
			
			//alert("알러지0 " + $("#id").val());
			
			// 4자 미만 처리
			if(id.length < 4){		
				$("#idCheckDiv").removeClass("alert-success");
				$("#idCheckDiv").addClass("alert-danger");
				$("#idCheckDiv").text("아이디는 4자 이상 영숫자이여야 합니다.");
				return;
			}
			
			// 20자 초과 처리
			if(id.length > 20){		
				$("#idCheckDiv").removeClass("alert-success");
				$("#idCheckDiv").addClass("alert-danger");
				$("#idCheckDiv").text("아이디는 20자 이내 영숫자이여야 합니다.");
				return;
			}
			
			// 4자 ~ 20자 사이 아이디인 경우 - 중복 체크하러 간다. -> 서버로 간다. URL필요 -> 화면에 다른 데이터는 변하지 않으면서 일부 처리에 필요한 데이터만 변경 URL은 변경이 없다. -> Ajax
			// 중복안된 경우(아이디가 null인 경우) - 사용가능한 아이디 입니다., 중복이 된 경우(아이디가 null이 아닌 경우) - 중복된 아이디입니다. -> 서버에서 처리
			// /member/idCheck -> *.do:sitemesh 위 아래 메뉴와 카피라이트가 붙는다.
			// result -> 서버에서 전달해 주는 데이터
			$("#idCheckDiv").load("/member/idCheck?id=" + id, function(result){

				// 결과에 따른 배경색 처리
				var msg = $("#idCheckDiv").text();
				// 클래스 다 지우기
				$("#idCheckDiv").removeClass("alert-success alert-danger");
				if(msg.indexOf("가능한") == -1){
					// 중복된 아이디 인 경우 배경은 빨간색
					$("#idCheckDiv").addClass("alert-danger");
					idCheck = false;
				} else{
					// 사용가능한 아이디 인 경우 배경은 파란색
					$("#idCheckDiv").addClass("alert-success");
					idCheck = true;
				}
				
			}); // ajax function
		}); // id function
		
		$("#pw").keyup(function(){
			pwCheck = false;
			// $(this) == $("#pw")
			var pw = $(this).val();
			
// 			alert("비밀 : " + pw);
			// 4자 미만 처리
			if(pw.length < 4){		
				$("#pwCheckDiv").removeClass("alert-success");
				$("#pwCheckDiv").addClass("alert-danger");
				$("#pwCheckDiv").text("비밀번호는 4자 이상이여야 합니다.");
				return;
			}
			
			// 20자 초과 처리
			if(pw.length > 20){		
				$("#pwCheckDiv").removeClass("alert-success");
				$("#pwCheckDiv").addClass("alert-danger");
				$("#pwCheckDiv").text("비밀번호는 20자 이내이여야 합니다.");
				return;
			}		
			
			// 4~20 사이 pw2와 같은지 체크
			var pw2 = $("#pw2").val();
			
			if(pw == pw2){
				// 비밀번호와 비밀번호 확인이 같은 경우
				$("#pwCheckDiv, #pw2CheckDiv").removeClass("alert-danger");
				$("#pwCheckDiv, #pw2CheckDiv").addClass("alert-success");
				$("#pwCheckDiv, #pw2CheckDiv").text("적당한 비밀번호 입니다.");
				pwCheck = true;
			} else {
				// 비밀번호와 비밀번호 확인이 같지 않은 경우
				$("#pwCheckDiv, #pw2CheckDiv").removeClass("alert-success");
				$("#pwCheckDiv, #pw2CheckDiv").addClass("alert-danger");
				$("#pwCheckDiv").text("비밀번호와 비밀번호 확인이 같아야 합니다.");
				if(pw2.length < 4)
					$("#pw2CheckDiv").text("비밀번호는 4자 이상이여야 합니다.");
				else if(pw2.length > 20)
					$("#pw2CheckDiv").text("비밀번호는 20자 이내이여야 합니다.");
				else
					$("#pw2CheckDiv").text("비밀번호와 비밀번호 확인이 같아야 합니다.");
			}
		}); // pw function
		
		$("#pw2").keyup(function(){
			pwCheck = false;
			var pw2 = $(this).val();
// 			alert("비밀확인 : " + pw2);
			// 4자 미만 처리
			if(pw2.length < 4){		
				$("#pw2CheckDiv").removeClass("alert-success");
				$("#pw2CheckDiv").addClass("alert-danger");
				$("#pw2CheckDiv").text("비밀번호는 4자 이상이여야 합니다.");
				return;
			}
			
			// 20자 초과 처리
			if(pw2.length > 20){		
				$("#pw2CheckDiv").removeClass("alert-success");
				$("#pw2CheckDiv").addClass("alert-danger");
				$("#pw2CheckDiv").text("비밀번호는 20자 이내이여야 합니다.");
				return;
			}
			
			// 4~20 사이 pw2와 같은지 체크
			var pw = $("#pw").val();
			if(pw == pw2){
				// 비밀번호와 비밀번호 확인이 같은 경우
				$("#pw2CheckDiv, #pwCheckDiv").removeClass("alert-danger");
				$("#pw2CheckDiv, #pwCheckDiv").addClass("alert-success");
				$("#pw2CheckDiv, #pwCheckDiv").text("적당한 비밀번호 입니다.");
				pwCheck = true;
			} else {
				// 비밀번호와 비밀번호 확인이 같지 않은 경우
				$("#pwCheckDiv, #pw2CheckDiv").removeClass("alert-success");
				$("#pwCheckDiv, #pw2CheckDiv").addClass("alert-danger");
				$("#pw2CheckDiv").text("비밀번호와 비밀번호 확인이 같아야 합니다.");
				if(pw.length < 4)
					$("#pwCheckDiv").text("비밀번호는 4자 이상이여야 합니다.");
				else if(pw.length > 20)
					$("#pwCheckDiv").text("비밀번호는 20자 이내이여야 합니다.");
				else
					$("#pwCheckDiv").text("비밀번호와 비밀번호 확인이 같아야 합니다.");
			}
			
		});// pw2 function
		
		// 회원 가입 submit 이벤트 후 처리
		$("#writeForm").submit(function(){
			
			//alert("아이디 체크 : " + idCheck + "\n비밀번호 체크 : " + pwCheck);
			
			// 아이디 중복체크 - 사용 가능한 아이디 인지 확인
			if(!idCheck){
				alert("중복이 되지 않는 적당한 형식의 아이디를 사용하셔야만 합니다.");
				$("#id").focus();
				// form 전송을 무시시킨다.
				return false;
			}
			// 비밀번호 체크
			if(!pwCheck){
				alert("비밀번호와 비밀번호 확인의 길이가 4~20 이여야 하고 같아야 합니다.");
				$("#pw").focus();
				// form 전송을 무시시킨다.
				return false;
			}
			// 닉네임 중복 체크
			if(!nickCheck){
				alert("중복이 되지 않는 적당한 형식의 아이디를 사용해야 합니다.");
				$("#nickname").focus();
				// form 전송을 무시시킨다.
				return false;
			}
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
			// form 전송을 무시시킨다. -> 나중에 꼭 주석처리
			//return false;
			
		}); // writeForm submit function
		
	}); // main function
</script>
</head>
<body>
<div class="container">
	<h2>회원 가입 폼</h2>
	<form action="write.do" method="post" enctype="multipart/form-data" id="writeForm">
		<div class="form-group">
			<label for="id">아이디</label>
			<input name="id" id="id" class="form-control" required="required" pattern="[A-Za-z0-9]{4,20}" placeholder="아이디 입력">
			<div class="alert alert-danger" id="idCheckDiv">아이디는 4자 이상의 영숫자를 입력하셔야 합니다.</div>
		</div>
		<div class="form-group">
			<label for="pw">비밀번호</label>
			<input name="pw" id="pw" class="form-control" required="required" pattern=".{4,20}" placeholder="비밀번호 입력" type="password">
			<div id="pwCheckDiv" class="alert alert-danger">비밀번호는 4자 이상이어야 합니다.</div>
		</div>
		<div class="form-group">
			<label for="pw2">비밀번호 확인</label>
			<input name="pw2" id="pw2" class="form-control" required="required" pattern=".{4,20}" placeholder="비밀번호 확인" type="password">
			<div id="pw2CheckDiv" class="alert alert-danger">비밀번호는 4자 이상이어야 합니다.</div>
		</div>
		<div class="form-group">
			<label for="nickname">닉네임</label>
			<input name="nickname" id="nickname" class="form-control" required="required" pattern=".{2,20}" placeholder="이름 입력">
			<div id="nickCheckDiv" class="alert alert-danger">닉네임은 2자 이상 20자 이하로 입력해야 합니다.</div>
		</div>
		<div class="form-group">
			<label for="name">이름</label>
			<input name="name" id="name" class="form-control" required="required" pattern="[가-힣]{2,10}" placeholder="이름 입력">
		</div>
		<div class="form-group">
			<label>성별</label>
			<div>
				<label class="radio-inline"><input name="gender" type="radio" value="남자" checked>남자</label>
				<label class="radio-inline"><input name="gender" type="radio" value="여자">여자</label>
			</div>
		</div>
		<div class="form-group">
			<label for="birth">생년월일</label>
			<input name="birth" id="birth" class="form-control datepicker" required="required" placeholder="yyyy-mm-dd" autocomplete="off">
		</div>
		<div class="form-group">
			<label for="tel">연락처</label>
			<input name="tel" id="tel" class="form-control" required="required" placeholder="연락처 입력">
		</div>
		<div class="form-group">
			<label for="email">이메일</label>
			<input name="email" id="email" class="form-control" required="required" placeholder="이메일 입력">
		</div>
		<div class="form-group">
			<label for="photoFile">사진</label>
			<input id="photoFile" name="photoFile" type="file">
		</div>
		<button class="btn btn-default">가입</button>
	</form>
</div>
</body>
</html>
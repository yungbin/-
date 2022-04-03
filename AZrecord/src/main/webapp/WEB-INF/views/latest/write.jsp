<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>음원 등록</title>
<script type="text/javascript">
$(function(){
	
	$("#writeForm").submit(function(){
		if(!lengthCheck("#songName", "음원명", 4, 30)) return false;
		if(!lengthCheck("#content", "내용", 4, 1000)) return false;
		
		function lengthCheck(objStr, itemName, minLen, maxLen){
			// len 변수 생성후 항목(objStr)의 데이터값(val)의 길이(length)를 넣는다.
			var len = $(objStr).val().length;
			// 최소 길이나 최대 길이가 안맞으면
			if(!(len >= minLen && len <= maxLen)){
				// 해당 항목(itemName)은 최소(minLen) ~ 최대(maxLen) 자로 적어야한다고 알려준다.
				alert(itemName + "은(는) " + minLen + " ~ " + maxLen + " 자 이내로 작성하셔야 합니다.");
				// 커서를 입력란에 위치 시킨다.
				$(objStr).focus();
				// 길이 제한이 안맞으면 false를 리턴한다.
				return false;
			}
			return true;
		}
	});
});
</script>
</head>
<body>
<div class="container">
<h2>음원 등록</h2>
<form action="write.do" method="post" enctype="multipart/form-data" id="writeForm">
	<input name="perPageNum" type="hidden" value="${param.perPageNum }" >
	<div class="form-group">
		<label>음원명</label>
		<input name="songName" id="songName" class="form-control" required="required">
	</div>
	<div class="form-group">
		<label>아티스트</label>
		<input name="nickname" id="nickname" class="form-control" value="${login.nickname }" readonly="readonly" 
		required="required">
	</div>
	<div class="form-group">
		<label>아이디</label>
		<input name="id" class="form-control" value="${login.id }" readonly="readonly">
	</div>
	<div class="form-group">
		<label>장르</label>
		<select name="genre" class="form-control">
			<option value="ballad">발라드</option>
			<option value="rock">락</option>
			<option value="electronic">일렉트로닉</option>
			<option value="jazz">재즈</option>
			<option value="pop">팝</option>
			<option value="chill">칠아웃</option>
		</select>
	</div>
	<div class="form-group">
		<label>내용</label>
		<textarea rows="7" name="content" id="content" class="form-control" required="required"></textarea>
	</div>
	<div class="form-group">
		<label>음원</label>
		<input name="songFileName" required="required" type="file" class="form-control">
	</div>
	<!-- 이미지는 필수항목이 아니다. 입력이 없으면 noImage가 자동으로 세팅된다. -->
	<div class="form-group">
		<label>이미지</label>
		<input name="imageFileName" type="file" class="form-control">
	</div>
	<button class="btn btn-default">등록</button>
	<button type="reset" class="btn btn-default">새로입력</button>
	<button type="button" onclick="history.back()" class="btn btn-default">취소</button>
</form>
</div>
</body>
</html>
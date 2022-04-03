<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 글쓰기 폼</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
  
  <script type="text/javascript">
  	$(function(){
  		$("#cancelBtn").click(function(){
  			history.back();
  		});
  		
  		$("#writeForm").submit(function(){
  	  		var len = $("#content").val().length;
  	  		if(!(len >= 4 && len <= 1000)){
  				// 해당 항목(itemName)은 최소(minLen) ~ 최대(maxLen) 자로 적어야한다고 알려준다.
  				alert("내용은 4자 에서 1000자 까지입니다.");
  				// 커서를 입력란에 위치 시킨다.
  				$("#content").focus();
  				// 길이 제한이 안맞으면 false를 리턴한다.
  				return false;
  			}
  		});
  	});
  </script>
</head>
<body>
<div class="container">
<h2>게시판 글쓰기 폼</h2>
<form action="write.do" method="post" id="writeForm">
<input type="hidden" name="perPageNum" value="${param.perPageNum }">
<div class="form-group">
	<label>제목</label>
	<!-- 4 ~ 20자 -->
	<input name="title" id="title" class="form-control" pattern=".{4,20}" required="required">
</div>
<div class="form-group">
	<label>주제</label>
	<select name="theme" class="form-control">
		<option value="talk">잡담</option>
		<option value="info">정보</option>
		<option value="pr">홍보</option>
	</select>
</div>
<div class="form-group">
	<label>내용</label>
	<!-- 1 ~ 3000자 -->
	<textarea name="content" id="content" class="form-control" rows="7" required="required"></textarea>
</div>
<div class="form-group">
	<label>작성자</label>
	<input name="nickname" id="nickname" class="form-control" value="${login.nickname }" readonly="readonly">
</div>
<div class="form-group">
	<label>아이디</label>
	<input name="id" id="id" class="form-control" value="${login.id }" readonly="readonly">
</div>
<button class="btn btn-default">등록</button>
<button type="reset" class="btn btn-default">새로입력</button>
<button type="button" id="cancelBtn" class="btn btn-default">취소</button>
</form>
</div>
</body>
</html>
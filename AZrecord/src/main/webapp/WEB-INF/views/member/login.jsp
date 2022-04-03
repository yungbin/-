<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인 폼</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
  <script type="text/javascript">
  	$(function(){
  		$("#cancelBtn").click(function(){
  			history.back();
  		});
  	});
  </script>
</head>
<body>
<div class="container">
<h2>로그인 폼</h2>
<form action="login.do" method="post">
<div class="form-group">
	<label>아이디</label>
	<input name="id" id="id" class="form-control">
</div>
<div class="form-group">
	<label>비밀번호</label>
	<input type="password" name="pw" id="pw" class="form-control">
</div>
<button class="btn btn-default">로그인</button>
<button type="reset" class="btn btn-default">새로입력</button>
<button type="button" id="cancelBtn" class="btn btn-default">취소</button>
</form>
</div>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>404 No Page</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
</head>
<body>
	<div class="container">
		<h2>404 No Page</h2>
		<div class="alert alert-danger">
			잘못된 요청을 하셨습니다.
		</div>
		<ul class="list-group">
				<li class="list-group-item">404 오류</li>
				<li class="list-group-item">주소를 확인 후 다시 시도해 보세요.</li>
				<li class="list-group-item">계속 페이지를 찾지 못하면 담당자에게 연락해주세요.</li>
				<li class="list-group-item">담당자 : 홍길동 010-0000-0001</li>
				<li class="list-group-item">
					<a href="/main/main.do" class="btn btn-default">메인으로 이동</a>
				</li>
		</ul>
	</div>
</body>
</html>
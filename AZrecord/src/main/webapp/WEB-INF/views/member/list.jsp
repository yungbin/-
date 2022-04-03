<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="pageNav" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 리스트</title>
<script type="text/javascript">
	$(function(){
		$(".dataRow").click(function(){
			var id = $(this).find(".id").text();
			location = "view.do?id=" + id + "&page=${pageObject.page}&perPageNum=${pageObject.perPageNum}";
		});
	});
</script>
</head>
<body>
<div class="container">
<h2>회원 리스트</h2>
<table class="table">
	<tr>
		<th>사진</th>
		<th>아이디</th>
		<th>닉네임</th>
		<th>이름</th>
		<th>생년월일</th>
		<th>성별</th>
		<th>연락처</th>
		<th>이메일</th>
		<th>상태</th>
		<th>등급번호</th>
		<th>등급명</th>
	</tr>
	<c:forEach items="${list }" var="vo">
		<tr class="dataRow">
			<td><img alt="사진" src="${vo.photo }" class="img-rounded" style="width: 30px; height: 40px;"></td>
			<td class="id">${vo.id }</td>
			<td>${vo.nickname }</td>
			<td>${vo.name }</td>
			<td><fmt:formatDate value="${vo.birth }" pattern="yyyy-MM-dd"/></td>
			<td>${vo.gender }</td>
			<td>${vo.tel }</td>
			<td>${vo.email }</td>
			<td>${vo.status }</td>
			<td>${vo.gradeNo }</td>
			<td>${vo.gradeName }</td>
		</tr>
	</c:forEach>
	<tr>
		<td colspan="9"><pageNav:pageNav listURI="list.do" pageObject="${pageObject }"/></td>
	</tr>
</table>
</div>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<table class="table">
	<tr>
		<th>번호</th>
		<th>주제</th>
		<th>제목</th>
		<th>작성자</th>
		<th>작성일</th>
		<th>조회수</th>
	</tr>
	<c:forEach items="${boardList }" var="vo" begin="0" end="4">
		<tr class="boardDataRow" data-no="${vo.no }">
			<td>${vo.no }</td>
			<td>[
			<c:choose>
				<c:when test="${vo.theme == 'talk'}">
				잡담
				</c:when>
				<c:when test="${vo.theme == 'info'}">
				정보
				</c:when>
				<c:when test="${vo.theme == 'pr'}">
				홍보
				</c:when>
			</c:choose>
			]</td>
			<td>${vo.title }</td>
			<td>${vo.nickname }</td>
			<td><fmt:formatDate value="${vo.writeDate }" pattern="yyyy-MM-dd"/></td>
			<td>${vo.hit }</td>
		</tr>
	</c:forEach>
</table>
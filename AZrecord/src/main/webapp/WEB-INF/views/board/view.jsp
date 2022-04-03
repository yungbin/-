<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 글보기</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<script type="text/javascript">
	$(function(){
		
		// 삭제 버튼 이벤트 처리
		$("#deleteBtn").click(function(){
			// 사용자에게 확인/취소 선택 창 열기 - confirm : 확인 - true, 취소 - false.
			// alert(confirm("정말 삭제 하시겠습니까?"));
			return confirm("정말 삭제 하시겠습니까?");
			// 페이지 이동을 막는다. -> 개발 끝나면 주석처리.
			// return false;
		});
		
	});
</script>
<style type="text/css">
.jumbotron{
	background: white;
	border: 1px solid #d6e9c6;
}
</style>
</head>
<body>
<div class="container">
<h2 style="color: #42B32F">게시판 글보기</h2>
<br>
<div class="row">
	<div class="col-sm-2">
		<div class="panel panel-success">
		    <div class="panel-heading">번호</div>
		    <div class="panel-body">${vo.no }</div>
		</div>
	</div>
	<div class="col-sm-8">
		<div class="panel panel-success">
		    <div class="panel-heading">제목</div>
		    <div class="panel-body">${vo.title }</div>
		</div>
	</div>
	<div class="col-sm-2">
		<div class="panel panel-success">
		    <div class="panel-heading">주제</div>
		    <div class="panel-body">
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
		    </div>
		</div>
	</div>
</div>
<div class="row">
	<div class="col-sm-12">
		<div class="jumbotron">
			${vo.content}
		</div>
	</div>
</div>
<div class="row" style="margin-bottom: 20px">
	<div class="col-sm-12">
		<div id="btnDiv">
			<!-- 본인 계정인 경우에만 삭제 수정처리가 보임. -->
			<c:if test="${!empty login && login.id == vo.id }">
				<a href="update.do?no=${vo.no }&inc=0&page=${param.page }&perPageNum=${param.perPageNum}
				&key=${param.key}&word=${param.word}&period=${param.period}" class="btn btn-default">수정</a>
				<a href="delete.do?no=${vo.no }&perPageNum=${param.perPageNum}" class="btn btn-default" id="deleteBtn">삭제</a>
			</c:if>
			<a href="list.do?page=${param.page}&perPageNum=${param.perPageNum}
			&key=${param.key}&word=${param.word}&period=${param.period}" class="btn btn-default">리스트</a>
		</div>
	</div>
</div>
<div class="row">
	<div class="col-sm-3">
		<div class="panel panel-success">
		    <div class="panel-heading">작성자</div>
		    <div class="panel-body">${vo.nickname }</div>
		</div>
	</div>
	<div class="col-sm-3">
		<div class="panel panel-success">
		    <div class="panel-heading">작성일</div>
		    <div class="panel-body">
		    	<fmt:formatDate value="${vo.writeDate }" pattern="yyyy-MM-dd"/>
		    </div>
		</div>
	</div>
	<div class="col-sm-4"></div>
	<div class="col-sm-2">
		<div class="panel panel-success">
		    <div class="panel-heading">조회수</div>
		    <div class="panel-body">${vo.hit }</div>
		</div>
	</div>
</div>
</div>
</body>
</html>
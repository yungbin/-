<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>음원 정보 보기</title>
<style type="text/css">
#btnDiv{
	margin-top: 20px;
}
</style>
<script type="text/javascript">
	$(function(){
		
		// 삭제 버튼 이벤트 처리
		$(".deleteBtn").click(function(){
			// 사용자에게 확인/취소 선택 창 열기 - confirm : 확인 - true, 취소 - false.
			// alert(confirm("정말 삭제 하시겠습니까?"));
			return confirm("삭제한 음원은 되돌릴 수 없습니다. 정말 삭제 하시겠습니까?");
			// 페이지 이동을 막는다. -> 개발 끝나면 주석처리.
			// return false;
		});
		
	});
</script>
</head>
<body>
<div class="container">
<h2 style="color: #42B32F">음원 정보 보기</h2>
<br>
<div class="row">
	<div class="col-sm-4">
		<div class="col-sm-12">
			<img alt="image" src="${vo.songImage }" style="width: 300px; height: 300px;" class="img-rounded">
		</div>
	</div>
	<div class="col-sm-1"></div>
	<div class="col-sm-6">
		<div class="col-sm-4">
			<h2><span class="label label-default">음원명</span></h2>
		</div>
		<div class="col-sm-8">
			<h2>${vo.songName }</h2>
		</div>
		<div class="col-sm-4">
			<h2><span class="label label-default">아티스트</span></h2>
		</div>
		<div class="col-sm-8">
			<h2>${vo.nickname }</h2>
		</div>
		<div class="col-sm-4">
			<h2><span class="label label-default">장르</span></h2>
		</div>
		<div class="col-sm-8">
			<h2>
			<c:choose>
				<c:when test="${vo.genre eq 'ballad' }">발라드</c:when>
				<c:when test="${vo.genre eq 'rock' }">락</c:when>
				<c:when test="${vo.genre eq 'electronic' }">일렉트로닉</c:when>
				<c:when test="${vo.genre eq 'jazz' }">재즈</c:when>
				<c:when test="${vo.genre eq 'pop' }">팝</c:when>
				<c:when test="${vo.genre eq 'chill' }">칠아웃</c:when>
			</c:choose>
			</h2>
		</div>
		<div class="col-sm-4">
			<h2><span class="label label-default">등록일</span></h2>
		</div>
		<div class="col-sm-8">
			<h2>
				<fmt:formatDate value="${vo.writeDate }" pattern="yyyy-MM-dd"/>
			</h2>
		</div>
		<div class="col-sm-4">
			<h2><span class="glyphicon glyphicon-eye-open" style="margin: 0 10px"></span></h2>
		</div>
		<div class="col-sm-8">
			<h2>${vo.hit}</h2>
		</div>
	</div>
	<div class="col-sm-1"></div>
</div>
<div class="row" id="btnDiv">
	<div class="col-sm-12">
		<!-- 로그인을 했으며, 자기 글인경우 보인다. -->
		<c:if test="${!empty login && login.nickname eq vo.nickname }">
			<a href="update.do?code=${vo.code }&page=${param.page}&perPageNum=${param.perPageNum}
			&key=${param.key}&word=${param.word}&period=${param.period}" class="btn btn-default">수정</a>
			<a href="delete.do?code=${vo.code}&deleteImage=${vo.songImage}&deleteSong=${vo.song}"
			class="btn btn-default deleteBtn">삭제</a>
		</c:if>
		<a href="list.do?page=${param.page}&perPageNum=${param.perPageNum}
		&key=${param.key}&word=${param.word}&period=${param.period}" class="btn btn-default">리스트</a>
	</div>
</div>
<div class="row" id="contentDiv" style="margin-top: 20px;">
	<div class="col-sm-12">
		<br>
			<h2>INFO</h2>
		<br>
		<audio src="${vo.song }" controls="controls"  preload="auto" onloadstart="this.volume=0.5"></audio>
		<br>
			<h2>설명</h2>
		<br>
		<div class="well well-lg">
			${vo.content }
		</div>
	</div>
</div>
</div>
</body>
</html>
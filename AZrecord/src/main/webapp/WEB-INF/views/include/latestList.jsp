<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<div id="myCarousel" class="carousel slide" data-ride="carousel" style="width: 1000px; height: 600px;
filter: drop-shadow(-10px 10px 10px #194d33);">
	<!-- 그림 밑에 동그란 점 갯수 -->
	<ol class="carousel-indicators">
		<c:forEach items="${latestList}" var="vo" varStatus="vs" begin="0" end="4">
			<li data-target="#myCarousel" data-slide-to="${vs.count - 1 }" ${(vs.count == 1)?'class="active"':''}></li>
		</c:forEach>
	</ol>

	<!-- 사진들 -->
	<div class="carousel-inner">
		<c:forEach items="${latestList}" var="vo" varStatus="vs" begin="0" end="4">
			<div class="item ${(vs.count == 1)?'active':''} imageDataRow" data-code="${vo.code}">
				<img alt="${vo.songImage }" src="${vo.songImage }" style="width: 1000px; height: 600px;">
				<div class="carousel-caption">
	         		<h3>${vo.songName }</h3>
	        		<p>${vo.nickname }</p>
        		</div>  
			</div>
		</c:forEach>
	</div>

	<!-- 왼쪽 오른쪽 화살표 -->
	<a class="left carousel-control" href="#myCarousel" data-slide="prev">
		<span class="glyphicon glyphicon-chevron-left"></span> <span
		class="sr-only">Previous</span>
	</a> <a class="right carousel-control" href="#myCarousel" data-slide="next">
		<span class="glyphicon glyphicon-chevron-right"></span> <span
		class="sr-only">Next</span>
	</a>
<!-- carousel end -->
</div>
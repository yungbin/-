<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="pageNav" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>인기 차트</title>
<style type="text/css">
.gallery-title
{
    font-size: 36px;
    color: #42B32F;
    text-align: center;
    font-weight: 500;
    margin-bottom: 70px;
}
.gallery-title:after {
    content: "";
    position: absolute;
    width: 7.5%;
    left: 46.5%;
    height: 45px;
    border-bottom: 1px solid #5e5e5e;
}
.filter-button
{
    font-size: 18px;
    border: 1px solid #42B32F;
    border-radius: 5px;
    text-align: center;
    color: #42B32F;
    margin-bottom: 30px;

}
.filter-button:hover
{
    font-size: 18px;
    border: 1px solid #42B32F;
    border-radius: 5px;
    text-align: center;
    color: #ffffff;
    background-color: #42B32F;

}
.btn-default:active .filter-button:active
{
    background-color: #42B32F;
    color: white;
}
.dataRow:hover {
	background: #eee;
	cursor: pointer;
}
</style>
<script type="text/javascript">
$(function() {
    $(".dataRow").click(function() {
        var code = $(this).data("code");
        var url = "/"
        if ($(this).hasClass("dataRow"))
            url = url + "latest";
        url += "/view.do?code=" + code + "&inc=1&page=1&perPageNum=10&period=all";
        location = url;
    });
});
</script>
</head>
<body>
<div class="container">
<!-- //// -->
<div class="row">
	<div class="gallery col-lg-12 col-md-12 col-sm-12 col-xs-12">
		<h1 class="gallery-title">
		<c:choose>
			<c:when test="${pageObject.period == 'hit' }">
			조회수 랭킹
			</c:when>
			<c:when test="${pageObject.period == 'recom' }">
			추천수 랭킹
			</c:when>
		</c:choose>
		</h1>
	</div>
	<div align="center">
		<a href="list.do?page=${pageObject.page }&perPageNum=${pageObject.perPageNum}&period=hit">
			<button class="btn btn-default filter-button">조회수</button>
		</a>
		<a href="list.do?page=${pageObject.page }&perPageNum=${pageObject.perPageNum}&period=recom">
			<button class="btn btn-default filter-button">추천수</button>
		</a>
	</div>
</div>
<br/>
<!-- //// -->
	<table class="table">
		<tr>
			<th>순위번호</th>
			<th></th>
			<th>음원명</th>
			<th>아티스트</th>
			<th>추천수</th>
			<th>조회수</th>
		</tr>
		<c:forEach items="${list }" var="vo">
			<tr class="dataRow" data-code="${vo.code }">
				<td>${vo.rnum }</td>
				<td><img alt="${vo.songImage }" src="${vo.songImage }" style="width:60px; height:60px;"></td>
				<td>${vo.songName }</td>
				<td>${vo.nickname }</td>
				<td>${vo.recom }</td>
				<td>${vo.hit }</td>
			</tr>
		</c:forEach>
		<tr>
			<td colspan="6" style="text-align: center;">
				<pageNav:pageNav listURI="list.do" pageObject="${pageObject }"/>
			</td>
		</tr>
	</table>
</div>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="pageNav" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>음원 리스트</title>
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
	cursor: pointer;
}
</style>
</head>
<body>
<div class="container">
<!-- //// -->
<div class="row">
	<div class="gallery col-lg-12 col-md-12 col-sm-12 col-xs-12">
		<h1 class="gallery-title">
		<c:choose>
			<c:when test="${pageObject.period == 'all' }">
			최신 음원
			</c:when>
			<c:when test="${pageObject.period == 'ballad' }">
			발라드
			</c:when>
			<c:when test="${pageObject.period == 'rock' }">
			락
			</c:when>
			<c:when test="${pageObject.period == 'electronic' }">
			일렉트로닉
			</c:when>
			<c:when test="${pageObject.period == 'jazz' }">
			재즈
			</c:when>
			<c:when test="${pageObject.period == 'pop' }">
			POP
			</c:when>
			<c:when test="${pageObject.period == 'chill' }">
			ChillOut
			</c:when>
		</c:choose>
		</h1>
	</div>
	<div align="center">
		<a href="list.do?page=${pageObject.page }&perPageNum=${pageObject.perPageNum}&period=all">
			<button class="btn btn-default filter-button">전체</button>
		</a>
		<a href="list.do?page=${pageObject.page }&perPageNum=${pageObject.perPageNum}&period=ballad">
			<button class="btn btn-default filter-button">발라드</button>
		</a>
		<a href="list.do?page=${pageObject.page }&perPageNum=${pageObject.perPageNum}&period=rock">
			<button class="btn btn-default filter-button">락</button>
		</a>
		<a href="list.do?page=${pageObject.page }&perPageNum=${pageObject.perPageNum}&period=electronic">
			<button class="btn btn-default filter-button">일렉트로닉</button>
		</a>
		<a href="list.do?page=${pageObject.page }&perPageNum=${pageObject.perPageNum}&period=jazz">
			<button class="btn btn-default filter-button">재즈</button>
		</a>
		<a href="list.do?page=${pageObject.page }&perPageNum=${pageObject.perPageNum}&period=pop">
			<button class="btn btn-default filter-button">팝</button>
		</a>
		<a href="list.do?page=${pageObject.page }&perPageNum=${pageObject.perPageNum}&period=chill">
			<button class="btn btn-default filter-button">ChillOut</button>
		</a>
	</div>
</div>
<br/>
<!-- //// -->
<div class="row" style="margin-bottom: 15px;">
	<!-- 검색에 대한 div -->
	<div class="col-md-8">
		<form class="form-inline">
		<input type="hidden" name="perPageNum" value="${pageObject.perPageNum }">
			<div class="input-group">
			  	<select name="key" class="form-control">
			  		<option value="n" ${(pageObject.key == "n")? "selected":"" }>음원명</option>
			  		<option value="a" ${(pageObject.key == "a")? "selected":"" }>작성자</option>
			  		<option value="c" ${(pageObject.key == "c")? "selected":"" }>내용</option>
			  		<option value="na" ${(pageObject.key == "na")? "selected":"" }>음원명/작성자</option>
			  		<option value="nc" ${(pageObject.key == "nc")? "selected":"" }>음원명/내용</option>
			  		<option value="ac" ${(pageObject.key == "ac")? "selected":"" }>작성자/내용</option>
			  		<option value="nac" ${(pageObject.key == "nac")? "selected":"" }>전체</option>
			  	</select>
			</div>
		  <div class="input-group">
		    <input type="text" class="form-control" placeholder="Search" name="word" value="${pageObject.word }">
		    <div class="input-group-btn">
		      <button class="btn btn-default" type="submit">
		        <i class="glyphicon glyphicon-search"></i>
		      </button>
		    </div>
		  </div>
		</form>
	</div>
</div>
<!-- ////// -->
	<div class="row">
	 	<!-- clo-md-3 : 한 줄에 사진 4장 표시 3 * 4 = 12 -->
	<c:forEach items="${list }" var="vo" varStatus="vs">
	  <div class="col-md-3">
	    <div class="thumbnail dataRow" 
	    onclick="location='view.do?code=${vo.code }&inc=1&page=${pageObject.page }&perPageNum=${pageObject.perPageNum }&key=${pageObject.key }&word=${pageObject.word }&period=${pageObject.period }'">
	        <img src="${vo.songImage }" alt="Photo List" style="width:100%; height: 300px;">
	        <div class="caption">
	          <p>${vo.songName }</p>
	          ${vo.nickname }
	        </div>
	    </div>
	  </div>
		<c:if test="${vs.count % 4 == 0 && vs.count != list.size()}">
		  <!-- 한 줄을 마감하고 새로운 줄을 시작한다. -->
		  ${"</div>" }
		  ${"<div class='row'>" }
		</c:if>
	</c:forEach>
	</div>
	<div style="text-align:center">
		<pageNav:pageNav listURI="list.do" pageObject="${pageObject }" 
			query="&key=${pageObject.key }&word=${pageObject.word }&period=${pageObject.period }"/>
	</div>
	<!-- 로그인한 회원만 보인다. -->
	<c:if test="${!empty login }">
		<div>
			<a href="write.do?perPageNum=${pageObject.perPageNum}" class="btn btn-default">곡 등록</a>
		</div>
	</c:if>
</div>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${title }</title>
<script type="text/javascript">
$(function(){
	$(".deleteBtn").click(function(){
		$(".deleteDiv").show();
	});
	$("#deleteDivClose").click(function(){
		$(".deleteDiv").hide();
	});
});
</script>
<style type="text/css">
.deleteDiv{
	display: none;
}
</style>
</head>
<body>
<div class="container">
<h2>${title }</h2>
<table class="table">
	<tr>
		<th>아이디</th>
		<td>${vo.id }</td>
	</tr>
	<tr>
		<th>이름</th>
		<td>${vo.name}</td>
	</tr>
	<tr>
		<th>닉네임</th>
		<td>${vo.nickname}</td>
	</tr>
	<tr>
		<th>성별</th>
		<td>${vo.gender}</td>
	</tr>
	<tr>
		<th>생년월일</th>
		<td><fmt:formatDate value="${vo.birth }" pattern="yyyy-MM-dd"/></td>
	</tr>
	<tr>
		<th>연락처</th>
		<td>${vo.tel}</td>
	</tr>
	<tr>
		<th>이메일</th>
		<td>${vo.email}</td>
	</tr>
	<tr>
		<th>가입일</th>
		<td><fmt:formatDate value="${vo.regDate }" pattern="yyyy-MM-dd"/></td>
	</tr>
	<tr>
		<th>사진</th>
		<td><img alt="${vo.photo }" src="${vo.photo }" style="width: 300px; height: 400px;"></td>
	</tr>
	<tr>
		<th>등급</th>
		<td>${vo.gradeName }</td>
	</tr>
	<tr>
		<td colspan="2">
		<c:if test="${empty param.id}">
			<a href="update.do?id=${vo.id }&oldPhoto=${vo.photo }" class="btn btn-default">정보 수정</a>
			<a class="btn btn-default deleteBtn">회원탈퇴</a>
			<div class="deleteDiv">
				<form action="delete.do">
					<div class="form-group">
						<label for="id">아이디</label>
						<input name="id" id="id" placeholder="본인의 아이디 입력" class="form-control">
					</div>
					<div class="form-group">
						<label for="pw">비밀번호</label>
						<input name="pw" id="pw" placeholder="본인의 패스워드 입력" class="form-control">
					</div>
					<button class="btn btn-default">입력</button>
					<button type="button" id="deleteDivClose" class="btn btn-default">취소</button>
				</form>
			</div>
		</c:if>
		<c:if test="${login.gradeNo == 9 && !empty param.id && login.id != vo.id }">
			<form action="changeStatus.do" method="post">
				<input type="hidden" name="id" value="${vo.id}">
				<input type="hidden" name="page" value="${param.page}">
				<input type="hidden" name="perPageNum" value="${param.perPageNum}">
				<div class="input-group">
					<select name="status" class="form-control">
						<option ${(vo.status == "정상")?"selected":"" }>정상</option>
						<option ${(vo.status == "탈퇴")?"selected":"" }>탈퇴</option>
						<option ${(vo.status == "강퇴")?"selected":"" }>강퇴</option>
						<option ${(vo.status == "휴면")?"selected":"" }>휴면</option>
					</select>
					<div class="input-group-btn">
						<button class="btn btn-default">변경</button>
					</div>
				</div>
			</form>
			<!-- 등급 변경 -->
			<form action="changeGradeNo.do" method="post">
				<input type="hidden" name="id" value="${vo.id }">
				<input type="hidden" name="page" value="${param.page }">
				<input type="hidden" name="perPageNum" value="${param.perPageNum}">
				<div class="input-group">
					<select name="gradeNo" class="form-control">
						<option ${(vo.gradeNo == 1)?"selected":"" } value="1">일반</option>
						<option ${(vo.gradeNo == 9)?"selected":"" } value="9">관리자</option>
					</select>
					<div class="input-group-btn">
						<button class="btn btn-default">변경</button>
					</div>
				</div>
			</form>
			<a href="changeGradeNo.do" class="btn btn-default">등급 변경</a>
		</c:if>
		</td>
	</tr>
</table>
</div>
</body>
</html>
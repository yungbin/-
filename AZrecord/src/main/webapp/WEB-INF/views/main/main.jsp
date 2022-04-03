<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>진달래 코드</title>
<script type="text/javascript">
$(function() {
    $(".imageDataRow").click(function() {
        var code = $(this).data("code");
        var url = "/"
        if ($(this).hasClass("imageDataRow"))
            url = url + "latest";
        url += "/view.do?code=" + code + "&inc=1&page=1&perPageNum=10&period=${pageObject.period}";
        location = url;
    });
    $(".boardDataRow").click(function() {
        var no = $(this).data("no");
        var url = "/"
        if ($(this).hasClass("boardDataRow"))
            url = url + "board";
        url += "/view.do?no=" + no + "&inc=1&page=1&perPageNum=10&period=${pageObject.period}";
        location = url;
    });
});
</script>
<style type="text/css">
.imageDataRow:hover{
	cursor: pointer;
}
.boardDataRow:hover{
	background: #eee;
	cursor: pointer;
}
#boardMainDiv{
	margin-top: 300px;
	margin-bottom: 300px;
}
</style>
</head>
<body>
	<div class="container">
		<div id="imageMainDiv">
			<h1>최신 음악</h1>
			<br>
			<div class="row" id="latestMain">
				<div class="col-md-12">
					<jsp:include page="/WEB-INF/views/include/latestList.jsp" />
				</div>
			</div>
		</div>
		<div id="boardMainDiv">
			<h1>자유게시판</h1>
			<br>
			<div class="row" id="boardMain">
				<div class="col-md-12">
					<jsp:include page="/WEB-INF/views/include/boardList.jsp" />
				</div>
			</div>
		</div>
	</div>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" Content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width, target-densitydpi=medium-dpi " />
<meta name="format-detection" content="telephone=no">
<script src="<c:url value="/resources/segroup/js/jquery-3.1.1.js" />"></script>
<script src="<c:url value="/resources/segroup/society/edu/js/slidebanner.js" />"></script>
<head>
<title></title>
<script src="<c:url value="/resources/segroup/society/edu/js/jquery.bxslider.min.js" />"></script>
<!-- bxSlider CSS file -->
<link href="<c:url value="/resources/segroup/society/edu/css/jquery.bxslider.css" />" rel="stylesheet" />
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/segroup/society/edu/css/common.css" />">
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/segroup/society/edu/css/sub.css" />">
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/segroup/society/edu/css/main.css" />">
<style>
.sub_top_img {
	width: 984px;
	height: 300px;
}

body .info1 {
	overflow: hidden;
	text-overflow: ellipsis;
	white-space: nowrap;
	width: 500px;
	height: 50px;
}

#page a {
	display: inline;
}

.center-cropped {
	object-fit: cover; /* Do not scale the image */
	object-position: center; /* Center the image within the element */
	height: 190px;
	width: 341px;
}

#boardContent {
	text-align: initial;
	padding-left: 50px;
}
</style>
<script>
	$(document).ready(function() {
		$("#btnWrite").click(function() {
			// 페이지 주소 변경(이동)
			location.href = "/board/write.do";
		});
		if ($(".imageContent img").width() > 1100) {
			$(".imageContent img").css("width", "100%");
			$(".imageContent img").css("height", "auto");
		}
	});

	function goToNear(seq, nearType) {
		location.href = "/edu/apply/image_notice_detail.do?seq=" + seq + "&searchOption=" + nearType;
	}

	function goToList() {
		location.href = "/edu/apply/image_notice.do";
	}
</script>
</head>
<body>
	<%@include file="../menu.jsp"%>
	<div class="main_m_contents">
		<div class="main_notice_wrap1">
			<div class="main_notice_title1">
				<h1>보도자료</h1>
			</div>
			<hr>
			<%-- ${status.count } --%>
			<header style="background: #f5f5f5;">
				<h2 style="padding: 20px;">${imageBoardDetail.board_content_title}</h2>
			</header>
			<hr>
			<br>
			<span style="display: inline; text-align: right;">
				<div>
					<h5>
						<span style="padding-right: 20px;"> 게시자 : ${imageBoardDetail.board_content_nm } </span>
						<span style="padding-right: 20px;"> 날짜 : ${imageBoardDetail.board_content_udt_dt } </span>
						<span style="padding-right: 20px;"> 조회수 : ${imageBoardDetail.board_content_hit } </span>
					</h5>
				</div>
			</span>
			<br> <br>
			<span class="imageContent" style="word-wrap: break-word;"> ${imageBoardDetail.board_content_ct } </span>
			<br> <br>
			<hr>
			<br> <br>
			<div class="gal_last">
				<div class="gal_write">
					<span style="width: 100%;">
						<c:if test="${boardDetail.board_content_seq_min != boardDetail.board_content_seq}">
							<input type="button" onclick="goToNear('${boardDetail.board_content_seq}' ,'previous')" name="" value="이전글">
						</c:if>
						<c:if test="${boardDetail.board_content_seq_max != boardDetail.board_content_seq}">
							<input type="button" onclick="goToNear('${boardDetail.board_content_seq}', 'next')" name="" value="다음글">
						</c:if>
						<input type="button" onclick="goToList()" name="" value="목록">
					</span>
				</div>
			</div>
		</div>
	</div>
	<%@include file="../footer.jsp"%>
</body>
</html>
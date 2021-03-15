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
<title>글로벌 엔지니어 양성</title>
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

.top_img {
	position: relative;
	background-image:
		url(/resources/segroup/society/edu/image/main/top_img/top_img_notice.jpg);
	height: 250px;
	background-size: cover;
}
</style>
<script>
	$(document).ready(function() {
		$("#btnWrite").click(function() {
			// 페이지 주소 변경(이동)
			location.href = "/board/write.do";
		});

	});

	function goToNear(seq, nearType) {
		location.href = "/edu/community/notice_detail.do?seq=" + seq + "&searchOption=" + nearType;
	}

	function goToList() {
		location.href = "/edu/community/notice.do";
	}
</script>
</head>
<body>
	<%@include file="../menu.jsp"%>
	<div class="top_img">
		<div class="top_img_text">
			<p class="top_img_text1">공지사항</p>
			<p class="top_img_text2">SES에서 알려드립니다!</p>
		</div>
	</div>
	<div style="overflow: hidden; width: 100%; height: 50px;"></div>
	<div class="main_m_contents">
		<div class="main_notice_wrap1">
			<header style="background: #f5f5f5;">
				<h2 style="padding: 20px;">${boardDetail.board_content_title}</h2>
			</header>
			<hr>
			<br>
			<span style="display: inline; text-align: right;">
				<div>
					<h5>
						<span style="padding-right: 20px;"> 게시자 : ${boardDetail.board_content_nm } </span>
						<span style="padding-right: 20px;"> 날짜 : ${boardDetail.board_content_udt_dt } </span>
						<span style="padding-right: 20px;"> 조회수 : ${boardDetail.board_content_hit } </span>
					</h5>
				</div>
			</span>
			<br> <br>
			<span class="imageContent""> ${boardDetail.board_content_ct } </span>
			<br> <br>
			<hr>
			<br>
			<c:if test="${fn:length(files) gt 0}">
				<h3>첨부파일</h3>
				<c:forEach var="data" items="${files}" varStatus="status">
					<br>
					<table>
						<tr class="notice_top" style="text-align: left;">
							<td class="notice_icon1">
								<a href="/file_download?origin=${data.board_file_origin}&saved=${data.board_file_saved}&path=${path}">${data.board_file_origin}</a>
							</td>
						</tr>
					</table>
				</c:forEach>
				<br>
				<hr>
				<br>
			</c:if>
			<br>
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
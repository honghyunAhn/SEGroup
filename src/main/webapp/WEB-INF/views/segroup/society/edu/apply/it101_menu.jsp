<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" Content="text/html; charset=utf-8" />
<!-- 
<meta name="viewport" content="width=device-width, target-densitydpi=medium-dpi " /> -->
<meta name="format-detection" content="telephone=no">
<script src="<c:url value="/resources/segroup/js/angular.min.js" />"></script>
<script src="<c:url value="/resources/segroup/js/jquery-3.1.1.js" />"></script>
<script
	src="<c:url value="/resources/segroup/society/edu/js/slidebanner.js" />"></script>
<head>
<title>글로벌 엔지니어 양성</title>
<script
	src="<c:url value="/resources/segroup/society/edu/js/jquery.bxslider.min.js" />"></script>
<!-- bxSlider CSS file -->
<link
	href="<c:url value="/resources/segroup/society/edu/css/jquery.bxslider.css" />"
	rel="stylesheet" />
<link rel="stylesheet" type="text/css"
	href="<c:url value="/resources/segroup/society/edu/css/common.css" />">
<link rel="stylesheet" type="text/css"
	href="<c:url value="/resources/segroup/society/edu/css/sub.css" />">
<link rel="stylesheet" type="text/css"
	href="<c:url value="/resources/segroup/society/edu/css/main.css" />">
<script type="text/javascript">
	function goCrcDetail(gisu_seq) {
		location.href = "/edu/apply/it101_detail?gisu_seq=" + gisu_seq;
	}

	$(function() {
		$(window).scroll(function() {
			if ($(this).scrollTop() > 10) {
				$('#MOVE_TOP_BTN').fadeIn();
			} else {
				$('#MOVE_TOP_BTN').fadeOut();
			}
		});

		$("#MOVE_TOP_BTN").click(function() {
			$('html, body').animate({
				scrollTop : 0
			}, 400);
			return false;
		});
	});
</script>
<style>
* {
    margin: 0px;
    padding: 0px;
}
body, html {
    height: 100%;
}
.top_img {
	position: relative;
	background-image:
		url(/resources/segroup/society/edu/image/main/top_img/top_img_it101.jpg);
	height: 250px;
	background-size: cover;
}
</style>
</head>
<body>
	<%@include file="../menu.jsp"%>
	<a id="MOVE_TOP_BTN" href="#none"><img
		src="/resources/segroup/society/edu/image/sub/top.png"
		style="width: 60px; height: 60px;" title="위로가기"></a>
	<div class="top_img">
		<div class="top_img_text">
			<p class="top_img_text1">IT101</p>
			<p class="top_img_text2">IT분야 전분가로 향하는 가장 빠른 길!</p>
		</div>
	</div>

	<div style="overflow: hidden; width: 100%; height: 50px;"></div>
	<div class="sub_m_contents">
		<div class="main_top_slidewrap">
			<div style="overflow: hidden; width: 100%; height: 50px;"></div>
			<!-- 			<div> -->
			<!-- 				<p>과정목록</p> -->
			<!-- 			</div> -->
			<c:if test="${fn:length(shortTermList) gt 0}">
				<div style="width: 100%; float: left; text-align: left;">
					<c:forEach var="data" items="${shortTermList }" varStatus="status">
						<div
							style="width: 33%; padding: 0px; float: left; text-align: left;">
							<ul>
								<li style="padding: 0px 0px 10px 31px;"><a
									style="font-size: 30px; font: bold;">${data.gisu_crc_nm }</a></li>
								<li><a href="javascript:goCrcDetail('${data.gisu_seq}')">
										<img
										src="/file_download?origin=&saved=${data.gisu_crc_icon01 }&path=${path }"
										style="height: 300px; width: 300px; margin-left: auto; margin-right: auto; display: block;" />
								</a></li>
								<li style="padding: 10px 10px 0px 31px;"><a
									style="font-size: 16px;">${data.gisu_crc_intro }</a></li>
							</ul>

						</div>
						<c:if test="${status.index%3 == 2 }">
							<div style="overflow: hidden; width: 100%; height: 30px;"></div>
						</c:if>
					</c:forEach>
				</div>
			</c:if>
			<c:if test="${fn:length(shortTermList) le 0}">
				<p>현재 모집중인 과정이 없습니다.</p>
			</c:if>
		</div>
	</div>
	<div style="overflow: hidden; width: 100%; height: 100px;"></div>
	<%@include file="../footer.jsp"%>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
	var myApp = angular.module('myapp', []);

	myApp.directive('code', [ '$http', function($http) {
		return {
			restrict : "E",
			replace : true,
			scope : {
				value : '@'
			},
			controller : function($scope, $element, $attrs) {
				$http({
					method : 'POST',
					url : '/codeconverter',
					responseType : 'text',
					params : {
						code : $attrs.value
					}
				}).then(function successCallback(response) {
					$scope.filterParams = response.data;
				}, function errorCallback(response) {
					console.log(response);
				});
			},
			template : "<span>{{filterParams}}</span>"
		}
	} ]);

	function goCrcDetail(gisu_seq) {
		location.href = "/edu/apply/cup_detail?gisu_seq=" + gisu_seq;
	}

	$(function() {
		// 날짜의 특수기호 하이푼(-)을 콤마(.)로 치환 후, 해당 ID 위치에 설정
		var gisu_app_st = '${seaCurGisu.gisu_app_st }'.replace(/\-/gi, ".");
		var gisu_app_et = '${seaCurGisu.gisu_app_et }'.replace(/\-/gi, ".");
		var gisu_crc_st = '${seaCurGisu.gisu_crc_st }'.replace(/\-/gi, ".");
		var gisu_crc_et = '${seaCurGisu.gisu_crc_et }'.replace(/\-/gi, ".");
		$('#apply_days').html(gisu_app_st + " ~ " + gisu_app_et);
		$('#edu_days').html(gisu_crc_st + " ~ " + gisu_crc_et);
	});

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
		url(/resources/segroup/society/edu/image/main/top_img/top_img_cup.jpg);
	height: 250px;
	background-size: cover;
}
</style>
</head>
<body ng-app="myapp">
	<%@include file="../menu.jsp"%>
	<a id="MOVE_TOP_BTN" href="#none"><img
		src="/resources/segroup/society/edu/image/sub/top.png"
		style="width: 60px; height: 60px;" title="위로가기"></a>
	<div class="top_img">
		<div class="top_img_text">
			<p class="top_img_text1">사전학습반</p>
			<p class="top_img_text2">본과정 대비 IT&일본어 사전학습과정!</p>
		</div>
	</div>

	<div style="overflow: hidden; width: 100%; height: 50px;"></div>
	<div class="sub_m_contents">
		<div class="main_top_slidewrap">

			<div style="overflow: hidden; width: 100%; height: 50px;"></div>
			<!--   -->
		
			<div class="sub_m_contents">
		<div class="main_top_slidewrap">
				<img src="/edu/admin/curriculum_gisu_insert_image/201230SWDO.jpg" width="800px">
			<div class="linner"></div>
		</div>
	</div>
			<!--   -->
			<c:if test="${fn:length(shortTermList) gt 0}">
				<div class="notice_wrap" style="width: 100%;">
					<table>
						<tr>
							<th>과정명</th>
							<th>기수</th>
							<th>교육기간</th>
							<th>교육시간</th>
							<th>신청기간</th>
							<th>상태</th>
						</tr>
						<c:forEach var="data" items="${shortTermList}" varStatus="status">
							<tr class="notice_top">
								<td style="width: 25%; text-align: left; padding-left: 30px;">${data.gisu_crc_nm}</td>
								<td>${data.gisu_num}</td>
								<td>${data.gisu_crc_st }~${data.gisu_crc_et }</td>
								<td>${data.gisu_crc_month }개월${data.gisu_crc_days }일(${data.gisu_crc_times }시간)</td>
								<td>${data.gisu_app_st }~${data.gisu_app_et }</td>
								<td><c:choose>
										<c:when test="${data.gisu_result == 'B1600'}">
                         &nbsp;<a href="" class="gisu_insert" onclick="goCrcDetail(${data.gisu_seq})"
												style="color: red;"><code value="${data.gisu_result }"></code></a>
											<br />
										</c:when>
										<c:when test="${data.gisu_result == 'B1601'}">
                         &nbsp;<a href="" class="gisu_update" onclick="goCrcDetail(${data.gisu_seq})"
												style="color: blue;"><code value="${data.gisu_result }"></code></a>
											<br />
										</c:when>
										<c:otherwise>
                         &nbsp;<code value="${data.gisu_result }"></code>
											<br />
										</c:otherwise>
									</c:choose></td>
							</tr>
						</c:forEach>
					</table>
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
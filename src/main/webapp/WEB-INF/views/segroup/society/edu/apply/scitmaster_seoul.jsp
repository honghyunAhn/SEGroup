<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" Content="text/html; charset=utf-8" />
<!-- 
<meta name="viewport" content="width=device-width, target-densitydpi=medium-dpi " /> -->
<meta name="format-detection" content="telephone=no">
<script src="<c:url value="/resources/segroup/js/angular.min.js" />"></script>
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
.linner {
	overflow: hidden;
	width: 100%;
	height: 10px;
}
.top_img {
	position: relative;
	background-image:
		url(/resources/segroup/society/edu/image/main/top_img/top_img_scitmaster_intro.jpg);
	height: 250px;
	background-size: cover;
}
.prImg {
    display: block;
    margin-left: auto;
    margin-right: auto;
}
</style>
</head>
<body ng-app="myapp">
	<%@include file="../menu.jsp"%>
	<a id="MOVE_TOP_BTN" href="#none">
		<img src="/resources/segroup/society/edu/image/sub/top.png" style="width: 60px; height: 60px;" title="위로가기">
	</a>
	<div>
		<div class="top_img">
			<div class="top_img_text">
				<p class="top_img_text1">정부승인 해외취업 연수과정</p>
				<p class="top_img_text2">K-Move 스쿨</p>
			</div>
		</div>
	</div>
	<div style="overflow: hidden; width: 100%; height: 50px;"></div>
	
	<div class="sub_m_contents">
		<div class="main_top_slidewrap">
			<c:forEach var="data" items="${seoul_img_select}">
				<img class="prImg" src="${data}" border="0" >
			</c:forEach>
			<br><br><br><br>
			<img usemap="#eDM" src="/resources/segroup/society/edu/image/sub/link_img.jpg">
			<br><br>
			<map name="eDM">
				<area shape="rect" target="_blank" onfocus="this.blur();" coords="255, 55, 835, 160" href="https://newtradecampus.kita.net/page/user_job_CloudIT_apply?src=email&amp;kw=00059A&amp;ACENO=0&amp;course_category=JOBA&amp;course_code=1498&amp;class_seq=39&amp;site_id=KITAACAD&amp;viewMode=detail">
				<area shape="circle" target="_blank" onfocus="this.blur();" coords="165,345, 82" href="http://codingnala.com/?src=email&amp;kw=00059A&amp;ACENO=3">
				<area shape="circle" target="_blank" onfocus="this.blur();" coords="355, 345, 82" href="https://www.facebook.com/smart.cloud.master/?src=email&amp;kw=00059A&amp;ACENO=1">
				<area shape="circle" target="_blank" onfocus="this.blur();" coords="550, 345, 82" href="https://www.youtube.com/channel/UCCsiCEQ8g6PacQLuJEYEWpw/featured?src=email&amp;kw=00059A&amp;ACENO=2&amp;view_as=subscriber">
				<area shape="circle" target="_blank" onfocus="this.blur();" coords="740, 345, 82" href="https://www.instagram.com/scitmaster/?hl=ko">
				<area shape="circle" target="_blank" onfocus="this.blur();" coords="935, 345, 82" href="https://post.naver.com/scitmaster?isHome=1">
			</map>
		</div>
	</div>
	
	<%@include file="../footer.jsp"%>
</body>
</html>
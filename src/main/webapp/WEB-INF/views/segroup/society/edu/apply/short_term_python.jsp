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

	function short_pay(seq,amount,nm){
		$("#pay_seq").val(seq);
		$("#price").val(amount);
		$("#goodname").val(nm)
		$("#userPayInfoForm").submit();
	}
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

.spacing30 {
	overflow: hidden;
	width: 100%;
	height: 30px;
}
.spacing50 {
	overflow: hidden;
	width: 100%;
	height: 50px;
}
.indent {
	margin-left: 15px;
}
#infotb tr td {
	text-align: left;
	padding-bottom: 15px;
	padding-right: 15px;
	white-space: nowrap;
}
#currtb tr td {
	padding: 7px;
	white-space: nowrap;
	border: 1px solid black;
}
#currtb tr td:nth-child(2) {
	text-align: left;
}
img.course_img {
	display: block;
	margin: 0px auto;
}
</style>
</head>
<body ng-app="myapp">
	<%@include file="../menu.jsp"%>
	<a id="MOVE_TOP_BTN" href="#none"><img src="/resources/segroup/society/edu/image/sub/top.png" style="width: 60px; height: 60px;" title="위로가기"></a>
	<div>
		<div class="top_img">
			<div class="top_img_text">
				<p class="top_img_text1">단기과정</p>
				<p class="top_img_text2">파이썬</p>
			</div>
		</div>
	</div>
	<div class="spacing50"></div>
	<div class="sub_m_contents">
		<img class ="course_img" alt="python" src="/resources/segroup/society/edu/image/course/python.jpg">
		<div class="main_top_slidewrap">
            <div class="spacing30"></div>
            <c:if test="${fn:length(shortTermList) gt 0}">
            	<div class="notice_wrap" style="width: 100%;">
            		<table>
            			<tr>
							<th>과정명</th>
							<th>교육기간</th>
							<th>교육시간</th>
							<th>신청기간</th>
							<th>상태</th>
						</tr>
						<c:forEach var="data" items="${shortTermList}" varStatus="status">
	           				<tr class="notice_top">
								<td style="width: 30%; text-align: left; padding-left: 30px;">${data.gisu_crc_nm}</td>
								<td>${data.gisu_crc_st}~${data.gisu_crc_et}</td>
								<td>${data.gisu_crc_month}개월${data.gisu_crc_days}일(${data.gisu_crc_times}시간)</td>
								<td>${data.gisu_app_st}~${data.gisu_app_et}</td>
								<td>
									<c:choose>
										<c:when test="${data.gisu_result == 'B1600'}">
                       						<input type="button" class="confirms_btn" value="결제하기" onclick="short_pay(${data.paySeq},${data.payAmount},'${data.gisu_crc_nm}')" style="width: 90%; float: left; height: 36px;">
										</c:when>
										<c:otherwise>
                         					<code value="개강예정"></code>
											<br>
										</c:otherwise>
									</c:choose>
								</td>
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
	<form id="userPayInfoForm" method="post" action="/edu/user/user_pay_ini">
		<input type="hidden" value="" name="price" id="price">
		<input type="hidden" value="" name="goodname" id="goodname">
		<input type="hidden" value="" name="pay_seq" id="pay_seq">
		<input type="hidden" value="" name="pay_from" id="pay_from">
		<input type="hidden" value="" name="pay_to" id="pay_to">
	</form>
	<div class="spacing50"></div>
	<%@include file="../footer.jsp"%>
</body>
</html>
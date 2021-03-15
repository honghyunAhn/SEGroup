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
		url(/resources/segroup/society/edu/image/main/top_img/top_img_oracle.jpg);
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
</style>
</head>
<body ng-app="myapp">
	<%@include file="../menu.jsp"%>
	<a id="MOVE_TOP_BTN" href="#none"><img src="/resources/segroup/society/edu/image/sub/top.png" style="width: 60px; height: 60px;" title="위로가기"></a>
	<div>
		<div class="top_img">
			<div class="top_img_text">
				<p class="top_img_text1">단기과정</p>
				<p class="top_img_text2">일본어</p>
			</div>
		</div>
	</div>
	<div class="spacing50"></div>
	<div class="sub_m_contents">
		<div class="main_top_slidewrap">
			<h1 align="center">찾아가는 일본어(On-Demand)</h1>
			<div class="spacing50"></div>
			<h3>∘ 강좌안내</h3>
			<div class="indent">
				이 강좌는 일본어를 필요로 하는 법인교육, 연수프로그램, 개인강습 등 모든 상황에 당사 일본어 스페셜리스트를 클라이언트가 지정하는 장소에 파견하는 맞춤형 일본어 교육과정입니다.<br><br>
				당 교육기관은 한국무역협회와 컨소시엄을 맺고 2001년부터 "SMART Cloud IT Master"라는 취업 연계 과정을 운영하고 있습니다. 현재는 연간 300명 정도의 인재를 ICT와 일본어를 교육시켜 AMAZON, Manpower Group, Persol Process&Technology, Pasona Tech, Technopro, Recruit R&D, Rakuten, 일본 IBM, Softbank 등, 일본 굴지의 IT관련 기업들에게 취업을 시키고 있습니다.<br><br>
				2019년 8월까지의 수료생 누계는 2,267명이며 평균 취업률은 98%입니다.<br><br>
				현재도 매년 6월과 11월의 연2회 서울과 도쿄에서 당사가 단독으로 Job Fair 행사를 주최하여 지속적으로 일본기업 면접회를 개최하고 있습니다.<br><br>
				19년간의 일본취업지도의 노하우를 바탕으로 살아있는 일본어 교육을 클라이언트의 희망에 맞게 구성하여 시간적 공간적 제약없이 제공하는 시스템입니다.<br><br>
				강사진은 일본 현지 경험이 풍부한 한국인을 포함한 한국어가 가능한 일본인 중심으로 구성되어 있어 다양한 레벨에도 대응 가능합니다.<br><br>
				기존 개인 일본어 출장 서비스에 비해 공신력 있는 당사의 엄격한 관리하에 다양한 경력의 강사를 자유롭게 배정할 수 있고 커리큘럼 대응범위가 넓어서 활용만족도가 높을 것으로 자신합니다. 일단 플랜 및 견적 문의는 무료이니 많은 관심 부탁드립니다.<br><br>
				감사합니다.
			</div>
			<div class="spacing30"></div>
			<img src="/resources/segroup/society/edu/image/main/cert01.bmp" style="vertical-align: middle;">
			<img src="/resources/segroup/society/edu/image/main/cert02.bmp" style="vertical-align: middle;">
			<div class="spacing30"></div>
			<h3>∘ 수강안내</h3>
			<table id="infotb" class="indent">
				<tr>
					<td>∘ 과정명</td>
					<td>찾아가는 일본어(On- Demand)</td>
				</tr>
				<tr>
					<td>∘ 교육목표</td>
					<td>
						- 일본어 교육을 필요로 하는 모든 곳에 시간적 공간적 제약없이 이용할 수 있습니다.<br>
						- 클라이언트의 교육요구에 다양하게 대응 할 수 있습니다.
					</td>
				</tr>
				<tr>
					<td>∘ 교육대상</td>
					<td>법인/학습프로그램 운영자/관련 교육기관 등</td>
				</tr>
				<tr>
					<td>∘ 일시</td>
					<td>요상담</td>
				</tr>
				<tr>
					<td>∘ 장소</td>
					<td>서울시 강남구 삼성동 코엑스(COEX) 4층 ICT 교육센터</td>
				</tr>
				<tr>
					<td>∘ 수강료</td>
					<td>요상담</td>
				</tr>
				<tr>
					<td>∘ 교재</td>
					<td>협의가능</td>
				</tr>
				<tr>
					<td>∘ 최소인원</td>
					<td>-</td>
				</tr>
				<tr>
					<td style="padding-bottom: 0px;">∘ 과정문의</td>
					<td style="padding-bottom: 0px;"><b>02-6000-5189 (선 문의 부탁드립니다.)</b></td>
				</tr>
			</table>
			<div class="spacing30"></div>
			<img src="/resources/segroup/society/edu/image/main/japan_on_demand_img01.bmp" style="vertical-align: middle; width: 280px; height: 156px;"><br>
			<img src="/resources/segroup/society/edu/image/main/japan_on_demand_img02.bmp" style="vertical-align: middle; width: 280px; height: 210px; padding-left: 275px;">
            <c:if test="${fn:length(shortTermList) gt 0}">
            	<div class="spacing30"></div>
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
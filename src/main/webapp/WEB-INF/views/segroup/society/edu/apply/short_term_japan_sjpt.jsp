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
#currtb tr td {
	padding: 7px;
	white-space: nowrap;
	border: 1px solid black;
}
#currtb tr td:nth-child(2) {
	text-align: left;
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
			<h1 align="center">내 마음대로 말하는 일본어!</h1>
			<div class="spacing50"></div>
			<h3>∘ 강좌안내</h3>
			<div class="indent">
				이 강좌는 일본취업 또는 일본 실무자를 대상으로 일본어 회화를 원활히 하기 위해 기존 SJPT교재를 사용하여 원어민 강사가 실생활에서 실천할 수 있는 회화를 학습하는 과정입니다.<br><br>
				당 교육기관은 한국무역협회와 컨소시엄을 맺고 2001년부터 "SMART Cloud IT Master"라는 취업 연계 과정을 운영하고 있습니다. 현재는 연간 300명 정도의 인재를 ICT와 일본어를 교육시켜 AMAZON, Manpower Group, Persol Process&Technology, Pasona Tech, Technopro, Recruit R&D, Rakuten, 일본 IBM, Softbank 등, 일본 굴지의 IT관련 기업들에게 취업을 시키고 있습니다.<br><br>
				2019년 8월까지의 수료생 누계는 2,267명이며 평균 취업률은 98%입니다.<br><br>
				현재도 매년 6월과 11월의 연2회 서울과 도쿄에서 당사가 단독으로 Job Fair 행사를 주최하여 지속적으로 일본기업 면접회를 개최하고 있습니다.<br><br>
				19년간의 일본취업지도의 노하우를 바탕으로 일본어 회화의 핵심적인 부분을 일본인 강사가 초급부터 고급까지 폭넓고 알기쉽게 지도하는 강좌입니다.<br><br>
				강사진은 일본어 교육경험이 풍부한 일본인으로 구성되어 있고 커리큘럼은 SJPT교재를 사용하여 즉시 실천할 수 있는 내용으로 구성하였습니다.<br><br>
				또한 일본기업문화의 특이성과 간단한 업무보고서 등 다양한 일본어 문서작성도 지도해드리고 최종적으로 희망자에 한해서 당사 Job Fair에 연계해서 취업상담도 지원해드리는 Only One 단기과정입니다.<br><br>
				장래 일본취업을 계획하고 계시거나 일본취업이 결정된 분 또는 주재원 내정되신 분은 이 과정을 수강하시여 불편함 없는 즐거운 일본생활이 되시길 바랍니다.<br><br>
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
					<td>내마음대로 말하는 일본어(레벨1~레벨3)</td>
				</tr>
				<tr>
					<td>∘ 교육목표</td>
					<td>
						- 실천적 일본어 회화실력을 배양합니다.<br>
						- 사내승진 및 자격증 취득을 할 수 있습니다.
					</td>
				</tr>
				<tr>
					<td>∘ 교육대상</td>
					<td>대학교 재학생/일본취업 준비생/일본취업 예정자/주재원 등</td>
				</tr>
				<tr>
					<td>∘ 일시</td>
					<td>
						2019년 12월 2일(월) ~ 12월 27일(금) 13:00 ~ 16:00 [(3hr/1일) 주2일 총24시간]<br>
						2020년 1월 6일(월) ~ 1월 31일(금) 13:00 ~ 16:00 [(3hr/1일) 주2일 총24시간]<br>
						2020년 2월 3일(월) ~ 2월 28일(금) 13:00 ~ 16:00 [(3hr/1일) 주2일 총24시간]<br>
						-매월 3개 레벨 동시운영-</td>
				</tr>
				<tr>
					<td>∘ 장소</td>
					<td>서울시 강남구 삼성동 코엑스(COEX) 4층 ICT 교육센터</td>
				</tr>
				<tr>
					<td>∘ 수강료</td>
					<td>25만원 (각 레벨별)</td>
				</tr>
				<tr>
					<td>∘ 교재</td>
					<td>SJPT한권으로 합격하기(시사 일본어사)</td>
				</tr>
				<tr>
					<td>∘ 최소인원</td>
					<td>5명 (최소 인원 미달 시 폐강 가능)</td>
				</tr>
				<tr>
					<td style="padding-bottom: 0px;">∘ 과정문의</td>
					<td style="padding-bottom: 0px;">02-6000-5189</td>
				</tr>
			</table>
			<div class="spacing30"></div>
			<h3>∘ 교육일정 및 커리큘럼</h3>
			<table id="currtb" class="indent">
				<tr>
					<td>일정</td>
					<td style="text-align: center;">교육시간</td>
					<td>교육내용</td>
				</tr>
				<tr>
					<td>월</td>
					<td style="text-align: center;">13:00 ~ 16:00</td>
					<td style="text-align: left;">
						1. SJPT 교재방식으로 회화연습<br>
						2. 발음 체크<br>
						3. 청해 체크<br>
						4. 모의 테스트<br>
						5. 일본 드라마 감상
					</td>
				</tr>
			</table>
			<div class="indent">※ 상기 교육 일정은 사정에 따라 변경될 수 있습니다.</div>
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
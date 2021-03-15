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
			<h1 align="center">IT인재를 위한 일본취업 프로그램</h1>
			<div class="spacing50"></div>
			<h3>∘ 강좌안내</h3>
			<div class="indent">
				이 강좌는 IT전공자 또는 IT학습 경험자를 대상으로 일본어와 면접기술을 학습하여 일본취업을 이루는 과정입니다.<br><br>
				당 교육기관은 한국무역협회와 컨소시엄을 맺고 2001년부터 "SMART Cloud IT Master"라는 취업 연계 과정을 운영하고 있습니다. 현재는 연간 300명 정도의 인재를 ICT와 일본어를 교육시켜 AMAZON, Manpower Group, Persol Process&Technology, Pasona Tech, Technopro, Recruit R&D, Rakuten, 일본 IBM, Softbank 등, 일본 굴지의 IT관련 기업들에게 취업을 시키고 있습니다.<br><br>
				2019년 8월까지의 수료생 누계는 2,267명이며 평균 취업률은 98%입니다.<br><br>
				현재도 매년 6월과 11월의 연2회 서울과 도쿄에서 당사가 단독으로 Job Fair 행사를 주최하여 지속적으로 일본기업 면접회를 개최하고 있습니다.<br><br>
				19년간의 일본취업지도의 노하우를 바탕으로 기존 IT지식 및 기술 습득자에게 일본취업교육 서비스를 단기간에 집중적으로 제공하여 일본취업에 특화시킨 강좌입니다.<br><br>
				강사진은 취업지원지도 경험이 풍부한 원어민으로 구성되어 있고 커리큘럼은 실전적인 내용을 선별해서 최적화시켰습니다.<br><br>
				또한 일본기업면접의 특이성과 자연스러운 일본어 표현방식 등을 1:1 맞춤형으로 케어해주고 최종적으로 희망자에 한해서 당사 Job Fair에 연계해서 취업상담도 끝까지 지원해드리는 All In One과정입니다.<br><br>
				장래 글로벌 IT전문가로서 인정받을 수 있는 일본취업의 찬스를 놓치지 마시고 저희 일본취업 스페셜리스트들과 함께  꼭 도전해 보시길 바랍니다.<br><br>
				감사합니다.
			</div>
			<div class="spacing30"></div>
			<img src="/resources/segroup/society/edu/image/main/company_list.bmp"><br>
			<img src="/resources/segroup/society/edu/image/main/cert01.bmp" style="vertical-align: middle;">
			<img src="/resources/segroup/society/edu/image/main/cert02.bmp" style="vertical-align: middle;">
			<div class="spacing30"></div>
			<h3>∘ 수강안내</h3>
			<table id="infotb" class="indent">
				<tr>
					<td>∘ 과정명</td>
					<td>IT인재를 위한 일본취업 프로그램</td>
				</tr>
				<tr>
					<td>∘ 교육목표</td>
					<td>
						- 일본어 비전공자에 대하여 일본어 및 취업전략을 학습합니다.<br>
						- 일본어로 면접을 할 수 있고 부수적인 입사전형에 대응할 수 있게 연습합니다.
					</td>
				</tr>
				<tr>
					<td>∘ 교육대상</td>
					<td>일본취업희망자 등</td>
				</tr>
				<tr>
					<td>∘ 일시</td>
					<td>2019년 12월 2일(월) ~ 5월 29일(금) 10:00 ~ 12:00 [(3hr/1일) 주3일 총216시간]</td>
				</tr>
				<tr>
					<td>∘ 장소</td>
					<td>서울시 강남구 삼성동 코엑스(COEX) 4층 ICT 교육센터</td>
				</tr>
				<tr>
					<td>∘ 수강료</td>
					<td>단계별: 40만원 종합반: 200만원 1단계(1개월)~6단계(6개월)</td>
				</tr>
				<tr>
					<td>∘ 교재</td>
					<td>민나노 일본어 외</td>
				</tr>
				<tr>
					<td>∘ 최소인원</td>
					<td>단과반: 5명 종합반: 5명 (최소 인원 미달 시 폐강 가능)</td>
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
					<td>12월</td>
					<td rowspan="6" style="text-align: center;">13:00 ~ 16:00</td>
					<td style="text-align: left;">
						초급~초중급 일본어 : 문법 및 회화<br>
						-. 히라가나 & 카타카나<br>
						-. 명사문, 의문문, 지시대명사 등<br>
						-. 형용사, 동사활용 등<br>
						-. 표현법
					</td>
				</tr>
				<tr>
					<td>1월</td>
					<td>
						중급 일본어1 : 독해 및 회화<br>
						-. 장단문 독해<br>
						-. 주제별 프리토킹<br>
						-. JPT 공략
					</td>
				</tr>
				<tr>
					<td>2월</td>
					<td>
						중급 일본어2 : 실전 일본어<br>
						-. 일본기업문화 이해<br>
						-. IT 일본어 용어<br>
						-. 비즈니스 일본어
					</td>
				</tr>
				<tr>
					<td>3월</td>
					<td>
						중고급 일본어 : 취업준비<br>
						-. 그룹 디스커션<br>
						-. 발음+듣기 연습(NHK뉴스)<br>
						-. 작문연습(자기 분석 관련)
					</td>
				</tr>
				<tr>
					<td>4월</td>
					<td>
						본격 취업전략Ⅰ<br>
						-. 이력서 첨삭<br>
						-. E/S카드 작성<br>
						-. 면접 전략
					</td>
				</tr>
				<tr>
					<td>5월</td>
					<td>
						본격 취업전략Ⅱ<br>
						-. 기업분석<br>
						-. 개별 취업 카운셀링<br>
						-. 면접 연습
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
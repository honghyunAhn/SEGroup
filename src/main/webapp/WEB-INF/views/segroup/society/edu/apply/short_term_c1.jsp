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
				<p class="top_img_text2">C언어</p>
			</div>
		</div>
	</div>
	<div class="spacing50"></div>
	<div class="sub_m_contents">
		<div class="main_top_slidewrap">
			<h1 align="center">&lt;입문: C 뿌리기-1부&gt; - IoT를 위한 첫 걸음</h1>
			<div class="spacing50"></div>
			<h3>∘ 강좌안내</h3>
			<div class="indent">
				이 강좌는 프로그래밍 언어에 대한 지식을 필요로 하는 초보자, 초급 개발자를 위한 강좌로 C언어를 이용하여 절차적 프로그래밍 개발 방법에 대해 공부합니다.<br><br>
				C언어는 컴퓨터 내부에서 프로그래밍 명령어가 어떻게 실행하고 동작하는지 Low Level에서 다루게 되므로 절차적으로 프로그램이 어떻게 실행되는지 공부하거나, 추후 알고리즘에 대해 깊은 지식을 학습하려고 할 때 도움이 되는 프로그래밍 언어입니다.<br><br>
				이 강좌를 통해 프로그래밍의 기본적인 처리방식에 대한 이해를 갖게 되어 이후 심화 학습을 하는 과정에도 많은 도움이 될 것으로 기대합니다.<br><br>
				이 과정을 공부하기 위해 선수 학습할 내용은 없으며, 다음 과정으로 "C 뿌리기-2부"를 수강하시는 것을 추천 드립니다.<br><br>
				감사합니다.
			</div>
			<div class="spacing30"></div>
			<h3>∘ 수강안내</h3>
			<table id="infotb" class="indent">
				<tr>
					<td>∘ 과정명</td>
					<td>&lt;입문: C 뿌리기-1부&gt; - IoT를 위한 첫 걸음</td>
				</tr>
				<tr>
					<td>∘ 교육목표</td>
					<td>
						- C 언어를 이용하여 프로그램의 개념과 컴퓨터 내부의 처리방식에 대해 알 수 있습니다.<br>
						- 앞으로 더 깊은 알고리듬이나 다른 언어를 통해 Application을 작성하는 밑거름이 될 지식을 공부할 수 있습니다.
					</td>
				</tr>
				<tr>
					<td>∘ 교육대상</td>
					<td>대학교 재학생/졸업생, 취업준비생</td>
				</tr>
				<tr>
					<td>∘ 일시</td>
					<td>
						2019년 10월 14일(월) ~ 10월 31일(목) 09:00 ~ 12:00 [총 14일, 42시간]<br>
						2019년 10월 21일(월) ~ 11월 15일(금) 19:00 ~ 21:00 [총 20일, 40시간]
					</td>
				</tr>
				<tr>
					<td>∘ 장소</td>
					<td>서울시 강남구 삼성동 코엑스(COEX) 4층 ICT 교육센터</td>
				</tr>
				<tr>
					<td>∘ 수강료</td>
					<td>250,000원</td>
				</tr>
				<tr>
					<td>∘ 교재</td>
					<td>[한빛 미디어] 혼자 공부하는 C언어</td>
				</tr>
				<tr>
					<td>∘ 최소인원</td>
					<td>10명 (최소인원 미달 시 폐강될 수 있음)</td>
				</tr>
				<tr>
					<td style="padding-bottom: 0px;">∘ 과정문의</td>
					<td style="padding-bottom: 0px;">02-6000-5450</td>
				</tr>
			</table>
			<div class="spacing30"></div>
			<h3>∘ 선수학습</h3>
			<div class="indent">∘ 없음</div>
			<div class="spacing30"></div>
			<h3>∘ 교육일정 및 커리큘럼</h3>
			<table id="currtb" class="indent">
				<tr>
					<td>일정</td>
					<td style="text-align: center;">교육시간</td>
					<td>교육내용</td>
				</tr>
				<tr>
					<td>10/14(월)</td>
					<td rowspan="14" style="text-align: center;">
						09:00 ~ 12:00<br><br>
						또는<br><br>
						19:00 ~ 21:00
					</td>
					<td style="text-align: left;">
						C 프로그래밍 시작하기<br>
						- 개발환경 설정<br>
						- C언어 프로그램의 구조<br>
						- 입력과 출력(scanf, printf)
					</td>
				</tr>
				<tr>
					<td>10/15(화)</td>
					<td>
						자료형의 이해<br>
						- 정수, 실수, 문자, 문자열, 배열 등<br>
						- 정수의 signed, unsigned의 이해
					</td>
				</tr>
				<tr>
					<td>10/16(수)</td>
					<td>
						C언어 연산자의 종류와 주요 특징<br>
						- 기본적인 연산( + - * / )의 사용법 익히기<br>
						- 이항 연산자와 단항 연산자, 삼항 연산자의 종류
					</td>
				</tr>
				<tr>
					<td>10/17(목)</td>
					<td>기본 연산자 Review 및 문제 풀이</td>
				</tr>
				<tr>
					<td>10/18(금)</td>
					<td>
						C언어 연산자의 종류와 주요 특징 2<br>
						- 관계연산자의 사용<br>
						- 관계연산자의 Short circuit
					</td>
				</tr>
				<tr>
					<td>10/21(월)</td>
					<td>
						비트 관련 연산자의 사용<br>
						- &amp;&amp;, ||, ~, &gt;&gt;, &lt;&lt; 연산자 등<br>
						- unsigned와 signed의 shift의 이해
					</td>
				</tr>
				<tr>
					<td>10/22(화)</td>
					<td>
						제어문의 사용<br>
						- 선택문 (if, switch~ case)
					</td>
				</tr>
				<tr>
					<td>10/23(수)</td>
					<td>
						반복문<br>
						- while문의 활용
					</td>
				</tr>
				<tr>
					<td>10/24(목)</td>
					<td>
						반복문<br>
						- for, do~while 문의 활용
					</td>
				</tr>
				<tr>
					<td>10/25(금)</td>
					<td>이중 반복문의 사용</td>
				</tr>
				<tr>
					<td>10/28(월)</td>
					<td>C언어 제공 함수의 사용 1</td>
				</tr>
				<tr>
					<td>10/29(화)</td>
					<td>C언어 제공 함수의 사용 2</td>
				</tr>
				<tr>
					<td>10/30(수)</td>
					<td>
						사용자 정의 함수의 작성<br>
						- 함수의 선언, 정의, 호출
					</td>
				</tr>
				<tr>
					<td>10/31(목)</td>
					<td>
						사용자 정의 함수의 작성<br>
						- Header 파일의 작성방법과 사용
					</td>
				</tr>
			</table>
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
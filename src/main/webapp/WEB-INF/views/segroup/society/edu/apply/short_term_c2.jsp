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
			<h1 align="center">&lt;초급: C 뿌리기-2부&gt; - IoT를 위한 첫 걸음</h1>
			<div class="spacing50"></div>
			<h3>∘ 강좌안내</h3>
			<div class="indent">
				이 강좌는 C 언어 입문과정에 대한 지식이 있는 분들을 대상으로 좀 더 심오한 C의 문법을 배우는 과정입니다.<br><br>
				이미 C 언어를 학습한 적 있으나 배열이나 포인터에서 막혀 고생했다고 하는 분들이나, 선수 과목으로 "입문: C 뿌리기-1부"를 학습한 후 수강하시면 많은 도움이 됩니다.<br><br>
				이 강좌를 통해 C 언어를 학습하면서 한 번쯤 좌절하게 되는 배열과 포인터와의 관계에 대해서 쉽게 이해하고 활용하며 메모리 관리에 관한 보다 깊은 이해를 할 수 있습니다.<br><br>
				이 과정을 공부한 후에 웹을 공부할 계획이 있다면 “입문: 누구나 JAVA-1부”, 만약 딥러닝 쪽에 관한 공부를 시작하고자 하신다면 “입문: 이제부터 파이썬” 수업을 수강하시는 것을 추천 드립니다.<br><br>
				감사합니다.
			</div>
			<div class="spacing30"></div>
			<h3>∘ 수강안내</h3>
			<table id="infotb" class="indent">
				<tr>
					<td>∘ 과정명</td>
					<td>&lt;초급: C 뿌리기-2부&gt; - IoT를 위한 첫 걸음</td>
				</tr>
				<tr>
					<td>∘ 교육목표</td>
					<td>
						- C 언어의 메모리 구조와 포인터에 대한 지식을 익혀 보다 깊은 이해를 할 수 있습니다.<br>
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
						2019년 11월 18일(월) ~ 12월 05일(목) 09:00 ~ 12:00 [총 14일, 42시간]<br>
						2019년 11월 25일(월) ~ 12월 20일(금) 19:00 ~ 21:00 [총 20일, 40시간]
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
			<div class="indent">∘ &lt;입문: C 뿌리기-1부&gt;</div>
			<div class="spacing30"></div>
			<h3>∘ 교육일정 및 커리큘럼</h3>
			<table id="currtb" class="indent">
				<tr>
					<td>일정</td>
					<td style="text-align: center;">교육시간</td>
					<td>교육내용</td>
				</tr>
				<tr>
					<td>11/18(월)</td>
					<td rowspan="14" style="text-align: center;">
						09:00 ~ 12:00<br><br>
						또는<br><br>
						19:00 ~ 21:00
					</td>
					<td style="text-align: left;">
						배열의 사용<br>
						- 정수 배열과, 실수형 배열의 사용
					</td>
				</tr>
				<tr>
					<td>11/19(화)</td>
					<td>
						문자열과 배열과의 관계<br>
						- 문자열형 배열과 문자열과의 관계
					</td>
				</tr>
				<tr>
					<td>11/20(수)</td>
					<td>
						포인터<br>
						- 포인터의 기본개념<br>
						- 배열과 포인터와의 관계
					</td>
				</tr>
				<tr>
					<td>11/21(목)</td>
					<td>
						함수와 배열<br>
						- 배열을 처리하는 함수의 작성
					</td>
				</tr>
				<tr>
					<td>11/22(금)</td>
					<td>
						문자와 문자열의 처리<br>
						- 문자 입출력 함수의 사용<br>
						- 버퍼를 사용하는 함수<br>
						- 문자열 연산 함수 직접 작성해 보기
					</td>
				</tr>
				<tr>
					<td>11/25(월)</td>
					<td>
						변수의 메모리 공간에 대한 이해<br>
						- 함수의 데이터 공유방법
					</td>
				</tr>
				<tr>
					<td>11/26(화)</td>
					<td>
						다차원 배열과 응용 포인터 1<br> 
						- 포인터배열과 배열포인터
					</td>
				</tr>
				<tr>
					<td>11/27(수)</td>
					<td>
						다차원 배열과 응용 포인터 2<br> 
						- 함수포인터와 Void 포인터
					</td>
				</tr>
				<tr>
					<td>11/28(목)</td>
					<td>
						메모리의 동적할당<br> 
						- 동적할당을 위한 함수, 메모리 해제 방법
					</td>
				</tr>
				<tr>
					<td>11/29(금)</td>
					<td>
						메모리의 동적할당<br> 
						- 동적 할당 공간에 대한 활용
					</td>
				</tr>
				<tr>
					<td>12/02(월)</td>
					<td>
						사용자 정의 자료형의 사용<br>
						- 구조체, 공용체, 열거형의 사용
					</td>
				</tr>
				<tr>
					<td>12/03(화)</td>
					<td>
						파일입출력 1<br>
						- C 언어에서 파일에 접근하는 방법
					</td>
				</tr>
				<tr>
					<td>12/04(수)</td>
					<td>
						파일입출력 2<br>
						- 다양한 파일 입출력 함수를 이용한 파일 데이터의 처리
					</td>
				</tr>
				<tr>
					<td>12/05(목)</td>
					<td>
						전처리와 분할 컴파일 방법<br>
						- 전처리 지시자<br>
						- 분할 컴파일의 개념
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
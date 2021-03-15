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
				<p class="top_img_text2">JAVA</p>
			</div>
		</div>
	</div>
	<div class="spacing50"></div>
	<div class="sub_m_contents">
		<div class="main_top_slidewrap">
			<h1 align="center">&lt;초급: 누구나 JAVA-2부&gt; - 객체 지향 코딩의 정석</h1>
			<div class="spacing50"></div>
			<h3>∘ 강좌안내</h3>
			<div class="indent">
				이 강좌는 JAVA에 대한 기초 지식을 갖춘 분들을 대상으로 하며 JAVA의 고급 문법을 배우는 과정입니다.<br><br>
				JAVA는 객체 지향 프로그래밍 언어로써 플랫폼에 독립적인 특징을 가지며 다양한 라이브러리를 지원하기 때문에 여러 분야에 걸쳐 사용됩니다. 특히 처음으로 객체 지향 프로그래밍 방법을 배울 때 추천됩니다.<br><br>
				이 강좌를 통해 JAVA의 메모리 구조부터 인터페이스, 예외 처리, 그리고 스레드와 네트워크 프로그래밍 등 JAVA에 있어서 가장 복잡하고 어려운 개념을 터득할 수 있으며, 이를 통해 JAVA의 기본기를 완성할 수 있습니다.<br><br>
				이 강좌를 수강하신 후, 웹 개발에 관심이 있으시다면 "쉽게 배우는 Spring Boot 2"를, 파이썬 및 인공지능에 관심이 있으시다면 "이제부터 파이썬"을 수강하시는 것을 추천 드립니다.<br><br>
				감사합니다.
			</div>
			<div class="spacing30"></div>
			<h3>∘ 수강안내</h3>
			<table id="infotb" class="indent">
				<tr>
					<td>∘ 과정명</td>
					<td>&lt;초급: 누구나 JAVA-2부&gt; - 객체 지향 코딩의 정석</td>
				</tr>
				<tr>
					<td>∘ 교육목표</td>
					<td>
						- JAVA를 통해 객체 지향 프로그램의 개념과 동작 원리에 대해 배울 수 있습니다.<br>
						- 객체 지향 프로그래밍 방식을 적용한 애플리케이션을 제작할 수 있습니다.
					</td>
				</tr>
				<tr>
					<td>∘ 교육대상</td>
					<td>대학교 재학생/졸업생, 취업준비생</td>
				</tr>
				<tr>
					<td>∘ 일시</td>
					<td>
						오전반 : 2019년 11월 04일(월) ~ 11월 21일(목) 10:00 ~ 13:00 [총 14일, 42시간]<br>
						오후반 : 2019년 11월 25일(월) ~ 12월 12일(금) 14:00 ~ 17:00 [총 14일, 42시간]<br>
						야간반 : 2019년 11월 25일(월) ~ 12월 20일(금) 19:00 ~ 21:00 [총 20일, 40시간]<br>
						주말반 : 2019년 11월 16일(토) ~ 12월 08일(일) 10:00 ~ 15:00 [총 8일, 40시간]
					</td>
				</tr>
				<tr>
					<td>∘ 장소</td>
					<td>서울시 강남구 삼성동 코엑스(COEX) 4층 ICT 교육센터</td>
				</tr>
				<tr>
					<td>∘ 수강료</td>
					<td>350,000원</td>
				</tr>
				<tr>
					<td>∘ 교재</td>
					<td>미정</td>
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
			<div class="indent">∘ &lt;입문: 누구나 JAVA-1부&gt;</div>
			<div class="spacing30"></div>
			<h3>∘ 교육일정 및 커리큘럼</h3>
			<table id="currtb" class="indent">
				<tr>
					<td>일정</td>
					<td style="text-align: center;">교육시간</td>
					<td>교육내용</td>
				</tr>
				<tr>
					<td>11/04(월)</td>
					<td rowspan="14" style="text-align: center;">
						09:00 ~ 12:00
					</td>
					<td style="text-align: left;">
						자바의 메모리 구조<br>
						- JVM의 작동 원리<br>
						- 메모리 구조<br>
						- 참조 자료형
					</td>
				</tr>
				<tr>
					<td>11/05(화)</td>
					<td>
						다형성<br>
						- 상향 형변환(upcasting)과 하향 형변환(downcasting)<br>
						- 다형성의 실적용<br>
						추상(abstract)<br>
						- 자료의 추상화<br>
						- 추상 메서드<br>
						- 추상 클래스
					</td>
				</tr>
				<tr>
					<td>11/06(수)</td>
					<td>
						인터페이스<br>
						- 추상 클래스와 인터페이스<br>
						- 인터페이스의 목적<br>
						- 인터페이스와 상속
					</td>
				</tr>
				<tr>
					<td>11/07(목)</td>
					<td>
						API<br>
						- 패키지<br>
						- 주요 API<br>
						- API 문서 확인 방법
					</td>
				</tr>
				<tr>
					<td>11/08(금)</td>
					<td>
						예외 처리<br>
						- try, catch<br>
						- 예외의 종류<br>
						- finally
					</td>
				</tr>
				<tr>
					<td>11/11(월)</td>
					<td>
						예외 처리<br>
						- throw<br>
						- 사용자 정의 예외
					</td>
				</tr>
				<tr>
					<td>11/12(화)</td>
					<td>
						제네릭<br>
						- 타입 안정성<br>
						- 두 개 이상의 제네릭 적용<br>
						- 제네릭 메서드<br>
						- extends
					</td>
				</tr>
				<tr>
					<td>11/13(수)</td>
					<td>
						람다식<br>
						- 람다식 사용법<br>
						- 람다식 적용
					</td>
				</tr>
				<tr>
					<td>11/14(목)</td>
					<td>
						스레드<br>
						- 스레드의 생성 방법<br>
						- 스레드의 활용
					</td>
				</tr>
				<tr>
					<td>11/15(금)</td>
					<td>
						스레드<br>
						- synchronized<br>
						- wait()와 notifyAll()
					</td>
				</tr>
				<tr>
					<td>11/18(월)</td>
					<td>
						입출력<br>
						- 스트림의 종류<br>
						- 문자 입출력<br>
						- 파일 입출력
					</td>
				</tr>
				<tr>
					<td>11/19(화)</td>
					<td>
						입출력<br>
						- 버퍼 스트림<br>
						- 객체 입출력
					</td>
				</tr>
				<tr>
					<td>11/20(수)</td>
					<td>
						네트워크 프로그래밍<br>
						- TCP/IP<br>
						- URL 클래스<br>
						- 소켓을 이용한 통신
					</td>
				</tr>
				<tr>
					<td>11/21(목)</td>
					<td>
						네트워크 프로그래밍<br>
						- UDP<br>
						- 채팅 프로그램 예제
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
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
</style>
</head>
<body ng-app="myapp">
	<%@include file="../menu.jsp"%>
	<a id="MOVE_TOP_BTN" href="#none"><img src="/resources/segroup/society/edu/image/sub/top.png" style="width: 60px; height: 60px;" title="위로가기"></a>
	<div>
		<div class="top_img">
			<div class="top_img_text">
				<p class="top_img_text1">단기과정</p>
				<p class="top_img_text2">Spring Boot 2</p>
			</div>
		</div>
	</div>
	<div class="spacing50"></div>
	<div class="sub_m_contents">
		<div class="main_top_slidewrap">
			<h1 align="center">&lt;최신: 쉽게 배우는 Spring Boot 2&gt; - Spring Boot 2 with Hibernate & Gradle</h1>
			<div class="spacing50"></div>
			<h3>∘ 강좌안내</h3>
			<div class="indent">
				이 강좌는 Casual하고 빠르게 웹을 구현할 수 있도록 Spring Boot 2의 기본적인 웹 개발 방법에 대해서 수업하는 과정입니다. 이미 Spring Legacy와 JSP 등을 이용해 Spring MVC 개발을 해본 분이거나 Framework에 대한 기본지식이 없는 분들이라 하더라도, 쉽게 웹을 개발할 수 있도록 수업이 진행됩니다.<br><br>
				Gradle을 이용하여 Dependency를 관리하고 Hibernate를 이용한 영속성 관리 방법에 대한 실무적인 내용을 다룹니다.<br><br>
				이 과정을 공부하기 위해서는 Java언어와 HTML5/CSS3에 대한 기본적인 지식이 필요하며, Servlet/JSP 등으로 간단한 웹 개발을 해본 분 혹은 Spring Legacy 사용가능한 분이라면 좋습니다.<br><br>
				이 과정을 공부하고 난 이후 딥러닝 쪽에 관한 공부를 시작하고자 하신다면 “입문: 이제부터 파이썬” 수업을 수강하시는 것을 추천 드립니다.<br><br>
				감사합니다.
			</div>
			<div class="spacing30"></div>
			<h3>∘ 수강안내</h3>
			<table id="infotb" class="indent">
				<tr>
					<td>∘ 과정명</td>
					<td>&lt;최신: 쉽게 배우는 Spring Boot 2&gt; - Spring Boot 2 with Hibernate & Gradle</td>
				</tr>
				<tr>
					<td>∘ 교육목표</td>
					<td>
						- Spring Boot를 이용해 Spring에서 지원하는 웹 MVC와 데이터 처리 방식에 대한 학습을 한다.<br>
						- Spring Boot를 이용하여 웹 개발 방식에 대하여 이해하고 게시판 작성을 통해 웹을 구현해본다.
					</td>
				</tr>
				<tr>
					<td>∘ 교육대상</td>
					<td>대학교 재학생/졸업생, 취업준비생, 재직자 등</td>
				</tr>
				<tr>
					<td>∘ 일시</td>
					<td>
						오전반 : 2019년 10월 14일(월) ~ 10월 31일(목) 10:00 ~ 13:00 [총 14일, 42시간]<br>
						오후반 : 2019년 11월 04일(월) ~ 11월 21일(목) 10:00 ~ 13:00 [총 14일, 42시간]<br>
						야간반 : 2019년 11월 04일(월) ~ 11월 29일(금) 19:00 ~ 21:00 [총 22일, 40시간]<br>
						주말반 : 2019년 10월 26일(토) ~ 11월 15일(토) (토)10:00~17:00 6시간, (일) 10:00~13:00 3시간 [총 7일, 42시간]
					</td>
				</tr>
				<tr>
					<td>∘ 장소</td>
					<td>서울시 강남구 삼성동 코엑스(COEX) 4층 ICT 교육센터</td>
				</tr>
				<tr>
					<td>∘ 수강료</td>
					<td>500,000원</td>
				</tr>
				<tr>
					<td>∘ 교재</td>
					<td>미정</td>
				</tr>
				<tr>
					<td>∘ 최소인원</td>
					<td>5명 (최소인원 미달 시 폐강될 수 있음)</td>
				</tr>
				<tr>
					<td style="padding-bottom: 0px;">∘ 과정문의</td>
					<td style="padding-bottom: 0px;">02-6000-5450</td>
				</tr>
			</table>
			<div class="spacing30"></div>
			<h3>∘ 선수학습</h3>
			<div class="indent">
				∘ &lt;입문: 누구나 JAVA-1부&gt;<br>
				∘ &lt;초급: 누구나 JAVA-2부&gt;
			</div>
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
						10:00 ~ 13:00
					</td>
					<td style="text-align: left;">
						실습 환경 설정<br>
						- JDK 설치, STS 설치<br>
						스프링 부트를 이용한 프로젝트 작성<br>
						- 스프링 부트 프로젝트 만들기<br>
						- 스프링 부트 프로젝트 구조 및 실행<br>
						- 간단한 웹 애플리케이션의 작성
					</td>
				</tr>
				<tr>
					<td>10/15(화)</td>
					<td>
						의존성 관리와 자동설정<br>
						- 스타터로 의존성 관리하기<br>
						- 의존성 재정의<br>
						스프링 부트의 자동설정<br>
						- 자동설정 이해하기<br>
						- 사용자 정의 스타터
					</td>
				</tr>
				<tr>
					<td>10/16(수)</td>
					<td>
						스프링 부트에서 테스트와 로깅<br>
						- MockMvc 이용<br>
						- 컨트롤러 테스트<br>
						- 스프링 부트 로깅
					</td>
				</tr>
				<tr>
					<td>10/17(목)</td>
					<td>
						스프링 부트 빌드 이해<br>
						- Runnable JAR 실행하기
					</td>
				</tr>
				<tr>
					<td>10/18(금)</td>
					<td>
						JPA 개념의 이해와 설정<br>
						- 영속성 유닛 설정<br>
						- 엔티티 매핑 설정<br>
						- 식별자 값 자동 증가시키기
					</td>
				</tr>
				<tr>
					<td>10/21(월)</td>
					<td>
						JPA API<br>
						- EntityManagerFactory와 EntityManager<br>
						- 영속성 컨텍스트와 엔티티 상태
					</td>
				</tr>
				<tr>
					<td>10/22(화)</td>
					<td>
						스프링 데이터 JPA 사용하기<br>
						- 쿼리 메소드 사용
					</td>
				</tr>
				<tr>
					<td>10/23(수)</td>
					<td>
						스프링 데이터 JPA 사용하기 2<br>
						- @Query 어노테이션의 사용<br>
						- QueryDSL을 이용한 동적 쿼리 적용 : 연관관계 매핑
					</td>
				</tr>
				<tr>
					<td>10/24(목)</td>
					<td>
						화면 개발<br>
						- DB와 연동하기 / 게시판 구현하기
					</td>
				</tr>
				<tr>
					<td>10/25(금)</td>
					<td>
						Tymeleaf 연동<br>
						- Tymeleaf를 이용한 게시판 개발
					</td>
				</tr>
				<tr>
					<td>10/28(월)</td>
					<td>
						사용자 로그인 인증과 예외처리
					</td>
				</tr>
				<tr>
					<td>10/29(화)</td>
					<td>
						스프링 부트 시큐리티의 적용<br>
						- 시큐리티 이해 및 데이터베이스 연동
					</td>
				</tr>
				<tr>
					<td>10/30(수)</td>
					<td>
						스프링 시큐리티 동작 원리와 JPA의 연동
					</td>
				</tr>
				<tr>
					<td>10/31(목)</td>
					<td>
						Business Layer의 개발<br>
						- 비즈니스 컴포넌트 구조의 이해와 비즈니스 컴포넌트 개발<br>
						- 시큐리티의 적용
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
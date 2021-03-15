<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="ko">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<!-- 홈페이지의 대략적인 설명 >> 검색 결과 제목 하단에 설명으로 노출 -->
<meta name="description" content=디지털·AI, 외국어, 직무, 자격증까지! Let's Do it! Doitcampus!">
<!-- 홈페이지 키워드 >> 키워드 검색했을 때 검색결과로 노출 -->
<meta name="keywords"
	content="디지털, AI, 빅데이터, 프로그래밍, 정보처리, 데이터베이스, 클라우드, 외국어, 영어, 일본어, 중국어, 직무, 경영, 사업전략, 리더십, 코칭, 마케팅, CS, 자기관리, 커뮤니케이션, 법정의무, 취업, 해외취업, Soft Engineer Society, SES, 소프트엔지니어소사이어티, SCIT, SWDO, E러닝, e-learning">
<title>Let's Do it 두잇캠퍼스</title>
<link rel="stylesheet" href="/resources/lms/css/swiper.min.css">
<link rel="stylesheet" href="/resources/lms/css/reset.css">
<link rel="stylesheet" href="/resources/lms/css/common.css">
<link rel="stylesheet" href="/resources/lms/css/img-icon.css">
<link rel="stylesheet" href="/resources/lms/css/style.css">
<link rel="stylesheet" href="/resources/lms/css/style_responsive.css">
<link rel="stylesheet" href="/resources/lms/css/renewal_style.css">
<script src="/resources/lms/js/jquery-3.3.1.min.js"></script>
<script src="/resources/lms/js/swiper.js"></script>
<script src="/resources/lms/js/renewal_script.js"></script>

<script type="text/javascript">
	$(document).ready(function() {

		// 저장된 쿠키값을 가져와서 ID 칸에 넣어준다. 없으면 공백으로 들어감.
		var userInputId = getCookie("userInputId");
		$("input[name='user_id']").val(userInputId);

		if ($("input[name='user_id']").val() != "") { // 그 전에 ID를 저장해서 처음 페이지 로딩 시, 입력 칸에 저장된 ID가 표시된 상태라면,
			$("#saveID").attr("checked", true); // ID 저장하기를 체크 상태로 두기.
		}

		$("#saveID").change(function() { // 체크박스에 변화가 있다면,
			if ($("#saveID").is(":checked")) { // ID 저장하기 체크했을 때,
				var userInputId = $("input[name='user_id']").val();
				setCookie("userInputId", userInputId, 7); // 7일 동안 쿠키 보관
			} else { // ID 저장하기 체크 해제 시,
				deleteCookie("userInputId");
			}
		});

		// ID 저장하기를 체크한 상태에서 ID를 입력하는 경우, 이럴 때도 쿠키 저장.
		$("input[name='user_id']").keyup(function() { // ID 입력 칸에 ID를 입력할 때,
			if ($("#saveID").is(":checked")) { // ID 저장하기를 체크한 상태라면,
				var userInputId = $("input[name='user_id']").val();
				setCookie("userInputId", userInputId, 7); // 7일 동안 쿠키 보관
			}
		});

		var message = $("#message").val();
		if (message !== undefined  && message != "" && message.length != 0) {
			alert(message);
		}
	});

	function setCookie(cookieName, value, exdays) {
		var exdate = new Date();
		exdate.setDate(exdate.getDate() + exdays);
		var cookieValue = escape(value)
				+ ((exdays == null) ? "" : "; expires=" + exdate.toGMTString());
		document.cookie = cookieName + "=" + cookieValue;
	}

	function deleteCookie(cookieName) {
		var expireDate = new Date();
		expireDate.setDate(expireDate.getDate() - 1);
		document.cookie = cookieName + "= " + "; expires="
				+ expireDate.toGMTString();
	}

	function getCookie(cookieName) {
		cookieName = cookieName + '=';
		var cookieData = document.cookie;
		var start = cookieData.indexOf(cookieName);
		var cookieValue = '';
		if (start != -1) {
			start += cookieName.length;
			var end = cookieData.indexOf(';', start);
			if (end == -1)
				end = cookieData.length;
			cookieValue = cookieData.substring(start, end);
		}
		return unescape(cookieValue);
	}
</script>
</head>

<body>
	<div class="skip-navigation">
		<!--웹접근성/content-->
		<p>
			<a class="goToMain" href="#main">콘텐츠 바로가기</a>
		</p>
	</div>

	<!-- header-include -->
	<%@include file="../sub_header.jsp"%>

	<div class="container subPage_container sub00 d-flex">
		<!-- <div class="container sub00 sub00-01" id="main"> -->
		<!-- sub00로그인/회원가입-include -->
		<%@include file="../user/menu/leftmenu00.jsp"%>
		<!-- <div class="sub-content sub00-01">
			<div class="page-locationWrap">
                <ul class="page-location">
                    <li class="img-icon home"><a href="index.html"></a></li>
                    <li class="img-icon chevron-right"></li>
                    <li class="category-menu"><a href="/lms/user/sub00-01">로그인/회원가입</a></li>
                    <li class="img-icon chevron-right"></li>
                    <li class="division-menu"><a href="/lms/user/sub00-01">로그인</a></li>
                    <li class="img-icon chevron-right"></li>
                <li class="section-menu"><a href="#">로그인</a></li>
                </ul>
                <div class="img-icon chevron-right"></div>
                <div class="sub-content sub00-01"></div>
            </div>
            <div class="header">
                <div class="titleBar h3">로그인</div>
                <h3 class="h3"></h3>
            </div>
        </div> -->
		<div class="subPage_content sub-content margin-left20" id="main">
			<div class="section userInfo sub00-01">
				<div class="header">
					<strong class="h4">두잇캠퍼스에 오신 것을 환영합니다.</strong>
					<h5 class="fz14 c999">로그인을 위하여 아래 아이디와 비밀번호를 입력하여 주십시오.</h5>
				</div>
				<div class="loginWrap enterWrap">
					<form class="form formStyle" id="loginForm"
						action="/lms/user/login" method="post">
						<input type="hidden" name="${_csrf.parameterName}"
							value="${_csrf.token}" />
						<c:if test="${not empty SPRING_SECURITY_LAST_EXCEPTION }">
							<spring:message var="securityMessage"
								code="${SPRING_SECURITY_LAST_EXCEPTION.message}" />
							<input type="hidden" id="message" value="${securityMessage}" />
							<br />
							<c:remove scope="session" var="SPRING_SECURITY_LAST_EXCEPTION" />
						</c:if>

						<input class="input" name="user_id" type="text" placeholder="아이디"
							maxlength="24"> <input class="input" name="user_pw"
							type="password" placeholder="비밀번호">
						<div class="checkWrap">
							<label> <input class="input check" type="checkbox"
								name="saveID" id="saveID"> 아이디 저장
							</label>
						</div>
						<!-- <a href="#"><input type="button" class="blue-btn button" value="로그인"></a> -->
						<input type="submit" class="btn_normal btn_xlarge btn_orangeD" value="로그인">
					</form>
					<ul class="division-menuWrap d-flex justify_center">
						<li><a href="/lms/user/sub00-02">회원가입</a></li>
						<li class="divBar">&nbsp;|&nbsp;</li>
						<li><a href="/lms/user/sub00-03">아이디 찾기</a></li>
						<li class="divBar">&nbsp;|&nbsp;</li>
						<li><a href="/lms/user/sub00-04">비밀번호 찾기</a></li>
					</ul>
				</div>
			</div>
		</div>
	</div>

	<!-- footer-include -->
	<%@include file="../common_footer_doitcam.jsp"%>
</body>

</html>

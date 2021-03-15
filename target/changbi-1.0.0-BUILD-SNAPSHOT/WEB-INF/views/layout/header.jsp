<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="util" uri="http://www.aracomm.com/customtag/util" %>

<sec:authentication property="principal" var="principal" />
<c:set var="contextPathsub" value='${fn:split(requestScope["javax.servlet.forward.request_uri"],"/")}'/>
<c:set var="islogin" value="false"/>
<sec:authorize access="isAuthenticated()"><c:set var="islogin" value="true"/></sec:authorize>
<c:set var="isMobile" value="false"/>
<c:if test="${currentDevice.mobile }"><c:set var="isMobile" value="true"/></c:if>

	<!-- 1.1. 헤더 -->
			<div id="header"  class="header">
				<div class="area-top">
					<h1 class="header-logo affixed-element-top"><a href="/" title="메인으로"><img src="/resources/images/logo.png" alt="창비교육 원격교육연수원"/></a></h1>
					<form class="header-search" action="<c:url value="/search"/>">
						<span class="cusPlaceHolder">
							<input type="text" name="keyword" class="cusPHIn" data-placeholder="과정명 또는 강사를 검색하세요." value="<c:out value="${param.keyword }"/>">
						</span>
						<button type="submit"><span class="sr-only">검색</span></button>
					</form>
					<p class="header-keyword">
						<span class="txtBox arrowR">인기 검색어</span>
						<span class="hitkeywords">
						</span>
						<!--//
							1. 검색어 선택시 - 방법1) 해당 검색 결과 페이지로 이동  VS 방법2) 검색 창에 해당 검색어 값 임력
							어떤 방법을 쓰던지 자바스크립트 에러시 대체 콘텐츠 제공을 위해 a태그 href속성에 해당 키워드의 검색페이지로 바로 이동할 수 있는 경로 값을 삽입 함
							2. 타이틀에 검색어 및 작동 방식 설명 삽입
						//-->
					</p>
				</div><!--//.header>.area-top-->
				<div class="area-menu affixed-element-top">
					<div class="gnb">
						<ul class="menu-d1">
							<li class="menu-item"><a class="<c:if test="${fn:contains(contextPathsub[0],'mypage')}">on</c:if>" id="Myroom" href="javascript:authAlertMove('/mypage/lecture/lecture1')"><span class="menu-title">나의 강의실</span></a></li>
							<li class="menu-item"><a class="<c:if test="${fn:contains(contextPathsub[0],'learn')}">on</c:if>" id="Course" href="/learn/course/course?course_code=0"><span class="menu-title">연수 신청</span></a></li>
							<li class="menu-item"><a class="<c:if test="${fn:contains(contextPathsub[0],'guide')}">on</c:if>" id="Guide" href="/guide/training/guide"><span class="menu-title">연수 안내</span></a></li>
							<li class="menu-item"><a class="<c:if test="${fn:contains(contextPathsub[0],'teacher')}">on</c:if>" id="Teacher" href="/teacher/list"><span class="menu-title">강사 소개</span></a></li>
							<li class="menu-item"><a class="<c:if test="${fn:contains(contextPathsub[0],'serviceCenter')}">on</c:if>" id="Help" href="/serviceCenter/bbs/notice?board_type=1"><span class="menu-title">고객 센터</span></a></li>
						</ul>
						<!--//
							페이지 네비게이션을 위해 각 메뉴 링크 id 로 해당 페이지 도메인 값을 사용
							(우선 임시 도메인 값을 임의로 적용함)
						//-->
						<c:if test="${not empty principal }">
						<sec:authorize access="isAnonymous()">
						<p class="topmenu">
							<a href="javascript:popupOpen('layerLogin')">로그인</a>
							<a href="<c:url value="/member/join1"/>">회원 가입</a>
						</p>
						</sec:authorize>
						<sec:authorize access="isAuthenticated()">
							<c:choose>
								<c:when test="${currentDevice.mobile }">
									<p class="topmenu">
										<a href="<c:url value="/user/signout"/>">로그아웃</a>
										<a href="<c:url value="/mypage/private/privatecertification"/>">개인 정보 수정</a>
									</p>
								</c:when>
								<c:otherwise>
									<p class="topmenu login-util">
										<span><strong><util:strcut len="18" value="${principal.name}"/></strong> 님</span>
										<i>I</i><a href="<c:url value="/user/signout"/>">로그아웃</a><i>I</i><a href="<c:url value="/mypage/private/privatecertification"/>">개인 정보 수정</a>
									</p>
								</c:otherwise>
							</c:choose>
						</sec:authorize>
						</c:if>
						<c:if test="${empty principal }">
						<p class="topmenu">
							<a href="javascript:popupOpen('layerLogin')">로그인</a>
							<a href="<c:url value="/member/join1"/>">회원 가입</a>
						</p>
						</c:if>
						<a class="btn-toggle" href="#fullmenu"><strong class="alt-txt"> 전체 메뉴</strong></a>
					</div><!--// .gnb-->
					<div id="fullmenu" class="off">
						<%@ include file="/WEB-INF/views/common/header/fullmenu.jsp"%>
					</div><!--// #.fullmenu -->
				</div><!--//.header>.area-menu-->
				<hr/>
			</div><!--//.header#header-->
	<!--// 1.1. 헤더 END -->

	<!--// 로그인팝업 -->
	<div class="cl-popup-overlay" id="layerLogin">
		<div class="cl-popup-wrap">
			<c:choose>
				<c:when test="${currentDevice.mobile }">
			<div class="cl-popup-box full">
				</c:when>
				<c:otherwise>
			<div class="cl-popup-box mid" style="width:800px; margin-left:-400px;">
				</c:otherwise>
			</c:choose>
				<!--
					팝업타입 별 클래스 & 스타일 제어
						1.폭 800px 이하, 높이 500px 이하 팝업 정가운데 위치)
							- class="cl-popup-box"
							- style="width:폭; height:높이; margin-left:-폭/2; margin-right: -높이/2;"
						2.폭 800px 이하, 높이 500px 이상 가로 가운데 위치
							- class="cl-popup-box mid"
							- style="width:폭; margin-left:-폭/2;"
						3.풀화면 팝업
							- class="cl-popup-box full"
				-->
				<div class="popup-header">
					<h3 class="popup-title">창비교육 원격교육연수원에 오신 선생님! 환영합니다.</h3>
				</div>
				<div class="popup-body">
					<div class="certification">
						<div class="certi">
							<h3>공인 인증서 로그인</h3>
							<span>아이디/비밀번호는 인증서 갱신, 등록, 해제 시에 필요하오니 반드시 기억하시기 바랍니다.</span>
							<a href="javascript:gPopCertForLogin()" class="btn M primary login-bt">공인 인증서 로그인</a>
							<a href="javascript:authAlertMove('<c:url value="/mypage/certificate/certificate"/>')" class="btn M primary">공인 인증서 갱신 바로 가기</a>
						</div>
					</div>
					<form class="login_wrap" id="tloginForm" method="post">
						<h3>아이디 로그인</h3>
						<input type="hidden" name="certkey">
						<input type="text" placeholder="아이디" name="username" value="${cookieValue}">
						<input type="password" placeholder="비밀번호" name="password">
						<label><input type="checkbox" name="sslLoginEnable"> 보안 로그인 사용</label>
						<label><input type="checkbox" name="saveIdChecked" value="Y"> 아이디 저장</label>
						<a href="<c:url value="/member/findId"/>" class="nth-1st help">아이디/비밀번호 찾기</a>
						<button type="button" onclick="gLogin('tloginForm')">로그인</button>
						<a href="<c:url value="/member/join1"/>" class="register">회원 가입</a>
					</form>
				</div><!--//.popup-body-->
			</div><!--//.cl-popup-box-->
		</div><!--//.cl-popup-wrap-->
		<button class="cl-popup-closer">
			<span class="sr-only">닫기</span>
		</button>
	</div><!--//.cl-popup-overlay-->
	<!--// 로그인팝업 END -->

<script type="text/javascript">
// action 처리 메시지
var actionMessage = '<c:out value="${actionMessage }"/>';<%-- controller 메시지 --%>
if (!isEmpty(actionMessage)) alert(actionMessage);

var globals = {
	islogin: ${islogin},
	isMobile: ${isMobile},
	sslAvail: '<spring:eval expression="@config['https.avail']"/>' == 'Y',
	sslPort: '<spring:eval expression="@config['https.port']"/>'
};
function gLogin(formId) {
	var isSecureChecked = $('#'+formId).find('input[name="sslLoginEnable"]').is(':checked');
	var isCurrentSecure = (location.protocol == 'https:');

	var loginUrl = '<c:url value="/user/signin"/>';
	if (globals.sslAvail && isSecureChecked) {
		loginUrl = getSecureUrl(loginUrl,globals.sslPort);
	}

	// 보인로그인 여부에 따라 ajax login이  유효하지 않음
	if (globals.sslAvail && isSecureChecked && !isCurrentSecure) {
		$('#'+formId).attr('action', loginUrl);
		$('#'+formId).submit();
	} else {
		$.ajax({
			url : loginUrl,
			data: $('#'+formId).serialize(),
			method: 'POST',
			type: 'POST',
			dataType : 'json'/*,
			crossDomain: true,
			beforeSend: function(xhr) {
				xhr.setRequestHeader("Accept", "application/json");
				xhr.setRequestHeader("X-Requested-With", "XMLHttpRequest");
			} */
		}).done(function(responseData) {
			var error = responseData.error;
			var code = responseData.code;
			var message = responseData.message;

			if (error) {
				if (code === 403 || code === 201){
					alert(message);
				} else {
					alert('알수 없는 오류가 발생하였습니다.');
				}

			} else {
				var redirectUrl = responseData.data.redirectUrl;
				location.replace(redirectUrl);
			}
		});
	}
};

var idenWinForLogin;
function gPopCertForLogin() {
	$('#tloginForm').find('input[name="certkey"]').val('');
	var url = '<c:url value="/iden/nice/checkplusForCertLogin"/>?iden_callback_success=onIdentitySuccessForLogin';
	if (globals.sslAvail) {
		url = getSecureUrl(url,globals.sslPort);
	}
	idenWinForLogin = popIdenWindow(url, 422, 660);
}

function onIdentitySuccessForLogin(iden_gbn, data) {
	var di = data.di;
	idenWinForLogin.close();

	var isCurrentSecure = (location.protocol == 'https:');

	var loginUrl = '<c:url value="/user/certsignin"/>';
	if (globals.sslAvail) {
		loginUrl = getSecureUrl(loginUrl,globals.sslPort);
	}

	// 보인로그인 여부에 따라 ajax login이  유효하지 않음
	if (globals.sslAvail && !isCurrentSecure) {
		var formId = 'tloginForm';
		$('#'+formId).find('input[name="certkey"]').val(di);
		$('#'+formId).attr('action', loginUrl);
		$('#'+formId).submit();
	} else {
		$.ajax({
			url : loginUrl,
			data: {'certkey':di},
			method: 'POST',
			type: 'POST',
			dataType : 'json'/* ,
			crossDomain: true,
			beforeSend: function(xhr) {
				xhr.setRequestHeader("Accept", "application/json");
				xhr.setRequestHeader("X-Requested-With", "XMLHttpRequest");
			} */
		}).done(function(responseData) {

			var error = responseData.error;
			var code = responseData.code;
			var message = responseData.message;

			if (error) {
				if (code === 403 || code === 201){
					alert(message);
				} else {
					alert('알수 없는 오류가 발생하였습니다.');
				}

			} else {
				var redirectUrl = responseData.data.redirectUrl;
				location.replace(redirectUrl);
			}
		});
	}
}

$(document).ready(function() {
	// 비밀번호 enter시 로그인 진행
	$('#tloginForm input[name="password"]').keypress(function (e) {
		if (e.which == 13) {
			gLogin('tloginForm');
		}
	});

	// 인기검색어
	if($('.hitkeywords').length > 0) {
		$.getJSON('<c:url value="/ajaxHitKeywords"/>', function(data) {
			var keywords = data.keywords;
			for(var i=0; i<keywords.length; i++) {
				k = keywords[i];
				$('.hitkeywords').append('<a href="<c:url value="/search"/>?keyword='+encodeURIComponent(k)+'" title="'+k+'">'+k+'</a> ');
			}
		});
	}
});
</script>
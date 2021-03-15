<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="<c:url value="/resources/segroup/js/jquery-3.1.1.js" />"></script>
<link type="text/css" rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto:400,500">
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/segroup/society/fap/css/default.css" />" />
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/segroup/society/fap/css/popModal.css" />" />
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/segroup/society/edu/css/login.css" />">
<script src="<c:url value="/resources/segroup/society/edu/js/slidebanner.js" />"></script>

<title>Bridge Job Fair</title>
</head>
<body>
	<%@include file="agency_menu.jsp"%>
	
	<section class="login_wrap">
		<div style="height:76px; "></div>
		
		<!-- 비밀번호 찾기 결과 -->
		<h2><spring:message code="fap.comp.id_find_result" /></h2>
		<c:if test="${canChange}">
				<div style="width: 100%; height: 100px; border: 1px 1px 1px 1px;">
					<!-- 비밀번호가 정상적으로 변경되었습니다. -->
					<dd><spring:message code="fap.comp.pw_change_success_alert" /></dd>
				</div>
				
				<div style="width: 100%; height: 100px; border: 1px 1px 1px 1px;">
					<ul class="login_menu1">
						<li>
							<a href="/fap/agency/agency_login"><h4><spring:message code="fap.common.move_login" /></h4></a>
						</li>
					</ul>
				</div>	
		</c:if>
		
		<c:if test="${not canChange}">
				<div style="width: 100%; height: 100px; border: 1px 1px 1px 1px;">
					<!-- 비밀번호 변경 실패 -->
					<dd><spring:message code="fap.comp.pw_change_fail_alert" /></dd>
				</div>
				
				<div style="width: 100%; height: 100px; border: 1px 1px 1px 1px;">
					<ul class="login_menu2">
						<li>
							<a href="/fap/agency/agency_login"><h4><spring:message code="fap.common.move_login" /></h4></a>
						</li>
						<li>
							<a href="/fap/agency/agency_forgot_password_form"><h4><spring:message code="fap.common.find_pw" /></h4></a>
						</li>
					</ul>
				</div>
		</c:if>
	</section>

	<%@include file="agency_footer.jsp"%>
</body>
</html>
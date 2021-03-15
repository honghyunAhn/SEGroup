<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css"
	href="/resources/segroup/society/fap/css/error.css" />
<title>Bridge Job Fair</title>
</head>
<div>
	<ul id="infoMenu">
		<c:choose>
			<c:when test="${empty check }">
				<li><a href="/fap/company/company_login">Login</a></li>
			</c:when>
			<c:otherwise>
				<li><a href="#none" id="logout">Logout</a></li>
			</c:otherwise>
		</c:choose>
		<li><a href="/fap/company/company_insert_form">Join</a></li>
		<li><a href="member/qna.html">Q&amp;A</a></li>
		<li class=""><select id="langSelect">
				<option value="" selected="selected" disabled="disabled">언어
					선택</option>
				<option value="ko">한국어(KR)</option>
				<option value="ja">日本語(JP)</option>
		</select></li>
	</ul>
</div>
<body>
<div class="body">
		<div>
			<img onclick="location.href='#'" class="logo"
				src="/resources/segroup/society/fap/images/bottom_logo.png" />
		</div>
		<div class="content">
			<div class="content">
				<div>
					<h2><spring:message code="com.login.apologize" /></h2>
				</div>
				<div>
					<h4><spring:message code="com.login.error_reason" /></h4>
					<ul>
						<li><spring:message code="com.login.expired" /></li>
					</ul>
				</div>
				<div>
					<h4><spring:message code="com.login.error_solution" /></h4>
					<ul>
						<li><spring:message code="com.login.error_solution.rejoin" /></li>
						<li><spring:message code="com.login.error_solution.withdraw_confirm" /></li>
						<li>
							<spring:message code="com.login.error_solution.homepage" />
							<a href="/fap/company/company_security_invalidate">Home page</a>
							<spring:message code="com.login.error_solution.homepage_button" />
						</li>
						<li><button onclick="javascript:history.back()"><spring:message code="com.login.error_solution.prepage" /></button></li>
					</ul>
				</div>
				<div>
					<h4><spring:message code="com.login.more" /></h4>
					<p><spring:message code="com.login.inquiry" /></p>
					<p><spring:message code="com.login.check" /></p>
				</div>
			</div>
		</div>
		<div class="pine">
			<img style="margin: -120% 0% 0% -40%" class="img" src="/resources/segroup/society/fap/images/access_denied.jpg" />
		</div>
	</div>
</body>
</html>
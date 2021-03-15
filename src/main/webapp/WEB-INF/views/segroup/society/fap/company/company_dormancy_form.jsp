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
<%@include file="company_error_menu.jsp"%>
<body>
<div class="body">
		<div>
			<img onclick="location.href='#'" class="logo"
				src="/resources/segroup/society/fap/images/bottom_logo.png" />
		</div>
		<div class="content">
			<div class="content">
				<div>
					<h2><spring:message code="com.login.disabled" /></h2>
				</div>
				<div>
					<h4><spring:message code="com.login.error_reason" /></h4>
					<ul>
						<li><spring:message code="com.lgoin.error_reason.inaccessible_id" /></li>
					</ul>
				</div>
				<div>
					<h4><spring:message code="com.lgoin.error_solution" /></h4>
					<ul>
						<li><spring:message code="com.login.error_solution.reset" /></li>
						<li><spring:message code="com.login.error_solution.confirm" /></li>
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
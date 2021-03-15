<%-- <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>FINE APPs for sw peopLE 회원</title>
</head>
<body>
<h1>접근 권한 없음!</h1>
<a href="/fap/user/user_security_invalidate">로그인 페이지로 이동</a>
</body>
</html> --%>

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
<%@include file="user_error_menu.jsp"%>
<body>
<div class="body">
		<div>
			<img onclick="location.href='#'" class="logo"
				src="/resources/segroup/society/fap/images/bottom_logo.png" />
		</div>
		<div class="content">
			<!-- <div>
				<h2>We’re sorry — something has gone wrong on our end.</h2>
			</div>
			<div>
				<h4>What could have caused this?</h4>
				<ul>
					<li>Well, something technical went wrong on our site.</li>
					<li>We might have removed the page when we redesigned our
						website.</li>
					<li>Or the link you clicked might be old and does not work
						anymore.</li>
					<li>Or you might have accidentally typed the wrong URL in the
						address bar.</li>
				</ul>
			</div>
			<div>
				<h4>What you can do?</h4>
				<ul>
					<li>You might try retyping the URL and trying again.</li>
					<li>Or we could take you back to the <a href="#">Our home
							page.</a></li>
				</ul>
			</div>
			<div>
				<h4>One more thing:</h4>
				<p>If you want to help us fix this issue, we are here to help.
					Please contact us and let us know what went wrong.</p>
				<p>Be sure to let us know what Web Browser and Operating System
					you were using when this occurred.</p>
			</div>
		</div> -->
			<div class="content">
				<div>
					<h2><spring:message code="com.login.anounce" /></h2>
				</div>
				<div>
					<h4><spring:message code="com.login.error_reason" /></h4>
					<ul>
						<li><spring:message code="com.login.error_reason.nonlogin" /></li>
						<li><spring:message code="com.login.error_reason.session_expired" /></li>
						<li><spring:message code="com.login.error_reason.unauthorized" /></li>
						<li><spring:message code="com.login.error_reason.inaccessible_link" /></li>
					</ul>
				</div>
				<div>
					<h4><spring:message code="com.login.error_solution" /></h4>
					<ul>
						<li><spring:message code="com.login.error_solution.relogin" /></li>
						<li><spring:message code="com.login.error_solution.retype" /></li>
						<li><spring:message code="com.login.error_solution.access_confirm" /></li>
						<li>
							<spring:message code="com.login.error_solution.homepage" />
							<a href="/fap/user/user_security_invalidate">Home page</a>
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
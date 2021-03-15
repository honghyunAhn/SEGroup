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
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/segroup/society/edu/css/common.css" />">
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/segroup/society/edu/css/sub.css" />">
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/segroup/society/edu/css/main.css" />">
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/segroup/society/edu/css/login.css" />">
<script src="<c:url value="/resources/segroup/society/edu/js/slidebanner.js" />"></script>
<title>글로벌 엔지니어 양성</title>
<script type="text/javascript">
$(document).ready(function(){
	var message = $("#message").val();
	if (message != "undefined" && message != "" && message.length != 0) {
		alert(message);
	}
});
</script>
</head>
<body>
<%@include file="../menu.jsp"%>

<section class="login_section">
	<form action="/edu/user/login" id="loginForm" method="post">
	
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
		<c:if test="${not empty SPRING_SECURITY_LAST_EXCEPTION }">
			<spring:message var="securityMessage" code="${SPRING_SECURITY_LAST_EXCEPTION.message}" />
			<input type="hidden" id="message" value="${securityMessage}" /><br />
			<c:remove scope="session"  var="SPRING_SECURITY_LAST_EXCEPTION"/>
		</c:if>
		
		
		<div class="login_wrap">
			<h2>로그인</h2>
			<div class="input_wrap">
				<input class="login_id" name="user_id" type="text" placeholder="아이디" />
				<input type="password"  name="user_pw" placeholder="비밀번호" />
			</div>
				<!-- <div class="auto_cbox">
				<b class="check_box"></b>
				<p>저장</p>
				</div> -->
			<input  class="login_btn" type="submit" value="로그인">
			<ul class="login_menu3">
				<li>
					<a href="/edu/user/user_forgot_id">아이디 찾기</a>
				</li>
				<li>
					<a href="/edu/user/user_forgot_password">비밀번호 찾기</a>
				</li>
				<li>
					<a href="/edu/user/user_join_terms">회원가입</a>
				</li>
			</ul>
		</div>
	
	</form>
</section>

<%@include file="../footer.jsp"%>
</body>
</html>
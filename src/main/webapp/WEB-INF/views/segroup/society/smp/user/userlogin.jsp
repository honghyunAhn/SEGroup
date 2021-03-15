<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>SMP 학생 페이지</title>
<link rel="stylesheet" type="text/css"
	href="/resources/segroup/society/smp/css/login.css">
<script src="<c:url value="/resources/segroup/js/jquery-3.1.1.js" />"></script>
<script type="text/javascript">
	
	$(document).ready(function() {
		var message = $("#message").val();
		if (message != "undefined" && message != "" && message.length != 0) {
			alert(message);
		}
	});
</script>
</head>
<body>
<!-- 시큐리티 정보 -->
	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
	<c:if test="${not empty SPRING_SECURITY_LAST_EXCEPTION }">
		<spring:message var="securityMessage" code="${SPRING_SECURITY_LAST_EXCEPTION.message}" />
		<input type="hidden" id="message" value="${securityMessage}" /><br />
		<c:remove scope="session"  var="SPRING_SECURITY_LAST_EXCEPTION"/>
	</c:if>
   <div id="card">
      <h2>KITA 무역 아카데미 로그인</h2>
      <form action="/smp/user/login" method="post" id="loginForm">
      <input type="text" id="user_id" name="user_id" placeholder="ID" /> 
      <input type="password" id="user_pw" name="user_pw" placeholder="Password" />

      <input type="submit" id="login" name="login" value="로그인" />
      </form>
   </div>

   <script
      src="//ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
</body>
</html>
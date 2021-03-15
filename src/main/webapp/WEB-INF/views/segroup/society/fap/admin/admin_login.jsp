<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Bridge Job Fair</title>

<script src="<c:url value="/resources/segroup/js/jquery-3.1.1.js" />"></script>
<script src="http://netdna.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
<link rel="stylesheet" type="text/css" href="http://netdna.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">

<!-- 페이징관련 css 시작 -->
<script src="<c:url value="/resources/segroup/society/edu/js/slidebanner.js" />"></script>
<script src="<c:url value="/resources/segroup/society/edu/js/jquery.bxslider.min.js" />"></script>
<!-- bxSlider CSS file -->
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/segroup/society/edu/css/jquery.bxslider.css" />" />
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/segroup/society/edu/css/common.css" />">
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/segroup/society/edu/css/main.css" />">
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/segroup/society/edu/css/sub.css" />">
<!-- 페이징 관련 css 끝 -->

<style>
	* {
		-webkit-box-sizing: border-box;
		   -moz-box-sizing: border-box;
		        box-sizing: border-box;
		outline: none;
	}
	body {
		background: url(/resources/segroup/society/edu/image/main/bg.jpg) no-repeat center center fixed;
		-webkit-background-size: cover;
		   -moz-background-size: cover;
		     -o-background-size: cover;
		        background-size: cover;
	}
	.login-form {
		margin: 100px auto;
		max-width: 446px;
	}
	form[role=login] {
		font: 18px/2.2em Lato, serif;
		color: #b4b4b4;
		background: #fff;
		max-width: 446px;
		-webkit-border-radius: 5px;
		   -moz-border-radius: 5px;
		        border-radius: 5px;
		padding: 5px 40px 30px 40px;
	}	
	form[role=login] h3 {
		font-size: 24px;
		color: #0b2344;
	}
	form[role=login] h4 {
		margin: 15px 0 30px 0;
	}
	form[role=login] input,
	form[role=login] button {
		font-size: 16px;
		margin: 5px 0;
	}
	form[role=login] input {
		color: #000;
		box-shadow: none;
	}
	form[role=login] input::-webkit-input-placeholder {
		color: #c1c4c5;
	}
	form[role=login] input:-moz-placeholder {
		color: #c1c4c5;
	}
	form[role=login] input::-moz-placeholder {
		color: #c1c4c5;
	}
	form[role=login] input:-ms-input-placeholder {  
		color: #c1c4c5;
	}
	form[role=login] > div {
		margin-top: 20px;
		text-align: center;
		font-size: 15px;
	}
	form[role=login] > div a {
		font-size: 15px;
		color: #007fff;
	}
</style>
<script type="text/javascript">
	$(document).ready(function() {
		var message = $("#message").val();
		if (typeof message != "undefined" && message != "") {
			alert(message);
		}
	});
	
	function formCheck(){
		var user_id = $.trim($("#user_id").val());
		var user_pw = $.trim($("#user_pw").val());
		
		if(user_id == ""){
			alert('<spring:message code="fap.err.id_input_err" />');
			return false;
		}
		
		if(user_pw == ""){
			alert('<spring:message code="fap.err.pw_check" />');
			return false;
		}
		return true;
	}
</script>
</head>
<body>
	<section class="container">
		<section class="login-form">
			<%-- <a href="/fap/admin/admin_login?lang=ko">언어변경</a>
			<spring:message code="test" /> --%>
			
			<form action="/fap/admin/login" id="loginForm" method="post" role="login" onsubmit="return formCheck();">
				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
				<c:if test="${not empty SPRING_SECURITY_LAST_EXCEPTION }">
					<spring:message var="securityMessage" code="${SPRING_SECURITY_LAST_EXCEPTION.message}" />
					<input type="hidden" id="message" value="${securityMessage}" /><br />
					<c:remove scope="session"  var="SPRING_SECURITY_LAST_EXCEPTION"/>
				</c:if>
				<div>
					<img src="/resources/segroup/society/edu/image/main/logo.png" alt="" />
					<h4>관리자 로그인</h4>
				</div>
				<input class="form-control input-lg" type="text" placeholder="USER ID" name="user_id" id="user_id"> <br />
				<input class="form-control input-lg" type="password" placeholder="PASSWORD" name="user_pw" id="user_pw"> <br />
				<input type="submit" name="go" class="btn btn-lg btn-block btn-info" value="Sign in">
				<!-- <input type="button" id="joinBtn" class="btn btn-lg btn-block btn-info" value="Sign Up"> -->
			</form>
		</section>
	</section>
</body>
</html>
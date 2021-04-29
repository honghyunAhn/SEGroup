<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Bridge Job Fair</title>
<link rel="stylesheet" type="text/css" href="/resources/segroup/society/fap/css/default.css" />
<link type="text/css" rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto:400,500">
<link type="text/css" rel="stylesheet" href="/resources/segroup/society/fap/css/popModal.css">
<script src="<c:url value="/resources/segroup/js/jquery-3.1.1.js" />"></script>
<script type="text/javascript">
	
	$(document).ready(function() {
		var message = $("#message").val();
		if (typeof message != "undefined" && message != "") {
			alert(message);
		}
		
		$("#user_pw").keyup(function(e){
			if(e.keyCode == 13)
				formCheck();
			});
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
		$('#loginForm').submit();
		
	}
</script>
</head>
<body>
	<%@include file="company_menu.jsp"%>
	<div class="join-wrap">	
		<div id="subcontents">

			<div id="loginBox">
				<div class="login_tabs">
					<div class="user_login_tab">
						<a href="/fap/user/user_login">
							<img src="<c:url value="/resources/segroup/society/fap/images/unck_radio.png" />">
							<spring:message code="com.login.user.tab" />
						</a>
					</div>
					<div class="company_login_tab">
						<a>
							<img src="<c:url value="/resources/segroup/society/fap/images/ck_radio.png" />">
							<spring:message code="com.login.company.tab" />
						</a>
					</div>
				</div>
				<div id="loginBBS">
					<form action="/fap/company/login" id="loginForm" method="post" role="login">
							
						<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /> 
						<c:if test="${not empty SPRING_SECURITY_LAST_EXCEPTION }">
							<spring:message var="securityMessage" code="${SPRING_SECURITY_LAST_EXCEPTION.message}" />
							<input type="hidden" id="message" value="${securityMessage}" /><br />
							<c:remove scope="session"  var="SPRING_SECURITY_LAST_EXCEPTION"/>
						</c:if>
							
							<div class="logintxt1">Login</div>
							<div class="logintxt2"><img src="/resources/segroup/society/fap/images/login_bar.gif" /></div>
							<div class="logintxt3">&nbsp;&nbsp;<input type="text" name="user_id" id="user_id" placeholder="ID" /></div>
							<div class="logintxt3">&nbsp;&nbsp;<input type="password" name="user_pw" id="user_pw" placeholder="PW" /></div>

							<div class="logintxt5"><button type="button" name="go"class="btn14 btn-primary" onclick="formCheck();">Login</button></div>
							<br>
							
							<div class="logintxt6">
									<button
										type="button"
										onclick="location.href='/fap/company/company_insert_form'"
										class="btn17 btn-primary">
										<spring:message code="fap.common.sign_up" />
									</button>
							</div>
					</form>
						<ul>
							<li class="logintxt7">
									<button
										type="button"
										onclick="location.href='/fap/company/company_forgot_id'"
										class="btn17 btn-primary">
										<spring:message code="fap.common.find_id" />
									</button>
							</li>
							<li class="logintxt7">
									<button
										type="button"
										onclick="location.href='/fap/company/company_forgot_password'"
										class="btn17 btn-primary">
										<spring:message code="fap.common.find_pw" />
									</button>
							</li>
						</ul>
				</div>
			</div>
		</div>
		<%@include file="../common_footer_fap.jsp"%>
	</div>
</body>
</html>
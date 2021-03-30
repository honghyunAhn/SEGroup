<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Bridge Job Fair</title>
	<link rel="stylesheet" type="text/css" href="<c:url value="/resources/segroup/society/fap/css/userDefault.css" />" />
	<link type="text/css" rel="stylesheet" href="/resources/segroup/society/fap/css/popModal.css">
	<script src="<c:url value="/resources/segroup/js/jquery-3.1.1.js" />"></script>
	<script src="<c:url value="/resources/segroup/js/angular.min.js" />"></script>
	
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
				alert('아이디를 입력해주세요.');
				return false;
			}
			
			if(user_pw == ""){
				alert('패스워드를 입력해주세요.');
				return false;
			}
			$('#loginForm').submit();
			
		}
	</script>
</head>
<body>
	<%@include file="user_menu.jsp"%><%@include file="user_quick_menu.jsp"%>
	<div class="join-wrap">
		<div id="loginSubcontents">
			<div id="loginBox">
				<div class="login_tabs">
					<div class="user_login_tab">
						<a>
							<img src="<c:url value="/resources/segroup/society/fap/images/ck_radio.png" />">
							<spring:message code="com.login.user.tab" />
						</a>
					</div>
					<div class="company_login_tab">
						<a href="/fap/company/company_login">
							<img src="<c:url value="/resources/segroup/society/fap/images/unck_radio.png" />">
							<spring:message code="com.login.company.tab" />
						</a>
					</div>
				</div>
				<div id="loginBBS">
					<form action="/fap/user/login" id="loginForm" method="post" role="login">
							
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
									<button type="button"
										onclick="location.href='<c:url value="/fap/user/user_insert_form" />'"
										class="btn17 btn-primary">
										회원가입
									</button>
							</div>
					</form>
						<ul>
							<li class="logintxt7">
									<button type="button"
										onclick="location.href='<c:url value="/fap/user/user_forgot_id" />'"
										class="btn17 btn-primary">
										아이디 찾기
									</button>
							</li>
							<li class="logintxt7">
									<button type="button"
										onclick="location.href='<c:url value="/fap/user/user_forgot_password" />'"
										class="btn17 btn-primary">
										비밀번호 찾기
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
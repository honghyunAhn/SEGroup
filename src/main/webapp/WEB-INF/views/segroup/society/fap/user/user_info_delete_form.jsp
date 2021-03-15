<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="<c:url value="/resources/segroup/js/jquery-3.1.1.js" />"></script>
<link type="text/css" rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto:400,500">
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/segroup/society/fap/css/default.css" />" />
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/segroup/society/fap/css/popModal.css" />" />

<title>Bridge Job Fair</title>
<script type="text/javascript">
function closeChildrenWindow() {
	window.close();
}
function formCheckAfterWithdraw() {
	var input_id = $('#user_id');
	var input_pw = $('#user_pw');
	var input_pw_check = $('#user_pw_check');
	
	if (input_id.val() == '') {
		alert('<spring:message code="fap.err.id_input_err" />');
		return;
	}
	
	if (input_pw.val() == '') {
		alert('<spring:message code="fap.err.pw_check" javaScriptEscape="true" />');
		selectAndFocus(input_pw);
		return false;
	}
	if (input_pw_check.val() == '') {
		alert('<spring:message code="fap.err.pw_check_input" javaScriptEscape="true" />');
		selectAndFocus(input_pw_check);
		return false;
	}
	
	if (input_pw.val() != input_pw_check.val()) {
		alert('<spring:message code="fap.err.pw_mismatched" javaScriptEscape="true" />');
		selectAndFocus(input_pw);
		return false;
	}
	
	var withdrawUserInfo = {
			'user_id' : input_id.val()
			,'user_pw' : input_pw_check.val()
	}

	$.ajax({
		beforeSend: function(xhr) {
		     xhr.setRequestHeader("AJAX", true);
		},
		url : '/fap/user/user_info_delete',
		type : 'post',
		contentType: 'application/json',
		data : JSON.stringify(withdrawUserInfo),
        dataType : "text", 
		success : function(response) {
			console.log(response);
			switch(response){
				case '1' : 
					//정상탈퇴
					alert('<spring:message code="fap.comp_withdraw_complete_alert" />');
					window.close();
					location.href = "/"; //허브페이지로 이동
					break;
				default : 
					alert('<spring:message code="fap.comp_mismatch_input_info_alert" />');
					break;
			}
		},
		error : function(response) {
			console.log(response);
			if(response.status == 403){
				alert('<spring:message code="com.login.ajaxSesstion" javaScriptEscape="true" />');
				location.href = "/fap/user/user_login";
			}
		}
	});	
}
</script>
</head>
<body>
	<div id="idpwBox" style="width:480px;">
		<div id="innerBox">
			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
			<div class="logintxt1" style="margin-top:15px; margin-bottom:15px; text-align: center;">
					<a href=""><h3 style="color: #930117;"><spring:message code="fap.common.user_withdraw" /></h3></a>
			</div>
			<div class="logintxt3" style="margin-left: 14%;">
				<input type="text" id="user_id" name="user_id" placeholder="ID"/>
			</div>
			<div class="logintxt3" style="margin-left: 14%;">
				<input type="password" id="user_pw" name="user_pw" placeholder="Password"/>
			</div>
			<div class="logintxt3" style="margin-left: 14%;">
				<input type="password" id="user_pw_check" name="user_pw_check" placeholder="Password Check"/>
			</div>
			<br>
			<div class="logintxt5" style="padding-bottom: 10px; text-align: center;">
				<button type="button" onclick="formCheckAfterWithdraw();" class="btn17 btn-primary" style="width:250px; background:#930117; border:1px solid #930117; font-size:16px; color:#fff;">
					<spring:message code="fap.common.user_withdraw" />
				</button>
				<br><br>
				<a href="javascript:closeChildrenWindow()"><h4 style="color: #930117;">close</h4></a>
			</div>
		</div>
	</div>
</body>
</html>
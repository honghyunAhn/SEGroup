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
<link type="text/css" rel="stylesheet"
	href="https://fonts.googleapis.com/css?family=Roboto:400,500">
<link rel="stylesheet" type="text/css"
	href="<c:url value="/resources/segroup/society/fap/css/default.css" />" />
<link rel="stylesheet" type="text/css"
	href="<c:url value="/resources/segroup/society/fap/css/popModal.css" />" />

<title><spring:message code="fap.common.my_page" /></title>
<script type="text/javascript">
	$(function() {
		$('#certi_code_section').hide();
	});

	/**
	 * 코드를 요청한다
	 */
	function request_certification_code() {
		var element_id = $('#user_id');
		if (element_id.val() == '') {
			alert('<spring:message code="fap.err.id_input_err" />');
			return;
		}

		var element_name = $('#user_nm');
		if (element_name.val() == '') {
			alert('<spring:message code="fap.comp.name_input_alert" />');
			return;
		}

		var element_email = $('#user_email');
		if (element_email.val() == '') {
			alert('<spring:message code="fap.comp.email_input_alert" />');
			return;
		}

		$('#certi_code_btn').html('<spring:message code="fap.comp.transmission_phrase" />');

		$.ajax({
			url : '<c:url value="/fap/user/user_request_certification_code" />',
			data : {
				user_id : element_id.val(),
				user_nm : element_name.val(),
				user_email : element_email.val()
			},
			success : function(isRequested) {
				if (!isRequested) {
					element_id.attr('readonly', '');
					element_name.attr('readonly', '');
					element_email.attr('readonly', '');
	
					var element_auth = $('#certi_code_section');
					$('#certi_code_btn').attr('id', 'certi_btn');
					$('#certi_btn').attr('onclick', 'certification_code();');
					
					$('#certi_btn').html('<spring:message code="fap.comp.authentication" />');
					element_auth.show();
					//약관란 높이 키우는 부분
					$('#privacy-policy').css('height', '500');
				} else {
					//이름과 메일주소가 일치하지 않음
					alert('<spring:message code="fap.comp.name_not_match_up" />');
					$('#certi_code_btn').html('<spring:message code="fap.comp.email_transmission" />');
				}
			},
			error : function(e) {
				//에러발생
				alert('<spring:message code="fap.comp.error_occurrence" />');
				$('#certi_code_btn').html('<spring:message code="fap.comp.email_transmission" />');
			}
		});
	}

	/**
	 * 
	 */
	function certification_code() {
		var input_auth = $('#certi_code');
		
		if (input_auth.val().length != 4
				|| new RegExp("[0-9]{4}").test(input_auth.val()) == false) {
			alert('<spring:message code="fap.comp.mis_auth_num_alert" />');
			return;
		}

		$.ajax({
			url : '<c:url value="/fap/user/user_check_certification_code" />',
			data : {
				certification_code : input_auth.val(),
			},
			success : function(isRequested) {
				if (isRequested) {
					input_auth.attr('readonly', '');
					
					//인증완료
					alert('<spring:message code="fap.comp.auth_agree_input_alert" />');
					location.href = "<c:url value='/fap/user/user_forgot_password_form' />";
				} else {
					//인증번호 틀리는 상황
					alert('<spring:message code="fap.comp.mis_auth_num_alert" />');
				}
			},
			error : function(e) {
				alert('<spring:message code="fap.comp.error_occurrence" />');
			}
		});
	}
</script>
</head>
<body>
<%@include file="user_menu.jsp"%><%@include file="user_quick_menu.jsp"%>
<div class="join-wrap">
	<!-----------------------서브컨텐츠 영역-------------------------->
	<div id="subcontents">
		<div id="loginmsg" style="padding-left: 8%;">
			<div id="privacy-policy" style="height: 420px;">
				<div class="privacy-policy-context">
					<h2>
						<spring:message code="fap.comp.pwsearch.header" />
					</h2>
					<h3>
						<spring:message code="fap.comp.pwsearch.text1" />
					</h3>
					<h3>
						<spring:message code="fap.comp.pwsearch.text2" />
					</h3>
					<h3>
						<spring:message code="fap.comp.pwsearch.text3" />
					</h3>
					<h3>
						<spring:message code="fap.comp.pwsearch.text4" />
					</h3>
					<h3>
						<spring:message code="fap.comp.pwsearch.text5" />
					</h3>
					<h4>
						<spring:message code="fap.comp.pwsearch.email" />
					</h4>
					<h4>
						<spring:message code="fap.comp.pwsearch.phone" />
					</h4>					
				</div>
			</div>
		</div>

		<div id="idpwBox">
			<ul>
				<li class="logintxt1"><spring:message code="fap.common.find_pw" /></li>
				
				<li class="logintxt2">
					<img src="<c:url value="/resources/segroup/society/fap/images/login_bar.gif" />" />
				</li>
				
				<li class="logintxt3">
					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /> 
					<input type="text" id="user_id" name="user_id" placeholder="ID" style="padding: 0; width: 36%;"/>
				</li>
				
				<li class="logintxt3">
					<input type="text" id="user_nm" name="user_nm" placeholder="Name" style="padding: 0; width: 36%;"/>
				</li>
				
				<li class="logintxt3">
					<input type="email" id="user_email" name="user_email" placeholder="Email" style="padding: 0; width: 36%;"/>
				</li>
				
				<li class="logintxt4" id="certi_code_section">
					<input id="certi_code" class="login_id" type="text" maxlength="4" name="code_number" placeholder="<spring:message code="fap.comp.auth_number" />" tabindex="4" style="padding: 0; width: 36%;"/>
					<br>
					<span><h5>&nbsp;<spring:message code="fap.comp.transmission_complete_phrase" /></h5></span>
				</li>

				<li class="logintxt5">
					<br>
					<button class="btn8 btn-primary" type="button" id="certi_code_btn" onclick="request_certification_code();" style="padding: 0; width: 37%;">
						<spring:message code="fap.comp.email_transmission" />
					</button>
				</li>
				<li class="logintxt5">
					<a href="/fap/user/user_login">
						<button type="button" class="btn17 btn-primary" style="width: 37%;">
							<spring:message code="fap.common.move_login" />
						</button>
					</a>
				</li>
			</ul>
		</div>

	</div>
	<!-----------------------/서브컨텐츠 영역-------------------------->
</div>

	<%@include file="../common_footer_fap.jsp"%>
</body>
</html>
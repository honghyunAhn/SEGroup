<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
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
$(function() {
	$('#certi_code_btn').on('click', request_certification_code);
	$('#certi_btn').on('click', certification_code);
	$('#certi_code_section').hide();
});

/**
 * 코드를 요청한다
 */
function request_certification_code() {
	var element_id = $('#user_id');
	if (element_id.val() == '') {
		alert('아이디를 적어주세요');
		return;
	}
	
	var element_name = $('#user_nm');
	if (element_name.val() == '') {
		alert('이름을 적어주세요');
		return;
	}
	
	var element_email = $('#user_email');
	if (element_email.val() == '') {
		alert('이메일을 적어주세요');
		return;
	}
	
	var btn = $('#certi_code_btn');
	btn.off('click');
	btn.css('background-color', 'lightgray');
	
	$.ajax({
		url: '<c:url value="/edu/user/user_request_certification_code" />',
		data: {
			user_id: element_id.val(),
			user_nm: element_name.val(),
			user_email: element_email.val()
		},
		success: function(isRequested) {
			if (!isRequested) {
				element_name.attr('readonly', '');
				element_email.attr('readonly', '');
				
				var element_auth = $('#certi_code_section');
				element_auth.show();
				
				var input_auth = $('#certi_code');
				input_auth.select();
				input_auth.focus();
			} else {
				alert('입력된 내용과 일치하는 정보가 없습니다');
				
				btn.on('click', request_certification_code);
				btn.css('background-color', '#212121');
			}
		},
		error: function(e) {
			alert('에러가 발생했습니다');
			
			btn.on('click', request_certification_code);
			btn.css('background-color', '#212121');
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
		alert('코드가 일치하지 않습니다');
		input_auth.focus();
		input_auth.select();
		return;
	}
	
	var btn = $('#certi_btn');
	btn.off('click');
	btn.css('background-color', 'lightgray');
	
	$.ajax({
		url: '<c:url value="/edu/user/user_check_certification_code" />',
		data: {
			certification_code: input_auth.val(),
		},
		success: function(isRequested) {
			if (isRequested) {
				input_auth.attr('readonly', '');
				alert('인증에 성공하였습니다');
				location.href = "<c:url value='/edu/user/user_forgot_password_form' />";
			} else {
				alert('인증에 실패하였습니다');

				btn.on('click', certification_code);
				btn.css('background-color', '#212121');
			}
		},
		error: function(e) {
			alert('에러가 발생했습니다');

			btn.on('click', certification_code);
			btn.css('background-color', '#212121');
		}
	});
}

</script>
</head>
<body>
<%@include file="../menu.jsp"%>
<br> <!-- 제목높이 보정용 -->
<section class="login_section">
	<div class="login_wrap">
		<h2>비밀번호 찾기</h2>
		<div class="input_wrap">
			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
			<input class="login_id" id="user_id" type="text"  name="user_id" placeholder="아이디" />
			<input class="login_id" id="user_nm" class="login_id" type="text" name="user_nm" placeholder="이름"/>
			<input id="user_email" type="email"  name="user_email" placeholder="이메일" />
		</div>
		
		<input id="certi_code_btn" class="login_btn" type="button" value="인증 번호 받기">
		
		<div id="certi_code_section">
			<div class="input_wrap">
				<input id="certi_code" class="login_id" type="text" maxlength="4"  name="code_number" placeholder="인증 번호 입력" />
				<span>이메일로 코드가 발송되었습니다</span>
			</div>
			
			<input id="certi_btn" class="login_btn" type="button" value="인증">
		</div>
	</div>
</section>

<%@include file="../footer.jsp"%>
</body>
</html>
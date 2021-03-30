<%-- <%@ page language="java" contentType="text/html; charset=UTF-8"
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
<script src="<c:url value="/resources/segroup/js/angular.min.js" />"></script>
<script src="<c:url value="/resources/segroup/society/edu/js/slidebanner.js" />"></script>
<title>Bridge Job Fair</title>
<script type="text/javascript">
// 정규표현식
var pw_regex = new RegExp("[0-9a-zA-Z!@#$%^&*]+");	// 수정 필요

// 상수
const PW_MIN_LENGTH = 8;
const PW_MAX_LENGTH = 12;

/**
 * 서브밋하기 전에 데이터를 체크한다
 */
function checkOnSubmit() {
	if (isPasswordCorrect() == false) { return false; }
	return true;
}

/**
 * 패스워드 검사를 진행한다
 * return: 같으면 true, 다르면 false
 */
function isPasswordCorrect() {
	var input_pw = $('#user_pw');
	var input_pw_check = $('#user_pw_check');
	
	var input_pw_val = input_pw.val();
	var input_pw_check_val = input_pw_check.val();
	
	if (input_pw_val.length < PW_MIN_LENGTH ||
			PW_MAX_LENGTH < input_pw_val.length) {
		alert('비밀번호의 길이가 맞지 않습니다');
		selectAndFocus(input_pw);
		return false;
	}
	
	if (input_pw_val == '') {
		alert('비밀번호를 입력해 주시기 바랍니다');
		selectAndFocus(input_pw);
		return false;
	}
	
	if (input_pw_check_val == '') {
		alert('비밀번호 확인란에 입력해 주시기 바랍니다');
		selectAndFocus(input_pw_check);
		return false;
	}
	
	if (pw_regex.test(input_pw_val) == false) {
		alert('비밀번호의 형식이 잘못 되었습니다');
		selectAndFocus(input_pw);
		return false;
	}
	
	if (input_pw_val != input_pw_check_val) {
		alert('비밀번호가 일치하지 않습니다');
		selectAndFocus(input_pw);
		return false;
	}
	
	return true;
}


/**
 * 엘리먼트를 선택한다
 */
function selectAndFocus(element) {
	element.select();
	element.focus();
}


/**
 * angular.js
 */
var myApp = angular.module('myapp', []);
myApp.directive('code', ['$http', function($http){
	return {
		restrict: "E",
		replace: true,
		scope : {
			value : '@'
		},
		controller: function ($scope, $element, $attrs) {
			$http({
				method: 'POST',
				url: '/codeconverter',
		  		responseType: 'text',
				params : {
					code : $attrs.value
				}
			}).then(function successCallback(response) {
	    		$scope.filterParams = response.data;
			}, function errorCallback(response) {
				console.log(response);
			});
		}
		,template: "<span>{{filterParams}}</span>"
	}
}]);



</script>
</head>
<body>
<br> <!-- 제목높이 보정용 -->
<section class="login_section">
	<!-- section -->
	<div class="login_wrap">
		<h2>비밀번호 변경하기</h2>
		<form action="<c:url value='/fap/user/user_forgot_password_change' />" method="POST" onsubmit="return checkOnSubmit();">
			<div class="input_wrap">
				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
				<input id="user_pw" class="login_id" type="password" name="user_pw" placeholder="비밀번호(8~12자리)" maxlength="12"/>
				<input id="user_pw_check" type="password"  name="user_pw_check" placeholder="비밀번호 확인(8~12자리)" maxlength="12" />
			</div>
			
			<input class="login_btn" type="submit" value="변경">
		</form>
	</div>
</section>
<div style="height:36px; "></div> <!-- 바닥높이 보정용 -->
</body>
</html> --%>


<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="<c:url value="/resources/segroup/js/jquery-3.1.1.js" />"></script>
<link type="text/css" rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto:400,500">
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/segroup/society/fap/css/default.css" />" />
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/segroup/society/fap/css/popModal.css" />" />
<script src="<c:url value="/resources/segroup/js/angular.min.js" />"></script>

<title><spring:message code="fap.common.my_page" /></title>
<script type="text/javascript">
// 정규표현식
var pw_regex = new RegExp("[0-9a-zA-Z!@#$%^&*]+");	// 수정 필요

// 상수
const PW_MIN_LENGTH = 8;
const PW_MAX_LENGTH = 40;

/**
 * 서브밋하기 전에 데이터를 체크한다
 */
function checkOnSubmit() {
	if (isPasswordCorrect() == false) { return false; }
	$('#user_forgot_password_change').submit();
}

/**
 * 패스워드 검사를 진행한다
 * return: 같으면 true, 다르면 false
 */
function isPasswordCorrect() {
	var input_pw = $('#user_pw');
	var input_pw_check = $('#user_pw_check');
	
	var input_pw_val = input_pw.val();
	var input_pw_check_val = input_pw_check.val();
	
	if (input_pw_val.length < PW_MIN_LENGTH ||
			PW_MAX_LENGTH < input_pw_val.length) {
		//비밀번호의 길이가 맞지 않습니다.
		alert('<spring:message code="fap.comp.pw_length_mis_matched_alert" />');
		selectAndFocus(input_pw);
		return false;
	}
	
	if (input_pw_val == '') {
		//비밀번호를 입력해 주시기 바랍니다.
		alert('<spring:message code="fap.comp.pw_input_alert" />');
		selectAndFocus(input_pw);
		return false;
	}
	
	if (input_pw_check_val == '') {
		//비밀번호 확인란에 입력해 주시기 바랍니다.
		alert('<spring:message code="fap.comp.pw_confirm_input_alert" />');
		selectAndFocus(input_pw_check);
		return false;
	}
	
	if (pw_regex.test(input_pw_val) == false) {
		//비밀번호의 형식이 잘못 되었습니다.
		alert('<spring:message code="fap.comp.pw_mis_format_alert" />');
		selectAndFocus(input_pw);
		return false;
	}
	
	if (input_pw_val != input_pw_check_val) {
		//비밀번호가 일치하지 않습니다.
		alert('<spring:message code="fap.comp.pw_mis_matchted_alert" />');
		selectAndFocus(input_pw);
		return false;
	}
	
	return true;
}


/**
 * 엘리먼트를 선택한다
 */
function selectAndFocus(element) {
	element.select();
	element.focus();
}


/**
 * angular.js
 */
var myApp = angular.module('myapp', []);
myApp.directive('code', ['$http', function($http){
	return {
		restrict: "E",
		replace: true,
		scope : {
			value : '@'
		},
		controller: function ($scope, $element, $attrs) {
			$http({
				method: 'POST',
				url: '/codeconverter',
		  		responseType: 'text',
				params : {
					code : $attrs.value
				}
			}).then(function successCallback(response) {
	    		$scope.filterParams = response.data;
			}, function errorCallback(response) {
				//console.log(response);
			});
		}
		,template: "<span>{{filterParams}}</span>"
	}
}]);

</script>
</head>
<body>
<%@include file="user_menu.jsp"%><%@include file="user_quick_menu.jsp"%>
<div class="join-wrap">
	<div id="subcontents">
		<div id="idpwBox">
			<div id="innerBox" style="padding-left: 33%;">
				<form action="<c:url value='/fap/user/user_forgot_password_change' />" method="POST" id="user_forgot_password_change">
					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
					<div class="logintxt1"><spring:message code="fap.comp.pw_change" /></div>
					<div class="logintxt2"><img src="/resources/segroup/society/fap/images/login_bar.gif" /></div>
					
					<div class="logintxt3"><input type="password" id="user_pw" name="user_pw" placeholder="<spring:message code="fap.comp.pw_number_count" />" maxlength="12" style="width:52%;"/></div>
					<div class="logintxt3"><input type="password" id="user_pw_check" name="user_pw_check" placeholder="<spring:message code="fap.comp.pw_number_count" />" maxlength="12" style="width:52%;"/></div>
					<br>
					<div class="logintxt5" style="text-align: left;">
						<button class="btn17 btn-primary submitBtn" style="width:55%; border-color:#005A8C; background:#007ec4; border:1px solid #bbb; font-size:16px; color:#fff;" onclick="checkOnSubmit();">
							<spring:message code="fap.comp.pw_change" />
						</button>
					</div>
				
				</form>
			
			</div>
		</div>
	</div>
</div>
<%@include file="../common_footer_fap.jsp"%>
</body>
</html>
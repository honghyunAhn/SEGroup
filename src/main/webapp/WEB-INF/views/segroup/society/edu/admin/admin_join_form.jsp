<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, target-densitydpi=medium-dpi" />
<meta name="format-detection" content="telephone=no">
<title>글로벌 엔지니어 양성</title>
<script src="<c:url value="/resources/segroup/js/jquery-3.1.1.js" />"></script>
<script src="<c:url value="/resources/segroup/society/edu/js/admin_menu.js" />"></script>
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/segroup/society/edu/css/admin_menu.css" />">
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/segroup/society/edu/css/common.css" />">
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/segroup/society/edu/css/sub.css" />">
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/segroup/society/edu/css/main.css" />">
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/segroup/society/edu/css/join.css" />">
<script src="<c:url value="/resources/segroup/js/angular.min.js" />"></script>
<script src="<c:url value="/resources/segroup/society/edu/js/slidebanner.js" />"></script>
<script type="text/javascript">
// 정규표현식
var phone_regex = /^\d{3}\d{3,4}\d{4}$/;
var pw_regex = new RegExp("[0-9a-zA-Z!@#$%^&*]+");	// 수정 필요
var nm_regex = /^[가-힣]{2,4}$/;
var birth_regex = new RegExp("[0-9]{8}");
var email_regex = new RegExp("([0-9a-zA-Z]+)(\@{1})([0-9a-zA-Z]+)([\.]{1})([0-9a-zA-Z]+)");
var id_regex = /^[a-zA-Z]+[a-zA-Z0-9]{5,19}$/g;


// 상수
const USER_INFO_USABLE = '사용 가능합니다. 사용하시겠습니까?'; 
const USER_INFO_NOT_USABLE = '중복입니다. 다시 시도해 주시기 바랍니다.';
const ID_MIN_LENGTH = 6;
const ID_MAX_LENGTH = 20;
const PW_MIN_LENGTH = 8;
const PW_MAX_LENGTH = 12;

/**
 * 서브밋하기 전에 데이터를 체크한다
 */
function checkOnSubmit() {
	if (isIdCorrect() == false) { return false; }
	if (isPasswordCorrect() == false) { return false; }
	if (isNameCorrect() == false) { return false; }
	if (isPhoneNumCorrect() == false) { return false; }
	if (isEmailCorrect() == false) { return false; }
	if (isBirthCorrect() == false) { return false; }
	if (isSexSelected() == false) { return false; }
	return true;
}

/**
 * 아이디 중복 검사를 진행한다
 */
function checkIdIsDuplicated() {
	var input_user_id = $('#user_id');
	
	console.log(input_user_id.val());
	
	if (input_user_id.val() == '') {
		alert('아이디를 입력해 주시기 바랍니다');
		selectAndFocus(input_user_id);
		return false;
	}
	
	
	if(!input_user_id.val().match(id_regex)){
        alert("아이디는 영문자로 시작하는 6~20자 영문자 또는 숫자이어야 합니다.");
		selectAndFocus(input_user_id);
		return false;
    }
	
	
	var data = {
		user_id: input_user_id.val()
	};
	
	checkDuplicated(data, input_user_id);
}

/**
 * 이메일 중복 검사를 진행한다
 */
function checkEmailIsDuplicated() {
	var input_user_email = $('#user_email');
	if (input_user_email.val() == '') {
		alert('이메일을 입력해 주시기 바랍니다');
		selectAndFocus(input_user_id);
		return false;
	}
	
	if (email_regex.test(input_user_email.val()) == false) {
		alert('이메일이 형식에 맞지 않습니다');
		return false;
	}
	
	var data = {
		user_email: input_user_email.val()
	};
	
	checkDuplicated(data, input_user_email);
}

/**
 * 데이터가 중복되는지 검사한다
 */
function checkDuplicated(data, element) {
	
	$.ajax({
		url: '<c:url value="/edu/user/user_duplicated" />'
		, dataType: 'json'
		, data: data
		, success: function (isDuplicated) {
			if (isDuplicated) {
				alert(USER_INFO_NOT_USABLE);
				element.removeAttr('checked');
			} else {
				var duplCheck = confirm(USER_INFO_USABLE);
				if(duplCheck){
					element.attr('checked', '');
					element.attr('readonly','readonly');
				}else{
					element.removeAttr('readonly');
					element.removeAttr('checked');
				}
			}
		}
		, error: function() {
			alert('중복 확인 과정 중 에러 발생');
		}
	});
}

/**
 * 아이디 검사를 진행한다
 */
function isIdCorrect() {
	var input_user_id = $('#user_id');
	if (input_user_id.val() == '') {
		alert('아이디를 입력해 주시기 바랍니다');
		selectAndFocus(input_user_id);
		return false;
	}
	if (!input_user_id.attr('checked')) {
		alert('아이디를 중복 체크를 진행해 주시기 바랍니다');
		selectAndFocus(input_user_id);
		return false;
	}
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
 * 이름 검사를 진행한다
 */
function isNameCorrect() {
	var input_nm = $('#user_nm');
	if (input_nm.val() == '') {
		alert('이름을 입력해 주시기 바랍니다');
		selectAndFocus(input_nm);
		return false;
	}
	if (nm_regex.test(input_nm.val()) == false) {
		alert('이름은 한국어로 작성해 주시기 바랍니다');
		selectAndFocus(input_nm);
		return false;
	}
	return true;
}

/**
 * 전화번호 검사를 진행한다
 * return: 제대로 되었으면 true, 다르면 false
 */
function isPhoneNumCorrect() {
	// 전화번호가 올바르면 데이터를 넣는다
	var phoneNum = $('#user_phone').val();
	
	if (phoneNum == '') {
		alert('휴대폰 번호를 입력해 주시기 바랍니다');
		return false;
	}
	if(phone_regex.test(phoneNum) == false){
        alert("휴대폰 번호를 양식에 맞게 입력해 주세요.");
        return false;
	}
	
	$("#user_phone").val(phoneNum);
	return true;
}

/**
 * 생년월일이 맞는가
 */
function isBirthCorrect() {
	var year = $('#birth_year').val();
	if (year == '') {
		alert('생년을 올바르게 작성해 주기시 바랍니다');
		return false;
	}

    var today = new Date();
    var yyyy = today.getFullYear();
    
	if (year < 1900 || (yyyy - 1) < year) {
		alert('생년을 올바르게 작성해 주기시 바랍니다');
		return false;
	}
    
	var month = $('#birth_month').val();
	if (month.length < 2) {
		alert('생월을 올바르게 작성해 주시기 바랍니다');
		return false;
	}
	if (month <= 0 || 12 < month) {
		alert('생월을 올바르게 작성해 주시기 바랍니다');
		return false;
	}
	
	var date = $('#birth_date').val();
	if (date.length < 2) {
		alert('생일을 올바르게 작성해 주시기 바랍니다');
		return false;
	}
    if (date < 1 || 31 < date) {
        alert('생일을 올바르게 작성해 주시기 바랍니다');
        return false;
    }
    if (month == 2 && (date < 1 || 29 < date)) {
        alert('생일을 올바르게 작성해 주시기 바랍니다');
        return false;
    }
	
	var birth = year + month + date;
	if (birth_regex.test(birth) == false) {
		alert('생년월일이 형식에 맞지 않습니다');
		return false;
	}
	
	$('#user_birth').val(birth);
	return true;
}

/**
 * 이메일을 적었는지
 */
function isEmailCorrect() {
	var input_email = $('#user_email');
	if (email_regex.test(input_email.val()) == false) {
		alert('이메일이 형식에 맞지 않습니다');
		return false;
	}
	if (!input_email.attr('checked')) {
		alert('이메일 중복 체크를 진행해 주시기 바랍니다');
		selectAndFocus(input_email);
		return false;
	}
	return true;
}

/**
 * 성별을 선택했는지
 */
function isSexSelected() {
	if (!$('#user_sex').val()) {
		alert('성별을 선택해 주시기 바랍니다');
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
 * 유저 성별 선택 이벤트
 */
function radioOnChange(evt) {
	$.each($('div.line > a.btn'), function (index, button) {
		var obj_button = $(button);
		var input_user_sex = $('#user_sex');
		if(evt.currentTarget == button) {
			obj_button.addClass('btn_b');
			obj_button.removeClass('btn_gray btn_fore_black');
			input_user_sex.val(obj_button.attr('value'));
		} else {
			obj_button.addClass('btn_gray btn_fore_black');
			obj_button.removeClass('btn_b');
		}
	});
}

/**
 * 페이지가 로딩되면 실행
 */
$(function() {
	$.each($('div.line > a.radio'), function (index, button) {
		$(button).on('click', radioOnChange);
	});
});

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

myApp.directive('selectcode', [ '$http', function($http) {
	return {
		restrict : "A",
		replace : true,
		scope : {
			value : '@'
		},
		controller : function($scope, $element, $attrs) {
			$http({
				method : 'POST',
				url : '/codeconverter',
				responseType : 'text',
				params : {
					code : $attrs.value
				}
			}).then(function successCallback(response) {
				$scope.filterParams = response.data;
			}, function errorCallback(response) {
				console.log(response);
			});
		},
		template : "<option>{{filterParams}}</option>"
	}
} ]);



</script>
</head>
<body ng-app="myapp">
	<%@include file="admin_menu.jsp"%>
	
	<!-- section -->
	<section class="join_section">
		<article>
			<h3>관리자 가입하기</h3>
			<br>
			<form action="<c:url value='/edu/admin/admin_join' />" method="POST" onsubmit="return checkOnSubmit();">			
				<div class="form_box">
				      
					<div class="line">
						<input class="ip_1" type="text" id="user_id" name="user_id" maxlength="20" placeholder="아이디(6~20자리)"/>
						<button class="join_btn" type="button" onclick="checkIdIsDuplicated();">중복체크</button>
					</div>
					
					<div class="line line_s">
						<input class="ip_2" type="password" id="user_pw" name="user_pw" maxlength="12" placeholder="비밀번호(8~12자리)"/>
					</div>
					
					<div class="line">
						<input class="ip_2" type="password" id="user_pw_check" maxlength="12" placeholder="비밀번호 확인(8~12자리)" />
					</div>
					
					<div class="line">
						<input class="ip_2" type="text" id="user_nm" name="user_nm" maxlength="4" placeholder="이름" />
					</div>
					
					<div class="line">
						<input class="ip_2" type="tel" id="user_phone" name="user_phone" maxlength="14"  placeholder="휴대폰번호( - 제외 )" />
					</div>
					
					<div class="line">
						<input class="ip_1" type="email" id="user_email" name="user_email" placeholder="이메일" />
						<button class="join_btn" type="button" onclick="checkEmailIsDuplicated();">중복체크</button>
					</div>
					
					<div class="line">
						<input class="ip_3" type="text" id="birth_year" name="birth_year" maxlength="4" placeholder="생년(YYYY)">
						<input class="ip_3" type="text" id="birth_month" name="birth_month" maxlength="2" placeholder="월(MM)">	
						<input class="ip_3" type="text" id="birth_date" name="birth_date" maxlength="2" placeholder="일(DD)">
						<input type="hidden" id="user_birth" name="user_birth" maxlength="8">
					</div>
					
					<div class="line line_align_center">
						<a class="btn btn_fifty_width btn_gray btn_fore_black radio" id="user_sex_m" value="A0000"><code value="A0000"></code></a>
						<a class="btn btn_fifty_width btn_gray btn_fore_black radio" id="user_sex_f" value="A0001"><code value="A0001"></code></a>
						<input type="hidden" id="user_sex" name="user_sex">
					</div>
					
					<div class="line">
						<select class="ip_5 select_project" name="admin_project">
							<option selectcode value="A0700" selected></option>
							<option selectcode value="A0701"></option>
							<option selectcode value="A0702"></option>
							<option selectcode value="A0703"></option>
						</select>
					</div>
					
					<div class="line"></div>
					
					<div class="line line_align_center">
						<input class="join_btn ip_4" type="submit" value="가입하기">
					</div>
				</div>  <!-- form_box -->
			</form>
		</article>
	</section>  <!--  join_section -->
</body>
</html>
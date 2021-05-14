<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html" charset="UTF-8">
	<title>Bridge Job Fair</title>
	<script src="<c:url value="/resources/segroup/js/jquery-3.1.1.js" />"></script>
	<script src="<c:url value="/resources/segroup/js/angular.min.js" />"></script>
	<link rel="stylesheet" type="text/css" href="<c:url value="/resources/segroup/society/edu/css/bootstrap.min.css" />">
	<style>
		form{display:inline;}
		div.custom_div{text-align:center;margin-left:330px;margin-right:330px;}
		tbody.custom_tbody{text-align:left}
		td{height:40px;}
		input[type="text"]{border:1px solid #ccc;width:95%;vertical-align:middle;}
		input[type="password"]{border:1px solid #ccc;width:95%;vertical-align:middle;height:30px;margin-bottom:0;}
		input[type="radio"]{margin-top:0;}
		input[type="email"]{width:80% !important;height:30px !important;}
		button.join_btn{background-color:#3af;color:white;border:none;border-radius:4px;width:14.5%;height:40px;font-weight:bold;}
		.crc_submit{background-color:#3af;color:white;border:none;border-radius:4px;font-weight:bold;font-size:120%;width:180px;height:50px;margin-top:15px;margin-bottom:30px;padding:5px;}
		#tolist{background-color:#333;color:white;}
		#delete_button{background-color:#999;color:white;}
	</style>
</head>
<script src="/resources/segroup/js/jquery-ui.js"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
<script type="text/javascript">
	//정규표현식
	var phone_regex = /^\d{3}\d{3,4}\d{4}$/;
	var pw_regex = new RegExp("[0-9a-zA-Z!@#$%^&*]+");
	var nm_regex = /^[가-힣]{2,4}$/;
	var birth_regex = new RegExp("[0-9]{8}");
	var email_regex = new RegExp("([0-9a-zA-Z]+)(\@{1})([0-9a-zA-Z]+)([\.]{1})([0-9a-zA-Z]+)");
	
	// 상수
	const PW_MIN_LENGTH = 8;
	const PW_MAX_LENGTH = 12;
	
	var first_email = "";

	$(function() {
		cleanDatepicker();
		
		$("#fap_comp_log_file").change(function() {
			var val = $(this).val();

			if (val == "") {
				$(this).val('');
				$("#imgDiv").empty();
				return;
			} else if (fileImageCheck(val)) {
				photoAjax();
			} else {
				$(this).val('');
				$("#imgDiv").empty();
				alert("이미지 파일이 아닙니다. gif, jpg, png 형식만 가능 합니다.");
				return;
			}
		});
		
		// 라디오버튼 초기값 설정
		// 성별
		$("input:radio[value='${company_user.user_sex}']").prop("checked", true);
		
		$('#user_birth').datepicker({
			dateFormat : 'yy/mm/dd'
			, changeMonth: true
			, changeYear: true
			, yearRange: "1900:"
		});
		
		$('#fap_comp_est_dt').datepicker({
			dateFormat : 'yy/mm/dd'
			, changeMonth: true
			, changeYear: true
			, yearRange: "1900:"
		});
		
		first_email = $('#user_email').val();
		
		$("#tolist").click(function(){
			location.href="/fap/admin/user_management?curPage=${curPage}&pageCount=${pageCount}&orderValue=${orderValue}&orderType=${orderType}&searchName=${searchName}&searchId=${searchId}";
		})
	});
	
	function cleanDatepicker() {

		var original_gotoToday = $.datepicker._gotoToday;

		$.datepicker._gotoToday = function(id) {
			var target = $(id), inst = this._getInst(target[0]);

			original_gotoToday.call(this, id);
			this._selectDate(id, this._formatDate(inst, inst.selectedDay, inst.drawMonth, inst.drawYear));
			target.blur();
		}

		var old_fn = $.datepicker._updateDatepicker;

		$.datepicker._updateDatepicker = function(inst) {
			old_fn.call(this, inst);

			var buttonPane = $(this).datepicker("widget").find(".ui-datepicker-buttonpane");

			$("<button type='button' class='ui-datepicker-clean ui-state-default ui-priority-primary ui-corner-all'>clear</button>").appendTo(buttonPane).click(function(ev) {
				$.datepicker._clearDate(inst.input);
			});
		}
	}
	
	/**
	 * 이메일 중복 검사를 진행한다
	 */
	function checkEmailIsDuplicated() {
		var input_email = $('#user_email').val();
		// 이메일을 변경 하지 않고 누를 경우
		if(first_email == input_email){
			return true;
		}
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
	
	function checkDuplicated(data, element) {
		console.log("data : "+JSON.stringify(data));
		console.log("element : "+JSON.stringify(element));
		
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
	
	function checkOnSubmit() {
		var user_pw = $('#user_pw').val();
		// 비밀번호를 변경 하지 않을 경우도 있기 때문에
		if(user_pw != ''){
			if (isPasswordCorrect() == false) { return false; }
		}
		if (isNameCorrect() == false) { return false; }
		if (isBirthCorrect() == false) { return false; }
		if (isPhoneNumCorrect() == false) { return false; }
		if (isEmailCorrect() == false) { return false; }
		
		return true;
	}
	
	function selectAndFocus(checkdata){
		checkdata.focus();
		checkdata.select();
	}
	/**
	 * 패스워드 검사를 진행한다
	 * return: 같으면 true, 다르면 false
	 */
	function isPasswordCorrect() {
		var input_pw = $('#user_pw');
		var input_pw_check = $('#user_pw_ck');
		
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
		return true;
	}
	
	/**
	 * 생년월일이 맞는가
	 */
	function isBirthCorrect() {
		var birth_year = $('#birth_year').val().toString();
		var birth_month = $('#birth_month').val().toString();
		var birth_date = $('#birth_date').val().toString();
		if (birth_year.length < 4 || birth_month.length < 2 || birth_date.length < 2) {
			alert("생년월일을 확인해주세요.")
			return false;
		}
		var birth = birth_year + birth_month + birth_date;
		$('#user_birth').val(birth);
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
	        alert('휴대폰 번호를 숫자로만 적어주세요');
	        return false;
		}
		
		$("#user_phone").val(phoneNum);
		return true;
	}
	
	/**
	 * 이메일을 적었는지
	 */
	function isEmailCorrect() {
		var input_email = $('#user_email');
		
		// 이메일이 변경 되지 않았을 경우에는 그냥 리턴
		if(first_email == input_email.val()){
			return true;
		}
		
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
	
	function company_user_delete() {
		return confirm("정말 회원 탈퇴를 하시겠습니까?");
	}

</script>
<body>
	<%@include file="admin_menu.jsp"%>
	<div class="page_title">
		<h2>JobFair 회원 관리</h2>
		<h5><a href="user_management">회원 관리 페이지</a>&nbsp;&nbsp;&gt;&nbsp;&nbsp;회원 정보 수정</h5>
	</div>
	<div class="custom_div" style="margin-top:20px;">
		<form action="/fap/admin/company_user_update" method="post" onsubmit="return checkOnSubmit();" enctype="multipart/form-data">
			<table class="gisu_crc_table">
				<colgroup>
					<col width="20%"/>
					<col width="80%"/>
				</colgroup>
				<thead>
					<tr>
						<th scope="col" class="name">회원정보</th>
						<th scope="col" style="text-align:center;">내 용</th>
					</tr>
				</thead>
				<tbody class="custom_tbody">
					<tr>
						<td class="name first">아이디</td>
						<td class="first"><input type="text" id="user_id" name="user_id" value="${company_user.user_id}" readonly="readonly"></td>
					</tr>
					<tr>
						<td class="name">비밀번호</td>
						<td><input type="password" id="user_pw" name="user_pw"></td>
					</tr>
					<tr>
						<td class="name">비밀번호 확인</td>
						<td><input type="password" id="user_pw_ck"></td>
					</tr>
					<tr>
						<td class="name">이름</td>
						<td><input type="text" id="user_nm" name="user_nm" value="${company_user.user_nm}"></td>
					</tr>
					<tr>
						<td class="name">생년월일</td>
						<td>
							<c:set var="birth" value="${company_user.user_birth}"/>
							<input class="ip_3" type="text" id="birth_year" name="birth_year" value="${fn:substring(birth,0,4) }" maxlength="4" placeholder="YYYY" style="width:10%;">년&nbsp;&nbsp;
							<input class="ip_3" type="text" id="birth_month" name="birth_month" value="${fn:substring(birth,5,7) }" maxlength="2" placeholder="MM" style="width:10%;">월&nbsp;&nbsp;
							<input class="ip_3" type="text" id="birth_date" name="birth_date" value="${fn:substring(birth,8,10) }" maxlength="2" placeholder="DD" style="width:10%;">일
							<input type="hidden" id="user_birth" name="user_birth" maxlength="8">
						</td>
					</tr>
					<tr>
						<td class="name">성별</td>
						<td>
							<input type="radio" name="user_sex" id="user_sex_m" value="A0000">남자&nbsp;&nbsp;
							<input type="radio" name="user_sex" id="user_sex_f" value="A0001">여자
						</td>
					</tr>
					<tr>
						<td class="name">전화번호</td>
						<td><input type="text" id="user_phone" name="user_phone" value="${company_user.user_phone}"></td>
					</tr>
					<tr>
						<td class="name">이메일</td>
						<td>
							<input type="email" id="user_email" name="user_email" placeholder="이메일" value="${company_user.user_email}">
							<button class="join_btn" type="button" onclick="checkEmailIsDuplicated();">중복체크</button>
						</td>
					</tr>
				</tbody>
			</table>
			<input class="crc_submit" type="submit" value="수정하기">
			<input id="tolist" class="crc_submit" type="button" value="목록보기">
			<input type="hidden" name="user_flag" value="A0103">
			<input type="hidden" name="user_state" value="A0200">
			<input type="hidden" name="curPage" value="${curPage}">
			<input type="hidden" name="pageCount" value="${pageCount}">
			<input type="hidden" name="orderValue" value="${orderValue}">
			<input type="hidden" name="orderType" value="${orderType}">
			<input type="hidden" name="searchName" value="${searchName}">
			<input type="hidden" name="searchId" value="${searchId}">
		</form>
		<form action="/fap/admin/user_info_delete" method="post" onsubmit="return company_user_delete();">
			<input type="hidden" name="user_id" value="${company_user.user_id}">
			<input class="crc_submit" id="delete_button" type="submit" value="회원 탈퇴">
		</form>
	</div>
</body>
</html>
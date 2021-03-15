<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Bridge Job Fair</title>
</head>
<script src="<c:url value="/resources/segroup/js/jquery-3.1.1.js" />"></script>
<script src="<c:url value="/resources/segroup/js/angular.min.js" />"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
<script src="<c:url value="/resources/segroup/js/jquery-ui.js" />"></script>

<link type="text/css" rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto:400,500">
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/segroup/society/fap/css/default.css" />" />
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/segroup/society/fap/css/popModal.css" />" />
<script type="text/javascript">
//정규표현식
var pw_regex = new RegExp("[0-9a-zA-Z!@#$%^&*]+");
var email_regex = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
var id_regex = /^[a-zA-Z]+[a-zA-Z0-9]{5,19}$/g;
var blank_regex = /\s/g;

// 상수
const ID_MIN_LENGTH = 6;
const ID_MAX_LENGTH = 20;
const PW_MIN_LENGTH = 8;
const PW_MAX_LENGTH = 40;


	$(function() {
		
		var message = $('#message').val();
		if(message != "" || message.length != 0){
			//alert(message);
		}
		
		//모든 input text 글자수 제한
		$("input[type='text']").keyup(function(){
		        if ($(this).val().length > $(this).attr('maxlength')) {
		            alert('<spring:message code="fap.err.characters_over" javaScriptEscape="true" />');
		            $(this).val($(this).val().substr(0, $(this).attr('maxlength')));
		        }
		});
		$("input[type='number']").keyup(function(){
	        if ($(this).val().length > $(this).attr('maxlength')) {
	            alert('<spring:message code="fap.err.over_maxlength" javaScriptEscape="true" />');
	            $(this).val($(this).val().substr(0, $(this).attr('maxlength')));
	        }
	    });
		$(".policy-agree").on("click",function(e){
			$(this).toggleClass("check");	
			if($(this).hasClass("check")){
				$("input:checkbox[id='user_terms_ck']").prop("checked", true);
			}else {
				$("input:checkbox[id='user_terms_ck']").prop("checked", false);
			}
				return false;
		});
		$("input[type='text']").off('keyup').keyup( function(){
			//모든 input 태그 제한
			var disallow_char = /(<([^>]+)>)/ig;
			var tempValue = $(this).val();
		    if (disallow_char.test(tempValue)) {
		        alert('<spring:message code="fap.err.tag_insert" javaScriptEscape="true" />');
		        $(this).val(tempValue.replace(disallow_char,""));
		    }
		});
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
				alert('<spring:message code="fap.err.image_type" javaScriptEscape="true" />');
				return;
			}
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
			}
			, controller: function ($scope, $element, $attrs) {
				$http({
					method: 'POST',
					url: '/codeconverter',
			  		responseType: 'text',
					params : {
						code : $attrs.value
					}
				}).then(function successCallback(response) {
		    		$scope.filterParams = response.data;
				} , function errorCallback(response) {
					console.log(response);
				});
			}
			, template: "<span>{{filterParams}}</span>"
		}
	}]);
	//blurCurrency
	myApp.directive('blurCurrency',['$filter',  function($filter) {
		return {
			require : 'ngModel',
			scope: true,
			link : function($scope, $el, $attr, $ngModelCtrl){
			 function formatter(value){
					value = value ? parseFloat(value.toString().replace(/[^0-9._-]/g, '')) || 0 : 0;
					var formattedValue = $filter('currency')(value,"",0);
					
					$ngModelCtrl.$setViewValue(value);
					$ngModelCtrl.$render();
					
					$el.val(formattedValue);
					
					return formattedValue;
				}
				
				$ngModelCtrl.$formatters.push(formatter);
				
				$el.bind('focus', function(){
					//$el.val('');
				});
				
				$el.bind('blur', function(){
					formatter($el.val());
				});
			}
		}
	}])
	//trim 함수
	function trim(stringToTrim) {
	    return stringToTrim.replace(/^\s+|\s+$/g,"");
	};
	/**
	 * 아이디 검사를 진행한다
	 */
	function isIdCorrect() {
		var input_user_id = $('#user_id');
		if (input_user_id.val() == '') {
			alert('<spring:message code="fap.err.id_input" javaScriptEscape="true" />');
			selectAndFocus(input_user_id);
			return false;
		}
		if (!input_user_id.attr('checked')) {
			alert('<spring:message code="fap.err.id_duplicate_check" javaScriptEscape="true" />');
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
	        alert('<spring:message code="fap.err.pw_length" javaScriptEscape="true" />');
			selectAndFocus(input_pw);
			return false;
		}
		//비밀번호 공백문자 여부 확인
		if(input_pw_val.match(blank_regex)){
			alert('<spring:message code="fap.err.space_character" javaScriptEscape="true" />');//메시지 추가
			return false;
		}
		
		if (input_pw_val == '') {
			alert('<spring:message code="fap.err.pw_check" javaScriptEscape="true" />');
			selectAndFocus(input_pw);
			return false;
		}
		
		if (input_pw_check_val == '') {
			alert('<spring:message code="fap.err.pw_check_input" javaScriptEscape="true" />');
			selectAndFocus(input_pw_check);
			return false;
		}
		
		if (pw_regex.test(input_pw_val) == false) {
			alert('<spring:message code="fap.err.pw_type_mismatched" javaScriptEscape="true" />');
			selectAndFocus(input_pw);
			return false;
		}
		
		if (input_pw_val != input_pw_check_val) {
			alert('<spring:message code="fap.err.pw_mismatched" javaScriptEscape="true" />');
			selectAndFocus(input_pw);
			return false;
		}
		
		return true;
	}

	/**
	 * 이름 검사를 진행한다
	 */
	function isNameCorrect() {
		var user_nm = $('#user_nm');
		if(user_nm.val() == ''){
			alert('<spring:message code="fap.err.name_input" javaScriptEscape="true" />');
			$('#user_nm').focus();
			return false;
		}
		user_nm.val(trim(user_nm.val()));
		return true;
	}

	/**
	 * 이메일을 적었는지
	 */
	 function isEmailCorrect() {
		var input_email = $('#user_email');
		if (email_regex.test(input_email.val()) == false) {
			alert('<spring:message code="fap.err.email_mismatched" javaScriptEscape="true" />');
			return false;
		}
		if (!input_email.attr('checked')) {
			alert('<spring:message code="fap.err.email_duplicate_check" javaScriptEscape="true" />');
			selectAndFocus(input_email);
			return false;
		}
		return true;
	}
	
	function form_check() {
		//blurCurrency
		$.each($(".currency"),function(index,item){
			var commaValue = angular.element(item).val();
			
			angular.element(item).val(commaValue.replace(/,/g, ''));
		});
		
		if (isIdCorrect() == false) { return false; }
		if (isPasswordCorrect() == false) { return false; }
		if (isNameCorrect() == false) { return false; }
		if (isEmailCorrect() == false) { return false; }
		
		var fap_comp_ja_nm = $('#fap_comp_ja_nm');
		var fap_comp_en_nm = $('#fap_comp_en_nm');
		var fap_comp_business_num = $('#fap_comp_business_num');
		var fap_comp_rep = $('#fap_comp_rep');
		var fap_comp_major_bussiness = $('#fap_comp_major_bussiness');
		var fap_comp_homepage = $('#fap_comp_homepage');
		var fap_comp_postcode = $('#fap_comp_postcode');
		var fap_comp_address = $('#fap_comp_address');
		var fap_comp_address_detail =$('#fap_comp_address_detail');
		var fap_comp_est_dt = $('#fap_comp_est_dt');
		var fap_comp_stock =$('#fap_comp_stock');
		var fap_comp_3years_avg_sales =$('#fap_comp_3years_avg_sales');
		var fap_comp_employee_num = $('#fap_comp_employee_num');
		//사진유무체크
		var photoSize = $("#fap_comp_log_file")[0].files;
	
		fap_comp_ja_nm.val(trim(fap_comp_ja_nm.val()));
		if(fap_comp_ja_nm.val() == ''){
			alert('<spring:message code="fap.err.comp_ja_name_input" javaScriptEscape="true" />');
			$('#fap_comp_ja_nm').focus();
			return false;
		}
		fap_comp_en_nm.val(trim(fap_comp_en_nm.val()));
		if(fap_comp_en_nm.val() == ''){
			alert('<spring:message code="fap.err.comp_en_name_input" javaScriptEscape="true" />');
			$('#fap_comp_en_nm').focus();
			return false;
		}
		fap_comp_business_num.val(trim(fap_comp_business_num.val()));
	
		fap_comp_rep.val(trim(fap_comp_rep.val()));
		if(fap_comp_rep.val() == ''){
			alert('<spring:message code="fap.err.represent_name_input" javaScriptEscape="true" />');
			$('#fap_comp_rep').focus();
			return false;
		}
		fap_comp_major_bussiness.val(trim(fap_comp_major_bussiness.val()));
		if(fap_comp_major_bussiness.val() == ''){
			alert('<spring:message code="fap.err.major_bussiness_input" javaScriptEscape="true" />');
			$('#fap_comp_major_bussiness').focus();
			return false;
		}
		
		fap_comp_homepage.val(trim(fap_comp_homepage.val()));
		
		fap_comp_postcode.val(trim(fap_comp_postcode.val()));
		if(fap_comp_postcode.val() == ''){
			alert('<spring:message code="fap.err.postcode_input" javaScriptEscape="true" />');
			$('#fap_comp_postcode').focus();
			return false;
		}
		fap_comp_address.val(trim(fap_comp_address.val()));
		if(fap_comp_address.val() == ''){
			alert('<spring:message code="fap.err.addr_input" javaScriptEscape="true" />');
			$('#fap_comp_address').focus();
			return false;
		}
		fap_comp_address_detail.val(trim(fap_comp_address_detail.val()));
		
		fap_comp_est_dt.val(trim(fap_comp_est_dt.val()));
		if(fap_comp_est_dt.val() == ''){
			alert('<spring:message code="fap.err.comp_est_dt_input" javaScriptEscape="true" />');
			$('#fap_comp_est_dt').focus();
			return false;
		}
		//자본금
		if(fap_comp_stock.val() == 0){
			alert('<spring:message code="fap.err.comp_stock" javaScriptEscape="true" />');
			$('#fap_comp_stock').focus();
			return false;
		}
		//최근 3년 매출
		if(fap_comp_3years_avg_sales.val() == 0){
			alert('<spring:message code="fap.err.comp_est_dt_input" javaScriptEscape="true" />');
			$('#fap_comp_3years_avg_sales').focus();
			return false;
		}
		
		fap_comp_employee_num.val(trim(fap_comp_employee_num.val()));
		if(fap_comp_employee_num.val() == 0){
			alert('<spring:message code="fap.err.emp_num_input" javaScriptEscape="true" />');
			$('#fap_comp_employee_num').focus();
			return false;
		}
	
		//기업 로고 사진
		if(photoSize.length == 0) {
			alert('<spring:message code="fap.err.photo_input" javaScriptEscape="true" />');
			$("#fap_comp_log_file").focus();
			return false;
		}
		
		if($("input:checkbox[id='user_terms_ck']").is(":checked") == false){
			alert('<spring:message code="fap.err.comp_user_terms_check" javaScriptEscape="true" />');
			return false;
		}
		
		$("input[type='number']").each(function(index, item){
			var value = $(item).val();
			if(value == null || value == ""){
				
				$(item).val("0");
			}
			
		 })
	
		$('#agency_company_insert').submit();
	}

	// 사진 AJAX
	function photoAjax() {
		var size = $("#fap_comp_log_file")[0].files[0].size;
		if (fileSizeCheck(size)) {
			var formData = new FormData();
			formData.append("file", $("#fap_comp_log_file")[0].files[0]);

			$.ajax({
				type : "POST",
				url : "/temporarily_upload",
				data : formData,
				processData : false,
				contentType : false,
				dataType : "json",
				success : function(data) {
					$("#imgDiv").empty();
					$("#imgDiv").html('<img alt="" style="width:30%; height:30%;" src="/edu/temporarilyPath/'+data.savedfile+'">');
				},
				error : function(e) {
					console.log(e);
				}
			});
		} else {
			$("#fap_comp_log_file").val('');
			$("#imgDiv").empty();
			alert('<spring:message code="fap.err.file_size" javaScriptEscape="true" />');
		}
	}
	
	function fileSizeCheck(size) {
		//5MB
		var maxSize = 5242880;
		var fileSize = Math.round(size);
		if (fileSize > maxSize) {
			return false;
		}
		return true;
	}
	
	function fileImageCheck(name) {
		switch (name.substring(name.lastIndexOf('.') + 1).toLowerCase()) {
		case 'gif':
		case 'jpg':
		case 'png':
			return true;
		default:
			return false;
		}
	}
	
	/**
	 * 아이디 중복 검사를 진행한다
	 */
	function checkIdIsDuplicated() {
		var input_user_id = $('#user_id');		
		
		if (input_user_id.val() == '') {
			alert('<spring:message code="fap.err.id_input_err" javaScriptEscape="true" />');
			selectAndFocus(input_user_id);
			return false;
		}
		
		
		if(!input_user_id.val().match(id_regex)){
	        alert('<spring:message code="fap.err.characters_mismatch" javaScriptEscape="true" />');
			selectAndFocus(input_user_id);
			return false;
	    }
		
		var data = {
			user_id: input_user_id.val()
		};
		
		checkDuplicated(data, input_user_id);
	}
	
	function checkDuplicated(data, element) {
		
		//console.log("data : "+data);
		//console.log("element : "+element);
		
		$.ajax({
			 beforeSend: function(xhr) {
			     xhr.setRequestHeader("AJAX", true);
			  }
			, url: '/fap/agency/id_duplicated'
			, dataType: 'json'
			, data: data
			, success: function (isDuplicated) {
				if (isDuplicated) {
					alert('<spring:message code="fap.err.email_duplicated" javaScriptEscape="true" />');
					element.removeAttr('checked');
				} else {
					var duplCheck = confirm('<spring:message code="fap.err.id_usable" javaScriptEscape="true" />');
					if(duplCheck){
						element.attr('checked', '');
						element.attr('readonly','readonly');
					}else{
						element.removeAttr('readonly');
						element.removeAttr('checked');
					}
				}
			}
			, error: function(e) {
				console.log(e);
				if(e.status == 403){
					alert('<spring:message code="com.login.ajaxSesstion" javaScriptEscape="true" />');
					location.href = "/fap/agency/agency_login";
				}else{
					alert('<spring:message code="fap.err.duplicated_confirm_err" javaScriptEscape="true" />');
				}
			}
		});
	}
	
	/**
	 * 이메일 중복 검사를 진행한다
	 */
	function checkEmailIsDuplicated() {
		
		var input_user_email = $('#user_email');
		
		input_user_email.val(trim(input_user_email.val()));
		
		if (input_user_email.val() == '') {
			alert('<spring:message code="fap.err.email_input_err" javaScriptEscape="true" />');
			selectAndFocus(input_user_id);
			return false;
		}
		//공백문자 여부 확인
		if(input_user_email.val().match(blank_regex)){
			alert('<spring:message code="fap.err.space_character" javaScriptEscape="true" />');
			return false;
		}
		
		if (email_regex.test(input_user_email.val()) == false) {
			alert('<spring:message code="fap.err.email_mismatched" javaScriptEscape="true" />');
			return false;
		}
		
		var data = {
			user_email: input_user_email.val()
		};
		
		checkDuplicated(data, input_user_email);
	}
	
	/**
	 * 엘리먼트를 선택한다
	 */
	function selectAndFocus(element) {
		element.select();
		element.focus();
	}
	
</script>
<body ng-app="myapp">
<%@include file="agency_menu.jsp"%>
<div class="join-wrap">
	<div id="subcontents">
		<form action="/fap/agency/agency_company_insert" method="post" enctype="multipart/form-data" id="agency_company_insert">
			<div class="joinBox">
					<div class="jointt">
						<p class="jointxt1">
					        <spring:message code="fap.common.responsible_person_info" />
						</p>
					</div>
					<div class="join-contents">
							<!-- 라디오 박스 선택전 입력란 시작 -->
						<div class="joinBBS">
							<div class="joinBBS-row">
								<div class="joinlt"><spring:message code="fap.common.user_id" /></div>
								<div class="joinrt">
									<input type="text" id="user_id" name="user_id" maxlength="25" placeholder="<spring:message code="fap.placholder.id" />">
									<button class="join_btn" type="button" onclick="checkIdIsDuplicated();">
										<spring:message code="fap.common.duplicate_ck" />
									</button>
									<input type="hidden" id="checked_id" name="checked_id">
								</div>
							</div>
							<div class="joinBBS-row">
								<div class="joinlt"><spring:message code="fap.common.password" /></div>
								<div class="joinrt"><input type="password" id="user_pw" name="user_pw" maxlength="50" placeholder="<spring:message code="fap.placholder.pw" />"></div>
							</div>
							<div class="joinBBS-row">
								<div class="joinlt"><spring:message code="fap.common.password_ck" /></div>
								<div class="joinrt"><input type="password" id="user_pw_check" maxlength="50" placeholder="<spring:message code="fap.placholder.pw" />"></div>
							</div>
							<div class="joinBBS-row">
								<div class="joinlt"><spring:message code="fap.common.user_nm" /></div>
								<div class="joinrt"><input type="text" id="user_nm" name="user_nm" maxlength="15" placeholder="<spring:message code="fap.placholder.name" />"></div>
							</div>
							<div class="joinBBS-row">
								<div class="joinlt"><spring:message code="fap.common.email" /></div>
								<div class="joinrt">
									<input type="email" id="user_email" name="user_email" size="30" maxlength="50">
									<button class="join_btn" type="button" onclick="checkEmailIsDuplicated();">
										<spring:message code="fap.common.duplicate_ck" />
									</button>
								</div>
							</div>
							<input type="hidden" name="user_flag" value="A0103">
							<input type="hidden" name="user_state" value="A0200">
							<input type="hidden" id="user_phone" name="user_phone" maxlength="15" value="000-000-0000"><br>
					</div>
				</div>
			</div>
			
			
			<div id="company_insert">
				<div class="joinBox">
						<div class="jointt">
							<p class="jointxt1">
						        <spring:message code="fap.common.responsible_company_info" />
							</p>
						</div>
						<div class="join-contents">
							<div class="joinBBS">
									<div class="joinBBS-row">
										<!-- 기업명 일문 -->
										<div class="joinlt point"><spring:message code="fap.comp.ja_nm" /><span class="red-point"></span></div>
										<div class="joinrt"><input type="text" id="fap_comp_ja_nm" name="fap_comp_ja_nm" maxlength="50" placeholder="50<spring:message code="fap.placeholder.limit_characters" />"></div>
									</div>
									<div class="joinBBS-row">
										<!-- 기업명 영문 -->
										<div class="joinlt point"><spring:message code="fap.comp.en_nm" /><span class="red-point"></span></div>
										<div class="joinrt"><input type="text" id="fap_comp_en_nm" name="fap_comp_en_nm" maxlength="50" placeholder="50<spring:message code="fap.placeholder.limit_characters" />"></div>
									</div>
									<div class="joinBBS-row">
										<!-- 사업자 등록번호 -->
										<div class="joinlt"><spring:message code="fap.comp.business_num" /></div>
										<div class="joinrt"><input type="text" id="fap_comp_business_num" name="fap_comp_business_num" maxlength="25" placeholder="<spring:message code="fap.placeholder.business_num" />"></div>
									</div>
									<div class="joinBBS-row">
										<!-- 대표자명 -->
										<div class="joinlt point"><spring:message code="fap.comp.rep" /><span class="red-point"></span></div>
										<div class="joinrt"><input type="text" id="fap_comp_rep" name="fap_comp_rep" maxlength="15"></div>
									</div>
									<div class="joinBBS-row">
										<!-- 주요산업분야 -->
										<div class="joinlt point"><spring:message code="fap.comp.major_bussiness" /><span class="red-point"></span></div>
										<div class="joinrt"><input type="text" id="fap_comp_major_bussiness" name="fap_comp_major_bussiness" maxlength="100" placeholder="100<spring:message code="fap.placeholder.limit_characters" />"></div>
									</div>
									<div class="joinBBS-row">	
										<!-- 홈페이지 -->
										<div class="joinlt"><spring:message code="fap.comp.homepage" /></div>
										<div class="joinrt"><input type="text" id="fap_comp_homepage" name="fap_comp_homepage" maxlength="75"></div>
									</div>
									<div class="joinBBS-row">
										<!-- 우편번호 -->
										<div class="joinlt point"><spring:message code="fap.comp.postcode" /><span class="red-point"></span></div>
										<div class="joinrt"><input type="text" id="fap_comp_postcode" name="fap_comp_postcode" maxlength="10" placeholder="<spring:message code="fap.placholder.postcode" />"></div>
									</div>
									<div class="joinBBS-row">
										<!-- 주소 -->
										<div class="joinlt point"><spring:message code="fap.comp.address" /><span class="red-point"></span></div>
										<div class="joinrt"><input type="text" id="fap_comp_address" name="fap_comp_address" maxlength="150"></div>
									</div>
									<div class="joinBBS-row">
										<!-- 상세주소 -->
										<div class="joinlt"><spring:message code="fap.comp.address_detail" /></div>
										<div class="joinrt"><input type="text" id="fap_comp_address_detail" name="fap_comp_address_detail" maxlength="150"></div>
									</div>
										<div class="joinBBS-row">	
										<!-- 설립일 -->
										<div class="joinlt point"><spring:message code="fap.comp.est_dt" /><span class="red-point"></span></div>
										<div class="joinrt"><input type="text" id="fap_comp_est_dt" name="fap_comp_est_dt" placeholder="<spring:message code="fap.placeholder.est_dt" />" maxlength="25"></div>
									</div>
									<div class="joinBBS-row">
										<!-- 자본금 -->
										<div class="joinlt point"><spring:message code="fap.comp.stock" /><span class="red-point"></span></div>
										<div class="joinrt"><input type="text" class="currency" id="fap_comp_stock" name="fap_comp_stock"  ng-model="fap_comp_stock" blur-currency maxlength="22">
										<span class="hiddenTx">円</span>
										</div>
									</div>
									<div class="joinBBS-row">
										<!-- 최근 3년간 평균매출 -->
										<div class="joinlt point"><spring:message code="fap.comp.3years_avg_sales" /><span class="red-point"></span></div>
										<div class="joinrt"><input type="text" class="currency" id="fap_comp_3years_avg_sales" name="fap_comp_3years_avg_sales" ng-model="fap_comp_3years_avg_sales" blur-currency maxlength="22">
										<span class="hiddenTx">円</span>
										</div>
									</div>
									<div class="joinBBS-row">	
										<!-- 사원수 -->
										<div class="joinlt point"><spring:message code="fap.comp.employee_num" /><span class="red-point"></span></div>
										<div class="joinrt">
											<input type="text" id="fap_comp_employee_num" name="fap_comp_employee_num" class="input currency" maxlength="9" blur-currency ng-model="fap_comp_employee_num">
											<span class="hiddenTx">名</span>
										</div>
									</div>
									<div class="joinBBS-row">
										<!-- SC IT Master 사원수 -->
										<div class="joinlt nl"><spring:message code="fap.comp.scit_num" /></div>
										<div class="joinrt">
											<input type="text" id="fap_comp_scit_num" name="fap_comp_scit_num" class="input currency" maxlength="9" blur-currency ng-model="fap_comp_scit_num">
											<span class="hiddenTx">名</span>
										</div>
									</div>
									<div class="joinBBS-row">
										<!-- 한국인 사원수 -->
										<div class="joinlt"><spring:message code="fap.comp.korean_num" /></div>
										<div class="joinrt">
											<input type="text" id="fap_comp_korean_num" name="fap_comp_korean_num" class="input currency" maxlength="9" blur-currency ng-model="fap_comp_korean_num">
											<span class="hiddenTx">名</span>
										</div>
									</div>
									<div class="joinBBS-row">
										<!-- 기타 외국인 사원수 -->
										<div class="joinlt"><spring:message code="fap.comp.foreigner_num" /></div>
										<div class="joinrt">
											<input type="text" id="fap_comp_foreigner_num" name="fap_comp_foreigner_num" class="input currency" maxlength="9" blur-currency ng-model="fap_comp_foreigner_num">
											<span class="hiddenTx">名</span>	
										</div>
									</div>
									<div class="joinBBS-row">
										<!-- 로고등록 -->
										<div class="joinlt point"><spring:message code="fap.comp.log_file" /><span class="red-point"></span></div>
										<div class="joinrt"><input type="file" id="fap_comp_log_file" name="fap_comp_log_file" accept="image/*"></div>
									</div>
									<div class="joinBBS-row2">
										<div id="imgDiv"></div>
									</div>
									<div class="joinBBS-row2">
										<div><spring:message code="fap.comp.log_using" /></div>	
										<input type="radio" id="radio3" name="fap_comp_log_using" value="B3200" checked="checked">
										<label for="radio3">
											<span class="radio-span"></span>
											<b><code value="B3200"></code></b>
										</label> &nbsp;
										
										<input type="radio" id="radio4" name="fap_comp_log_using" value="B3201">
										<label for="radio4">
											<span class="radio-span"></span>
											<b><code value="B3201"></code></b>
										</label> &nbsp;
										
										<input type="radio" id="radio5" name="fap_comp_log_using" value="B3202">
										<label for="radio5">
											<span class="radio-span"></span>
											<b><code value="B3202"></code></b>
										</label>
									</div>
								</div>
						</div>
					</div>
				</div>
				<div class="joinBox">
					<div class="join-policy">
						<input type="checkbox" id="user_terms_ck" name="user_terms_ck" value="A1301">
						<!-- <input type="hidden" name="user_terms_ck" value="A1301"> -->
						<label class="policy-label" for="user_terms_ck">
							<spring:message code="fap.common.privacy.policy" />
							<%-- <a href="javascript:void(0);" class="privacy-policy-link">
								<spring:message code="fap.common.privacy.policy.info" />
							</a> --%>
						</label>
						<div id="privacy-policy">
							<div class="privacy-policy-context">
								<spring:message code="fap.personal.security.agreement" />
							</div>
						</div>
						<div class="policy-agree">
							<span><spring:message code="fap.common.privacy.policy_agree_check" /></span>
						</div>
					</div>
				</div>

				<div class="joinBox">
					<div class="join-policy">
						<div id="joinBtn">
							<button type="button" class="join-btn icon submitBtn" onclick="form_check();"><spring:message code="fap.common.join.btn" /></button>
						</div>
					</div>
				</div>
		</form>
	</div>
</div>
<%@include file="agency_footer.jsp"%>
</body>
</html>
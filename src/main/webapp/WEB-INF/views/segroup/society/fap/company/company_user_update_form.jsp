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
<script src="<c:url value="/resources/segroup/society/fap/js/lodash.js" />"></script>

<link type="text/css" rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto:400,500">
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/segroup/society/fap/css/default.css" />" />
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/segroup/society/fap/css/popModal.css" />" />
<script type="text/javascript">
var pw_regex = new RegExp("[0-9a-zA-Z!@#$%^&*]+");
var email_regex = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
var blank_regex = /\s/g;
//상수
const ID_MIN_LENGTH = 6;
const ID_MAX_LENGTH = 20;
const PW_MIN_LENGTH = 8;
const PW_MAX_LENGTH = 40;

	$(function() {
		
		_update = _.debounce(function(){
			$('#company_user_update_form').submit(); 
		},500,true);
		
		$("input[type='text']").keyup(function(){
			//모든 input text 글자수 제한
	        if ($(this).val().length > $(this).attr('maxlength')) {
	            alert('<spring:message code="fap.err.over_maxlength" javaScriptEscape="true" />');
	            $(this).val($(this).val().substr(0, $(this).attr('maxlength')));
	        }
	    });
		$("input[type='email']").keyup(function(){
			//email 글자수 제한
	        if ($(this).val().length > $(this).attr('maxlength')) {
	            alert('<spring:message code="fap.err.over_maxlength" javaScriptEscape="true" />');
	            $(this).val($(this).val().substr(0, $(this).attr('maxlength')));
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
				alert('<spring:message code="fap.err.image_type" />');
				return;
			}
		});
		
		$("input:radio[value='${company_user.user_sex}']").prop("checked", true);
	
	});
	
	/**
	 * 엘리먼트를 선택한다
	 */
	function selectAndFocus(element) {
		element.select();
		element.focus();
	}
	//trim 함수
	function trim(stringToTrim) {
	    return stringToTrim.replace(/^\s+|\s+$/g,"");
	};
	/**
	 * 폼체크
	 */
	function form_check() {
		var input_pw = $('#user_pw');
		var input_pw_check = $('#user_pw_check');
		var user_nm = $('#user_nm');
		var input_user_email = $('#user_email');
		var input_pw_val = input_pw.val();
		var input_pw_check_val = input_pw_check.val();
		
		input_user_email.val(trim(input_user_email.val()));
		//패스워드
		if (input_pw_val.length < PW_MIN_LENGTH ||
				PW_MAX_LENGTH < input_pw_val.length) {
	        alert('<spring:message code="fap.err.pw_length" javaScriptEscape="true" />');
			selectAndFocus(input_pw);
			return false;
		}
		
		if (input_pw_val == '') {
			alert('<spring:message code="fap.err.pw_check" javaScriptEscape="true" />');
			selectAndFocus(input_pw);
			return false;
		}
		
		//공백문자 여부 확인
		if(input_pw_val.match(blank_regex)){
			alert('<spring:message code="fap.err.space_character" javaScriptEscape="true" />');//메시지 추가
			return false;
		}
		
		if(input_user_email.val().match(blank_regex)){
			alert('<spring:message code="fap.err.space_character" javaScriptEscape="true" />');
			return false;
		}
		
		if (input_pw_check_val == '') {
			alert('<spring:message code="fap.err.pw_check_input" javaScriptEscape="true" />');
			selectAndFocus(input_pw_check);
			return false;
		}
		
		if (input_pw_val != input_pw_check_val) {
			alert('<spring:message code="fap.err.pw_mismatched" javaScriptEscape="true" />');
			selectAndFocus(input_pw);
			return false;
		}
		
		//이름
		if(user_nm.val() == ''){
			alert('<spring:message code="fap.err.name_input" javaScriptEscape="true" />');
			selectAndFocus(user_nm);
			return false;
		}
		user_nm.val(trim(user_nm.val()));
			
		//이메일
		if (input_user_email.val() == '') {
			alert('<spring:message code="fap.err.email_input_err" javaScriptEscape="true" />');
			selectAndFocus(input_user_email);
			return false;
		}
		
		if (!input_user_email.attr('checked')) {
			alert('<spring:message code="fap.err.email_duplicate_check" javaScriptEscape="true" />');
			selectAndFocus(input_user_email);
			return false;
		}
		
		_update();
	}
	
	function checkEmailIsDuplicated() {
		//원래 이메일 
		var origin_email = $('#user_origin_email').val();
		var element = $('#user_email');
		//원래 이메일과 입력한 이메일이 같으면 그냥 넘겨줌 
		if(element.val() == origin_email) {
			var duplCheck = confirm('<spring:message code="fap.err.id_usable" javaScriptEscape="true" />');
			
			if(duplCheck){
				element.attr('checked', '');
				element.attr('readonly','readonly');
			}else{
				element.removeAttr('readonly');
				element.removeAttr('checked');
			}
			
		} else {
			
			var data = {
					user_email: element.val()
			};
			
			$.ajax({
				beforeSend: function(xhr) {
				     xhr.setRequestHeader("AJAX", true);
				}
				, url: '/fap/company/user_duplicated'
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
					if(e.status == 403){
						alert('<spring:message code="com.login.ajaxSesstion" javaScriptEscape="true" />');
						location.href = "/fap/company/company_login";
					}else{
						alert('<spring:message code="fap.err.duplicated_confirm_err" javaScriptEscape="true" />');
					}
				}
			});
		}
		
	}
	
	//자식창 띄워서 회원 탈퇴 진행
	function company_user_delete() {
		var windowW = 482;  // 창의 가로 길이
        var windowH = 386;  // 창의 세로 길이
		var left = Math.ceil((window.screen.width - windowW)/2);
	    var top = Math.ceil((window.screen.height - windowH)/2);
		var settings = "width="+ windowW +", height="+ windowH +", top="+top+", left="+left+", resizable=no, resizable=no";
		var windowObj = window.open("/fap/company/company_user_info_delete_form", "회원 탈퇴 폼", settings);
	}
</script>
<body>
<%@include file="company_menu.jsp"%>

<div class="join-wrap">
	<div id="subcontents">
	<form action="/fap/company/company_user_update_form" method="post" enctype="multipart/form-data" id="company_user_update_form">
	<input type="hidden" id="user_origin_email" name="user_origin_email" size="30" value="${company_user.user_email}">
		<div class="joinBox">
			<div class="jointt">
				<p class="jointxt1">
			        <spring:message code="fap.common.head.title.responsible_person_info_update" />
				</p>
			</div>
			<div class="join-contents">
					<!-- 라디오 박스 선택전 입력란 시작 -->
				<div class="joinBBS">
						<div class="joinBBS-row">
							<div class="joinlt"><spring:message code="fap.common.user_id" /></div>
							<div class="joinrt">
								<input type="text" id="user_id" name="user_id" value="${company_user.user_id}" readonly="readonly">
							</div>
						</div>
						<div class="joinBBS-row">
							<div class="joinlt"><spring:message code="fap.common.password" /></div>
							<div class="joinrt"><input type="password" id="user_pw" name="user_pw" placeholder="<spring:message code="fap.placholder.pw" />"></div>
						</div>
						<div class="joinBBS-row">
							<div class="joinlt"><spring:message code="fap.common.password_ck" /></div>
							<div class="joinrt"><input type="password" id="user_pw_check" placeholder="<spring:message code="fap.placholder.pw" />"></div>
						</div>
						<div class="joinBBS-row">
							<div class="joinlt"><spring:message code="fap.common.user_nm" /></div>
							<div class="joinrt"><input type="text" id="user_nm" name="user_nm" value="${company_user.user_nm}" placeholder="<spring:message code="fap.placholder.name" />"></div>
						</div>
						<div class="joinBBS-row">
							<div class="joinlt"><spring:message code="fap.common.email" /></div>
							<div class="joinrt">
								<input type="text" id="user_email" name="user_email" size="30" value="${company_user.user_email}">
								<button class="join_btn" type="button" onclick="checkEmailIsDuplicated();">
									<spring:message code="fap.common.duplicate_ck" />
								</button>
							</div>
						</div>
						<input type="hidden" id="user_birth" name="user_birth" value="${company_user.user_birth}" readonly="readonly"><br>
						<input type="hidden" name="user_sex" value="A0000" checked="checked">
						<input type="hidden" name="user_sex" value="A0001">
						<input type="hidden" name="user_flag" value="A0103">
						<input type="hidden" name="user_state" value="A0200">
						<input type="hidden" id="user_phone" name="user_phone" value="000-000-0000">
					</div>
				</div>
			</div>
			<div class="joinBox">
				<div class="join-policy">
					<div id="joinBtn">
						<button type="button" class="join-btn icon submitBtn" onclick="form_check();"><spring:message code="fap.common.user_update"/></button>
						<!-- 회원 탈퇴 -->
						<a href="javascript:company_user_delete()">
							<h5 style="color: #930117; text-align: right;"><spring:message code="fap.common.user_withdraw" /></h5>
						</a>
					</div>
				</div>
			</div>
		</form>
		<!-- 회원 탈퇴 -->
	</div>
</div>
<%@include file="company_footer.jsp"%>
</body>
</html>
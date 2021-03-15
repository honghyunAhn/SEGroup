<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
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
<script src="<c:url value="/resources/segroup/js/angular.min.js" />"></script>
<script src="<c:url value="/resources/segroup/js/datepicker.js" />"></script>	

<link rel="stylesheet" type="text/css" href="<c:url value="/resources/segroup/society/fap/css/default.css" />" />
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/segroup/society/fap/css/popModal.css" />" />
<script type="text/javascript">
//정규표현식
var phone_regex = /^\d{3}\d{3,4}\d{4}$/;
var pw_regex = new RegExp("[0-9a-zA-Z!@#$%^&*]+");
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
const JOB_OBJECTIVE_LENGTH = 50;
const EDU_COURSE_NM_LENGTH = 50;

//본인인증 (서브도메인 처리)
//document.domain = 'sesoc.global';
document.domain = 'softsociety.net';

	$(function() {
		cleanDatepicker();
		
		$('#user_birth').datepicker({
			dateFormat : 'yy/mm/dd'
			, changeMonth: true
			, changeYear: true
			, yearRange: "1900:"
		});
		
		// 성별
		$('.sex-type').on('click', function() {
			$('.sex-type').removeClass('ck');
			$('.sex-type').find('input:radio[name="user_sex"]').prop('checked', false);
			
			$(this).addClass("ck");
			$(this).find('input:radio[name="user_sex"]').prop('checked', true);
		});
		
		// 고등학교 계열
		$('.hs-field').on('click', function() {
			$('.hs-field').removeClass('ck');
			$('.hs-field').find('input:radio[name="fap_personal_hs_field"]').prop('checked', false);
			
			$(this).addClass("ck");
			$(this).find('input:radio[name="fap_personal_hs_field"]').prop('checked', true);
		});
		  
		// 국내/외 구분
		$('.univ-abroad').on('click', function() {
			$('.univ-abroad').removeClass('ck');
			$('.univ-abroad').find('input:radio[name="fap_personal_univ_abroad_ck"]').prop('checked', false);
			
			$(this).addClass("ck");
			$(this).find('input:radio[name="fap_personal_univ_abroad_ck"]').prop('checked', true);
		});
		
		// 학부 구분
		$('.univ-coll').on('click', function() {
			$('.univ-coll').removeClass('ck');
			$('.univ-coll').find('input:radio[name="fap_personal_univ_coll"]').prop('checked', false);
			
			$(this).addClass("ck");
			$(this).find('input:radio[name="fap_personal_univ_coll"]').prop('checked', true);
		});
		
		// 석/박사 구분
		$('.grad-ck').on('click', function() {
			$('.grad-ck').removeClass('ck');
			$('.grad-ck').find('input:radio[name="fap_personal_grad_ck"]').prop('checked', false);
			
			$(this).addClass("ck");
			$(this).find('input:radio[name="fap_personal_grad_ck"]').prop('checked', true);
		});
		
		select_event();
		
		$(".policy-agree").on("click",function(e){
			$(this).toggleClass("check");	
			if($(this).hasClass("check")){
				$("input:checkbox[id='user_terms_ck']").prop("checked", true);
			}else {
				$("input:checkbox[id='user_terms_ck']").prop("checked", false);
			}

			return false;
		});
		
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
	 * angular.js
	 */
	var myApp = angular.module('myapp', []);
	
	myApp.controller('BBSController',['$scope','$compile', '$http', function($scope, $compile) {
		
		var kmoveList = JSON.parse('${kmoveList}');
		$scope.kmoveList = JSON.parse('${kmoveList}');
		
		var content = '';
		 
		// [start] 교육기관 불러오기 시작
		content += '<div class="BBS-select">';
		content += '	<button type="button" class="BBS-select-btn">';
		content += '<span>' + kmoveList[0].code_nm + '</span>';
		content += '	</button>';
		content += '	<input type="hidden" id="fap_personal_user_edu_ct_nm" name="fap_personal_user_edu_ct_nm" value="A1500">';
		content += '</div>';
		content += '<div class="BBS-select-option">';
		content += '	<ul class="option-list">';
		for(var i in kmoveList) {
			var edu_code = kmoveList[i].group_id + kmoveList[i].code;
			content += '	<li class="option-type">';
			content += '		<button type="button">';
			content += '			<span value="' + edu_code + '">' + kmoveList[i].code_nm + '</span>';
			content += '		</button>';
			content += '	</li>';
		}
		content += '	</ul>';
		content += '</div>';

		$('#user_org').append($compile(content)($scope));
		content = '';
		// [end] 교육기관 불러오기 끝
		
		// [start] 최종학력 불러오기 시작
		content += '<div class="BBS-select" id="school_gb">';
		content += '	<button type="button" class="BBS-select-btn"><code value="B3300"></code></button>';
		content += '	<input type="hidden" id="fap_personal_user_edu_level" name="fap_personal_user_edu_level" value="B3300">';
		content += '</div>';
		content += '<div class="BBS-select-option">';
		content += '	<ul class="option-list">';
		content += '		<li class="option-type edu_level_type">';
		content += '			<button type="button"><code value="B3300"></code></button>';
		content += '		</li>';
		content += '		<li class="option-type edu_level_type">';
		content += '			<button type="button"><code value="B3304"></code></button>';
		content += '		</li>';
		content += '		<li class="option-type edu_level_type">';
		content += '			<button type="button"><code value="B3301"></code></button>';
		content += '		</li>';
		content += '		<li class="option-type edu_level_type">';
		content += '			<button type="button"><code value="B3305"></code></button>';
		content += '		</li>';
		content += '		<li class="option-type edu_level_type">';
		content += '			<button type="button"><code value="B3302"></code></button>';
		content += '		</li>';
		content += '		<li class="option-type edu_level_type">';
		content += '			<button type="button"><code value="B3306"></code></button>';
		content += '		</li>';
		content += '		<li class="option-type edu_level_type">';
		content += '			<button type="button"><code value="B3303"></code></button>';
		content += '		</li>';
		content += '	</ul>';
		content += '</div>';

		$('#edu_level').append($compile(content)($scope));
		content = '';
		// [end] 최종학력 불러오기 끝
		
		$scope.school_event = function(selected_obj) {
			var edu_level = selected_obj.find('span').attr('value');
			// 최종학력에 따른 폼 변형
			var content = '';
			if(edu_level == 'B3300'){
				$('#edu_detail').empty();
				
				content += '<div class="joinBBS-row">';
				content += '	<div class="joinlt">고등학교 명</div>';
				content += '	<div class="joinrt">';
				content += '		<input type="text" id="fap_personal_hs_nm" name="fap_personal_hs_nm">';
				content += '	</div>';
				content += '</div>';
				
				content += '<div class="joinBBS-row radio-row">';
				content += '	<div class="joinlt">계열</div>';
				content += '	<div class="joinrt">';
				content += '		<span class="bbs-radio hs-field ck">';
				content += '			<label class="bbs-radio-label">';
				content += '				<code value="B3400"></code>';
				content += '			</label>';
				content += '			<input type="radio" id="field_mk" name="fap_personal_hs_field" id="fap_personal_hs_field" value="B3400" checked="checked"/>';
				content += '		</span>';
				content += '		<span class="bbs-radio hs-field">';
				content += '			<label class="bbs-radio-label">';
				content += '				<code value="B3401"></code>';
				content += '			</label>';
				content += '			<input type="radio" id="field_lk" name="fap_personal_hs_field" id="fap_personal_hs_field" value="B3401"/>';
				content += '		</span>';
				content += '		<span class="bbs-radio hs-field">';
				content += '			<label class="bbs-radio-label">';
				content += '				<code value="B3402"></code>';
				content += '			</label>';
				content += '			<input type="radio" id="field_sh" name="fap_personal_hs_field" id="fap_personal_hs_field" value="B3402"/>';
				content += '		</span>';
				content += '	</div>';
				content += '</div>';
				
			}
			// 전문대학교 재학, 졸업 / 대학교 재학, 졸업
			if(edu_level == 'B3301'
					|| edu_level == 'B3302'
					|| edu_level == 'B3304'
					|| edu_level == 'B3305'){
				$('#edu_detail').empty();
				
				content += '<div class="joinBBS-row">';
				content += '	<div class="joinlt">대학교 명</div>';
				content += '	<div class="joinrt">';
				content += '		<input type="text" id="fap_personal_univ_nm" name="fap_personal_univ_nm">';
				content += '	</div>';
				content += '</div>';
				
				content += '<div class="joinBBS-row radio-row">';
				content += '	<div class="joinlt">국내/외 구분</div>';
				content += '	<div class="joinrt">';
				content += '		<span class="bbs-radio univ-abroad ck">';
				content += '			<label class="bbs-radio-label">';
				content += '				<code value="B3500"></code>';
				content += '			</label>';
				content += '			<input type="radio" id="abroad_do" name="fap_personal_univ_abroad_ck" id="fap_personal_univ_abroad_ck" value="B3500" checked="checked"/>';
				content += '		</span>';
				content += '		<span class="bbs-radio univ-abroad">';
				content += '			<label class="bbs-radio-label">';
				content += '				<code value="B3501"></code>';
				content += '			</label>';
				content += '			<input type="radio" id="abroad_ov" name="fap_personal_univ_abroad_ck" id="fap_personal_univ_abroad_ck" value="B3501"/>';
				content += '		</span>';			
				content += '	</div>';		
				content += '</div>';
				
				content += '<div class="joinBBS-row radio-row">';
				content += '	<div class="joinlt">학부</div>';
				content += '	<div class="joinrt">';
				content += '		<span class="bbs-radio univ-coll ck">';
				content += '			<label class="bbs-radio-label">';
				content += '				<code value="B2800"></code>';
				content += '			</label>';
				content += '			<input type="radio" id="coll_cs" name="fap_personal_univ_coll" id="fap_personal_univ_coll" value="B2800" checked="checked"/>';
				content += '		</span>';
				content += '		<span class="bbs-radio univ-coll">';
				content += '			<label class="bbs-radio-label">';
				content += '				<code value="B2801"></code>';
				content += '			</label>';
				content += '			<input type="radio" id="coll_cs_e" name="fap_personal_univ_coll" id="fap_personal_univ_coll" value="B2801"/>';
				content += '		</span>';
				content += '		<span class="bbs-radio univ-coll">';
				content += '			<label class="bbs-radio-label">';
				content += '				<code value="B2802"></code>';
				content += '			</label>';
				content += '			<input type="radio" id="coll_ja" name="fap_personal_univ_coll" id="fap_personal_univ_coll" value="B2802"/>';
				content += '		</span>';
				content += '		<span class="bbs-radio univ-coll">';
				content += '			<label class="bbs-radio-label">';
				content += '				<code value="B2803"></code>';
				content += '			</label>';
				content += '			<input type="radio" id="coll_la" name="fap_personal_univ_coll" id="fap_personal_univ_coll" value="B2803"/>';
				content += '		</span>';
				content += '		<span class="bbs-radio univ-coll">';
				content += '			<label class="bbs-radio-label">';
				content += '				<code value="B2804"></code>';
				content += '			</label>';
				content += '			<input type="radio" id="coll_ga" name="fap_personal_univ_coll" id="fap_personal_univ_coll" value="B2804"/>';
				content += '		</span>';
				content += '		<span class="bbs-radio univ-coll">';
				content += '			<label class="bbs-radio-label">';
				content += '				<code value="B2805"></code>';
				content += '			</label>';
				content += '			<input type="radio" id="coll_ns" name="fap_personal_univ_coll" id="fap_personal_univ_coll" value="B2805"/>';
				content += '		</span>';
				content += '		<span class="bbs-radio univ-coll">';
				content += '			<label class="bbs-radio-label">';
				content += '				<code value="B2806"></code>';
				content += '			</label>';
				content += '			<input type="radio" id="coll_eng" name="fap_personal_univ_coll" id="fap_personal_univ_coll" value="B2806"/>';
				content += '		</span>';
				content += '		<span class="bbs-radio univ-coll">';
				content += '			<label class="bbs-radio-label">';
				content += '				<code value="B2807"></code>';
				content += '			</label>';
				content += '			<input type="radio" id="coll_etc" name="fap_personal_univ_coll" id="fap_personal_univ_coll" value="B2807"/>';
				content += '		</span>';
				content += '		</span>';
				content += '	</div>';
				content += '</div>';

				content += '<div class="joinBBS-row">';
				content += '	<div class="joinlt">세부전공</div>';
				content += '	<div class="joinrt">';
				content += '		<input type="text" id="fap_personal_univ_major" name="fap_personal_univ_major">';
				content += '	</div>';
				content += '</div>';
				
			}
			
			// 대학원 재학, 졸업
			if(edu_level == 'B3303'
					|| edu_level == 'B3306'){
				$('#edu_detail').empty();
				
				content += '<div class="joinBBS-row">';
				content += '	<div class="joinlt">대학교 명</div>';
				content += '	<div class="joinrt">';
				content += '		<input type="text" id="fap_personal_univ_nm" name="fap_personal_univ_nm">';
				content += '	</div>';
				content += '</div>';
				
				content += '<div class="joinBBS-row radio-row">';
				content += '	<div class="joinlt">국내/외 구분</div>';
				content += '	<div class="joinrt">';
				content += '		<span class="bbs-radio univ-abroad ck">';
				content += '			<label class="bbs-radio-label">';
				content += '				<code value="B3500"></code>';
				content += '			</label>';
				content += '			<input type="radio" id="abroad_do" name="fap_personal_univ_abroad_ck" id="fap_personal_univ_abroad_ck" value="B3500" checked="checked"/>';
				content += '		</span>';
				content += '		<span class="bbs-radio univ-abroad">';
				content += '			<label class="bbs-radio-label">';
				content += '				<code value="B3501"></code>';
				content += '			</label>';
				content += '			<input type="radio" id="abroad_ov" name="fap_personal_univ_abroad_ck" id="fap_personal_univ_abroad_ck" value="B3501"/>';
				content += '		</span>';			
				content += '	</div>';		
				content += '</div>';
				
				content += '<div class="joinBBS-row radio-row">';
				content += '	<div class="joinlt">학부</div>';
				content += '	<div class="joinrt">';
				content += '		<span class="bbs-radio univ-coll ck">';
				content += '			<label class="bbs-radio-label">';
				content += '				<code value="B2800"></code>';
				content += '			</label>';
				content += '			<input type="radio" id="coll_cs" name="fap_personal_univ_coll" id="fap_personal_univ_coll" value="B2800" checked="checked"/>';
				content += '		</span>';
				content += '		<span class="bbs-radio univ-coll">';
				content += '			<label class="bbs-radio-label">';
				content += '				<code value="B2801"></code>';
				content += '			</label>';
				content += '			<input type="radio" id="coll_cs_e" name="fap_personal_univ_coll" id="fap_personal_univ_coll" value="B2801"/>';
				content += '		</span>';
				content += '		<span class="bbs-radio univ-coll">';
				content += '			<label class="bbs-radio-label">';
				content += '				<code value="B2802"></code>';
				content += '			</label>';
				content += '			<input type="radio" id="coll_ja" name="fap_personal_univ_coll" id="fap_personal_univ_coll" value="B2802"/>';
				content += '		</span>';
				content += '		<span class="bbs-radio univ-coll">';
				content += '			<label class="bbs-radio-label">';
				content += '				<code value="B2803"></code>';
				content += '			</label>';
				content += '			<input type="radio" id="coll_la" name="fap_personal_univ_coll" id="fap_personal_univ_coll" value="B2803"/>';
				content += '		</span>';
				content += '		<span class="bbs-radio univ-coll">';
				content += '			<label class="bbs-radio-label">';
				content += '				<code value="B2804"></code>';
				content += '			</label>';
				content += '			<input type="radio" id="coll_ga" name="fap_personal_univ_coll" id="fap_personal_univ_coll" value="B2804"/>';
				content += '		</span>';
				content += '		<span class="bbs-radio univ-coll">';
				content += '			<label class="bbs-radio-label">';
				content += '				<code value="B2805"></code>';
				content += '			</label>';
				content += '			<input type="radio" id="coll_ns" name="fap_personal_univ_coll" id="fap_personal_univ_coll" value="B2805"/>';
				content += '		</span>';
				content += '		<span class="bbs-radio univ-coll">';
				content += '			<label class="bbs-radio-label">';
				content += '				<code value="B2806"></code>';
				content += '			</label>';
				content += '			<input type="radio" id="coll_eng" name="fap_personal_univ_coll" id="fap_personal_univ_coll" value="B2806"/>';
				content += '		</span>';
				content += '		<span class="bbs-radio univ-coll">';
				content += '			<label class="bbs-radio-label">';
				content += '				<code value="B2807"></code>';
				content += '			</label>';
				content += '			<input type="radio" id="coll_etc" name="fap_personal_univ_coll" id="fap_personal_univ_coll" value="B2807"/>';
				content += '		</span>';
				content += '		</span>';
				content += '	</div>';
				content += '</div>';

				content += '<div class="joinBBS-row">';
				content += '	<div class="joinlt">세부전공</div>';
				content += '	<div class="joinrt">';
				content += '		<input type="text" id="fap_personal_univ_major" name="fap_personal_univ_major">';
				content += '	</div>';
				content += '</div>';
				
				content += '<div class="joinBBS-row">';
				content += '	<div class="joinlt">대학원 명</div>';
				content += '	<div class="joinrt">';
				content += '		<input type="text" id="fap_personal_grad_nm" name="fap_personal_grad_nm">';
				content += '	</div>';
				content += '</div>';
				
				content += '<div class="joinBBS-row radio-row">';
				content += '	<div class="joinlt">석/박사 구분</div>';
				content += '	<div class="joinrt">';
				content += '		<span class="bbs-radio grad-ck ck">';
				content += '			<label class="bbs-radio-label">';
				content += '				<code value="B3600"></code>';
				content += '			</label>';
				content += '			<input type="radio" id="grad_ms" name="fap_personal_grad_ck" id="fap_personal_grad_ck" value="B3600" checked="checked"/>';
				content += '		</span>';
				content += '		<span class="bbs-radio grad-ck">';
				content += '			<label class="bbs-radio-label">';
				content += '				<code value="B3601"></code>';
				content += '			</label>';
				content += '			<input type="radio" id="grad_doc" name="fap_personal_grad_ck" id="fap_personal_grad_ck" value="B3601"/>';
				content += '		</span>';			
				content += '	</div>';		
				content += '</div>';
				
				content += '<div class="joinBBS-row">';
				content += '	<div class="joinlt">전공분야</div>';
				content += '	<div class="joinrt">';
				content += '		<input type="text" id="fap_personal_grad_major" name="fap_personal_grad_major">';
				content += '	</div>';
				content += '</div>';
				
			}
			
			$('#edu_detail').append($compile(content)($scope));
			
			// 고등학교 계열
			$('.hs-field').on('click', function() {
				$('.hs-field').removeClass('ck');
				$('.hs-field').find('input:radio[name="fap_personal_hs_field"]').prop('checked', false);
				
				$(this).addClass("ck");
				$(this).find('input:radio[name="fap_personal_hs_field"]').prop('checked', true);
			});
			
			// 국내/외 구분
			$('.univ-abroad').on('click', function() {
				$('.univ-abroad').removeClass('ck');
				$('.univ-abroad').find('input:radio[name="fap_personal_univ_abroad_ck"]').prop('checked', false);
				
				$(this).addClass("ck");
				$(this).find('input:radio[name="fap_personal_univ_abroad_ck"]').prop('checked', true);
			});
			
			// 학부 구분
			$('.univ-coll').on('click', function() {
				$('.univ-coll').removeClass('ck');
				$('.univ-coll').find('input:radio[name="fap_personal_univ_coll"]').prop('checked', false);
				
				$(this).addClass("ck");
				$(this).find('input:radio[name="fap_personal_univ_coll"]').prop('checked', true);
			});
			
			// 석/박사 구분
			$('.grad-ck').on('click', function() {
				$('.grad-ck').removeClass('ck');
				$('.grad-ck').find('input:radio[name="fap_personal_grad_ck"]').prop('checked', false);
				
				$(this).addClass("ck");
				$(this).find('input:radio[name="fap_personal_grad_ck"]').prop('checked', true);
			});
			
		}
		
	}]);
	
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
	
	//셀렉트 박스 공통 이벤트
	function select_box_event(){
		$(".BBS-select").off("click").on("click",function(){
			$(this).toggleClass("on");
			$(this).nextAll(".BBS-select-option").toggle();
		});
		
		$(".BBS-select-option").off("mouseenter").on("mouseenter",function(){
			blur_flag = false;
		});
		$(".BBS-select-option").off("mouseleave").on("mouseleave",function(){
			blur_flag = true;
		});
		
		$(".BBS-select-btn").blur(function(){
	 		if(blur_flag){
				$(this).closest(".BBS-select").removeClass("on");
				$(this).closest(".BBS-select").nextAll(".BBS-select-option").css("display","none");
	 		}
		});
	}
	
	// 교육기관 이벤트
	function select_event() {
		select_box_event();
		
		$(".option-type").off("click").on("click",function(){
			
			var selected_obj = $(this);
			
			if(!$(this).hasClass("selected")){
				var btnval = $(this).find("span").text();
				var org_code = $(this).find("span").attr("value");
				$(this).closest(".BBS-dropdown").find(".BBS-select span").text(btnval);
				$(this).closest(".BBS-dropdown").find(".BBS-select input").val(org_code);
				
				$(this).siblings().removeClass("selected");
				$(this).addClass("selected");
				
				if(org_code != 'A1500'){
					$(".course").removeClass("disnone");
				}else{
					$(".course").addClass("disnone");
				}
				
			}
			$(this).closest(".BBS-dropdown").find(".BBS-select").removeClass("on");
			$(this).closest(".BBS-dropdown").find(".BBS-select").nextAll(".BBS-select-option").css("display","none");

			
			if($(this).hasClass("edu_level_type")){
				angular.element("#fap_user_insert_body").scope().school_event(selected_obj);
			}
			
		});
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
	
	function checkDuplicated(data, element) {
		
		console.log("data : "+data);
		console.log("element : "+element);
		
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
		if (isJobObjectiveCorrect() == false) { return false; }
		
		
		if($("input:checkbox[id='user_terms_ck']").is(":checked") == false){
			alert('<spring:message code="fap.err.comp_user_terms_check" javaScriptEscape="true" />');
			return false;
		}
		
		var edu_ct_nm = $('#fap_personal_user_edu_ct_nm').val();
		//교육기관 있을 시 명칭 체크
		if(edu_ct_nm != 'A1500'){
			if(isEduCourseNmCorrect() == false) { return false; }
		}
		
		var edu_level = $('#fap_personal_user_edu_level').val();
		// 고등학교 폼 체크
		if(edu_level == 'B3300'){
			if(isHsCorrect() == false) { return false; }
		}
		// 대학교 폼 체크
		if(edu_level == 'B3301' || edu_level == 'B3302' || edu_level == 'B3304' || edu_level == 'B3305'){
			if(isUnivCorrect() == false) { return false; }
		}
		// 대학교, 대학원 폼 체크
		if(edu_level == 'B3303' || edu_level == 'B3306'){
			if(isUnivCorrect() == false) { return false; }
			if(isGradCorrect() == false) { return false; }
		}
		
		return true;
	}	
	
	function isEduCourseNmCorrect() {
		var edu_course_nm = $("#edu_course_nm").val();
		if(edu_course_nm == ''){
			alert("기관명-과정명을 입력해 주시기 바랍니다.");
			return false;
		}
		if(edu_course_nm > EDU_COURSE_NM_LENGTH){
			alert("기관명-과정명은 최대 50글자 까지 입력 가능합니다.");
			return false;
		}
		return true;
	}
	
	function isJobObjectiveCorrect() {
		var job_objective = $("#job_objective").val();
		if(job_objective == ''){
			alert("취업희망직무를 입력해 주시기 바랍니다.");
			return false;
		}
		if(job_objective.length > JOB_OBJECTIVE_LENGTH){
			alert("취업희망직무는 최대 50글자 까지 입력 가능합니다.");
			return false;
		}
		return true;
	}
	
	function isHsCorrect() {
		var fap_personal_hs_nm = $('#fap_personal_hs_nm').val();
		if(fap_personal_hs_nm == ''){
			alert('고등학교 명을 입력해 주시기 바랍니다.');
			return false;
		}
		return true;
	}
	
	function isUnivCorrect() {
		var fap_personal_univ_nm = $('#fap_personal_univ_nm').val();
		var fap_personal_univ_major = $('#fap_personal_univ_major').val();
		
		if(fap_personal_univ_nm == ''){
			alert('대학교 명을 입력해 주시기 바랍니다.');
			return false;
		}
		
		if(fap_personal_univ_major == ''){
			alert('세부전공을 입력해 주시기 바랍니다.');
			return false;
		}
		return true;
	}
	
	function isGradCorrect() {
		var fap_personal_grad_nm = $('#fap_personal_grad_nm').val();
		var fap_personal_grad_major = $('#fap_personal_grad_major').val();
		
		if(fap_personal_grad_nm == ''){
			alert('대학원 명을 입력해 주시기 바랍니다.');
			return false;
		}
		
		if(fap_personal_grad_major == ''){
			alert('전공분야를 입력해 주시기 바랍니다.');
			return false;
		}
		return true;
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
			/* alert('이름을 입력해 주시기 바랍니다');
			selectAndFocus(input_nm); */
			alert('본인인증을 완료하여 주시기 바랍니다.');
			return false;
		}
		if (nm_regex.test(input_nm.val()) == false) {
			/* alert('이름은 한국어로 작성해 주시기 바랍니다');
			selectAndFocus(input_nm); */
			alert('본인인증을 완료하여 주시기 바랍니다.');
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
			/* alert('휴대폰 번호를 입력해 주시기 바랍니다'); */
			alert('본인인증을 완료하여 주시기 바랍니다.');
			return false;
		}
		if(phone_regex.test(phoneNum) == false){
	        /* alert("휴대폰 번호를 양식에 맞게 입력해 주세요."); */
	        alert('본인인증을 완료하여 주시기 바랍니다.');
	        return false;
		}
		
		$("#user_phone").val(phoneNum);
		return true;
	}

	/**
	 * 생년월일이 맞는가
	 */
	function isBirthCorrect() {
		var birth = $('#user_birth').val();
		if (birth == '') {
			alert('생년 월일은 필수 사항입니다.');
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
		if ($('input:radio[name="user_sex"]:checked').val() == '') {
			alert('성별을 선택해 주시기 바랍니다');
			/* alert('본인인증을 완료하여 주시기 바랍니다.'); */
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
	
	window.CallVerified = function() {
		alert('본인인증을 완료하였습니다.');
		$('#redMessage').html("본인인증을 완료하였습니다.");
	}

	var url = "https://www.mobile-ok.com/popup/common/hscert.jsp";   //운영
	// var url = "http://dev.mobile-ok.com/popup/common/hscert.jsp";  //개발
	var DRMOK_window;

	function openDRMOKWindow(){
		window.name = 'sendJsp';
		var url = "https://www.mobile-ok.com/popup/common/hscert.jsp";   //운영
		// var url = "http://dev.mobile-ok.com/popup/common/hscert.jsp";  //개발
		DRMOK_window = window.open(url+'?cpid=${cpId}&rtn_url=${rtn_url}&req_info=${encReqInfo}', 'DRMOKWindow', 'width=425,height=550,scrollbars=no,toolbar=no,location=no,directories=no,status=no' );
		DRMOK_window.focus();

		if(DRMOK_window == null){
			alert(" ※ 윈도우 XP SP2 또는 인터넷 익스플로러 7 사용자일 경우에는 \n    화면 상단에 있는 팝업 차단 알림줄을 클릭하여 팝업을 허용해 주시기 바랍니다. \n\n※ MSN,야후,구글 팝업 차단 툴바가 설치된 경우 팝업허용을 해주시기 바랍니다.");
		}
	}
	
</script>
<body ng-app="myapp" ng-controller="BBSController" id="fap_user_insert_body">
	
	<%@include file="user_menu.jsp"%>
	
	<form name="reqDRMOKForm" method="post">
        <input type="hidden" name="req_info" value = "${encReqInfo}">
		<input type="hidden" name="rtn_url" value = "#">
		<input type="hidden" name="cpid" value = "${cpId}">
		<input type="hidden" name="newpop" value = "Y">
	
		<div class="join-wrap" style="min-height: 100px;">
			<div id="subcontents" style="padding-bottom: 20px;">
				<div class="joinBox">
					<div class="join-policy">
						<div id="joinBtn">
							<input type="button" class="join-btn icon submitBtn" onclick="openDRMOKWindow()" value="본인인증">
						</div>
						<div>					
							<br><font id="redMessage" color="red">작성전에 먼저 본인 인증을 진행하여 주세요.</font>
						</div>
					</div>
				</div>
			</div>
		</div>
	
	</form>
	
	<form action="/fap/user/user_insert_form" method="post" onsubmit="return checkOnSubmit();">
	
	<input type="hidden" name="user_flag" value="A0100">
	<input type="hidden" name="user_state" value="A0200">
	<input type="hidden" id="checked_id" name="checked_id">
	
	<div class="join-wrap">
		<div id="subcontents" style="padding-top: 20px;">
			<div class="joinBox">
				<div class="jointt">
					<p class="jointxt1">
				       	 회원정보 입력  
					</p>
				</div>
				<div class="join-contents">
					<div class="joinBBS">
						<div class="joinBBS-row">
							<div class="joinlt">ID</div>
							<div class="joinrt">
								<input type="text" id="user_id" name="user_id">
								<button class="join_btn" type="button" onclick="checkIdIsDuplicated();">
									중복확인
								</button>
							</div>
						</div>
						<div class="joinBBS-row">
							<div class="joinlt">비밀번호</div>
							<div class="joinrt"><input type="password" id="user_pw" name="user_pw" placeholder="<spring:message code="fap.placholder.pw" />"></div>
						</div>
						<div class="joinBBS-row">
							<div class="joinlt">비밀번호 확인</div>
							<div class="joinrt"><input type="password" id="user_pw_check" placeholder="<spring:message code="fap.placholder.pw" />"></div>
						</div>
						<div class="joinBBS-row">
							<div class="joinlt">이름</div>
							<div class="joinrt"><input type="text" id="user_nm" name="user_nm" placeholder="<spring:message code="fap.placholder.name" />"></div>
						</div>
						<div class="joinBBS-row">
							<div class="joinlt">E-mail</div>
							<div class="joinrt">
								<input type="text" id="user_email" name="user_email" size="30">
								<button class="join_btn" type="button" onclick="checkEmailIsDuplicated();">
									중복확인
								</button>
							</div>
						</div>
						<div class="joinBBS-row">
							<div class="joinlt">생년월일</div>
							<div class="joinrt"><input type="text" id="user_birth" name=user_birth readonly="readonly"></div>
						</div>

						<div class="joinBBS-row radio-row">
							<div class="joinlt">성별</div>
							<div class="joinrt">
								<span class="bbs-radio sex-type">
									<label class="bbs-radio-label">
										<code value="A0000"></code>
									</label>
									<input type="radio" name="user_sex" id="sex_m" value="A0000" />
								</span>
								<span class="bbs-radio sex-type">
									<label class="bbs-radio-label">
										<code value="A0001"></code>
									</label>
									<input type="radio" name="user_sex" id="sex_f" value="A0001" />
								</span>
							</div>
						</div>

						<div class="joinBBS-row">
							<div class="joinlt">전화번호</div>
							<div class="joinrt">
								<input type="text" id="user_phone" name="user_phone" readonly="readonly">
								<!-- <button class="join_btn" type="button" onclick="openDRMOKWindow();">
									전화번호
								</button> -->
							</div>
						</div>
						<div class="joinBBS-row">
							<div class="joinlt">취업희망직무</div>
							<div class="joinrt">
								<input type="text" id="job_objective" name="fap_personal_user_job_objective" placeholder="(예. ICT, 기계전기전자분야, 일반사무, 통역, 관광/여객, 마케팅 등)">
							</div>
						</div>
						<div class="joinBBS-row">
							<div class="joinlt nl"><p>해외취업 연수과정<br> 참여 여부</p></div>
							<div class="BBS-dropdown" id="user_org">
								
							</div>
							<div class="joinrt-comment">
								* 선택시 하단에 입력창이 생성됩니다.
							</div>
						</div>
						<div class="joinBBS-row disnone course">
							<div class="joinlt">기관 및 과정명</div>
							<div class="joinrt">
								<input type="text" id="edu_course_nm" name="fap_personal_user_edu_course_nm" placeholder="(예. 기관명-과정명)">
							</div>
						</div>
						<div class="joinBBS-row">
							<div class="joinlt">최종학력</div>
							<div class="BBS-dropdown" id="edu_level">
								
							</div>
						</div>
						
						<!-- 학력 세부 정보 -->
						<div id="edu_detail">
							<div class="joinBBS-row">
								<div class="joinlt">고등학교 명</div>
								<div class="joinrt">
									<input type="text" id="fap_personal_hs_nm" name="fap_personal_hs_nm">
								</div>
							</div>
							
							<div class="joinBBS-row radio-row">
								<div class="joinlt">계열</div>
								<div class="joinrt">
									<span class="bbs-radio hs-field ck">
										<label class="bbs-radio-label">
											<code value="B3400"></code>
										</label>
										<input type="radio" id="field_mk" name="fap_personal_hs_field" id="fap_personal_hs_field" value="B3400" checked="checked"/>
									</span>
									<span class="bbs-radio hs-field">
										<label class="bbs-radio-label">
											<code value="B3401"></code>
										</label>
										<input type="radio" id="field_lk" name="fap_personal_hs_field" id="fap_personal_hs_field" value="B3401"/>
									</span>
									<span class="bbs-radio hs-field">
										<label class="bbs-radio-label">
											<code value="B3402"></code>
										</label>
										<input type="radio" id="field_sh" name="fap_personal_hs_field" id="fap_personal_hs_field" value="B3402"/>
									</span>
								</div>
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
				<div id="joinBtn">
					<input type="submit" class="join-btn icon submitBtn" value="회원가입">
				</div>
			</div>
		</div>
	</div>
	
	</form>
	
	<%@include file="../common_footer_fap.jsp"%>

</body>
</html>
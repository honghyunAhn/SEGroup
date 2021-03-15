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
<script src="<c:url value="/resources/segroup/js/datepicker.js" />"></script>	

<link rel="stylesheet" type="text/css" href="<c:url value="/resources/segroup/society/fap/css/default.css" />" />
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/segroup/society/fap/css/popModal.css" />" />
<script type="text/javascript">

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
		content += '		<li class="option-type">';
		content += '			<button type="button" ng-click="school_event($event)"><code value="B3300"></code></button>';
		content += '		</li>';
		content += '		<li class="option-type">';
		content += '			<button type="button" ng-click="school_event($event)"><code value="B3304"></code></button>';
		content += '		</li>';
		content += '		<li class="option-type">';
		content += '			<button type="button" ng-click="school_event($event)"><code value="B3301"></code></button>';
		content += '		</li>';
		content += '		<li class="option-type">';
		content += '			<button type="button" ng-click="school_event($event)"><code value="B3305"></code></button>';
		content += '		</li>';
		content += '		<li class="option-type">';
		content += '			<button type="button" ng-click="school_event($event)"><code value="B3302"></code></button>';
		content += '		</li>';
		content += '		<li class="option-type">';
		content += '			<button type="button" ng-click="school_event($event)"><code value="B3306"></code></button>';
		content += '		</li>';
		content += '		<li class="option-type">';
		content += '			<button type="button" ng-click="school_event($event)"><code value="B3303"></code></button>';
		content += '		</li>';
		content += '	</ul>';
		content += '</div>';

		$('#edu_level').append($compile(content)($scope));
		content = '';
		// [end] 최종학력 불러오기 끝
		
		$scope.school_event = function($event) {
			var edu_level = '';
			if($(event.target).is(':button')){
				edu_level = $(event.target).find('span').attr('value');
			}else{
				edu_level = $(event.target).attr('value');
			}
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
	
	var blur_flag = true;
	
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

		});
	}
	
	/**
	 * 서브밋하기 전에 데이터를 체크한다
	 */
	function checkOnSubmit() {
		var job_objective = $("#job_objective").val();
		if(job_objective == ''){
			alert("취업희망직무를 입력해 주시기 바랍니다.");
			return false;
		}
		if(job_objective.length > 50){
			alert("취업희망직무는 최대 50글자 까지 입력 가능합니다.");
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
	
	/**
	 * 엘리먼트를 선택한다
	 */
	function selectAndFocus(element) {
		element.select();
		element.focus();
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
	
</script>
<body ng-app="myapp" ng-controller="BBSController">
	
	<sec:authorize access="hasAnyRole('ROLE_A0100', 'ROLE_A0101', 'ROLE_A0102', 'ROLE_A0106', 'ROLE_A0108')">
		<sec:authentication property="details.user" var="detail" />
	</sec:authorize>
	
	<form action="/fap/user/user_insert_school" method="post" onsubmit="return checkOnSubmit();">
	
	<input type="hidden" id="user_id" name="user_id" value="${user_id}">
	
	<div class="join-wrap">
		<div id="subcontents">
			<div class="joinBox">
				<div class="jointt">
					<p class="jointxt1">
				       	학교정보 입력<br>
				       	<h2>등록된 학교 정보가 없으므로 입력해주십시오.</h2>
					</p>
				</div>
				<div class="join-contents">
					<div class="joinBBS">
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
					<div id="joinBtn">
						<input type="submit" class="join-btn icon submitBtn" value="정보입력">
					</div>
				</div>
			</div>
		</div>
	</div>
	
	</form>

</body>
</html>
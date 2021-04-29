<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Bridge Job Fair</title>
<script src="<c:url value="/resources/segroup/js/jquery-3.1.1.js" />"></script>
<script src="<c:url value="/resources/segroup/js/angular.min.js" />"></script>
<script src="<c:url value="/resources/segroup/society/fap/js/layer.js" />"></script>
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/segroup/society/fap/css/default.css" />" />
<link type="text/css" rel="stylesheet" href="<c:url value="/resources/segroup/society/fap/css/layer.css" />" media="" />
<script type="text/javascript">
var myApp = angular.module('myapp', []);
myApp.controller('TokyoFairController',['$scope','$compile', '$http', function($scope, $compile, $http) {
	
	$("#tokyofair-interview-select").focus(function(){
		$scope.previous = $(this).val();
	}).change(function(){
		$(this).blur();
		
		if(confirm("<spring:message code='fap.tokyofair.screening.insert.search_interview_tx_warn' />")){
			$(".personal-interview-wrap").empty();
		}else{
			$(this).val($scope.previous);
			return false;
		}
		
	});
	
	$scope.select_interview_type = function(){
		var target = $(".personal-select option:selected").val();
		var fap_job_ad_seq = $("#fap_job_ad_seq").val();
		
		if(target == 'E0600' || target == 'E0602'){
			
			$http({
				method : 'POST',
				url : '/fap/company/tokyofair_screening_subject_search',
				params : {
					fap_job_ad_seq: fap_job_ad_seq
				},
				headers : {
					"AJAX" : true
				}
			}).then(function successCallback(response) {
				
				$(".checkbox-wrap").empty();
				var context = '';
				$.each(response.data, function(index, item){
					context +='<span class="check-name ck">';
					context +='<label class="check-name-label">'+item.fap_resume_nm+'('+item.fap_resume_birth+')</label>';
					context +='<input type="checkbox" class="user_check" name="scrUser.scrUserList['+index+'].fap_tokyofair_scr_resume_seq" value="'+item.fap_resume_seq+'">';
					context +='</span>';
				});
				$(".checkbox-wrap").html($compile(context)($scope));
				
				$('.personal-interview-row').each(function(index,item){
					var offsetHeight = $(this).find(".right-side").outerHeight();
					$(this).find(".left-side").outerHeight(offsetHeight);
				});
				
				$(".user_check").each(function(index,item){
					$(this).prop("checked",true);
				});
				
				$(".check-name").off("click").on('click',function(){
					var target = $(".personal-select option:selected").val();
					if(target == 'E0600' || target == 'E0602'){
						$(".layer-message").html('<spring:message code="fap.tokyofair.screening.insert.interview_select_message" javaScriptEscape="true" />');
						layer_popup("#tokyofair-layer");
					}else{
						$(this).toggleClass("ck");
						if($(this).hasClass("ck")){
							$(this).find("input").prop("checked",true);
						}else{
							$(this).find("input").prop("checked",false);
						}
					}
				});
				
			}, function errorCallback(response) {
				if(response.status == 403){
					alert('<spring:message code="com.login.ajaxSesstion" javaScriptEscape="true" />');
					location.href = "/fap/company/company_login";
				}
			});
			
		}else{
			
			$http({
				method : 'POST',
				url : '/fap/company/tokyofair_screening_subject_search_two',
				params : {
					fap_job_ad_seq: fap_job_ad_seq
				},
				headers : {
					"AJAX" : true
				}
			}).then(function successCallback(response) {
				
				$(".checkbox-wrap").empty();
				var context = '';
				$.each(response.data, function(index, item){
					context +='<span class="check-name ck">';
					context +='<label class="check-name-label">'+item.fap_resume_nm+'('+item.fap_resume_birth+')</label>';
					context +='<input type="checkbox" class="user_check" name="scrUser.scrUserList['+index+'].fap_tokyofair_scr_resume_seq" value="'+item.fap_resume_seq+'">';
					context +='</span>';
				});
				$(".checkbox-wrap").html($compile(context)($scope));
				
				$('.personal-interview-row').each(function(index,item){
					var offsetHeight = $(this).find(".right-side").outerHeight();
					$(this).find(".left-side").outerHeight(offsetHeight);
				});
				
				$(".user_check").each(function(index,item){
					$(this).prop("checked",true);
				});
				
				$(".check-name").off("click").on('click',function(){
					var target = $(".personal-select option:selected").val();
					if(target == 'E0600' || target == 'E0602'){
						$(".layer-message").html('<spring:message code="fap.tokyofair.screening.insert.interview_select_message" javaScriptEscape="true" />');
						layer_popup("#tokyofair-layer");
					}else{
						$(this).toggleClass("ck");
						if($(this).hasClass("ck")){
							$(this).find("input").prop("checked",true);
						}else{
							$(this).find("input").prop("checked",false);
						}
					}
				});
				
			}, function errorCallback(response) {
				if(response.status == 403){
					alert('<spring:message code="com.login.ajaxSesstion" javaScriptEscape="true" />');
					location.href = "/fap/company/company_login";
				}
			});
			
		}
	}
	
	$scope.drawInterviewForm = function(){
		/*var count = $("#count").val();
		
		 if(count >= 3){
			$(".layer-message").html('<spring:message code="fap.tokyofair.screening.insert.warn" />');
			layer_popup("#tokyofair-layer");
			return;
		} */
		var fap_job_ad_seq = $("#fap_job_ad_seq").val();
		
		$http({
			method : 'POST',
			url : '/fap/company/tokyofair_screening_subject_search',
			params : {
				fap_job_ad_seq: fap_job_ad_seq
			},
			headers : {
				"AJAX" : true
			}
		}).then(function successCallback(response) {
			var interviewType = $("#tokyofair-interview-select").val();
			
			var context = '';
			context +='<div class="personal-interview-row">';
			context +='<div class="left-side">';
			context +='<p class="title">';
			context +='<spring:message code="fap.tokyofair.screening.insert.interview_title" />';
			context +='<span class="title-warn"><spring:message code="fap.tokyofair.screening.insert.interview_title_warn" /></span>';
			context +='</p>';
			context +='</div>';
			context +='<div class="right-side">';
			context +='<input type="text" name="fap_tokyofair_screening_nm" id="fap_tokyofair_screening_nm" class="context" maxlength="30" placeholder="30<spring:message code="fap.placeholder.limit_characters" />">';
			context +='</div>';
			context +='</div>';
			context +='<div class="personal-interview-row">';
			context +='<div class="left-side">';
			context +='<p class="title single-row">';
			context +='<spring:message code="fap.tokyofair.screening.insert.interview_type" />';
			context +='</p>';
			context +='</div>';
			context +='<div class="right-side">';
			context +='<div>';
			context +='<select class="personal-select" name="fap_tokyofair_screening_type" id="fap_tokyofair_screening_type" onchange="angular.element(this).scope().select_interview_type()">';
			context +='<option selectcode value="E0600"></option>';
			context +='<option selectcode value="E0601"></option>';
			context +='<option selectcode value="E0602"></option>';
			context +='</select>';
			context +='</div>';
			context +='<div class="right-side-warn">';
			context +='<span class="select-warn">';
			context +='<spring:message code="fap.tokyofair.screening.insert.interview_personal_type_warn" />';
			context +='</span>';
			context +='</div>';
			context +='</div>';
			context +='</div>';
			context +='<div class="personal-interview-row">';
			context +='<div class="left-side left-check">';
			context +='<p class="title">';
			context +='<spring:message code="fap.tokyofair.screening.insert.interview_select" />';
			context +='<span class="title-warn"><spring:message code="fap.tokyofair.screening.insert.interview_select_warn" /></span>';
			context +='</p>';
			context +='</div>';
			context +='<div class="right-side right-check">';
			context +='<div class="checkbox-wrap">';
			
			$.each(response.data, function(index, item){
				context +='<span class="check-name ck">';
				context +='<label class="check-name-label">'+item.fap_resume_nm+'('+item.fap_resume_birth+')</label>';
				context +='<input type="checkbox" class="user_check" name="scrUser.scrUserList['+index+'].fap_tokyofair_scr_resume_seq" value="'+item.fap_resume_seq+'">';
				context +='</span>';
			});
			context +='</div>';
			context +='</div>';
			context +='</div>';
			if(interviewType == 'E0501'){
				context +='<div class="personal-interview-row">';
				context +='<div class="left-side">';
				context +='<p class="title">';
				context +='<spring:message code="fap.tokyofair.screening.insert.interview_group_num" />';
				context +='</p>';
				context +='</div>';
				context +='<div class="right-side">';
				context +='<input type="text" name="fap_tokyofair_screening_user_num" id="fap_tokyofair_screening_user_num" class="context" ng-model="interviewer_num" maxlength="2" blur-currency>';
				context +='<span class="placeTx">名</span>';
				context +='</div>';
				context +='</div>';
			}
			context +='<div class="personal-interview-row">';
			context +='<div class="left-side">';
			context +='<p class="title">';
			context +='<spring:message code="fap.tokyofair.screening.insert.interview_time" />';
			context +='</p>';
			context +='</div>';
			context +='<div class="right-side">';
			context +='<select class="personal-select" name="fap_tokyofair_screening_time" id="fap_tokyofair_screening_time">';
			context +='<option value="10">10<spring:message code="fap.tokyofair.screening.insert.interview_time_tx" /></option>';
			context +='<option value="20">20<spring:message code="fap.tokyofair.screening.insert.interview_time_tx" /></option>';
			context +='<option value="30">30<spring:message code="fap.tokyofair.screening.insert.interview_time_tx" /></option>';
			context +='<option value="40">40<spring:message code="fap.tokyofair.screening.insert.interview_time_tx" /></option>';
			context +='<option value="50">50<spring:message code="fap.tokyofair.screening.insert.interview_time_tx" /></option>';
			context +='<option value="60">60<spring:message code="fap.tokyofair.screening.insert.interview_time_tx" /></option>';
			context +='<option value="70">70<spring:message code="fap.tokyofair.screening.insert.interview_time_tx" /></option>';
			context +='<option value="80">80<spring:message code="fap.tokyofair.screening.insert.interview_time_tx" /></option>';
			context +='<option value="90">90<spring:message code="fap.tokyofair.screening.insert.interview_time_tx" /></option>';
			context +='</select>';
			context +='<span class="select-warn">';
			context +='<spring:message code="fap.tokyofair.screening.insert.interview_time_warn" />';
			context +='</span>';
			context +='</div>';
			context +='</div>';
			context +='<div class="personal-interview-row">';
			context +='<div class="left-side">';
			context +='<p class="title">';
			context +='<spring:message code="fap.tokyofair.screening.insert.interviewer_num" />';
			context +='</p>';
			context +='</div>';
			context +='<div class="right-side">';
			context +='<input type="text" name="fap_tokyofair_screening_comp_num" id="fap_tokyofair_screening_comp_num" class="context" ng-model="interviewer_num" maxlength="2" blur-currency>';
			context +='<span class="placeTx">名</span>';
			context +='</div>';
			context +='</div>';
			context +='<div class="personal-interview-row">';
			context +='<div class="left-side">';
			context +='<p class="title">';
			context +='<spring:message code="fap.tokyofair.screening.insert.interview_admin_request" />';
			context +='</p>';
			context +='</div>';
			context +='<div class="right-side">';
			context +='<textarea class="longText" name="fap_tokyofair_screening_admin_req" maxlength="500" placeholder="500<spring:message code="fap.placeholder.limit_characters" />"></textarea>';
			context +='</div>';
			context +='</div>';
			context +='<div class="personal-interview-row">';
			context +='<div class="left-side">';
			context +='<p class="title">';
			context +='<spring:message code="fap.tokyofair.screening.insert.interview_applier_request" />';
			context +='</p>';
			context +='</div>';
			context +='<div class="right-side">';
			context +='<textarea class="longText" name="fap_tokyofair_screening_user_req" maxlength="500" placeholder="500<spring:message code="fap.placeholder.limit_characters" />"></textarea>';
			context +='</div>';
			context +='</div>';
			context +='<div class="personal-interview-row">';
			context +='<span class="tokyofair-btn blue mg10" id="insert-btn"><spring:message code="fap.tokyofair.screening.insert.insert_btn" /></span>';
			context +='<span class="tokyofair-btn green mg10" id="list-btn"><spring:message code="fap.tokyofair.screening.insert.list_btn" /></span>';
			context +='</div>';
			$(".personal-interview-wrap").html($compile(context)($scope));
			
			realTimeValidation();
			
			$('.personal-interview-row').each(function(index,item){
				var offsetHeight = $(this).find(".right-side").outerHeight();
				$(this).find(".left-side").outerHeight(offsetHeight);
			});
			
			$(".user_check").each(function(index,item){
				$(this).prop("checked",true);
			});
			
			$(".check-name").off('click').on('click',function(){
				var target = $(".personal-select option:selected").val();
				if(target == 'E0600' || target == 'E0602'){
					$(".layer-message").html('<spring:message code="fap.tokyofair.screening.insert.interview_select_message" javaScriptEscape="true" />');
					layer_popup("#tokyofair-layer");
				}else{
					$(this).toggleClass("ck");
					if($(this).hasClass("ck")){
						$(this).find("input").prop("checked",true);
					}else{
						$(this).find("input").prop("checked",false);
					}
				}
			});
			
			$("#insert-btn").off("click").on("click", function(){
				//유효성 검사 필요
				var interview_type = $("#tokyofair-interview-select").val();			//E0500 개별 , E0501 그룹
				var fap_tokyofair_screening_nm = $("#fap_tokyofair_screening_nm").val();			//전형 이름
				var user_check_count = $(".check-name.ck").length;			// 면접 대상자 수
				var fap_tokyofair_screening_user_num = $("#fap_tokyofair_screening_user_num").val();			// 그룹별 인원 수
				var fap_tokyofair_screening_comp_num = $("#fap_tokyofair_screening_comp_num").val();		// 면접관 수
				
				if(fap_tokyofair_screening_nm == '' || fap_tokyofair_screening_nm.length == 0){
					$(".layer-message").html('<spring:message code="fap.tokyofair.screening.insert.interview_title_message" />');
					layer_popup("#tokyofair-layer");
					$("#fap_tokyofair_screening_nm").focus();
					return false;
				}else if(user_check_count == 0){
					$(".layer-message").html('<spring:message code="fap.tokyofair.screening.insert.interview_type_message" />');
					layer_popup("#tokyofair-layer");
					$(".checkbox-wrap").focus();
					return false;
				}else if(interview_type == 'E0501' && fap_tokyofair_screening_user_num == 0){
					$(".layer-message").html('<spring:message code="fap.tokyofair.screening.insert.interview_group_num_message" />');
					layer_popup("#tokyofair-layer");
					$("#fap_tokyofair_screening_user_num").focus();
					return false;
				}else if(fap_tokyofair_screening_comp_num == 0){
					$(".layer-message").html('<spring:message code="fap.tokyofair.screening.insert.interviewer_num_message" />');
					layer_popup("#tokyofair-layer");
					$("#fap_tokyofair_screening_comp_num").focus();
					return false;
				}
				
				$("#insertForm").submit();
			});
			
			$("#list-btn").off("click").on("click", function(){
				location.href = "/fap/company/company_tokyofair_screening_management";
			});
			
		}, function errorCallback(response) {
			if(response.status == 403){
				alert('<spring:message code="com.login.ajaxSesstion" javaScriptEscape="true" />');
				location.href = "/fap/company/company_login";
			}
		});
		
		
	}
	
}]);
myApp.directive('selectcode', ['$http',function($http){
	return {
		restrict: "A",
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
		,template: "<option>{{filterParams}}</option>"
	}
}]);


myApp.directive('code', [ '$http', function($http) {
	return {
		restrict : "E",
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
		template : "<span>{{filterParams}}</span>"
	}
}]);

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
}]);

function realTimeValidation(){
	$('input[type="text"]').off('change').change(function(){
	        this.value = $.trim(this.value);
	});
	//모든 textarea trim
	$('textarea').off('change').change(function(){
	        this.value = $.trim(this.value);
	});
	$("input[type='text']").off('keyup').keyup( function(){
		//모든 input text 글자수 제한
	    if ($(this).val().length >= $(this).attr('maxlength')) {
	        alert('<spring:message code="fap.err.over_maxlength" javaScriptEscape="true" />');
	        $(this).val($(this).val().substr(0, $(this).attr('maxlength')));
	    }
	});
	$('textarea').off('keyup').keyup( function() {
			if($(this).val().length >= $(this).attr('maxlength')) {
				alert('<spring:message code="fap.err.over_maxlength" javaScriptEscape="true" />');
				$(this).val($(this).val().substring(0, $(this).attr('maxlength')));
			}
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
	$("textarea").off('keyup').keyup( function(){
		//모든 input 태그 제한
		var disallow_char = /(<([^>]+)>)/ig;
		var tempValue = $(this).val();
	    if (disallow_char.test(tempValue)) {
	        alert('<spring:message code="fap.err.tag_insert" javaScriptEscape="true" />');
	        $(this).val(tempValue.replace(disallow_char,""));
	    }
	});

}
</script>
</head>
<body ng-app="myapp" ng-controller="TokyoFairController">
<%@include file="company_menu.jsp"%>
<form action="/fap/company/company_tokyofair_screening_insert" method="post" id="insertForm">
	<div class="join-wrap">
		<div id="subcontents">
			<h1><spring:message code="fap.tokyofair.screening.insert.title" /></h1>
			<h6></h6>	
			<div id="nowBox">
				<div class="nowfind" id="select-box-layout">
					<h5><spring:message code="fap.tokyofair.screening.insert.search_interview_tx" /></h5>
					<div class="tokyofair-btn-wrap screening-insert">
						<span class="tokyofair-btn green sm" id="interview-btn" ng-click="drawInterviewForm()"><spring:message code="fap.tokyofair.screening.insert.interview_btn" /></span>
					</div>
					<div class="tokyofair-interview-wrap">
						<select id="tokyofair-interview-select" name="fap_tokyofair_screening_gb">
							<option selectcode value="E0500"></option>
							<option selectcode value="E0501"></option>
						</select>
					</div>
				</div>
				
				<div class="personal-interview-wrap">
				</div>
				
			</div>
		</div>
	</div>
	<input type="hidden" id="fap_job_ad_seq" name="fap_job_ad_seq" value="${fap_job_ad_seq }">
	<input type="hidden" id="fap_comp_id" name="fap_comp_id" value="${fap_comp_id }">
	<input type="hidden" id="count" value="${count}">
</form>
<%@include file="../common_footer_fap.jsp"%>

<div class="dim-layer">
    <div class="dimBg"></div>
    <div id="tokyofair-layer" class="pop-layer">
        <div class="pop-container">
            <div class="pop-conts">
            	<div class="layer-header">
            		<h2>
            			<spring:message code="fap.tokyofair.screening.insert.title" />
            		</h2>
            	</div>
            	<div class="layer-message">
            	
            	</div>
                <!--content //-->
                <div class="btn-r">
                    <a href="#" class="btn-layerClose">Close</a>
                </div>
                <!--// content-->
            </div>
        </div>
    </div>
</div>
</body>
</html>
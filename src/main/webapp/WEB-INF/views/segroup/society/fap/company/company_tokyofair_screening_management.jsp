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
	/* ------------------------- 파라미터 scope에 담는 구역 -------------------------- */
	//select 박스 그리는데 필요한 잡페어 리스트
	var jobfair_map = JSON.parse('${jobfair_map}');
	
	//잡페어 리스트 default값 선택해주기 위한 변수
	$scope.fap_jobfair_divide_seq = '${fap_jobfair_divide_seq}';
	$scope.fap_jobfair_seq = '${fap_jobfair_seq}';
	/* ------------------------- 파라미터 scope에 담는 구역 끝 -------------------------- */
	
	/* --------------------------- [start] jobfair selectbox 그리기 시작 -------------------------- */
	var context = '';
	context +=	'<select onchange="angular.element(this).scope().select_change(1)" id="select_jobfair" ng-model="::fap_jobfair_seq">';
	if($scope.fap_jobfair_seq == 0){
	context +=		'<option value= "0" hidden><spring:message code="fap.tokyofair.screening.management.search_jobfair" /></option>';
	}
	//진행중인 잡페어
	context +=		'<optgroup label="<spring:message code="fap.jobfair.jobfair_on_air" />" flag="1">';
	jobfair_map.jobfair_list_now.forEach(function (jobfair, index) {
		context +=	'<option value="' + jobfair.fap_jobfair_seq + '">' + jobfair.fap_jobfair_title + '</option>';
	});
	context +=		'</optgroup>';
	//예정된 잡페어
	context +=		'<optgroup label="<spring:message code="fap.jobad.jobfair_planned" />" flag="2">';
	jobfair_map.jobfair_list_before.forEach(function (jobfair, index) {
		context +=	'<option value="' + jobfair.fap_jobfair_seq + '">' + jobfair.fap_jobfair_title + '</option>';
	});
	//종료된 잡페어
	context +=		'</optgroup>';
	context +=		'<optgroup label="<spring:message code="fap.jobfair.closed_jobfair" />" flag="3">';
	jobfair_map.jobfair_list_after.forEach(function (jobfair, index) {
		context +=	'<option value="' + jobfair.fap_jobfair_seq + '">' + jobfair.fap_jobfair_title + '</option>';
	});
	context +=		'</optgroup>';
	context +=	'</select>';
	context+='&nbsp;';
	context +=	'<select onchange="angular.element(this).scope().select_change(2)" id="select_jobfair_detail" disabled="disabled">';
	context +=		'<option value="" id="jobfair_detail_hidden" hidden><spring:message code="fap.tokyofair.screening.management.search_jobfair_divide" /></option>';
	context +=	'</select>';
	context += '<div class="tokyofair-job-ad-select">';
	context +=	'<select onchange="angular.element(this).scope().select_change(3)" id="select_job_ad_detail" disabled="disabled">';
	context +=		'<option value="" id="job_ad_detail_hidden" hidden><spring:message code="fap.tokyofair.screening.management.search_job_ad" /></option>';
	context +=	'</select>';
	context += '</div>';
	$('#select-box-layout').append($compile(context)($scope));
	$('#select_jobfair_detail').attr('disabled', false);
	$('#select_job_ad_detail').attr('disabled', false);
	
	$http({
		method : 'POST',
		url : '/fap/company_roadmap/select_jobfair_divide',
		responseType : 'text',
		params : {
			fap_jobfair_seq: '${fap_jobfair_seq}'
		},
		headers : {
			"AJAX" : true
		}
	}).then(function successCallback(response) {
		//jobfair_detail에 option 추가
		for(var i in response.data){
			$('#select_jobfair_detail').append($compile('<option selectcode value="' 
					+ response.data[i].fap_jobfair_divide_gb + '" seq="' + response.data[i].fap_jobfair_divide_seq + '"></option>')($scope));
		}
	}, function errorCallback(response) {
		console.log(response);
		if(response.status == 403){
			alert('<spring:message code="com.login.ajaxSesstion" javaScriptEscape="true" />');
			location.href = "/fap/company/company_login";
		}
	});
	
	$scope.select_change = function(flag){
		//flag(1:jobfair select box 선택, 2:divide select box 선택)
		if(flag == 1){
			$(".screening-list-wrap").empty();
			$('#jobfair_detail_hidden').prop('selected', true);
			$('#select_jobfair_detail').html('<option value="" id="jobfair_detail_hidden" hidden><spring:message code="fap.tokyofair.screening.management.search_jobfair_divide" /></option>');
			$('#select_jobfair_detail').attr('disabled', false);
			$('#job_ad_detail_hidden').prop('selected', true);
			$('#select_job_ad_detail').html('<option value="" id="select_job_ad_detail" hidden><spring:message code="fap.tokyofair.screening.management.search_job_ad" /></option>');
			$('#select_job_ad_detail').attr('disabled', false);
			
			$scope.fap_jobfair_seq = $('#select_jobfair option:selected').val();
			
			$http({
				method : 'POST',
				url : '/fap/company_roadmap/select_jobfair_divide',
				responseType : 'text',
				params : {
					fap_jobfair_seq: $('#select_jobfair option:selected').val()
				},
				headers : {
					"AJAX" : true
				}
			}).then(function successCallback(response) {
				for(var i in response.data){
					$('#select_jobfair_detail').append($compile('<option selectcode value="' 
							+ response.data[i].fap_jobfair_divide_gb + '" seq="' + response.data[i].fap_jobfair_divide_seq + '"></option>')($scope));
				}
				
			}, function errorCallback(response) {
				console.log(response);
				if(response.status == 403){
					alert('<spring:message code="com.login.ajaxSesstion" javaScriptEscape="true" />');
					location.href = "/fap/company/company_login";
				}
			});
			
		}else if(flag ==2){
			$(".screening-list-wrap").empty();
			$('#job_ad_detail_hidden').prop('selected', true);
			$('#select_job_ad_detail').html('<option value="" id="select_job_ad_detail" hidden><spring:message code="fap.tokyofair.screening.management.search_job_ad" /></option>');
			$('#select_job_ad_detail').attr('disabled', false);
			//셀렉트 박스 변경될 때 채용공고 처음 그려주는 곳(체크)
			$scope.fap_jobfair_divide_seq = $('#select_jobfair_detail option:selected').attr('seq');
			
			$http({
				method : 'POST',
				url : '/fap/company_roadmap/select_job_ad_title_list',
				responseType : 'text',
				params : {
					fap_jobfair_divide_seq: $scope.fap_jobfair_divide_seq
				},
				headers : {
					"AJAX" : true
				}
			}).then(function successCallback(response) {
				for(var i in response.data){
					$('#select_job_ad_detail').append($compile('<option value="'+response.data[i].fap_job_ad_seq+'">'+response.data[i].fap_job_ad_title+'</option>')($scope));
				}
				
			}, function errorCallback(response) {
				console.log(response);
				if(response.status == 403){
					alert('<spring:message code="com.login.ajaxSesstion" javaScriptEscape="true" />');
					location.href = "/fap/company/company_login";
				}
			});
			
		}else if(flag ==3){
			var fap_job_ad_seq = $("#select_job_ad_detail option:selected").val();
			
			$http({
				method : 'POST',
				url : '/fap/company/tokyofair_screening_search',
				params : {
					fap_job_ad_seq: fap_job_ad_seq
				},
				headers : {
					"AJAX" : true
				}
			}).then(function successCallback(response) {
				
				if(response.data.length > 0){
					var context = '<table class="list-table">'
					context += '<thead>';
					context += '<tr>';
					context += '<th>No</th>';
					context += '<th><spring:message code="fap.tokyofair.screening.management.screening_type" /></th>';
					context += '<th><spring:message code="fap.tokyofair.screening.management.screening_ins_dt" /></th>';
					context += '<th><spring:message code="fap.tokyofair.screening.management.screening_gb" /></th>';
					context += '</tr>';
					context += '</thead>';
					context += '<tbody>';
					$.each(response.data, function(index,item){
						context += '<tr>';
						context += '<td>'+(index+1)+'</td>';
						context += '<td><span class="updateSpan pointer underline" seq="'+item.fap_tokyofair_screening_seq+'">'+item.fap_tokyofair_screening_nm+'</span></td>';
						context += '<td>'+item.fap_tokyofair_screening_ins_dt+'</td>';
						context += '<td><code value="'+item.fap_tokyofair_screening_sch_gb+'"></code></td>';
						context += '</tr>';
					});
					context += '</tbody>';
					context += '</table>';
					
					$(".screening-list-wrap").html($compile(context)($scope));
					
					$(".updateSpan").off("click").on("click",function(){
						var fap_tokyofair_screening_seq = $(this).attr("seq");
						location.href = "/fap/company/company_tokyofair_screening_update_form?fap_tokyofair_screening_seq="+fap_tokyofair_screening_seq;
					});
					
				}else{
					var context = '<div class="list-empty">';
					context += '<p>';
					context += '<spring:message code="fap.tokyofair.screening.search_form.nothing" />';
					context += '</p>';
					context += '</div>';
					
					$(".screening-list-wrap").html(context);
				}
				
			}, function errorCallback(response) {
				console.log(response);
				if(response.status == 403){
					alert('<spring:message code="com.login.ajaxSesstion" javaScriptEscape="true" />');
					location.href = "/fap/company/company_login";
				}
			});
			
		}
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

$(function(){
	
	$("#screening-btn").on("click",function(){
		var fap_jobfair_divide_seq = $('#select_jobfair_detail option:selected').attr('seq');
		
		if(typeof fap_jobfair_divide_seq == "undefined"){
			$(".layer-message").html('<spring:message code="fap.tokyofair.screening.management.err1" />');
			layer_popup("#tokyofair-layer");
		}else{
			$.ajax({
				beforeSend: function(xhr) {
				     xhr.setRequestHeader("AJAX", true);
				},
				url : '/fap/company/company_tokyofair_screening_date_check',
				type : 'post',
				data : {
					fap_jobfair_divide_seq : fap_jobfair_divide_seq
				},
				success : function(response) {
					if(response == 0){
						$(".layer-message").html('<spring:message code="fap.tokyofair.screening.management.err2" />');
						layer_popup("#tokyofair-layer");
					}else{
						var fap_job_ad_seq = $("#select_job_ad_detail option:selected").val();
						if(typeof fap_job_ad_seq == "undefined" || fap_job_ad_seq == ''){
							$(".layer-message").html('<spring:message code="fap.tokyofair.screening.management.err3" />');
							layer_popup("#tokyofair-layer");					
						}else{
							location.href = "/fap/company/company_tokyofair_screening_insert_form?fap_job_ad_seq="+fap_job_ad_seq;
						}
					}
				},
				error : function(response){
					console.log(response);
					if(response.status == 403){
						alert('<spring:message code="com.login.ajaxSesstion" javaScriptEscape="true" />');
						location.href = "/fap/company/company_login";
					}
				}
			});
		}
		
	});
	
	$("#schedule-btn").on("click",function(){
		var fap_jobfair_divide_seq = $('#select_jobfair_detail option:selected').attr('seq');
		
		if(typeof fap_jobfair_divide_seq == "undefined"){
			$(".layer-message").html('<spring:message code="fap.tokyofair.screening.management.err1" />');
			layer_popup("#tokyofair-layer");
		}else{
			$.ajax({
				beforeSend: function(xhr) {
				     xhr.setRequestHeader("AJAX", true);
				},
				url : '/fap/company/company_tokyofair_screening_date_check',
				type : 'post',
				data : {
					fap_jobfair_divide_seq : fap_jobfair_divide_seq
				},
				success : function(response) {
					if(response == 0){
						$(".layer-message").html('<spring:message code="fap.tokyofair.screening.management.err2" />');
						layer_popup("#tokyofair-layer");
					}else{
						var fap_job_ad_seq = $("#select_job_ad_detail option:selected").val();
						if(typeof fap_job_ad_seq == "undefined" || fap_job_ad_seq == ''){
							$(".layer-message").html('<spring:message code="fap.tokyofair.screening.management.err3" />');
							layer_popup("#tokyofair-layer");					
						}else{
							location.href = "/fap/company/company_tokyofair_schedule_management?fap_job_ad_seq="+fap_job_ad_seq+"&fap_jobfair_divide_seq="+fap_jobfair_divide_seq;
						}
					}
				},
				error : function(response){
					console.log(response);
					if(response.status == 403){
						alert('<spring:message code="com.login.ajaxSesstion" javaScriptEscape="true" />');
						location.href = "/fap/company/company_login";
					}
				}
			});
		}
	});
	
	$("#schedule-check-btn").on("click",function(){
		var fap_jobfair_divide_seq = $('#select_jobfair_detail option:selected').attr('seq');
		if(typeof fap_jobfair_divide_seq == "undefined"){
			$(".layer-message").html('<spring:message code="fap.tokyofair.screening.management.err1" />');
			layer_popup("#tokyofair-layer");
		}else{
			
			$.ajax({
				beforeSend: function(xhr) {
				     xhr.setRequestHeader("AJAX", true);
				},
				url : '/fap/company/company_tokyofair_screening_date_check',
				type : 'post',
				data : {
					fap_jobfair_divide_seq : fap_jobfair_divide_seq
				},
				success : function(response) {
					if(response == 0){
						$(".layer-message").html('<spring:message code="fap.tokyofair.screening.management.err2" />');
						layer_popup("#tokyofair-layer");
					}else{
						var fap_job_ad_seq = $("#select_job_ad_detail option:selected").val();
						if(typeof fap_job_ad_seq == "undefined" || fap_job_ad_seq == ''){
							$(".layer-message").html('<spring:message code="fap.tokyofair.screening.management.err3" />');
							layer_popup("#tokyofair-layer");					
						}else{
							location.href = "/fap/company/company_tokyofair_screening_search_form?fap_jobfair_divide_seq="+fap_jobfair_divide_seq;
						}
					}
				},
				error : function(response){
					console.log(response);
					if(response.status == 403){
						alert('<spring:message code="com.login.ajaxSesstion" javaScriptEscape="true" />');
						location.href = "/fap/company/company_login";
					}
				}
			});
			
		}
		
	});
})
</script>
</head>
<body ng-app="myapp" ng-controller="TokyoFairController">
<%@include file="company_menu.jsp"%>
<div class="join-wrap">
	<div id="subcontents">
		<h1><spring:message code="fap.tokyofair.screening.management.title" /></h1>
		<h6></h6>	
		<div id="nowBox">
			<div class="nowfind" id="select-box-layout">
				<h5><spring:message code="fap.tokyofair.screening.management.search_jobfair_tx" /></h5>
				<div class="tokyofair-btn-wrap">
					<span class="tokyofair-btn green" id="screening-btn"><spring:message code="fap.tokyofair.screening.management.screening_btn" /></span>
					<span class="tokyofair-btn blue" id="schedule-btn"><spring:message code="fap.tokyofair.screening.management.schedule_btn" /></span>
					<span class="tokyofair-btn brown" id="schedule-check-btn"><spring:message code="fap.tokyofair.screening.management.schedule_check_btn" /></span>
				</div>
			</div>
			
			<div class="screening-list-wrap">
			</div>
			
		</div>
	</div>
</div>
<%@include file="../common_footer_fap.jsp"%>

<div class="dim-layer">
    <div class="dimBg"></div>
    <div id="tokyofair-layer" class="pop-layer">
        <div class="pop-container">
            <div class="pop-conts">
            	<div class="layer-header">
            		<h2>
            			<spring:message code="fap.tokyofair.screening.management.title" />
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
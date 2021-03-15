<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="<c:url value="/resources/segroup/js/jquery-3.1.1.js" />"></script>
<script src="<c:url value="/resources/segroup/js/angular.min.js" />"></script>
<title>Bridge Job Fair</title>
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/segroup/society/fap/css/default.css" />" />
<script type="text/javascript">
var myApp = angular.module('myapp', []);

myApp.controller('JobPayController',['$scope','$compile','$http', function($scope, $compile,$http) {
	$scope.select_change = function(){
		var fap_jobfair_seq = $("#jobfairSelect option:selected").val();
		
		if(fap_jobfair_seq != 0){
			$http({
				method: 'POST',
				url: "/fap/company/company_pay_for_cost_search",
				params : {
					fap_jobfair_seq : fap_jobfair_seq
				},
				headers : {
					"AJAX" : true
				}
			}).then(function successCallback(response) {
				
				$scope.drawList(response.data);
				
			}, function errorCallback(response) {
				console.log(response);
				if(response.status == 403){
					alert('<spring:message code="com.login.ajaxSesstion" javaScriptEscape="true" />');
					location.href = "/fap/company/company_login";
				}
			});
		}else{
			$(".pay-content-vip").html("");
			$(".pay-table").html("");
		}
		
	}
	
	$scope.drawList = function(data){
		console.log(data);
		
		var vipContext = '';
		
		if(data.length == 0){
			vipContext += '<br><spring:message code="fap.common.pay_for_cost.context.wait" />';
		}else if(data[0].fap_per_comp_temp_payment_vip_gb == 'E0400'){
			vipContext += '<br><spring:message code="fap.common.pay_for_cost.context.bottom" />';
		}
		
		$(".pay-content-vip").html(vipContext);
		
		var tableContext = '';
		
		if(data.length != 0){
			tableContext += '<div id="nuguBB5">';
			tableContext += '<ul class="tit5">';
			tableContext += '<li class="wi1">JobFair</li>';
			tableContext += '<li class="wi2">Cost</li>';
			tableContext += '</ul>';
			tableContext += '</div>';
			tableContext += '<div id="nuguBB6">';
			
			$.each(data,function(indext,item){
				tableContext += '<ul class="tit6" >';
				tableContext += '<li class="wi5"><code value="'+item.fap_jobfair_divide_gb+'"></code></li>';
				tableContext += '<li class="wi6">';
				tableContext += comma(item.fap_per_jobfair_divide_temp_cost)+'円';
				tableContext += '</li>';
				tableContext += '</ul>';
			})
			tableContext += '</div>';
		
			$(".pay-table").html($compile(tableContext)($scope));
		}
	}
}]);

function comma(str) {
    str = String(str);
    return str.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');
}

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
				//console.log(response);
			});
		},
		template : "<span>{{filterParams}}</span>"
	}
} ]);

</script>
</head>
<body ng-app="myapp" ng-controller="JobPayController" id="company_job_pay_body">
<%@include file="company_menu.jsp"%>

<div class="join-wrap">

	<div id="subcontents">
		<div class="pay-content">
			<div class="title">
				<p class="titletext">
					<spring:message code="fap.common.pay_for_cost" />
				</p>
			</div>
			<div id="top">
				<div>
					<span><spring:message code="fap.comp.search_jobfair" /> : </span>
					<select onchange="angular.element(this).scope().select_change()"  id="jobfairSelect" style="width: 200px; height: 26px;">
						<option value="0" ><spring:message code="fap.comp.select" /></option>
						<c:forEach var="data" items="${jobfairList }">
							<option value="${data.fap_jobfair_seq }">${data.fap_jobfair_title }</option>
						</c:forEach>
					</select>
					<span><spring:message code="fap.common.pay_for_cost_jobfair" /></span>
				</div>		
			</div>
			<div class="pay-content-top">
				<spring:message code="fap.common.pay_for_cost.context.top" />
			</div>
			<div class="pay-content-middle">
				<spring:message code="fap.common.pay_for_cost.context.middle" />
				<div class="pay-content-vip">
				</div>
			</div>
			<div class="pay-table">
			</div>
			
		</div>
	</div>

</div>
<%@include file="company_footer.jsp"%>
</body>
</html>
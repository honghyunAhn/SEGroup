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
	var replaceJson = '${total}';
    replaceJson = replaceJson.replace(/(?:\r\n|\r|\n)/g, '\\r\\n');
	$scope.totalMap = JSON.parse(replaceJson);
	console.log($scope.totalMap);
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
	$(".schedule_print").on("click",function(){
		var popupX = (window.screen.width / 2) - ( 1200 / 2 );
        var popupY = (window.screen.height / 2) - ( 700 / 2 ) - 50;
		
		var tokyofair_schedule_print = document.tokyofair_schedule_print;
		window.open('','tokyofair_schedule_print',"width=1200,height=1800,left='+popupX+',top='+popupY+',screenX='+popupX+',screenY='+popupY+',toolbar=no,location=no,directories=no,status=no,menubar=no,resizable=yes,scrollbars=no,copyhistory=no,scrollbars=yes");
		tokyofair_schedule_print.target = 'tokyofair_schedule_print';
		tokyofair_schedule_print.submit();
	});
})
</script>

</head>
<body ng-app="myapp" ng-controller="TokyoFairController">
<%@include file="company_menu.jsp"%>
<div class="join-wrap">
		<div id="subcontents">
			<h1><spring:message code="fap.tokyofair.screening.search_form.title" /></h1>
			<h6></h6>
			
			<div class="screening_search_wrap" ng-if="totalMap != null">
				<div class="screening_search_line">
					<div class="screening_search_tx">
						<div>
							<p class="screening_search_title">{{totalMap.fap_jobfair_set_nm}}</p>
						</div>
						<div>
							<p class="screening_search_addr">{{totalMap.fap_jobfair_set_addr}}</p>
						</div>
					</div>
					<div class="screening_search_btn">
						<span class="tokyofair-btn blue schedule_print"><spring:message code="fap.comp.app_print" /></span>
					</div>
				</div>
				
				<table ng-repeat="schedule in totalMap.tokyoScheduleList" class="screening_search_schedule">
					<tr>
						<td><spring:message code="fap.tokyofair.screening.search_form.nm" /></td>
						<td colspan="2">{{schedule.fap_tokyofair_screening_nm}}</td>
					</tr>
					<tr>
						<td><spring:message code="fap.tokyofair.screening.search_form.date" /></td>
						<td colspan="2">{{schedule.fap_tokyofair_date_dt}}</td>
					</tr>
					<tr>
						<td><spring:message code="fap.tokyofair.screening.search_form.room_num" /></td>
						<td colspan="2">{{schedule.fap_tokyofair_date_room_num}}</td>
					</tr>
					<tbody ng-switch on="schedule.fap_tokyofair_screening_gb">
						<tr ng-repeat="member in schedule.tokyoScheduleMemberList" ng-switch-when="E0500">
								<td>{{member.fap_tokyofair_member_st}} ~ {{member.fap_tokyofair_member_et}}</td>
								<td colspan="2">{{member.fap_resume_nm}}({{member.fap_resume_birth}})</td>
						</tr>
						<tr ng-repeat="member in schedule.tokyoScheduleMemberList" ng-switch-when="E0501">
							<td ng-if="$index%schedule.fap_tokyofair_screening_user_num == 0" rowspan="{{schedule.fap_tokyofair_screening_user_num}}">{{$index/schedule.fap_tokyofair_screening_user_num + 1}}Group</td>
							<td ng-if="$index%schedule.fap_tokyofair_screening_user_num == 0" rowspan="{{schedule.fap_tokyofair_screening_user_num}}">{{member.fap_tokyofair_member_st}} ~ {{member.fap_tokyofair_member_et}}</td>
							<td>{{member.fap_resume_nm}}({{member.fap_resume_birth}})</td>
						</tr>
						<tr ng-repeat="member in schedule.tokyoScheduleMemberList" ng-switch-default>
							<td ng-if="$index == 0" rowspan="{{schedule.tokyoScheduleMemberList.length}}">{{member.fap_tokyofair_member_st}} ~ {{member.fap_tokyofair_member_et}}</td>
							<td colspan="2">{{member.fap_resume_nm}}({{member.fap_resume_birth}})</td>
						</tr>
					</tbody>
				</table>
				
			</div>	
			
			<div class="screening_search_wrap" ng-if="totalMap == null">
				<div class="screening_nothing_line">
					<p class="screening_nothing_tx">
						<spring:message code="fap.tokyofair.schedule.search_form.nothing" />
					</p>
				</div>
			</div>
		</div>
</div>

<form action="/fap/company/company_tokyofair_screening_search_print_form" method="post" name="tokyofair_schedule_print" id="tokyofair_schedule_print">
	<input type="hidden" name="fap_jobfair_divide_seq" value="${fap_jobfair_divide_seq }">
</form>
<%@include file="../common_footer_fap.jsp"%>
</body>
</html>
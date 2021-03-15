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

function printWindow() {
	window.print();
}
</script>
<style type="text/css" media="print">
@page {
	size: auto; /* auto is the initial value */
	margin: 10mm; /* this affects the margin in the printer settings */
}

html {
	margin: 0px;
}

body {
	margin: 0mm; /* margin you want for the content */
}
.printBtn {
	display: none !important;
}
</style>
</head>
<body ng-app="myapp" ng-controller="TokyoFairController">
<div style="display: block; position: fixed; top: 1px; left: 25px; z-index: 150;">
	<input class="printBtn" type="button" style="height: 60px; width: 100px;" onclick="printWindow()" value="print">
</div>
<div class="join-wrap">
		<div id="subcontents">
			<h1><spring:message code="fap.tokyofair.screening.search_form.title" /></h1>
			<h6></h6>
			
			<div class="screening_search_wrap">
				<div>
					<p class="screening_search_title">{{totalMap.fap_jobfair_set_nm}}</p>
				</div>
				<div>
					<p class="screening_search_addr">{{totalMap.fap_jobfair_set_addr}}</p>
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
		</div>
</div>
</body>
</html>
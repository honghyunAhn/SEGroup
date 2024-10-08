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
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/segroup/society/fap/css/userDefault.css" />" />
<script type="text/javascript">
var myApp = angular.module('myapp', []);
myApp.controller('TokyoFairController',['$scope','$compile', '$http','$timeout', function($scope, $compile, $http, $timeout) {
	var replaceJson = '${tokyofairUserMap}';
    replaceJson = replaceJson.replace(/(?:\r\n|\r|\n)/g, '\\r\\n');
	$scope.totalMap = JSON.parse(replaceJson);
	console.log($scope.totalMap);
	
	$timeout(function() {
		
		$.each($(".span-code"), function(index, item){
			var cd = $(this).attr("cd");
			var context = '<code value="'+cd+'"></code>';
			$(this).html(context);
		})

		$compile(".span-code")($scope);
	}, 0);
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
			<h1>현장 면접 일정</h1>
			<h6></h6>
			
			<div class="screening_search_wrap" ng-if="totalMap != null">
				<div>
					<p class="screening_search_title">{{totalMap.fap_jobfair_set_nm}}</p>
				</div>
				<div>
					<p class="screening_search_addr">{{totalMap.fap_jobfair_set_addr}}</p>
				</div>
				
				<table ng-repeat="schedule in totalMap.tokyoScheduleUserList" class="screening_search_schedule">
					<tr>
						<td><spring:message code="fap.tokyofair.screening.search_form.nm" /></td>
						<td colspan="2">{{schedule.fap_tokyofair_screening_nm}}</td>
					</tr>
					<tr>
						<td>면접 회사</td>
						<td>{{schedule.fap_comp_en_nm}}</td>
						<td>{{schedule.fap_comp_ja_nm}}</td>
					</tr>
					<tr>
						<td>채용 공고</td>
						<td colspan="2">{{schedule.fap_job_ad_title}}</td>				
					</tr>
					<tr>
						<td><spring:message code="fap.tokyofair.screening.search_form.date" /></td>
						<td colspan="2">{{schedule.fap_tokyofair_date_dt}}</td>
					</tr>
					<tr>
						<td><spring:message code="fap.tokyofair.screening.search_form.room_num" /></td>
						<td colspan="2">{{schedule.fap_tokyofair_date_room_num}}</td>
					</tr>
					<tr ng-switch on="schedule.fap_tokyofair_screening_gb">
						<td>면접 타입</td>
						<td ng-switch-when="E0501"><div class="span-code" cd="{{schedule.fap_tokyofair_screening_gb}}"></div></td>
						<td ng-switch-when="E0501">Group - {{schedule.fap_tokyofair_screening_user_num}}명</td>
						<td colspan="2" ng-switch-default><div class="span-code" cd="{{schedule.fap_tokyofair_screening_gb}}"></div></td>
					</tr>
					<tr>
						<td>면접 시간</td>
						<td colspan="2">{{schedule.fap_tokyofair_member_st}} ~ {{schedule.fap_tokyofair_member_et}}</td>
					</tr>
					<tr ng-if="schedule.fap_tokyofair_screening_user_req != '' ">
						<td>지원자 전달사항</td>
						<td colspan="2">{{schedule.fap_tokyofair_screening_user_req}}</td>
					</tr>
				</table>
			</div>	
			
			<div class="screening_search_wrap" ng-if="totalMap == null">
				<div class="screening_nothing_line">
					<p class="screening_nothing_tx">
						등록된 일정이 없습니다
					</p>
				</div>
			</div>
		</div>
</div>

</body>
</html>
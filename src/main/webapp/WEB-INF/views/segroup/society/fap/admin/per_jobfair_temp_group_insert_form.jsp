<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">	
	<script src="<c:url value="/resources/segroup/js/jquery-3.1.1.js" />"></script>
	<script src="<c:url value="/resources/segroup/js/angular.min.js" />"></script>
	
<title>Bridge Job Fair</title>
<script type="text/javascript">

var myApp = angular.module('myapp', []);

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

myApp.controller('AdminController', ['$scope','$compile','$http', function($scope,$compile,$http){

	var fap_jobfair_seq = $("#fap_jobfair_seq").val();
	
	$http({
		method: 'POST',
		url: "/fap/admin/select_all_job_fair_divide",
		params : {
			fap_jobfair_seq : fap_jobfair_seq
		}
	}).then(function successCallback(response) {
		
		var context = '';
		$.each(response.data,function(index, item){
			
			context +='<code value="'+item.fap_jobfair_divide_gb+'"></code>';
			context +='?????? : <input type="text" class="currency" name="perJobfairDivideList['+index+'].fap_per_jobfair_divide_temp_cost" ng-model="divide_cost" blur-currency>';
			context +='<input type="hidden" name="perJobfairDivideList['+index+'].fap_jobfair_divide_seq" value="'+item.fap_jobfair_divide_seq+'"><br>';
			
		});
		
		$("#divideDiv").html($compile(context)($scope));
		
	}, function errorCallback(response) {
		console.log(response);
	});

}]);

function formCheck(){
	// blurCurrency
	$.each($(".currency"),function(index,item){
		var commaValue = angular.element(item).val();
		
		angular.element(item).val(commaValue.replace(/,/g, ''));
	});
	
	return true;
}

</script>
</head>
<body  ng-app="myapp" ng-controller="AdminController">
 <%@include file="admin_menu.jsp"%>
	<br>
	<div class="page_title">
		<h2>???????????? ?????? ?????? ?????? ?????? ??????</h2>
	</div>
	<br>

<form action="/fap/admin/per_jobfair_temp_group_insert" method="post" onsubmit="return formCheck()">
????????? ??? : ${jobfair.fap_jobfair_title } <br>
?????? ??? : <input type="text" name="fap_per_jobfair_temp_group_nm"> <br>
?????? ???????????? ?????? <br>
<div id="divideDiv">
	
</div>
<input type="hidden" id="fap_jobfair_seq" name="fap_jobfair_seq" value="${jobfair.fap_jobfair_seq }">
<input type="submit" value="????????????">
</form>
</body>
</html>
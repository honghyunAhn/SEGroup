<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">	
	<link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
	<script src="<c:url value="/resources/segroup/js/jquery-3.1.1.js" />"></script>
	<script src="<c:url value="/resources/segroup/js/jquery-ui.js" />"></script>
	<script src="<c:url value="/resources/segroup/js/angular.min.js" />"></script>
	<script src="<c:url value="/resources/segroup/js/datepicker.js" />"></script>
	<script type="text/javascript" src="/resources/segroup/js/jquery.timepicker.min.js"></script>
	<script src="<c:url value="/resources/segroup/js/timepicker.js" />"></script>
	<link type="text/css" rel="stylesheet" href="/resources/segroup/css/jquery.timepicker.css" media="" />
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
<title>Bridge Job Fair</title>
	<script type="text/javascript">
	var myApp = angular.module('myapp', []);

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
	} ]);
	
	myApp.controller('AdminController', ['$scope','$compile','$http', function($scope,$compile,$http){
		
		$scope.jobfair_change = function(){
			var fap_jobfair_seq = $("#jobfairSelect option:selected").val();
			$("#search_data").html('');
			if(fap_jobfair_seq != 0){
				$http({
					method: 'POST',
					url: "/fap/admin/select_all_job_fair_divide",
					params : {
						fap_jobfair_seq : fap_jobfair_seq
					}
				}).then(function successCallback(response) {
					$scope.jobfair_divide_draw(response.data);
				}, function errorCallback(response) {
					console.log(response);
				});
			}
		}
		
		$scope.jobfair_divide_draw = function(data){
			var context = '';
			context += '<option seq="0">?????? ???????????? ???????????????</option>';
			
			$.each(data , function(index , item){
				context += '<option selectcode value="'+item.fap_jobfair_divide_gb+'" seq="'+item.fap_jobfair_divide_seq+'"></option>';
			});
			
			$("#jobfairDivideSelect").html($compile(context)($scope));
		}
		
		$scope.jobfair_divide_change = function(){
			var fap_jobfair_divide_seq = $("#jobfairDivideSelect option:selected").attr("seq");
			if(fap_jobfair_divide_seq != 0){
				$http({
					method: 'POST',
					url: "/fap/admin/tokyofair_schedule_set_search_list",
					params : {
						fap_jobfair_divide_seq : fap_jobfair_divide_seq
					}
				}).then(function successCallback(response) {
					$scope.list_draw(response.data);
				}, function errorCallback(response) {
					console.log(response);
				});
			}else{
				$("#search_data").html('');
			}
		}
		
		$scope.list_draw = function(data){
			var context = '';
			$.each(data, function(index,item){
				context += '<tr>';
				context += '<td>'+(index+1)+'</td>';
				context += '<td>'+item.fap_jobfair_set_nm+'</td>';
				context += '<td>'+item.fap_jobfair_set_addr+'</td>';
				context += '<td><a href="#" onclick="angular.element(this).scope().gb_change('+item.fap_jobfair_divide_seq+','+item.fap_jobfair_set_seq+',\''+item.fap_jobfair_set_gb+'\')"><code value="'+item.fap_jobfair_set_gb+'"></code></a></td>';
				context += '<td><input type="button" class="updateBtn" value="??????" ng-click="setting_update('+item.fap_jobfair_set_seq+')" /></td>';
				context += '<td><input type="button" class="deleteBtn" value="??????" ng-click="setting_delete('+item.fap_jobfair_set_seq+')" /></td>';
				context += '</tr>';
			});
			
			$("#search_data").html($compile(context)($scope));
		}
		
		$scope.gb_change = function(fap_jobfair_divide_seq,fap_jobfair_set_seq,fap_jobfair_set_gb){
			
			$http({
				method: 'POST',
				url: "/fap/admin/tokyofair_schedule_set_gb_update",
				params : {
					fap_jobfair_divide_seq : fap_jobfair_divide_seq
					,fap_jobfair_set_seq : fap_jobfair_set_seq
					,fap_jobfair_set_gb : fap_jobfair_set_gb
				}
			}).then(function successCallback(response) {
					$scope.list_draw(response.data);
					alert("??????????????? ?????? ???????????????.");
			}, function errorCallback(response) {
					console.log(response);
			});
			
		}
		
		$scope.setting_delete = function(fap_jobfair_set_seq){
            if (confirm("?????? ??????????????????????????") == true){
            	var fap_jobfair_divide_seq = $("#jobfairDivideSelect option:selected").attr("seq");

            	$http({
    				method: 'POST',
    				url: "/fap/admin/tokyofair_schedule_delete",
    				params : {
    					fap_jobfair_divide_seq : fap_jobfair_divide_seq
    					,fap_jobfair_set_seq : fap_jobfair_set_seq
    				}
    			}).then(function successCallback(response) {
    					$scope.list_draw(response.data);
    					alert("????????? ?????? ???????????????.");
    			}, function errorCallback(response) {
    					console.log(response);
    			});
            	
           	}else{
           	   return;
           }
		}
		
		$scope.setting_update = function(fap_jobfair_set_seq){
			$("#fap_jobfair_set_seq").val(fap_jobfair_set_seq);
			$("#updateForm").attr("action","tokyofair_schedule_update_form");
			$("#updateForm").submit();
		}
		
	}]);
	
	$(function(){
		
		$("#calendarBtn").on("click",function(){
			var fap_jobfair_divide_seq = $("#jobfairDivideSelect option:selected").attr("seq");
			
			if(fap_jobfair_divide_seq == 0) {
				alert("?????? ???????????? ????????? ?????????.");
			}else{
				$("#fap_jobfair_divide_seq").val(fap_jobfair_divide_seq);
				$("#insertForm").attr("action","tokyofair_schedule_insert_form");
				$("#insertForm").submit();
			}
			
		});
		
		$("#scheduleBtn").on("click",function(){
			var fap_jobfair_divide_seq = $("#jobfairDivideSelect option:selected").attr("seq");
			
			if(fap_jobfair_divide_seq == 0) {
				alert("?????? ???????????? ????????? ?????????.");
			}else{
				$("#fap_jobfair_divide_seq").val(fap_jobfair_divide_seq);
				$("#insertForm").attr("action","tokyofair_schedule_search_form");
				$("#insertForm").attr("method","get");
				$("#insertForm").submit();
			}
			
		});
		
	})
	
	</script>

</head>
<body  ng-app="myapp" ng-controller="AdminController">
<%@include file="admin_menu.jsp"%>
	<br>
	<div class="page_title">
		<h2>???????????? ?????? ????????? ??????</h2>
	</div>
	<br>
	<select id="jobfairSelect" onchange="angular.element(this).scope().jobfair_change()">
		<option value="0">???????????? ???????????????</option>
		<c:forEach var="data" items="${jobfairList }">
			<option value="${data.fap_jobfair_seq }">${data.fap_jobfair_title }</option>
		</c:forEach>
	</select>
	
	<select id="jobfairDivideSelect" onchange="angular.element(this).scope().jobfair_divide_change()">
		<option seq="0">?????? ???????????? ???????????????</option>
	</select>
	
	<input type="button" id="calendarBtn" value="????????????">
	<input type="button" id="scheduleBtn" value="????????????">
	
	<table class="table">
		<thead>
			<tr>
				<th>??????</th>
				<th>?????? ??????</th>
				<th>?????? ??????</th>
				<th>????????????</th>
				<th>??????</th>
				<th>??????</th>
			</tr>
		</thead>
		<tbody id="search_data">
			
		</tbody>
	</table>
	
	<form id="insertForm" method="post">
		<input type="hidden" id="fap_jobfair_divide_seq" name="fap_jobfair_divide_seq">
	</form>
	
	<form id="updateForm" method="post">
		<input type="hidden" id="fap_jobfair_set_seq" name="fap_jobfair_set_seq">
	</form>
	
</body>
</html>
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
	
	myApp.controller('AdminController', ['$scope','$compile','$http', function($scope,$compile,$http){
		
		$scope.jobfair_change = function(){
			var fap_jobfair_seq = $("#jobfairSelect option:selected").val();
			if(fap_jobfair_seq != 0){
				$http({
					method: 'POST',
					url: "/fap/admin/per_jobfair_temp_group_search",
					params : {
						fap_jobfair_seq : fap_jobfair_seq
					}
				}).then(function successCallback(response) {
					
					$scope.drawList(response.data);
					
				}, function errorCallback(response) {
					console.log(response);
				});
			}
		}
		
		$scope.drawList = function(data){
			
			var context = '';
			$.each(data,function(index,item){
				context +='<tr>';
				context +='<td>'+(index+1)+'</td>';
				context +='<td>'+item.fap_per_jobfair_temp_group_nm+'</td>';
				$.each(item.divideList, function(index2, item2){
					context +='<td><code value="'+item2.fap_jobfair_divide_gb+'"></code></td>';
					context +='<td>'+item2.fap_per_jobfair_divide_temp_cost+'</td>';
				})
				context +='<td><input type="button" class="updateFormBtn" value="수정"><input type="hidden" class="per_seq" value="'+item.fap_per_jobfair_temp_group_seq+'"></td>';
				context +='<td><input type="button" class="deleteBtn" value="삭제"><input type="hidden" class="per_seq" value="'+item.fap_per_jobfair_temp_group_seq+'"></td>';
				context +='</tr>';
			})
			
			$("#listTbody").html($compile(context)($scope));
			
			$(".deleteBtn").on("click",function(){
				var per_seq = $(this).next(".per_seq").val();
				
				$("#per_seq").val(per_seq);
				
				$("#deleteForm").submit();
			});
			
			$(".updateFormBtn").on("click", function(){
				var per_seq = $(this).next(".per_seq").val();
				var fap_jobfair_title = 	$("#jobfairSelect option:selected").text();
				
				$("#fap_per_jobfair_temp_group_seq").val(per_seq);
				$("#fap_jobfair_title_update").val(fap_jobfair_title);
				
				$("#updateForm").submit();
			})
			
		}
		
		
	}]);
	
	$(function(){
		$("#insertFormBtn").on("click",function(){
			var fap_jobfair_seq = $("#jobfairSelect option:selected").val();
			var fap_jobfair_title = 	$("#jobfairSelect option:selected").text();
			
			if(fap_jobfair_seq == 0){
				alert("잡페어를 선택해 주세요.");
				return;
			}
			
			$("#fap_jobfair_seq").val(fap_jobfair_seq);
			$("#fap_jobfair_title").val(fap_jobfair_title);
			
			$("#insertForm").submit();
		})
		
	});
	
	</script>
</head>
<body  ng-app="myapp" ng-controller="AdminController">
 <%@include file="admin_menu.jsp"%>
	<br>
	<div class="page_title">
		<h2>잡페어별 임시 결제 그룹 관리</h2>
	</div>
	<br>
	 
	<select id="jobfairSelect" onchange="angular.element(this).scope().jobfair_change()">
		<option value="0">잡페어를 선택하세요</option>
		<c:forEach var="data" items="${jobfairList }">
			<option value="${data.fap_jobfair_seq }">${data.fap_jobfair_title }</option>
		</c:forEach>
	</select>
	<a href="/fap/admin/admin_main">메인으로</a>
	<div>
		<input type="button" id="insertFormBtn" value="등록">
	</div>
	
	<table>
		<tbody id="listTbody">
		
		</tbody>
	</table>
	
	<form action="/fap/admin/per_jobfair_temp_group_insert_form" method="post" id="insertForm">
		<input type="hidden" name="fap_jobfair_seq" id="fap_jobfair_seq">
		<input type="hidden" name="fap_jobfair_title" id="fap_jobfair_title">
	</form>
	
	<form action="/fap/admin/per_jobfair_temp_group_delete" method="post" id="deleteForm">
		<input type="hidden" name="fap_per_jobfair_temp_group_seq" id="per_seq">
	</form>
	
	<form action="/fap/admin/per_jobfair_temp_group_update_form" method="post" id="updateForm">
		<input type="hidden" name="fap_jobfair_title" id="fap_jobfair_title_update">
		<input type="hidden" name="fap_per_jobfair_temp_group_seq" id="fap_per_jobfair_temp_group_seq">
	</form>
</body>
</html>
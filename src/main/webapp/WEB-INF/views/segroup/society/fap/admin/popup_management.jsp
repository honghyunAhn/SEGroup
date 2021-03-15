<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">	
	<script src="<c:url value="/resources/segroup/js/jquery-3.1.1.js" />"></script>
	<script src="<c:url value="/resources/segroup/js/angular.min.js" />"></script>
	<!-- modal을 위한 bootstrap -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
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
	$scope.insert_popup = function(){
		location.href = "/fap/admin/popup_insert_form";
	}
}]);

function popup_delete(seq){
	$("#fap_popup_seq").val(seq);
	
	if(confirm("팝업을 삭제 하시겠습니까?")){
		$("#delete_form").submit();
	}
}
</script>
</head>
<body  ng-app="myapp" ng-controller="AdminController">
 <%@include file="admin_menu.jsp"%>
	<br>
	<div class="page_title">
		<h2>팝업 관리</h2>
	</div>
	<br>
	<table class="table">
		<thead>
			<tr>
				<th>
					팝업제목
				</th>
				<th>
					팝업구분
				</th>
				<th>
					노출상태
				</th>
				<th>
					등록일
				</th>
				<th>
					삭제
				</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="item" items="${result }">
				<tr>
					<td>
						<a href="/fap/admin/popup_update_form?fap_popup_seq=${item.fap_popup_seq }">${item.fap_popup_title }</a>
					</td>
					<td><code value="${item.fap_popup_gb }"></code></td>
					<td><code value="${item.fap_popup_st }"></code></td>
					<td>${item.fap_popup_ins_dt }</td>
					<td>
						<button onclick="popup_delete('${item.fap_popup_seq}')">삭제</button>
					</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	<button ng-click="insert_popup()">팝업 등록</button>
	<form action="/fap/admin/popup_delete" method="post" id="delete_form">
		<input type="hidden" name="fap_popup_seq" id="fap_popup_seq">
	</form>
</body>
</html>
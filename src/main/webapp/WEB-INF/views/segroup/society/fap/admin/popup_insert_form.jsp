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
}]);
</script>
</head>
<body  ng-app="myapp" ng-controller="AdminController">
<%@include file="admin_menu.jsp"%>
	<br>
	<div class="page_title">
		<h2>팝업 등록</h2>
	</div>
	<br>
	<form action="/fap/admin/popup_insert" method="post" enctype="multipart/form-data">
			팝업 제목 : <input type="text" name="fap_popup_title"> <br>
			팝업 이미지 : <input type="file" name="fap_popup_img" accept="image/*"><br>
			팝업 내용(점검시간용도) : <input type="text" name="fap_popup_ct"><br>
			팝업 구분 : <input type="radio" name="fap_popup_gb" value="D1500"> <code value="D1500"></code> <input type="radio" name="fap_popup_gb" value="D1501"> <code value="D1501"></code> <br>
			팝업 상태 : <input type="radio" name="fap_popup_st" value="D1600"> <code value="D1600"></code> <input type="radio" name="fap_popup_st" value="D1601"> <code value="D1601"></code> <br>
			팝업 링크<br>
			<select name="fap_popup_link">
				<option value="/fap/user/user_main_popup">서버점검링크</option>
				<option value="/fap/user/user_open_pt_popup">설명회링크</option>
				<option value="/fap/user/user_open_edu_popup">구직자교육링크</option>
			</select>
			<input type="submit" value="저장">
	</form>
	
</body>
</html>
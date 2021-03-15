<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="<c:url value="/resources/segroup/js/angular.min.js" />"></script>
<script type="text/javascript">
	var myApp = angular.module('myapp', []);
	
	/**
		$http : 우리가 흔히 아는 ajax라고 생각하면 됨; 비동기식
	*/
	myApp.controller('MainController', ['$scope','$http', function($scope,$http) {
		$http({
			// method, url : ajax와 동일
			method: 'POST',
			url: 'ajax'
			// successCallback은 ajax에서의 success와 같음
		}).then(function successCallback(response) {
			// 실제 controller에서의 return값(response)의 데이터를 scope.results에 담음
			$scope.results = response.data;
			// errorCallback는 ajax에서의 error와 같음
		}, function errorCallback(response) {

		});
	}]);
	
	myApp.directive('code', ['$http',function($http){
		return {
			restrict: "E",
			replace: true,
			/**
				scope 옵션
				scope : false 	-> 새로운 scope 객체를 생성하지 않고 부모를 가진 같은 scope 객체를 공유; default 옵션
				scope : true 	-> 새로운 scope 객체를 생성하고 부모 scope 객체를 상속
				scope : {...} 	-> isolate/isolated scope를 새롭게 생성
								      재사용 가능한 컴포넌트를 만들 때 사용하는데 컴포넌트가 parent scope의 값을 read/write못하게 하기 위함이다.
								   parent scope에 접근(access)하고 싶을 경우 Binding 전략(=, @, &)를 이용한다.
				Binding 전략 
				= : 부모 scope의 property와 directive의 property를 data binding하여 부모 scope에 접근
				@ : directive의 attribute vale를 {{}}방식 (interpolation)을 이용해 부모 scope에 접근
			*/
			scope : {
				value : '@'
			},
			controller: function ($scope, $element, $attrs) {
				//console.log($attrs.value);
				$http({
					// 이동하는 controller에서는 공통코드 -> 해당하는 문자열로 변환헤줌
					method: 'POST',
					url: 'codeconverter',
			  		responseType: 'text',
			  		// params : contorller로 넘어가는 데이터
					params : {
						code : $attrs.value
					}
				}).then(function successCallback(response) {
		    		$scope.filterParams = response.data;
				}, function errorCallback(response) {
					alert(response);
				});
			}
			,template: "<span>{{filterParams}}</span>"
		}
	}]);
</script>
</head>
<body  ng-app="myapp" ng-controller="MainController">
	<table>
		<tr ng-repeat="res in results">
			<td>{{res.name}}</td>
			<td>{{res.class}}</td>
		</tr>
	</table>
	<code value="A0000"></code>
	<code value="A0100"></code>
	<code value="A0202"></code>
</body>
</html>
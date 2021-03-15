<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html ng-app="myapp">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="<c:url value="/resources/segroup/js/angular.min.js" />"></script>
<script type="text/javascript">
	var myApp = angular.module('myapp', []);
	
	myApp.controller('MainController', ['$scope', function($scope) {
        $scope.users = [
            {"name":"taguchi", "score":52.22},
            {"name":"tanaka", "score":38.22},
            {"name":"yamada", "score":11.11},
            {"name":"test1", "score":22.11},
            {"name":"test2", "score":33.11},
            {"name":"test3", "score":44.11},
            {"name":"test4", "score":55.11},
            {"name":"test5", "score":66.11}
        ];
    }]);
	
	myApp.controller('UserItemController', ['$scope', function($scope){
		/**
			이 함수는 user의 score를 1씩 증가 시켜주는 함수
		*/
    	$scope.increment = function() {
    		$scope.user.score++;
    	}
    }]);
	
</script>
<style type="text/css">
	.even {
		background: #ccc;
	}
	.odd {
		background: red;
	}
</style>
</head>
<body ng-controller="MainController">
	<ul>
		<!-- 
			ng-class-odd="'변수명'" : 홀수번째의 값에 알맞는 변수명의 style가 적용 
			ng-class-even="'변수명'" : 짝수번째의 값에 알맞는 변수명의 style가 적용
			index : 말 그대로 index로 0부터 시작
			first : 반복문의 처음일 경우 true, 아닐 경우 false
			middle : 반목문의 중간(정확히 중간이 아니고 그냥 사이에 있는거 전부)일 경우 true, 아닐 경우 false
			last : 반복문의 마지막일 경우 true, 아닐 경우 false
		-->
		<li ng-repeat="user in users" ng-class-even="'even'" ng-class-odd="'odd'">
			{{$index + 1}} {{$first}} {{$middle}} {{$last}} {{user.name|uppercase}}	{{user.score|number:4}}
		</li>
	</ul>
	
	<ul>
		<li ng-repeat="user in users" ng-controller="UserItemController">
			{{user.name}}	{{user.score}}
			<!--
				ng-click="함수" : 클릭시 정의된 함수를 실행시킴 
			-->
			<button ng-click="increment()">+1</button>
		</li>
	</ul>
</body>
</html>
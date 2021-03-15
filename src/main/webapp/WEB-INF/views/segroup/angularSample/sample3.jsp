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
	
</script>
</head>
<body ng-controller="MainController">
	<ul>
		<!-- 
			limitTo:숫자 : 숫자 만큼만 출력
		-->
		<li ng-repeat="user in users|limitTo:5">
			{{user.name}}	{{user.score|number:4}}
		</li>
	</ul>
	<ul>
		<!-- 
			orderBy:'변수명' : 변수명을 오름차순으로 출력
		-->
		<li ng-repeat="user in users|orderBy:'score'">
			{{user.name}}	{{user.score|number:4}}
		</li>
	</ul>
	<ul>
		<!-- 
			orderBy:'-변수명' : 변수명을 내림차순으로 출력
		-->
		<li ng-repeat="user in users|orderBy:'-score'">
			{{user.name}}	{{user.score|number:4}}
		</li>
	</ul>
	<ul>
		<li ng-repeat="user in users|orderBy:'-score'|limitTo:3">
			{{user.name}}	{{user.score|number:4}}
		</li>
	</ul>
</body>
</html>
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
	
	//커스텀 필터
	/**
		'capitalize'이란 이름의 함수를 정의
		이 함수는 데이터의 첫 글자를 대문자로 변환해주는 함수
	*/
	myApp.filter('capitalize', function() {
    	return function(input, param){
    		return input.substring(0,1).toUpperCase()+input.substring(1);
    	}
    });
</script>
</head>
<body ng-controller="MainController">
	<!-- 
		ng-model : 변수 설정
	-->
	<p>전체 필터 : <input type="text" ng-model="query"></p>
	<!-- <p>이름 필터 : <input type="text" ng-model="query.name"></p> -->
	<ul>
		<!-- 
			capitalize : 위에 정의한 함수 호출
			filter:'변수' : 기준점을 바탕으로 배열을 정렬; 이 함수에서는 위에 query에 입력된 text를 기준으로 출력됨(입력된 text가 있는 데이터만 출력)
		 -->
		<li ng-repeat="user in users | filter:query">
			{{user.name}} {{user.name | capitalize}} {{user.score|number:4}}
		</li>
	</ul>
</body>
</html>
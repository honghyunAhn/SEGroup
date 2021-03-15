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
		
        /**
        	오늘 날짜를 변수에 입력
        */
        $scope.today = new Date();

	}]);
	
</script>
</head>
<body ng-controller="MainController">
	<!-- 
		length : 배열의 갯수를 나타냄
		number : 기본 숫자 포맷으로 출력
		currency : 화폐통화 포맷으로 출력; default는 '$'
		currency:"&#8361;" : ₩통화 포맷으로 출력
		'변수명'|date:'yyyy-MM-dd' : 일치하는 변수명의 값을 뒤에 오는 date포맷으로 출력
	-->
	<p>{{users.length}}</p>
	<p>{{25 * 500|number}}</p>
	<p>{{25 * 500|currency}}</p>
	<p>{{25 * 500|currency:"&#8361;"}}</p>
	<p>{{today|date:'yyyy-MM-dd'}}</p>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html ng-app="myapp">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="<c:url value="/resources/segroup/js/angular.min.js" />"></script>
<script type="text/javascript">
							 // module의 이름; 여기서는 'myapp'
	var myApp = angular.module('myapp', []);
	
	/**
		controller : scope의 model과 function을 정의해준다.
		$scope : 양방형 데이터 바인딩의 핵심이자 view와 controller를 이러주는 징검다리
				 scope를 통해 view와 controller간의 소통이 가능해짐
				 - AngularJS의 컨트롤러는 하나의 컨트롤러에 하나의 $scope만을 가지게 된다.
				 - 컨트롤러 함수 두 개가 있을 경우 컨트롤러 함수당 별도의 $scope 객체가 생성된다.
	*/
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

<!-- 
	ng-controller="이름" : 처음 angular를 불러오는 구문; 위에서 설정한 '이름'과 일치하는 것을 불러옴
 -->
<body ng-controller="MainController">
	<ul>
		<!-- 
			ng-repeat : 주어진 횟수(컬렉션의 항목 수)만큼 HTML 세트 반복 
						컬렉션 객체의 항목을 순차적으로 접근할 때 사용.
						(*컬렉션 -  배열 또는 객체가 여러 개 들어있는 집합)
						자바의 for문
			'a' in 'b' : 원래 정의된 b를 a라는 이름으로 부르겠다는 것을 나타냄
						 user in users의 경우 위에 정의된 users를 user이라는 이름으로 부르겠다는 것
						 데이터베이스의 별칭과 같은 맥락
		 -->
		<li ng-repeat="user in users">
			{{user.name}}	{{user.score}}
		</li>
	</ul>
	
	<ul>
		<!-- 
			uppercase : 전체를 대문자로 출력
			lowercase : 전체를 소문자로 출력
			number:숫자 : 소수점 아래 자리수를 표시(숫자 만큼)
		 -->
		<li ng-repeat="user in users">
			{{user.name|uppercase}}	{{user.score|number:4}}
		</li>
	</ul>
</body>
</html>
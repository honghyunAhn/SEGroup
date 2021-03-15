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
        	users에 값을 추가
        */
        $scope.addUser = function(){
        	$scope.users.push($scope.user);
        }

	}]);
	
</script>
</head>
<body ng-controller="MainController">
	<!-- 
		ng-submit="함수" : submit버튼 클릭시 함수가 실행됨
	-->
	<form novalidate name="myName" ng-submit="addUser()">
		<p>
			Color:
			<!-- 
				ng-options="color for color in ['red','blue','pink']" : 'color'라는 이름으로 3개의 option을 넣어줌
				ng-init="user.color='red'" : select box 중 처음 보여 줄 값을 설정
			-->
			<select ng-model="user.color" ng-options=" 'label:'+color for color in ['red','blue','pink']" ng-init="user.color='red'"></select>
		</p>
		<p>
			18+:
			<!--
				ng-true-value=" 'adult' " ng-false-value=" 'child' : check할 경우 true, check하지 않을 경우 false
			-->
			<input type="checkbox" ng-model="user.adult" ng-true-value=" 'adult' " ng-false-value=" 'child' ">
		</p>
		<p>
			Phone:
			<!-- 
				우리가 흔히 아는 radio와 같음
			-->
			<input type="radio" ng-model="user.phone" value="iPhone"> iPhone
			<input type="radio" ng-model="user.phone" value="Android"> Android
		</p>
		<p>
			Memo:
			<!-- 
				ng-maxlength="숫자" : 입력 할 수 있는 최대 숫자를 제한함
				{{140 - user.memo.length}} : 계산식으로 여기서 최대 숫자로 지정한 140에 현재 유저가 입력하고 있는 text의 숫자(입력한 글자의 갯수)를 빼주는 계산식
			-->
			<textarea ng-model="user.memo" ng-maxlength="140"></textarea>{{140-user.memo.length}}
		</p>
		<p>
			Name:
			<!--
				ng-minlength="숫자" : 입력해야할 최소 글자 수
				ng-maxlength="숫자" : 입력해야할 수 있는 최대 글자 수 
				required : 필수
				ng-show="조건" : 조건에 만족하지 않으면 보여 줌
				
				ex) myName.name.$error.minlength : 
					myName 		<- form의 이름
					name 		<- myName안에 있는 name이 name인 것
					$error 		<- 조건이 만족 하지 않는 경우
					minlength 	<- 최소 입력해야하는 글자 수
					-> 여기서는 4글자 이하 일 경우 Too short가 나타남
					
				ex) myName.name.$error.maxlength : 
					myName 		<- form의 이름
					name 		<- myName안에 있는 name이 name인 것
					$error 		<- 조건이 만족 하지 않는 경우
					maxlength 	<- 최소 입력해야하는 글자 수
					-> 여기서는 9글자 이상 일 경우 Too long이 나타남
					
				myName.name.$error.required : 필수값일 경우 입력 되지 않은 경우 보여 줌
			-->
			<input type="text" name="name" ng-model="user.name" ng-minlength="5" ng-maxlength="8" required>
			<span ng-show="myName.name.$error.required">Required</span>
			<span ng-show="myName.name.$error.minlength">Too short</span>
			<span ng-show="myName.name.$error.maxlength">Too long</span>
		</p>
		<p>
			Score:
			<input type="number" name="score" ng-model="user.score">
		</p>
		<p>
			Email:
			<!-- 
				email 포맷을 검사해줌
			-->
			<input type="email" name="email" ng-model="user.email">
			<span ng-show="myName.email.$error.email">Not valid email!!</span>
		</p>
		<p>
			Web:
			<!-- 
				url 포맷을 검사해줌
			-->
			<input type="url" name="url" ng-model="user.url">
			<span ng-show="myName.url.$error.url">Not valid url</span>
		</p>
		<p><input type="submit" value="add"></p>
	</form>
	
	
	<!-- 
		user|json : user의 값을 보여준다
	-->
	<pre>{{user|json}}</pre>
	
	<ul>
		<li ng-repeat="user in users">
			{{user.name}}	{{user.score}}
		</li>
	</ul>
</body>
</html>
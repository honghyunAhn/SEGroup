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
	
	// 커스텀 지시자 포커스 생성
	/**
		이 함수는 focus 해주는 함수
		아래의 phone에 걸려있음
	*/
	myApp.directive('focus', function(){
		return {
			link : function(scope, element, attrs) {
				element[0].focus();
			}
		}
	});
	
	// 커스텀 지시자 hello 태그 생성
	/**
		directive : 기본형식 - 모듈.directive(이름, 함수);
					속성 혹은 태그를 작성하여 HTML안에 특수한 기능을 추가하는 것
	
		restrict의 종류 
			E : element
			A : attribute
			C : class
			M : comment
			
		replace : directive를 사용한 HTML의 태그에 template 또는 emplateUrl에 포함된 태그 내용을 추가할지 교체할지 설정. 
				  true로 설정할 경우 HTML의 디렉티브를 사용한 태그를 template 또는 templateUrl에 작성된 내용으로 교체합니다.
				  false로 설정할 경우 template 또는 templateUrl에 작성된 내용이 추가됨
		template : directive를 사용한 부분에 보여줄 내용
	*/
	myApp.directive('hello', function(){
		return {
			restrict: "E",
			replace: true,
			template: "<div>Hello readers , thank you for coming</div>"
		}
	});
</script>
</head>
<body  ng-app="myapp">
	name : <input type="text">
	phone : <input type="text" focus>
	
	<hello></hello>
</body>
</html>
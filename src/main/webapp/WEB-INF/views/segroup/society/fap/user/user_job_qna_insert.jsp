<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Bridge Job Fair</title>
	<link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
	<link type="text/css" rel="stylesheet" href="<c:url value="/resources/segroup/society/fap/css/popModal.css" />">
	<link rel="stylesheet" type="text/css" href="<c:url value="/resources/segroup/society/fap/css/default.css" />" />
	<link type="text/css" rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto:400,500">		
	<script src="<c:url value="/resources/segroup/js/jquery-3.1.1.js" />"></script>
	<script src="<c:url value="/resources/segroup/js/jquery-ui.js" />"></script>
	<script src="<c:url value="/resources/segroup/js/angular.min.js" />"></script>	
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
	<script type="text/javascript">
		var myApp = angular.module('myapp', []);		
		
		myApp.controller('RequiredDocController', ['$scope','$compile','$http', function($scope,$compile,$http){
			
		}]);		
		
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
		} ]);
	
		myApp.directive('selectcode', [ '$http', function($http) {
			return {
				restrict : "A",
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
				template : "<option>{{filterParams}}</option>"
			}
		} ]);
	
	</script>
	<script type="text/javascript">
			
		function insert() {
			$("#insert_job_qna").submit();
		}
	</script>
	
	
</head>
<body ng-app="myapp" ng-controller="RequiredDocController">
	<%@include file="user_menu.jsp"%>

<div class="join-wrap">
	<div id="subcontents">
		<div class="joinBox">
			<div id="qna-q">
				<form action="/fap/user/user_job_qna_insert" method="post" id="insert_job_qna">
					<div id="hidden-box">
						<input type="hidden" name="fap_job_ad_seq" value="${fap_job_ad_seq}">
					</div>
					<table class="board_view">
						<colgroup>
							<col width="17%"/>
							<col width="58%"/>
							<col width="10%"/>
							<col width="15%"/>
						</colgroup>
						<tbody>
							<tr>
								
							    <th scope="row"><spring:message code="fap.jobad.qna.question_title" /></th>
							    <td colspan="3">
							       	<input name="fap_job_qna_question_title" class="qna-q-title" type="text">
							    </td>
							</tr>
							<tr>
								<th scope="row"><spring:message code="fap.jobad.qna.question_content" /></th>
							    <td colspan="3">
									<textarea name="fap_job_qna_question_content" class="qna-q-content" rows="" cols=""></textarea>
							    </td>
							    
							</tr>
						</tbody>
					</table>
				</form>
			</div>
			
			<div class="boardManagerDiv">
				<a href="javascript:insert()"><button class="job-qna-btn">등록</button></a>
				<a href="/fap/user/user_job_qna_management?fap_job_ad_seq=${fap_job_ad_seq}"><button id="boardListBtn"><spring:message code="fap.jobfair.main.board.list" /></button></a>
				<a href="/fap/user/user_main"><button id="boardMainBtn"><spring:message code="fap.jobfair.main.board.main" /></button></a>
			</div>
			<br><br><br><br>
		</div>
	</div>
</div>



	<%@include file="../common_footer_fap.jsp"%>
		
	

	
</body>
</html>
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
			
			var job_qna_list = '${job_qna_list}';
			
			job_qna_list = job_qna_list.replace(/(?:\r\n|\r|\n)/g, '\\r\\n');
		   
			job_qna_list = JSON.parse(job_qna_list);
			
			var context = '';
			if(job_qna_list.length == 0){
				 context += '<ul class="qnatitle2">';
				 context += '	<li class="wid16"><spring:message code="fap.jobad.qna.no_question" /></li>';
				 context += '</ul>';
				 
			}else{
				for(var i in job_qna_list){
					context += '<ul class="qnatitle2">';
					 context += '	<li class="wid12">' + (Number(i) + 1) + '</li>';
					 context += '	<li class="wid15"><a href="/fap/user/user_job_qna?fap_job_qna_question_seq=' + job_qna_list[i].fap_job_qna_question_seq + '">' + job_qna_list[i].fap_job_qna_question_title;
					if(job_qna_list[i].fap_job_qna_refuse_reason != null){
						/* context += ' (<spring:message code="fap.comp.agency_connect_refusal" />)'; */
						/* (거절) 메세지 감춤 */
					}
					context +=  '</a></li>';
					 context += '	<li class="wid12"><code value="' + job_qna_list[i].fap_job_qna_question_per + '"></code></li>';
					 context += '	<li class="wid12"><code value="' + job_qna_list[i].fap_job_qna_question_state + '"></code></li>';
					
					
					
					 context += '	<li class="wid12">' + job_qna_list[i].fap_job_qna_question_udt_dt + '</li>';
					 
					 context += '</ul>';
				}
			}
			
			
			$("#board_div").append($compile(context)($scope));
			
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
			
		
	</script>
	
	
</head>
<body ng-app="myapp" ng-controller="RequiredDocController">
	<%@include file="user_menu.jsp"%><%@include file="user_quick_menu.jsp"%>

	<div id="subcontents">
		<div id="qnaBBS">
			<div>
				<ul class="qnatitle">
					<li class="wid12"><spring:message code="fap.jobfair.main.board.no" /></li>
					<li class="wid15"><spring:message code="fap.jobad.qna.question_title" /></li>
					<li class="wid12">승인여부</li>
					<li class="wid12"><spring:message code="fap.jobad.qna.is_question" /></li>
					
					<li class="wid12"><spring:message code="fap.jobfair.main.board.indate" /></li>
				</ul>
			</div>
			<div id="board_div">
			
			
			</div>
		</div>

		<div class="qnaBtnDiv">
			<a href="/fap/user/user_job_qna_insert?fap_job_ad_seq=${fap_job_ad_seq}"><button class="job-qna-btn">질문등록</button></a>
			<a href="/fap/user/user_job_advertisement_list_form"><button id="boardListBtn"><spring:message code="fap.jobfair.main.board.list" /></button></a>
			<a href="/fap/user/user_main"><button id="boardMainBtn"><spring:message code="fap.jobfair.main.board.main" /></button></a>
		</div>

	</div>

	<%@include file="../common_footer_fap.jsp"%>
		
	

	
</body>
</html>
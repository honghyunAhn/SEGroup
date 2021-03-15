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
		$(function() {
		
			
			
		});
		
		
	</script>
	<script type="text/javascript">
		var myApp = angular.module('myapp', []);		
		
		myApp.controller('RequiredDocController', ['$scope','$compile','$http', function($scope,$compile,$http){
				
				
			
			var job_qna = '${job_qna_json}';
			job_qna = JSON.parse(job_qna);
			console.log(job_qna);
			
			var fap_job_ad_seq = '${fap_job_ad_seq}';
			console.log(fap_job_ad_seq);
			
			
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
	<%@include file="agency_menu.jsp"%>

<div class="join-wrap">
	<div id="subcontents">
		<div class="joinBox">
			<div id="qna-q">
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
						    <td>
						       	${job_qna.fap_job_qna_question_title}
						    </td>
						    <th scope="row"><spring:message code="fap.jobfair.main.board.indate" /></th>
					    	<td>
					    		${job_qna.fap_job_qna_question_udt_dt}
					    	</td>
						</tr>
						<tr>
							<th scope="row"><spring:message code="fap.jobad.qna.question_content" /></th>
						    <td colspan="3">
								${job_qna.fap_job_qna_question_content}
						    </td>
						    
						</tr>
					</tbody>
				</table>
			</div>
			<div id="qna-a">
				<c:if test="${job_qna.fap_job_qna_question_state eq 'C1100'}">
					<!-- 답변 등록 -->
					<form action="/fap/agency/agency_job_qna_answer_insert" method="post">
						<input type="hidden" name="fap_job_qna_question_seq" value="${job_qna.fap_job_qna_question_seq}">
						<input type="hidden" name="fap_job_ad_seq" value="${job_qna.fap_job_ad_seq}">
						<table class="board_view">
							<tr>
								<td>
									<textarea name="fap_job_qna_answer_content" rows="5" cols="5" id="job-qna-input"></textarea>
								</td>
								<td>
									<button id="job-qna-btn" type="submit" onsubmit=""><spring:message code="fap.common.join.btn" /></button>
								</td>
							</tr>
						</table>
					</form>
				</c:if>
				<c:if test="${job_qna.fap_job_qna_question_state eq 'C1101'}">
					<!-- 답변 수정 -->
					<form action="/fap/agency/agency_job_qna_answer_update" method="post">
						<input type="hidden" name="fap_job_qna_answer_seq" value="${job_qna.jobQNAa.fap_job_qna_answer_seq}">
						<input type="hidden" name="fap_job_ad_seq" value="${job_qna.fap_job_ad_seq}">
						<table class="board_view">
							<tr>
								<td>
									<textarea name="fap_job_qna_answer_content" rows="5" cols="5" id="job-qna-input">${job_qna.jobQNAa.fap_job_qna_answer_content}</textarea>
								</td>
								<td>
									<button id="job-qna-btn" type="submit"><spring:message code="fap.common.update.btn" /></button>
								</td>
							</tr>
						</table>
					</form>
				</c:if>
			</div>
			
			
			<div class="boardManagerDiv">
				<a href="/fap/agency/agency_job_qna_management?fap_job_ad_seq=${job_qna.fap_job_ad_seq}"><button id="boardListBtn"><spring:message code="fap.jobfair.main.board.list" /></button></a>
				<a href="/fap/agency/agency_main"><button id="boardMainBtn"><spring:message code="fap.jobfair.main.board.main" /></button></a>
			</div>
			<br><br><br><br>
		</div>
	</div>
</div>



	<%@include file="agency_footer.jsp"%>
		
	

	
</body>
</html>
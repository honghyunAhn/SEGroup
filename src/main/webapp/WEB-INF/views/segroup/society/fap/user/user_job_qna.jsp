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
	
		$(document).ready(function(){
			var is_editable = false;
			is_editable = ${is_editable};
			if(is_editable){
				$("#qna_title").prop("disabled", false);
				$("#qna_content").prop("disabled", false);
			}
			$("#qna_content").css('height', $('#qna_content').prop('scrollHeight')+12);
			$("#job-qna-input").css('height', $('#job-qna-input').prop('scrollHeight')+12);
			//
		});

		function update() {
			if(confirm("정말로 수정하시겠습니까?")){
				$("#update_form").submit();
			}
		}
		
		function delete_func() {
			if(confirm("정말로 삭제하시겠습니까?")){
				location.href = "/fap/user/user_job_qna_delete?fap_job_qna_question_seq=" + "${job_qna.fap_job_qna_question_seq}" + "&fap_job_ad_seq=" + "${job_qna.fap_job_ad_seq}";
			}
		}
	</script>
</head>
<body ng-app="myapp" ng-controller="RequiredDocController">
	<%@include file="user_menu.jsp"%><%@include file="user_quick_menu.jsp"%>

<div class="join-wrap">
	<div id="subcontents">
		<div class="joinBox">
			<div id="qna-q">
				<form action="/fap/user/user_job_qna_update" method="post" id="update_form">
					<input type="hidden" name="fap_job_qna_question_seq" value="${job_qna.fap_job_qna_question_seq}">
					<input type="hidden" name="fap_job_ad_seq" value="${job_qna.fap_job_ad_seq}">
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
							       	<input name="fap_job_qna_question_title" type="text" id="qna_title" value="${job_qna.fap_job_qna_question_title}" disabled="disabled">
							    </td>
							    <th scope="row"><spring:message code="fap.jobfair.main.board.indate" /></th>
						    	<td>
						    		${job_qna.fap_job_qna_question_udt_dt}
						    	</td>
							</tr>
							<tr>
								<th scope="row"><spring:message code="fap.jobad.qna.question_content" /></th>
							    <td colspan="3">
							    	<textarea name="fap_job_qna_question_content" id="qna_content" disabled="disabled">${job_qna.fap_job_qna_question_content}</textarea>
							    </td>
							    
							</tr>
						</tbody>
					</table>
				</form>
			</div>
			<div id="qna-a">
				<!-- 거절사유 -->
				<c:choose>
					<c:when test="${job_qna.fap_job_qna_question_state eq 'C1101'}">
						<!-- 답변  -->
						<input type="hidden" name="fap_job_qna_question_seq" value="${job_qna.fap_job_qna_question_seq}">
						<input type="hidden" name="fap_job_ad_seq" value="${job_qna.fap_job_ad_seq}">
						<table class="board_view">
							<tr>
								<td>
									<textarea disabled="disabled" name="fap_job_qna_answer_content"  id="job-qna-input">${job_qna.jobQNAa.fap_job_qna_answer_content }</textarea>
								</td>
							</tr>
						</table>
					</c:when>
					<c:when test="${job_qna.fap_job_qna_refuse_reason ne null and job_qna.fap_job_qna_refuse_reason ne ''}">
						<table class="board_view">
							<tr>
								<td>
									<textarea disabled="disabled" name="fap_job_qna_answer_content" rows="5" cols="5" id="job-qna-input">${job_qna.fap_job_qna_refuse_reason }</textarea>
								</td>
							</tr>
						</table>
					</c:when>
					<c:otherwise>
						
					</c:otherwise>
					
				</c:choose>
				
				
			</div>
			
			
			<div class="boardManagerDiv">
				<c:if test="${is_editable}">
					<button onclick="update()" id="boardListBtn" type="button">수정</button>
					<button onclick="delete_func()" id="boardListBtn" type="button">삭제</button>
				</c:if>
				<a href="/fap/user/user_job_qna_management?fap_job_ad_seq=${job_qna.fap_job_ad_seq}"><button id="boardListBtn"><spring:message code="fap.jobfair.main.board.list" /></button></a>
				<a href="/fap/user/user_main"><button id="boardMainBtn"><spring:message code="fap.jobfair.main.board.main" /></button></a>
			</div>
			<br><br><br><br>
		</div>
	</div>
</div>



	<%@include file="../common_footer_fap.jsp"%>
		
	

	
</body>
</html>
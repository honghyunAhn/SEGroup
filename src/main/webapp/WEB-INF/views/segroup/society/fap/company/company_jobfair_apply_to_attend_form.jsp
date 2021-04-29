<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Bridge Job Fair</title>
	<script src="<c:url value="/resources/segroup/js/jquery-3.1.1.js" />"></script>
	<script src="<c:url value="/resources/segroup/js/jquery-ui.js" />"></script>
	<script src="<c:url value="/resources/segroup/js/angular.min.js" />"></script>
	
	<link rel="stylesheet" type="text/css" href="<c:url value="/resources/segroup/society/fap/css/default.css" />" />
	<link type="text/css" rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto:400,500">
	<link type="text/css" rel="stylesheet" href="<c:url value="/resources/segroup/society/fap/css/popModal.css" />">
	
	<script type="text/javascript">
		$(function() {
			$('#nav li').hover(function() {
				$('ul', this).slideDown(200);
				$(this).children('a:first').addClass("hov");
			}, function() {
				$('ul', this).slideUp(100);
				$(this).children('a:first').removeClass("hov");		
			});
		});
	</script>
	
	<script type="text/javascript">	
			
		var myApp = angular.module('myapp', []);		
			
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
		}]);		
		
		//잡페어 출력
		myApp.controller('MainController', ['$scope','$compile','$http', function($scope,$compile,$http){
			$http({
				method: 'POST',
				url: '/fap/company/jobfair_search_list',
				headers : {
					"AJAX" : true
				}
			}).then(function successCallback(response) {
				$scope.jobfair_draw(response.data);	
			}, function errorCallback(response) {
				if(response.status == 403){
					alert('<spring:message code="com.login.ajaxSesstion" javaScriptEscape="true" />');
					location.href = "/fap/company/company_login";
				}
			});
			
			//잡페어
			$scope.jobfair_draw = function(result){		
				$('#fairBox').children().remove();
				var context = '';
				for(var i in result){
					context += '<div id="fair">';
					
					context += '<div class="fairleft">';
					context += '<img src="/fap/admin/jobfair_logo_image/'+result[i].fapJobfairList[0].fap_jobfair_log_saved+'" />';
					context += '</div>';
					
					context += '<div id="fairright">';
					
					context += '<div id="tit_f">';
					context += result[i].fapJobfairList[0].fap_jobfair_title;
					context += '</div>';
					
					context += '<ul id="fairbbs1">';
					context += '<li class="msgbox"><spring:message code="fap.jobfair.fair_schedule" /></li>';//일정
					context += '<li class="msgbox2">' + result[i].fapJobfairList[0].fap_jobfair_st + ' ~ ' + result[i].fapJobfairList[0].fap_jobfair_et + '</li>';
					context += '</ul>';
					
					context += '<ul id="fairbbs2">';
					context += '<li class="msgbox"><spring:message code="fap.jobfair.place_hold" /></li>';//개최지
					context += '<spring:message var="attendButton" code="fap.jobfair.attend_jobfair" />';
					
					if(result[i].fapJobfairLoList.length == 2){
						context += '<li class="fairbbs2"><spring:message code="fap.jobfair.place_hold" /> : <code value="C0000" style="display: inline;"></code>, <code value="C0001" style="display: inline;"></code></li>';
					}
					
					else if(result[i].fapJobfairLoList.length == 1 && result[i].fapJobfairLoList[0].fap_jobfair_lo == 'C0000'){
						context += '<li class="fairbbs2"><spring:message code="fap.jobfair.place_hold" /> : <code value="C0000" style="display: inline;"></code></li>';
					}
					
					else if(result[i].fapJobfairLoList.length == 1 && result[i].fapJobfairLoList[0].fap_jobfair_lo == 'C0001'){
						context += '<li class="fairbbs2" ><spring:message code="fap.jobfair.place_hold" /> : <code value="C0001" style="display: inline;"></code></li>';
					}
					context += '</ul>';		
					context += '<div class="fairbtn"><button class="btn btn-primary" ng-click="compJobfairParticipation('+result[i].fapJobfairList[0].fap_jobfair_seq+')"><spring:message code="fap.jobfair.attend_jobfair" /></button></div>';
					
				context += '</div>';
				context += '</div>';
				}
				$('#fairBox').prepend($compile(context)($scope));				

			}
			
			//잡페어 세부선택 페이지로 이동
			$scope.compJobfairParticipation = function(fap_jobfair_seq){
				var fap_jobfair_seq = fap_jobfair_seq;
				location.href="/fap/company/company_jobfair_participation?fap_jobfair_seq=" + fap_jobfair_seq;
			}
		}]);	
	</script>
	
</head>
<body ng-app="myapp" ng-controller="MainController">
<%@include file="company_menu.jsp"%>
<div class="join-wrap">
	<div id="subcontents">
		<div>
			<h1><spring:message code="fap.common.attend_jobfair" /></h1>
			<h6><spring:message code="fap.jobfair.select_jobfair_to_comment" /></h6>
		</div>
		  
		<div id="fairBox">
		
		</div>
	</div>
</div>
<%@include file="../common_footer_fap.jsp"%>
</body>
</html>
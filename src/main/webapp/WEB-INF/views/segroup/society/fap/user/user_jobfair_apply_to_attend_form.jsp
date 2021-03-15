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
	<script src="<c:url value="/resources/segroup/js/angular.min.js" />"></script>
	
	<link rel="stylesheet" type="text/css" href="<c:url value="/resources/segroup/society/fap/css/userDefault.css" />" />
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
			
		//잡페어 세부선택 페이지로 이동
		function userJobfairParticipationApply(fap_jobfair_seq) {
			alert(fap_jobfair_seq)
		}
		
		function checkConfirm() {
			var realApply = confirm('정말 지원하시겠습니까?');
			if(realApply == false){
				return false;
			}
		}
	</script>
	
</head>
<body ng-app="myapp">
<sec:authorize access="isAuthenticated()">
	<sec:authentication property="details" var="check"/>
	<input type="hidden" id="user_flag" value="${check.user.user_flag }" />
</sec:authorize>
<%@include file="user_menu.jsp"%>
<div class="join-wrap">
	<div id="subcontents">
		<div>
			<h1><spring:message code="fap.common.attend_jobfair" /></h1>
			<h6><spring:message code="fap.jobfair.select_jobfair_to_comment" /></h6>
		</div>
		  
		<div id="fairBox">
			<c:forEach var="jobfairInfo" items="${jobfairInfoList}" varStatus="status">		
				<div id="fair">
					<div class="fairleft">
						<c:if test="${jobfairInfo.fap_jobfair_log_saved ne null}">
							<img alt="img${status.count}" src="/fap/admin/jobfair_logo_image/${jobfairInfo.fap_jobfair_log_saved}">
						</c:if>	
					</div>
					
					<div id="fairright">
						<div id="tit_f">
							${jobfairInfo.fap_jobfair_title}
						</div>
						
						<ul id="fairbbs1">
							<li class="msgbox">일정</li>
							<li class="msgbox2">${jobfairInfo.fap_jobfair_st} ~ ${jobfairInfo.fap_jobfair_et}</li>
						</ul>
						
						<ul id="fairbbs2">
							<li class="msgbox">개최지</li>
							<li class="fairbbs2">
								<c:forEach var="jobfairloInfo" items="${jobfairInfo.jobfairLoList}" varStatus="status">
									<code value="${jobfairloInfo}" style="display: inline;"></code>
								</c:forEach>
							</li>	
						</ul>
						<c:choose>
							<c:when test="${jobfairInfo.fap_jobfair_user_per eq 'C1000'}">
								<div class="fairbtn">
									<button class="btn btn-primary">
										승인 대기중
									</button>
								</div>
							</c:when>
							<c:when test="${jobfairInfo.fap_jobfair_user_per eq 'C1001'}">
								<div class="fairbtn">
									<form method="get" action="<c:url value="/fap/user/user_jobfair_participation_form" />">
										<input type="hidden" name="fap_jobfair_seq" value="${jobfairInfo.fap_jobfair_seq}">
										<button class="btn btn-primary">
											세부 선택으로 이동
										</button>
									</form>
								</div>
							</c:when>
							<c:otherwise>
								<div class="fairbtn">
									<form method="post" action="<c:url value="/fap/user/entry_request" />" onsubmit="return checkConfirm();">
										<input type="hidden" name="fap_jobfair_seq" value="${jobfairInfo.fap_jobfair_seq}">
										<input type="hidden" name="fap_jobfair_title" value="${jobfairInfo.fap_jobfair_title}">
										<button class="btn btn-primary">
											참가 신청
										</button>
									</form>
								</div>
							</c:otherwise>
						</c:choose>
					</div>
				</div>
			</c:forEach>	
		</div>
	</div>
</div>
<%@include file="../common_footer_fap.jsp"%>
</body>
</html>
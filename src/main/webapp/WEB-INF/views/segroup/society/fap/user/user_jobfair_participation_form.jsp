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
	
	<link rel="stylesheet" type="text/css" href="<c:url value="/resources/segroup/society/fap/css/userDefault.css" />" />
	<link rel="stylesheet" type="text/css" href="<c:url value="/resources/segroup/society/fap/css/popModal.css" />" />
	
	<script type="text/javascript">
		$(function() {
			$('#logout').off("click").on("click", function() {
				$('#logoutForm').submit();
				return false;
			});
			
			//[start] 디자인에 필요한 코드 시작
			$('#nav li').hover(function() {
				$('ul', this).slideDown(200);
				$(this).children('a:first').addClass("hov");
			}, function() {
				$('ul', this).slideUp(100);
				$(this).children('a:first').removeClass("hov");		
			});
			//[end] 디자인에 필요한 코드 종료
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
		
		myApp.controller('ParticipationController', ['$scope', '$compile', function($scope, $compile) {

		}]);
		
	</script>
	
</head>
<body ng-app="myapp">

<%@include file="user_menu.jsp"%>
	 
<div class="join-wrap">	 
	<div id="subcontents">
	
		<h1>잡페어 참가</h1>
		<h6><span class="red">참가할 세부 Fair를 선택하세요(복수참가시 각각 신청해주세요)</span></h6>

		<h6>※참가기업의 수의 따라, 예정보다 일찍 마감할 수도 있습니다.</h6>
		
		<div id="fairctr">
		
			<c:forEach var="jobfairDivideInfo" items="${jobfairDivideInfoList}" varStatus="status">
				<!-- 반복문 시작 -->
			  <ul>
			   <li>
				<div id="faircheck${status.count}">
					<input type="hidden" name="fap_jobfair_seq" value="${jobfairDivideInfo.fap_jobfair_seq}">	
		    			
	    			<!-- K-fair -->
	    			<c:if test="${jobfairDivideInfo.fap_jobfair_divide_gb == 'C0100'}">
	   					<img src="<c:url value="/resources/segroup/society/fap/images/faircheck1.jpg" />" />
	   				</c:if>
	   				
	   				<!-- J-fair -->
	   				<c:if test="${jobfairDivideInfo.fap_jobfair_divide_gb == 'C0101'}">
						<img src="<c:url value="/resources/segroup/society/fap/images/faircheck2.jpg" />" />
					</c:if>	
					
					<!-- 포스트시즌 -->
					<c:if test="${jobfairDivideInfo.fap_jobfair_divide_gb == 'C0102'}">
						<img src="<c:url value="/resources/segroup/society/fap/images/faircheck3.jpg" />" />
					</c:if>
						
					<!-- 진행기간 -->	
		    		<ul id="faircheckBoxs1">
		    			<li class="msgbox">진행기간</li>
		   				<li class="msgbox2">${jobfairDivideInfo.fap_jobfair_divide_st} ~ ${jobfairDivideInfo.fap_jobfair_divide_et}</li>
		   			 </ul>
		    	
		    		<!-- 참가 가능 기간 -->
		    		<ul id="faircheckBoxs2">
		    			<li class="msgbox">신청기간</li>
		    			<li class="msgbox2">${jobfairDivideInfo.fap_jobfair_divide_app_st} ~ ${jobfairDivideInfo.fap_jobfair_divide_app_et}</li>
		    		</ul>
		              
		            <!-- 구분 -->
		    		<ul id="faircheckBoxs3">
		    			<li class="msgbox">구분</li>
		    			<li class="msgbox2"><code value="${jobfairDivideInfo.fap_jobfair_divide_gb}"></code></li>
		    		</ul>
		            
		            <!-- 설명 -->    
		    		<ul id="faircheckBoxs4">
		   				<li class="msgbox">설명</li>
		    			<li class="msgbox2">
		    				<textarea readonly="readonly">${jobfairDivideInfo.fap_jobfair_divide_detail}</textarea>
		    			</li>
		    		</ul>
		    		
		    		<c:choose>
			    		<c:when test="${jobfairDivideInfo.fap_jobfair_divide_app_st <= jobfairDivideInfo.to_day and jobfairDivideInfo.to_day <= jobfairDivideInfo.fap_jobfair_divide_app_et}">
			    			<form action="<c:url value="/fap/user/user_main" />" method="get">
								<div class="faircheckBtn">
									<button class="btn btn-primary">신청완료</button>
								</div>				
							</form>	
						</c:when>
						<c:otherwise>
							<div class="faircheckBtn">
								<button class="btn btn-primary">참가기간이 아닙니다.</button>
							</div>	
						</c:otherwise>
					</c:choose>
				</div>
			  </li>
			 </ul>
				<!-- 반복문 종료 -->
			</c:forEach>
		</div>
	</div>
</div>

<%@include file="../common_footer_fap.jsp"%>		
</body>
</html>
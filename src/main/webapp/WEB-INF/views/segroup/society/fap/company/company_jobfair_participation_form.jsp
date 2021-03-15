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
	
	<link type="text/css" rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto:400,500">
	<link rel="stylesheet" type="text/css" href="<c:url value="/resources/segroup/society/fap/css/default.css" />" />
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
	<script type="text/javascript">
		$(document).ready(function(){
			var fap_comp_id_ck = "${fap_comp_id_ck}";
			if( fap_comp_id_ck != ""){
				alert('<spring:message code="fap.err.comp.id_check" />');
				location.href="/fap/company/company_login_success";
			}
		});
		
		function jobfairDivideJoin(divide_seq){
			if($(this).prop('disabled') == true){
				return false;
			}
			$(this).prop('disabled', true);
			
			//오늘 날짜 설정
			var today = new Date();
			var dd = today.getDate();
			var mm = today.getMonth() + 1;
			var yyyy = today.getFullYear();
			
			if(dd < 10){
				dd = '0' + dd;
			}
			if(mm < 10){
				mm = '0' + mm;
			}	
			today = yyyy + '-' +  mm + '-' + dd;
				
			if($('#jobfairDivideJoinBtn'+divide_seq).attr('app_st') <= today && today <= $('#jobfairDivideJoinBtn'+divide_seq).attr('app_et')){
				var participation = confirm('<spring:message code="fap.err.comp.participation.confirm" />');
				if(participation){
					var fap_jobfair_seq = $('[name="fap_jobfair_seq"]').val();
					var fap_jobfair_divide_seq = divide_seq;
					
					$.ajax({
						beforeSend: function(xhr) {
						     xhr.setRequestHeader("AJAX", true);
						}
						, type : "POST"
						, url : "/fap/company/company_jobfair_divide_participation"
						, data : {fap_jobfair_seq : fap_jobfair_seq , fap_jobfair_divide_seq : fap_jobfair_divide_seq}
						, success : function(data) {
							$(this).prop('disabled', false);
							if(data == null){
								alert('<spring:message code="fap.err.comp.id_check" />');
							}
							location.reload();
						},
						error : function(e) {
							$(this).prop('disabled', false);
							console.log(e);
							if(e.status == 403){
								alert('<spring:message code="com.login.ajaxSesstion" javaScriptEscape="true" />');
								location.href = "/fap/company/company_login";
							}
						}
					});
				}else{
					$(this).prop('disabled', false);
					return;
				}
			}else{
				$(this).prop('disabled', false);
				alert('<spring:message code="fap.jobfair.apply_dt_check" javaScriptEscape="true" />');
				return;
			}
		}
	</script>
	
</head>
<body ng-app="myapp" ng-controller="ParticipationController">

<%@include file="company_menu.jsp"%>
	 
<div class="join-wrap">	 
	<div id="subcontents">
	
		<h1><spring:message code="fap.common.attend_jobfair" /></h1>
		<h6><span class="red"><spring:message code="fap.jobad.select_jobfair_to_attend" /></span></h6>

		<h6><spring:message code="fap.jobfair.select_jobfair_to_comment" /></h6>
		
		<div id="fairctr">
		
			<c:forEach var="result" items="${jobfairDivideList}" varStatus="status">
				<!-- 반복문 시작 -->
			  <ul>
			   <li>
				<div id="faircheck${status.count}">
					<input type="hidden" name="fap_jobfair_seq" value="${result.fap_jobfair_seq}">	
		    			
	    			<!-- K-fair -->
	    			<c:if test="${result.fap_jobfair_divide_gb == 'C0100'}">
	   					<img src="<c:url value="/resources/segroup/society/fap/images/faircheck1.jpg" />" />
	   				</c:if>
	   				
	   				<!-- J-fair -->
	   				<c:if test="${result.fap_jobfair_divide_gb == 'C0101'}">
						<img src="<c:url value="/resources/segroup/society/fap/images/faircheck2.jpg" />" />
					</c:if>	
					
					<!-- 포스트시즌 -->
					<c:if test="${result.fap_jobfair_divide_gb == 'C0102'}">
						<img src="<c:url value="/resources/segroup/society/fap/images/faircheck3.jpg" />" />
					</c:if>
						
					<!-- 진행기간 -->	
		    		<ul id="faircheckBoxs1">
		    			<li class="msgbox"><spring:message code="fap.jobfair.pcs_term" /></li>
		   				<li class="msgbox2">${result.fap_jobfair_divide_st} ~ ${result.fap_jobfair_divide_et}</li>
		   			 </ul>
		    	
		    		<!-- 참가 가능 기간 -->
		    		<ul id="faircheckBoxs2">
		    			<li class="msgbox"><spring:message code="fap.jobfair.attendable_term" /></li>
		    			<li class="msgbox2">${result.fap_jobfair_divide_app_st} ~ ${result.fap_jobfair_divide_app_et}</li>
		    		</ul>
		              
		            <!-- 구분 -->
		    		<ul id="faircheckBoxs3">
		    			<li class="msgbox"><spring:message code="fap.common.gb" /></li>
		    			<li class="msgbox2"><code value="${result.fap_jobfair_divide_gb}"></code></li>
		    		</ul>
		            
		            <!-- 설명 -->    
		    		<ul id="faircheckBoxs4">
		   				<li class="msgbox"><spring:message code="fap.common.explanation" /></li>
		    			<li class="msgbox2"><textarea class="explanation_textarea" readonly="readonly">${result.fap_jobfair_divide_detail}</textarea></li>
		    		</ul>
		    		
		  		 	<!-- 아래부터 버튼 코드 --> 
					<c:set var="loop_flag" value="false" />
					<c:forEach var="list" items="${participationInfo}">
						<c:if test="${result.fap_jobfair_divide_seq == list.fap_jobfair_divide_seq}">
							<c:set var="loop_flag" value="true" />
						</c:if>
					</c:forEach>
					<c:if test="${loop_flag == false}">
						<div class="faircheckBtn">
							<button id="jobfairDivideJoinBtn${result.fap_jobfair_divide_seq}" class="btn btn-primary" value="${result.fap_jobfair_divide_seq}" app_st="${result.fap_jobfair_divide_app_st }" app_et="${result.fap_jobfair_divide_app_et}" onclick="jobfairDivideJoin(${result.fap_jobfair_divide_seq});">
								<spring:message code="fap.jobfair.attend_jobfair" />
							</button>
						</div>		
					</c:if>	
					<form action="company_job_ad_management" method="get">
						<input type="hidden" name="fap_jobfair_seq" value="${result.fap_jobfair_seq}">	
						<input type="hidden" name="fap_jobfair_divide_seq" value="${result.fap_jobfair_divide_seq}">	
						<c:if test="${loop_flag == true}">
							<div class="faircheckBtn">
								<button class="btn btn-primary"><spring:message code="fap.jobad.manage_and_write_jobad" /></button>
							</div>
						</c:if>				
					</form>					
				</div>
			  </li>
			 </ul>
				<!-- 반복문 종료 -->
			</c:forEach>
		</div>
	</div>
</div>

<%@include file="company_footer.jsp"%>		
</body>
</html>
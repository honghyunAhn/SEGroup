<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Bridge Job Fair</title>
</head>
<script src="<c:url value="/resources/segroup/js/jquery-3.1.1.js" />"></script>
<script src="<c:url value="/resources/segroup/js/angular.min.js" />"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
<script src="<c:url value="/resources/segroup/js/jquery-ui.js" />"></script>
<script src="<c:url value="/resources/segroup/js/angular.min.js" />"></script>

<link type="text/css" rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto:400,500">
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/segroup/society/fap/css/default.css" />" />
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/segroup/society/fap/css/popModal.css" />" />
<script type="text/javascript">

	var myApp = angular.module('myapp', []);
	
	myApp.controller('ConnectManagementController',['$scope','$compile', '$http', function($scope, $compile, $http) {
		
		 $scope.connect_request = function () {
				var fap_comp_ja_nm = $('#fap_comp_ja_nm').val();
				var fap_comp_en_nm = $('#fap_comp_en_nm').val();
				
				if(fap_comp_ja_nm == ''){
					alert('<spring:message code="fap.err.comp_ja_name_input" />');
					return;
				}
				
				$http({
					url : '/fap/agency/connect_request'
					, method : 'post'
					, params : {
						fap_comp_ja_nm : fap_comp_ja_nm
						, fap_comp_en_nm : fap_comp_en_nm
					},
					headers : {
						"AJAX" : true
					}
				}).then(function successCallback(response) {
						if(response.data == 0){
							alert('<spring:message code="fap.comp.error_occurrence" />');
						} else if(response.data == 1){
							alert('<spring:message code="fap.comp.agency_connect_request_alert" />');
							location.reload();
						}
				   }, function errorCallback(response) {
					   if(response.status == 403){
							alert('<spring:message code="com.login.ajaxSesstion" javaScriptEscape="true" />');
							location.href = "/fap/agency/agency_login";
						}
				});
				
			}
			
			$scope.delete_request = function () {
				var fap_comp_user_request_seq = $('#fap_comp_user_request_seq').val();
				
				$http({
					url : '/fap/agency/connect_request_delete'
					, method : 'post'
					, params : {
						fap_comp_user_request_seq : fap_comp_user_request_seq
					},
					headers : {
						"AJAX" : true
					}
				}).then(function successCallback(response) {
						if(response.data == 0){
							alert('<spring:message code="fap.comp.error_occurrence" />');
						} else if(response.data == 1){
							alert('<spring:message code="fap.comp.agency_connect_delete_alert" />');
							location.reload();
						}
				   }, function errorCallback(response) {
					   if(response.status == 403){
							alert('<spring:message code="com.login.ajaxSesstion" javaScriptEscape="true" />');
							location.href = "/fap/agency/agency_login";
						}
				});
				
			}
		
	}]);
		
	
</script>
<body ng-app="myapp" ng-controller="ConnectManagementController">
<%@include file="agency_menu.jsp"%>
<div class="join-wrap">
	<div id="subcontents">
		<div id="company_insert">
			<c:if test="${CompUserConnectRequest != '[]' }">
				<div class="joinBox">
					<div class="jointt">
						<p class="jointxt1">
					        <spring:message code="fap.comp.responsible_person_connect" />
						</p>
					</div>
						<c:forEach var="data" items="${CompUserConnectRequest}">
							<input type="hidden" value="${data.fap_comp_user_request_seq}" id="fap_comp_user_request_seq">
							<div class="join-contents">
								<div class="joinBBS">
									<div class="joinBBS-row">
										<!-- 기업명 일문 -->
										<div class="joinlt"><spring:message code="fap.comp.ja_nm" /></div>
										<div class="joinrt"><input type="text" id="fap_comp_ja_nm" class="input" maxlength="50" value="${data.fap_comp_ja_nm}" readonly="readonly"></div>
									</div>
									<div class="joinBBS-row">
										<!-- 기업명 영문 -->
										<div class="joinlt"><spring:message code="fap.comp.en_nm" /></div>
										<div class="joinrt"><input type="text" id="fap_comp_en_nm" class="input" maxlength="50" value="${data.fap_comp_en_nm}" readonly="readonly"></div>
									</div>
								</div>
							</div>
						</c:forEach>
				</div>
				<div class="joinBox">			
					<div id="joinBtn">
						<button type="button" class="join-btn icon submitBtn" ng-click="delete_request()"><spring:message code="fap.comp.responsible_person_connect_delete"/></button>
					</div>
				</div>
			</c:if>
						
			<c:if test="${CompUserConnectRequest == '[]' }">
				<div class="joinBox">
					<div class="jointt">
						<p class="jointxt1">
					        <spring:message code="fap.comp.responsible_person_connect" />
						</p>
					</div>
					<div class="join-contents">
						<div class="joinBBS">
							<div class="joinBBS-row">
								<!-- 기업명 일문 -->
								<div class="joinlt"><spring:message code="fap.comp.ja_nm" /></div>
								<div class="joinrt"><input type="text" id="fap_comp_ja_nm" class="input" maxlength="50" name="fap_comp_ja_nm"></div>
							</div>
							<div class="joinBBS-row">
								<!-- 기업명 영문 -->
								<div class="joinlt"><spring:message code="fap.comp.en_nm" /></div>
								<div class="joinrt"><input type="text" id="fap_comp_en_nm" class="input" maxlength="50" name="fap_comp_en_nm"></div>
							</div>
						</div>
					</div>
				</div>
				<div class="joinBox">	
					<div id="joinBtn">
						<button type="button" class="join-btn icon submitBtn" ng-click="connect_request()"><spring:message code="fap.comp.responsible_person_connect_request" /></button>
					</div>
				</div>
			</c:if>
		</div>
	</div>
</div>

















	<%-- <div id="subcontents">
		
		<h1><spring:message code="fap.comp.responsible_person_connect" /></h1>
		<br><br><br>
		
        
		<c:if test="${CompUserConnectRequest != '[]' }">
			<c:forEach var="data" items="${CompUserConnectRequest}">
				<input type="hidden" value="${data.fap_comp_user_request_seq}" id="fap_comp_user_request_seq">
				<spring:message code="fap.comp.ja_name" />
				<input type="text" value="${data.fap_comp_ja_nm}" readonly="readonly">
				<br>
				<spring:message code="fap.comp.en_name" />
				<input type="text" value="${data.fap_comp_en_nm}" readonly="readonly">
			</c:forEach>
			<br>
			<button class="btn btn-primary" ng-click="delete_request()"><spring:message code="fap.comp.responsible_person_connect_delete"/></button>
		</c:if>

		<c:if test="${CompUserConnectRequest == '[]' }">
			<ul>
	    	<li>
	    		<spring:message code="fap.comp.ja_name" />
		    	<input type="text" name="fap_comp_ja_nm" id="fap_comp_ja_nm">
		    </li>
		    <li>
		    	<spring:message code="fap.comp.en_name" />
		    	<input type="text" name="fap_comp_en_nm" id="fap_comp_en_nm">
		    </li>
		    <li>
		    	<button class="btn btn-primary" ng-click="connect_request()"><spring:message code="fap.comp.responsible_person_connect_request" /></button>
		    </li>
	    </ul>
		</c:if>		
		
	</div> --%>
<%@include file="agency_footer.jsp"%>
</body>
</html>
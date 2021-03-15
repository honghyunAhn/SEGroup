<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
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

<link type="text/css" rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto:400,500">
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/segroup/society/fap/css/default.css" />" />
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/segroup/society/fap/css/popModal.css" />" />
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
<script type="text/javascript">
	
$(function() {
		$(".request-label").on("click",function(e){
 			var clickedFlag = $(this).attr('flag');
			var check = $(this).attr('for');
			
			if (clickedFlag == 'unclicked') {
				$('#'+check).prop("checked", false);
				$(this).attr('flag', 'clicked');
				$(this).toggleClass("check");
				
			} else {
				$('#'+check).prop("checked", true);
				$(this).attr('flag','unclicked');
				$(this).removeClass("check");
				
			}
		});		
	});
	
	var myApp = angular.module('myapp', []);
	
	myApp.controller('AgencyCompRegistration',['$scope','$compile', '$http', function($scope, $compile, $http) {
		
		var select_agency_management_company_list = '${select_agency_management_company_list}';
		$scope.select_agency_management_company_list = JSON.parse(select_agency_management_company_list);
		
		var comp_user = '${comp_user}';
		$scope.comp_user = JSON.parse(comp_user);
		
	
		
	}]);
	
	function check_ini() {
		$("input:checkbox").prop("checked", false);
	}

	function comp_list_ck(ck) {
		if(ck == 'request'){
			$('#request_list').show();
			$('#standBy_list').hide();
			$('#refusal_list').hide();
		} else if(ck == 'standBy'){
			$('#standBy_list').show();
			$('#request_list').hide();
			$('#refusal_list').hide();
		} else if(ck == 'refusal'){
			$('#refusal_list').show();
			$('#standBy_list').hide();
			$('#request_list').hide();
		}
	}
	
	function means_ck(ck) {
		if(ck == 'request'){
			$('#means_request').show();
			$('#means_direct').hide();
		} else if(ck == 'direct'){
			$('#means_request').hide();
			$('#means_direct').show();
		}
	}
	
	
	function direct_connect() {
		user_id = $('#user_id').val();
		user_pw = $('#user_pw').val();
		$.ajax({
			 beforeSend: function(xhr) {
			     xhr.setRequestHeader("AJAX", true);
			 }
			,url : '/fap/agency/company_direct_connect'
			, type : 'post'
			, data : {
				user_id : user_id
				, user_pw : user_pw
			}
			, dataType : 'text'
			, success : function(data) {
				if(data == 'nonexist_id'){
					alert('<spring:message code="com.login.idcheck"/>');
				} else if(data == 'nonmatch_pw'){
					alert('<spring:message code="com.login.pwcheck"/>');
				} else if(data == 'another_agency'){ 
					alert('<spring:message code="fap.err.agency_another_agency"/>');
				} else if(data == 'exist_list'){
					alert('<spring:message code="fap.err.agency_exist"/>');
				} else if(data == 'complete'){
					alert('<spring:message code="fap.comp.agency_connect_success_alert"/>');
					location.reload();
				}
			}, error : function(e){
				if(e.status == 403){
					alert('<spring:message code="com.login.ajaxSesstion" javaScriptEscape="true" />');
					location.href = "/fap/agency/agency_login";
				}
			}
		}); // ajax end
		
	} // function(direct_connect) end
	
	function connect_request() {
		var comp_list = [];
		$("input[name='comp_nm_list']:checked").each(function () {
			comp_id = $(this).val();
			comp_list.push(comp_id);
		});

		jQuery.ajaxSettings.traditional = true;
		
		if(comp_list.length == 0){
			alert('<spring:message code="fap.err.agency_select_company"/>');
			return false;
		}
		
		$.ajax({
			 beforeSend: function(xhr) {
			     xhr.setRequestHeader("AJAX", true);
			}
			, url : '/fap/agency/company_connect_request'
			, type : 'post'
		 	, data : {
				'comp_list' : comp_list
			}
			, dataType : 'text'
			, success : function(data) {
				alert('<spring:message code="fap.comp.agency_connect_request_alert"/>');
				location.reload();
			}
			, error : function(e){
				if(e.status == 403){
					alert('<spring:message code="com.login.ajaxSesstion" javaScriptEscape="true" />');
					location.href = "/fap/agency/agency_login";
				}
			}
		}); // ajax end
		
	} // function(connect_request) end
	
	function request_delete(fap_comp_id, request_ck) {
		
		if(confirm('<spring:message code="fap.err.agency.comp_delete_check"/>')){
			$.ajax({
				 beforeSend: function(xhr) {
				     xhr.setRequestHeader("AJAX", true);
				}
				, url : '/fap/agency/delete_connect_request'
				, type : 'post'
				, data : {
					fap_comp_id : fap_comp_id
					, request_ck : request_ck
				}
				, dataType : 'text'
				, success : function() {
					alert('<spring:message code="fap.comp.agency_connect_delete_alert"/>');
					location.reload();
				}
				, error : function(e) {
					if(e.status == 403){
						alert('<spring:message code="com.login.ajaxSesstion" javaScriptEscape="true" />');
						location.href = "/fap/agency/agency_login";
					}
				}
			}); // ajax end
		}
		
	} // function(request_delete) end
	
	
	
</script>
<style type="text/css">
		.top_div {
			width : 985px;
			background : #eee;
			border-bottom : 1px solid #ddd;
			padding : 0 10px;
			line-height : 40px;
			font-size : 12px;
		}
	</style>
<body ng-app="myapp" ng-controller="AgencyCompRegistration">
	<%@include file="agency_menu.jsp"%>

	<div id="subcontents">
		<div class="joinBBS-row3">
			<div class="top_div">
				<input type="radio" id="means_ck_request" name="means_ck" onclick="means_ck('request')" checked="checked">
				<label for="means_ck_request">
					<span class="radio-span"></span><b><spring:message code="fap.comp.responsible_person_connect_request"/></b>
				</label> &nbsp;
				
				<input type="radio" id="means_ck_direct" name="means_ck" onclick="means_ck('direct')">						
				<label for="means_ck_direct">
					<span class="radio-span"></span><b><spring:message code="fap.agency.direct_register"/></b>
				</label>
			</div>
		</div>
	
	<br><br>
	
	<!-- 요청 보내기 -->
	<div id='means_request'>
		<div class="joinBBS-row3">
			<div class="top_div">
				<input type="radio" id="option_ck_request" name="option_ck" onclick="comp_list_ck('request')" checked="checked">
				<label for="option_ck_request">
					<span class="radio-span"></span><b><spring:message code="fap.agency.comp_to_send_request"/></b>
				</label> &nbsp;
				
				<input type="radio" id="option_ck_standBy" name="option_ck" onclick="comp_list_ck('standBy')">				
				<label for="option_ck_standBy">
					<span class="radio-span"></span><b><spring:message code="fap.agency.comp_on_list"/></b>
				</label> &nbsp;
				
				<input type="radio" id="option_ck_refusal" name="option_ck" onclick="comp_list_ck('refusal')">		
				<label for="option_ck_refusal">
					<span class="radio-span"></span><b><spring:message code="fap.agency.rejected_comp_list"/></b>
				</label> &nbsp;
			</div>
		</div>
    
    	<br><br>
    		
    	<div id="request_list">
    		<h3><spring:message code="fap.agency.comp_to_send_request_list"/></h3>
    		<br>
	    	<div id="request_list_1">
	    		<ul class="title1">
		       		<li class="wi1"><spring:message code="fap.comp.required_no"/></li>
		            <li class="wi2"><spring:message code="fap.comp.select"/></li>
		            <li class="wi3"><spring:message code="fap.comp.ja_name"/></li>
		            <li class="wi4"><spring:message code="fap.comp.en_name"/></li>
		       </ul>
	    	</div>	    	
	    	<div id="request_list_2">
	    		<c:forEach var="data" items="${select_comp_list}" varStatus="status">
		    		<ul class="title2">
			       		<li class="wi5">${status.count}</li>
			            <li class="wi6">
			            	<input type="checkbox" id="comp_nm_check_${status.count}" name="comp_nm_list" value="${data.fap_comp_id}">
			            	<label class="request-label" for="comp_nm_check_${status.count}" flag="unclicked"></label>
			            </li>
			            <li class="wi7">${data.fap_comp_ja_nm}</li>
			            <li class="wi8">${data.fap_comp_en_nm}</li>
			       </ul>
			   </c:forEach>
	    	</div>	    	
	    	<button id="requestBtn" onclick="connect_request()"><spring:message code="fap.comp.responsible_person_connect_request"/></button>
    	</div>    	
        
       <div id="standBy_list" style="display: none;">
	       	<h3><spring:message code="fap.agency.comp_on_list"/></h3>
	       	<br>
	       	<div id="standby_list_1">
	    		<ul class="title1">
		       		<li class="wi1"><spring:message code="fap.comp.required_no"/></li>
		            <li class="wi2"><spring:message code="fap.comp.ja_name"/></li>
		            <li class="wi3"><spring:message code="fap.comp.en_name"/></li>
		            <li class="wi4"><spring:message code="fap.comp.required_doc_delete"/></li>
		       </ul>
	    	</div>	
	    	<div id="standby_list_2">
	    		<c:forEach var="data" items="${select_standBy_comp}" varStatus="status">
		    		<ul class="title2">
			       		<li class="wi5">${status.count}</li>
			            <li class="wi6">${data.fap_comp_ja_nm}</li>
			            <li class="wi7">${data.fap_comp_en_nm}</li>
			            <li class="wi8"><button class="deleteBtn" onclick="request_delete('${data.fap_comp_id}', 'standBy')"><spring:message code="fap.comp.required_doc_delete"/></button></li>
			       </ul>
			   </c:forEach>
	    	</div>
	    	<br><br><br>
       </div>
       
       <div id="refusal_list" style="display: none;">
       	<h3><spring:message code="fap.agency.rejected_comp"/></h3>
       		<br>
	       	<div id="refusal_list_1">
	    		<ul class="title1">
		       		<li class="wi1"><spring:message code="fap.comp.required_no"/></li>
		            <li class="wi2"><spring:message code="fap.comp.ja_name"/></li>
		            <li class="wi3"><spring:message code="fap.comp.en_name"/></li>
		            <li class="wi4"><spring:message code="fap.comp.required_doc_delete"/></li>
		       </ul>
	    	</div>	
	    	<div id="refusal_list_2">
	    		<c:forEach var="data" items="${select_refusal_comp}" varStatus="status">
		    		<ul class="title2">
			       		<li class="wi5">${status.count}</li>
			            <li class="wi6">${data.fap_comp_ja_nm}</li>
			            <li class="wi7">${data.fap_comp_en_nm}</li>
			            <li class="wi8"><button class="deleteBtn" onclick="request_delete('${data.fap_comp_id}', 'refusal')"><spring:message code="fap.comp.required_doc_delete"/></button></li>
			       </ul>
			   </c:forEach>
	    	</div>
	    	<br><br><br>
       </div>
	</div>	
	
	<!-- 직접 등록하기 -->
	<div id="means_direct" style="display: none;">
    	<span class="means_direct_id"><spring:message code="fap.common.user_id"/></span><input type="text" id="user_id" name="user_id"><br><br>
    	<span class="means_direct_pw"><spring:message code="fap.common.password"/></span><input type="password" id="user_pw" name="user_pw"><br><br>
    	<input type="button" class="insertBtn" onclick="direct_connect()" value="<spring:message code="fap.common.join.btn"/>" style="padding-left: 60px; border-left-width: 10px;">
    	<br><br><br><br>
	</div>

		<div id="control_list" ng-repeat="list in select_agency_management_company_list">
			<div id="control_list_1" ng-if="list.fap_ag_id == comp_user.fap_comp_id">
				<h3>{{list.ag_en_nm}} ({{list.ag_ja_nm}}) <spring:message code="fap.agency.comp_under_control"/></h3>
			
	    		<ul class="title1">
		       		<li class="wi1"><spring:message code="fap.comp.ja_name"/></li>
		            <li class="wi2"><spring:message code="fap.comp.en_name"/></li>
		       </ul> 

			<div id="control_list_2">
	    		<ul class="title2" ng-repeat="comp_list in list.comp_info">
		       		<li class="wi5">{{comp_list.fap_comp_ja_nm}}</li>
		            <li class="wi6">{{comp_list.fap_comp_en_nm}}</li>
		       </ul>
	    	</div>	
	    	</div>  
		</div>
	
	<br>
	
		<div id="uncontrol_list" ng-repeat="list in select_agency_management_company_list">
			<div id="uncontrol_list_1" ng-if="list.fap_ag_id != comp_user.fap_comp_id">
				<h3>Agency{{$index}} <spring:message code="fap.agency.comp_under_control"/></h3>
			
	    		<ul class="title1">
		       		<li class="wi1"><spring:message code="fap.comp.ja_name"/></li>
		            <li class="wi2"><spring:message code="fap.comp.en_name"/></li>
		       </ul> 

				<div id="uncontrol_list_2">
		    		<ul class="title2" ng-repeat="comp_list in list.comp_info">
			       		<li class="wi5">{{comp_list.fap_comp_ja_nm}}</li>
			            <li class="wi6">{{comp_list.fap_comp_en_nm}}</li>
			       </ul>
		    	</div>	
	   		 </div>
	   		 <br><br><br> 
		</div>
	
	</div>

<br><br><br>
	<%@include file="agency_footer.jsp"%>

</body>
</html>
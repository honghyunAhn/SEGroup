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
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
	
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
			
			var fap_comp_id_ck = "${fap_comp_id_ck}";
			if( fap_comp_id_ck != ""){
				alert('<spring:message code="fap.err.comp.id_check" />');
				location.href="/fap/company/company_login_success";
			}
		});
		
		
		var myApp = angular.module('myapp', []);
		
		myApp.controller('ParticipationController', ['$scope', '$compile', function($scope, $compile) {

		}]);
			
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
		
		//모달창 띄워서 참가시킬 기업 리스트 출력
		function requestAllowableCompanyList(jobfair_seq, divide_seq){
			$.ajax({
				 beforeSend: function(xhr) {
				     xhr.setRequestHeader("AJAX", true);
				},
				url : 'agency_select_allowable_company_list_form',
				type : 'post',
				data : {
						'fap_jobfair_seq' : jobfair_seq
						,'fap_jobfair_divide_seq' : divide_seq
				},
		        dataType : 'json', 
				success : function(compInfoList) {
					var context = '';
					$('#allowableCompInfoDiv').children().remove();
					context += '<br>';
					if(compInfoList == undefined || compInfoList == null || compInfoList.length == 0){
						context += '<h4><spring:message code="fap.jobfair.not_insert_company_list" /></h4>';
						context += '<br>';
					} else{
						$.each(compInfoList, function(index, compInfo){
							context += '<div id="perCompInfoDiv">';
							context += 	'<div style="display: block; width: 50%; float:left;">';
							context += 		'<h3>' + compInfo.fap_comp_ja_nm + '</h3>';
							context += 	'</div>';
							context += 	'<div style="display: block; width: 50%; float:left;">';
							context += 		'<input type="checkbox" value="' + compInfo.fap_comp_id + '" style="display: block; width: 25px; height: 20px;margin:0 auto;">';
							context += 	'</div>';
							context += '</div>';
							context += '<br><br>';
						});
						context += '<br>';
						context += '<div class="logintxt5" style="padding-bottom: 10px; text-align: center;">';
						context += 	'<button type="button" onclick="joinCompanyFunc(' + jobfair_seq + ', ' + divide_seq + ')" class="btn17 btn-primary" style="width:250px; background:#0087e6; border:1px solid #0087e6; font-size:16px; color:#fff;">';
						context += 		'<spring:message code="fap.comp.modal_insert" />';
						context += 	'</button>';
						context += 	'<br><br>';
						context += '</div>';
					}
					$('#allowableCompInfoDiv').append(context);
					$("#requestAllowableCompanyModal").modal('show');
				},
				error : function(response) {
					console.log(response);
					if(response.status == 403){
						alert('<spring:message code="com.login.ajaxSesstion" javaScriptEscape="true" />');
						location.href = "/fap/agency/agency_login";
					}
				}
			});
		}
		//선택한 기업 참가시키는 함수
		function joinCompanyFunc(jobfair_seq, divide_seq) {
			/* if($(this).prop('disabled') == true){
				return false;
			}
			$(this).prop('disabled', true); */
			
			var allSearchInfoInput = $('#allowableCompInfoDiv').find('input');
		 	var fap_jobfair_divide_seq = divide_seq;
			var fap_jobfair_seq = jobfair_seq;
			var checkedCompanyInput = new Array();
			
		 	for (var i=0; i<allSearchInfoInput.length; i++) {
				if($(allSearchInfoInput[i]).is(':checked') == true){
					checkedCompanyInput.push($(allSearchInfoInput[i]).val());
				}
			}
			
			var insertCompanyInfo = {};
			insertCompanyInfo['checkedCompanyInput'] = checkedCompanyInput;
			insertCompanyInfo['fap_jobfair_seq'] = fap_jobfair_seq;
			insertCompanyInfo['fap_jobfair_divide_seq'] = fap_jobfair_divide_seq;
			
			if(checkedCompanyInput.length > 0){
				
			 	$.ajax({
			 		 beforeSend: function(xhr) {
					     xhr.setRequestHeader("AJAX", true);
					},
					url : 'insert_company_jobfair_join_table',
					type : 'post',
					contentType: 'application/json',
					data : JSON.stringify(insertCompanyInfo),
			        dataType : "text", 
					success : function(response) {
						//$(this).prop('disabled', false);
						switch(response){
						case 'insertSuccess' : 
							alert('<spring:message code="fap.jobfair.attended_jobfair_alert" />');
							$("#requestAllowableCompanyModal").modal('hide');
							break;
						default : 
							alert('<spring:message code="fap.jobfair.attend_to_fail_alert" />');
							break;
						}
					},
					error : function(response) {
						//$(this).prop('disabled', false);
						console.log(response);
						if(response.status == 403){
							alert('<spring:message code="com.login.ajaxSesstion" javaScriptEscape="true" />');
							location.href = "/fap/agency/agency_login";
						}
					}
				});
			 	
			}else{
				//$(this).prop('disabled', false);
				alert('<spring:message code="fap.jobad.select_join_company_alert" />');
			}
		}
		//참가한 회사 목록중에 원하는 회사 선택해서 채용공고 등록으로 이동시키는 함수
		function attendJobfair(jobfair_seq, divide_seq) {
			$.ajax({
				 beforeSend: function(xhr) {
				     xhr.setRequestHeader("AJAX", true);
				},
				url : 'agency_select_attend_company_list_form',
				type : 'post',
				data : {
						'fap_jobfair_seq' : jobfair_seq
						,'fap_jobfair_divide_seq' : divide_seq
				},
		        dataType : 'json', 
				success : function(compInfoList) {
					var context = '';
					$('#JoinedCompInfoDiv').children().remove();
					context += '<br>';
					if(compInfoList == undefined || compInfoList == null || compInfoList.length == 0){
						context += '<h4><spring:message code="fap.jobfair.no_company_on_jobfair" /></h4>';
						context += '<h4><spring:message code="fap.jobfair.please_click_to_attend_jobfair" /></h4>';
						context += '<br>';
					} else{
						$.each(compInfoList, function(index, compInfo){
							context += '<div id="perCompInfoDiv">';
							context += 	'<div style="display: block; width: 50%; float:left;">';
							context += 		'<h3>' + compInfo.fap_comp_ja_nm + '</h3>';
							context += 	'</div>';
							context += 	'<div style="display: block; width: 50%; float:left;">';
							context += 		'<input type="radio" name="fap_comp_id" value="' + compInfo.fap_comp_id + '" style="display: block; width: 25px; height: 20px; margin:0 auto;">';
							context += 	'</div>';
							context += '</div>';
							context += '<br><br>';
						});
						context += '<br>';
						context += '<div class="logintxt5" style="padding-bottom: 10px; text-align: center;">';
						context += 	'<button type="button" onclick="joinJobfairFunc(' + jobfair_seq + ', ' + divide_seq + ')" class="btn17 btn-primary" style="width:250px; background:#0087e6; border:1px solid #0087e6; font-size:16px; color:#fff;">';
						context += 		'<spring:message code="fap.jobfair.attend_jobfair" />';
						context += 	'</button>';
						context += 	'<br><br>';
						context += '</div>';
					}
					$('#JoinedCompInfoDiv').append(context);
					$("#attendJobfairModal").modal('show');
				},
				error : function(response) {
					console.log(response);
					if(response.status == 403){
						alert('<spring:message code="com.login.ajaxSesstion" javaScriptEscape="true" />');
						location.href = "/fap/agency/agency_login";
					}
				}
			});
		}
		//선택한 기업으로 채용공고목록 폼으로 이동시키는 함수
		function joinJobfairFunc(jobfair_seq, divide_seq) {
			var chosen_fap_comp_id = $('input[name=fap_comp_id]:checked', '#JoinedCompInfoDiv').val();
			if(chosen_fap_comp_id != undefined){
			 	$.ajax({
			 		 beforeSend: function(xhr) {
					     xhr.setRequestHeader("AJAX", true);
					},
					url : 'chosen_company_id_save_session',
					type : 'post',
					data : {'chosen_fap_comp_id' : chosen_fap_comp_id},
			        dataType : "text", 
					success : function(response) {
						switch(response){
						case 'insertSessionSuccess' :
							//해당 잡페어로 이동시켜주는 부분
							$("#attendJobfairModal").modal('hide');
							location.href = '/fap/agency/agency_job_ad_management?fap_jobfair_seq=' + jobfair_seq + '&fap_jobfair_divide_seq=' + divide_seq + '';
							break;
						default : 
							alert('<spring:message code="fap.jobfair.attend_to_fail_alert" />');
							break;
						}
					},
					error : function(response) {
						console.log(response);
						if(response.status == 403){
							alert('<spring:message code="com.login.ajaxSesstion" javaScriptEscape="true" />');
							location.href = "/fap/agency/agency_login";
						}
					}
				});
			}else{
				alert('<spring:message code="fap.jobad.select_join_company_alert" />');
			}
		}
	</script>
	
</head>
<body ng-app="myapp" ng-controller="ParticipationController">

<!-- 메뉴바 -->
<%@include file="agency_menu.jsp"%>
<!-- /메뉴바 -->

<div class="join-wrap">	
	<div id="subcontents">
	
		<h1><spring:message code="fap.common.attend_jobfair" /></h1>
		<h6><span class="red"><spring:message code="fap.jobad.select_jobfair_to_attend" /></span></h6>

		<h6><spring:message code="fap.jobfair.select_jobfair_to_comment" /></h6>
		
		<div id="fairctr">
		
			<c:forEach var="result" items="${jobfairDivideList}" varStatus="status">
				<!-- 반복문 시작 -->
				<ul><li>
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
		              
		            <!--  -->
		    		<ul id="faircheckBoxs3">
		    			<li class="msgbox"><spring:message code="fap.common.gb" /></li>
		    			<li class="msgbox2"><code value="${result.fap_jobfair_divide_gb}"></code></li>
		    		</ul>
		                
		    		<ul id="faircheckBoxs4">
		   				<li class="msgbox"><spring:message code="fap.common.explanation" /></li>
		    			<li class="msgbox2">
		    				<textarea class="explanation_textarea" readonly="readonly">${result.fap_jobfair_divide_detail}</textarea>
		    			</li>
		    		</ul>
	    		
					<div class="faircheckBtn">
						<input type="hidden" name="fap_jobfair_seq" value="${result.fap_jobfair_seq}">	
						<input type="hidden" name="fap_jobfair_divide_seq" value="${result.fap_jobfair_divide_seq}">
						<c:choose>
							<c:when test="${result.fap_jobfair_divide_app_st <= result.now_day and result.now_day <= result.fap_jobfair_divide_app_et}">
								<button type="button" class="btn btn-primary" value="${result.fap_jobfair_divide_seq}" app_st="${result.fap_jobfair_divide_app_st }" app_et="${result.fap_jobfair_divide_app_et}" onclick="requestAllowableCompanyList(${result.fap_jobfair_seq}, ${result.fap_jobfair_divide_seq})">
									<spring:message code="fap.jobfair.attend_jobfair" />
								</button>
								<button type="button" class="btn btn-primary" onclick="attendJobfair(${result.fap_jobfair_seq}, ${result.fap_jobfair_divide_seq})">
									<spring:message code="fap.jobad.manage_and_write_jobad" />
								</button>
							</c:when>
							<c:otherwise>
								<button type="button" class="btn btn-primary">
									<spring:message code="fap.jobfair.can_not_join_jobfair_phrase" />
								</button>
							</c:otherwise>
						</c:choose>	
					</div>

				</div>
				</li></ul>
				<!-- 반복문 종료 -->
			</c:forEach>
		</div>
	</div>
</div>
	
	<!-- [start] 아직 참가하지 않는 회사 참가시키는 모달창 시작 -->
	<div class="modal fade" id="requestAllowableCompanyModal" tabindex="-1" role="dialog" aria-labelledby="modal" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
			
				<div class="modal-header">
					<h3 class="modal-title" id="modal">
						<!--참가 가능한 회사 목록 -->
						<spring:message code="fap.jobfair.let_attend_company_list" />
					</h3>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				
				<div class="modal-body">	
					<div id="allowableCompInfoDiv" style="text-align:center;">

						
					</div>
				</div>
				
			</div>
		</div>
	</div>
	<!-- [end] 아직 참가하지 않는 회사 참가시키는 모달창 종료 -->
	
	<!-- [start] 참가한 회사 목록중에 원하는 회사 선택해서 채용공고 등록으로 이동시키는 모달창 시작 -->
	<div class="modal fade" id="attendJobfairModal" tabindex="-1" role="dialog" aria-labelledby="modal" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
			
				<div class="modal-header">
					<h3 class="modal-title" id="modal">
						<!--참가 가능한 회사 목록 -->
						<spring:message code="fap.jobfair.select_company_to_comfirm_regist" />
					</h3>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				
				<div class="modal-body">	
					<div id="JoinedCompInfoDiv" style="text-align:center;">

						
					</div>
				</div>
				
			</div>
		</div>
	</div>
	<!-- [end] 참가한 회사 목록중에 원하는 회사 선택해서 채용공고 등록으로 이동시키는 모달창 종료 -->
	
<%@include file="agency_footer.jsp"%>		
</body>
</html>
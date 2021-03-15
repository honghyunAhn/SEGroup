<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<script src="<c:url value="/resources/segroup/js/jquery-3.1.1.js" />"></script>
	<script src="<c:url value="/resources/segroup/js/angular.min.js" />"></script>
	<link rel="stylesheet" type="text/css" href="<c:url value="/resources/segroup/society/fap/css/userDefault.css" />" />
	<link type="text/css" rel="stylesheet" href="<c:url value="/resources/segroup/society/fap/css/popModal.css" />">
	<title>Bridge Job Fair</title>
	<script type="text/javascript">
		//angular module 
		var myApp = angular.module('myapp', []);
		
		myApp.controller('OpenPtController',['$scope','$compile','$http', function($scope, $compile,$http) {
			
			$scope.openResumeDetailModal = function (e) {
				var fap_resume_seq = $(e.currentTarget).attr('resume_seq');
				var user_id = $('#user_id').val();
				$('#resumeInfoModal').modal('show');
				$http({
					url: 'select_user_resume_info_read',
					method: 'post',
					params: { 'fap_resume_seq' : fap_resume_seq 
								,'user_id' : user_id
					},
					XMLHttpRequestResponseType: 'json',
					headers : {
						"AJAX" : true
					}
				}).then(function successCallback(response) {
					var wholeResumeJson = JSON.stringify(response.data);
					var replaceJson = wholeResumeJson.replace(/(?:\r\n|\r|\n)/g, '<br />');
					$scope.resumeApply = JSON.parse(replaceJson);
					
					$timeout(function() {
						
						$.each($(".span-code"), function(index, item){
							var cd = $(this).attr("cd");
							var context = '<code value="'+cd+'"></code>';
							$(this).html(context);
						})

						$compile(".span-code")($scope);
					
					}, 0);
					
				}, function errorCallback(response) {
					console.log(response);
					if(response.status == 403){
						alert('<spring:message code="com.login.ajaxSesstion" javaScriptEscape="true" />');
						location.href = "/fap/user/user_login";
					}
				});
			}
			
			$scope.search_open_list = function(e){
				var _this = $(e.currentTarget);
				$(".header_tx").removeClass("on");
				$(_this).addClass("on");
				if($(_this).hasClass("presentation")){
					$scope.user_open_pt_applied_list();
				}else if($(_this).hasClass("education")){
					$scope.user_open_edu_applied_list();
				}
				
			}
			
			$scope.user_open_pt_applied_list = function(){
				$http({
					method: 'POST',
					url: '/fap/user/user_open_pt_applied_list',
					headers : {
						"AJAX" : true
					}
				}).then(function successCallback(response) {
					$scope.open_pt_content_list_draw(response);
					
				}, function errorCallback(response) {
					console.log(response);
					if(response.status == 403){
						alert('<spring:message code="com.login.ajaxSesstion" javaScriptEscape="true" />');
						location.href = "/fap/user/user_login";
					}
				});
			}
			
			$scope.open_pt_content_list_draw = function(response){
				var context = '';
				var context_length = response.data.length;
				
				var header_context = '';
				
				header_context += '<div class="col col1">';
				header_context += '<spring:message code="fap.open_com.title" />';
				header_context += '</div>';
				header_context += '<div class="col col2">';
				header_context += '<spring:message code="fap.open_com.join_dt" />';
				header_context += '</div>';
				header_context += '<div class="col col3">';
				header_context += '<spring:message code="fap.open_com.join_st" />';
				header_context += '</div>';
			
				$(".content_header").html(header_context);
				
				if(context_length > 0){
					$.each(response.data , function(index, item){
						context += '<li>';
						context += '<div class="col col1">';
						context += item.fap_open_pt_title;
						context += '</div>';
						context += '<div class="col col2">';
						context += item.fap_open_pt_apply_ins_dt;
						context += '</div>';
						context += '<div class="col col3">';
						if(item.fap_open_pt_apply_gb == 'D1300'){
							context += '<button class="apply_cancel_btn" ng-click="user_open_pt_apply_cancel(\''+item.fap_open_pt_apply_seq+'\')"><code value="'+item.fap_open_pt_apply_gb+'"></code></button>';
						}else{
							context += '<code value="'+item.fap_open_pt_apply_gb+'"></code>';
						}
						context += '</div>';
						context += '</li>';
					});
				}else{
					context += '<li class="noData">';
					context += '<spring:message code="fap.open_com.join_empty" />';
					context += '</li>';
				}
				
				$(".inner_body").html($compile(context)($scope));	
				
			}
			
			$scope.user_open_pt_apply_cancel = function(fap_open_pt_apply_seq){
				$http({
					method: 'POST',
					url: '/fap/user/user_open_pt_apply_cancel',
					params : {fap_open_pt_apply_seq : fap_open_pt_apply_seq},
					headers : {
						"AJAX" : true
					}
				}).then(function successCallback(response) {
					$scope.open_pt_content_list_draw(response);
					
				}, function errorCallback(response) {
					console.log(response);
					if(response.status == 403){
						alert('<spring:message code="com.login.ajaxSesstion" javaScriptEscape="true" />');
						location.href = "/fap/user/user_login";
					}
				});
			}
			
			$scope.user_open_pt_edu_apply_cancel = function(fap_open_pt_apply_seq){
				$http({
					method: 'POST',
					url: '/fap/user/user_open_pt_edu_apply_cancel',
					params : {fap_open_pt_apply_seq : fap_open_pt_apply_seq},
					"AJAX" : true
				}).then(function successCallback(response) {
					$scope.open_edu_content_list_draw(response);
					
				}, function errorCallback(response) {
					console.log(response);
					if(response.status == 403){
						alert('<spring:message code="com.login.ajaxSesstion" javaScriptEscape="true" />');
						location.href = "/fap/user/user_login";
					}
				});
			}
			
			$scope.user_open_edu_applied_list = function(){
				$http({
					method: 'POST',
					url: '/fap/user/user_open_edu_applied_list',
					headers : {
						"AJAX" : true
					}
				}).then(function successCallback(response) {
					$scope.open_edu_content_list_draw(response);
					
				}, function errorCallback(response) {
					console.log(response);
					if(response.status == 403){
						alert('<spring:message code="com.login.ajaxSesstion" javaScriptEscape="true" />');
						location.href = "/fap/user/user_login";
					}
				});
			}
			
			$scope.open_edu_content_list_draw = function(response){
				var context = '';
				var context_length = response.data.length;
				
				var header_context = '';
				
				header_context += '<div class="col col1">';
				header_context += '<spring:message code="fap.open_com.title" />';
				header_context += '</div>';
				header_context += '<div class="col col2">';
				header_context += '<spring:message code="fap.open_com.join_dt" />';
				header_context += '</div>';
				header_context += '<div class="col col3">';
				header_context += '<spring:message code="fap.open_com.join_st" />';
				header_context += '</div>';
				header_context += '<div class="col col4">';
				header_context += '<spring:message code="fap.open_edu.resume_select" />';
				header_context += '</div>';
				header_context += '<div class="col col5">';
				header_context += '<spring:message code="fap.open_edu.join_pass" />';
				header_context += '</div>';
				
				$(".content_header").html(header_context);
				
				if(context_length > 0){
					$.each(response.data , function(index, item){
						context += '<li>';
						context += '<div class="col col1">';
						context += item.fap_open_pt_title;
						context += '</div>';
						context += '<div class="col col2">';
						context += item.fap_open_pt_apply_ins_dt;
						context += '</div>';
						context += '<div class="col col3">';
						if(item.fap_open_pt_apply_gb == 'D1300'){
							context += '<button class="apply_cancel_btn" ng-click="user_open_pt_edu_apply_cancel(\''+item.fap_open_pt_apply_seq+'\')"><code value="'+item.fap_open_pt_apply_gb+'"></code></button>';
						}else{
							context += '<code value="'+item.fap_open_pt_apply_gb+'"></code>';
						}
						context += '</div>';
						context += '<div class="col col4">';
						context += '<button class="apply_resume_check"  resume_seq="'+item.fap_resume_seq+'" ng-click="openResumeDetailModal($event)">확인</button>';
						context += '</div>';
						context += '<div class="col col5">';
						context += '<code value="'+item.fap_open_pt_resume_gb+'"></code>';
						context += '</div>';
						context += '</li>';
					});
				}else{
					context += '<li class="noData">';
					context += '<spring:message code="fap.open_com.join_empty" />';
					context += '</li>';
				}
				
				$(".inner_body").html($compile(context)($scope));
			}
			
			$scope.user_open_pt_applied_list();
			
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
	</script>
</head>
<body ng-app="myapp" ng-controller="OpenPtController">
<sec:authorize access="hasAnyRole('ROLE_A0100', 'ROLE_A0101', 'ROLE_A0102', 'ROLE_A0106', 'ROLE_A0108')">
	<sec:authentication property="details.user" var="detail" />
	<input type="hidden" name="user_id" value="${detail.user_id}" id="user_id">
</sec:authorize>
<%@include file="user_menu.jsp"%>
<div class="join-wrap">
	<div id="subcontents">
		<div class="open_pt_mypage_wrap">
			<div class="open_pt_mypage_header">
				<ul class="text-align-left">
					<li class="header_tx on presentation" ng-click="search_open_list($event)">
						<a><spring:message code="fap.open_pt.join_list" /></a>
					</li>
					<li class="header_tx education" ng-click="search_open_list($event)">
						<a><spring:message code="fap.open_edu.join_list" /></a>
					</li>
				</ul>
			</div>
			<div class="open_pt_content_wrap">
				<div class="content_header">
				</div>
				<div class="content_body">
					<ul class="inner_body">
					</ul>
				</div>
			</div>
		</div>
	</div>
</div>

<div class="modal fade" id="resumeInfoModal" role="dialog">
	
		<!-- Modal dialog------------------------->
		<div class="modal-dialog" id="modal-dialog" style="max-width: 1200px;">
		
			<!-- 1 Modal content------------------------->
			<div class="modal-content">
				<div class="modal-header">
		          <h4 class="modal-title" id="title"><span ng-bind="resumeApply.fap_resume_title"></span></h4>
		          <button type="button" class="close" data-dismiss="modal">&times;</button>
		        </div>
				
				<!-- body 시작-->
				<div class="modal-body">
		        	<div class="resume_wrap">
						<div class="resume_sub">
						
							<div class="userjoinBox">
								<div id="sub3_bbs2" class="basic_top">
									<h2><spring:message code="fap.resume.user_info" /></h2>
									<ul class="tit1">
										<li class="photo">
											<img alt="" ng-src="/fap/user/resume_photo_image/{{resumeApply.fap_resume_pic_saved}}">
										</li>
									</ul>
									<ul class="tit2 first">
										<li class="wid1"><code value="B3100"></code></li>
										<li class="wid2">
											<span ng-bind="resumeApply.resumeNameList[0].fap_resume_nm"></span>
										</li>
										<li class="wid3"><spring:message code="fap.resume.user_nationality" /></li>
										<li class="wid4">
											<span ng-bind="resumeApply.fap_resume_nationality"></span>
										</li>
									</ul>
									<ul class="tit2">
										<li class="wid1"><code value="B3102"></code></li>
										<li class="wid2">
											<span ng-bind="resumeApply.resumeNameList[2].fap_resume_nm"></span>
										</li>
										<li class="wid3"><code value="B3103"></code></li>
										<li class="wid4">
											<span ng-bind="resumeApply.resumeNameList[3].fap_resume_nm"></span>
										</li>						
									</ul>
									<ul class="tit2">
										<li class="wid1"><code value="B3101"></code></li>
										<li class="wid2">
											<span ng-bind="resumeApply.resumeNameList[1].fap_resume_nm"></span>
										</li>
										<li class="wid3"><spring:message code="fap.resume.user_dependent" /></li>
										<li class="wid4">
											<span ng-bind="resumeApply.fap_resume_dependents"></span><spring:message code="com.placeholder.people" />
										</li>						
									</ul>
								</div>
								<div id="sub3_bbs2">
									<ul class="tit3">
										<li class="wid1"><spring:message code="fap.resume.user_birth" /></li>
										<li class="wid2_birth">
											<span ng-bind="resumeApply.fap_resume_birth.substr(0,4)"></span><spring:message code="com.placeholder.year" />
										</li>
										<li class="wid2_birth">
											<span ng-bind="resumeApply.fap_resume_birth.substr(5,2)"></span><spring:message code="com.placeholder.month" />
										</li>
										<li class="wid2_birth"> 
											<span ng-bind="resumeApply.fap_resume_birth.substr(8,2)"></span><spring:message code="com.placeholder.day" />
										</li>
									</ul>
									<ul class="tit3">
										<li class="wid1"><spring:message code="fap.resume.user_address" /></li>
										<li class="wid2 resumeAddr" ng-repeat="addr in resumeApply.resumeAddrList">	
											<span ng-bind="addr.fap_resume_address"></span>
										</li>
									</ul>
									<ul class="tit3">
										<li class="wid1"><spring:message code="fap.resume.user_gender" /></li>
										<li class="wid2">
											<div class="span-code" cd="{{resumeApply.fap_resume_gender}}"></div>
										</li>
									</ul>
									<ul class="tit3">
										<li class="wid1"><spring:message code="fap.resume.user_married_or_not" /></li>
										<li class="wid2">
											<div class="span-code" cd="{{resumeApply.fap_resume_marital}}"></div>
										</li>
									</ul>
								</div><!-- <div id="sub3_bbs2"> -->
							</div> <!-- <div id="userjoinBox"> -->		
				
							<!-- ------------------------------------기본정보---------------------------------------------->
							<div class="userjoinBox">
								<h2><spring:message code="fap.resume.edu_history" /></h2>
								<div class="sub3_bbs3 resume_edu" ng-repeat="eduHistory in resumeApply.resumeEduList">
									<ul class="tit2 title">
										<li class="wid1"><spring:message code="fap.resume.edu_entrance" /></li>
										<li class="wid2"><spring:message code="fap.resume.edu_graduation" /></li>
										<li class="wid3"><spring:message code="fap.resume.edu_period" /></li>
										<li class="wid4"><spring:message code="fap.resume.edu_graduated_or_not" /></li>
									</ul>
									<ul class="tit2">
										<li class="wid1">
											<span ng-bind="eduHistory.fap_resume_edu_er_dt"></span>
										</li>
										<li class="wid2">
											<span ng-bind="eduHistory.fap_resume_edu_gd_dt"></span>
										</li>
										<li class="wid3">
											<span ng-bind="eduHistory.fap_resume_edu_pd_summary"></span>
										</li>
										<li class="wid4">
											<div class="span-code" cd="{{eduHistory.fap_resume_edu_gd_ck}}"></div>
										</li>
									</ul>
									<ul class="tit3">
										<li class="wid1"><spring:message code="fap.resume.edu_school_nm" /></li>
										<li class="wid2">
											<span ng-bind="eduHistory.fap_resume_edu_sc_nm"></span>
										</li>
									</ul>
									<ul class="tit3">
										<li class="wid1"><spring:message code="fap.resume.edu_curriculum" /></li>
										<li class="wid2">
											<span ng-bind="eduHistory.fap_resume_edu_coll"></span>
										</li>					
									</ul>
									<ul class="tit3">
										<li class="wid1"><spring:message code="fap.resume.edu_major_field" /></li>
										<li class="wid2">
											<div class="span-code" cd="{{eduHistory.fap_resume_edu_field}}"></div>
										</li>					
									</ul>
									<ul class="tit3">
										<li class="wid1"><spring:message code="fap.resume.edu_major_nm" /></li>
										<li class="wid2">
											<span ng-bind="eduHistory.fap_resume_edu_major"></span>
										</li>					
									</ul>
									<ul class="tit3">
										<li class="wid1"><spring:message code="fap.resume.edu_remarks" /></li>
										<li class="wid2 textarea">
											<textarea class="readonly_textarea" ng-bind="eduHistory.fap_resume_edu_note" readonly="readonly"></textarea>
										</li>
									</ul>					
								</div><!-- <div id="sub3_bbs3"> -->
							</div><!-- <div id="userjoinBox"> -->
							<!-- ------------------------------------학력관련 교육이수 ---------------------------------------------->
							<div class="userjoinBox">
								<h2><spring:message code="fap.resume.career" /></h2>
								<div class="sub3_bbs3 resume_crr" ng-repeat ="career in resumeApply.resumeCareerList">
									<ul class="tit2 title">
										<li class="wid1"><spring:message code="fap.resume.career_service_start_day" /></li>
										<li class="wid2"><spring:message code="fap.resume.career_service_completion_day" /></li>
										<li class="wid3"><spring:message code="fap.resume.edu_period" /></li>
										<li class="wid4"><spring:message code="fap.resume.career_position" /></li>
									</ul>
									<ul class="tit2">
										<li class="wid1">
											<span ng-bind="career.fap_resume_crr_st"></span>
										</li>
										<li class="wid2">
											<span ng-bind="career.fap_resume_crr_et"></span>
										</li>
										<li class="wid3">
											<span ng-bind="career.fap_resume_crr_pd_summary"></span>
										</li>
										<li class="wid4">
											<span ng-bind="career.fap_resume_crr_job_position"></span>
										</li>
									</ul>
									<ul class="tit3">
										<li class="wid1"><spring:message code="fap.resume.career_comp_nm" /></li>
										<li class="wid2">
											<span ng-bind="career.fap_resume_crr_comp_nm"></span>
										</li>
									</ul>
									<ul class="tit3">
										<li class="wid1"><spring:message code="fap.resume.career_comp_major_business" /></li>
										<li class="wid2">
											<span ng-bind="career.fap_resume_crr_major_bussiness"></span>
										</li>					
									</ul>
									<ul class="tit3">
										<li class="wid1"><spring:message code="fap.resume.career_field" /></li>
										<li class="wid2">
											<div class="span-code" cd="{{career.fap_resume_crr_gb}}"></div>
										</li>					
									</ul>
									<ul class="tit3">
										<li class="wid1"><spring:message code="fap.resume.career_responsibility" /></li>
										<li class="wid2 textarea">
											<textarea class="readonly_textarea" ng-bind="career.fap_resume_crr_job_function" readonly="readonly"></textarea>
										</li>
									</ul>					
								</div>
							</div>	
							<!-- ------------------------------------사회 경력 ---------------------------------------------->
							<div class="userjoinBox">
								<h2><spring:message code="fap.resume.certification" /></h2>
								<div class="sub3_bbs3 resume_license" ng-repeat="license in resumeApply.resumeLicenseList">
									<ul class="tit2 title">
										<li class="wid1"><spring:message code="fap.resume.certification_license" /></li>
										<li class="wid2"><spring:message code="fap.resume.certification_obtained_year" /></li>
										<li class="wid3"><spring:message code="fap.resume.certification_obtained_month" /></li>
										<li class="wid4"><spring:message code="fap.resume.certification_issuing_organization" /></li>
									</ul>
									<ul class="tit2">
										<li class="wid1">
											<div class="span-code" cd="{{license.fap_resume_license_nm}}"></div>
										</li>
										<li class="wid2">
											<span ng-bind="license.fap_resume_license_get_year"></span>
										</li>
										<li class="wid3">
											<span ng-bind="license.fap_resume_license_get_month"></span>
										</li>
										<li class="wid4">
											<span ng-bind="license.fap_resume_license_issuing_organization"></span>
										</li>
									</ul>
									<ul class="tit3">
										<li class="wid1"><spring:message code="fap.resume.certification_score" /></li>
										<li class="wid2">
											<span ng-bind="license.fap_resume_license_score"></span>
										</li>
									</ul>
									<ul class="tit3">
										<li class="wid1"><spring:message code="fap.resume.certification_remarks" /></li>
										<li class="wid2 textarea">
											<textarea class="readonly_textarea" ng-bind="license.fap_resume_license_note" readonly="readonly"></textarea>
										</li>
									</ul>					
								</div><!-- <div id="sub3_bbs3"> -->
							</div>
							<!-- ----------------------------자격(기술 및 외국어 역량 중심) --------------------------------------------->
							<div class="userjoinBox">
								<h2><spring:message code="fap.resume.talent" /></h2>
								<div class="sub3_bbs7 resume_talent" ng-repeat="talent in resumeApply.resumeTalentList">
									<ul class="tit2">
										<li class="wid1"><spring:message code="fap.resume.talent_number" /></li>
										<li class="wid2"><spring:message code="fap.resume.talent_context" /></li>
									</ul>
									<ul class="tit3">
										<li class="wid1">{{$index+1}}</li>
										<li class="wid2 textarea">
											<textarea class="readonly_textarea_talent" ng-bind="talent.fap_resume_talent_content" readonly="readonly"></textarea>
										</li>
									</ul>				
								</div><!-- <div id="sub3_bbs7"> -->
							</div><!-- <div id="userjoinBox"> -->				
							<!-- ----------------------------역량/재능(ICT, 외국어, 인간관계 등 업무 관련 상세) --------------------------------------------->
							<div class="userjoinBox">
								<h2><spring:message code="fap.resume.project_development_career" /></h2>
								<div class="sub3_bbs3 resume_project" ng-repeat="project in resumeApply.resumeProjectList">
									<ul class="tit2 title">
										<li class="wid1"><spring:message code="fap.resume.project_development_start_date" /></li>
										<li class="wid2"><spring:message code="fap.resume.project_development_end_date" /></li>
										<li class="wid3"><spring:message code="fap.resume.edu_period" /></li>
										<li class="wid4"><spring:message code="fap.resume.project_development_member" /></li>
									</ul>
									<ul class="tit2">
										<li class="wid1">
											<span ng-bind="project.fap_resume_project_st"></span>
										</li>
										<li class="wid2">
											<span ng-bind="project.fap_resume_project_et"></span>
										</li>
										<li class="wid3">
											<span ng-bind="project.fap_resume_project_pd_summary"></span>
										</li>
										<li class="wid4">
											<span ng-bind="project.fap_resume_project_peoples_num"></span>
											<spring:message code="com.placeholder.people" />
										</li>
									</ul>
									<ul class="tit3">
										<li class="wid1"><spring:message code="fap.resume.project_nm" /></li>
										<li class="wid2">
											<span ng-bind="project.fap_resume_project_nm"></span>
										</li>
									</ul>
									<ul class="tit3">
										<li class="wid1"><spring:message code="fap.resume.project_main_service" /></li>
										<li class="wid2 textarea">
											<textarea class="readonly_textarea" ng-bind="project.fap_resume_project_service" readonly="readonly"></textarea>
										</li>					
									</ul>
									<ul class="tit3">
										<li class="wid1"><spring:message code="fap.resume.project_charge_filed" /></li>
										<li class="wid2 textarea">
											<textarea class="readonly_textarea" ng-bind="project.fap_resume_project_responsibility" readonly="readonly"></textarea>
										</li>
									</ul>
									<ul class="tit3">
										<li class="wid1"><spring:message code="fap.resume.project_used_technique" /></li>
										<li class="wid2 textarea">
											<textarea class="readonly_textarea" ng-bind="project.fap_resume_project_technique" readonly="readonly"></textarea>
										</li>
									</ul>					
								</div><!-- <div id="sub3_bbs3"> -->
							</div>		
							<!-- ----------------------------SW 프로젝트 개발경력 --------------------------------------------->
							<div class="userjoinBox">
								<h2><spring:message code="fap.resume.self_introduction" /></h2>
								<div class="sub3_bbs8">
									<ul class="tit2">
										<li class="wid1">
											<code value="B4100"></code>
										</li>					
									</ul>
									<ul class="tit3">
										<li class="wid1">
											<textarea class="readonly_textarea_pr" ng-bind="resumeApply.resumeProfileList[0].fap_resume_pr_content" readonly="readonly"></textarea>
										</li>						
									</ul>
									<ul class="tit2">
										<li class="wid1">
											<code value="B4101"></code>
										</li>					
									</ul>
									<ul class="tit3">
										<li class="wid1">
											<textarea class="readonly_textarea_pr" ng-bind="resumeApply.resumeProfileList[1].fap_resume_pr_content" readonly="readonly"></textarea>
										</li>						
									</ul>
									<ul class="tit2">
										<li class="wid1">
											<code value="B4102"></code>
										</li>					
									</ul>
									<ul class="tit3">
										<li class="wid1">
											<textarea class="readonly_textarea_pr" ng-bind="resumeApply.resumeProfileList[2].fap_resume_pr_content" readonly="readonly"></textarea>
										</li>						
									</ul>
								</div> <!-- <div id="sub3_bbs8"> -->
							</div><!-- <div id="userjoinBox"> -->				
							<!-- ----------------------------------------------자기소개서----------- --------------------------------------------->
							<div class="userjoinBox">
								<h2><spring:message code="fap.resume.self_introduction_video_portfolio" /></h2>
								<div id="sub3_bbs9">
									<ul class="tit2 resumeFile" ng-switch="!!resumeApply.resumeFileList[0].fap_resume_file_origin">
										<li class="wid1"><spring:message code="fap.resume.self_introduction_file" /></li>	
										<li class="wid2" ng-switch-when="true">
											<a class="display-inline" ng-href="/file_download?origin={{resumeApply.resumeFileList[0].fap_resume_file_origin}}&saved={{resumeApply.resumeFileList[0].fap_resume_file_saved}}&path=/fap/user/resume_movie_file">
												{{resumeApply.resumeFileList[0].fap_resume_file_origin}}
											</a>
										</li>
									</ul>
									<ul class="tit2 resumeFile" ng-switch="!!resumeApply.resumeFileList[1].fap_resume_file_origin">
										<li class="wid1"></li>
										<li class="wid2" ng-switch-when="true">
											<a class="display-inline" ng-href="/file_download?origin={{resumeApply.resumeFileList[1].fap_resume_file_origin}}&saved={{resumeApply.resumeFileList[1].fap_resume_file_saved}}&path=/fap/user/resume_portfolio_file">
												{{resumeApply.resumeFileList[1].fap_resume_file_origin}}
											</a>
										</li>
									</ul>
									<ul class="tit2 resumeFile" ng-switch="!!resumeApply.resumeFileList[2].fap_resume_file_origin">
										<li class="wid1"></li>	
										<li class="wid2" ng-switch-when="true">
											<a class="display-inline" ng-href="/file_download?origin={{resumeApply.resumeFileList[2].fap_resume_file_origin}}&saved={{resumeApply.resumeFileList[2].fap_resume_file_saved}}&path=/fap/user/resume_project_file">
												{{resumeApply.resumeFileList[2].fap_resume_file_origin}}
											</a>
										</li>
									</ul>
									<ul class="tit2">
										<li class="wid1"><spring:message code="fap.resume.self_introduction_url" /></li>
										<li class="wid2">
											<a href="{{resumeApply.fap_resume_url}}" target="_blank">{{resumeApply.fap_resume_url}}</a>
										</li>
									</ul>			
								</div> <!-- <div id="sub3_bbs9"> -->
							</div><!-- <div id="userjoinBox"> -->				
							<!-- ----------------------------------------------개인 동영상 및 포트폴리오 파일----------- --------------------------------------------->
						</div>
						</div>
						
						<!-- body 끝 -->
		        </div>
		        <div class="modal-footer">
		          <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
		        </div>
				
			</div>
			<!-- modal content div 종료 -->
			
		</div>
		<!-- modal-dialog div 종료 -->
		
	</div>

<%@include file="../common_footer_fap.jsp"%>
</body>
</html>
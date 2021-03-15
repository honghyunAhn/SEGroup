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
	$(function(){
		select_box_event();
	})
	var myApp = angular.module('myapp', []);
	
	myApp.controller('OpenPtResumeApplyController', ['$scope', '$compile', '$http','$timeout', function($scope, $compile, $http,$timeout) {
		
		//이력서 등록폼으로 이동
		$scope.moveResumeInsert = function(){
			location.href = "/fap/user/resume_management";
		}
		$scope.openResumeDetailModal = function (e) {
			var fap_resume_seq = $('#fap_resume_seq').val();
			
			if(fap_resume_seq == 0){
				alert('<spring:message code="fap.open_edu.resume_select_check" />');
				return;
			}
			
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
		//[start] 지원 이력서보기 모달창 출력 종료(남유송)
		
	}]);
	
		
		var blur_flag = true;
		
		//셀렉트 박스 공통 이벤트
		function select_box_event(){
			$(".resume_select").off("click").on("click",function(){
				$(this).toggleClass("on");
				$(this).nextAll(".resume_select_option").toggle();
			});
			
			$(".resume_select_option").off("mouseenter").on("mouseenter",function(){
				blur_flag = false;
			});
			$(".resume_select_option").off("mouseleave").on("mouseleave",function(){
				blur_flag = true;
			});
			
			$(".resume_select_btn").blur(function(){
		 		if(blur_flag){
					$(this).closest(".resume_select").removeClass("on");
					$(this).closest(".resume_select").nextAll(".resume_select_option").css("display","none");
		 		}
			});
			
			$(".option-type").off("click").on("click",function(){
				if(!$(this).hasClass("selected")){
					var btnval = $(this).find("span").text();
					var org_code = $(this).find("span").attr("value");
					$(this).closest(".resume_dropdown").find(".resume_select span").text(btnval);
					$(this).closest(".resume_dropdown").find(".resume_select input").val(org_code);
					
					$(this).siblings().removeClass("selected");
					$(this).addClass("selected");
				}
				$(this).closest(".resume_dropdown").find(".resume_select").removeClass("on");
				$(this).closest(".resume_dropdown").find(".resume_select").nextAll(".resume_select_option").css("display","none");
		
			});
		}
	
	
	
		function apply_check(){
			var user_flag = $("#user_flag").val();
			
			var fap_resume_seq = $('#fap_resume_seq').val();
			
			if (typeof fap_resume_seq == "undefined" || fap_resume_seq == "") {
				alert('<spring:message code="fap.open_edu.resume_insert_check" />');
				return;
			}
			
			if(user_flag == 'A0101' || user_flag == 'A0106'){
				alert('<spring:message code="fap.open_edu.join_comment" />\n<spring:message code="fap.open_com.main" />');
				location.href="/fap/user/user_main";
			}else{
				var fap_open_pt_seq = $("#fap_open_pt_seq").val();
				$.ajax({
					beforeSend: function(xhr) {
					     xhr.setRequestHeader("AJAX", true);
					},
					url : '/fap/user/user_open_pt_edu_apply',
					type : 'post',
					data : {
						fap_open_pt_seq : fap_open_pt_seq,
						fap_resume_seq : fap_resume_seq
					},
					success : function(response){
						
						if(response == 0){
							alert('<spring:message code="fap.open_com.join_complete" />\n<spring:message code="fap.open_com.join_check" />');
						}else{
							alert('<spring:message code="fap.open_com.join_already" />\n<spring:message code="fap.open_com.join_check" />');
						}
						location.href="/fap/user/user_main";
					},
					error : function(e){
						console.log(e);
						if(e.status == 403){
							alert('<spring:message code="com.login.ajaxSesstion" javaScriptEscape="true" />');
							location.href = "/fap/user/user_login";
						}
					}
				})
			}
			
		}
		function login_check(){
			alert('<spring:message code="fap.open_com.join_login_check" />\n<spring:message code="fap.open_com.login" />');
			location.href="/fap/user/user_open_pt_edu_info_login";
		}
		function back_main(){
			location.href="/fap/user/user_main";
		}
	</script>
	
</head>
<body ng-app="myapp" ng-controller="OpenPtResumeApplyController">
<sec:authorize access="hasAnyRole('ROLE_A0100,ROLE_A0101,ROLE_A0102,ROLE_A0106')">
	<sec:authentication property="details" var="check" />
	<sec:authentication property="details.user" var="user" />
	<input type="hidden" id="user_flag" value="${user.user_flag}">
	<input type="hidden" name="user_id" value="${user.user_id}" id="user_id">
</sec:authorize>
<%@include file="user_menu.jsp"%>
<div class="join-wrap">
	<div id="subcontents">
		<c:choose>
			<c:when test="${empty result}">
				<div class="open_pt_wrap">
					<div class="open_pt_empty">
						<spring:message code="fap.open_edu.empty" />
						<div class="empty_btn">
							<button class="open_pt_empty_btn" onclick="back_main()"><spring:message code="fap.open_com.main" /></button>
						</div>
					</div>
				</div>
			</c:when>
			<c:otherwise>
				<div class="open_pt_wrap">
					${result.fap_open_pt_ct }
				</div>
				<div class="open_pt_apply">
					<c:choose>
						<c:when test="${result.fap_open_pt_close_gb == 'D1202' }">
							<spring:message code="fap.open_edu.join_end" />
						</c:when>
						<c:otherwise>
							<c:choose>
								<c:when test="${empty check}">
									<input type="button" class="open_pt_apply_btn" value="<spring:message code="fap.open_com.join" />" onclick="login_check()">
								</c:when>
								<c:otherwise>
									<div class="open_pt_resume_wrap">
										<div class="open_pt_resume_row">
											<div class="resume_lt"><spring:message code="fap.open_edu.resume" /></div>
											<div class="resume_rt">
												<c:choose>
													<c:when test="${empty resumeFormList}">
														<button class="resume_insert" type="button" ng-click="moveResumeInsert()">
															<spring:message code="fap.open_edu.resume_insert" />
														</button>
													</c:when>
													<c:otherwise>
														<div class="resume_dropdown">
															<div class="resume_select">
																<button type="button" class="resume_select_btn"><span><spring:message code="fap.open_edu.resume_select_check" /></span></button>
																<input type="hidden" id="fap_resume_seq" value="0">
															</div>
															<div class="resume_select_option">
																<ul class="option-list">
																	<c:forEach items="${resumeFormList}" var="resumeFormList">
																		<li class="option-type">
																			<button type="button"><span value="${resumeFormList.fap_resume_seq}">${resumeFormList.fap_resume_title}</span></button>
																		</li>
																	</c:forEach>
																</ul>
															</div>
														</div>
														<button class="join_btn resume_check" type="button" ng-click="openResumeDetailModal($event)">
															<spring:message code="fap.open_edu.resume_check" />
														</button>
													</c:otherwise>
												</c:choose>
											</div>
										</div>
									</div>
									<input type="button" class="open_pt_apply_btn" value="<spring:message code="fap.open_com.join" />" onclick="apply_check()">
								</c:otherwise>
							</c:choose>
							<input type="hidden" id="fap_open_pt_seq" value="${result.fap_open_pt_seq }">
						</c:otherwise>
					</c:choose>
				</div>
			</c:otherwise>
		</c:choose>
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
	<!-- modal fade div 종료 -->

<%@include file="../common_footer_fap.jsp"%>
</body>
</html>
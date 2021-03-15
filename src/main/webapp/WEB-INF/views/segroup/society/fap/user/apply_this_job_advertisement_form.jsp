<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<!DOCTYPE html>
<html>
<head>
	<script src="<c:url value="/resources/segroup/js/jquery-3.1.1.js" />"></script>
	<script src="<c:url value="/resources/segroup/js/angular.min.js" />"></script>
	<script src="<c:url value="/resources/segroup/society/fap/js/layer.js" />"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
	<link type="text/css" rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto:400,500">
	<link rel="stylesheet" type="text/css" href="<c:url value="/resources/segroup/society/fap/css/userDefault.css" />" />
	<link rel="stylesheet" type="text/css" href="<c:url value="/resources/segroup/society/fap/css/layer.css" />" />
	<link rel="stylesheet" type="text/css" href="<c:url value="/resources/segroup/society/fap/css/popModal.css" />" />
	
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Bridge Job Fair</title>
</head>
<script type="text/javascript">



	$(function() {
		select_event();
		
		$(".apply-agree").on("click",function(){
			$(this).toggleClass("check");
		})
		
		$(".btn-layerClose").on("click",function(){
			var flag = $(".apply-agree").hasClass("check");
			
			if(!flag){
				alert("주의사항을 확인 하신 후 체크를 해주셔야 입사지원이 가능합니다");
			}else{
				var fap_job_app_info_rank = $('#fap_job_app_info_rank').val();
				var fap_jobfair_divide_gb = $("#fap_jobfair_divide_gb").val();
				var fap_job_ad_rule_type = $("#fap_job_ad_rule_type").val();
				var fap_jobfair_seq = $('#applyJobAdvertisement').find('#fap_jobfair_seq').val();
				
				//서울페어 && E타입
				if(fap_jobfair_divide_gb == 'C0100' && fap_job_ad_rule_type == 'D2000'){
					
					//지망순위가 1순위가 아닐경우
					if(fap_job_app_info_rank != 1){
						alert("E Type 의 채용공고는 1지망으로만 지원이 가능합니다.");
						return;
					}
					
				}
				
				$.ajax({
					beforeSend: function(xhr) {
					     xhr.setRequestHeader("AJAX", true);
					},
					url : '/fap/user/user_apply_confirm',
					type : 'post',
					data : {
								fap_jobfair_seq : fap_jobfair_seq
					},
			        dataType : "json", 
					success : function(response) {
						
						if(response){
							var successMessage = '';
							successMessage += '해당 회사에 지원신청을 완료하였습니다.\n';
							successMessage += '채용공고 목록페이지로 이동합니다.';
							alert(successMessage);
							$("#fap_job_app_info_rank_in_form").val($("#fap_job_app_info_rank").val());
							$('#applyJobAdvertisement').submit();
						}
					},
					error : function(response){
						$(this).prop('disabled', false);
						console.log(response);
						if(response.status == 403){
							alert('<spring:message code="com.login.ajaxSesstion" javaScriptEscape="true" />');
							location.href = "/fap/user/user_login";
						}
					}
				});
			
			}
			
		})
	});
	
	var myApp = angular.module('myapp', []);
	
	myApp.controller('PersonalApplicationStatusController', ['$scope', '$compile', '$http','$timeout', function($scope, $compile, $http,$timeout) {
		
		//이력서 등록폼으로 이동
		$scope.moveResumeInsert = function(){
			location.href = "/fap/user/resume_management";
		}
		
		//[start] 지원 이력서보기 모달창 출력 시작(남유송)
		$scope.openResumeDetailModal = function (e) {
			var fap_resume_seq = $('#fap_resume_seq').val();
			
			if(fap_resume_seq == 0){
				alert("이력서를 선택해 주세요.");
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
	
	//selectcode
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
	
	//codeconverter
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
	
	
	var blur_flag = true;
	
	//셀렉트 박스 공통 이벤트
	function select_box_event(){
		$(".BBS-select").off("click").on("click",function(){
			$(this).toggleClass("on");
			$(this).nextAll(".BBS-select-option").toggle();
		});
		
		$(".BBS-select-option").off("mouseenter").on("mouseenter",function(){
			blur_flag = false;
		});
		$(".BBS-select-option").off("mouseleave").on("mouseleave",function(){
			blur_flag = true;
		});
		
		$(".BBS-select-btn").blur(function(){
	 		if(blur_flag){
				$(this).closest(".BBS-select").removeClass("on");
				$(this).closest(".BBS-select").nextAll(".BBS-select-option").css("display","none");
	 		}
		});
	}
	
	// 교육기관 이벤트
	function select_event() {
		select_box_event();
		
		$(".option-type").off("click").on("click",function(){
			if(!$(this).hasClass("selected")){
				var btnval = $(this).find("span").text();
				var org_code = $(this).find("span").attr("value");
				$(this).closest(".BBS-dropdown").find(".BBS-select span").text(btnval);
				$(this).closest(".BBS-dropdown").find(".BBS-select input").val(org_code);
				
				$(this).siblings().removeClass("selected");
				$(this).addClass("selected");
			}
			$(this).closest(".BBS-dropdown").find(".BBS-select").removeClass("on");
			$(this).closest(".BBS-dropdown").find(".BBS-select").nextAll(".BBS-select-option").css("display","none");
	
		});
	}
	//시간체크
	//현재 최초, 추가 확인 후 추가테이블에 설정된 회사인지도 체크
	function applyFormCheck() {
		var fap_job_app_info_rank = $('#fap_job_app_info_rank').val();
		var fap_resume_seq = $('#fap_resume_seq').val();		
		var fap_jobfair_divide_gb = $("#fap_jobfair_divide_gb").val();
		var fap_job_ad_rule_type = $("#fap_job_ad_rule_type").val();
		
		if(typeof fap_resume_seq == "undefined"){
			alert("이력서를 등록해 주세요.");
			return false;
		}
		
		if(fap_job_app_info_rank == 0){
			alert('지망 순위를 선택해주세요.');
			return false;
		}
		if(fap_resume_seq == 0){
			alert('제출할 이력서를 선택해주세요.');
			return false;
		}
	
		 
		//지원자의 개인정보가 기업에 노출되는 부분에 대해 동의를 받음 	
			
		var realApply = confirm('<spring:message code="fap.resume.exposure_agree_phrase" javaScriptEscape="true" />');
		if(realApply == false){					 
			return false;
		}					 
		var fap_job_exp_agree_gb="D1901";
		$("#fap_job_exp_agree_gb").val(fap_job_exp_agree_gb);			 

		
		//지원하기전에 한번 더 지원가능 체크하는 부분 
		var fap_jobfair_divide_seq = $('#applyJobAdvertisement').find('#fap_jobfair_divide_seq').val();
		var fap_jobfair_seq = $('#applyJobAdvertisement').find('#fap_jobfair_seq').val();
		var fap_job_ad_seq = $('#applyJobAdvertisement').find('#fap_job_ad_seq').val();
		
		$('#fap_selected_resume_seq').val(fap_resume_seq);
		
		var applyApplicableCheckInfo = {
				'fap_job_ad_seq' : fap_job_ad_seq
				,'fap_jobfair_divide_seq' : fap_jobfair_divide_seq
				,'fap_jobfair_seq' : fap_jobfair_seq
	
		}
	
		$.ajax({
			beforeSend: function(xhr) {
			     xhr.setRequestHeader("AJAX", true);
			},
			url : 'apply_this_job_advertisement_applicable_check',
			type : 'post',
			contentType: 'application/json',
			data : JSON.stringify(applyApplicableCheckInfo),
	        dataType : "text", 
			success : function(response) {
				$(this).prop('disabled', false);
				switch(response){
					case 'inapplicableTime' : 
						alert('지원 가능한 시간이 아닙니다.');
						break;
					case 'duplicateTrue' : 
						alert('이미 지원한 회사입니다.');
						break;
					case 'useAllQuarter' :
						alert('지망개수를 모두 소진하여 더이상 지망을 할 수 없습니다.');
						break;
					case 'needConfirmApplyCheck' :
						layer_popup("#apply_confirm_check_layer");
						break;
					default : 
						//지원가능 할 때 부분
						//서울페어 && E타입
						if(fap_jobfair_divide_gb == 'C0100' && fap_job_ad_rule_type == 'D2000'){
							
							//지망순위가 1순위가 아닐경우
							if(fap_job_app_info_rank != 1){
								alert("E Type 의 채용공고는 1지망으로만 지원이 가능합니다.");
								break;
							}
							
						}
					
						var successMessage = '';
						successMessage += '해당 회사에 지원신청을 완료하였습니다.\n';
						successMessage += '채용공고 목록페이지로 이동합니다.';
						alert(successMessage);
						$("#fap_job_app_info_rank_in_form").val($("#fap_job_app_info_rank").val());
						$('#applyJobAdvertisement').submit();
						break;
							
						
				}
			},
			error : function(response) {
				$(this).prop('disabled', false);
				console.log(response);
				if(response.status == 403){
					alert('<spring:message code="com.login.ajaxSesstion" javaScriptEscape="true" />');
					location.href = "/fap/user/user_login";
				}
			}
		});
	}
	
	//지원을 하지 않고 채용공고 목록페이지로 돌아가는 부분
	function backJobAdvertisementList() {
		location.href='user_job_advertisement_list_form';
	}
</script>
<body ng-app="myapp" ng-controller="PersonalApplicationStatusController">
	<sec:authorize access="hasAnyRole('ROLE_A0100', 'ROLE_A0101', 'ROLE_A0102', 'ROLE_A0106', 'ROLE_A0108')">
		<sec:authentication property="details.user" var="detail" />
		<input type="hidden" name="user_id" value="${detail.user_id}" id="user_id">		 
	</sec:authorize>
	<%@include file="user_menu.jsp"%>
	<input type="hidden"  value="${fap_jobfair_divide_gb}" id="fap_jobfair_divide_gb">
	<input type="hidden"  value="${applyInfo.fap_job_ad_rule_type}" id="fap_job_ad_rule_type">
	<div class="join-wrap">
		<div id="subcontents">
			<div class="joinBox">
				<div class="jointt">
					<p class="jointxt1">
				       	 지원하기
					</p>
				</div>
				<div class="join-contents">
					<div class="joinBBS">
						<div class="joinBBS-row">
							<div class="joinlt">지원회사</div>
							<div class="joinrt">
								<input type="text" value="${applyInfo.fap_comp_ja_nm}" readonly="readonly">
							</div>
						</div>
						<div class="joinBBS-row">
							<div class="joinlt">지망</div>
							<div class="BBS-dropdown">
								<div class="BBS-select">
									<button type="button" class="BBS-select-btn"><span>지망을 선택 하세요</span></button>
									<input type="hidden" id="fap_job_app_info_rank" name="fap_job_app_info_rank" value="0">
								</div>
								<div class="BBS-select-option">
									<ul class="option-list">
										<c:forEach var="applyAvailableRank" items="${applyInfo.applyAvailableRankList}" varStatus="status">
											<li class="option-type">
												<button type="button"><span value="${applyAvailableRank}">${applyAvailableRank}지망</span></button>
											</li>
										</c:forEach>
									</ul>							
								</div>
								
							</div>
						</div>
						<div class="joinBBS-row">
							<div class="joinlt">이력서</div>
							<div class="joinrt">
								<c:choose>
									<c:when test="${empty resumeFormList}">
										<button class="resume_insert" type="button" ng-click="moveResumeInsert()">
											이력서 등록
										</button>
									</c:when>
									<c:otherwise>
										<div class="BBS-dropdown">
											<div class="BBS-select">
												<button type="button" class="BBS-select-btn"><span>이력서를 선택하세요</span></button>
												<input type="hidden" id="fap_resume_seq" value="0">
											</div>
											<div class="BBS-select-option">
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
											이력서 확인
										</button>
									</c:otherwise>
								</c:choose>
							</div>
						</div>
						
					</div>
				</div>
					
			</div>
			<div class="joinBox">
				<div id="joinBtn">
					<button class="apply-btn submitBtn" onclick="applyFormCheck();">지원하기</button>
					<button class="apply-btn submitBtn red" onclick="backJobAdvertisementList();">목록으로</button>
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
	<!-- modal fade div 종료 -->
	
	<!-- 보증보험 레이어 시작 -->
	
	<div class="dim-layer">
	    <div class="dimBg"></div>
	    <div id="apply_confirm_check_layer" class="pop-layer md">
	        <div class="pop-container">
	            <div class="pop-conts">
	                <!--content //-->
					<div class="confirm-header">
						2020 Bridge JOB Fair 참가요령 및 주의사항 안내
					</div>
					<div class="confirm-body">
						<!-- 일반인용 -->
						<c:if test="${detail.user_flag == 'A0100'}">
					    <div class="container">
					        <ol class="category">
					            <li>
					                2020 Bridge JOB Fair는 참가자가 지원할 수 있는 기업의 수를 다음과 같이 제한하고 있습니다.
					                <ul class="division" style="list-style-type:square">
					                    <li>
					                        <strong>Seoul Fair : 1인당 최대 5개사까지</strong>
					                    </li>
					                    <li>
					                        <strong>Tokyo Fair : 1인당 최대 5개사까지</strong>
					                        <ul class="section" style="list-style-type:none">
					                            <li>
					                                (단, Seoul Fair에 참가한 지원자의 경우 그 결과에 따라 다음과 같이 조정될 수 있습니다.)
					                            </li>
					                            <li>
					                                (1) <strong>Seoul Fair에 참가하여 합격(내정)된 기업을 입사포기하고 참가할 경우</strong> : 합격기업 수만큼 삭감<br> (예) 서울페어에서 5개사를 지원, 2개사에 합격(내정)된 경우 3개사까지만 지원가능
					                            </li>
					                            <li>
					                                (2) <strong>Seoul Fair에 참가하지 않았거나, 참가하였더라도 합격(내정)된 기업이 없는 경우</strong> : 5개사까지 지원가능
					                            </li>
					                        </ul>
					                    </li>
					                </ul>
					            </li>
					            <li>
					                E-Type으로 입사전형을 시행하는 기업에 지원할 때는 <span class="c-red">주의</span>하세요.
					                <ul class="division" style="list-style-type:square">
					                    <li>
					                        <strong>E-Type의 입사전형이란 채용(내정)이 되면 다른 기업으로의 지원을 포기하는 것을 조건으로
					                            입사희망자를 선발하는 것으로, E-Type의 기업에 지원하여 채용(내정)이 확정되면,
					                            다른 기업으로의 지원 사항은 자동적으로 취소 처리되게 됩니다.</strong>
					                    </li>
					                    <li>
					                        따라서 E-Type의 기업에는 입사의사가 확실한 경우에만 지원하여야 합니다.<br>전형의 성격상 E-Type의 기업은<strong> 1인당 1개사만 지</strong>원이 가능합니다. (예) 서울페어에서 E-Type 1개사를 포함 총5개사를 지원한 경우 E-Type기업에 채용(내정)이 확정되면 다른 기업의 합격여부에 관계없이 여타 4개사에 대한 지원자체가 시스템에 의해 취소처리 되며 도쿄페어에도 참석할 수 없습니다.
					                    </li>
					                </ul>
					            </li>
					            <li>
					                본 잡페어는 정부지원 K-Move센터 사업의 일환으로 시행되는 것으로 본 잡페어를 통해 취업을 확정한 지원자는 관련 <strong>해외취업증빙자료를 기한내에 제출하셔야 합니다.</strong> (세부내용 해당자 추후 공지)
					            </li>
					            <%-- 
					            <li>
					                항공임 지원관련 안내
					                <ul class="division" style="list-style-type:square">
					                    <li>
					                        도쿄페어 참가지원자가 현지면접의 대상자로 확정된 경우 다음과 같이 왕복항공임을 지원합니다. 동 지원은 잡페어 참가기업의 후원하에 이루어지는 것으로서 다음과 같은 경우 지원대상에서 제외됩니다.
					                        <ul class="section" style="list-style-type:disc">
					                            <li>
					                                현지 잡페어의 지정된 장소와 시간에 참석하지 않는 경우
					                            </li>
					                            <li>
					                                현지 잡페어를 통해 지원기업에 채용(내정)이 확정되었으나 취업을 이행하지 않는 경우 (복수기업에 합격된 경우 어느 1개사에만 취업을 이행하면 됩니다.)
					                            </li>
					                        </ul>
					                    </li>
					                    <li>
					                        항공임 지원 희망자는 다음과 같이 신청서 작성 제출
					                        <ul class="section" style="list-style-type:disc">
					                            <li>
					                                지원서양식은 별도 없으며, 도쿄페어 행사 종료 후 항공권 구매영수증 또는 이티켓, 지원금 수령계좌정보를 <span class="c-blue">job@sesoc.global</span>에 제출해야합니다.
					                            </li>
					                            <li>
					                                <strong>보증보험 부보</strong> : 2019.11.22까지 웹사이트를 통해 부보동의서 전자서명 환수를 담보하기 위한 보험으로 보험료 부담액은 없으며, 채용(내정)이 확정된 기업이 없는 경우에는 환수대상이 아닙니다.
					                            </li>
					                            <li>
					                                <strong>지원시기</strong> : 잡페어 종료후 2주이내
					                            </li>
					                            <li>
					                                <strong>지원한도</strong> : 1인 기준 40만원 한도 내 실비지급
					                            </li>
					                        </ul>
					                    </li>
					                </ul>
					                <img src="<c:url value="/resources/segroup/society/fap/images/normal.jpg" />" alt="일반인용 부보절차">
					            </li>
					            <li>
					                JOB Fair에서 제출되는 입사지원 서류는 거짓이 없어야 하고, 허위사실을 기재할 경우 채용전형에서 불이익이 발생할 수 있습니다.
					            </li>
					             --%>
					        </ol>
					        <div class="from-text">
					            Soft Engineer Society Bridge JOB Fair 사무국 귀하
					        </div>
					    </div>
						</c:if>
					    <!-- 마스터용 -->
					    <c:if test="${detail.user_flag == 'A0101' or detail.user_flag == 'A0106' or detail.user_flag == 'A0108'}">
					    <div class="container">
					        <ol class="category">
					            <li>
					                2020 Bridge JOB Fair는 참가자가 지원할 수 있는 기업의 수를 다음과 같이 제한하고 있습니다.
					                <ul class="division" style="list-style-type:square">
					                    <li>
					                        <strong>Seoul Fair : 1인당 최대 5개사까지</strong>
					                    </li>
					                    <li>
					                        <strong>Tokyo Fair : 1인당 최대 5개사까지</strong>
					                        <ul class="section" style="list-style-type:none">
					                            <li>
					                                (단, Seoul Fair에 참가한 지원자의 경우 그 결과에 따라 다음과 같이 조정될 수 있습니다.)
					                            </li>
					                            <li>
					                                (1) <strong>Seoul Fair에 참가하여 합격(내정)된 기업을 입사포기하고 참가할 경우</strong> : 합격기업 수만큼 삭감<br>(예) 서울페어에서 5개사를 지원, 2개사에 합격(내정)된 경우 3개사까지만 지원가능
					                            </li>
					                            <li>
					                                (2) <strong>Seoul Fair에 참가하지 않았거나, 참가하였더라도 합격(내정)된 기업이 없는 경우</strong> : 5개사까지 지원가능
					                            </li>
					                        </ul>
					                    </li>
					                </ul>
					            </li>
					            <li>
					                E-Type으로 입사전형을 시행하는 기업에 지원할 때는 <span class="c-red">주의</span>하세요.
					                <ul class="division" style="list-style-type:square">
					                    <li>
					                        <strong>E-Type의 입사전형이란 채용(내정)이 되면 다른 기업으로의 지원을 포기하는 것을 조건으로
					                            입사희망자를 선발하는 것으로, E-Type의 기업에 지원하여 채용(내정)이 확정되면,
					                            다른 기업으로의 지원 사항은 자동적으로 취소 처리되게 됩니다.</strong>
					                    </li>
					                    <li>
					                        따라서 E-Type의 기업에는 입사의사가 확실한 경우에만 지원하여야 합니다. <br>전형의 성격상 E-Type의 기업은<strong> 1인당 1개사만 지</strong>원이 가능합니다.<br>(예) 서울페어에서 E-Type 1개사를 포함 총5개사를 지원한 경우 E-Type기업에 채용(내정)이 확정되면 다른 기업의 합격여부에 관계없이 여타 4개사에 대한 지원자체가 시스템에 의해 취소처리 되며 도쿄페어에도 참석할 수 없습니다.
					                    </li>
					                </ul>
					            </li>
					            <li>
					                해외취업 국비지원과정 연수생으로서 잔여교육과정에 성실히 임하며, 적극적인 구직활동, 취업 후 해외취업증빙자료 제출 등의 의무가 있음을 인지하며, 이에 대한 이행보증보험 부보절차가 진행됩니다.
					                <ul class="division" style="list-style-type:square">
					                    <li>
					                        제출자료 : 재직증명서(입사 1개월 후 발급분), 고용계약서, 비자사본, 취업사실확인서(월드잡 플러스 발급)
					                    </li>
					                    <li>
					                        제출기한 : 2020년 5월 30일까지
					                        <ul class="section" style="list-style-type:none">
					                            <li>
					                            1) 취업 후 관련증빙자료 미제출 시<br>: 정부제출용 증빙자료 대리확보 활동에 소요되는 경비 변제 (1인당 150만원 한도)
					                            </li>
					                            <li>
					                                2) 취업 확정 후 잔여교육과정에 성실히 참여하지 않아 정부 수료기준 미달시 발생하는 기회비용변제 (1인당 150만원 한도)
					                            </li>
					                            <li>
					                                3) 지원기업에 내정(입사확정 등) 되었음에도 단순변심 등으로 취업을 이행하지 않을 경우
					                                <br>: JOB Fair 제 경비(잡페어 기획 및 참가비, 채용전형 지원비 등) 에 대한 변제 (1인당 150만원한도)
					                            </li>
					                        </ul>
				                            <img src="<c:url value="/resources/segroup/society/fap/images/master.jpg" />" alt="마스터용 부보절차" >
					                    </li>
					                </ul>
					            </li>
					            <li>
					                JOB Fair에서 제출되는 입사지원 서류는 거짓이 없어야 하고, 허위사실을 기재할 경우 채용전형에서 불이익이 발생할 수 있습니다.
					            </li>
					        </ol>
					        <div class="from-text">
					            Soft Engineer Society Bridge JOB Fair 사무국 귀하
					        </div>
					    </div>
					    </c:if>
					</div>
					<div class="confirm-footer">
						<div class="apply-agree">
							<span>상기내용을 확인하였습니다.</span>
						</div>
					</div>
	                <!--// content-->
	                <div class="btn-r">
	                    <a href="#" class="btn-layerClose">확인</a>
	                </div>
	            </div>
	        </div>
	    </div>
	</div>
	
	<!-- 보증보험 레이어 종료 -->
	
	
	<form id="applyJobAdvertisement" method="post" action="apply_this_job_advertisement">
			<input type="hidden" name="fap_comp_id" value="${applyInfo.fap_comp_id}">
			<input type="hidden" name="fap_job_ad_seq" id="fap_job_ad_seq" value="${applyInfo.fap_job_ad_seq}">
			<input type="hidden" name="fap_jobfair_seq" id="fap_jobfair_seq" value="${applyInfo.fap_jobfair_seq}">
			<input type="hidden" name="fap_jobfair_divide_seq" id="fap_jobfair_divide_seq" value="${applyInfo.fap_jobfair_divide_seq}">
			<input type="hidden" name="apply_flag" value="${applyInfo.apply_flag}">
			<input type="hidden" id="fap_job_app_info_rank_in_form" name="fap_job_app_info_rank" value="0">
			<input type="hidden" name="fap_resume_seq" id="fap_selected_resume_seq">
			<input type="hidden" name="fap_job_exp_agree_gb" id="fap_job_exp_agree_gb">	
	</form>
	
	<%@include file="../common_footer_fap.jsp"%>	
</body>
</html>
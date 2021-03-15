<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<!DOCTYPE html PUBLIC>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Bridge Job Fair</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
<script src="<c:url value="/resources/segroup/js/angular.min.js" />"></script>
<script type="text/javascript">
$(function() {
	$("input").attr("readonly",true);
	$("input[type=radio]").attr('disabled', true);	
		
});
//angular module 
		var myApp = angular.module('myapp', []);
		
		myApp.controller('ResumeController',['$scope','$compile', '$http', function($scope, $compile, $http) {
			//전형별 정보 가져오기
			$http({
				url:'applied_result_list',
				method: 'post',
				params: {
					fap_job_ad_seq : $('#fap_job_ad_seq').val()
				},
				XMLHttpRequestResponseType: 'json'
			}).then(function successCallback(response){
				console.log(response.data);
				$scope.appliedResultInfo = response.data;
			}, function errorCallback(response) {
				console.log(response);
			});
			 
			$scope.resumeModal = function(e) {
				var fap_job_ad_seq = $(e.currentTarget).attr('id');
				var fap_resume_seq = $(e.currentTarget).val();
				var user_id = $(e.currentTarget).attr('seq');
				$('#myModal').modal('show');
				
				$http({
					url: 'applied_resume_list',
					method: 'post',
					params: {
								fap_job_ad_seq : fap_job_ad_seq
								,fap_resume_seq : fap_resume_seq
								,user_id : user_id
							},
					dataType: 'json'
				}).then(function successCallback(response) {
					var wholeResumeJson = JSON.stringify(response.data);
 					var replaceJson = wholeResumeJson.replace(/(?:\r\n|\r|\n)/g, '<br />');
 					$scope.resumeApply = JSON.parse(replaceJson);
					
					$scope.file_change = function(file) {
						var val = $("#fap_resume_pic").val();
			
						if (val == "") {
							$("#fap_resume_pic").val('');
							$("#photoDiv").empty();
							return;
						} else if (fileImageCheck(val)) {
							photoAjax();
						} else {
							$("#fap_resume_pic").val('');
							$("#photoDiv").empty();
							alert("이미지 파일이 아닙니다. gif, jpg, png 형식만 가능 합니다.");
							return;
						}
					}
					
					$scope.addResumeAddr = function(){
						var resumeAddrClass = $(".resumeAddr");
						var addrIndex = resumeAddrClass.length;
						
						var content = '<li class="resumeAddr">주소<input type="text" name="resumeAddrList['+addrIndex+'].fap_resume_address"> </li>';
						
						$(".resumeAddr:last").after($compile(content)($scope));	
					}
					
					$scope.removeResumeAddr = function(){
						var addrIndex = $(".resumeAddr").length;
						if(addrIndex > 1) {
							$(".resumeAddr:last").remove();
						}
					}
	
					$scope.addResumeEdu = function(){
						
						//교육 관련 
						var resumeEduClass = $(".resumeEdu");
						var eduIndex = resumeEduClass.length;//datepicker이랑 생각해서 보여줘야함. 
						var eduStartId = "fap_resume_edu_er_dt_" + eduIndex;
						var eduEndId = "fap_resume_edu_gd_dt_" + eduIndex;
						
						var content = '<ul class="resumeEdu">';
						content +='입학/졸업<li><input type="text" name="resumeEduList['+eduIndex+'].fap_resume_edu_er_dt" id="'+eduStartId+'">~<br><input type="text" name="resumeEduList['+eduIndex+'].fap_resume_edu_gd_dt" id="'+eduEndId+'"></li>';
						content +='기간 요약<li><input type="text" name="resumeEduList['+eduIndex+'].fap_resume_edu_pd_summary"></li>';
						content +='기간명/학교<li><input type="text" name="resumeEduList['+eduIndex+'].fap_resume_edu_sc_nm"></li>';	
						content +='과정/단과<li><input type="text" name="resumeEduList['+eduIndex+'].fap_resume_edu_coll"></li>';	
						content +='<li>전공<input type="text" name="resumeEduList['+eduIndex+'].fap_resume_edu_major"></li>';
						content +='전공 계열';	
						content +='<select name="resumeEduList['+eduIndex+'].fap_resume_edu_field">';
						content +='<option selectcode value="B2800" selected></option>';
						content +='<option selectcode value="B2801"></option>';
						content +='<option selectcode value="B2802"></option>';
						content +='<option selectcode value="B2803"></option>';
						content +='<option selectcode value="B2804"></option>';
						content +='<option selectcode value="B2805"></option>';
						content +='<option selectcode value="B2806"></option>';
						content +='<option selectcode value="B2807"></option>';
						content +='</select></li>';
						content +='졸업여부<li><select>'	
						content +='<option selectcode value="B1000" selected></option>'	;
						content +='<option selectcode value="B1001"></option>'	;
						content +='<option selectcode value="B1002"></option>';
						content +='</select></li>'	
						content +='<li><input type="text" name="resumeEduList['+eduIndex+'].fap_resume_edu_note"></li>'	
							
						
						$(".resumeEdu:last").after($compile(content)($scope));	
						minMax(eduStartId, eduEndId);
						
					}
					
					$scope.removeResumeEdu = function(){
						var eduIndex = $(".resumeEdu").length;
						if(eduIndex > 1) {
							$(".resumeEdu:last").remove();
						}
					}
					
					//사회경력
					$scope.addResumeCareer = function(){
						var resumeCareerClass = $(".resumeCareer");	
						var careerIndex = resumeCareerClass.length;
						var careerStartId = "fap_resume_crr_st_" + careerIndex;
						var careerEndId = "fap_resume_crr_et_" + careerIndex;
						
						var content = '<ul class="resumeCareer">';
						content += '<li><select name="resumeCareerList['+careerIndex+'].fap_resume_crr_gb">';
						content += '<option selectcode value="B3900" selected></option>';
						content +='<option selectcode value="B3901"></option>';
						content +='<option selectcode value="B3902"></option>';	
						content +='</select></li>';	
						content += '<li><input type="text" name="resumeCareerList['+careerIndex+'].fap_resume_crr_st" id="'+ careerStartId +'">~<br><input type="text" name="resumeCareerList['+careerIndex+'].fap_resume_crr_et" id="'+careerEndId+'"></li>';
						content += '<li><input type="text" name="resumeCareerList['+careerIndex+'].fap_resume_crr_pd_summary"></li>';
						content += '<li><input type="text" name="resumeCareerList['+careerIndex+'].fap_resume_crr_comp_nm"></li>';
						content += '<li><input type="text" name="resumeCareerList['+careerIndex+'].fap_resume_crr_major_bussiness"></li>';
						content += '<li><input type="text" name="resumeCareerList['+careerIndex+'].fap_resume_crr_job_function"></li>';
						content += '<li><input type="text" name="resumeCareerList['+careerIndex+'].fap_resume_crr_job_position"></li>';
						
						$(".resumeCareer:last").after($compile(content)($scope));				
						minMax(careerStartId, careerEndId);						
						
					}
					$scope.removeResumeCareer = function(){
						var careerIndex = $(".resumeCareer").length;
						console.log(careerIndex);
						if(careerIndex > 1) {
							$(".resumeCareer:last").remove();
						}
					}
					//프로젝트
					$scope.addProject = function(){
						var resumeProjectClass = $(".resumeProject");
						var projectIndex = resumeProjectClass.length;
						var projectStartId = "fap_resume_project_st_" + projectIndex ;
						var projectEndId = "fap_resume_project_et_" + projectIndex;
						
						var content = '<ul class = "resumeProject">';
						content += '<li>프로젝트명<input type="text" name="resumeProjectList['+projectIndex+'].fap_resume_project_nm"></li>';
						content += '<li>주요서비스<input type="text" name="resumeProjectList['+projectIndex+'].fap_resume_project_service"></li>';	
						content += '<li>개발기간<input type="text" name="resumeProjectList['+projectIndex+'].fap_resume_project_st" id="'+ projectStartId +'">~<input type="text" name="resumeProjectList['+projectIndex+'].fap_resume_project_et" id="'+ projectEndId +'"></li>';
						content += '<li>기간요약 <input type="number" name="resumeProjectList['+projectIndex+'].fap_resume_project_pd_summary" id ="fap_resume_project_pd_summary">일</li>';
						content += '<li>담당분야(본인)<input type="text" name="resumeProjectList['+projectIndex+'].fap_resume_project_responsibility"></li>';
						content += '<li>사용기술(본인)<input type="text" name="resumeProjectList['+projectIndex+'].fap_resume_project_technique"></li>';
						content += '<li>총참여인원<input type="number" name="resumeProjectList['+projectIndex+'].fap_resume_project_peoples_num" id="fap_resume_project_peoples_num"></li>';
						content += '</ul>';
						
						$(".resumeProject:last").after(content);
						minMax(projectStartId, projectEndId);
						
					}
					$scope.removeProject = function(){
						var projectIndex = $(".resumeProject").length;
						if(projectIndex > 1) {
							$(".resumeProject:last").remove();
						}
					}
					//자격증
					$scope.addLicense = function() {
						var resumeLicenseClass = $(".resumeLicense");
						var licenseIndex = resumeLicenseClass.length;
						
						var content = '<ul class ="resumeLicense">';
						content += '<li>년<input type="text" name="resumeLicenseList['+licenseIndex+'].fap_resume_license_get_year"></li>';
						content +='<li>월<input type="text" name="resumeLicenseList['+licenseIndex+'].fap_resume_license_get_month"></li>';
						content +='<li>면허/자격<select name="resumeLicenseList['+licenseIndex+'].fap_resume_license_nm">';
						content += '<option value="B2900"></option>';
						content += '<option value="B2901"></option>';
						content += '<option value="B2902"></option>';
						content += '<option value="B2903"></option>';
						content += '<option value="B2904"></option>';
						content += '<option value="B2905"></option>';
						content += '<option value="B2906"></option>';
						content += '<option>직접 입력</option>';
						content += '</select></li>';
						content += '<li>점수<input type="number" name="resumeLicenseList['+licenseIndex+'].fap_resume_license_score" value="0">점</li>';
						content += '<li>발행기관<input type="text" name="resumeLicenseList['+licenseIndex+'].fap_resume_license_issuing_organization"></li>';
						content += '<li>비고<input type="text" name="resumeLicenseList['+licenseIndex+'].fap_resume_license_note"></li>';
						content += '</ul>';
						$(".resumeLicense:last").after($compile(content)($scope));
						
					}
					$scope.removeLicense = function() {
						var licenseIndex = $(".resumeLicense").length;
						//console.log(licenseIndex);
						if(licenseIndex > 1) {
							$(".resumeLicense:last").remove();
						}
					}
					//역량+재능
					$scope.addTalent = function() {
						var resumeTalentClass = $(".resumeTalent");
						var talentIndex = resumeTalentClass.length;
						var talentNumber = talentIndex + 1;
						
						var content = '<ul class="resumeTalent">';
						content += '<li><input type="text" value="No.'+talentNumber+'"></li>';
						content += '<li>내용<input type="text" name="resumeTalentList['+talentIndex+'].fap_resume_talent_content"></li>';
						content += '</ul>';
						
						$(".resumeTalent:last").after(content);
						
					}
					$scope.removeTalent = function() {
						var talentIndex = (".removeTalent").length;
						if(talentIndex > 1) {
							$(".resumeTalent:last").remove();
						}
					}
					//자기소개서 
					$scope.addProfile = function() {
						var resumeProfileClass = $(".resumeProfile");
						var profileIndex = resumeProfileClass.length;
						
						var content = '<ul class="resumeProfile">';
						content += '<li><select name="resumeProfileList['+profileIndex+'].fap_resume_pr_gb">';
						content += '<option selectcode value="B3800"></option>';
						content += '<option selectcode value="B3801"></option>';
						content += '<option selectcode value="B3802"></option>';
						content += '<option selectcode value="B3803"></option>	';
						content +='</select></li>';
						content +='<li><textarea name="resumeProfileList['+profileIndex+'].fap_resume_pr_content"></textarea></li>';
						content += '</ul>';
						
						$(".resumeProfile:last").after(content);
					}
					$scope.removeProfile = function() {
						var profileIndex = (".resumeProfile").length;
						if(profileIndex > 1) {
							$(".resumeProfile:last").remove();
						}
					}
					
				}, function errorCallback(response) {
					console.log(response);
				});
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
</script>
<title>지원자 리스트</title>
</head>
<body ng-app="myapp" ng-controller="ResumeController">
 <%@include file="admin_menu.jsp"%>
 
	<h1>${fap_comp_ja_nm}</h1>
	<input type="hidden" name="fap_job_ad_seq" id="fap_job_ad_seq" value="${fap_job_ad_seq}">
	<c:forEach items="${allApplicantList}" var="applicant">
		<ul>
			<li>${applicant.fap_resume_nm}</li>
		</ul>
			<button ng-click="resumeModal($event)" id="${fap_job_ad_seq}" value ="${applicant.fap_resume_seq}" seq="${applicant.user_id}">이력서 보기</button>
	</c:forEach>
		<ul ng-repeat="appliedInfo in appliedResultInfo">
			<li>{{appliedInfo.fap_job_recruit_pcs_gb}}</li>
			<li>{{appliedInfo.fap_job_app_info_cancel_gb}}</li>
			<li>{{appliedInfo.fap_job_app_rt_acp}}</li>
		</ul>
	
	<!-- Modal --------------->
  <div class="modal fade" id="myModal" role="dialog">
    <div class="modal-dialog">
      <!-- Modal content------------------------->
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal">&times;</button>
          <h4 class="modal-title" id="title"></h4>
        </div>
        <div class="modal-body">
		          <form id ="resume" action="resume_update" method="post" style="width: 100%" enctype="multipart/form-data">
					<input type="hidden" name="fap_resume_seq" value="{{resumeApply.fap_resume_seq}}">
					
					<h1>이력서 제목</h1>
					<br>
					<div>
					<header>이력서 제목</header>
						<table border="1">
							<tr>
								<td>이력서 제목</td>
								<td colspan="2"><input type="text" name="fap_resume_title" id="fap_resume_title" value={{resumeApply.fap_resume_title}}></td>
							</tr>
						</table>
					</div>
						<br>
					<!-- ------------------------------------기본정보---------------------------------------------->	
				
					<div>
						<header>기본정보</header>
						<ul>
							
							<li>
								국적<input type="text" name="fap_resume_nationality" value="{{resumeApply.fap_resume_nationality}}">
							</li>
							<li>사진(파일선택)
								<div ng-switch="!!resumeApply.fap_resume_pic_origin">
									<div ng-switch-when="true">
										<div id="photoDiv"></div>
										<input type="hidden" name="fap_resume_pic_origin" value="{{resumeApply.fap_resume_pic_origin}}">
										<input type="hidden" name="fap_resume_pic_saved" value="{{resumeApply.fap_resume_pic_saved}}"> 
										<img alt="" ng-src="/fap/user/resume_photo_image/{{resumeApply.fap_resume_pic_saved}}">
										<div>
											<a class="display-inline" ng-href="/file_download?origin={{resumeApply.fap_resume_pic_origin}}&saved={{resumeApply.fap_resume_pic_saved}}&path=/fap/user/resume_photo_image">
												{{resumeApply.fap_resume_pic_origin}}
											</a>
											<img class="x_icon" ng-click="resumeApply.fap_resume_pic_origin=false" src="<c:url value="/resources/segroup/society/fap/images/main/deletePic.png" />" alt="" />
										</div>
									</div>
									<div ng-switch-default>
										<div id="photoDiv"></div>
										<input type="hidden" name="fap_resume_pic_saved" value="{{resumeApply.fap_resume_pic_saved}}">
										<input type="file" name="fap_resume_pic" id="fap_resume_pic" onchange="angular.element(this).scope().file_change(this)" accept="image/*">
									</div>
								</div>
							</li>
						</ul>
						
						<ul class = "resumeName">		
							<li><code value="B3100" name="resumeNameList[0].fap_resume_lang_gb"></code><input type="text" name="resumeNameList[0].fap_resume_nm" id="fap_resume_nm" value="{{resumeApply.resumeNameList[0].fap_resume_nm}}"></li>
							<li><code value="B3101" name="resumeNameList[1].fap_resume_lang_gb"></code><input type="text" name="resumeNameList[1].fap_resume_nm" id="fap_resume_nm" value="{{resumeApply.resumeNameList[1].fap_resume_nm}}"></li>
							<li><code value="B3102" name="resumeNameList[2].fap_resume_lang_gb"></code><input type="text" name="resumeNameList[2].fap_resume_nm" id="fap_resume_nm" value="{{resumeApply.resumeNameList[2].fap_resume_nm}}"></li>
							<li><code value="B3103" name="resumeNameList[3].fap_resume_lang_gb"></code><input type="text" name="resumeNameList[3].fap_resume_nm" id="fap_resume_nm" value="{{resumeApply.resumeNameList[3].fap_resume_nm}}"></li>
						</ul>
						<ul>	
							<li class="resumeAddr"  ng-repeat="addr in resumeApply.resumeAddrList">주소<input type="text" name="resumeAddrList[{{$index}}].fap_resume_address" value="{{addr.fap_resume_address}}"> </li>
						</ul>
						<ul>	
							<li>생년월일</li>
							<li>
								<input type="text" name="fap_resume_birth" value="{{resumeApply.fap_resume_birth}}">
							</li>
							<li> 성별
								<input type="radio" name="fap_resume_gender" value="A0000" checked>
								<code value="A0000"></code>
								<input type="radio" name="fap_resume_gender" value="A0001">
								<code value="A0001"></code>
							</li>
							<li> 기혼 여부
								<input type="radio" name="fap_resume_marital" checked>
								<code value="B3001"></code>
								<input type="radio" name="fap_resume_marital">
								<code value="B3000"></code>
							</li>
							<li> 부양가족
								<input type="text" name="fap_resume_dependents" value="{{resumeApply.fap_resume_dependents}}">명
							</li>
						</ul>
					</div>
							<br><br>
					<!-- ------------------------------------학력관련 교육이수 ---------------------------------------------->	
					<div>
						<header>학력,관련 교육 이수</header>
						
						<ul class="resumeEdu" ng-repeat="eduHistory in resumeApply.resumeEduList">
							<li>입학/졸업<input type="text" name="resumeEduList[{{$index}}].fap_resume_edu_er_dt" id="fap_resume_edu_er_dt_0" value="{{eduHistory.fap_resume_edu_er_dt}}">
							~<br><input type="text" name="resumeEduList[{{$index}}].fap_resume_edu_gd_dt" id="fap_resume_edu_gd_dt_0" value="{{eduHistory.fap_resume_edu_gd_dt}}"></li>
							<li>기간 요약<input type="text" name="resumeEduList[{{$index}}].fap_resume_edu_pd_summary" value="{{eduHistory.fap_resume_edu_pd_summary}}"></li>
							<li>기간명/학교<input type="text" name="resumeEduList[{{$index}}].fap_resume_edu_sc_nm" value="{{eduHistory.fap_resume_edu_sc_nm}}"></li>
							<li>과정/단과<input type="text" name="resumeEduList[{{$index}}].fap_resume_edu_coll" value="{{eduHistory.fap_resume_edu_coll}}"></li>
							<li>전공<input type="text" name="resumeEduList[{{$index}}].fap_resume_edu_major" value="{{eduHistory.fap_resume_edu_major}}"></li>
							<li>전공 계열
								<select name="resumeEduList[{{$index}}].fap_resume_edu_field" ng-model="eduHistory.fap_resume_edu_field" disabled>
									<option selectcode value="B2800" selected></option>
									<option selectcode value="B2801"></option>
									<option selectcode value="B2802"></option>
									<option selectcode value="B2803"></option>
									<option selectcode value="B2804"></option>
									<option selectcode value="B2805"></option>
									<option selectcode value="B2806"></option>
									<option selectcode value="B2807"></option>
								</select>
							</li>
							<li>졸업여부
								<select name="resumeEduList[{{$index}}].fap_resume_edu_gd_ck" ng-model="eduHistory.fap_resume_edu_gd_ck" disabled>
											<option selectcode value="B1000" selected></option>
											<option selectcode value="B1001"></option>
											<option selectcode value="B1002"></option>
								</select>
							</li>
							<li>비고<input type="text" name="resumeEduList[{{$index}}].fap_resume_edu_note" value="{{eduHistory.fap_resume_edu_note}}"></li>
						</ul>
					    </div>
					 	<br><br>
					 	
					<!-- ------------------------------------사회경력 ---------------------------------------------->	
					<div>
						<header>사회경력</header>
							<ul class="resumeCareer" ng-repeat ="career in resumeApply.resumeCareerList">
								<li>
									<select name="resumeCareerList[{{$index}}].fap_resume_crr_gb" value="{{career.fap_resume_crr_gb}}" disabled>
										<option selectcode value="B3900" selected></option>
										<option selectcode value="B3901"></option>
										<option selectcode value="B3902"></option>
									</select>
								</li>
								<li>근무기간<input type="text" name="resumeCareerList[{{$index}}].fap_resume_crr_st" id="fap_resume_crr_st_0" value="{{career.fap_resume_crr_st}}">
								~<br><input type="text" name="resumeCareerList[{{$index}}].fap_resume_crr_et" id="fap_resume_crr_et_0" value="{{career.fap_resume_crr_et}}"></li>
								<li>기간요약 <input type="number" name="resumeCareerList[{{$index}}].fap_resume_crr_pd_summary" id ="fap_resume_crr_pd_summary" value="{{career.fap_resume_crr_pd_summary}}">일</li>
								<li>회사명<input type="text" name="resumeCareerList[{{$index}}].fap_resume_crr_comp_nm" value="{{career.fap_resume_crr_comp_nm}}"></li>
								<li>회사 주요 사업<input type="text" name="resumeCareerList[{{$index}}].fap_resume_crr_major_bussiness" value="{{career.fap_resume_crr_major_bussiness}}"></li>
								<li>담당 업무<input type="text" name="resumeCareerList[{{$index}}].fap_resume_crr_job_function" value="{{career.fap_resume_crr_job_function}}"></li>
								<li>직위<input type="text" name="resumeCareerList[{{$index}}].fap_resume_crr_job_position" value="{{career.fap_resume_crr_job_position}}"></li>
							</ul>
					</div>
						<br>
					<!-- ------------------------------------프로젝트 ---------------------------------------------->
					<div>
						<header>SW 프로젝트 개발경력</header>
						<ul class = "resumeProject" ng-repeat="project in resumeApply.resumeProjectList">
							<li>프로젝트명<input type="text" name="resumeProjectList[{{$index}}].fap_resume_project_nm" value="{{project.fap_resume_project_nm}}"></li>
							<li>주요서비스<input type="text" name="resumeProjectList[{{$index}}].fap_resume_project_service" value="{{project.fap_resume_project_service}}"></li>
							<li>개발기간<input type="text" name="resumeProjectList[{{$index}}].fap_resume_project_st" id="fap_resume_project_st_0" value="{{project.fap_resume_project_st}}">
							~<input type="text" name="resumeProjectList[{{$index}}].fap_resume_project_et" id="fap_resume_project_et_0" value="{{project.fap_resume_project_et}}"></li>
							<li>기간요약 <input type="number" name="resumeProjectList[{{$index}}].fap_resume_project_pd_summary" value="{{project.fap_resume_project_pd_summary}}"></li>
							<li>담당분야(본인)<input type="text" name="resumeProjectList[{{$index}}].fap_resume_project_responsibility" value="{{project.fap_resume_project_responsibility}}"></li>
							<li>사용기술(본인)<input type="text" name="resumeProjectList[{{$index}}].fap_resume_project_technique" value="{{project.fap_resume_project_technique}}"></li>
							<li>총참여인원<input type="number" name="resumeProjectList[{{$index}}].fap_resume_project_peoples_num" id="fap_resume_project_peoples_num" value="{{project.fap_resume_project_peoples_num}}">명</li>
						</ul>
					</div>
					<br>
					<!-- ------------------------------------자격(기술 및 외국어) ---------------------------------------------->
					<div>
					<header>자격(기술 및 외국어)</header>
					<ul class ="resumeLicense" ng-repeat="license in resumeApply.resumeLicenseList">
						<li>년<input type="text" name="resumeLicenseList[{{$index}}].fap_resume_license_get_year" value="{{license.fap_resume_license_get_year}}"></li>
						<li>월<input type="text" name="resumeLicenseList[{{$index}}].fap_resume_license_get_month" value="{{license.fap_resume_license_get_month}}"></li>
						<li>면허/자격
							<select name="resumeLicenseList[{{$index}}].fap_resume_license_nm" ng-model="license.fap_resume_license_nm" disabled>
								<option value="B2900">정보처리기사</option>
								<option value="B2901">정보처리산업기사</option>
								<option value="B2902">JLPT 1급</option>
								<option value="B2903">JLPT 2급</option>
								<option value="B2904">JPT</option>
								<option value="B2905">토익</option>
								<option value="B2906">기타</option>
								<option>직접 입력</option>
							</select>
						<li>점수<input type="number" name="resumeLicenseList[{{$index}}].fap_resume_license_score" id ="fap_resume_license_score" value="{{license.fap_resume_license_score}}">점</li>
						<li>발행기관<input type="text" name="resumeLicenseList[{{$index}}].fap_resume_license_issuing_organization" value="{{license.fap_resume_license_issuing_organization}}"></li>
						<li>비고<input type="text" name="resumeLicenseList[{{$index}}].fap_resume_license_note" value="{{license.fap_resume_license_note}}"></li>
					</ul>
					</div>
					<br>
					<!-- ------------------------------------역량 재능 ---------------------------------------------->
					<div>
						<header>역량 재능</header>
							<ul class="resumeTalent" ng-repeat="talent in resumeApply.resumeTalentList">
								<li><input type="text" value="No.1"></li>
								<li>내용<input type="text" name="resumeTalentList[{{$index}}].fap_resume_talent_content" value="{{talent.fap_resume_talent_content}}"></li>
							</ul>
					</div>	
					<!-- ------------------------------------자기소개서 ---------------------------------------------->
					<div>
						<header>자기소개서</header>
						<ul class="resumeProfile" ng-repeat="profile in resumeApply.resumeProfileList">
							<li>
								<input type="text" name="resumeProfileList[{{$index}}].fap_resume_pr_gb" value="{{profile.fap_resume_pr_gb}}">
							</li>
							<li><textarea name="resumeProfileList[{{$index}}].fap_resume_pr_content">{{profile.fap_resume_pr_content}}</textarea></li>
						</ul>	
					</div>
						<br>	
					<!-- ------------------------------------개인 동영상 및 포트폴리오 파일 ---------------------------------------------->
					<div>
						<header>개인 동영상 및 포트폴리오 파일</header>
						
						<ul class="resumeFile" ng-switch="!!resumeApply.resumeFileList[0].fap_resume_file_origin">
							<li ng-switch-when="true">
								<code value="B3700"></code>
								<input type="hidden" name="resumeFileList[0].fap_resume_file_origin" value="{{resumeApply.resumeFileList[0].fap_resume_file_origin}}">
								<input type="hidden" name="resumeFileList[0].fap_resume_file_saved" value="{{resumeApply.resumeFileList[0].fap_resume_file_saved}}">
								<input type="hidden" value="B3700" name="resumeFileList[0].fap_resume_file_gb"> 
								<a class="display-inline" ng-href="/file_download?origin={{resumeApply.resumeFileList[0].fap_resume_file_origin}}&saved={{resumeApply.resumeFileList[0].fap_resume_file_saved}}&path=/fap/user/resume_movie_file">
									{{resumeApply.resumeFileList[0].fap_resume_file_origin}}
								</a>
								<img class="x_icon" ng-click="resumeApply.resumeFileList[0].fap_resume_file_origin=false" src="<c:url value="/resources/segroup/society/fap/images/main/deletePic.png" />" alt="" />
							</li>
							
							<li ng-switch-default>
								<input type="hidden" value="{{resumeApply.resumeFileList[0].fap_resume_file_gb}}" name="resumeFileList[0].fap_resume_file_gb">
								<input type="file" name="resumeFileList[0].fap_resume_file" value="{{resumeApply.resumeFileList[0].fap_resume_file}} ">
								<input type="hidden" name="resumeFileList[0].fap_resume_file_saved" value="{{resumeApply.resumeFileList[0].fap_resume_file_saved}}">
							</li>
						</ul>
						
						<ul class="resumeFile" ng-switch="!!resumeApply.resumeFileList[1].fap_resume_file_origin">	
							<li ng-switch-when="true">
								<code value="B3701"></code>
								<input type="hidden" value="B3701" name="resumeFileList[1].fap_resume_file_gb">
								<input type="hidden" name="resumeFileList[1].fap_resume_file_origin" value="{{resumeApply.resumeFileList[1].fap_resume_file_origin}}">
								<input type="hidden" name="resumeFileList[1].fap_resume_file_saved" value="{{resumeApply.resumeFileList[1].fap_resume_file_saved}}">
								<a class="display-inline" ng-href="/file_download?origin={{resumeApply.resumeFileList[1].fap_resume_file_origin}}&saved={{resumeApply.resumeFileList[1].fap_resume_file_saved}}&path=/fap/user/resume_portfolio_file">
									{{resumeApply.resumeFileList[1].fap_resume_file_origin}}
								</a>
								<img class="x_icon" ng-click="resumeApply.resumeFileList[1].fap_resume_file_origin=false" src="<c:url value="/resources/segroup/society/fap/images/main/deletePic.png" />" alt="" />
							</li>
							<li ng-switch-default>
								<input type="hidden" value="{{resumeApply.resumeFileList[1].fap_resume_file_gb}}" name="resumeFileList[1].fap_resume_file_gb">
								<input type="file" value="파일선택" name="resumeFileList[1].fap_resume_file" value="{{resumeApply.resumeFileList[1].fap_resume_file}}">
								<input type="hidden" name="resumeFileList[1].fap_resume_file_saved" value="{{resumeApply.resumeFileList[1].fap_resume_file_saved}}">
							</li>
						</ul>
		
						
					</div>
				</form>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        </div>
      </div>
    </div>
  </div>  

</body>
</html>
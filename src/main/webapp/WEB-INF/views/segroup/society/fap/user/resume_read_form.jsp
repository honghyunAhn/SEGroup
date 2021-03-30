<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="<c:url value="/resources/segroup/js/jquery-3.1.1.js" />"></script>
<script src="<c:url value="/resources/segroup/js/jquery-ui.js" />"></script>
<script src="<c:url value="/resources/segroup/js/angular.min.js" />"></script>
<script src="<c:url value="/resources/segroup/js/datepicker.js" />"></script>
<script src="<c:url value="/resources/segroup/society/fap/js/lodash.js" />"></script>
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/segroup/society/fap/css/userDefault.css" />" />
<link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
<title>Bridge Job Fair</title>
<script type="text/javascript">
var resume_edu_length;
var resume_crr_length;
var resume_project_length;


	$(function() {
		realTimeValidation();
		_update = _.debounce(function(){
			$('#resume_form').submit(); 
		},500,true);
		
		cleanDatepicker();
		
		//이력서 사진 파일에 관한 함수
		$('#fap_resume_pic').change(function() {
			var val = $(this).val();
			
			if(val == "") {
				$(this).val('');
				$(".photo").empty();
				return;	
			} else if(fileImageCheck(val)) {
				photoAjax();
			} else {
				$(this).val('');
				$(".photo").empty();
				alert("이미지 파일이 아닙니다. gif, jpg, png 형식만 가능합니다.");
				return;
			}
		});
		
		
		//개인 동영상 파일 체크
		$("#resume_personal_video").change(function(){
			 var file = $(this).val();
			
			 if(file == ""){
				 $(this).val("");
				 return;
			 }
			 
			//확장자 체크
			if( extension_check_video(file) ) {
				
			} else {
				alert('<spring:message code="fap.err.video_type" javaScriptEscape="true" />');
				$(this).val("");
			} 
			
			//파일 사이즈 체크
			var size = 0;
			// 브라우저 확인
			var browser=navigator.appName;
			
			// 익스플로러일 경우
			if (browser=="Microsoft Internet Explorer") {
				var oas = new ActiveXObject("Scripting.FileSystemObject");
				fileSize = oas.getFile( file ).size;
			}
			// 익스플로러가 아닐경우
			else {
				size = $(this)[0].files[0].size;
			}
			
			//100MB
			if(file_size_check(size, 100)){
				//alert("size ok");
			}else{
				alert('<spring:message code="fap.err.video_size" javaScriptEscape="true" />');
				$(this).val("");
			}
		
		});
		
		//포트폴리오 파일 체크
		$("#resume_personal_pr").change(function(){
			var file = $(this).val();
			
			if(file == "") {
				$(this).val("");
				return;
			} 
			
			//확장자 체크
			if( extension_check_pdf(file) ) {
				
			} else {
				alert('<spring:message code="fap.err.pdf_type" javaScriptEscape="true" />');
				$(this).val("");
			} 
			
			//파일 사이즈 체크
			var size = 0;
			// 브라우저 확인
			var browser=navigator.appName;
			
			// 익스플로러일 경우
			if (browser=="Microsoft Internet Explorer") {
				var oas = new ActiveXObject("Scripting.FileSystemObject");
				fileSize = oas.getFile( file ).size;
			}
			// 익스플로러가 아닐경우
			else {
				size = $(this)[0].files[0].size;
			}
			
			//5MB
			if(file_size_check(size, 5)){
				//alert("size ok");
			}else{
				alert('<spring:message code="fap.err.pdf_size" javaScriptEscape="true" />');
				$(this).val("");
			}
			
		});
		
	});
	
	//innerHtml용 유효성체크
	function realTimeValidation(){
		$('input[type="text"]').change(function(){
		        this.value = $.trim(this.value);
		});
		//모든 textarea trim
		$('textarea').off('change').change(function(){
		        this.value = $.trim(this.value);
		});
		$("input[type='text']").off('keyup').keyup( function(){
			//모든 input text 글자수 제한
		    if ($(this).val().length >= $(this).attr('maxlength')) {
		        alert('<spring:message code="fap.err.over_maxlength" javaScriptEscape="true" />');
		        $(this).val($(this).val().substr(0, $(this).attr('maxlength')));
		    }
		});
		$("input[type='number']").off('keyup').keyup( function(){
			//모든 input text 글자수 제한
		    if ($(this).val().length >= $(this).attr('maxlength')) {
		        alert('<spring:message code="fap.err.over_maxlength" javaScriptEscape="true" />');
		        $(this).val($(this).val().substr(0, $(this).attr('maxlength')));
		    }
		});
		$('textarea').off('keyup').keyup( function() {
				if($(this).val().length >= $(this).attr('maxlength')) {
					alert('<spring:message code="fap.err.over_maxlength" javaScriptEscape="true" />');
					$(this).val($(this).val().substring(0, $(this).attr('maxlength')));
				}
		});
		$("input[type='text']").off('keyup').keyup( function(){
			//모든 input 태그 제한
			var disallow_char = /(<([^>]+)>)/ig;
			var tempValue = $(this).val();
		    if (disallow_char.test(tempValue)) {
		        alert('<spring:message code="fap.err.tag_insert" javaScriptEscape="true" />');
		        $(this).val(tempValue.replace(disallow_char,""));
		    }
		});
		$("textarea").off('keyup').keyup( function(){
			//모든 input 태그 제한
			var disallow_char = /(<([^>]+)>)/ig;
			var tempValue = $(this).val();
		    if (disallow_char.test(tempValue)) {
		        alert('<spring:message code="fap.err.tag_insert" javaScriptEscape="true" />');
		        $(this).val(tempValue.replace(disallow_char,""));
		    }
		});
	
	}
	
	//angular module 
	var myApp = angular.module('myapp', []);
	
	
	myApp.controller('ResumeController',['$scope','$compile','$timeout', function($scope, $compile,$timeout) {
						//이력서 전체 정보 hashmap
						var wholeResumeJson = '${wholeResumeJson}';
						
						var replaceJson = wholeResumeJson.replace(/(?:\r\n|\r|\n)/g, '\\r\\n');
						
						$scope.resumeApply = JSON.parse(replaceJson);
						
						resume_edu_length = $scope.resumeApply.resumeEduList.length;
						resume_crr_length = $scope.resumeApply.resumeCareerList.length;
						resume_project_length = $scope.resumeApply.resumeProjectList.length;
						
						$scope.file_change = function(file) {
							var val = $("#fap_resume_pic").val();

							if (val == "") {
								$("#fap_resume_pic").val('');
								$(".photo").empty();
								return;
							} else if (fileImageCheck(val)) {
								photoAjax();
							} else {
								$("#fap_resume_pic").val('');
								$(".photo").empty();
								alert("이미지 파일이 아닙니다. gif, jpg, png 형식만 가능 합니다.");
								return;
							}
						}
						
						$scope.addResumeEdu = function(){
							
							//교육 관련 
							var resumeEduClass = $(".resume_edu");
							var eduIndex = resumeEduClass.length;
							
							var eduStartId = "fap_resume_edu_er_dt_" + eduIndex;
							var eduEndId = "fap_resume_edu_gd_dt_" + eduIndex;
							
							var content = '<div class="sub3_bbs3 resume_edu">';
							content += '<ul class="tit2 title">';
							content += '<li class="wid1"><spring:message code="fap.resume.edu_entrance" /></li>';
							content += '<li class="wid2"><spring:message code="fap.resume.edu_graduation" /></li>';
							content += '<li class="wid3"><spring:message code="fap.resume.edu_period" /></li>';
							content += '<li class="wid4"><spring:message code="fap.resume.edu_graduated_or_not" /></li>';
							content += '</ul>';
							content += '<ul class="tit2">';
							content += '<li class="wid1">';
							content += '<input type="text" class="input1 fap_resume_edu_er_dt" name="resumeEduList['+eduIndex+'].fap_resume_edu_er_dt" id="'+eduStartId+'">';
							content += '</li>';
							content += '<li class="wid2">';
							content += '<input type="text" class="input1 fap_resume_edu_gd_dt" name="resumeEduList['+eduIndex+'].fap_resume_edu_gd_dt" id="'+eduEndId+'">';
							content += '</li>';
							content += '<li class="wid3">';
							content += '<input type="text" class="input1 fap_resume_edu_pd_summary" name="resumeEduList['+eduIndex+'].fap_resume_edu_pd_summary" maxlength="10" placeholder="10<spring:message code="fap.placeholder.limit_characters" />">';
							content += '</li>';
							content += '<li class="wid4">';
							content += '<div class="resume-dropdown">';
							content += '<div class="resume-select">';
							content += '<button type="button" class="resume-select-btn"><code value="B1000"></code></button>';
							content += '<input type="hidden" id="resume-gd-gb" name="resumeEduList['+eduIndex+'].fap_resume_edu_gd_ck" value="B1000">';
							content += '</div>';
							content += '<div class="resume-select-option">';
							content += '<ul class="option-list">';
							content += '<li class="resume-gd selected">';
							content += '<button type="button" resume-gd="B1000"><code value="B1000"></code></button>';
							content += '</li>';
							content += '<li class="resume-gd">';
							content += '<button type="button" resume-gd="B1001"><code value="B1001"></code></button>';
							content += '</li>';
							content += '<li class="resume-gd">';
							content += '<button type="button" resume-gd="B1002"><code value="B1002"></code></button>';
							content += '</li>';
							content += '</ul>';
							content += '</div>';
							content += '</div>';
							content += '</li>';
							content += '</ul>';
							content += '<ul class="tit3">';
							content += '<li class="wid1"><spring:message code="fap.resume.edu_school_nm" /></li>';
							content += '<li class="wid2">';
							content += '<input type="text" class="input2 fap_resume_edu_sc_nm" name="resumeEduList['+eduIndex+'].fap_resume_edu_sc_nm" maxlength="50" placeholder="50<spring:message code="fap.placeholder.limit_characters" />">';
							content += '</li>';
							content += '</ul>';
							content += '<ul class="tit3">';
							content += '<li class="wid1"><spring:message code="fap.resume.edu_curriculum" /></li>';
							content += '<li class="wid2">';
							content += '<input type="text" class="input2" name="resumeEduList['+eduIndex+'].fap_resume_edu_coll" maxlength="50" placeholder="50<spring:message code="fap.placeholder.limit_characters" />">';
							content += '</li>';
							content += '</ul>';
							content += '<ul class="tit3">';
							content += '<li class="wid1"><spring:message code="fap.resume.edu_major_field" /></li>';
							content += '<li class="wid2">';
							content += '<div class="resume-dropdown">';
							content += '<div class="resume-select">';
							content += '<button type="button" class="resume-select-btn"><code value="B2800"></code></button>';
							content += '<input type="hidden" id="resume-field-gb" name="resumeEduList['+eduIndex+'].fap_resume_edu_field" value="B2800">';
							content += '</div>';
							content += '<div class="resume-select-option">';
							content += '<ul class="option-list">';
							content += '<li class="resume-field selected">';
							content += '<button type="button" resume-field="B2800"><code value="B2800"></code></button>';
							content += '</li>';
							content += '<li class="resume-field">';
							content += '<button type="button" resume-field="B2801"><code value="B2801"></code></button>';
							content += '</li>';
							content += '<li class="resume-field">';
							content += '<button type="button" resume-field="B2802"><code value="B2802"></code></button>';
							content += '</li>';
							content += '<li class="resume-field">';
							content += '<button type="button" resume-field="B2803"><code value="B2803"></code></button>';
							content += '</li>';
							content += '<li class="resume-field">';
							content += '<button type="button" resume-field="B2804"><code value="B2804"></code></button>';
							content += '</li>';
							content += '<li class="resume-field">';
							content += '<button type="button" resume-field="B2805"><code value="B2805"></code></button>';
							content += '</li>';
							content += '<li class="resume-field">';
							content += '<button type="button" resume-field="B2806"><code value="B2806"></code></button>';
							content += '</li>';
							content += '<li class="resume-field">';
							content += '<button type="button" resume-field="B2807"><code value="B2807"></code></button>';
							content += '</li>';
							content += '</ul>';
							content += '</div>';
							content += '</div>';
							content += '</li>';
							content += '</ul>';
							content += '<ul class="tit3">';
							content += '<li class="wid1"><spring:message code="fap.resume.edu_major_nm" /></li>';
							content += '<li class="wid2">';
							content += '<input type="text" class="input2" name="resumeEduList['+eduIndex+'].fap_resume_edu_major" maxlength="50" placeholder="50<spring:message code="fap.placeholder.limit_characters" />">';
							content += '</li>';
							content += '</ul>';
							content += '<ul class="tit3">';
							content += '<li class="wid1"><spring:message code="fap.resume.edu_remarks" /></li>';
							content += '<li class="wid2">';
							content += '<textarea rows="4" cols="20" name="resumeEduList['+eduIndex+'].fap_resume_edu_note" maxlength="150" placeholder="150<spring:message code="fap.placeholder.limit_characters" />"></textarea>';
							content += '</li>';
							content += '</ul>';
							content += '</div>';
							
							$(".resume_edu_wrap").append($compile(content)($scope));	
							minMax(eduStartId, eduEndId);
							realTimeValidation();
							resume_gd_event();
							resume_field_event();
						}
						
						$scope.removeResumeEdu = function(){
							var eduIndex = $(".resume_edu").length;
							if(eduIndex > 0) {
								$(".resume_edu:last").remove();
							}
						}
						
						//사회경력
						$scope.addResumeCareer = function(){
							var resumeCareerClass = $(".resume_crr");	
							var careerIndex = resumeCareerClass.length;
							var careerStartId = "fap_resume_crr_st_" + careerIndex;
							var careerEndId = "fap_resume_crr_et_" + careerIndex;
						
							var content = '<div class="sub3_bbs3 resume_crr">';
							content += '<ul class="tit2 title">';
							content += '<li class="wid1"><spring:message code="fap.resume.career_service_start_day" /></li>';
							content += '<li class="wid2"><spring:message code="fap.resume.career_service_completion_day" /></li>';
							content += '<li class="wid3"><spring:message code="fap.resume.edu_period" /></li>';
							content += '<li class="wid4"><spring:message code="fap.resume.career_position" /></li>';
							content += '</ul>';
							content += '<ul class="tit2">';
							content += '<li class="wid1">';
							content += '<input type="text" class="input1 fap_resume_crr_st" name="resumeCareerList['+careerIndex+'].fap_resume_crr_st" id="'+ careerStartId +'">';
							content += '</li>';
							content += '<li class="wid2">';
							content += '<input type="text" class="input1 fap_resume_crr_et" name="resumeCareerList['+careerIndex+'].fap_resume_crr_et" id="'+careerEndId+'">';
							content += '</li>';
							content += '<li class="wid3">';
							content += '<input type="text" class="input1 fap_resume_crr_pd_summary" name="resumeCareerList['+careerIndex+'].fap_resume_crr_pd_summary" id ="fap_resume_crr_pd_summary'+careerIndex+'"  maxlength="10" placeholder="10<spring:message code="fap.placeholder.limit_characters" />">';
							content += '</li>';
							content += '<li class="wid4">';
							content += '<input type="text" class="input1 fap_resume_crr_job_position" name="resumeCareerList['+careerIndex+'].fap_resume_crr_job_position" maxlength="10" placeholder="10<spring:message code="fap.placeholder.limit_characters" />">';
							content += '</li>';
							content += '</ul>';
							content += '<ul class="tit3">';
							content += '<li class="wid1"><spring:message code="fap.resume.career_comp_nm" /></li>';
							content += '<li class="wid2">';
							content += '<input type="text" class="input2 fap_resume_crr_comp_nm" name="resumeCareerList['+careerIndex+'].fap_resume_crr_comp_nm" maxlength="50" placeholder="50<spring:message code="fap.placeholder.limit_characters" />">';
							content += '</li>';
							content += '</ul>';
							content += '<ul class="tit3">';
							content += '<li class="wid1"><spring:message code="fap.resume.career_comp_major_business" /></li>';
							content += '<li class="wid2">';
							content += '<input type="text" class="input2 fap_resume_crr_major_bussiness" name="resumeCareerList['+careerIndex+'].fap_resume_crr_major_bussiness" maxlength="50" placeholder="50<spring:message code="fap.placeholder.limit_characters" />">';
							content += '</li>';
							content += '</ul>';
							content += '<ul class="tit3">';
							content += '<li class="wid1"><spring:message code="fap.resume.career_field" /></li>';
							content += '<li class="wid2">';
							content += '<div class="resume-dropdown">';
							content += '<div class="resume-select">';
							content += '<button type="button" class="resume-select-btn"><code value="B3900"></code></button>';
							content += '<input type="hidden" id="resume-crr-gb" name="resumeCareerList['+careerIndex+'].fap_resume_crr_gb" value="B3900">';
							content += '</div>';
							content += '<div class="resume-select-option">';
							content += '<ul class="option-list">';
							content += '<li class="resume-crr selected">';
							content += '<button type="button" resume-crr="B3900"><code value="B3900"></code></button>';
							content += '</li>';
							content += '<li class="resume-crr">';
							content += '<button type="button" resume-crr="B3901"><code value="B3901"></code></button>';
							content += '</li>';
							content += '<li class="resume-crr">';
							content += '<button type="button" resume-crr="B3902"><code value="B3902"></code></button>';
							content += '</li>';
							content += '</ul>';
							content += '</div>';
							content += '</div>';
							content += '</li>';
							content += '</ul>';
							content += '<ul class="tit3">';
							content += '<li class="wid1"><spring:message code="fap.resume.career_responsibility" /></li>';
							content += '<li class="wid2">';
							content += '<textarea rows="4" cols="20" class="fap_resume_crr_job_function" name="resumeCareerList['+careerIndex+'].fap_resume_crr_job_function" maxlength="150" placeholder="150<spring:message code="fap.placeholder.limit_characters" />"></textarea>';
							content += '</li>';
							content += '</ul>';
							content += '</div>';
							
							$(".resume_crr_wrap").append($compile(content)($scope));				
							minMax(careerStartId, careerEndId);			
							realTimeValidation();
							resume_crr_event();
							
						}
						$scope.removeResumeCareer = function(){
							var careerIndex = $(".resume_crr").length;
							console.log(careerIndex);
							if(careerIndex > 0) {
								$(".resume_crr:last").remove();
							}
						}
						//프로젝트
						$scope.addProject = function(){
							var resumeProjectClass = $(".resume_project");
							var projectIndex = resumeProjectClass.length;
							var projectStartId = "fap_resume_project_st_" + projectIndex ;
							var projectEndId = "fap_resume_project_et_" + projectIndex;
							
							var content = '<div class="sub3_bbs3 resume_project">';
							content += '<ul class="tit2 title">';
							content += '<li class="wid1"><spring:message code="fap.resume.project_development_start_date" /></li>';
							content += '<li class="wid2"><spring:message code="fap.resume.project_development_end_date" /></li>';
							content += '<li class="wid3"><spring:message code="fap.resume.edu_period" /></li>';
							content += '<li class="wid4"><spring:message code="fap.resume.project_development_member" /></li>';
							content += '</ul>';
							content += '<ul class="tit2">';
							content += '<li class="wid1">';
							content += '<input type="text" class="input1 fap_resume_project_st" name="resumeProjectList['+projectIndex+'].fap_resume_project_st" id="'+ projectStartId +'">';
							content += '</li>';
							content += '<li class="wid2">';
							content += '<input type="text" class="input1 fap_resume_project_et" name="resumeProjectList['+projectIndex+'].fap_resume_project_et" id="'+ projectEndId +'">';
							content += '</li>';
							content += '<li class="wid3">';
							content += '<input type="text" class="input1 fap_resume_project_pd_summary" name="resumeProjectList['+projectIndex+'].fap_resume_project_pd_summary" id ="fap_resume_project_pd_summary'+projectIndex+'"  maxlength="10" placeholder="10<spring:message code="fap.placeholder.limit_characters" />">';
							content += '</li>';
							content += '<li class="wid4">';
							content += '<input type="number" class="input1 fap_resume_project_peoples_num" name="resumeProjectList['+projectIndex+'].fap_resume_project_peoples_num" id="fap_resume_project_peoples_num'+projectIndex+'"  maxlength="10" placeholder="10<spring:message code="fap.placeholder.limit_characters" />">';
							content += '<span class="hiddenTx"><spring:message code="com.placeholder.people" /></span>';
							content += '</li>';
							content += '</ul>';
							content += '<ul class="tit3">';
							content += '<li class="wid1"><spring:message code="fap.resume.project_nm" /></li>';
							content += '<li class="wid2">';
							content += '<input type="text" class="input2 fap_resume_project_nm" name="resumeProjectList['+projectIndex+'].fap_resume_project_nm" maxlength="50" placeholder="50<spring:message code="fap.placeholder.limit_characters" />">';
							content += '</li>';
							content += '</ul>';
							content += '<ul class="tit3">';
							content += '<li class="wid1"><spring:message code="fap.resume.project_main_service" /></li>';
							content += '<li class="wid2">';
							content += '<textarea rows="4" cols="20" class="fap_resume_project_service" name="resumeProjectList['+projectIndex+'].fap_resume_project_service" maxlength="150" placeholder="150<spring:message code="fap.placeholder.limit_characters" />"></textarea>';
							content += '</li>';
							content += '</ul>';
							content += '<ul class="tit3">';
							content += '<li class="wid1"><spring:message code="fap.resume.project_charge_filed" /></li>';
							content += '<li class="wid2">';
							content += '<textarea rows="4" cols="20" class="fap_resume_project_responsibility" name="resumeProjectList['+projectIndex+'].fap_resume_project_responsibility" maxlength="150" placeholder="150<spring:message code="fap.placeholder.limit_characters" />"></textarea>';
							content += '</li>';
							content += '</ul>';
							content += '<ul class="tit3">';
							content += '<li class="wid1"><spring:message code="fap.resume.project_used_technique" /></li>';
							content += '<li class="wid2">';
							content += '<textarea rows="4" cols="20" class="fap_resume_project_technique" name="resumeProjectList['+projectIndex+'].fap_resume_project_technique" maxlength="150" placeholder="150<spring:message code="fap.placeholder.limit_characters" />"></textarea>';
							content += '</li>';
							content += '</ul>';
							content += '</div>';
							
							$(".resume_project_wrap").append(content);
							minMax(projectStartId, projectEndId);
							realTimeValidation();
						}
						$scope.removeProject = function(){
							var projectIndex = $(".resume_project").length;
							if(projectIndex > 0) {
								$(".resume_project:last").remove();
							}
						}
						//자격증
						$scope.addLicense = function() {
							var resumeLicenseClass = $(".resume_license");
							var licenseIndex = resumeLicenseClass.length;
							
							var content = '<div class="sub3_bbs3 resume_license">';
							content +='<ul class="tit2 title">';
							content +='<li class="wid1"><spring:message code="fap.resume.certification_license" /></li>';
							content +='<li class="wid2"><spring:message code="fap.resume.certification_obtained_year" /></li>';
							content +='<li class="wid3"><spring:message code="fap.resume.certification_obtained_month" /></li>';
							content +='<li class="wid4"><spring:message code="fap.resume.certification_issuing_organization" /></li>';
							content +='</ul>';
							content +='<ul class="tit2">';
							content +='<li class="wid1">';
							content +='<div class="resume-dropdown">';
							content +='<div class="resume-select">';
							content +='<button type="button" class="resume-select-btn"><code value="B2900"></code></button>';
							content +='<input type="hidden" id="resume-license-gb" name="resumeLicenseList['+licenseIndex+'].fap_resume_license_nm" value="B2900">';
							content +='</div>';
							content +='<div class="resume-select-option">';
							content +='<ul class="option-list">';
							content +='<li class="resume-license selected">';
							content +='<button type="button" resume-license="B2900"><code value="B2900"></code></button>';
							content +='</li>';
							content +='<li class="resume-license">';
							content +='<button type="button" resume-license="B2901"><code value="B2901"></code></button>';
							content +='</li>';
							content +='<li class="resume-license">';
							content +='<button type="button" resume-license="B2902"><code value="B2902"></code></button>';
							content +='</li>';
							content +='<li class="resume-license">';
							content +='<button type="button" resume-license="B2903"><code value="B2903"></code></button>';
							content +='</li>';
							content +='<li class="resume-license">';
							content +='<button type="button" resume-license="B2904"><code value="B2904"></code></button>';
							content +='</li>';
							content +='<li class="resume-license">';
							content +='<button type="button" resume-license="B2905"><code value="B2905"></code></button>';
							content +='</li>';
							content +='<li class="resume-license">';
							content +='<button type="button" resume-license="B2906"><code value="B2906"></code></button>';
							content +='</li>';
							content +='</ul>';
							content +='</div>';
							content +='</div>';
							content +='</li>';
							content +='<li class="wid2">';
							content +='<input type="text" class="input1 fap_resume_license_get_year" name="resumeLicenseList['+licenseIndex+'].fap_resume_license_get_year" maxlength="4" placeholder="<spring:message code="com.placeholder.yyyy" />">';
							content +='</li>';
							content +='<li class="wid3">';
							content +='<input type="text" class="input1 fap_resume_license_get_month" name="resumeLicenseList['+licenseIndex+'].fap_resume_license_get_month" maxlength="2" placeholder="<spring:message code="com.placeholder.mm" />">';
							content +='</li>';
							content +='<li class="wid4">';
							content +='<input type="text" class="input1 fap_resume_license_issuing_organization" name="resumeLicenseList['+licenseIndex+'].fap_resume_license_issuing_organization" maxlength="15" placeholder="15<spring:message code="fap.placeholder.limit_characters" />">';
							content +='</li>';
							content +='</ul>';
							content +='<ul class="tit3">';
							content +='<li class="wid1"><spring:message code="fap.resume.certification_score" /></li>';
							content +='<li class="wid2">';
							content +='<input type="number" class="input2" name="resumeLicenseList['+licenseIndex+'].fap_resume_license_score" maxlength="10" placeholder="10<spring:message code="fap.placeholder.limit_characters" />">';
							content +='</li>';
							content +='</ul>';
							content +='<ul class="tit3">';
							content +='<li class="wid1"><spring:message code="fap.resume.certification_remarks" /></li>';
							content +='<li class="wid2">';
							content +='<textarea rows="4" cols="20" name="resumeLicenseList['+licenseIndex+'].fap_resume_license_note" maxlength="150" placeholder="150<spring:message code="fap.placeholder.limit_characters" />"></textarea>';
							content +='</li>';
							content +='</ul>';
							content +='</div>';
							
							$(".resume_license_wrap").append($compile(content)($scope));
							realTimeValidation();
							resume_license_event();
							
						}
						$scope.removeLicense = function() {
							var licenseIndex = $(".resume_license").length;
							
							if(licenseIndex > 0) {
								$(".resume_license:last").remove();
							}
						}
						//역량+재능
						$scope.addTalent = function() {
							var resumeTalentClass = $(".resume_talent");
							var talentIndex = resumeTalentClass.length;
							
							var talentNumber = talentIndex;
							
							var content = '';
							content += '<div class="sub3_bbs7 resume_talent">';
							content += '<ul class="tit2">';
							content += '<li class="wid1"><spring:message code="fap.resume.talent_number" /></li>';
							content += '<li class="wid2"><spring:message code="fap.resume.talent_context" /></li>';
							content += '</ul>';
							content += '<ul class="tit3">';
							content += '<li class="wid1">'+(talentNumber+1)+'</li>';
							content += '<li class="wid2">';
							content += '<textarea rows="4" cols="20" class="fap_resume_talent_content" name="resumeTalentList['+talentNumber+'].fap_resume_talent_content" maxlength="200" placeholder="<spring:message code="fap.resume.talent_context_ex" /> (200<spring:message code="fap.placeholder.limit_characters" />)"></textarea>';
							content += '</li>';
							content += '</ul>';
							content += '</div>';
							
							$(".resume_talent_wrap").append($compile(content)($scope));
							realTimeValidation();
						}
						$scope.removeTalent = function() {
							var resumeTalentClass = $(".resume_talent");
							var talentIndex = resumeTalentClass.length;
							
							if(talentIndex > 0) {
								$(".resume_talent:last").remove();
							}
						}
						
						$timeout(function() {
							
							$.each($(".resume-select-btn"), function(index, item){
								var cd = $(this).attr("cd");
								var context = '<code value="'+cd+'"></code>';
								$(this).html(context);
							})

							$compile(".resume-select-btn")($scope);
						
						}, 0);
						
					}
				]);
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
	} ]);
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
	} ]);
	
	myApp.directive('blurCurrency',['$filter',  function($filter) {
		return {
			require : 'ngModel',
			scope: true,
			link : function($scope, $el, $attr, $ngModelCtrl){
			 function formatter(value){
					value = value ? parseFloat(value.toString().replace(/[^0-9._-]/g, '')) || 0 : 0;
					var formattedValue = $filter('currency')(value,"",0);
					
					$ngModelCtrl.$setViewValue(value);
					$ngModelCtrl.$render();
					
					$el.val(formattedValue);
					
					return formattedValue;
				}
				
				$ngModelCtrl.$formatters.push(formatter);
				
				$el.bind('focus', function(){
					//$el.val('');
				});
				
				$el.bind('blur', function(){
					formatter($el.val());
				});
			}
		}
	}])

	//datepicker
	function cleanDatepicker() {

		var original_gotoToday = $.datepicker._gotoToday;

		$.datepicker._gotoToday = function(id) {
			var target = $(id), inst = this._getInst(target[0]);

			original_gotoToday.call(this, id);
			this._selectDate(id, this._formatDate(inst, inst.selectedDay, inst.drawMonth, inst.drawYear));
			target.blur();
		}

		var old_fn = $.datepicker._updateDatepicker;

		$.datepicker._updateDatepicker = function(inst) {
			old_fn.call(this, inst);

			var buttonPane = $(this).datepicker("widget").find(".ui-datepicker-buttonpane");

			$("<button type='button' class='ui-datepicker-clean ui-state-default ui-priority-primary ui-corner-all'>clear</button>").appendTo(buttonPane).click(function(ev) {
				$.datepicker._clearDate(inst.input);
			});
		}
	}
	
	//목록으로
	function readList(){
		location.href = "/fap/user/resume_management";
	}
	
		
		
	//이력서에 이미지 파일 ajax로 넘겨주기 
	function photoAjax() {
		
		var size = $("#fap_resume_pic")[0].files[0].size;
		if(file_size_check(size,5)) {
			var formData = new FormData();
			formData.append("file", $("#fap_resume_pic")[0].files[0]);
			
			$.ajax({
				type : "POST",
				url : "/temporarily_upload",
				data : formData,
				processData : false,
				contentType : false,
				dataType: "json",
				success : function(data) {
					$(".photo").empty();
					$(".photo").html('<img alt="" src="/edu/temporarilyPath/'+data.savedfile+'">');
				},
				error : function(e) {
					console.log(e);
				}
			});
		} else {
			$("#fap_resume_pic").val('');
			$(".photo").empty();
			alert("파일 사이즈는 5MB까지 입니다.");
		}
	}
	
	//사이즈 체크 함수
	function file_size_check (size, max_size) {
		
		max_size = max_size * 1024 * 1024;	//MB를 byte로 변경
		
		if (size > max_size){
			return false;
		}
		
		return true;
	}
	
	//pdf
	function extension_check_pdf (file_name){
		var extension = file_name.substring(file_name.lastIndexOf('.') + 1).toLowerCase();
		
		switch (extension) {
		case "pdf":
		case "zip":
			return true;
		default:
			return false;
		}
	}
	
	//동영상
	function extension_check_video (file_name){
		var extension = file_name.substring(file_name.lastIndexOf('.') + 1).toLowerCase();
		
		switch (extension) {
		case "mp4":
		case "wmv":
		case "mpg":
		case "mpeg":
		case "avi":
			return true;
		default:
			return false;
		}
	}
	
	//이력서 이미지 파일 체크
	function fileImageCheck(name) {
		switch(name.substring(name.lastIndexOf('.') +1).toLowerCase()) {
		case 'gif':
		case 'jpg':
		case 'png':
		case 'jpeg': 
			return true;
		default:
			return false;
		}
	}
	
</script>
</head>
	<body ng-app="myapp" ng-controller="ResumeController">
	<sec:authorize access="hasAnyRole('ROLE_A0100', 'ROLE_A0101', 'ROLE_A0102', 'ROLE_A0106', 'ROLE_A0108')">
		<sec:authentication property="details.user" var="detail" />
		</sec:authorize>
		<%@include file="user_menu.jsp"%><%@include file="user_quick_menu.jsp"%>
		<div class="resume_wrap">
		<div id="subcontents">
		
			
			<input type="hidden" name="fap_resume_seq" value="{{resumeApply.fap_resume_seq}}">
			<input type="hidden" name="fap_resume_ins_id" value="${detail.user_id}">
			<input type="hidden" name="fap_resume_ins_dt" value="{{resumeApply.fap_resume_ins_dt}}">
			<input type="hidden" name="fap_resume_udt_id" value="${detail.user_id}">
			<input type="hidden" name="fap_resume_udt_dt" value="{{resumeApply.fap_resume_udt_dt}}">
			
			<div class="userjoinBox">
				<div id="sub3Box">
					<h2>이력서 확인</h2>
				</div>
				<div id="sub3_bbs2">
					<ul class="tit">
						<li class="wid1"><spring:message code="fap.resume.title" /></li>
						<li class="wid2">
							<input type="text" class="input" name="fap_resume_title" id="fap_resume_title" ng-model="resumeApply.fap_resume_title" maxlength="40" placeholder="40<spring:message code="fap.placeholder.limit_characters" />" readonly="readonly">
						</li>
					</ul>					
				</div>			
			</div> <!-- <div id="userjoinBox"> -->
			<div class="userjoinBox">
				<div id="sub3_bbs2" class="basic_top">
					<h2><spring:message code="fap.resume.user_info" /></h2>
					<ul class="tit1">
						
						<ul ng-switch="!!resumeApply.fap_resume_pic_origin">
							<ul ng-switch-when="true">
								<li class="photo">
									<img alt="" ng-src="/fap/user/resume_photo_image/{{resumeApply.fap_resume_pic_saved}}">
								</li>
								<input type="hidden" name="fap_resume_pic_origin" value="{{resumeApply.fap_resume_pic_origin}}">
								<input type="hidden" name="fap_resume_pic_saved" value="{{resumeApply.fap_resume_pic_saved}}"> 
								<li>
									<a class="display-inline" ng-href="/file_download?origin={{resumeApply.fap_resume_pic_origin}}&saved={{resumeApply.fap_resume_pic_saved}}&path=/fap/user/resume_photo_image">
										Download
									</a>
								</li>
							</ul>
							<ul ng-switch-default>
								<li class="photo"></li>
								<input type="hidden" name="fap_resume_pic_saved" ng-model="resumeApply.fap_resume_pic_saved">
								<li class="photo_file">
								</li>
							</ul>
						</ul>
					
					</ul>
					<ul class="tit2 first">
						<li class="wid1"><code value="B3100"></code></li>
						<li class="wid2">
							<input type="hidden" name="resumeNameList[0].fap_resume_lang_gb" value="B3100">
							<input type="text" class="input1" name="resumeNameList[0].fap_resume_nm" id="fap_resume_nm" value="${detail.user_nm}" readonly>
						</li>
						<li class="wid3"><spring:message code="fap.resume.user_nationality" /></li>
						<li class="wid4">
							<input type="text" class="input1" name="fap_resume_nationality" ng-model="resumeApply.fap_resume_nationality" maxlength="10" placeholder="10<spring:message code="fap.placeholder.limit_characters" />" readonly>
						</li>
					</ul>
					<ul class="tit2">
						<li class="wid1"><code value="B3102"></code></li>
						<li class="wid2">
							<input type="hidden" name="resumeNameList[2].fap_resume_lang_gb" value="B3102">
							<input type="text" class="input1" name="resumeNameList[2].fap_resume_nm" id="fap_resume_nm_ja" ng-model="resumeApply.resumeNameList[2].fap_resume_nm" maxlength="10" placeholder="10<spring:message code="fap.placeholder.limit_characters" />" readonly>
						</li>
						<li class="wid3"><code value="B3103"></code></li>
						<li class="wid4">
							<input type="hidden" name="resumeNameList[3].fap_resume_lang_gb" value="B3103">
							<input type="text" class="input1" name="resumeNameList[3].fap_resume_nm" id="fap_resume_nm_yomi" ng-model="resumeApply.resumeNameList[3].fap_resume_nm" maxlength="10" placeholder="10<spring:message code="fap.placeholder.limit_characters" />" readonly>
						</li>						
					</ul>
					<ul class="tit2">
						<li class="wid1"><code value="B3101"></code></li>
						<li class="wid2">
							<input type="hidden" name="resumeNameList[1].fap_resume_lang_gb" value="B3101">
							<input type="text" class="input1" name="resumeNameList[1].fap_resume_nm" id="fap_resume_nm_eng"  ng-model="resumeApply.resumeNameList[1].fap_resume_nm" maxlength="20" placeholder="20<spring:message code="fap.placeholder.limit_characters" />" readonly>
						</li>
						<li class="wid3"><spring:message code="fap.resume.user_dependent" /></li>
						<li class="wid4">
							<input type="text" class="input1" name="fap_resume_dependents" ng-model="resumeApply.fap_resume_dependents" readonly>
							<span class="hiddenTx"><spring:message code="com.placeholder.people" /></span>
						</li>						
					</ul>
				</div>
				<div id="sub3_bbs2">
					<ul class="tit3">
						<li class="wid1"><spring:message code="fap.resume.user_birth" /></li>
						<c:set var="birth" value="${detail.user_birth}" />
						<li class="wid2_birth">
							<input type="text" class="input" name="fap_resume_birth" value="${fn:substring(birth,0,4) }" readonly>
							<span class="hiddenTx"><spring:message code="com.placeholder.year" /></span>
						</li>
						<li class="wid2_birth">
							<input type="text" class="input" name="fap_resume_birth" value="${fn:substring(birth,5,7) }" readonly>
							<span class="hiddenTx"><spring:message code="com.placeholder.month" /></span>
						</li>
						<li class="wid2_birth"> 
							<input type="text" class="input" name="fap_resume_birth" value="${fn:substring(birth,8,10) }"readonly>
							<span class="hiddenTx"><spring:message code="com.placeholder.day" /></span>
						</li>
					</ul>
					<ul class="tit3">
						<li class="wid1"><spring:message code="fap.resume.user_address" /></li>
						<li class="wid2 resumeAddr" ng-repeat="addr in resumeApply.resumeAddrList">
							<input type="text" class="input1" name="resumeAddrList[{{$index}}].fap_resume_address" ng-model="addr.fap_resume_address" maxlength="100" placeholder="100<spring:message code="fap.placeholder.limit_characters" />" readonly>
						</li>
					</ul>
					<ul class="tit3">
						<li class="wid1"><spring:message code="fap.resume.user_gender" /></li>
						<li class="wid2">
							<input type="hidden" name="fap_resume_gender" value="${detail.user_sex}">
							<code value="${detail.user_sex}"></code>																					
						</li>
					</ul>
					<ul class="tit3">
						<li class="wid1"><spring:message code="fap.resume.user_married_or_not" /></li>
						<li class="wid2">
							<span class="marital_radio" ng-class="{'ck' : resumeApply.fap_resume_marital=='B3001'}">
								<label class="marital_label">
									<code value="B3001"></code>
								</label>
								<input type="radio" id="radio3" name="fap_resume_marital" value="B3001" ng-model="resumeApply.fap_resume_marital">
							</span>
							<span class="marital_radio" ng-class="{'ck' : resumeApply.fap_resume_marital=='B3000'}">
								<label class="marital_label">
									<code value="B3000"></code>
								</label>													
								<input type="radio" id="radio4" name="fap_resume_marital" value="B3000" ng-model="resumeApply.fap_resume_marital">	
							</span>
						</li>
					</ul>
				</div><!-- <div id="sub3_bbs2"> -->
			</div> <!-- <div id="userjoinBox"> -->		

			<!-- ------------------------------------기본정보---------------------------------------------->
			<div class="userjoinBox">
				<h2><spring:message code="fap.resume.edu_history" /></h2>
				<div class="resume_edu_wrap">
					<div class="sub3_bbs3 resume_edu" ng-repeat="eduHistory in resumeApply.resumeEduList">
						<ul class="tit2 title">
							<li class="wid1"><spring:message code="fap.resume.edu_entrance" /></li>
							<li class="wid2"><spring:message code="fap.resume.edu_graduation" /></li>
							<li class="wid3"><spring:message code="fap.resume.edu_period" /></li>
							<li class="wid4"><spring:message code="fap.resume.edu_graduated_or_not" /></li>
						</ul>
						<ul class="tit2">
							<li class="wid1">
								<input type="text" class="input1 fap_resume_edu_er_dt" name="resumeEduList[{{$index}}].fap_resume_edu_er_dt" id="fap_resume_edu_er_dt_{{$index}}" ng-model="eduHistory.fap_resume_edu_er_dt" readonly>
							</li>
							<li class="wid2">
								<input type="text" class="input1 fap_resume_edu_gd_dt" name="resumeEduList[{{$index}}].fap_resume_edu_gd_dt" id="fap_resume_edu_gd_dt_{{$index}}" ng-model="eduHistory.fap_resume_edu_gd_dt" readonly>
							</li>
							<li class="wid3">
								<input type="text" class="input1 fap_resume_edu_pd_summary" name="resumeEduList[{{$index}}].fap_resume_edu_pd_summary" ng-model="eduHistory.fap_resume_edu_pd_summary" maxlength="10" placeholder="10<spring:message code="fap.placeholder.limit_characters" />" readonly>
							</li>
							<li class="wid4">
								<div class="resume-dropdown">
									<div class="resume-select">
										<button type="button" class="resume-select-btn" cd="{{eduHistory.fap_resume_edu_gd_ck}}"></button>
										<input type="hidden" id="resume-gd-gb" name="resumeEduList[{{$index}}].fap_resume_edu_gd_ck" value="{{eduHistory.fap_resume_edu_gd_ck}}">
									</div>
									<div class="resume-select-option">
										<ul class="option-list">
											<li class="resume-gd"  ng-class="{'selected' : eduHistory.fap_resume_edu_gd_ck=='B1000'}">
												<button type="button" resume-gd="B1000"><code value="B1000"></code></button>
											</li>
											<li class="resume-gd"  ng-class="{'selected' : eduHistory.fap_resume_edu_gd_ck=='B1001'}">
												<button type="button" resume-gd="B1001"><code value="B1001"></code></button>
											</li>
											<li class="resume-gd"  ng-class="{'selected' : eduHistory.fap_resume_edu_gd_ck=='B1002'}">
												<button type="button" resume-gd="B1002"><code value="B1002"></code></button>
											</li>
										</ul>
									</div>
								</div>
							</li>
						</ul>
						<ul class="tit3">
							<li class="wid1"><spring:message code="fap.resume.edu_school_nm" /></li>
							<li class="wid2">
								<input type="text" class="input2 fap_resume_edu_sc_nm" name="resumeEduList[0].fap_resume_edu_sc_nm" ng-model="eduHistory.fap_resume_edu_sc_nm" maxlength="50" placeholder="50<spring:message code="fap.placeholder.limit_characters" />" readonly>
							</li>
						</ul>
						<ul class="tit3">
							<li class="wid1"><spring:message code="fap.resume.edu_curriculum" /></li>
							<li class="wid2">
								<input type="text" class="input2" name="resumeEduList[{{$index}}].fap_resume_edu_coll" ng-model="eduHistory.fap_resume_edu_coll"  maxlength="50" placeholder="50<spring:message code="fap.placeholder.limit_characters" />" readonly>
							</li>					
						</ul>
						<ul class="tit3">
							<li class="wid1"><spring:message code="fap.resume.edu_major_field" /></li>
							<li class="wid2">
								<div class="resume-dropdown">
									<div class="resume-select">
										<button type="button" class="resume-select-btn" cd="{{eduHistory.fap_resume_edu_field}}"></button>
										<input type="hidden" id="resume-field-gb" name="resumeEduList[{{$index}}].fap_resume_edu_field" value="{{eduHistory.fap_resume_edu_field}}">
									</div>
									<div class="resume-select-option">
										<ul class="option-list">
											<li class="resume-field" ng-class="{'selected' : eduHistory.fap_resume_edu_field=='B2800'}">
												<button type="button" resume-field="B2800"><code value="B2800"></code></button>
											</li>
											<li class="resume-field" ng-class="{'selected' : eduHistory.fap_resume_edu_field=='B2801'}">
												<button type="button" resume-field="B2801"><code value="B2801"></code></button>
											</li>
											<li class="resume-field" ng-class="{'selected' : eduHistory.fap_resume_edu_field=='B2802'}">
												<button type="button" resume-field="B2802"><code value="B2802"></code></button>
											</li>
											<li class="resume-field" ng-class="{'selected' : eduHistory.fap_resume_edu_field=='B2803'}">
												<button type="button" resume-field="B2803"><code value="B2803"></code></button>
											</li>
											<li class="resume-field" ng-class="{'selected' : eduHistory.fap_resume_edu_field=='B2804'}">
												<button type="button" resume-field="B2804"><code value="B2804"></code></button>
											</li>
											<li class="resume-field" ng-class="{'selected' : eduHistory.fap_resume_edu_field=='B2805'}">
												<button type="button" resume-field="B2805"><code value="B2805"></code></button>
											</li>
											<li class="resume-field" ng-class="{'selected' : eduHistory.fap_resume_edu_field=='B2806'}">
												<button type="button" resume-field="B2806"><code value="B2806"></code></button>
											</li>
											<li class="resume-field" ng-class="{'selected' : eduHistory.fap_resume_edu_field=='B2807'}">
												<button type="button" resume-field="B2807"><code value="B2807"></code></button>
											</li>
										</ul>
									</div>
								</div>
							</li>					
						</ul>
						<ul class="tit3">
							<li class="wid1"><spring:message code="fap.resume.edu_major_nm" /></li>
							<li class="wid2">
								<input type="text" class="input2" name="resumeEduList[{{$index}}].fap_resume_edu_major" ng-model="eduHistory.fap_resume_edu_major"  maxlength="50" placeholder="50<spring:message code="fap.placeholder.limit_characters" />" readonly>
							</li>					
						</ul>
						<ul class="tit3">
							<li class="wid1"><spring:message code="fap.resume.edu_remarks" /></li>
							<li class="wid2">
								<textarea rows="4" cols="20" name="resumeEduList[{{$index}}].fap_resume_edu_note" ng-model="eduHistory.fap_resume_edu_note"  maxlength="150" placeholder="150<spring:message code="fap.placeholder.limit_characters" />" readonly></textarea>
							</li>
						</ul>					
					</div><!-- <div id="sub3_bbs3"> -->
				</div>
			</div><!-- <div id="userjoinBox"> -->
			<!-- ------------------------------------학력관련 교육이수 ---------------------------------------------->
			<div class="userjoinBox">
				<h2><spring:message code="fap.resume.career" /></h2>
				<div class="resume_crr_wrap">
					<div class="sub3_bbs3 resume_crr" ng-repeat ="career in resumeApply.resumeCareerList">
						<ul class="tit2 title">
							<li class="wid1"><spring:message code="fap.resume.career_service_start_day" /></li>
							<li class="wid2"><spring:message code="fap.resume.career_service_completion_day" /></li>
							<li class="wid3"><spring:message code="fap.resume.edu_period" /></li>
							<li class="wid4"><spring:message code="fap.resume.career_position" /></li>
						</ul>
						<ul class="tit2">
							<li class="wid1">
								<input type="text" class="input1 fap_resume_crr_st" name="resumeCareerList[{{$index}}].fap_resume_crr_st" id="fap_resume_crr_st_{{$index}}" ng-model="career.fap_resume_crr_st" readonly>
							</li>
							<li class="wid2">
								<input type="text" class="input1 fap_resume_crr_et" name="resumeCareerList[{{$index}}].fap_resume_crr_et" id="fap_resume_crr_et_{{$index}}" ng-model="career.fap_resume_crr_et" readonly>
							</li>
							<li class="wid3">
								<input type="text" class="input1 fap_resume_crr_pd_summary" name="resumeCareerList[{{$index}}].fap_resume_crr_pd_summary" id ="fap_resume_crr_pd_summary{{$index}}" ng-model="career.fap_resume_crr_pd_summary" maxlength="10" placeholder="10<spring:message code="fap.placeholder.limit_characters" />" readonly>
							</li>
							<li class="wid4">
								<input type="text" class="input1 fap_resume_crr_job_position" name="resumeCareerList[{{$index}}].fap_resume_crr_job_position" ng-model="career.fap_resume_crr_job_position" maxlength="10" placeholder="10<spring:message code="fap.placeholder.limit_characters" />" readonly>
							</li>
						</ul>
						<ul class="tit3">
							<li class="wid1"><spring:message code="fap.resume.career_comp_nm" /></li>
							<li class="wid2">
								<input type="text" class="input2 fap_resume_crr_comp_nm" name="resumeCareerList[{{$index}}].fap_resume_crr_comp_nm" ng-model="career.fap_resume_crr_comp_nm" maxlength="50" placeholder="50<spring:message code="fap.placeholder.limit_characters" />" readonly>
							</li>
						</ul>
						<ul class="tit3">
							<li class="wid1"><spring:message code="fap.resume.career_comp_major_business" /></li>
							<li class="wid2">
								<input type="text" class="input2 fap_resume_crr_major_bussiness" name="resumeCareerList[{{$index}}].fap_resume_crr_major_bussiness" ng-model="career.fap_resume_crr_major_bussiness" maxlength="50" placeholder="50<spring:message code="fap.placeholder.limit_characters" />" readonly>
							</li>					
						</ul>
						<ul class="tit3">
							<li class="wid1"><spring:message code="fap.resume.career_field" /></li>
							<li class="wid2">
								<div class="resume-dropdown">
									<div class="resume-select">
										<button type="button" class="resume-select-btn" cd="{{career.fap_resume_crr_gb}}"></button>
										<input type="hidden" id="resume-crr-gb" name="resumeCareerList[{{$index}}].fap_resume_crr_gb"  value="{{career.fap_resume_crr_gb}}">
									</div>
									<div class="resume-select-option">
										<ul class="option-list">
											<li class="resume-crr">
												<button type="button" resume-crr="B3900"><code value="B3900"></code></button>
											</li>
											<li class="resume-crr">
												<button type="button" resume-crr="B3901"><code value="B3901"></code></button>
											</li>
											<li class="resume-crr">
												<button type="button" resume-crr="B3902"><code value="B3902"></code></button>
											</li>
										</ul>
									</div>
								</div>
							</li>					
						</ul>
						<ul class="tit3">
							<li class="wid1"><spring:message code="fap.resume.career_responsibility" /></li>
							<li class="wid2">
								<textarea rows="4" cols="20" class="fap_resume_crr_job_function" name="resumeCareerList[{{$index}}].fap_resume_crr_job_function"  ng-model="career.fap_resume_crr_job_function" maxlength="150" placeholder="150<spring:message code="fap.placeholder.limit_characters" />" readonly></textarea>
							</li>
						</ul>					
					</div>
				</div>
			</div>	
			<!-- ------------------------------------사회 경력 ---------------------------------------------->
			<div class="userjoinBox">
				<h2><spring:message code="fap.resume.certification" /></h2>
				<div class="resume_license_wrap">
					<div class="sub3_bbs3 resume_license" ng-repeat="license in resumeApply.resumeLicenseList">
						<ul class="tit2 title">
							<li class="wid1"><spring:message code="fap.resume.certification_license" /></li>
							<li class="wid2"><spring:message code="fap.resume.certification_obtained_year" /></li>
							<li class="wid3"><spring:message code="fap.resume.certification_obtained_month" /></li>
							<li class="wid4"><spring:message code="fap.resume.certification_issuing_organization" /></li>
						</ul>
						<ul class="tit2">
							<li class="wid1">
								<div class="resume-dropdown">
									<div class="resume-select">
										<button type="button" class="resume-select-btn" cd="{{license.fap_resume_license_nm}}"></button>
										<input type="hidden" id="resume-license-gb" name="resumeLicenseList[{{$index}}].fap_resume_license_nm" value="{{license.fap_resume_license_nm}}">
									</div>
									<div class="resume-select-option">
										<ul class="option-list">
											<li class="resume-license selected">
												<button type="button" resume-license="B2900"><code value="B2900"></code></button>
											</li>
											<li class="resume-license">
												<button type="button" resume-license="B2901"><code value="B2901"></code></button>
											</li>
											<li class="resume-license">
												<button type="button" resume-license="B2902"><code value="B2902"></code></button>
											</li>
											<li class="resume-license">
												<button type="button" resume-license="B2903"><code value="B2903"></code></button>
											</li>
											<li class="resume-license">
												<button type="button" resume-license="B2904"><code value="B2904"></code></button>
											</li>
											<li class="resume-license">
												<button type="button" resume-license="B2905"><code value="B2905"></code></button>
											</li>
											<li class="resume-license">
												<button type="button" resume-license="B2906"><code value="B2906"></code></button>
											</li>
										</ul>
									</div>
								</div>						
							</li>
							<li class="wid2">
								<input type="text" class="input1 fap_resume_license_get_year" name="resumeLicenseList[{{$index}}].fap_resume_license_get_year" ng-model="license.fap_resume_license_get_year" maxlength="4" placeholder="<spring:message code="com.placeholder.yyyy" />" readonly>
							</li>
							<li class="wid3">
								<input type="text" class="input1 fap_resume_license_get_month" name="resumeLicenseList[{{$index}}].fap_resume_license_get_month" ng-model="license.fap_resume_license_get_month" maxlength="2" placeholder="<spring:message code="com.placeholder.mm" />" readonly>
							</li>
							<li class="wid4">
								<input type="text" class="input1 fap_resume_license_issuing_organization" name="resumeLicenseList[{{$index}}].fap_resume_license_issuing_organization" ng-model="license.fap_resume_license_issuing_organization" maxlength="15" placeholder="15<spring:message code="fap.placeholder.limit_characters" />" readonly>
							</li>
						</ul>
						<ul class="tit3">
							<li class="wid1"><spring:message code="fap.resume.certification_score" /></li>
							<li class="wid2">
								<input type="number" class="input2" name="resumeLicenseList[{{$index}}].fap_resume_license_score" ng-model="license.fap_resume_license_score" maxlength="10" placeholder="10<spring:message code="fap.placeholder.limit_characters" />" readonly>
							</li>
						</ul>
						<ul class="tit3">
							<li class="wid1"><spring:message code="fap.resume.certification_remarks" /></li>
							<li class="wid2">
								<textarea rows="4" cols="20" name="resumeLicenseList[{{$index}}].fap_resume_license_note" ng-model="license.fap_resume_license_note" maxlength="150" placeholder="150<spring:message code="fap.placeholder.limit_characters" />" readonly></textarea>
							</li>
						</ul>					
					</div><!-- <div id="sub3_bbs3"> -->
				</div>
			</div>
			<!-- ----------------------------자격(기술 및 외국어 역량 중심) --------------------------------------------->
			<div class="userjoinBox">
				<h2><spring:message code="fap.resume.talent" /></h2>
				<div class="resume_talent_wrap">
					<div class="sub3_bbs7 resume_talent" ng-repeat="talent in resumeApply.resumeTalentList">
						<ul class="tit2">
							<li class="wid1"><spring:message code="fap.resume.talent_number" /></li>
							<li class="wid2"><spring:message code="fap.resume.talent_context" /></li>
						</ul>
						<ul class="tit3">
							<li class="wid1">{{$index+1}}</li>
							<li class="wid2">
								<textarea rows="4" cols="20" class="fap_resume_talent_content" name="resumeTalentList[{{$index}}].fap_resume_talent_content" ng-model="talent.fap_resume_talent_content" maxlength="200" placeholder="200<spring:message code="fap.placeholder.limit_characters" />" readonly></textarea>
							</li>
						</ul>				
					</div><!-- <div id="sub3_bbs7"> -->
				</div>
			</div><!-- <div id="userjoinBox"> -->				
			<!-- ----------------------------역량/재능(ICT, 외국어, 인간관계 등 업무 관련 상세) --------------------------------------------->
			<div class="userjoinBox">
				<h2><spring:message code="fap.resume.project_development_career" /></h2>
				<div class="resume_project_wrap">
					<div class="sub3_bbs3 resume_project" ng-repeat="project in resumeApply.resumeProjectList">
						<ul class="tit2 title">
							<li class="wid1"><spring:message code="fap.resume.project_development_start_date" /></li>
							<li class="wid2"><spring:message code="fap.resume.project_development_end_date" /></li>
							<li class="wid3"><spring:message code="fap.resume.edu_period" /></li>
							<li class="wid4"><spring:message code="fap.resume.project_development_member" /></li>
						</ul>
						<ul class="tit2">
							<li class="wid1">
								<input type="text" class="input1 fap_resume_project_st" name="resumeProjectList[{{$index}}].fap_resume_project_st" id="fap_resume_project_st_{{$index}}" ng-model="project.fap_resume_project_st" readonly>
							</li>
							<li class="wid2">
								<input type="text" class="input1 fap_resume_project_et" name="resumeProjectList[{{$index}}].fap_resume_project_et" id="fap_resume_project_et_{{$index}}" ng-model="project.fap_resume_project_et" readonly>
							</li>
							<li class="wid3">
								<input type="text" class="input1 fap_resume_project_pd_summary" name="resumeProjectList[{{$index}}].fap_resume_project_pd_summary" id ="fap_resume_project_pd_summary{{$index}}" ng-model="project.fap_resume_project_pd_summary"  maxlength="10" placeholder="10<spring:message code="fap.placeholder.limit_characters" />" readonly>
							</li>
							<li class="wid4">
								<input type="number" class="input1 fap_resume_project_peoples_num" name="resumeProjectList[{{$index}}].fap_resume_project_peoples_num" id="fap_resume_project_peoples_num{{$index}}" ng-model="project.fap_resume_project_peoples_num" maxlength="10" placeholder="10<spring:message code="fap.placeholder.limit_characters" />" readonly>
								<span class="hiddenTx"><spring:message code="com.placeholder.people" /></span>
							</li>
						</ul>
						<ul class="tit3">
							<li class="wid1"><spring:message code="fap.resume.project_nm" /></li>
							<li class="wid2">
								<input type="text" class="input2 fap_resume_project_nm" name="resumeProjectList[{{$index}}].fap_resume_project_nm" ng-model="project.fap_resume_project_nm" maxlength="50" placeholder="50<spring:message code="fap.placeholder.limit_characters" />" readonly>
							</li>
						</ul>
						<ul class="tit3">
							<li class="wid1"><spring:message code="fap.resume.project_main_service" /></li>
							<li class="wid2">
								<textarea rows="4" cols="20" class="fap_resume_project_service" name="resumeProjectList[{{$index}}].fap_resume_project_service" ng-model="project.fap_resume_project_service" maxlength="150" placeholder="150<spring:message code="fap.placeholder.limit_characters" />" readonly></textarea>
							</li>					
						</ul>
						<ul class="tit3">
							<li class="wid1"><spring:message code="fap.resume.project_charge_filed" /></li>
							<li class="wid2">
								<textarea rows="4" cols="20" class="fap_resume_project_responsibility" name="resumeProjectList[{{$index}}].fap_resume_project_responsibility"  ng-model="project.fap_resume_project_responsibility" maxlength="150" placeholder="150<spring:message code="fap.placeholder.limit_characters" />" readonly></textarea>
							</li>
						</ul>
						<ul class="tit3">
							<li class="wid1"><spring:message code="fap.resume.project_used_technique" /></li>
							<li class="wid2">
								<textarea rows="4" cols="20" class="fap_resume_project_technique" name="resumeProjectList[{{$index}}].fap_resume_project_technique" ng-model="project.fap_resume_project_technique" maxlength="150" placeholder="150<spring:message code="fap.placeholder.limit_characters" />" readonly></textarea>
							</li>
						</ul>					
					</div><!-- <div id="sub3_bbs3"> -->
				</div>
			</div>		
			<!-- ----------------------------SW 프로젝트 개발경력 --------------------------------------------->
			<div class="userjoinBox">
				<h2><spring:message code="fap.resume.self_introduction" /></h2>
				<div class="sub3_bbs8">
					<ul class="tit2">
						<li class="wid1">
							<code value="B4100"></code>
							<input type="hidden" name="resumeProfileList[0].fap_resume_pr_gb" value="B4100">
						</li>					
					</ul>
					<ul class="tit3">
					
						<li class="wid1">
							<textarea rows="4" cols="20" name="resumeProfileList[0].fap_resume_pr_content" ng-model="resumeApply.resumeProfileList[0].fap_resume_pr_content" maxlength="1000" placeholder="1000<spring:message code="fap.placeholder.limit_characters" />" readonly></textarea>
						</li>						
					</ul>
					<ul class="tit2">
						<li class="wid1">
							<code value="B4101"></code>
							<input type="hidden" name="resumeProfileList[1].fap_resume_pr_gb" value="B4101">
						</li>					
					</ul>
					<ul class="tit3">
					
						<li class="wid1">
							<textarea rows="4" cols="20" name="resumeProfileList[1].fap_resume_pr_content" ng-model="resumeApply.resumeProfileList[1].fap_resume_pr_content" maxlength="1000" placeholder="1000<spring:message code="fap.placeholder.limit_characters" />" readonly></textarea>
						</li>						
					</ul>
					<ul class="tit2">
						<li class="wid1">
							<code value="B4102"></code>
							<input type="hidden" name="resumeProfileList[2].fap_resume_pr_gb" value="B4102">
						</li>					
					</ul>
					<ul class="tit3">
					
						<li class="wid1">
							<textarea rows="4" cols="20" name="resumeProfileList[2].fap_resume_pr_content" ng-model="resumeApply.resumeProfileList[2].fap_resume_pr_content" maxlength="1000" placeholder="1000<spring:message code="fap.placeholder.limit_characters" />" readonly></textarea>
						</li>						
					</ul>
				</div> <!-- <div id="sub3_bbs8"> -->
			</div><!-- <div id="userjoinBox"> -->				
			<!-- ----------------------------------------------자기소개서----------- --------------------------------------------->
			<div class="userjoinBox">
				<h2><spring:message code="fap.resume.self_introduction_video_portfolio" /></h2>
				<h4>
					<spring:message code="fap.resume.fap.resume.self_introduction_text" />
				</h4>
				<div id="sub3_bbs9">
					<ul class="tit2 resumeFile" ng-switch="!!resumeApply.resumeFileList[0].fap_resume_file_origin">
						<li class="wid1"><spring:message code="fap.resume.self_introduction_file" /></li>	
						<li class="wid3" ng-switch-when="true">
							<input type="hidden" name="resumeFileList[0].fap_resume_file_origin" value="{{resumeApply.resumeFileList[0].fap_resume_file_origin}}">
							<input type="hidden" name="resumeFileList[0].fap_resume_file_saved" value="{{resumeApply.resumeFileList[0].fap_resume_file_saved}}">
							<input type="hidden" value="B3700" name="resumeFileList[0].fap_resume_file_gb"> 
							<a class="display-inline" ng-href="/file_download?origin={{resumeApply.resumeFileList[0].fap_resume_file_origin}}&saved={{resumeApply.resumeFileList[0].fap_resume_file_saved}}&path=/fap/user/resume_movie_file">
								<span ng-bind="resumeApply.resumeFileList[0].fap_resume_file_origin"></span>
							</a>
						</li>
						
						<li class="wid3" ng-switch-default>
							등록된 파일이 없습니다.
						</li>
						<li class="wid4">
							<label for="resume_file_video"><font color="red"><small>● 파일명은 영어,숫자의 조합으로 하시길 권장합니다.</small></font></label>
						</li>
					</ul>
					<ul class="tit2 resumeFile" ng-switch="!!resumeApply.resumeFileList[1].fap_resume_file_origin">
						<li class="wid1"></li>
						<li class="wid3 va-bt" ng-switch-when="true">
							<input type="hidden" value="B3701" name="resumeFileList[1].fap_resume_file_gb">
							<input type="hidden" name="resumeFileList[1].fap_resume_file_origin" value="{{resumeApply.resumeFileList[1].fap_resume_file_origin}}">
							<input type="hidden" name="resumeFileList[1].fap_resume_file_saved" value="{{resumeApply.resumeFileList[1].fap_resume_file_saved}}">
							<a class="display-inline" ng-href="/file_download?origin={{resumeApply.resumeFileList[1].fap_resume_file_origin}}&saved={{resumeApply.resumeFileList[1].fap_resume_file_saved}}&path=/fap/user/resume_portfolio_file">
								<span ng-bind="resumeApply.resumeFileList[1].fap_resume_file_origin"></span>
							</a>
						</li>
						<li  class="wid3" ng-switch-default>
							등록된 파일이 없습니다.
						</li>
						<li class="wid4">
							<label for="resume_file_pdf"><font color="red"><small>● 파일은 pdf, zip, mp4, wmv, mpg, mpeg, avi 만 가능합니다.</small></font></label><br>
							<span class="resume_file_tx_sub"><font color="red"><small>다른형태의 파일은 압축하여 올려주세요.</small></font></span>
						</li>
					</ul>	
					<ul class="tit2 resumeFile" ng-switch="!!resumeApply.resumeFileList[2].fap_resume_file_origin">
						<li class="wid1"></li>	
						<li class="wid3" ng-switch-when="true">
							<input type="hidden" name="resumeFileList[2].fap_resume_file_origin" value="{{resumeApply.resumeFileList[2].fap_resume_file_origin}}">
							<input type="hidden" name="resumeFileList[2].fap_resume_file_saved" value="{{resumeApply.resumeFileList[2].fap_resume_file_saved}}">
							<input type="hidden" value="B3702" name="resumeFileList[2].fap_resume_file_gb"> 
							<a class="display-inline" ng-href="/file_download?origin={{resumeApply.resumeFileList[2].fap_resume_file_origin}}&saved={{resumeApply.resumeFileList[2].fap_resume_file_saved}}&path=/fap/user/resume_project_file">
								<span ng-bind="resumeApply.resumeFileList[2].fap_resume_file_origin"></span>
							</a>
						</li>
						<li class="wid3" ng-switch-default>
							등록된 파일이 없습니다.
						</li>
						<li class="wid4">
							<label for="resume_file_project"><font color="red"><small>● 각 파일은 최대 100M 까지 가능합니다.</small></font></label>
						</li>
					</ul>
					<ul class="tit2">
						<li class="wid1"><spring:message code="fap.resume.self_introduction_url" /></li>
						<li class="wid2" ng-switch="!!resumeApply.fap_resume_url">
							<font color="red"><small>http:// 혹은 https:// 로 시작해야 합니다.</small></font><br>
							<input type="text" ng-switch-when="true" class="input1" id="fap_resume_url" name="fap_resume_url" maxlength="100" placeholder="ex) http://www.bridge.career" value="{{resumeApply.fap_resume_url}}" readonly>
							<input type="text" ng-switch-default class="input1" id="fap_resume_url" name="fap_resume_url" maxlength="100" readonly>
						</li>
					</ul>			
				</div> <!-- <div id="sub3_bbs9"> -->
			</div>
			<div class="userjoinBox">
				<div id="sub3_bbsbtn">
					<input type="button" class="resume_list" id="resume_list_btn" value="목록으로" onclick="readList();">
				</div> <!-- <div id="sub3_bbsbtn"> -->
			</div><!-- <div id="userjoinBox"> -->				
			<!-- ----------------------------------------------개인 동영상 및 포트폴리오 파일----------- --------------------------------------------->
		</div>
		</div>
		<%@include file="../common_footer_fap.jsp"%>
	</body>
</html>
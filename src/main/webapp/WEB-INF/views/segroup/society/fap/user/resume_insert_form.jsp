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
	$(function() {
		
		realTimeValidation();
		
		_insert = _.debounce(function(){
			$('#resume_form').submit(); 
		},500,true);
		
		cleanDatepicker();
		
		minMax("fap_resume_edu_er_dt_0" , "fap_resume_edu_gd_dt_0");
		minMax("fap_resume_crr_st_0" , "fap_resume_crr_et_0");
		minMax("fap_resume_project_st_0","fap_resume_project_et_0");
		
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
			if( extension_check_files(file) ) {
				
			} else {
				alert('<spring:message code="fap.err.file_type" javaScriptEscape="true" />');
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
			if( extension_check_files(file) ) {
				
			} else {
				alert('<spring:message code="fap.err.file_type" javaScriptEscape="true" />');
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
		
		//프로젝트 영상
		$("#resume_personal_project").change(function(){
			 var file = $(this).val();
			
			 if(file == ""){
				 $(this).val("");
				 return;
			 }
			 
			//확장자 체크
			if( extension_check_files(file) ) {
				
			} else {
				alert('<spring:message code="fap.err.file_type" javaScriptEscape="true" />');
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
		
		//기혼여부
		$(".marital_radio").off("click").on("click",function(){
			
			$(".marital_radio").removeClass("ck");
			$(".marital_radio").find("input:radio[name='fap_resume_marital']").prop("checked", false);
			$(this).addClass("ck");
			$(this).find("input:radio[name='fap_resume_marital']").prop("checked", true);
			
			return;
		});
		
		resume_gd_event();
		
		resume_field_event();
		
		resume_crr_event();
		
		resume_license_event();
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
			//숫자와 콤마만 입력
			$(this).val($(this).val().replace(/[^-\.0-9]/g, ""));
			
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

	
	myApp.controller('ResumeController',['$scope','$compile', function($scope, $compile) {
				
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
							content += '<input type="text" class="input1 fap_resume_edu_er_dt" name="resumeEduList['+eduIndex+'].fap_resume_edu_er_dt" id="'+eduStartId+'"  readonly="readonly">';
							content += '</li>';
							content += '<li class="wid2">';
							content += '<input type="text" class="input1 fap_resume_edu_gd_dt" name="resumeEduList['+eduIndex+'].fap_resume_edu_gd_dt" id="'+eduEndId+'"  readonly="readonly">';
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
							content += '<button type="button" class="resume-select-btn"><code value="B2807"></code></button>';
							content += '<input type="hidden" id="resume-field-gb" name="resumeEduList['+eduIndex+'].fap_resume_edu_field" value="B2807">';
							content += '</div>';
							content += '<div class="resume-select-option">';
							content += '<ul class="option-list">';
							content += '<li class="resume-field">';
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
							content += '<li class="resume-field selected">';
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
							content += '<input type="text" class="input1 fap_resume_crr_st" name="resumeCareerList['+careerIndex+'].fap_resume_crr_st" id="'+ careerStartId +'"  readonly="readonly">';
							content += '</li>';
							content += '<li class="wid2">';
							content += '<input type="text" class="input1 fap_resume_crr_et" name="resumeCareerList['+careerIndex+'].fap_resume_crr_et" id="'+careerEndId+'"  readonly="readonly">';
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
							content += '<input type="text" class="input1 fap_resume_project_st" name="resumeProjectList['+projectIndex+'].fap_resume_project_st" id="'+ projectStartId +'"  readonly="readonly">';
							content += '</li>';
							content += '<li class="wid2">';
							content += '<input type="text" class="input1 fap_resume_project_et" name="resumeProjectList['+projectIndex+'].fap_resume_project_et" id="'+ projectEndId +'"  readonly="readonly">';
							content += '</li>';
							content += '<li class="wid3">';
							content += '<input type="text" class="input1 fap_resume_project_pd_summary" name="resumeProjectList['+projectIndex+'].fap_resume_project_pd_summary" id ="fap_resume_project_pd_summary'+projectIndex+'"  maxlength="10" placeholder="10<spring:message code="fap.placeholder.limit_characters" />">';
							content += '</li>';
							content += '<li class="wid4">';
							content += '<input type="number" class="input1 fap_resume_project_peoples_num" name="resumeProjectList['+projectIndex+'].fap_resume_project_peoples_num" id="fap_resume_project_peoples_num'+projectIndex+'"  maxlength="10" placeholder="10<spring:message code="fap.placeholder.limit_characters" />">';
							content += '<span class="hiddenTxt"><spring:message code="com.placeholder.people" /></span>';
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
							content +='<input type="number" class="input2" name="resumeLicenseList['+licenseIndex+'].fap_resume_license_score" maxlength="10" placeholder="10<spring:message code="fap.placeholder.limit_characters" />" step="0.1">';
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
							content += '<textarea rows="4" cols="20" class="fap_resume_talent_content" name="resumeTalentList['+talentNumber+'].fap_resume_talent_content" maxlength="200" placeholder="<spring:message code="fap.resume.talent_context_ex" />  (200<spring:message code="fap.placeholder.limit_characters" />)"></textarea>';
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
					}
				]);
	
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
	//blurCurrency
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
	}]);
	
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
	
	//유효성 검사
	function formCheck(){
		//commaTest
		$.each($(".currency"),function(index,item){
			var commaValue = angular.element(item).val();
			
			angular.element(item).val(commaValue.replace(/,/g, ''));
		});
	
		//이력서 제목 체크
		var fap_resume_title = $("#fap_resume_title").val();
		if(fap_resume_title == "") {
			$("#fap_resume_title").focus();
			alert("이력서 제목을 입력해 주세요");
			return false;
		}
		
		//국적 체크
		var nationality = $("#nationality").val();
		if(nationality == ""){
			$("#nationality").focus();
			alert("국적을 입력해 주세요");
			return false;
		}
		
		//이름(일문) 체크
		var fap_resume_nm_ja = $("#fap_resume_nm_ja").val();
		if(fap_resume_nm_ja == ""){
			$("#fap_resume_nm_ja").focus();
			alert("이름(일문)을 입력해 주세요");
			return false;
		}
		
		//이름(요미가나) 체크
		var fap_resume_nm_yomi = $("#fap_resume_nm_yomi").val();
		if(fap_resume_nm_yomi == ""){
			$("#fap_resume_nm_yomi").focus();
			alert("이름(요미가나)를 입력해 주세요");
			return false;
		}
		
		//이름(영문) 체크
		var fap_resume_nm_eng = $("#fap_resume_nm_eng").val();
		if(fap_resume_nm_eng == ""){
			$("#fap_resume_nm_eng").focus();
			alert("이름(영문)을 입력해 주세요");
			return false;
		}

		//기혼여부 체크
		if($("input:radio[name='fap_resume_marital']").is(":checked") == false){
			alert('기혼여부를 선택해 주세요.');
			return false;
		}
		
		//학력정보 체크
		var edu_length = $(".resume_edu").length;
		var edu_sc_check = false;
		var edu_er_dt_check = false;
		var edu_gd_dt_check = false;
		var edu_pd_summary_check = false;
		
		if(edu_length > 0){
			
			$.each($(".fap_resume_edu_sc_nm"), function(index, item){
				if($(this).val() == null || $(this).val() == ''){
					alert("학력정보의 기관명/학교를 입력해 주세요.");
					$(this).focus();
					edu_sc_check = true;
					return false;
				}
			});
			
			if(edu_sc_check) {
				return false;
			}
			
			$.each($(".fap_resume_edu_er_dt"), function(index, item){
				if($(this).val() == null || $(this).val() == ''){
					alert("학력정보의 입학날짜를 입력해 주세요.");
					$(this).focus();
					edu_er_dt_check = true;
					return false;
				}
			});
			
			if(edu_er_dt_check) {
				return false;
			}
			
			$.each($(".fap_resume_edu_gd_dt"), function(index, item){
				if($(this).val() == null || $(this).val() == ''){
					alert("학력정보의 졸업날짜를 입력해 주세요.");
					$(this).focus();
					edu_gd_dt_check = true;
					return false;
				}
			});
			
			if(edu_gd_dt_check) {
				return false;
			}
			
			$.each($(".fap_resume_edu_pd_summary"), function(index, item){
				if($(this).val() == null || $(this).val() == ''){
					alert("학력정보의 기간요약을 입력해 주세요.");
					$(this).focus();
					edu_pd_summary_check = true;
					return false;
				}
			});
			
			if(edu_pd_summary_check) {
				return false;
			}
			
		}
		
		//사회경력 체크
		var crr_length = $(".resume_crr").length;
		var crr_st_check = false;
		var crr_et_check = false;
		var crr_pd_summary_check = false;
		var crr_job_position_check = false;
		var crr_comp_nm_check = false;
		var crr_major_bussiness_check = false;
		var crr_job_function_check = false;
		
		if(crr_length > 0){
			
			$.each($(".fap_resume_crr_st"), function(index, item){
				if($(this).val() == null || $(this).val() == ''){
					alert("사회경력의 근무시작일을 입력해 주세요.");
					$(this).focus();
					crr_st_check = true;
					return false;
				}
			});
			
			if(crr_st_check) {
				return false;
			}
			
			$.each($(".fap_resume_crr_et"), function(index, item){
				if($(this).val() == null || $(this).val() == ''){
					alert("사회경력의 근무종료일을 입력해 주세요.");
					$(this).focus();
					crr_et_check = true;
					return false;
				}
			});
			
			if(crr_et_check) {
				return false;
			}
			
			$.each($(".fap_resume_crr_pd_summary"), function(index, item){
				if($(this).val() == null || $(this).val() == ''){
					alert("사회경력의 기간요약을 입력해 주세요.");
					$(this).focus();
					crr_pd_summary_check = true;
					return false;
				}
			});
			
			if(crr_pd_summary_check) {
				return false;
			}
			
			$.each($(".fap_resume_crr_job_position"), function(index, item){
				if($(this).val() == null || $(this).val() == ''){
					alert("사회경력의 직위를 입력해 주세요.");
					$(this).focus();
					crr_job_position_check = true;
					return false;
				}
			});
			
			if(crr_job_position_check) {
				return false;
			}
			
			$.each($(".fap_resume_crr_comp_nm"), function(index, item){
				if($(this).val() == null || $(this).val() == ''){
					alert("사회경력의 회사명을 입력해 주세요.");
					$(this).focus();
					crr_comp_nm_check = true;
					return false;
				}
			});
			
			if(crr_comp_nm_check) {
				return false;
			}
			
			$.each($(".fap_resume_crr_major_bussiness"), function(index, item){
				if($(this).val() == null || $(this).val() == ''){
					alert("사회경력의 회사주요사업을 입력해 주세요.");
					$(this).focus();
					crr_major_bussiness_check = true;
					return false;
				}
			});
			
			if(crr_major_bussiness_check) {
				return false;
			}
			
			$.each($(".fap_resume_crr_job_function"), function(index, item){
				if($(this).val() == null || $(this).val() == ''){
					alert("사회경력의 담당업무를 입력해 주세요.");
					$(this).focus();
					crr_job_function_check = true;
					return false;
				}
			});
			
			if(crr_job_function_check) {
				return false;
			}
		}
		
		//프로젝트경력 체크
		var project_length = $(".resume_project").length;
		var project_st_check = false;
		var project_et_check = false;
		var project_pd_summary_check = false;
		var project_peoples_num_check = false;
		var project_nm_check = false;
		var project_service_check = false;
		var project_responsibility_check = false;
		var project_technique_check = false;
		
		if(project_length > 0){
			
			$.each($(".fap_resume_project_st"), function(index, item){
				if($(this).val() == null || $(this).val() == ''){
					alert("프로젝트경력의 개발시작일을 입력해 주세요.");
					$(this).focus();
					project_st_check = true;
					return false;
				}
			});
			
			if(project_st_check) {
				return false;
			}
			
			$.each($(".fap_resume_project_et"), function(index, item){
				if($(this).val() == null || $(this).val() == ''){
					alert("프로젝트경력의 개발종료일을 입력해 주세요.");
					$(this).focus();
					project_et_check = true;
					return false;
				}
			});
			
			if(project_et_check) {
				return false;
			}
			
			$.each($(".fap_resume_project_pd_summary"), function(index, item){
				if($(this).val() == null || $(this).val() == ''){
					alert("프로젝트경력의 기간요약을 입력해 주세요.");
					$(this).focus();
					project_pd_summary_check = true;
					return false;
				}
			});
			
			if(project_pd_summary_check) {
				return false;
			}
			
			$.each($(".fap_resume_project_peoples_num"), function(index, item){
				if($(this).val() == null || $(this).val() == ''){
					alert("프로젝트경력의 참여인원을 입력해 주세요.");
					$(this).focus();
					project_peoples_num_check = true;
					return false;
				}
			});
			
			if(project_peoples_num_check) {
				return false;
			}
			
			$.each($(".fap_resume_project_nm"), function(index, item){
				if($(this).val() == null || $(this).val() == ''){
					alert("프로젝트경력의 프로젝트명을 입력해 주세요.");
					$(this).focus();
					project_nm_check = true;
					return false;
				}
			});
			
			if(project_nm_check) {
				return false;
			}
			
			$.each($(".fap_resume_project_service"), function(index, item){
				if($(this).val() == null || $(this).val() == ''){
					alert("프로젝트경력의 주요서비스를 입력해 주세요.");
					$(this).focus();
					project_service_check = true;
					return false;
				}
			});
			
			if(project_service_check) {
				return false;
			}
			
			$.each($(".fap_resume_project_responsibility"), function(index, item){
				if($(this).val() == null || $(this).val() == ''){
					alert("프로젝트경력의 담당분야를 입력해 주세요.");
					$(this).focus();
					project_responsibility_check = true;
					return false;
				}
			});
			
			if(project_responsibility_check) {
				return false;
			}
			
			$.each($(".fap_resume_project_technique"), function(index, item){
				if($(this).val() == null || $(this).val() == ''){
					alert("프로젝트경력의 사용기술을 입력해 주세요.");
					$(this).focus();
					project_technique_check = true;
					return false;
				}
			});
			
			if(project_technique_check) {
				return false;
			}
			
		}
		
		//자격증 체크
		var license_length = $(".resume_license").length;
		var license_get_year_check = false;
		var license_get_month_check = false;
		var license_issuing_organization_check = false;
		
		if(license_length > 0){
			
			$.each($(".fap_resume_license_get_year"), function(index, item){
				if($(this).val() == null || $(this).val() == ''){
					alert("자격증의 취득년도를 입력해 주세요.");
					$(this).focus();
					license_get_year_check = true;
					return false;
				}else if(isNaN($(this).val())){
					alert("자격증의 취득년도는 4자리 숫자만 입력해 주세요.");
					$(this).focus();
					license_get_year_check = true;
					return false;
				}
			});
			
			if(license_get_year_check) {
				return false;
			}
			
			$.each($(".fap_resume_license_get_month"), function(index, item){
				if($(this).val() == null || $(this).val() == ''){
					alert("자격증의 취득월을 입력해 주세요.");
					$(this).focus();
					license_get_month_check = true;
					return false;
				}else if(isNaN($(this).val())){
					alert("자격증의 취득월은 2자리 숫자만 입력해 주세요.");
					$(this).focus();
					license_get_month_check = true;
					return false;
				}
			});
			
			if(license_get_month_check) {
				return false;
			}
			
			$.each($(".fap_resume_license_issuing_organization"), function(index, item){
				if($(this).val() == null || $(this).val() == ''){
					alert("자격증의 발행기관을 입력해 주세요.");
					$(this).focus();
					license_issuing_organization_check = true;
					return false;
				}
			});
			
			if(license_issuing_organization_check) {
				return false;
			}
		}
		
		//역량/재능 체크
		var talent_length = $(".resume_talent").length;
		var talent_content_check = false;
		
		if(talent_length > 0){
			
			$.each($(".fap_resume_talent_content"), function(index, item){
				if($(this).val() == null || $(this).val() == ''){
					alert("역량/재능의 내용을 입력해 주세요.");
					$(this).focus();
					talent_content_check = true;
					return false;
				}
			});
			
			if(talent_content_check) {
				return false;
			}
		}
		
		
		$("input[type='number']").each(function(index, item){
			var value = $(item).val();
			if(value == null || value == ""){
				
				$(item).val("0");
			}
			
		})
		
		var fap_resume_url = $("#fap_resume_url").val();
		
		if(fap_resume_url != ""){
			if(!checkUrlForm(fap_resume_url)){
				alert("올바른 URL형태가 아닙니다.");
				return false;
			}else if(fap_resume_url == "http://" || fap_resume_url == "https://"){
				$("#fap_resume_url").val("");
			}
		}
		
		_insert();
		
	}

	//url 체크
	function checkUrlForm(strUrl) {
	    var expUrl = /^http[s]?\:\/\//i;
	    return expUrl.test(strUrl);
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
	
	//통합 파일
	function extension_check_files (file_name){
		var extension = file_name.substring(file_name.lastIndexOf('.') + 1).toLowerCase();
		
		switch (extension) {
		case "pdf":
		case "zip":
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
	
	var blur_flag = true;
	
	function resume_license_event(){
		select_box_event();
		
		//주요업무 셀렉트 옵션 선택
		$(".resume-license").off("click").on("click",function(){
			if(!$(this).hasClass("selected")){
				var btnval = $(this).find("span").text();
				var work_code = $(this).find("span").attr("value");
				$(this).closest(".resume-dropdown").find(".resume-select span").text(btnval);
				$(this).closest(".resume-dropdown").find(".resume-select input").val(work_code);
				
				$(this).siblings().removeClass("selected");
				$(this).addClass("selected");
			}
			$(this).closest(".resume-dropdown").find(".resume-select").removeClass("on");
			$(this).closest(".resume-dropdown").find(".resume-select").nextAll(".resume-select-option").css("display","none");

		});
	}
	
	function resume_crr_event(){
		select_box_event();
		
		//주요업무 셀렉트 옵션 선택
		$(".resume-crr").off("click").on("click",function(){
			if(!$(this).hasClass("selected")){
				var btnval = $(this).find("span").text();
				var work_code = $(this).find("span").attr("value");
				$(this).closest(".resume-dropdown").find(".resume-select span").text(btnval);
				$(this).closest(".resume-dropdown").find(".resume-select input").val(work_code);
				
				$(this).siblings().removeClass("selected");
				$(this).addClass("selected");
			}
			$(this).closest(".resume-dropdown").find(".resume-select").removeClass("on");
			$(this).closest(".resume-dropdown").find(".resume-select").nextAll(".resume-select-option").css("display","none");

		});
	}
	
	function resume_gd_event(){
		select_box_event();
		
		//주요업무 셀렉트 옵션 선택
		$(".resume-gd").off("click").on("click",function(){
			if(!$(this).hasClass("selected")){
				var btnval = $(this).find("span").text();
				var work_code = $(this).find("span").attr("value");
				$(this).closest(".resume-dropdown").find(".resume-select span").text(btnval);
				$(this).closest(".resume-dropdown").find(".resume-select input").val(work_code);
				
				$(this).siblings().removeClass("selected");
				$(this).addClass("selected");
			}
			$(this).closest(".resume-dropdown").find(".resume-select").removeClass("on");
			$(this).closest(".resume-dropdown").find(".resume-select").nextAll(".resume-select-option").css("display","none");

		});
	}
	
	function resume_field_event(){
		select_box_event();
		
		//주요업무 셀렉트 옵션 선택
		$(".resume-field").off("click").on("click",function(){
			if(!$(this).hasClass("selected")){
				var btnval = $(this).find("span").text();
				var work_code = $(this).find("span").attr("value");
				$(this).closest(".resume-dropdown").find(".resume-select span").text(btnval);
				$(this).closest(".resume-dropdown").find(".resume-select input").val(work_code);
				
				$(this).siblings().removeClass("selected");
				$(this).addClass("selected");
			}
			$(this).closest(".resume-dropdown").find(".resume-select").removeClass("on");
			$(this).closest(".resume-dropdown").find(".resume-select").nextAll(".resume-select-option").css("display","none");

		});
	}
	
	//셀렉트 박스 공통 이벤트
	function select_box_event(){
		$(".resume-select").off("click").on("click",function(){
			$(this).toggleClass("on");
			$(this).nextAll(".resume-select-option").toggle();
		});
		
		$(".resume-select-option").off("mouseenter").on("mouseenter",function(){
			blur_flag = false;
		});
		$(".resume-select-option").off("mouseleave").on("mouseleave",function(){
			blur_flag = true;
		});
		
		$(".resume-select-btn").blur(function(){
	 		if(blur_flag){
				$(this).closest(".resume-select").removeClass("on");
				$(this).closest(".resume-select").nextAll(".resume-select-option").css("display","none");
	 		}
		});
	}
	
	
</script>
</head>
	<body ng-app="myapp" ng-controller="ResumeController">
		<sec:authorize access="hasAnyRole('ROLE_A0100', 'ROLE_A0101', 'ROLE_A0102', 'ROLE_A0106', 'ROLE_A0108')">
		<sec:authentication property="details.user" var="detail" />
		</sec:authorize>
		<%@include file="user_menu.jsp"%>
		<%@include file="user_quick_menu.jsp"%>
		<div class="resume_wrap">
		<div id="subcontents">
		
		<form id="resume_form" action="resume_insert" method="post" style="width: 100%"  enctype="multipart/form-data">
			
			<!-- userId 정보 가져와주세요 -->
			<input type="hidden" name="user_id" value="${detail.user_id}">
			<input type="hidden" name="fap_resume_ins_id" value="${detail.user_id}">
			<input type="hidden" name="fap_resume_udt_id" value="${detail.user_id}">
			
			<div class="userjoinBox">
				<div id="sub3Box">
					<h2>이력서 만들기</h2>
					<h2 class="red" style="color: red; padding-top: 10px;"><b>＊ 이력서는 반드시 일본어로 작성해 주시기 바랍니다.</b></h2>
				</div>
				<div id="sub3_bbs2">
					<ul class="tit">
						<li class="wid1"><spring:message code="fap.resume.title" /></li>
						<li class="wid2">
							<input type="text" class="input" name="fap_resume_title" id="fap_resume_title" maxlength="40" placeholder="40<spring:message code="fap.placeholder.limit_characters" />">
						</li>
					</ul>					
				</div>			
			</div> <!-- <div id="userjoinBox"> -->
			<div class="userjoinBox">
				<div id="sub3_bbs2" class="basic_top">
					<h2><spring:message code="fap.resume.user_info" /></h2>
					<ul class="tit1">
						<li class="photo">
						</li>
						<li class="photo_file">
							<input type="file" id="fap_resume_pic" name="fap_resume_pic" accept="image/*">
						</li>
					</ul>
					<ul class="tit2 first">
						<li class="wid1"><code value="B3100"></code></li>
						<li class="wid2">
							<input type="hidden" name="resumeNameList[0].fap_resume_lang_gb" value="B3100">
							<input type="text" class="input1" name="resumeNameList[0].fap_resume_nm" id="fap_resume_nm" value="${detail.user_nm}" readonly>
						</li>
						<li class="wid3"><spring:message code="fap.resume.user_nationality" /></li>
						<li class="wid4">
							<input type="text" class="input1" id="nationality" name="fap_resume_nationality" maxlength="10" placeholder="10<spring:message code="fap.placeholder.limit_characters" />">
						</li>
					</ul>
					<ul class="tit2">
						<li class="wid1"><code value="B3102"></code></li>
						<li class="wid2">
							<input type="hidden" name="resumeNameList[2].fap_resume_lang_gb" value="B3102">
							<input type="text" class="input1" name="resumeNameList[2].fap_resume_nm" id="fap_resume_nm_ja" maxlength="10" placeholder="10<spring:message code="fap.placeholder.limit_characters" />">
						</li>
						<li class="wid3"><code value="B3103"></code></li>
						<li class="wid4">
							<input type="hidden" name="resumeNameList[3].fap_resume_lang_gb" value="B3103">
							<input type="text" class="input1" name="resumeNameList[3].fap_resume_nm" id="fap_resume_nm_yomi" maxlength="10" placeholder="10<spring:message code="fap.placeholder.limit_characters" />">
						</li>						
					</ul>
					<ul class="tit2">
						<li class="wid1"><code value="B3101"></code></li>
						<li class="wid2">
							<input type="hidden" name="resumeNameList[1].fap_resume_lang_gb" value="B3101">
							<input type="text" class="input1" name="resumeNameList[1].fap_resume_nm" id="fap_resume_nm_eng" maxlength="20" placeholder="20<spring:message code="fap.placeholder.limit_characters" />">
						</li>
						<li class="wid3"><spring:message code="fap.resume.user_dependent" /></li>
						<li class="wid4">
							<input type="text" class="input1" name="fap_resume_dependents" maxlength="10" value="0">
							<span class="hiddenTxt"><spring:message code="com.placeholder.people" /></span>
						</li>						
					</ul>
				</div>
				<div id="sub3_bbs2">
					<ul class="tit3">
						<li class="wid1"><spring:message code="fap.resume.user_birth" /></li>
						<c:set var="birth" value="${detail.user_birth}" />
						<li class="wid2_birth">
							<input type="text" class="input" name="fap_resume_birth" value="${fn:substring(birth,0,4) }" readonly>
							<span class="hiddenTxt"><spring:message code="com.placeholder.year" /></span>
						</li>
						<li class="wid2_birth">
							<input type="text" class="input" name="fap_resume_birth" value="${fn:substring(birth,5,7) }" readonly>
							<span class="hiddenTxt"><spring:message code="com.placeholder.month" /></span>
						</li>
						<li class="wid2_birth"> 
							<input type="text" class="input" name="fap_resume_birth" value="${fn:substring(birth,8,10) }"readonly>
							<span class="hiddenTxt"><spring:message code="com.placeholder.day" /></span>
						</li>
					</ul>
					<ul class="tit3">
						<li class="wid1"><spring:message code="fap.resume.user_address" /></li>
						<li class="wid2">
							<input type="text" class="input1" name="resumeAddrList[0].fap_resume_address" maxlength="100" placeholder="100<spring:message code="fap.placeholder.limit_characters" />">
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
							<span class="marital_radio">
								<label class="marital_label">
									<code value="B3001"></code>
								</label>
								<input type="radio" id="radio3" name="fap_resume_marital" value="B3001">
							</span>
							<span class="marital_radio">
								<label class="marital_label">
									<code value="B3000"></code>
								</label>													
								<input type="radio" id="radio4" name="fap_resume_marital" value="B3000">	
							</span>
						</li>
					</ul>
				</div><!-- <div id="sub3_bbs2"> -->
			</div> <!-- <div id="userjoinBox"> -->		

			<!-- ------------------------------------기본정보---------------------------------------------->	
			<div class="userjoinBox">
				<h2><spring:message code="fap.resume.edu_history" /></h2>
				<div class="resume_edu_wrap">
				</div><!-- <div id="sub3_bbs3"> -->
				<button type="button" class="btn-add" ng-click="addResumeEdu()"></button>
				<button type="button" class="btn-remove" ng-click="removeResumeEdu()"></button>
			</div><!-- <div id="userjoinBox"> -->
			<!-- ------------------------------------학력관련 교육이수 ---------------------------------------------->
			<div class="userjoinBox">
				<h2><spring:message code="fap.resume.career" /></h2>
				<div class="resume_crr_wrap">
				</div>
				<button type="button" class="btn-add" ng-click="addResumeCareer()"></button>
				<button type="button" class="btn-remove" ng-click="removeResumeCareer()"></button>
			</div>	
			<!-- ------------------------------------사회 경력 ---------------------------------------------->
			<div class="userjoinBox">
				<h2><spring:message code="fap.resume.certification" /></h2>
				<div class="resume_license_wrap">
				</div><!-- <div id="sub3_bbs3"> -->
				<button type="button" class="btn-add" ng-click="addLicense()"></button>
				<button type="button" class="btn-remove" ng-click="removeLicense()"></button>
			</div>
			<!-- ----------------------------자격(기술 및 외국어 역량 중심) --------------------------------------------->
			<div class="userjoinBox">
				<h2><spring:message code="fap.resume.talent" /></h2>
				<div class="resume_talent_wrap">
				</div><!-- <div id="sub3_bbs7"> -->
				<button type="button" class="btn-add" ng-click="addTalent()"></button>
				<button type="button" class="btn-remove" ng-click="removeTalent()"></button>
			</div><!-- <div id="userjoinBox"> -->				
			<!-- ----------------------------역량/재능(ICT, 외국어, 인간관계 등 업무 관련 상세) --------------------------------------------->
			<div class="userjoinBox">
				<h2><spring:message code="fap.resume.project_development_career" /></h2>
				<div class="resume_project_wrap">
				</div><!-- <div id="sub3_bbs3"> -->
				<button type="button" class="btn-add" ng-click="addProject()"></button>
				<button type="button" class="btn-remove" ng-click="removeProject()"></button>
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
							<textarea rows="4" cols="20" name="resumeProfileList[0].fap_resume_pr_content" maxlength="1000" placeholder="1000<spring:message code="fap.placeholder.limit_characters" />"></textarea>
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
							<textarea rows="4" cols="20" name="resumeProfileList[1].fap_resume_pr_content" maxlength="1000" placeholder="1000<spring:message code="fap.placeholder.limit_characters" />"></textarea>
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
							<textarea rows="4" cols="20" name="resumeProfileList[2].fap_resume_pr_content" maxlength="1000" placeholder="1000<spring:message code="fap.placeholder.limit_characters" />"></textarea>
						</li>						
					</ul>
				</div> <!-- <div id="sub3_bbs8"> -->
			</div><!-- <div id="userjoinBox"> -->				
			<!-- ----------------------------------------------자기소개서----------- --------------------------------------------->
			<div class="userjoinBox">
				<h2>
					<spring:message code="fap.resume.self_introduction_video_portfolio" />
				</h2>
				<span class="red">
					<spring:message code="fap.resume.fap.resume.self_introduction_text" />
				</span>
				<%-- <div id="sub3_bbs2">
					<ul class="tit3">
						<li class="wid1"><spring:message code="fap.resume.self_introduction_file" /><br><small><font color="red">(최대 3개까지)</font></small></li>
						<li class="wid2">
							<div class="btn-wrap">
								<button type="button" class="btn-add"></button>
								<button type="button" class="btn-remove"></button>
							</div>
						</li>
					</ul>
				</div>
				<div id="sub3_bbs2">
					<ul class="tit3">
						<li class="wid1"></li>
						<li class="wid2">
							<div class="file-wrap">
								<input type="text" class="input3" readonly="readonly">
								<button type="button" class="btn-file">찾아보기</button>
								<input type="file" class="hid-file">
							</div>
							<div class="file-wrap">
								<input type="text" class="input3" readonly="readonly">
								<button type="button" class="btn-file">찾아보기</button>
								<input type="file" class="hid-file">
							</div>
							<div class="file-wrap">
								<input type="text" class="input3" readonly="readonly">
								<button type="button" class="btn-file">찾아보기</button>
								<input type="file" class="hid-file">
							</div>
						</li>
					</ul>
				</div> --%>
			
				<div id="sub3_bbs9">
					<ul class="tit2">
						<li class="wid1"><spring:message code="fap.resume.self_introduction_file" /></li>	
						<li class="wid3">
							<input type="hidden" value="B3700" name="resumeFileList[0].fap_resume_file_gb">
							<input type="file" value="파일선택" id="resume_personal_video" name="resumeFileList[0].fap_resume_file">
						</li>
						<li class="wid4">
							<label for="resume_file_video"><font color="red"><small>● 파일명은 영어,숫자의 조합으로 하시길 권장합니다.</small></font></label>
						</li>				
					</ul>
					<ul class="tit2">
						<li class="wid1"></li>
						<li class="wid3 va-bt">
							<input type="hidden" value="B3701" name="resumeFileList[1].fap_resume_file_gb">
							<input type="file" value="파일선택" id="resume_personal_pr" name="resumeFileList[1].fap_resume_file">
						</li>	
						<li class="wid4">
							<label for="resume_file_pdf"><font color="red"><small>● 파일은 pdf, zip, mp4, wmv, mpg, mpeg, avi 만 가능합니다.</small></font></label><br>
							<span class="resume_file_tx_sub"><font color="red"><small>다른형태의 파일은 압축하여 올려주세요.</small></font></span>
						</li>												
					</ul>
					<ul class="tit2">
						<li class="wid1"></li>	
						<li class="wid3">
							<input type="hidden" value="B3702" name="resumeFileList[2].fap_resume_file_gb">
							<input type="file" value="파일선택" id="resume_personal_project" name="resumeFileList[2].fap_resume_file">
						</li>		
						<li class="wid4">
							<label for="resume_file_project"><font color="red"><small>● 각 파일은 최대 100M 까지 가능합니다.</small></font></label>
						</li>			
					</ul>	
					<ul class="tit2">
						<li class="wid1"><spring:message code="fap.resume.self_introduction_url" /></li>
						<li class="wid2">
							<font color="red"><small>http:// 혹은 https:// 로 시작해야 합니다.</small></font><br>
							<input type="text" class="input1" id="fap_resume_url" name="fap_resume_url" maxlength="100" placeholder="100<spring:message code="fap.placeholder.limit_characters" />  ex) http://www.bridge.career " value="http://">
						</li>
					</ul>		
				</div> 
			
				
			<%-- 	<div id="sub3_bbs9">
					<ul class="tit2">
						<li class="wid1"><code value="B3700"></code></li>	
						<li class="wid2">
							<input type="hidden" value="B3700" name="resumeFileList[0].fap_resume_file_gb">
							<input type="file" value="파일선택" id="resume_personal_video" name="resumeFileList[0].fap_resume_file">
							<label for="resume_file_video"><spring:message code="fap.placeholder.video_size" /></label>
						</li>					
					</ul>
					<ul class="tit2">
						<li class="wid1"><code value="B3701"></code></li>
						<li class="wid2">
							<input type="hidden" value="B3701" name="resumeFileList[1].fap_resume_file_gb">
							<input type="file" value="파일선택" id="resume_personal_pr" name="resumeFileList[1].fap_resume_file">
							<label for="resume_file_pdf"><spring:message code="fap.placeholder.file_size" /></label>
						</li>													
					</ul>
					<ul class="tit2">
						<li class="wid1"><code value="B3702"></code></li>	
						<li class="wid2">
							<input type="hidden" value="B3702" name="resumeFileList[2].fap_resume_file_gb">
							<input type="file" value="파일선택" id="resume_personal_project" name="resumeFileList[2].fap_resume_file">
							<label for="resume_file_project"><spring:message code="fap.placeholder.video_size" /></label>
						</li>					
					</ul>	
					<ul class="tit2">
						<li class="wid1"><spring:message code="fap.resume.self_introduction_url" /></li>
						<li class="wid2">
							<input type="text" class="input1" name="resumeAddrList[0].fap_resume_address" maxlength="100" placeholder="100<spring:message code="fap.placeholder.limit_characters" />">
						</li>
					</ul>		
				</div>  --%>
				<!-- <div id="sub3_bbs9"> -->
				
			</div>
			<div class="userjoinBox">
				<div id="sub3_bbsbtn">
					<input type="button" class="resume_submit" id="resume_submit_btn" value="생성하기" onclick="formCheck();">
					<input type="button" class="resume_list" id="resume_list_btn" value="목록으로" onclick="readList();">
				</div> <!-- <div id="sub3_bbsbtn"> -->
			</div><!-- <div id="userjoinBox"> -->				
			<!-- ----------------------------------------------개인 동영상 및 포트폴리오 파일----------- --------------------------------------------->
		</form>
		</div>
		</div>
		<%@include file="../common_footer_fap.jsp"%>
	</body>
</html>
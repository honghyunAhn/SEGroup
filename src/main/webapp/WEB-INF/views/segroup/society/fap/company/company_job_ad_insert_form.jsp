<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%-- <%
 response.setHeader("Pragma", "No-cache"); 
 response.setDateHeader("Expires", 0); 
 response.setHeader("Cache-Control", "no-Cache"); 
%> --%>
<script src="<c:url value="/resources/segroup/js/jquery-3.1.1.js" />"></script>
<script src="<c:url value="/resources/segroup/js/jquery-ui.js" />"></script>
<script src="<c:url value="/resources/segroup/js/angular.min.js" />"></script>
<script src="<c:url value="/resources/segroup/js/datepicker.js" />"></script>
<script src="<c:url value="/resources/segroup/society/fap/js/scrollspy.js" />"></script>
<script src="<c:url value="/resources/segroup/society/fap/js/lodash.js" />"></script>

<!-- 추가한 css -->
<link rel="stylesheet" type="text/css" href="/resources/segroup/society/fap/css/default.css" />
<link type="text/css" rel="stylesheet" href="/resources/segroup/society/fap/css/popModal.css">
<link type="text/css" rel="stylesheet" href="/resources/segroup/society/fap/css/scrollspy.css">
<title>Bridge Job Fair</title>
<script type="text/javascript">
	$(function() {
		realTimeValidation();
		_insert_form = _.debounce(function(){
			alert('<spring:message code="fap.jobad.insert.comment" javaScriptEscape="true" />');
			$('#insert_form').submit(); 
		},500,true);
		
		//기업소개 파일 폼체크 onclick 이벤트
		$("#job_ad_file_video").change( function() {
			var file = $(this).val();
			
			if(file == "") {
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
		
		//기업소개 파일 폼체크 onclick 이벤트
		$("#job_ad_file_img").change( function() {
			var file = $(this).val();
			
			if(file == "") {
				$(this).val("");
				return;
			} 
			//확장자 체크
			if( extension_check_img(file) ) {
				
			} else {
				alert('<spring:message code="fap.err.image_type" javaScriptEscape="true" />');
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
				alert('<spring:message code="fap.err.photo_size" javaScriptEscape="true" />');
				$(this).val("");
			}
			
		});
		
		//기업소개 파일 폼체크 onclick 이벤트
		$("#job_ad_file_pdf").change( function() {
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
			
			//20MB
			if(file_size_check(size, 20)){
				//alert("size ok");
			}else{
				alert('<spring:message code="fap.err.pdf_size" javaScriptEscape="true" />');
				$(this).val("");
			}
			
		});
		
		
		///////////////////////////////////////////////////////////////////
		angular.element("#company_job_ad_body").scope().initAccordion();
		///////////////////////////////////////////////////////////////////
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
	//등록및 임시저장시 title 폼체크하는 함수(사용중)
	function form_check(flag) {
		//flag 1:등록,2:임시저장
		
		// 등록,임시저장 둘다 체크해야 하는 항목 
		// fap_job_ad_title, 제목
		var fap_job_ad_title = $("#fap_job_ad_title").val();
		if(fap_job_ad_title == null || fap_job_ad_title == ''){
			
			alert('<spring:message code="fap.err.title_input" />');
			$("#fap_job_ad_title").focus();
			return false;
		}
	
		// blurCurrency
		$.each($(".currency"),function(index,item){
			var commaValue = angular.element(item).val();
			
			angular.element(item).val(commaValue.replace(/,/g, ''));
		});
		
		$("input[type='number']").each(function(index, item){
			var value = $(item).val();
			if(value == null || value == ""){
				
				$(item).val("0");
			}
			
		})
	
		if(flag == 1){
			//등록 일 경우만 체크하는 항목
			
			//기업 일문명
			var fap_job_comp_ja_nm = $("#fap_job_comp_ja_nm").val();
			if(fap_job_comp_ja_nm == null || fap_job_comp_ja_nm == ''){
				
				alert('<spring:message code="fap.err.comp_ja_nm" />');
				$("#fap_job_comp_ja_nm").focus();
				return false;
			}
			//기업 영문명
			var fap_job_comp_en_nm = $("#fap_job_comp_en_nm").val();
			if(fap_job_comp_en_nm == null || fap_job_comp_en_nm == ''){
				
				alert('<spring:message code="fap.err.comp_en_nm" />');
				$("#fap_job_comp_en_nm").focus();
				return false;
			}
			//기업 주요사업
			var fap_job_ad_major_business = $("#fap_job_ad_major_business").val();
			if(fap_job_ad_major_business == null || fap_job_ad_major_business == ''){
				
				alert('<spring:message code="fap.err.comp_major_bus" />');
				$("#fap_job_ad_major_business").focus();
				return false;
			}
			//기업 설립일
			var fap_job_ad_est_dt = $("#fap_job_ad_est_dt").val();
			if(fap_job_ad_est_dt == null || fap_job_ad_est_dt == ''){
				
				alert('<spring:message code="fap.err.comp_est_dt" />');
				$("#fap_job_ad_est_dt").focus();
				return false;
			}
			//기업 자본금
			var fap_job_ad_stock = $("#fap_job_ad_stock").val();
			if(fap_job_ad_stock == 0){
				
				alert('<spring:message code="fap.err.comp_stock" />');
				$("#fap_job_ad_stock").focus();
				return false;
			}
			//기업 3년간 매출
			var fap_job_ad_3years_avg_sales = $("#fap_job_ad_3years_avg_sales").val();
			if(fap_job_ad_3years_avg_sales == 0){
				
				alert('<spring:message code="fap.err.comp_recent_sales" />');
				$("#fap_job_ad_3years_avg_sales").focus();
				return false;
			}
			//기업 사원수
			var fap_job_ad_employee_num = $("#fap_job_ad_employee_num").val();
			if(fap_job_ad_employee_num < 1){
				
				alert('<spring:message code="fap.err.comp_emp_num" />');
				$("#fap_job_ad_employee_num").focus();
				return false;
			}
			//기업 우편번호
			var fap_job_ad_postcode = $("#fap_job_ad_postcode").val();
			if(fap_job_ad_postcode == null || fap_job_ad_postcode == ''){
				
				alert('<spring:message code="fap.err.comp_postcode" />');
				$("#fap_job_ad_postcode").focus();
				return false;
			}
			//기업 주소
			var fap_job_ad_address = $("#fap_job_ad_address").val();
			if(fap_job_ad_address == null || fap_job_ad_address == ''){
				
				alert('<spring:message code="fap.err.comp_address" />');
				$("#fap_job_ad_address").focus();
				return false;
			}
			//모집직종 체크
			if($("input:radio[name='fap_job_ad_category_type']").is(":checked") == false){
				alert('<spring:message code="fap.err.job_ad_occupation" />');
				return false;
			}
			//모집직종 체크
			var categoryAry =  $('#job_category_div').find('input:checkbox');
			var categoryCkFlag = false;
			for (var i=0; i<categoryAry.length; i++) {
				if($(categoryAry[i]).is(':checked') == true){
					categoryCkFlag = true;
					break;
				}
			}
			if(categoryCkFlag == false){
				alert('<spring:message code="fap.err.job_ad_occupation" />'); 
				$('#se_input_ck_autofocus').focus(); 
				return false;
			}
			
			//입사 예정일
			var jobJoinAry =  $('#fap_job_join_dt_gb_div').find('input');
			var joinCkFlag = false;
			for (var i=0; i<categoryAry.length; i++) {
				if($(jobJoinAry[i]).is(':checked') == true){
					joinCkFlag = true;
					break;
				}
			}
			if(joinCkFlag == false){
				alert('<spring:message code="fap.err.job_ad_ja_nm" />'); 
				return false;
			}
			
			//고용형태 체크
			if($("input:radio[name='fap_job_ad_hire_type']").is(":checked") == false){
				alert('<spring:message code="fap.err.job_ad_hire_type" />');
				return false;
			}
			
			//채용예정인원
			var fap_job_ad_recruit_num = $("#fap_job_ad_recruit_num").val();
			if(fap_job_ad_recruit_num < 1){
				alert('<spring:message code="fap.err.job_ad_recruit_num" />');
				$("#fap_job_ad_recruit_num").focus();
				return false;
			}
			
			//근무 예정지
			var workplaceAry =  $('#fap_job_workplace_gb_div').find('span');
			var workplaceCkFlag = false;
			for (var i=0; i<workplaceAry.length; i++) {
				if($(workplaceAry[i]).attr('class') == 'job-check long-check ck'){
					workplaceCkFlag = true;
					break;
				}
			}
			if(workplaceCkFlag == false){
				alert('<spring:message code="fap.err.job_ad_workplace" />'); 
				return false;
			}
			
			//시용기간 
			if($("input:radio[name='fap_job_ad_intern']").is(":checked") == false){
				alert('<spring:message code="fap.err.job_ad_intern_ck" />');
				return false;
			}
			
			//기숙사 유무
			if($("input:radio[name='fap_job_ad_isdorm']").is(":checked") == false){
				alert('<spring:message code="fap.err.job_ad_dorm_ck" />');
				return false;
			}
			//기본급
			var basic_pay_input = $("#basic_pay_input").val();
			if(basic_pay_input == 0){
				alert('<spring:message code="fap.err.job_ad_basic_sal" />');
				$("#basic_pay_input").focus();
				return false;
			}
			
			//교통비
			var transportCkAry =  $('#transport_ck_div').find('span');
			var transportCkFlag = false;	
			for (var i = 0; i < transportCkAry.length; i++) {
				if($(transportCkAry[i]).attr('class') == 'job-radio transport yes ck' || $(transportCkAry[i]).attr('class') == 'job-radio transport no ck'){
					transportCkFlag = true;
					break;
				}
			}
			if(transportCkFlag == false){
				alert('<spring:message code="fap.err.job_ad_transport_fee_ck" />'); 
				return false;
			}
			
			//상여
			var incentiveCkAry =  $('#incentive_ck_div').find('span');
			var incentiveCkFlag = false;	
			for (var i = 0; i < incentiveCkAry.length; i++) {
				if($(incentiveCkAry[i]).attr('class') == 'job-radio incentive yes ck' || $(incentiveCkAry[i]).attr('class') == 'job-radio incentive no ck'){
					incentiveCkFlag = true;
					break;
				}
			}
			if(incentiveCkFlag == false){
				alert('<spring:message code="fap.err.job_ad_incentive_ck" />'); 
				return false;
			}
			
			//채용전형 
			var hidden_recruit_pcs_ck = $('#hidden_recruit_pcs_ck').val();
			if(hidden_recruit_pcs_ck == undefined){
				alert('<spring:message code="fap.err.job_ad_recruit_type" />');
				return false;
			}
			
			//성적공개
			if($("input:radio[name='fap_job_ad_open_grade']").is(":checked") == false){
				alert('<spring:message code="fap.err.job_ad_open_grade_ck" />');
				return false;
			}
			
			//재류자격신청시 정보처리기사는 필수인가
			if($("input:radio[name='fap_job_ad_qual_dpe']").is(":checked") == false){
				alert('<spring:message code="fap.err.fap_job_ad_terms_dpe_ck" />');
				return false;
			}
			
			//정보처리기사는 채용 필수 조건인가
			if($("input:radio[name='fap_job_ad_terms_dpe']").is(":checked") == false){
				alert('<spring:message code="fap.err.fap_job_ad_qual_dpe_ck" />');
				return false;
			}
			
			//지원자 재지원 가능 여부
			if($("input:radio[name='fap_job_ad_overlap']").is(":checked") == false){
				alert('<spring:message code="fap.err.fap_job_ad_overlap_ck" />');
				return false;
			}
			
			// 과정 수료 동의
			if($('#fap_job_ad_coc_agree').is(':checked') == false){
				alert('<spring:message code="fap.err.check_coc_agree" />');
				return false;
			}
			
			_insert_form();	//더블클릭 방지하는 서브밋(임시저장은 temp_save() 함수에서 실행)
		}else if(flag == 2){
			//임시저장 일 경우만 체크하는 항목
		}
	}
	
	
	var myApp = angular.module('myapp', []);
	
	myApp.controller('JobAdController',['$scope','$compile', function($scope, $compile) {
		
		var comp_info = '${comp_info}';
		$scope.comp_info = JSON.parse(comp_info);
		
		//주요업무정보
		$scope.addWork = function() {
			
			var count = $(".work-type-plus .work-type-content").length + 1;
			var context = '';
			context +='<div class="work-type-content">';
			context +='<div class="job-ad-contents">';
			context +='<div class="job-ad-row">';
			context +='<div class="job-ad-lt">';
			context +='</div>';
			context +='<div class="job-ad-rt">';
			context +='<div class="job-ad-dropdown">';
			context +='<div class="job-ad-select">';
			context +='<button type="button" class="job-ad-select-btn"><code value="C0300"></code></button>';
			context +='<input type="hidden" id="work-gb" name="jobWorkList['+count+'].fap_job_work_gb" value="C0300">';
			context +='</div>';
			context +='<div class="job-ad-select-option">';
			context +='<ul class="option-list">';
			context +='<li class="work-type selected">';
			context +='<button type="button" work-code="C0300"><code value="C0300"></code></button>';
			context +='</li>';
			context +='<li class="work-type">';
			context +='<button type="button" work-code="C0301"><code value="C0301"></code></button>';
			context +='</li>';
			context +='<li class="work-type">';
			context +='<button type="button" work-code="C0302"><code value="C0302"></code></button>';
			context +='</li>';
			context +='<li class="work-type">';
			context +='<button type="button" work-code="C0304"><code value="C0304"></code></button>';
			context +='</li>';
			context +='<li class="work-type">';
			context +='<button type="button" work-code="C0305"><code value="C0305"></code></button>';
			context +='</li>';
			context +='<li class="work-type">';
			context +='<button type="button" work-code="C0306"><code value="C0306"></code></button>';
			context +='</li>';
			context +='<li class="work-type">';
			context +='<button type="button" work-code="C0307"><code value="C0307"></code></button>';
			context +='</li>';
			context +='<li class="work-type">';
			context +='<button type="button" work-code="C0308"><code value="C0308"></code></button>';
			context +='</li>';
			context +='<li class="work-type">';
			context +='<button type="button" work-code="C0309"><code value="C0309"></code></button>';
			context +='</li>';
			context +='<li class="work-type">';
			context +='<button type="button" work-code="C0303"><code value="C0303"></code></button>';
			context +='</li>';
			context +='</ul>';
			context +='</div>';
			context +='</div>';
			context +='</div>';
			context +='</div>';
			context +='<div class="job-ad-row m10">';
			context +='<div class="job-ad-lt bnt-lt">';
			context +='</div>';
			context +='<div class="job-ad-rt">';
			context +='<textarea rows="4" cols="20" name="jobWorkList['+count+'].fap_job_work_dtl" maxlength="1000" placeholder="1000<spring:message code="fap.placeholder.limit_characters" />"></textarea>';
			context +='</div>';
			context +='</div>';
			context +='</div>';
			context +='</div>';
			
			$(".work-type-plus").append($compile(context)($scope));
			//실시간 유효성 검사
			realTimeValidation();
			work_event();
			
		}
		
		$scope.removeWork = function() {
			$(".work-type-plus .work-type-content:last").remove();
		}
		
		//우대사항
		$scope.addPref = function() {
			var count = $(".preferences-type-plus .preferences-type-content").length + 1;
			var context = '';
			context +='<div class="preferences-type-content">';
			context +='<div class="job-ad-contents">';
			context +='<div class="job-ad-row">';
			context +='<div class="job-ad-lt">';
			context +='</div>';
			context +='<div class="job-ad-rt">';
			context +='<div class="job-ad-dropdown">';
			context +='<div class="job-ad-select">';
			context +='<button type="button" class="job-ad-select-btn"><code value="C4106"></code></button>';
			context +='<input type="hidden" id="preferences-gb" name="jobPrefList['+count+'].fap_job_pref_gb" value="C4106">';
			context +='</div>';
			context +='<div class="job-ad-select-option">';
			context +='<ul class="option-list">';
			context +='<li class="preferences-type selected">';
			context +='<button type="button" preferences-code="C4106"><code value="C4106"></code></button>';
			context +='</li>';
			context +='<li class="preferences-type">';
			context +='<button type="button" preferences-code="C4100"><code value="C4100"></code></button>';
			context +='</li>';
			context +='<li class="preferences-type">';
			context +='<button type="button" preferences-code="C4101"><code value="C4101"></code></button>';
			context +='</li>';
			context +='<li class="preferences-type">';
			context +='<button type="button" preferences-code="C4102"><code value="C4102"></code></button>';
			context +='</li>';
			context +='<li class="preferences-type">';
			context +='<button type="button" preferences-code="C4103"><code value="C4103"></code></button>';
			context +='</li>';
			context +='<li class="preferences-type">';
			context +='<button type="button" preferences-code="C4104"><code value="C4104"></code></button>';
			context +='</li>';
			context +='<li class="preferences-type">';
			context +='<button type="button" preferences-code="C4105"><code value="C4105"></code></button>';
			context +='</li>';
			context +='</ul>';
			context +='</div>';
			context +='</div>';
			context +='</div>';
			context +='</div>';
			context +='<div class="job-ad-row m10">';
			context +='<div class="job-ad-lt bnt-lt">';
			context +='</div>';
			context +='<div class="job-ad-rt">';
			context +='<textarea rows="4" cols="20" name="jobPrefList['+count+'].fap_job_pref_dtl" maxlength="200" placeholder="200<spring:message code="fap.placeholder.limit_characters" />"></textarea>';
			context +='</div>';
			context +='</div>';
			context +='</div>';
			context +='</div>';
			
			$(".preferences-type-plus").append($compile(context)($scope));
			//실시간 유효성 검사
			realTimeValidation();
			preferences_event();
			
		}
		
		$scope.removePref = function() {
			$(".preferences-type-plus .preferences-type-content:last").remove();
		}
		
		//채용전형
		$scope.addRecruitPcs = function() {
			
			var count = $(".accordion .accordion-header").length;
			var context = '';
			context += '<div class="accordion-header">';
			context += '<input type="hidden" id="hidden_recruit_pcs_ck" name="jobRecruitPcsList['+count+'].fap_job_recruit_pcs_od" value="'+(count+1)+'">';
			context += '<code value="C2500"></code>';
			context += '</div>';
			context += '<div class="ui-accordion-content">';
			context += '<div class="ui-accordion-content-header">';
			context += '<div class="job-ad-row">';
			context += '<div class="job-ad-lt">';
			context += '<spring:message code="fap.jobad.recruit_pcs_type" />';
			context += '</div>';
			context += '<div class="job-ad-rt">';
			context += '<div class="job-ad-dropdown">';
			context += '<div class="job-ad-select">';
			context += '<button type="button" class="job-ad-select-btn"><code value="C2500"></code></button>';
			context += '<input type="hidden" id="recruit-gb" name="jobRecruitPcsList['+count+'].fap_job_recruit_pcs_gb" value="C2500">';
			context += '</div>';
			context += '<div class="job-ad-select-option">';
			context += '<ul class="option-list">';
			context += '<li class="recruit-type selected">';
			context += '<button type="button" recruit-code="C2500"><code value="C2500"></code></button>';
			context += '</li>';
			context += '<li class="recruit-type">';
			context += '<button type="button" recruit-code="C2501"><code value="C2501"></code></button>';
			context += '</li>';
			context += '<li class="recruit-type">';
			context += '<button type="button" recruit-code="C2502"><code value="C2502"></code></button>';
			context += '</li>';
			context += '<li class="recruit-type">';
			context += '<button type="button" recruit-code="C2503"><code value="C2503"></code></button>';
			context += '</li>';
/* 			context += '<li class="recruit-type">';
			context += '<button type="button" recruit-code="C2504"><code value="C2504"></code></button>';
			context += '</li>'; */
			context += '</ul>';
			context += '</div>';
			context += '</div>';
			context += '</div>';
			context += '</div>';
			context += '<div class="job-ad-row">';
			context += '<div class="job-ad-lt">';
			context += '<spring:message code="fap.jobad.recruit_pcs_detail" />';
			context += '</div>';
			context += '<div class="job-ad-rt">';
			context += '<textarea rows="4" cols="20" name="jobRecruitPcsList['+count+'].fap_job_recruit_pcs_dtl" maxlength="400" placeholder="400<spring:message code="fap.placeholder.limit_characters" />"></textarea>';
			context += '</div>';
			context += '</div>';
			context += '</div>';
			context += '</div>';
			
			$(".accordion:last").append($compile(context)($scope));
			//실시간 유효성 검사
			realTimeValidation();
			//전형일정
			recruit_event();
			
			//아코디언 설정
			$scope.initAccordion();
			
		}
		
		$scope.removeRecruitPcs = function() {
				$(".accordion .accordion-header:last").remove();
				$(".accordion .ui-accordion-content:last").remove();
		}
		
		//채용 전형 - 시험전형
		$scope.addRecruitExam = function(selected_obj) {
			
			var count =  selected_obj.closest(".ui-accordion-content").index(".ui-accordion-content");
			
			var context = '';
			context += '<div class="ui-accordion-content-body">';
			context += '<div class="job-ad-row">';
			context += '<div class="job-ad-lt">';
			context += '<spring:message code="fap.jobad.exam_type" />';
			context += '</div>';
			context += '<div class="job-ad-rt">';
			context += '<div class="job-ad-dropdown">';
			context += '<div class="job-ad-select">';
			context += '<button type="button" class="job-ad-select-btn"><code value="C2600"></code></button>';
			context += '<input type="hidden" id="recruit-exam-type" name="jobRecruitPcsList['+count+'].jobExam.fap_job_exam_gb" value="C2600">';
			context += '</div>';
			context += '<div class="job-ad-select-option">';
			context += '<ul class="option-list">';
			context += '<li class="recruit-exam-type selected">';
			context += '<button type="button" recruit-exam-type-code="C2600"><code value="C2600"></code></button>';
			context += '</li>';
			context += '<li class="recruit-exam-type">';
			context += '<button type="button" recruit-exam-type-code="C2601"><code value="C2601"></code></button>';
			context += '</li>';
			context += '</ul>';
			context += '</div>';
			context += '</div>';
			context += '</div>';
			context += '</div>';
			context += '<div class="job-ad-row">';
			context += '<div class="job-ad-lt">';
			context += '<spring:message code="fap.jobad.exam_obj_type" />';
			context += '</div>';
			context += '<div class="job-ad-rt recruit-row">';
			context += '<div class="job-ad-dropdown">';
			context += '<div class="job-ad-select">';
			context += '<button type="button" class="job-ad-select-btn"><code value="C2700"></code></button>';
			context += '<input type="hidden" id="recruit-exam-obj-type" name="jobRecruitPcsList['+count+'].jobExam.fap_job_exam_obj" value="C2700">';
			context += '</div>';
			context += '<div class="job-ad-select-option">';
			context += '<ul class="option-list">';
			context += '<li class="recruit-exam-obj-type selected">';
			context += '<button type="button" recruit-exam-obj-type-code="C2700"><code value="C2700"></code></button>';
			context += '</li>';
			context += '<li class="recruit-exam-obj-type">';
			context += '<button type="button" recruit-exam-obj-type-code="C2701"><code value="C2701"></code></button>';
			context += '</li>';
			context += '<li class="recruit-exam-obj-type etc">';
			context += '<button type="button" recruit-exam-obj-type-code="C2702"><code value="C2702"></code></button>';
			context += '</li>';
			context += '</ul>';
			context += '</div>';
			context += '</div>';
			context += '<div class="sub-area display">';
			context += '<div class="sub-area-inner">';
			context += '<div class="bar-inner">';
			context += '<h5 class="inner-title"><spring:message code="fap.jobad.exam_obj" /></h5>';
			context += '<span class="inner-item">';
			context += '<textarea rows="4" cols="20" name="jobRecruitPcsList['+count+'].jobExam.jobExamObjEtc.fap_job_exam_obj_etc_dtl" maxlength="150"></textarea>';
			context += '</span>';
			context += '</div>';
			context += '</div>';
			context += '</div>';
			context += '</div>';
			context += '</div>';
			context += '<div class="job-ad-row">';
			context += '<div class="job-ad-lt doubleline">';
			context += '<spring:message code="fap.comp.exam_mail" />';
			context += '</div>';
			context += '<div class="job-ad-rt">';
			context += '<div class="job-ad-dropdown">';
			context += '<div class="job-ad-select">';
			context += '<button type="button" class="job-ad-select-btn"><code value="C2800"></code></button>';
			context += '<input type="hidden" id="recruit-exam-email-type" name="jobRecruitPcsList['+count+'].jobExam.fap_job_exam_mail" value="C2800">';
			context += '</div>';
			context += '<div class="job-ad-select-option">';
			context += '<ul class="option-list">';
			context += '<li class="recruit-exam-email-type selected">';
			context += '<button type="button" recruit-exam-type-code="C2800"><code value="C2800"></code></button>';
			context += '</li>';
			context += '<li class="recruit-exam-email-type">';
			context += '<button type="button" recruit-exam-type-code="C2801"><code value="C2801"></code></button>';
			context += '</li>';
			context += '</ul>';
			context += '</div>';
			context += '</div>';
			context += '</div>';
			context += '</div>';
			context += '<div class="job-ad-row">';
			context += '<div class="job-ad-lt">';
			context += '<spring:message code="fap.comp.exam_sv" />';
			context += '</div>';
			context += '<div class="job-ad-rt recruit-row">';
			context += '<div class="job-ad-dropdown">';
			context += '<div class="job-ad-select">';
			context += '<button type="button" class="job-ad-select-btn"><code value="C2900"></code></button>';
			context += '<input type="hidden" id="recruit-exam-sv-type" name="jobRecruitPcsList['+count+'].jobExam.fap_job_exam_sv" value="C2900">';
			context += '</div>';
			context += '<div class="job-ad-select-option">';
			context += '<ul class="option-list">';
			context += '<li class="recruit-exam-sv-type selected">';
			context += '<button type="button" recruit-exam-sv-code="C2900"><code value="C2900"></code></button>';
			context += '</li>';
			context += '<li class="recruit-exam-sv-type">';
			context += '<button type="button" recruit-exam-sv-code="C2901"><code value="C2901"></code></button>';
			context += '</li>';
			context += '<li class="recruit-exam-sv-type">';
			context += '<button type="button" recruit-exam-sv-code="C2902"><code value="C2902"></code></button>';
			context += '</li>';
			context += '<li class="recruit-exam-sv-type etc">';
			context += '<button type="button" recruit-exam-sv-code="C2903"><code value="C2903"></code></button>';
			context += '</li>';
			context += '</ul>';
			context += '</div>';
			context += '</div>';
			context += '<div class="sub-area display">';
			context += '<div class="sub-area-inner">';
			context += '<div class="bar-inner">';
			context += '<h5 class="inner-title"><spring:message code="fap.jobad.exam_obj" /></h5>';
			context += '<span class="inner-item">';
			context += '<textarea rows="4" cols="20" name="jobRecruitPcsList['+count+'].jobExam.jobExamSvEtc.fap_job_exam_sv_etc_dtl" maxlength="150"></textarea>';
			context += '</span>';
			context += '</div>';
			context += '</div>';
			context += '</div>';
			context += '</div>';
			context += '</div>';
			context += '<div class="job-ad-row">';
			context += '<div class="job-ad-lt">';
			context += '<spring:message code="fap.comp.exam_need" />';
			context += '</div>';
			context += '<div class="job-ad-rt recruit-row">';
			context += '<div class="job-ad-dropdown">';
			context += '<div class="job-ad-select">';
			context += '<button type="button" class="job-ad-select-btn"><code value="C3000"></code></button>';
			context += '<input type="hidden" id="recruit-exam-need-type" name="jobRecruitPcsList['+count+'].jobExam.fap_job_exam_need" value="C3000">';
			context += '</div>';
			context += '<div class="job-ad-select-option">';
			context += '<ul class="option-list">';
			context += '<li class="recruit-exam-need-type selected">';
			context += '<button type="button" recruit-exam-need-code="C3000"><code value="C3000"></code></button>';
			context += '</li>';
			context += '<li class="recruit-exam-need-type">';
			context += '<button type="button" recruit-exam-need-code="C3001"><code value="C3001"></code></button>';
			context += '</li>';
			context += '<li class="recruit-exam-need-type etc">';
			context += '<button type="button" recruit-exam-need-code="C3002"><code value="C3002"></code></button>';
			context += '</li>';
			context += '</ul>';
			context += '</div>';
			context += '</div>';
			context += '<div class="sub-area display">';
			context += '<div class="sub-area-inner">';
			context += '<div class="bar-inner">';
			context += '<h5 class="inner-title"><spring:message code="fap.jobad.exam_obj" /></h5>';
			context += '<span class="inner-item">';
			context += '<textarea rows="4" cols="20" name="jobRecruitPcsList['+count+'].jobExam.jobExamNeedEtc.fap_job_exam_need_etc_dtl" maxlength="150"></textarea>';
			context += '</span>';
			context += '</div>';
			context += '</div>';
			context += '</div>';
			context += '</div>';
			context += '</div>';
			context += '<div class="job-ad-row">';
			context += '<div class="job-ad-lt">';
			context += '<spring:message code="fap.comp.exam_type_gb" />';
			context += '</div>';
			context += '<div class="job-ad-rt check-row">';
			context += '<span class="job-check long-check">';
			context += '<label class="job-check-label">';
			context += '<code value="C3200"></code>';
			context += '</label>';
			context += '<input type="checkbox" name="jobRecruitPcsList['+count+'].jobExam.jobExamTypeList[0].fap_job_exam_type_gb" value="C3200">';
			context += '</span>';
			context += '<span class="job-check long-check">';
			context += '<label class="job-check-label">';
			context += '<code value="C3201"></code>';
			context += '</label>';
			context += '<input type="checkbox" name="jobRecruitPcsList['+count+'].jobExam.jobExamTypeList[1].fap_job_exam_type_gb" value="C3201">';
			context += '</span>';
			context += '<span class="job-check long-check">';
			context += '<label class="job-check-label">';
			context += '<code value="C3202"></code>';
			context += '</label>';
			context += '<input type="checkbox" name="jobRecruitPcsList['+count+'].jobExam.jobExamTypeList[2].fap_job_exam_type_gb" value="C3202">';
			context += '</span>';
			context += '<span class="job-check long-check">';
			context += '<label class="job-check-label">';
			context += '<code value="C3203"></code>';
			context += '</label>';
			context += '<input type="checkbox" name="jobRecruitPcsList['+count+'].jobExam.jobExamTypeList[3].fap_job_exam_type_gb" value="C3203">';
			context += '</span>';
			context += '</div>';
			context += '</div>';
			context += '<div class="job-ad-row">';
			context += '<div class="job-ad-lt">';
			context += '</div>';
			context += '<div class="job-ad-rt check-row">';
			context += '<span class="job-check long-check">';
			context += '<label class="job-check-label">';
			context += '<code value="C3204"></code>';
			context += '</label>';
			context += '<input type="checkbox" name="jobRecruitPcsList['+count+'].jobExam.jobExamTypeList[4].fap_job_exam_type_gb" value="C3204">';
			context += '</span>';
			context += '<span class="job-check long-check">';
			context += '<label class="job-check-label">';
			context += '<code value="C3205"></code>';
			context += '</label>';
			context += '<input type="checkbox" name="jobRecruitPcsList['+count+'].jobExam.jobExamTypeList[5].fap_job_exam_type_gb" value="C3205">';
			context += '</span>';
			context += '</div>';
			context += '</div>';
			context += '<div class="job-ad-row m50">';
			context += '<div class="job-ad-lt">';
			context += '<spring:message code="fap.comp.exam_tm" />';
			context += '</div>';
			context += '<div class="job-ad-rt">';
			context += '<input type="text" name="jobRecruitPcsList['+count+'].jobExam.fap_job_exam_tm" maxlength="50">';
			context += '<span class="hiddenTx">分</span>';
			context += '</div>';
			context += '</div>';
			context += '<div class="job-ad-row">';
			context += '<div class="job-ad-lt">';
			context += '<spring:message code="fap.comp.exam_file" />';
			context += '</div>';
			context += '<div class="job-ad-rt">';
			context += '<input type="file" id ="fap_job_exam_file" name="jobRecruitPcsList[' + count + '].jobExam.jobExamFile.fap_job_exam_file">';
			context += '<label for="fap_job_exam_file"><spring:message code="fap.placeholder.file_size" /></label>';
			context += '</div>';
			context += '</div>';
			context += '</div>';
			
			selected_obj.closest(".ui-accordion-content-header").nextAll(".ui-accordion-content-body").empty();
			selected_obj.closest(".ui-accordion-content-header").after($compile(context)($scope));
			//실시간 유효성 검사
			realTimeValidation();
			//시험전형 - 시험종류
			recruit_exam_type_event();
			
			//시험전형 - 시험 대상자
			recruit_exam_obj_type_event();
			
			//시험전형 - 시험 대상자 이메일 필요 여부
			recruit_exam_email_type_event();
			
			//시험전형 - 시험 감독 여부
			recruit_exam_sv_type_event();
			
			//시험전형 - 시험 준비물 여부
			recruit_exam_need_type_event();
			
			//체크박스 공통 처리
			checkbox_event();
			
		}
		
		//채용 전형 - 면접전형
		$scope.addRecruitInterview = function(selected_obj) {
			
			var count = selected_obj.closest(".ui-accordion-content").index(".ui-accordion-content");
			
			var context = '<div class="ui-accordion-content-body">';
			context += '<div class="job-ad-row">';
			context += '<div class="job-ad-lt">';
			context += '<spring:message code="fap.comp.itv_gb" />';
			context += '</div>';
			context += '<div class="job-ad-rt recruit-row">';
			context += '<div class="job-ad-dropdown">';
			context += '<div class="job-ad-select">';
			context += '<button type="button" class="job-ad-select-btn"><code value="C3300"></code></button>';
			context += '<input type="hidden" id="recruit-itv-gb-type" name="jobRecruitPcsList['+count+'].jobItv.fap_job_itv_gb" value="C3300">';
			context += '</div>';
			context += '<div class="job-ad-select-option">';
			context += '<ul class="option-list">';
			context += '<li class="recruit-itv-gb-type selected">';
			context += '<button type="button" recruit-itv-gb-type-code="C3300"><code value="C3300"></code></button>';
			context += '</li>';
			context += '<li class="recruit-itv-gb-type skype">';
			context += '<button type="button" recruit-itv-gb-type-code="C3301"><code value="C3301"></code></button>';
			context += '</li>';
			context += '</ul>';
			context += '</div>';
			context += '</div>';
			context += '<div class="sub-area display">';
			context += '<div class="sub-area-inner">';
			context += '<div class="bar-inner">';
			context += '<h5 class="inner-title"><spring:message code="fap.comp.itv_skype_id" /></h5>';
			context += '<span class="inner-item">';
			context += '<input type="text" name="jobRecruitPcsList['+count+'].jobItv.fap_job_itv_skype" maxlength="50">';
			context += '</span>';
			context += '</div>';
			context += '</div>';
			context += '</div>';
			context += '</div>';
			context += '</div>';
			context += '<div class="job-ad-row">';
			context += '<div class="job-ad-lt">';
			context += '<spring:message code="fap.comp.itv_obj" />';
			context += '</div>';
			context += '<div class="job-ad-rt recruit-row">';
			context += '<div class="job-ad-dropdown">';
			context += '<div class="job-ad-select">';
			context += '<button type="button" class="job-ad-select-btn"><code value="C3400"></code></button>';
			context += '<input type="hidden" id="recruit-itv-obj-type" name="jobRecruitPcsList['+count+'].jobItv.fap_job_itv_obj" value="C3400">';
			context += '</div>';
			context += '<div class="job-ad-select-option">';
			context += '<ul class="option-list">';
			context += '<li class="recruit-itv-obj-type selected">';
			context += '<button type="button" recruit-itv-obj-type-code="C3400"><code value="C3400"></code></button>';
			context += '</li>';
			context += '<li class="recruit-itv-obj-type">';
			context += '<button type="button" recruit-itv-obj-type-code="C3401"><code value="C3401"></code></button>';
			context += '</li>';
			context += '<li class="recruit-itv-obj-type">';
			context += '<button type="button" recruit-itv-obj-type-code="C3402"><code value="C3402"></code></button>';
			context += '</li>';
			context += '<li class="recruit-itv-obj-type etc">';
			context += '<button type="button" recruit-itv-obj-type-code="C3403"><code value="C3403"></code></button>';
			context += '</li>';
			context += '</ul>';
			context += '</div>';
			context += '</div>';
			context += '<div class="sub-area display">';
			context += '<div class="sub-area-inner">';
			context += '<div class="bar-inner">';
			context += '<h5 class="inner-title"><spring:message code="fap.common.etc" /></h5>';
			context += '<span class="inner-item">';
			context += '<textarea rows="4" cols="20" name="jobRecruitPcsList['+count+'].jobItv.jobItvObjEtc.fap_job_itv_obj_etc_dtl" maxlength="150"></textarea>';
			context += '</span>';
			context += '</div>';
			context += '</div>';
			context += '</div>';
			context += '</div>';
			context += '</div>';
			context += '<div class="job-ad-row">';
			context += '<div class="job-ad-lt">';
			context += '<spring:message code="fap.comp.itv_tp" />';
			context += '</div>';
			context += '<div class="job-ad-rt recruit-row">';
			context += '<div class="job-ad-dropdown">';
			context += '<div class="job-ad-select">';
			context += '<button type="button" class="job-ad-select-btn"><code value="C3500"></code></button>';
			context += '<input type="hidden" id="recruit-itv-tp-type" name="jobRecruitPcsList['+count+'].jobItv.fap_job_itv_tp" value="C3500">';
			context += '</div>';
			context += '<div class="job-ad-select-option">';
			context += '<ul class="option-list">';
			context += '<li class="recruit-itv-tp-type selected">';
			context += '<button type="button" recruit-itv-tp-type-code="C3500"><code value="C3500"></code></button>';
			context += '</li>';
			context += '<li class="recruit-itv-tp-type">';
			context += '<button type="button" recruit-itv-tp-type-code="C3501"><code value="C3501"></code></button>';
			context += '</li>';
			context += '<li class="recruit-itv-tp-type">';
			context += '<button type="button" recruit-itv-tp-type-code="C3502"><code value="C3502"></code></button>';
			context += '</li>';
			context += '<li class="recruit-itv-tp-type etc">';
			context += '<button type="button" recruit-itv-tp-type-code="C3503"><code value="C3503"></code></button>';
			context += '</li>';
			context += '</ul>';
			context += '</div>';
			context += '</div>';
			context += '<div class="sub-area display">';
			context += '<div class="sub-area-inner">';
			context += '<div class="bar-inner">';
			context += '<h5 class="inner-title"><spring:message code="fap.common.etc" /></h5>';
			context += '<span class="inner-item">';
			context += '<textarea rows="4" cols="20" name="jobRecruitPcsList['+count+'].jobItv.jobItvTpEtc.fap_job_itv_tp_etc_dtl" maxlength="150"></textarea>';
			context += '</span>';
			context += '</div>';
			context += '</div>';
			context += '</div>';
			context += '</div>';
			context += '</div>';
			context += '<div class="job-ad-row">';
			context += '<div class="job-ad-lt">';
			context += '<spring:message code="fap.comp.itv_tm" />';
			context += '</div>';
			context += '<div class="job-ad-rt">';
			context += '<input type="text" name="jobRecruitPcsList['+count+'].jobItv.fap_job_itv_tm" maxlength="50">';
			context += '<span class="hiddenTx">分</span>';
			context += '</div>';
			context += '</div>';
			context += '</div>';
			
			selected_obj.closest(".ui-accordion-content-header").nextAll(".ui-accordion-content-body").empty();
			selected_obj.closest(".ui-accordion-content-header").after($compile(context)($scope));
			//실시간 유효성 검사
			realTimeValidation();
			//면접구분
			recruit_itv_gb_type_event();
			
			//면접대상자 구분
			recruit_itv_obj_type();
			
			//면접형태 구분
			recruit_itv_tp_type();
		}
		
		//채용 전형 - 기타전형
		$scope.addRecruitEtc = function(selected_obj) {
			
			var count = selected_obj.closest(".ui-accordion-content").index(".ui-accordion-content");
			var context = '<div class="ui-accordion-content-body">';
			context += '<div class="job-ad-row">';
			context += '<div class="job-ad-lt">';
			context += '<spring:message code="fap.comp.test_etc_obj" />';
			context += '</div>';
			context += '<div class="job-ad-rt recruit-row">';
			context += '<div class="job-ad-dropdown">';
			context += '<div class="job-ad-select">';
			context += '<button type="button" class="job-ad-select-btn"><code value="C3600"></code></button>';
			context += '<input type="hidden" id="recruit-test-etc-obj-type" name="jobRecruitPcsList['+count+'].jobTestEtc.fap_job_test_etc_obj" value="C3600">';
			context += '</div>';
			context += '<div class="job-ad-select-option">';
			context += '<ul class="option-list">';
			context += '<li class="recruit-test-etc-obj-type selected">';
			context += '<button type="button" recruit-test-etc-obj-type-code="C3600"><code value="C3600"></code></button>';
			context += '</li>';
			context += '<li class="recruit-test-etc-obj-type">';
			context += '<button type="button" recruit-test-etc-obj-type-code="C3601"><code value="C3601"></code></button>';
			context += '</li>';
			context += '<li class="recruit-test-etc-obj-type">';
			context += '<button type="button" recruit-test-etc-obj-type-code="C3602"><code value="C3602"></code></button>';
			context += '</li>';
			context += '<li class="recruit-test-etc-obj-type etc">';
			context += '<button type="button" recruit-test-etc-obj-type-code="C3603"><code value="C3603"></code></button>';
			context += '</li>';
			context += '</ul>';
			context += '</div>';
			context += '</div>';
			context += '<div class="sub-area display">';
			context += '<div class="sub-area-inner">';
			context += '<div class="bar-inner">';
			context += '<h5 class="inner-title"><spring:message code="fap.common.etc" /></h5>';
			context += '<span class="inner-item">';
			context += '<textarea rows="4" cols="20" name="jobRecruitPcsList['+count+'].jobTestEtc.jobTestEtcObj.fap_job_test_etc_obj_dtl" maxlength="50"></textarea>';
			context += '</span>';
			context += '</div>';
			context += '</div>';
			context += '</div>';
			context += '</div>';
			context += '</div>';
			context += '<div class="job-ad-row">';
			context += '<div class="job-ad-lt">';
			context += '<spring:message code="fap.comp.test_etc_detail" />';
			context += '</div>';
			context += '<div class="job-ad-rt">';
			context += '<textarea rows="4" cols="20" name="jobRecruitPcsList['+count+'].jobTestEtc.fap_job_test_etc_dtl" maxlength="150"></textarea>';
			context += '</div>';
			context += '</div>';
			context += '</div>';
			
			selected_obj.closest(".ui-accordion-content-header").nextAll(".ui-accordion-content-body").empty();
			selected_obj.closest(".ui-accordion-content-header").after($compile(context)($scope));
			//실시간 유효성 검사
			realTimeValidation();
			//기타전형 대상자 구분
			recruit_test_etc_obj_type();
		}
							
		//급여 (원병호)
		//급여 기타수당 추가
		$scope.add_job_pay = function(){
			var count = $(".job-extra-plus .sub-area").length + 4;
			var context = '';
			context += '<div class="sub-area">';
			context += '<input type="hidden" name="jobPayList['+count+'].fap_job_pay_gb" value="C2201">';
			context += '<div class="sub-area-inner">';
			context += '<div class="bar-inner">';
			context += '<div class="inner-float">';
			context += '<h5 class="inner-title"><spring:message code="fap.jobad.extra_fee_name" /></h5>';
			context += '<span class="inner-item">';
			context += '<input type="text" class="half" name="jobPayList['+count+'].fap_job_pay_dtl"  maxlength ="200"/>';
			context += '</span>';
			context += '</div>';
			context += '<div class="inner-float">';
			context += '<h5 class="inner-title right-title"><spring:message code="fap.jobad.extra_fee" /></h5>';
			context += '<span class="inner-item right-title">';
			context += '<input type="text" class="currency half basic-fee" name="jobPayList['+count+'].fap_job_pay_info" ng-model="jobPayList['+count+'].fap_job_pay_info" blur-currency maxlength="9"/>';
			context += '<span class="hiddenTx">円</span>';
			context += '</span>';
			context += '</div>';
			context += '</div>';
			context += '</div>';
			context += '</div>';
			
			$(".job-extra-plus").append($compile(context)($scope));
			//실시간 유효성 검사
			realTimeValidation();
		}//급여 기타수당 추가 끝
		
		//급여 기타수당 삭제
		$scope.remove_job_pay = function() {
			$(".job-extra-plus .sub-area:last").remove();
		}//급여 기타수당 삭제 끝
		
		//급여 기본급 기타 추가
		$scope.add_job_pay_etc = function() {
			
			var count = $(".extra-fee-plus .sub-area-inner").length;
			var context = '';
			context += '<div class="sub-area-inner">';
			context += '<div class="bar-inner">';
			context += '<div class="inner-float">';
			context += '<h5 class="inner-title"><spring:message code="fap.jobad.extra_fee_name" /></h5>';
			context += '<span class="inner-item">';
			context += '<input type="text" class="half" name="jobPayList[0].jobPayBase.jobPayBaseList[3].jobPayEtc.jobPayEtcList['+count+'].fap_job_pay_etc_nm" maxlength="15" />';
			context += '</span>';
			context += '</div>';
			context += '<div class="inner-float">';
			context += '<h5 class="inner-title right-title"><spring:message code="fap.jobad.extra_fee" /></h5>';
			context += '<span class="inner-item right-title">';
			context += '<input type="text" class="currency half basic-fee" name="jobPayList[0].jobPayBase.jobPayBaseList[3].jobPayEtc.jobPayEtcList['+count+'].fap_job_pay_etc_info" ng-model="jobPayList[0].jobPayBase.jobPayBaseList[3].jobPayEtc.jobPayEtcList['+count+'].fap_job_pay_etc_info" blur-currency maxlength ="9"/>';
			context += '<span class="hiddenTx">円</span>';
			context += '</span>';
			context += '</div>';
			context += '</div>';
			context += '</div>';
						
			$(".extra-fee-plus").append($compile(context)($scope));
			//실시간 유효성 검사
			realTimeValidation();
			basic_total_event();
		}//급여 기본급 기타 추가 끝
		
		$scope.remove_job_pay_etc = function() {

			$(".extra-fee-plus .sub-area-inner:last").remove();
			
			var total_fee = 0;
			
			$.each($(".basic-fee"), function(index, item){
				total_fee += parseInt($(this).val().replace(/,/g, ''));
			});
			
			$(".basic-total").text(String(total_fee).replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,'));

		}//급여 기본급 기타 추가 끝
		
		//급여 끝
		
		$scope.initAccordion = function(){
			var headers = $('.accordion .accordion-header,.accordion-load .accordion-header-load');
			var contentAreas = $('.accordion .ui-accordion-content,.accordion-load .ui-accordion-content-load');
			var expandLink = $('.accordion-expand-all');

			headers.off("click").on("click",function() {
				$(this).toggleClass("on");
			    var panel = $(this).next();
			    var isOpen = panel.is(':visible');
			 
			    panel[isOpen? 'slideUp': 'slideDown']()
			        .trigger(isOpen? 'hide': 'show');

			    return false;
			});

			expandLink.off("click").on("click",function(){
			    var isAllOpen = $(this).data('isAllOpen');
			    
			    contentAreas[isAllOpen? 'hide': 'show']()
			        .trigger(isAllOpen? 'hide': 'show');
			});

			contentAreas.on({
			    show: function(){
			        var isAllOpen = !contentAreas.is(':hidden');   
			        if(isAllOpen){
			            expandLink.text('Collapse All')
			                .data('isAllOpen', true);
			        }
			    },
			    hide: function(){
			        var isAllOpen = !contentAreas.is(':hidden');
			        if(!isAllOpen){
			            expandLink.text('Expand all')
			            .data('isAllOpen', false);
			        } 
			    }
			});
		}
		

	}//myapp.controller
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
					//console.log(response);
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
					//console.log(response);
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
	
</script>

<script type="text/javascript">
	//근무예정지에 따른 상세 근무예정지
	$(document).ready(function(){
		$('.scrollspy').scrollSpy();
		
		//체크박스 공통 처리
		checkbox_event();
	
		//모집직종
		$(".category-type").on("click",function(){
			
			$(".category-type").removeClass("ck");
			$(".category-type").find("input:radio[name='fap_job_ad_category_type']").prop("checked", false);
			$(this).addClass("ck");
			$(this).find("input:radio[name='fap_job_ad_category_type']").prop("checked", true);
			
			//ICT계열 선택시
			if($(this).hasClass("ict-type")){
				$(this).nextAll(".sub-area").find(".etc-area").find(".job-check").removeClass("ck");
				$(this).nextAll(".sub-area").find(".etc-context").find("textarea").val("");
				$(this).nextAll(".sub-area").find(".etc-area").addClass("category-none");
				$(this).nextAll(".sub-area").find(".etc-context").addClass("category-none");
				$(this).nextAll(".sub-area").find(".ict-area").removeClass("category-none");
				$(this).nextAll(".sub-area").find(".etc-area").find("input:checkbox").prop("checked",false);
			}
			//기전계 등 기타 계열 선택시
			else if($(this).hasClass("etc-type")){
				$(this).nextAll(".sub-area").find(".ict-area").find(".job-check").removeClass("ck");
				$(this).nextAll(".sub-area").find(".ict-area").addClass("category-none");
				$(this).nextAll(".sub-area").find(".etc-area").removeClass("category-none");
				$(this).nextAll(".sub-area").find(".ict-area").find("input:checkbox").prop("checked",false);
			}
			
			return;
			
		});
		
		//고용형태
		$(".hire-type").on("click",function(){
			
			$(".hire-type").removeClass("ck");
			$(".hire-type").find("input:radio[name='fap_job_ad_hire_type']").prop("checked", false);
			$(this).addClass("ck");
			$(this).find("input:radio[name='fap_job_ad_hire_type']").prop("checked", true);
			
			//정규직 체크시
			if($(this).hasClass("regular")){
				$(this).nextAll(".sub-area").find(".emp-contract").find(".job-radio").removeClass("ck");
				$(this).nextAll(".sub-area").find(".emp-contract").find("input[name='fap_job_jit_employee_isswitch']").prop("checked", false);
				$(this).nextAll(".sub-area").find(".emp-contract").css("display","none");
				$(this).nextAll(".sub-area").find(".emp-context").css("display","none");
				$(this).nextAll(".sub-area").find(".emp-context").find("textarea").val("");
			}
			//계약직 체크시
			else if($(this).hasClass("contract")){
				$(this).nextAll(".sub-area").find(".emp-contract").css("display","block");
			}
			
			return;
		});
		
		//정사원전환조건
		$(".emp-switch").on("click",function(){
			
			$(".emp-switch").removeClass("ck");
			$(".emp-switch").find("input:radio[name='fap_job_jit_employee_isswitch']").prop("checked", false);
			$(this).addClass("ck");
			$(this).find("input:radio[name='fap_job_jit_employee_isswitch']").prop("checked", true);
			
			//있음 체크시
			if($(this).hasClass("yes")){
				$(this).closest(".sub-area-inner").nextAll(".emp-context").css("display","block");
			}
			//없음 or 미정 체크시
			else{
				$(this).closest(".sub-area-inner").nextAll(".emp-context").css("display","none");
				$(this).closest(".sub-area-inner").nextAll(".emp-context").find("textarea").val("");
			}
			
			return ;
		});
		
		//시용기간
		$(".intern").on("click",function(){
			
			$(".intern").removeClass("ck");
			$(".intern").find("input:radio[name='fap_job_ad_intern']").prop("checked", false);
			$(this).addClass("ck");
			$(this).find("input:radio[name='fap_job_ad_intern']").prop("checked", true);
			
			// !!!확인 - 필요 없을거 같음
			//있음 체크시
			if($(this).hasClass("yes")){
				$(this).nextAll(".sub-area").css("display","block");
			}
			//없음 체크시
			else{
				$(this).nextAll(".sub-area").css("display","none");
				$(this).nextAll(".sub-area").find("input[type='text']").val("");
				
				$(this).nextAll(".sub-area").find(".trial-pay").removeClass("ck");
				$(this).nextAll(".sub-area").find(".trial-pay").find("input[type='radio']").prop("checked", false);
			}
			
		});
		
		//시용기간 중 급여변동
		$(".trial-pay").on("click",function(){
			
			$(".trial-pay").removeClass("ck");
			$(".trial-pay").find("input:radio[name='fap_job_trial_pay_equal']").prop("checked", false);
			$(this).addClass("ck");
			$(this).find("input:radio[name='fap_job_trial_pay_equal']").prop("checked", true);
			
		});
		
		//기숙사 유무
		$(".isdorm").on("click",function(){
			$(".isdorm").removeClass("ck");
			$(".isdorm").find("input:radio[name='fap_job_ad_isdorm']").prop("checked", false);
			$(this).addClass("ck");
			$(this).find("input:radio[name='fap_job_ad_isdorm']").prop("checked", true);
			
			//있음 체크시
			if($(this).hasClass("yes")){
				$(this).nextAll(".sub-area").css("display","block");
			}
			//없음 체크시
			else{
				$(this).nextAll(".sub-area").css("display","none");
				$(this).nextAll(".sub-area").find("input[type='text']").val("");
			}
		});
		
		//주요업무
		work_event();
		
		//기타 - 성적공개
		$(".etc-grade").on("click",function(){
			$(".etc-grade").removeClass("ck");
			$(".etc-grade").find("input:radio[name='fap_job_ad_open_grade']").prop("checked", false);
			$(this).addClass("ck");
			$(this).find("input:radio[name='fap_job_ad_open_grade']").prop("checked", true);
		});
		
		//기타 - 재류자격
		$(".etc-qual_dpe").on("click",function(){
			$(".etc-qual_dpe").removeClass("ck");
			$(".etc-qual_dpe").find("input:radio[name='fap_job_ad_qual_dpe']").prop("checked", false);
			$(this).addClass("ck");
			$(this).find("input:radio[name='fap_job_ad_qual_dpe']").prop("checked", true);
		});
		
		//기타 - 채용조건
		$(".etc-terms_dpe").on("click",function(){
			$(".etc-terms_dpe").removeClass("ck");
			$(".etc-terms_dpe").find("input:radio[name='fap_job_ad_terms_dpe']").prop("checked", false);
			$(this).addClass("ck");
			$(this).find("input:radio[name='fap_job_ad_terms_dpe']").prop("checked", true);
		});
		
		//기타 - 수료
		$(".etc-coc_agree").on("click",function(){
			$(".etc-coc_agree").removeClass("ck");
			$(".etc-coc_agree").find("input:radio[name='fap_job_ad_coc_agree']").prop("checked", false);
			$(this).addClass("ck");
			$(this).find("input:radio[name='fap_job_ad_coc_agree']").prop("checked", true);
		});
		
		//기타 - 중복지원
		$(".etc-overlap").on("click",function(){
			$(".etc-overlap").removeClass("ck");
			$(".etc-overlap").find("input:radio[name='fap_job_ad_overlap']").prop("checked", false);
			$(this).addClass("ck");
			$(this).find("input:radio[name='fap_job_ad_overlap']").prop("checked", true);
		});
		
		//희망성별
		$(".ad-gender").on("click",function(){
			$(".ad-gender").removeClass("ck");
			$(".ad-gender").find("input:radio[name='fap_job_ad_gender']").prop("checked", false);
			$(this).addClass("ck");
			$(this).find("input:radio[name='fap_job_ad_gender']").prop("checked", true);
		});
		
		//희망연령
		$(".ad-age").on("click",function(){
			$(".ad-age").removeClass("ck");
			$(".ad-age").find("input:radio[name='fap_job_ad_age']").prop("checked", false);
			$(this).addClass("ck");
			$(this).find("input:radio[name='fap_job_ad_age']").prop("checked", true);
		});
		
		//희망일본어
		$(".ad-ja").on("click",function(){
			$(".ad-ja").removeClass("ck");
			$(".ad-ja").find("input:radio[name='fap_job_ja_level_gb']").prop("checked", false);
			$(this).addClass("ck");
			$(this).find("input:radio[name='fap_job_ja_level_gb']").prop("checked", true);
		});
		
		//우대사항
		preferences_event();
		
		//기본급 합계
		basic_total_event();
		
		//교통비 유무
		$(".transport").on("click",function(){
			$(".transport").removeClass("ck");
			$(this).addClass("ck");
			
			//있음 체크시
			if($(this).hasClass("yes")){
				$(this).nextAll(".sub-area").css("display","block");
				$(this).nextAll(".sub-area").find("textarea").attr("name", "jobPayList[2].fap_job_pay_dtl");
			}
			//없음 체크시
			else{
				$(this).nextAll(".sub-area").css("display","none");
				$(this).nextAll(".sub-area").find("input[type='text']").val(0);
				$(this).nextAll(".sub-area").find("textarea").val("");
				$(this).nextAll(".sub-area").find("textarea").removeAttr("name");
			}
		});
		
		//상여 유무
		$(".incentive").on("click",function(){
			$(".incentive").removeClass("ck");
			$(this).addClass("ck");
			
			//있음 체크시
			if($(this).hasClass("yes")){
				$(this).nextAll(".sub-area").css("display","block");
			}
			//없음 체크시
			else{
				$(this).nextAll(".sub-area").css("display","none");
				$(this).nextAll(".sub-area").find("input[type='text']").val(0);
				$(this).nextAll(".sub-area").find("textarea").val("");
			}
		});
		
	});		
	
	//체크박스 공통 처리
	function checkbox_event(){
		$(".job-check").off("click").on("click",function(){
			// $(".sub-area-inner").hide();
			$(this).toggleClass("ck");
			
			if($(this).hasClass("work-first")){
				$(this).nextAll(".sub-area.work-first").find("textarea").val("");	
				$(this).nextAll(".sub-area.work-first").find(".sub-area-inner").toggle();
			}
			
			if($(this).hasClass("work-last")){
				$(this).nextAll(".sub-area.work-last").find("textarea").val("");	
				$(this).nextAll(".sub-area.work-last").find(".sub-area-inner").toggle();
			}
			
			if($(this).hasClass("etc")){
				$(this).nextAll(".sub-area").find("textarea").val("");	
				$(this).nextAll(".sub-area").find(".sub-area-inner").toggle();
			}
			
			if($(this).hasClass("category-etc")){
				$(".etc-context").toggleClass("category-none");
			}
			
			if($(this).hasClass("ck")){
				$(this).find(".job-check-label").next("input:checkbox").prop("checked", true);
			} else {
				$(this).find(".job-check-label").next("input:checkbox").prop("checked", false);
			}
			
			for(var i = 0; i < 9; i++){
				$(".area-work").find(".sub-area-inner").eq(i).hide();
			}

			for(var i = 0; i < 7; i++){
				if($("input:checkbox[name='jobWorkplaceList["+i+"].fap_job_workplace_gb']").prop("checked")){
					$(".area-work").find(".sub-area-inner").eq(i).show();
				} else {
					for(var j = 0; j < 9; j++){
						$("input:checkbox[name='jobWorkplaceList["+i+"].jobWorkplaceDtl.jobWorkplaceDtlList["+j+"].fap_job_workplace_dtl_gb']").prop("checked", false);
						$("input:checkbox[name='jobWorkplaceList["+i+"].jobWorkplaceDtl.jobWorkplaceDtlList["+j+"].fap_job_workplace_dtl_gb']").closest(".wp-dtl").removeClass("ck");
					}
				}
			}
			
			if($("input:checkbox[name='jobWorkplaceList[7].fap_job_workplace_gb']").prop("checked")){
				// 나머지 체크 없애고 hide 처리, 기타지역은 남겨둠
				for(var j = 0; j < 7; j++){
					$(".area-work").find(".sub-area-inner").eq(j).hide();
					$("input:checkbox[name='jobWorkplaceList["+j+"].fap_job_workplace_gb']").prop("checked", false);
					$("input:checkbox[name='jobWorkplaceList["+j+"].fap_job_workplace_gb']").closest(".long-check").removeClass("ck");
				}
				
				// 세부지역도 체크 없앰
				$(".wp-dtl").removeClass("ck");
				$(".wp-dtl").find("input:checkbox").prop("checked", false);
			}
			
			if($("input:checkbox[name='jobWorkplaceList[8].fap_job_workplace_gb']").prop("checked")){
				$(".area-work").find(".sub-area-inner").eq(7).show();
			}
			
			if($(this).hasClass("wp-textarea")){
				$(this).find("textarea").focus();
			}
			
		})
	}
	
	var blur_flag = true;
	
	function work_event(){
		select_box_event();
		
		//주요업무 셀렉트 옵션 선택
		$(".work-type").off("click").on("click",function(){
			if(!$(this).hasClass("selected")){
				var btnval = $(this).find("span").text();
				var work_code = $(this).find("span").attr("value");
				$(this).closest(".job-ad-dropdown").find(".job-ad-select span").text(btnval);
				$(this).closest(".job-ad-dropdown").find(".job-ad-select input").val(work_code);
				$(this).closest(".job-ad-row").next(".job-ad-row").find("textarea").val("");
				
				$(this).siblings().removeClass("selected");
				$(this).addClass("selected");
			}
			$(this).closest(".job-ad-dropdown").find(".job-ad-select").removeClass("on");
			$(this).closest(".job-ad-dropdown").find(".job-ad-select").nextAll(".job-ad-select-option").css("display","none");

		});
	}
	
	function preferences_event(){
		select_box_event();
		
		//우대사항 셀렉트 옵션 선택
		$(".preferences-type").off("click").on("click",function(){
			var btnval = $(this).find("span").text();
			var work_code = $(this).find("span").attr("value");
			
			if(!$(this).hasClass("selected")){
				$(this).closest(".job-ad-dropdown").find(".job-ad-select span").text(btnval);
				$(this).closest(".job-ad-dropdown").find(".job-ad-select input").val(work_code);
				
				$(this).closest(".job-ad-row").next(".job-ad-row").find("textarea").val("");
				
				$(this).siblings().removeClass("selected");
				$(this).addClass("selected");
			}
			
			$(this).closest(".job-ad-dropdown").find(".job-ad-select").removeClass("on");
			$(this).closest(".job-ad-dropdown").find(".job-ad-select").nextAll(".job-ad-select-option").css("display","none");
		});
		
	}
	
	function recruit_event(){
		select_box_event();
		
		//전형 셀렉트 옵션 선택
		$(".recruit-type").off("click").on("click",function(){
			var btnval = $(this).find("span").text();
			var work_code = $(this).find("span").attr("value");
			var selected_obj = $(this);
			
			if(!$(this).hasClass("selected")){
				$(this).closest(".job-ad-dropdown").find(".job-ad-select span").text(btnval);
				$(this).closest(".job-ad-dropdown").find(".job-ad-select input").val(work_code);
				$(this).closest(".ui-accordion-content").prev(".accordion-header").find("span").text(btnval);
				
				$(this).closest(".job-ad-row").next(".job-ad-row").find("textarea").val("");
				
				$(this).siblings().removeClass("selected");
				$(this).addClass("selected");
				
				recruit_select_innerHTML(selected_obj,work_code);
			}
			
			$(this).closest(".job-ad-dropdown").find(".job-ad-select").removeClass("on");
			$(this).closest(".job-ad-dropdown").find(".job-ad-select").nextAll(".job-ad-select-option").css("display","none");
		});
		
	}
	
	//시험 전형 - 시험 종류
	function recruit_exam_type_event(){
		select_box_event();
		
		$(".recruit-exam-type").off("click").on("click",function(){
			var btnval = $(this).find("span").text();
			var work_code = $(this).find("span").attr("value");
			
			if(!$(this).hasClass("selected")){
				$(this).closest(".job-ad-dropdown").find(".job-ad-select span").text(btnval);
				$(this).closest(".job-ad-dropdown").find(".job-ad-select input").val(work_code);
				
				$(this).siblings().removeClass("selected");
				$(this).addClass("selected");
			}
			
			$(this).closest(".job-ad-dropdown").find(".job-ad-select").removeClass("on");
			$(this).closest(".job-ad-dropdown").find(".job-ad-select").nextAll(".job-ad-select-option").css("display","none");
		});
	}
	
	//시험 전형 - 시험 대상자
	function recruit_exam_obj_type_event(){
		select_box_event();
		
		$(".recruit-exam-obj-type").off("click").on("click",function(){
			var btnval = $(this).find("span").text();
			var work_code = $(this).find("span").attr("value");
			
			if(!$(this).hasClass("selected")){
				$(this).closest(".job-ad-dropdown").find(".job-ad-select span").text(btnval);
				$(this).closest(".job-ad-dropdown").find(".job-ad-select input").val(work_code);
				
				$(this).closest(".job-ad-rt").find("textarea").val("");
				
				if($(this).hasClass("etc")){
					$(this).closest(".job-ad-rt").find(".sub-area").css("display","block");
				}else{
					$(this).closest(".job-ad-rt").find(".sub-area").css("display","none");
				}
				
				$(this).siblings().removeClass("selected");
				$(this).addClass("selected");
			}
			
			$(this).closest(".job-ad-dropdown").find(".job-ad-select").removeClass("on");
			$(this).closest(".job-ad-dropdown").find(".job-ad-select").nextAll(".job-ad-select-option").css("display","none");
		});
	}
	
	//시험 전형 - 이메일 필요 여부
	function recruit_exam_email_type_event(){
		select_box_event();
		
		$(".recruit-exam-email-type").off("click").on("click",function(){
			var btnval = $(this).find("span").text();
			var work_code = $(this).find("span").attr("value");
			
			if(!$(this).hasClass("selected")){
				$(this).closest(".job-ad-dropdown").find(".job-ad-select span").text(btnval);
				$(this).closest(".job-ad-dropdown").find(".job-ad-select input").val(work_code);
				
				$(this).siblings().removeClass("selected");
				$(this).addClass("selected");
			}
			
			$(this).closest(".job-ad-dropdown").find(".job-ad-select").removeClass("on");
			$(this).closest(".job-ad-dropdown").find(".job-ad-select").nextAll(".job-ad-select-option").css("display","none");
		});
	}
	
	//시험 전형 - 시험 감독 여부
	function recruit_exam_sv_type_event(){
		select_box_event();
		
		$(".recruit-exam-sv-type").off("click").on("click",function(){
			var btnval = $(this).find("span").text();
			var work_code = $(this).find("span").attr("value");
			
			if(!$(this).hasClass("selected")){
				$(this).closest(".job-ad-dropdown").find(".job-ad-select span").text(btnval);
				$(this).closest(".job-ad-dropdown").find(".job-ad-select input").val(work_code);
				
				$(this).closest(".job-ad-rt").find("textarea").val("");
				
				if($(this).hasClass("etc")){
					$(this).closest(".job-ad-rt").find(".sub-area").css("display","block");
				}else{
					$(this).closest(".job-ad-rt").find(".sub-area").css("display","none");
				}
				
				$(this).siblings().removeClass("selected");
				$(this).addClass("selected");
			}
			
			$(this).closest(".job-ad-dropdown").find(".job-ad-select").removeClass("on");
			$(this).closest(".job-ad-dropdown").find(".job-ad-select").nextAll(".job-ad-select-option").css("display","none");
		});
	}
	
	//시험 전형 - 준비물
	function recruit_exam_need_type_event(){
		select_box_event();
		
		$(".recruit-exam-need-type").off("click").on("click",function(){
			var btnval = $(this).find("span").text();
			var work_code = $(this).find("span").attr("value");
			
			if(!$(this).hasClass("selected")){
				$(this).closest(".job-ad-dropdown").find(".job-ad-select span").text(btnval);
				$(this).closest(".job-ad-dropdown").find(".job-ad-select input").val(work_code);
				
				$(this).closest(".job-ad-rt").find("textarea").val("");
				
				if($(this).hasClass("etc")){
					$(this).closest(".job-ad-rt").find(".sub-area").css("display","block");
				}else{
					$(this).closest(".job-ad-rt").find(".sub-area").css("display","none");
				}
				
				$(this).siblings().removeClass("selected");
				$(this).addClass("selected");
			}
			
			$(this).closest(".job-ad-dropdown").find(".job-ad-select").removeClass("on");
			$(this).closest(".job-ad-dropdown").find(".job-ad-select").nextAll(".job-ad-select-option").css("display","none");
		});
	}
	
	//면접 전형 - 면접구분
	function recruit_itv_gb_type_event(){
		select_box_event();
		
		$(".recruit-itv-gb-type").off("click").on("click",function(){
			var btnval = $(this).find("span").text();
			var work_code = $(this).find("span").attr("value");
			
			if(!$(this).hasClass("selected")){
				$(this).closest(".job-ad-rt").find("input").val("");
				
				$(this).closest(".job-ad-dropdown").find(".job-ad-select span").text(btnval);
				$(this).closest(".job-ad-dropdown").find(".job-ad-select input").val(work_code);
				
				if($(this).hasClass("skype")){
					$(this).closest(".job-ad-rt").find(".sub-area").css("display","block");
				}else{
					$(this).closest(".job-ad-rt").find(".sub-area").css("display","none");
				}
				
				$(this).siblings().removeClass("selected");
				$(this).addClass("selected");
			}
			
			$(this).closest(".job-ad-dropdown").find(".job-ad-select").removeClass("on");
			$(this).closest(".job-ad-dropdown").find(".job-ad-select").nextAll(".job-ad-select-option").css("display","none");
		});
	}
	
	//면접 전형 - 면접 대상자 구분
	function recruit_itv_obj_type(){
		select_box_event();
		
		$(".recruit-itv-obj-type").off("click").on("click",function(){
			var btnval = $(this).find("span").text();
			var work_code = $(this).find("span").attr("value");
			
			if(!$(this).hasClass("selected")){
				$(this).closest(".job-ad-dropdown").find(".job-ad-select span").text(btnval);
				$(this).closest(".job-ad-dropdown").find(".job-ad-select input").val(work_code);
				
				$(this).closest(".job-ad-rt").find("textarea").val("");
				
				if($(this).hasClass("etc")){
					$(this).closest(".job-ad-rt").find(".sub-area").css("display","block");
				}else{
					$(this).closest(".job-ad-rt").find(".sub-area").css("display","none");
				}
				
				$(this).siblings().removeClass("selected");
				$(this).addClass("selected");
			}
			
			$(this).closest(".job-ad-dropdown").find(".job-ad-select").removeClass("on");
			$(this).closest(".job-ad-dropdown").find(".job-ad-select").nextAll(".job-ad-select-option").css("display","none");
		});
	}
	
	//면접 전형 - 면접 형태 구분
	function recruit_itv_tp_type(){
		select_box_event();
		
		$(".recruit-itv-tp-type").off("click").on("click",function(){
			var btnval = $(this).find("span").text();
			var work_code = $(this).find("span").attr("value");
			
			if(!$(this).hasClass("selected")){
				$(this).closest(".job-ad-dropdown").find(".job-ad-select span").text(btnval);
				$(this).closest(".job-ad-dropdown").find(".job-ad-select input").val(work_code);
				
				$(this).closest(".job-ad-rt").find("textarea").val("");
				
				if($(this).hasClass("etc")){
					$(this).closest(".job-ad-rt").find(".sub-area").css("display","block");
				}else{
					$(this).closest(".job-ad-rt").find(".sub-area").css("display","none");
				}
				
				$(this).siblings().removeClass("selected");
				$(this).addClass("selected");
			}
			
			$(this).closest(".job-ad-dropdown").find(".job-ad-select").removeClass("on");
			$(this).closest(".job-ad-dropdown").find(".job-ad-select").nextAll(".job-ad-select-option").css("display","none");
		});
	}
	
	//기타 전형 - 대상자 구분
	function recruit_test_etc_obj_type(){
		select_box_event();
		
		$(".recruit-test-etc-obj-type").off("click").on("click",function(){
			var btnval = $(this).find("span").text();
			var work_code = $(this).find("span").attr("value");
			
			if(!$(this).hasClass("selected")){
				$(this).closest(".job-ad-dropdown").find(".job-ad-select span").text(btnval);
				$(this).closest(".job-ad-dropdown").find(".job-ad-select input").val(work_code);
				
				$(this).closest(".job-ad-rt").find("textarea").val("");
				
				if($(this).hasClass("etc")){
					$(this).closest(".job-ad-rt").find(".sub-area").css("display","block");
				}else{
					$(this).closest(".job-ad-rt").find(".sub-area").css("display","none");
				}
				
				$(this).siblings().removeClass("selected");
				$(this).addClass("selected");
			}
			
			$(this).closest(".job-ad-dropdown").find(".job-ad-select").removeClass("on");
			$(this).closest(".job-ad-dropdown").find(".job-ad-select").nextAll(".job-ad-select-option").css("display","none");
		});
	}
	
	//셀렉트 박스 공통 이벤트
	function select_box_event(){
		$(".job-ad-select").off("click").on("click",function(){
			$(this).toggleClass("on");
			$(this).nextAll(".job-ad-select-option").toggle();
		});
		
		$(".job-ad-select-option").off("mouseenter").on("mouseenter",function(){
			blur_flag = false;
		});
		$(".job-ad-select-option").off("mouseleave").on("mouseleave",function(){
			blur_flag = true;
		});
		
		$(".job-ad-select-btn").blur(function(){
	 		if(blur_flag){
				$(this).closest(".job-ad-select").removeClass("on");
				$(this).closest(".job-ad-select").nextAll(".job-ad-select-option").css("display","none");
	 		}
		});
	}
	
	
	//기본급 자동계산
	function basic_total_event(){
		$(".basic-fee").blur(function(){
			var total_fee = 0;
			
			$.each($(".basic-fee"), function(index, item){
				total_fee += parseInt($(this).val().replace(/,/g, ''));
			});
			
			$(".basic-total").text(String(total_fee).replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,'));
		
		});
	}
	
	//전형종류 선택시 - InnerHTML 호출 함수
	function recruit_select_innerHTML(selected_obj,code){
		
		//서류전형
		if(code == "C2500"){
			selected_obj.closest(".ui-accordion-content-header").nextAll(".ui-accordion-content-body").remove();
		}
		//시험
		else if(code == "C2501"){
			angular.element("#company_job_ad_body").scope().addRecruitExam(selected_obj);
		}
		//면접
		else if(code == "C2502"){
			angular.element("#company_job_ad_body").scope().addRecruitInterview(selected_obj);
		}
		//기타
		else if(code == "C2503"){
			angular.element("#company_job_ad_body").scope().addRecruitEtc(selected_obj);
		}
		//현지면접
		/* else if(code == "C2504"){
			selected_obj.closest(".ui-accordion-content-header").nextAll(".ui-accordion-content-body").remove();
		} */
	}
	
	//임시저장시 추가 파라미터를 넣어주는 함수(사용중)
	function temp_save() {
		
		if(form_check(2) == false) {
			return;
		}
		
		if( $("#fap_job_ad_state").val() == null || $("#fap_job_ad_state").val() == undefined){
			var input = document.createElement("input");
			input.setAttribute("type", "hidden");
			input.setAttribute("name", "fap_job_ad_state");
			input.setAttribute("value", "C2103");
			input.setAttribute("id", "fap_job_ad_state");
			
			$("#insert_form").append(input);
		}
		
		_insert_form();
	}
	
	
	/* 기업소개 첨부파일 폼체크 함수 */
	
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
	
	//이미지
	function extension_check_img (file_name){
		var extension = file_name.substring(file_name.lastIndexOf('.') + 1).toLowerCase();
		
		switch (extension) {
		case "gif":
		case "jpg":
		case "jpeg":
		case "png":
			return true;
		default:
			return false;
		}
	}
	
	//pdf
	function extension_check_pdf (file_name){
		var extension = file_name.substring(file_name.lastIndexOf('.') + 1).toLowerCase();
		
		switch (extension) {
		case "pdf":
			return true;
		default:
			return false;
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
	
	
	/* 기업소개 첨부파일 폼체크 끝*/
	
	//페이징관련 함수
	function changePageLoadList(clickedPage) {
		var fap_jobfair_seq = $('#fap_jobfair_seq').val();
		
		$.ajax({
			beforeSend: function(xhr) {
			     xhr.setRequestHeader("AJAX", true);
			},
			url : 'select_job_ad_load_list_paging',
			type : 'post',
			data : {
							'clickedPage' : clickedPage,
							'fap_jobfair_seq' : fap_jobfair_seq
						},
	        dataType : 'json', 
			success : function(map) {
				var totalCount = map.adTotalCount;
				var currentPage = map.repNavi.currentPage;
				var pagePerGroup = map.repNavi.pagePerGroup;
				var num = totalCount - ((pagePerGroup) * (currentPage - 1))
				
				$('.before-job-table-tbd').children().remove();
				var adInfoContext = '';
				$('.before-page-ul').children().remove();
				var pageContext = '';
				
				//[start] 이전 채용공고 정보 innerHtml로 그려주기 시작
				$.each(map.select_job_ad_load_list, function(index, adLoadList){
					adInfoContext += '<tr>';
					adInfoContext += '<td scope="col">' + (num - index) + '</td>';
					adInfoContext += '<td scope="col" title="' + adLoadList.fap_job_ad_title + '">' + adLoadList.fap_job_ad_title + '</td>';
					adInfoContext += '<td scope="col" title="' + adLoadList.fap_jobfair_title + '">' + adLoadList.fap_jobfair_title + '</td>';
					adInfoContext += '<td scope="col"><button onclick="ad_load('+adLoadList.fap_job_ad_seq+')"><spring:message code="fap.comp.select" /></button></td>';
					adInfoContext += '</tr>';					
				});
				//[end] 이전 채용공고 정보 inner로 그려주기 종료
				
				//[start] 페이지정보 innerHtml로 그려주기 시작
				pageContext += '<li>';
				pageContext += '<a href="javascript:changePageLoadList(' + (map.repNavi.currentPage - map.repNavi.pagePerGroup) + ')">◁◁</a>';
				pageContext += '</li>';
				pageContext += '<li>';
				pageContext += '<a href="javascript:changePageLoadList(' + (map.repNavi.currentPage - 1) + ')">◀</a>';
				pageContext += '</li>';
				
				for(var i=map.repNavi.startPageGroup; i<=map.repNavi.endPageGroup; i++){
					pageContext += '<li>';
					if(i == map.repNavi.currentPage){
						pageContext += '<span class="now">' + i + '</span>';
					}else{
						pageContext += '<a href="javascript:changePageLoadList(' + i + ')">' + i + '</a>';
					}
					pageContext += '</li>';
				}
				
				pageContext += '<li>';
				pageContext += '<a href="javascript:changePageLoadList(' + (map.repNavi.currentPage + 1) + ')">▶</a>';
				pageContext += '</li>';
				pageContext += '<li>';
				pageContext += '<a href="javascript:changePageLoadList(' + (map.repNavi.currentPage + map.repNavi.pagePerGroup) + ')">▷▷</a>';
				pageContext += '</li>';
				//[end] 페이지정보 inner로 그려주기 종료
				
				$('.before-job-table-tbd').append(adInfoContext);
				$('.before-page-ul').append(pageContext);
			},
			error : function(response) {
				console.log(response);
				if(response.status == 403){
					alert('<spring:message code="com.login.ajaxSesstion" javaScriptEscape="true" />');
					location.href = "/fap/company/company_login";
				}
			}
		});	
	}
	
	// 목록으로
	function return_list() {
		var fap_jobfair_seq = $('#fap_jobfair_seq').val();
		var fap_jobfair_divide_seq = $('#fap_jobfair_divide_seq').val();
		
		location.href='/fap/company/company_job_ad_management?fap_jobfair_seq='+fap_jobfair_seq+'&fap_jobfair_divide_seq='+fap_jobfair_divide_seq;
	}
	
	// 불러오기
	function ad_load(fap_job_ad_seq) {
		if(confirm('<spring:message code="fap.jobad.call_pre_jobad" />')){
			
			var fap_jobfair_seq = $('#fap_jobfair_seq').val();
			var fap_jobfair_divide_seq = $('#fap_jobfair_divide_seq').val();
			var fap_job_ad_seq = fap_job_ad_seq;
			var url = '';
			url += '/fap/company/company_job_ad_insert_form_load?fap_jobfair_seq=';
			url += fap_jobfair_seq;
			url += '&fap_jobfair_divide_seq='
			url += fap_jobfair_divide_seq;
			url += '&fap_job_ad_seq='
			url += fap_job_ad_seq;
			
			location.href=url;
		}else{
			
		}
	}
	
</script>

</head>
<body ng-app="myapp" ng-controller="JobAdController" id="company_job_ad_body">

	<!------------------------/헤드영역-------------------------->

	<%@include file="company_menu.jsp"%>

	<!------------------------/헤드영역-------------------------->
	
	<!-----------------------서브컨텐츠 영역--------------------------->
	<div class="job-ad-wrap">
		<div class="job-ad-subcontents">
		<div class="job-ad-content">
		
		<!-- 해당 기업의 과거 작성한 채용공고 불러오기 -->
		<c:if test="${not empty select_job_ad_load_list}">
			<div class="job-ad-load">
				<div class="accordion-load">
					<div class="accordion-header-load before-job-open">
						<span><spring:message code="fap.jobad.call_pre_jobad" /></span>
					</div>
					<div class="ui-accordion-content-load">
						<div class="ui-accordion-content-header">
							<div class="before-job-area">
								<div class="before-job-table">
									<table>
										<colgroup>
											<col width="10%">
											<col width="50%">
											<col width="30%">
											<col width="10%">
										</colgroup>
										<tbody class="before-job-table-tbd">
										<c:forEach var="adLoadList" items="${select_job_ad_load_list}" varStatus="status">									
											<tr>
												<td scope="col">${jobAdLoadNum - (status.count-1)}</td>
												<td scope="col" title="${adLoadList.fap_job_ad_title}">${adLoadList.fap_job_ad_title}</td>
												<td scope="col" title="${adLoadList.fap_jobfair_title}">${adLoadList.fap_jobfair_title}</td>
												<td scope="col"><button style="cursor: pointer;" onclick="ad_load(${adLoadList.fap_job_ad_seq})"><spring:message code="fap.comp.select" /></button></td>
											</tr>
										</c:forEach>
										</tbody>
									</table>
								</div>
								<div class="before-page">
									<ul class="before-page-ul">
											<li>
												<a href="javascript:changePageLoadList(${repNavi.currentPage - repNavi.pagePerGroup})">◁◁</a>
											</li>
											<li>
												<a href="javascript:changePageLoadList(${repNavi.currentPage - 1})">◀</a>
											</li>
										<c:forEach var="i" begin="${repNavi.startPageGroup}" end="${repNavi.endPageGroup}" step="1">
											<li>
											<c:choose>					
												<c:when test="${i eq repNavi.currentPage}">
													<span class="now">${i}</span>
												</c:when>
												<c:otherwise>
													<a href="javascript:changePageLoadList(${i})">${i}</a>
												</c:otherwise>
											</c:choose>									
											</li>
										</c:forEach>
											<li>
												<a href="javascript:changePageLoadList(${repNavi.currentPage + 1})">▶</a>
											</li>
											<li>
												<a href="javascript:changePageLoadList(${repNavi.currentPage + repNavi.pagePerGroup})">▷▷</a>
											</li>
									</ul>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</c:if>
		
		<form action="company_job_ad_insert" method="post" enctype="multipart/form-data" id="insert_form">
		<div class="job-ad-box">
						
			<input type="hidden" name="fap_job_ad_ins_id" value="${fap_comp_id }">
			<input type="hidden" name="fap_job_ad_udt_id" value="${fap_comp_id }">
			<input type="hidden" name="fap_job_dorm_ins_id" value="${fap_comp_id }">
			<input type="hidden" name="fap_job_dorm_udt_id" value="${fap_comp_id }">
			<input type="hidden" name="fap_job_jit_employee_ins_id" value="${fap_comp_id }">
			<input type="hidden" name="fap_job_jit_employee_udt_id" value="${fap_comp_id }">
			<input type="hidden" name="fap_job_ja_level_ins_id" value="${fap_comp_id }">
			<input type="hidden" name="fap_job_ja_level_udt_id" value="${fap_comp_id }">
			<input type="hidden" name="fap_job_trial_ins_id" value="${fap_comp_id }">
			<input type="hidden" name="fap_job_trial_udt_id" value="${fap_comp_id }">
			
			<input type="hidden" id="fap_jobfair_seq" name="fap_jobfair_seq" value="${fap_jobfair_seq}">
			<input type="hidden" id="fap_jobfair_divide_seq" name="fap_jobfair_divide_seq" value="${fap_jobfair_divide_seq}">
			<input type="hidden" name="fap_comp_id" value="${fap_comp_id}">
			
			<!-- <h1 style="width: 430px;">채용공고 등록 form</h1> -->
			<!-- 기업정보 -->
			<div id="company_info" class="scrollspy">
			<div class="job-ad-hd scrollspy">
			       <p class="job-ad-hd-tx">
			       		<spring:message code="fap.common.responsible_company_info" />
			       </p>
			</div>
	
			<div class="job-ad-contents scrollspy">
				<div class="job-ad-row">
					<!-- 채용공고 제목 -->
					<div class="job-ad-lt point">
						<spring:message code="fap.jobad.title" />
						<span class="red-point"></span>
					</div>
					<div class="job-ad-rt">
						<input class="input2" type="text" name="fap_job_ad_title" id="fap_job_ad_title" maxlength="50" placeholder="50<spring:message code="fap.placeholder.limit_characters" />">
					</div>
		    	</div>
				<div class="job-ad-row">
					<!-- 기업명(일본어) -->
					<div class="job-ad-lt point">
						<spring:message code="fap.comp.ja_nm" />
						<span class="red-point"></span>
					</div>
					<div class="job-ad-rt">
						<input type="text" class="input3" id="fap_job_comp_ja_nm" name="jobCompList[1].fap_job_comp_nm" ng-model="comp_info.fap_comp_ja_nm" maxlength="50" placeholder="50<spring:message code="fap.placeholder.limit_characters" />"/>
						<input type="hidden" name="jobCompList[1].fap_job_comp_gb" value="C0201" />
					</div>
		    	</div>
		    	<div class="job-ad-row">
					<!-- 기업명(영어) -->
					<div class="job-ad-lt point">
						<spring:message code="fap.comp.en_nm" />
						<span class="red-point"></span>
					</div>
					<div class="job-ad-rt">
						<input type="text" class="input1" id="fap_job_comp_en_nm" name="jobCompList[0].fap_job_comp_nm" ng-model="comp_info.fap_comp_en_nm" maxlength="50" placeholder="50<spring:message code="fap.placeholder.limit_characters" />"/>
						<input type="hidden" name="jobCompList[0].fap_job_comp_gb" value="C0200" />
					</div>
		    	</div>
		    	<div class="job-ad-row">
					<!-- 주요사업분야 -->
					<div class="job-ad-lt point">
						<spring:message code="fap.comp.major_bussiness" />
						<span class="red-point"></span>
					</div>
					<div class="job-ad-rt">
						<input class="input2" type="text" id="fap_job_ad_major_business"name="fap_job_ad_major_business" ng-model="comp_info.fap_comp_major_bussiness" maxlength="100" placeholder="100<spring:message code="fap.placeholder.limit_characters" />">
					</div>
		    	</div>
				<div class="job-ad-row">
					<!-- 설립일, 자본금 -->
					<div class="job-ad-lt point">
						<spring:message code="fap.comp.est_dt" />
						<span class="red-point"></span>
					</div>
					<div class="job-ad-rt-md">
						<input class="input3" type="text" id="fap_job_ad_est_dt" name="fap_job_ad_est_dt" ng-model="comp_info.fap_comp_est_dt" maxlength="15" placeholder="<spring:message code="fap.placeholder.est_dt" />">
					</div>
					<div class="job-ad-lt-md point">
							<spring:message code="fap.comp.stock" />
							<span class="red-point"></span>
					</div>
					<div class="job-ad-rt-la">
						<input class="input3 currency" type="text" id="fap_job_ad_stock" name="fap_job_ad_stock" ng-model="comp_info.fap_comp_stock" blur-currency maxlength="22">
						<span class="hiddenTx">円</span>
					</div>
		    	</div>				
				<div class="job-ad-row">
					<!-- 최근 3년간 매출 -->
					<div class="job-ad-lt point">
						<spring:message code="fap.comp.3years_avg_sales" />
						<span class="red-point"></span>
					</div>
					<div class="job-ad-rt">
						<input class="input2 currency" type="text" id="fap_job_ad_3years_avg_sales" name="fap_job_ad_3years_avg_sales" ng-model="comp_info.fap_comp_3years_avg_sales" blur-currency maxlength="22">
						<span class="hiddenTx">円</span>
					</div>
		    	</div>
		    	<div class="job-ad-row">
					<!-- 사원수 -->
					<div class="job-ad-lt point">
						<spring:message code="fap.comp.employee_num" />
						<span class="red-point"></span>
					</div>
					<div class="job-ad-rt">
						<input class="input3 currency" id="fap_job_ad_employee_num" type="text" name="fap_job_ad_employee_num" ng-model="comp_info.fap_comp_employee_num" blur-currency maxlength="9">
						<span class="hiddenTx">名</span>
					</div>
		    	</div>
		    	<div class="job-ad-row">
					<!-- 외국인 사원수, 한국인 사원수 -->
					<div class="job-ad-lt">
						<spring:message code="fap.comp.foreigner_num" />
					</div>
					<div class="job-ad-rt-md">
						<input class="input3 currency" type="text" name="fap_job_ad_foreigner_num" ng-model="comp_info.fap_comp_foreigner_num" blur-currency maxlength="9">
						<span class="hiddenTx sm">名</span>
					</div>
					<div class="job-ad-lt-md">
						<spring:message code="fap.comp.korean_num" />
					</div>
					<div class="job-ad-rt-la">
						<input class="input3 currency" type="text" name="fap_job_ad_korean_num" ng-model="comp_info.fap_comp_korean_num" blur-currency maxlength="9">
						<span class="hiddenTx">名</span>
					</div>
		    	</div>
		    	<div class="job-ad-row">
					<!-- 우편번호 -->
					<div class="job-ad-lt point">
						<spring:message code="fap.comp.postcode" />
						<span class="red-point"></span>
					</div>
					<div class="job-ad-rt">
						<input class="input2" type="text" id="fap_job_ad_postcode" name="fap_job_ad_postcode" ng-model="comp_info.fap_comp_postcode" maxlength="10" placeholder="<spring:message code="fap.placholder.postcode" />">
					</div>
		    	</div>
		    	<div class="job-ad-row">
					<!-- 주소 -->
					<div class="job-ad-lt point">
						<spring:message code="fap.comp.address" />
						<span class="red-point"></span>
					</div>
					<div class="job-ad-rt">
						<input class="input2" type="text" id="fap_job_ad_address" name="fap_job_ad_address" ng-model="comp_info.fap_comp_address" maxlength="150">
					</div>
		    	</div>
		    	<div class="job-ad-row">
					<!-- 주소 -->
					<div class="job-ad-lt">
						<spring:message code="fap.comp.address_detail" />
					</div>
					<div class="job-ad-rt">
						<input class="input2" type="text" name="fap_job_ad_address_dtl" ng-model="comp_info.fap_comp_address_detail" maxlength="150">
					</div>
		    	</div>
				<div class="job-ad-row">
					<!-- 홈페이지 -->
					<div class="job-ad-lt">
						<spring:message code="fap.comp.homepage" />
					</div>
					<div class="job-ad-rt">
						<input class="input2" type="text" name="fap_job_ad_homepage" ng-model="comp_info.fap_comp_homepage" maxlength="75">
					</div>
		    	</div>
		
			</div>
			
		</div>
		</div>
		<div id="hire_info" class="job-ad-box scrollspy">
			<!-- 고용정보 -->
			<div class="job-ad-hd scrollspy">
				<p class="job-ad-hd-tx">
			        <spring:message code="fap.jobad.hire_info" />
		        </p>
			</div>
			
			<div class="job-ad-contents">
				<div id="job_category_div">
					<div class="job-ad-row">
						<!-- 고용형태 -->
						<div class="job-ad-lt point">
							<spring:message code="fap.jobad.job_category" />
							<span class="red-point"></span>
						</div>
						<div class="job-ad-rt radio-row">
							<span class="job-radio category-type ict-type">
								<label class="job-radio-label">
									<code value="C5400"></code>
								</label>
								<input type="radio" name="fap_job_ad_category_type" value="C5400"/>
							</span>
							<span class="job-radio category-type etc-type">
								<label class="job-radio-label">
									<code value="C5401"></code>
								</label>
								<input type="radio" name="fap_job_ad_category_type" value="C5401" />
							</span>
							<div class="sub-area">
								<!-- ICT -->
								<div class="sub-area-inner ict-area category-none">
									<div class="bar-inner">
										<h5 class="inner-title">
											<code value="C5400"></code>
										</h5>
										<span class="inner-item">
											<span class="job-check">
												<label class="job-check-label">
													<code value="C3700"></code>
												</label>
												<input type="checkbox" id="se_input_ck_autofocus" name="jobCategoryList[0].fap_job_category_gb" value="C3700">
											</span>
											<span class="job-check">
												<label class="job-check-label">
													<code value="C3701"></code>
												</label>
												<input type="checkbox" name="jobCategoryList[1].fap_job_category_gb" value="C3701">
											</span>
											<span class="job-check">
												<label class="job-check-label">
													<code value="C3702"></code>
												</label>
												<input type="checkbox" name="jobCategoryList[2].fap_job_category_gb" value="C3702">
											</span>
											<span class="job-check">
												<label class="job-check-label">
													<code value="C3703"></code>
												</label>
												<input type="checkbox" name="jobCategoryList[3].fap_job_category_gb" value="C3703">
											</span>
										</span>
									</div>
								</div>
								<!-- 비ICT -->
								<div class="sub-area-inner etc-area category-none">
									<div class="bar-inner">
										<h5 class="inner-title">
											<code value="C5401"></code>
										</h5>
										<span class="inner-item">
											<span class="job-check">
												<label class="job-check-label">
													<code value="C3705"></code>
												</label>
												<input type="checkbox" id="se_input_ck_autofocus" name="jobCategoryList[5].fap_job_category_gb" value="C3705">
											</span>
											<span class="job-check">
												<label class="job-check-label">
													<code value="C3706"></code>
												</label>
												<input type="checkbox" name="jobCategoryList[6].fap_job_category_gb" value="C3706">
											</span>
											<span class="job-check">
												<label class="job-check-label">
													<code value="C3707"></code>
												</label>
												<input type="checkbox" name="jobCategoryList[7].fap_job_category_gb" value="C3707">
											</span>
											<span class="job-check">
												<label class="job-check-label">
													<code value="C3708"></code>
												</label>
												<input type="checkbox" name="jobCategoryList[8].fap_job_category_gb" value="C3708">
											</span>
											<span class="job-check">
												<label class="job-check-label">
													<code value="C3709"></code>
												</label>
												<input type="checkbox" name="jobCategoryList[9].fap_job_category_gb" value="C3709">
											</span>
											<span class="job-check">
												<label class="job-check-label">
													<code value="C3710"></code>
												</label>
												<input type="checkbox" name="jobCategoryList[10].fap_job_category_gb" value="C3710">
											</span>
											<span class="job-check category-etc">
												<label class="job-check-label">
													<code value="C3704"></code>
												</label>
												<input type="checkbox" name="jobCategoryList[4].fap_job_category_gb" value="C3704">
											</span>
										</span>
									</div>
								</div>
								<!-- 기타 -->
								<div class="sub-area-inner etc-context category-none">
									<div class="bar-inner">
										<h5 class="inner-title"><spring:message code="fap.jobad.job_category.detail" /></h5>
										<span class="inner-item">
											<textarea rows="4" cols="20" name="jobCategoryList[4].JobCategoryEtc.fap_job_category_etc_dtl" maxlength="200" placeholder="200<spring:message code="fap.placeholder.limit_characters" />"></textarea>
										</span>
									</div>
								</div>
							</div>
						</div>
			    	</div>
				</div>
				<div class="job-ad-row" id="fap_job_join_dt_gb_div">
					<!-- 입사예정일 -->
					<div class="job-ad-lt point">
						<spring:message code="fap.jobad.join_work_dt" />
						<span class="red-point"></span>
					</div>
					<div class="job-ad-rt check-row">
						<span class="job-check long-check work-first">
							<label class="job-check-label">
								<code value="C1500"></code>
							</label>
							<input type="checkbox" name="jobJoinDtList[0].fap_job_join_dt_gb" value="C1500" />
						</span>
						<span class="job-check long-check work-last">
							<label class="job-check-label">
								<code value="C1501"></code>
							</label>
							<input type="checkbox" name="jobJoinDtList[1].fap_job_join_dt_gb" value="C1501" />
						</span>
						<div class="sub-area work-first">
							<div class="sub-area-inner">
								<div class="bar-inner">
									<h5 class="inner-title"><code value="C1500"></code></h5>
									<span class="inner-item">
										<textarea rows="4" cols="20" name="jobJoinDtList[0].fap_job_join_dt_dtl" maxlength="200"></textarea>
									</span>
								</div>
							</div>
						</div>
						<div class="sub-area work-last">
							<div class="sub-area-inner">
								<div class="bar-inner">
									<h5 class="inner-title"><code value="C1501"></code></h5>
									<span class="inner-item">
										<textarea rows="4" cols="20" name="jobJoinDtList[1].fap_job_join_dt_dtl" maxlength="200"></textarea>
									</span>
								</div>
							</div>
						</div>
					</div>
		    	</div>
				<div class="job-ad-row">
					<!-- 근무시간, 평균잔업시간 -->
					<div class="job-ad-lt">
						<spring:message code="fap.jobad.worktime" />
					</div>
					<div class="job-ad-rt-md">
						<input class="input3" type="text" name="fap_job_ad_worktime" maxlength="15" placeholder="<spring:message code="fap.placeholder.worktime" />">
					</div>
					<div class="job-ad-lt-md">
						<spring:message code="fap.jobad.overtime" />
					</div>
					<div class="job-ad-rt-la">
						<input class="input3" type="text" name="fap_job_ad_overtime" maxlength="15">
						<span class="hiddenTx">時間</span>
					</div>
		    	</div>
		    	<div class="job-ad-row">
					<!-- 고용형태 -->
					<div class="job-ad-lt point">
						<spring:message code="fap.jobad.hire_type" />
						<span class="red-point"></span>
					</div>
					<div class="job-ad-rt radio-row">
						<span class="job-radio hire-type regular">
							<label class="job-radio-label">
								<code value="C0400"></code>
							</label>
							<input type="radio" name="fap_job_ad_hire_type" value="C0400"/>
						</span>
						<span class="job-radio hire-type contract">
							<label class="job-radio-label">
								<code value="C0401"></code>
							</label>
							<input type="radio" name="fap_job_ad_hire_type" value="C0401" />
						</span>
						<div class="sub-area">
							<div class="sub-area-inner emp-contract">
								<div class="bar-inner">
									<h5 class="inner-title"><spring:message code="fap.jobad.is_permanent" /></h5>
									<span class="inner-item radio">
										<span class="job-radio emp-switch yes">
											<label class="job-radio-label">
												<code value="C3800"></code>
											</label>
											<input type="radio" name="fap_job_jit_employee_isswitch" value="C3800" />
										</span>
										<span class="job-radio emp-switch no">
											<label class="job-radio-label">
												<code value="C3801"></code>
											</label>
											<input type="radio" name="fap_job_jit_employee_isswitch" value="C3801" />
										</span>
										<span class="job-radio emp-switch yet">
											<label class="job-radio-label">
												<code value="C3802"></code>
											</label>
											<input type="radio" name="fap_job_jit_employee_isswitch" value="C3802" />
										</span>
									</span>
								</div>
							</div>
							<div class="sub-area-inner emp-contract">
								<div class="bar-inner">
									<h5 class="inner-title"><spring:message code="fap.jobad.employee_term" /></h5>
									<span class="inner-item">
										<textarea rows="4" cols="20" name="fap_job_jit_employee_term" maxlength="200" placeholder="200<spring:message code="fap.placeholder.limit_characters" />"></textarea>
									</span>
								</div>
							</div>
							<div class="sub-area-inner emp-contract">
								<div class="bar-inner">
									<h5 class="inner-title"><spring:message code="fap.jobad.employee_condition" /></h5>
									<span class="inner-item">
										<textarea rows="4" cols="20" name="fap_job_jit_employee_dtl" maxlength="200" placeholder="200<spring:message code="fap.placeholder.limit_characters" />"></textarea>
									</span>
								</div>
							</div>
						</div>
					</div>
		    	</div>
				<div class="job-ad-row m50">
					<!-- 채용예정인원 -->
					<div class="job-ad-lt doubleline point">
						<spring:message code="fap.jobad.recruit_num" />
						<span class="red-point"></span>
					</div>
					<div class="job-ad-rt">
						<input class="input2 currency" id="fap_job_ad_recruit_num" ng-model="fap_job_ad_recruit_num" type="text" name="fap_job_ad_recruit_num" blur-currency maxlength="9">
						<span class="hiddenTx">名</span>
					</div>
		    	</div>	
				
				<div class="job-ad-row" id="fap_job_workplace_gb_div">
					<!-- 근무예정지  -->
					<div class="job-ad-lt point">
						<spring:message code="fap.jobad.workplace" />
						<span class="red-point"></span>
					</div>
					<div class="job-ad-rt check-row p0">
						<div class="job-ad-inner-box">
							<span class="job-check long-check">
								<label class="job-check-label">
									<code value="C3900"></code>
								</label>
								<input type="checkbox" name="jobWorkplaceList[0].fap_job_workplace_gb" value="C3900">
							</span>
							<span class="job-check long-check">
								<label class="job-check-label">
									<code value="C3901"></code>
								</label>
								<input type="checkbox" name="jobWorkplaceList[1].fap_job_workplace_gb" value="C3901">
							</span>
							<span class="job-check long-check">
								<label class="job-check-label">
									<code value="C3902"></code>
								</label>
								<input type="checkbox" name="jobWorkplaceList[2].fap_job_workplace_gb" value="C3902">
							</span>
							<span class="job-check long-check">
								<label class="job-check-label">
									<code value="C3903"></code>
								</label>
								<input type="checkbox" name="jobWorkplaceList[3].fap_job_workplace_gb" value="C3903">
							</span>
						</div>
						<div class="job-ad-inner-box p10">
							<span class="job-check long-check">
								<label class="job-check-label">
									<code value="C3904"></code>
								</label>
								<input type="checkbox" name="jobWorkplaceList[4].fap_job_workplace_gb" value="C3904">
							</span>
							<span class="job-check long-check">
								<label class="job-check-label">
									<code value="C3905"></code>
								</label>
								<input type="checkbox" name="jobWorkplaceList[5].fap_job_workplace_gb" value="C3905">
							</span>
							<span class="job-check long-check">
								<label class="job-check-label">
									<code value="C3906"></code>
								</label>
								<input type="checkbox" name="jobWorkplaceList[6].fap_job_workplace_gb" value="C3906">
							</span>
							<span class="job-check long-check">
								<label class="job-check-label">
									<code value="C3907"></code>
								</label>
								<input type="checkbox" name="jobWorkplaceList[7].fap_job_workplace_gb" value="C3907">
							</span>
						</div>
						<div class="job-ad-inner-box p10">
							<span class="job-check long-check">
								<label class="job-check-label">
									<code value="C3908"></code>
								</label>
								<input type="checkbox" name="jobWorkplaceList[8].fap_job_workplace_gb" value="C3908">
							</span>
						</div>
						<div class="sub-area area-work">
							<!-- 1 -->
							<div class="sub-area-inner">
								<div class="bar-inner">
									<h5 class="inner-title">
										<code value="C3900"></code>
									</h5>
									<span class="inner-item">
										<span class="job-check wp-dtl">
											<label class="job-check-label">
												<code value="C4000"></code>
											</label>
											<input type="checkbox" name="jobWorkplaceList[0].jobWorkplaceDtl.jobWorkplaceDtlList[0].fap_job_workplace_dtl_gb" value="C4000">
										</span>
										<span class="job-check wp-dtl">
											<label class="job-check-label">
												<code value="C4001"></code>
											</label>
											<input type="checkbox" name="jobWorkplaceList[0].jobWorkplaceDtl.jobWorkplaceDtlList[1].fap_job_workplace_dtl_gb" value="C4001">
										</span>
										<span class="job-check wp-dtl">
											<label class="job-check-label">
												<code value="C4002"></code>
											</label>
											<input type="checkbox" name="jobWorkplaceList[0].jobWorkplaceDtl.jobWorkplaceDtlList[2].fap_job_workplace_dtl_gb" value="C4002">
										</span>
										<span class="job-check wp-dtl">
											<label class="job-check-label">
												<code value="C4003"></code>
											</label>
											<input type="checkbox" name="jobWorkplaceList[0].jobWorkplaceDtl.jobWorkplaceDtlList[3].fap_job_workplace_dtl_gb" value="C4003">
										</span>
										<span class="job-check wp-dtl">
											<label class="job-check-label">
												<code value="C4004"></code>
											</label>
											<input type="checkbox" name="jobWorkplaceList[0].jobWorkplaceDtl.jobWorkplaceDtlList[4].fap_job_workplace_dtl_gb" value="C4004">
										</span>
										<span class="job-check wp-dtl">
											<label class="job-check-label">
												<code value="C4005"></code>
											</label>
											<input type="checkbox" name="jobWorkplaceList[0].jobWorkplaceDtl.jobWorkplaceDtlList[5].fap_job_workplace_dtl_gb" value="C4005">
										</span>
										<span class="job-check wp-dtl">
											<label class="job-check-label">
												<code value="C4006"></code>
											</label>
											<input type="checkbox" name="jobWorkplaceList[0].jobWorkplaceDtl.jobWorkplaceDtlList[6].fap_job_workplace_dtl_gb" value="C4006">
										</span>
									</span>
								</div>
							</div>
							<!-- 2 -->
							<div class="sub-area-inner">
								<div class="bar-inner">
									<h5 class="inner-title">
										<code value="C3901"></code>
									</h5>
									<span class="inner-item">
										<span class="job-check wp-dtl">
											<label class="job-check-label">
												<code value="C4007"></code>
											</label>
											<input type="checkbox" name="jobWorkplaceList[1].jobWorkplaceDtl.jobWorkplaceDtlList[0].fap_job_workplace_dtl_gb" value="C4007">
										</span>
										<span class="job-check wp-dtl">
											<label class="job-check-label">
												<code value="C4008"></code>
											</label>
											<input type="checkbox" name="jobWorkplaceList[1].jobWorkplaceDtl.jobWorkplaceDtlList[1].fap_job_workplace_dtl_gb" value="C4008">
										</span>
										<span class="job-check wp-dtl">
											<label class="job-check-label">
												<code value="C4009"></code>
											</label>
											<input type="checkbox" name="jobWorkplaceList[1].jobWorkplaceDtl.jobWorkplaceDtlList[2].fap_job_workplace_dtl_gb" value="C4009">
										</span>
										<span class="job-check wp-dtl">
											<label class="job-check-label">
												<code value="C4010"></code>
											</label>
											<input type="checkbox" name="jobWorkplaceList[1].jobWorkplaceDtl.jobWorkplaceDtlList[3].fap_job_workplace_dtl_gb" value="C4010">
										</span>
										<span class="job-check wp-dtl">
											<label class="job-check-label">
												<code value="C4011"></code>
											</label>
											<input type="checkbox" name="jobWorkplaceList[1].jobWorkplaceDtl.jobWorkplaceDtlList[4].fap_job_workplace_dtl_gb" value="C4011">
										</span>
										<span class="job-check wp-dtl">
											<label class="job-check-label">
												<code value="C4012"></code>
											</label>
											<input type="checkbox" name="jobWorkplaceList[1].jobWorkplaceDtl.jobWorkplaceDtlList[5].fap_job_workplace_dtl_gb" value="C4012">
										</span>
										<span class="job-check wp-dtl">
											<label class="job-check-label">
												<code value="C4013"></code>
											</label>
											<input type="checkbox" name="jobWorkplaceList[1].jobWorkplaceDtl.jobWorkplaceDtlList[6].fap_job_workplace_dtl_gb" value="C4013">
										</span>
									</span>
								</div>
							</div>
							<!-- 3 -->
							<div class="sub-area-inner">
								<div class="bar-inner">
									<h5 class="inner-title">
										<code value="C3902"></code>
									</h5>
									<span class="inner-item">
										<span class="job-check wp-dtl">
											<label class="job-check-label">
												<code value="C4014"></code>
											</label>
											<input type="checkbox" name="jobWorkplaceList[2].jobWorkplaceDtl.jobWorkplaceDtlList[0].fap_job_workplace_dtl_gb" value="C4014">
										</span>
										<span class="job-check wp-dtl">
											<label class="job-check-label">
												<code value="C4015"></code>
											</label>
											<input type="checkbox" name="jobWorkplaceList[2].jobWorkplaceDtl.jobWorkplaceDtlList[1].fap_job_workplace_dtl_gb" value="C4015">
										</span>
										<span class="job-check wp-dtl">
											<label class="job-check-label">
												<code value="C4016"></code>
											</label>
											<input type="checkbox" name="jobWorkplaceList[2].jobWorkplaceDtl.jobWorkplaceDtlList[2].fap_job_workplace_dtl_gb" value="C4016">
										</span>
										<span class="job-check wp-dtl">
											<label class="job-check-label">
												<code value="C4017"></code>
											</label>
											<input type="checkbox" name="jobWorkplaceList[2].jobWorkplaceDtl.jobWorkplaceDtlList[3].fap_job_workplace_dtl_gb" value="C4017">
										</span>
										<span class="job-check wp-dtl">
											<label class="job-check-label">
												<code value="C4018"></code>
											</label>
											<input type="checkbox" name="jobWorkplaceList[2].jobWorkplaceDtl.jobWorkplaceDtlList[4].fap_job_workplace_dtl_gb" value="C4018">
										</span>
										<span class="job-check wp-dtl">
											<label class="job-check-label">
												<code value="C4019"></code>
											</label>
											<input type="checkbox" name="jobWorkplaceList[2].jobWorkplaceDtl.jobWorkplaceDtlList[5].fap_job_workplace_dtl_gb" value="C4019">
										</span>
									</span>
								</div>
							</div>
							<!-- 4 -->
							<div class="sub-area-inner">
								<div class="bar-inner">
									<h5 class="inner-title">
										<code value="C3903"></code>
									</h5>
									<span class="inner-item">
										<span class="job-check wp-dtl">
											<label class="job-check-label">
												<code value="C4020"></code>
											</label>
											<input type="checkbox" name="jobWorkplaceList[3].jobWorkplaceDtl.jobWorkplaceDtlList[0].fap_job_workplace_dtl_gb" value="C4020">
										</span>
										<span class="job-check wp-dtl">
											<label class="job-check-label">
												<code value="C4021"></code>
											</label>
											<input type="checkbox" name="jobWorkplaceList[3].jobWorkplaceDtl.jobWorkplaceDtlList[1].fap_job_workplace_dtl_gb" value="C4021">
										</span>
										<span class="job-check wp-dtl">
											<label class="job-check-label">
												<code value="C4022"></code>
											</label>
											<input type="checkbox" name="jobWorkplaceList[3].jobWorkplaceDtl.jobWorkplaceDtlList[2].fap_job_workplace_dtl_gb" value="C4022">
										</span>
										<span class="job-check wp-dtl">
											<label class="job-check-label">
												<code value="C4023"></code>
											</label>
											<input type="checkbox" name="jobWorkplaceList[3].jobWorkplaceDtl.jobWorkplaceDtlList[3].fap_job_workplace_dtl_gb" value="C4023">
										</span>
									</span>
								</div>
							</div>
							<!-- 5 -->
							<div class="sub-area-inner">
								<div class="bar-inner">
									<h5 class="inner-title">
										<code value="C3904"></code>
									</h5>
									<span class="inner-item">
										<span class="job-check wp-dtl">
											<label class="job-check-label">
												<code value="C4024"></code>
											</label>
											<input type="checkbox" name="jobWorkplaceList[4].jobWorkplaceDtl.jobWorkplaceDtlList[0].fap_job_workplace_dtl_gb" value="C4024">
										</span>
										<span class="job-check wp-dtl">
											<label class="job-check-label">
												<code value="C4025"></code>
											</label>
											<input type="checkbox" name="jobWorkplaceList[4].jobWorkplaceDtl.jobWorkplaceDtlList[1].fap_job_workplace_dtl_gb" value="C4025">
										</span>
										<span class="job-check wp-dtl">
											<label class="job-check-label">
												<code value="C4026"></code>
											</label>
											<input type="checkbox" name="jobWorkplaceList[4].jobWorkplaceDtl.jobWorkplaceDtlList[2].fap_job_workplace_dtl_gb" value="C4026">
										</span>
										<span class="job-check wp-dtl">
											<label class="job-check-label">
												<code value="C4027"></code>
											</label>
											<input type="checkbox" name="jobWorkplaceList[4].jobWorkplaceDtl.jobWorkplaceDtlList[3].fap_job_workplace_dtl_gb" value="C4027">
										</span>
										<span class="job-check wp-dtl">
											<label class="job-check-label">
												<code value="C4028"></code>
											</label>
											<input type="checkbox" name="jobWorkplaceList[4].jobWorkplaceDtl.jobWorkplaceDtlList[4].fap_job_workplace_dtl_gb" value="C4028">
										</span>
										<span class="job-check wp-dtl">
											<label class="job-check-label">
												<code value="C4029"></code>
											</label>
											<input type="checkbox" name="jobWorkplaceList[4].jobWorkplaceDtl.jobWorkplaceDtlList[5].fap_job_workplace_dtl_gb" value="C4029">
										</span>
									</span>
								</div>
							</div>
							<!-- 6 -->
							<div class="sub-area-inner">
								<div class="bar-inner">
									<h5 class="inner-title">
										<code value="C3905"></code>
									</h5>
									<span class="inner-item">
										<span class="job-check wp-dtl">
											<label class="job-check-label">
												<code value="C4030"></code>
											</label>
											<input type="checkbox" name="jobWorkplaceList[5].jobWorkplaceDtl.jobWorkplaceDtlList[0].fap_job_workplace_dtl_gb" value="C4030">
										</span>
										<span class="job-check wp-dtl">
											<label class="job-check-label">
												<code value="C4031"></code>
											</label>
											<input type="checkbox" name="jobWorkplaceList[5].jobWorkplaceDtl.jobWorkplaceDtlList[1].fap_job_workplace_dtl_gb" value="C4031">
										</span>
										<span class="job-check wp-dtl">
											<label class="job-check-label">
												<code value="C4032"></code>
											</label>
											<input type="checkbox" name="jobWorkplaceList[5].jobWorkplaceDtl.jobWorkplaceDtlList[2].fap_job_workplace_dtl_gb" value="C4032">
										</span>
										<span class="job-check wp-dtl">
											<label class="job-check-label">
												<code value="C4033"></code>
											</label>
											<input type="checkbox" name="jobWorkplaceList[5].jobWorkplaceDtl.jobWorkplaceDtlList[3].fap_job_workplace_dtl_gb" value="C4033">
										</span>
										<span class="job-check wp-dtl">
											<label class="job-check-label">
												<code value="C4034"></code>
											</label>
											<input type="checkbox" name="jobWorkplaceList[5].jobWorkplaceDtl.jobWorkplaceDtlList[4].fap_job_workplace_dtl_gb" value="C4034">
										</span>
										<span class="job-check wp-dtl">
											<label class="job-check-label">
												<code value="C4035"></code>
											</label>
											<input type="checkbox" name="jobWorkplaceList[5].jobWorkplaceDtl.jobWorkplaceDtlList[5].fap_job_workplace_dtl_gb" value="C4035">
										</span>
										<span class="job-check wp-dtl">
											<label class="job-check-label">
												<code value="C4036"></code>
											</label>
											<input type="checkbox" name="jobWorkplaceList[5].jobWorkplaceDtl.jobWorkplaceDtlList[6].fap_job_workplace_dtl_gb" value="C4036">
										</span>
										<span class="job-check wp-dtl">
											<label class="job-check-label">
												<code value="C4037"></code>
											</label>
											<input type="checkbox" name="jobWorkplaceList[5].jobWorkplaceDtl.jobWorkplaceDtlList[7].fap_job_workplace_dtl_gb" value="C4037">
										</span>
										<span class="job-check wp-dtl">
											<label class="job-check-label">
												<code value="C4038"></code>
											</label>
											<input type="checkbox" name="jobWorkplaceList[5].jobWorkplaceDtl.jobWorkplaceDtlList[8].fap_job_workplace_dtl_gb" value="C4038">
										</span>
									</span>
								</div>
							</div>
							<!-- 7 -->
							<div class="sub-area-inner">
								<div class="bar-inner">
									<h5 class="inner-title">
										<code value="C3906"></code>
									</h5>
									<span class="inner-item">
										<span class="job-check wp-dtl">
											<label class="job-check-label">
												<code value="C4039"></code>
											</label>
											<input type="checkbox" name="jobWorkplaceList[6].jobWorkplaceDtl.jobWorkplaceDtlList[0].fap_job_workplace_dtl_gb" value="C4039">
										</span>
										<span class="job-check wp-dtl">
											<label class="job-check-label">
												<code value="C4040"></code>
											</label>
											<input type="checkbox" name="jobWorkplaceList[6].jobWorkplaceDtl.jobWorkplaceDtlList[1].fap_job_workplace_dtl_gb" value="C4040">
										</span>
										<span class="job-check wp-dtl">
											<label class="job-check-label">
												<code value="C4041"></code>
											</label>
											<input type="checkbox" name="jobWorkplaceList[6].jobWorkplaceDtl.jobWorkplaceDtlList[2].fap_job_workplace_dtl_gb" value="C4041">
										</span>
										<span class="job-check wp-dtl">
											<label class="job-check-label">
												<code value="C4042"></code>
											</label>
											<input type="checkbox" name="jobWorkplaceList[6].jobWorkplaceDtl.jobWorkplaceDtlList[3].fap_job_workplace_dtl_gb" value="C4042">
										</span>
										<span class="job-check wp-dtl">
											<label class="job-check-label">
												<code value="C4043"></code>
											</label>
											<input type="checkbox" name="jobWorkplaceList[6].jobWorkplaceDtl.jobWorkplaceDtlList[4].fap_job_workplace_dtl_gb" value="C4043">
										</span>
										<span class="job-check wp-dtl">
											<label class="job-check-label">
												<code value="C4044"></code>
											</label>
											<input type="checkbox" name="jobWorkplaceList[6].jobWorkplaceDtl.jobWorkplaceDtlList[5].fap_job_workplace_dtl_gb" value="C4044">
										</span>
										<span class="job-check wp-dtl">
											<label class="job-check-label">
												<code value="C4045"></code>
											</label>
											<input type="checkbox" name="jobWorkplaceList[6].jobWorkplaceDtl.jobWorkplaceDtlList[6].fap_job_workplace_dtl_gb" value="C4045">
										</span>
										<span class="job-check wp-dtl">
											<label class="job-check-label">
												<code value="C4046"></code>
											</label>
											<input type="checkbox" name="jobWorkplaceList[6].jobWorkplaceDtl.jobWorkplaceDtlList[7].fap_job_workplace_dtl_gb" value="C4046">
										</span>
									</span>
								</div>
							</div>
							<!-- 8 -->
							<div class="sub-area-inner">
								<div class="bar-inner">
									<h5 class="inner-title">
										<code value="C3908"></code>
									</h5>
									<span class="inner-item">
										<span class="job-check wp-dtl wp-textarea">
											<textarea rows="4" cols="20" name="jobWorkplaceList[8].JobWorkplaceEtc.fap_job_workplace_etc_address" maxlength="150"></textarea>
										</span>
									</span>
								</div>
							</div>
							
						</div>
					</div>
		    	</div>
				
				<div class="job-ad-row m50">
					<!-- 시용기간유무 -->
					<div class="job-ad-lt point">
						<spring:message code="fap.jobad.intern" />
						<span class="red-point"></span>
					</div>
					<div class="job-ad-rt radio-row">
						<span class="job-radio intern yes">
							<label class="job-radio-label">
								<code value="C0500"></code>
							</label>
							<input type="radio" name="fap_job_ad_intern" value="C0500"/>
						</span>
						<span class="job-radio intern no">
							<label class="job-radio-label">
								<code value="C0501"></code>
							</label>
							<input type="radio" name="fap_job_ad_intern" value="C0501"/>
						</span>
						<div class="sub-area display">
							<div class="sub-area-inner">
								<div class="bar-inner">
									<h5 class="inner-title"><spring:message code="fap.jobad.jobtrial_pd" /></h5>
									<span class="inner-item">
										<input type="text" name="fap_job_trial_pd" maxlength="50"/>
										<span class="hiddenTx"><spring:message code="fap.jobad.dorm_month" /></span>
									</span>
								</div>
							</div>
							<div class="sub-area-inner">
								<div class="bar-inner">
									<h5 class="inner-title"><spring:message code="fap.jobad.jobtrial_pay" /></h5>
									<span class="inner-item">
										<input type="text" class="currency" name="fap_job_trial_pay" ng-model="comp_info.fap_job_trial_pay" blur-currency/>
										<span class="hiddenTx">円</span>
									</span>
								</div>
							</div>
							<div class="sub-area-inner">
								<div class="bar-inner">
									<h5 class="inner-title"><spring:message code="fap.jobad.jobtrial_pay_condition" /></h5>
									<span class="inner-item radio">
										<span class="job-radio trial-pay">
											<label class="job-radio-label">
												<code value="C2400"></code>
											</label>
											<input type="radio" name="fap_job_trial_pay_equal" value="C2400"/>
										</span>
										<span class="job-radio trial-pay">
											<label class="job-radio-label">
												<code value="C2401"></code>
											</label>
											<input type="radio" name="fap_job_trial_pay_equal" value="C2401"/>
										</span>
									</span>
								</div>
							</div>
						</div>
					</div>
		    	</div>
				
				<div class="job-ad-row m50">
					<!-- 기숙사유무 -->
					<div class="job-ad-lt point">
						<spring:message code="fap.jobad.is_dorm" />
						<span class="red-point"></span>
					</div>
					<div class="job-ad-rt radio-row">
						<span class="job-radio isdorm yes">
							<label class="job-radio-label">
								<code value="C0800"></code>
							</label>
							<input type="radio" name="fap_job_ad_isdorm" value="C0800"/>
						</span>
						<span class="job-radio isdorm no">
							<label class="job-radio-label">
								<code value="C0801"></code>
							</label>
							<input type="radio" name="fap_job_ad_isdorm" value="C0801"/>
						</span>
						<div class="sub-area display">
							<div class="sub-area-inner">
								<div class="bar-inner">
									<h5 class="inner-title"><spring:message code="fap.jobad.dorm_lo" /></h5>
									<span class="inner-item">
										<input type="text" name="fap_job_dorm_lo" maxlength="100" placeholder="100<spring:message code="fap.placeholder.limit_characters" />"/>
									</span>
								</div>
							</div>
							<div class="sub-area-inner">
								<div class="bar-inner">
									<h5 class="inner-title"><spring:message code="fap.jobad.dorm_cost" /></h5>
									<span class="inner-item">
										<input type="text" class="currency" name="fap_job_dorm_cost" ng-model="comp_info.fap_job_dorm_cost" blur-currency/>
										<span class="hiddenTx">円/月</span>
									</span>
								</div>
							</div>
							<div class="sub-area-inner">
								<div class="bar-inner">
									<h5 class="inner-title"><spring:message code="fap.jobad.dorm_note" /></h5>
									<span class="inner-item">
										<textarea rows="4" cols="20" name="fap_job_dorm_note" maxlength="200" placeholder="<spring:message code="fap.placeholder.currency" />(200<spring:message code="fap.placeholder.limit_characters" />)"></textarea>
									</span>
								</div>
							</div>
						</div>
					</div>
		    	</div>
				<div class="job-ad-row m50">
					<!-- 승급 -->
					<div class="job-ad-lt">
						<spring:message code="fap.jobad.promotion" />
					</div>
					<div class="job-ad-rt">
						<input class="input2" type="text" name="fap_job_ad_promotion" maxlength="100" placeholder="100<spring:message code="fap.placeholder.limit_characters" />">
					</div>
		    	</div>
		    	<div class="job-ad-row">
					<!-- 휴일 -->
					<div class="job-ad-lt">
						<spring:message code="fap.jobad.vacation" />
					</div>
					<div class="job-ad-rt">
						<textarea rows="4" cols="20" name="fap_job_ad_vacation" maxlength="200" placeholder="200<spring:message code="fap.placeholder.limit_characters" />"></textarea>
					</div>
		    	</div>
				<div class="job-ad-row">
					<!-- 보험 및 퇴직금  -->
					<div class="job-ad-lt">
						<spring:message code="fap.jobad.insurance" />
					</div>
					<div class="job-ad-rt check-row">
						<span class="job-check">
							<label class="job-check-label">
								<code value="C0600"></code>
							</label>
							<input type="checkbox" name="jobIsrList[0].fap_job_isr_gb" value="C0600">
						</span>
						<span class="job-check">
							<label class="job-check-label">
								<code value="C0601"></code>
							</label>
							<input type="checkbox" name="jobIsrList[1].fap_job_isr_gb" value="C0601">
						</span>
						<span class="job-check">
							<label class="job-check-label">
								<code value="C0602"></code>
							</label>
							<input type="checkbox" name="jobIsrList[2].fap_job_isr_gb" value="C0602">
						</span>
						<span class="job-check">
							<label class="job-check-label">
								<code value="C0603"></code>
							</label>
							<input type="checkbox" name="jobIsrList[3].fap_job_isr_gb" value="C0603">
						</span>
						<span class="job-check">
							<label class="job-check-label">
								<code value="C0604"></code>
							</label>
							<input type="checkbox" name="jobIsrList[4].fap_job_isr_gb" value="C0604">
						</span>
					</div>
		    	</div>
				<div class="job-ad-row m50">
					<!-- 기타 복리후생 -->
					<div class="job-ad-lt">
						<spring:message code="fap.jobad.welfare" />
					</div>
					<div class="job-ad-rt">
						<textarea rows="4" cols="20" name="fap_job_ad_welfare" maxlength="500" placeholder="500<spring:message code="fap.placeholder.limit_characters" />"></textarea>
					</div>
		    	</div>
			</div>	
		</div>	
		
		<div id="detail" class="job-ad-box scrollspy">
			<!-- 상세정보 -->
			<div class="job-ad-hd scrollspy">
				    <p class="job-ad-hd-tx">
		       				<spring:message code="fap.jobad.detail.title" />
		       		</p>
			</div>
			
			<div class="job-ad-contents">
				<div class="job-ad-row">
					<!-- 주요업무 -->
					<div class="job-ad-lt doubleline point">
						<spring:message code="fap.jobad.work" />
						<span class="red-point"></span>
					</div>
					<div class="job-ad-rt">
						<div class="job-ad-dropdown">
							<div class="job-ad-select">
								<button type="button" class="job-ad-select-btn"><code value="C0300"></code></button>
								<input type="hidden" id="work-gb" name="jobWorkList[0].fap_job_work_gb" value="C0300">
							</div>
							<div class="job-ad-select-option">
								<ul class="option-list">
									<li class="work-type selected">
										<button type="button" work-code="C0300"><code value="C0300"></code></button>
									</li>
									<li class="work-type">
										<button type="button" work-code="C0301"><code value="C0301"></code></button>
									</li>
									<li class="work-type">
										<button type="button" work-code="C0302"><code value="C0302"></code></button>
									</li>
									<li class="work-type">
										<button type="button" work-code="C0304"><code value="C0304"></code></button>
									</li>
									<li class="work-type">
										<button type="button" work-code="C0305"><code value="C0305"></code></button>
									</li>
									<li class="work-type">
										<button type="button" work-code="C0306"><code value="C0306"></code></button>
									</li>
									<li class="work-type">
										<button type="button" work-code="C0307"><code value="C0307"></code></button>
									</li>
									<li class="work-type">
										<button type="button" work-code="C0308"><code value="C0308"></code></button>
									</li>
									<li class="work-type">
										<button type="button" work-code="C0309"><code value="C0309"></code></button>
									</li>
									<li class="work-type">
										<button type="button" work-code="C0303"><code value="C0303"></code></button>
									</li>
								</ul>
							</div>
						</div>
					<span><spring:message code="fap.jobad.work.select" /></span>
					</div>
		    	</div>
		    	<div class="job-ad-row m10">
					<!-- 주요업무 추가/삭제 버튼 -->
					<div class="job-ad-lt bnt-lt">
						<button type="button" class="btn-add" ng-click="addWork()"></button>
						<button type="button" class="btn-remove" ng-click="removeWork()"></button>
					</div>
					<div class="job-ad-rt">
						<textarea rows="4" cols="20" name="jobWorkList[0].fap_job_work_dtl" maxlength="1000" placeholder="1000<spring:message code="fap.placeholder.limit_characters" />"></textarea>
					</div>
		    	</div>
		    	<!-- 주요업무 Inner Html 영역 -->
		    	<div class="work-type-plus">
					
				</div>
				
				<div class="job-ad-row">
					<!-- 희망 성별 -->
					<div class="job-ad-lt">
						<spring:message code="fap.jobad.gender" />
					</div>
					<div class="job-ad-rt radio-row">
						<span class="job-radio ad-gender">
							<label class="job-radio-label">
								<code value="C4200"></code>
							</label>
							<input type="radio" name="fap_job_ad_gender" value="C4200"/>
						</span>
						<span class="job-radio ad-gender">
							<label class="job-radio-label">
								<code value="C4201"></code>
							</label>
							<input type="radio" name="fap_job_ad_gender" value="C4201"/>
						</span>
						<span class="job-radio ad-gender">
							<label class="job-radio-label">
								<code value="C4202"></code>
							</label>
							<input type="radio" name="fap_job_ad_gender" value="C4202"/>
						</span>
					</div>
		    	</div>
		    	
		    	<div class="job-ad-row m50">
					<!-- 희망 연령 -->
					<div class="job-ad-lt">
						<spring:message code="fap.jobad.age" />
					</div>
					<div class="job-ad-rt radio-row">
						<span class="job-radio ad-age">
							<label class="job-radio-label">
								<code value="C1400"></code>
							</label>
							<input type="radio" name="fap_job_ad_age" value="C1400"/>
						</span>
						<span class="job-radio ad-age">
							<label class="job-radio-label">
								<code value="C1401"></code>
							</label>
							<input type="radio" name="fap_job_ad_age" value="C1401"/>
						</span>
						<span class="job-radio ad-age">
							<label class="job-radio-label">
								<code value="C1402"></code>
							</label>
							<input type="radio" name="fap_job_ad_age" value="C1402"/>
						</span>
						<span class="job-radio ad-age">
							<label class="job-radio-label">
								<code value="C1403"></code>
							</label>
							<input type="radio" name="fap_job_ad_age" value="C1403"/>
						</span>
					</div>
		    	</div>
		    	
		    	<div class="job-ad-row m50">
					<!-- 희망 일본어 -->
					<div class="job-ad-lt">
						<spring:message code="fap.jobad.required_ja_level" />
					</div>
					<div class="job-ad-rt radio-row">
						<span class="job-radio ad-ja">
							<label class="job-radio-label">
								<code value="C4400"></code>
							</label>
							<input type="radio" name="fap_job_ja_level_gb" value="C4400"/>
						</span>
						<span class="job-radio ad-ja">
							<label class="job-radio-label">
								<code value="C4401"></code>
							</label>
							<input type="radio" name="fap_job_ja_level_gb" value="C4401"/>
						</span>
						<span class="job-radio ad-ja">
							<label class="job-radio-label">
								<code value="C4402"></code>
							</label>
							<input type="radio" name="fap_job_ja_level_gb" value="C4402"/>
						</span>
						<span class="job-radio ad-ja">
							<label class="job-radio-label">
								<code value="C4403"></code>
							</label>
							<input type="radio" name="fap_job_ja_level_gb" value="C4403"/>
						</span>
						<div class="sub-area">
							<div class="sub-area-inner">
								<div class="bar-inner">
									<h5 class="inner-title"><spring:message code="fap.jobad.required_ja_level.detail" /></h5>
									<span class="inner-item">
										<textarea rows="4" cols="20" name="fap_job_ja_level_dtl" maxlength="200" placeholder="200<spring:message code="fap.placeholder.limit_characters" />"></textarea>
									</span>
								</div>
							</div>
						</div>
					</div>
		    	</div>
		    	
		    	<div class="job-ad-row">
					<!-- 우대사항 -->
					<div class="job-ad-lt doubleline">
						<spring:message code="fap.jobad.preferences" />
					</div>
					<div class="job-ad-rt">
						<div class="job-ad-dropdown">
							<div class="job-ad-select">
								<button type="button" class="job-ad-select-btn"><code value="C4106"></code></button>
								<input type="hidden" id="preferences-gb" name="jobPrefList[0].fap_job_pref_gb" value="C4106">
							</div>
							<div class="job-ad-select-option">
								<ul class="option-list">
									<li class="preferences-type selected">
										<button type="button" preferences-code="C4106"><code value="C4106"></code></button>
									</li>
									<li class="preferences-type">
										<button type="button" preferences-code="C4100"><code value="C4100"></code></button>
									</li>
									<li class="preferences-type">
										<button type="button" preferences-code="C4101"><code value="C4101"></code></button>
									</li>
									<li class="preferences-type">
										<button type="button" preferences-code="C4102"><code value="C4102"></code></button>
									</li>
									<li class="preferences-type">
										<button type="button" preferences-code="C4103"><code value="C4103"></code></button>
									</li>
									<li class="preferences-type">
										<button type="button" preferences-code="C4104"><code value="C4104"></code></button>
									</li>
									<li class="preferences-type">
										<button type="button" preferences-code="C4105"><code value="C4105"></code></button>
									</li>
								</ul>
							</div>
						</div>
					<span><spring:message code="fap.jobad.work.select" /></span>
					</div>
		    	</div>
		    	<div class="job-ad-row m10">
					<!-- 우대사항 추가/삭제 버튼 -->
					<div class="job-ad-lt bnt-lt">
						<button type="button" class="btn-add" ng-click="addPref()"></button>
						<button type="button" class="btn-remove" ng-click="removePref()"></button>
					</div>
					<div class="job-ad-rt">
						<textarea rows="4" cols="20" name="jobPrefList[0].fap_job_pref_dtl" maxlength="200" placeholder="200<spring:message code="fap.placeholder.limit_characters" />"></textarea>
					</div>
		    	</div>
		    	<!-- 우대사항 Inner Html 영역 -->
		    	<div class="preferences-type-plus">
					
				</div>
				<div class="job-ad-row">
					<!-- 인재상 -->
					<div class="job-ad-lt">
						<spring:message code="fap.jobad.ideal_person" />
					</div>
					<div class="job-ad-rt">
						<textarea rows="4" cols="20" name="fap_job_ad_ideal_person" maxlength="800" placeholder="800<spring:message code="fap.placeholder.limit_characters" />"></textarea>
					</div>
		    	</div>
			</div>
		</div>
		
		<div id="pay_detail" class="job-ad-box scrollspy">
			<div class="job-ad-hd scrollspy">
				<p class="job-ad-hd-tx">
					<spring:message code="fap.jobad.pay_detail" />
				</p>
			</div>
			
			<div class="job-ad-contents">
				<div class="job-ad-row">
					<!-- 기본급 -->
					<input type="hidden" name="jobPayList[0].fap_job_pay_gb" value="C2200">
					<input type="hidden" name="jobPayList[0].jobPayBase.jobPayBaseList[0].fap_job_pay_base_gb" value="C2300">
					<input type="hidden" name="jobPayList[0].jobPayBase.jobPayBaseList[1].fap_job_pay_base_gb" value="C2301">
					<input type="hidden" name="jobPayList[0].jobPayBase.jobPayBaseList[2].fap_job_pay_base_gb" value="C2302">
					<input type="hidden" name="jobPayList[0].jobPayBase.jobPayBaseList[3].fap_job_pay_base_gb" value="C2303">
					
					<div class="job-ad-lt">
						<spring:message code="fap.jobad.basic_sal_total" />
						<div>
							<span class="basic-total">0</span>
							<spring:message code="fap.jobad.basic_sal_total_yen" />
						</div>
					</div>
					<div class="job-ad-rt sal-row">
						<div class="sub-area">
							<div class="sub-area-inner">
								<div class="bar-inner">
									<div class="job-ad-lt point" style="margin-top: 2%; margin-left: -1%;"><h5 class="inner-title"><spring:message code="fap.jobad.basic_sal" /><span class="red-point"></span></h5></div>
									<span class="inner-item">
										<input type="text" class="currency basic-fee" id="basic_pay_input" name="jobPayList[0].jobPayBase.jobPayBaseList[0].fap_job_pay_base_info" ng-model="jobPayList[0].jobPayBase.jobPayBaseList[0].fap_job_pay_base_info" blur-currency/>
										<span class="hiddenTx">円</span>
									</span>
								</div>
							</div>
							<div class="sub-area-inner">
								<div class="bar-inner">
									<h5 class="inner-title"><spring:message code="fap.jobad.housing_fee" /></h5>
									<span class="inner-item">
										<input type="text" class="currency basic-fee" name="jobPayList[0].jobPayBase.jobPayBaseList[1].fap_job_pay_base_info" ng-model="jobPayList[0].jobPayBase.jobPayBaseList[1].fap_job_pay_base_info" blur-currency/>
										<span class="hiddenTx">円</span>
									</span>
								</div>
							</div>
							<div class="sub-area-inner">
								<div class="bar-inner">
									<div class="inner-float">
										<h5 class="inner-title"><spring:message code="fap.jobad.service_overtime_fee" /></h5>
										<span class="inner-item">
											<input type="text" class="currency half basic-fee" name="jobPayList[0].jobPayBase.jobPayBaseList[2].fap_job_pay_base_info" ng-model="jobPayList[0].jobPayBase.jobPayBaseList[2].fap_job_pay_base_info" blur-currency/>
											<span class="hiddenTx">円</span>
										</span>
									</div>
									<div class="inner-float">
										<h5 class="inner-title right-title"><spring:message code="fap.jobad.service_overtime_time" /></h5>
										<span class="inner-item right-title">
											<input type="text" class="currency half" name="jobPayList[0].jobPayBase.jobPayBaseList[2].jobServiceWork.fap_job_service_work_tm" ng-model="jobPayList[0].jobPayBase.jobPayBaseList[2].jobServiceWork.fap_job_service_work_tm" blur-currency/>
											<span class="hiddenTx"><spring:message code="fap.jobad.service_overtime_time" /></span>
										</span>
									</div>
								</div>
							</div>
							<div class="sub-area-inner">
								<div class="bar-inner">
									<h5 class="inner-title"><spring:message code="fap.jobad.extra_fee_title" /></h5>
									<span class="inner-item">
										<button type="button" class="btn-add" ng-click="add_job_pay_etc()"></button>
										<button type="button" class="btn-remove" ng-click="remove_job_pay_etc()"></button>
									</span>
								</div>
							</div>
							
							<div class="extra-fee-plus">
								
							</div>
							<div class="sub-area-inner">
								<div class="bar-inner">
									<h5 class="inner-title"><spring:message code="fap.jobad.incentive.detail" /></h5>
									<span class="inner-item">
										<textarea rows="4" cols="20" name="jobPayList[0].fap_job_pay_dtl" maxlength="200" placeholder="200<spring:message code="fap.placeholder.limit_characters" />"></textarea>
									</span>
								</div>
							</div>
						</div>
					</div>
					<!-- 기본급 끝 -->
		    	</div>
		    	<!-- 잔업수당(기본급에 포함되지 않는) -->
		    	<div class="job-ad-row">
		    		<input type="hidden" name="jobPayList[1].fap_job_pay_gb" value="C2202">
		    		<div class="job-ad-lt">
		    			<spring:message code="fap.jobad.overtime_fee" />
		    			<div>
		    			<spring:message code="fap.jobad.overtime_fee_sub" />
		    			</div>
		    		</div>
		    		<div class="job-ad-rt sal-row">
						<div class="sub-area">
							<div class="sub-area-inner">
								<div class="bar-inner">
									<div class="inner-float">
										<h5 class="inner-title"><spring:message code="fap.jobad.overtime_fee" /></h5>
										<span class="inner-item">
											<input type="text" class="currency half" name="jobPayList[1].fap_job_pay_info" ng-model="jobPayList[1].fap_job_pay_info" blur-currency/>
											<span class="hiddenTx">円/時</span>
										</span>
									</div>
									<div class="inner-float">
										<h5 class="inner-title right-title"></h5>
										<span class="inner-item right-title">
											<input type="text" class="currency half" name="jobPayList[1].jobPayExtra.fap_job_pay_extra_tm" ng-model="jobPayList[1].jobPayExtra.fap_job_pay_extra_tm" blur-currency/>
											<span class="hiddenTx">時間以上</span>
										</span>
									</div>
								</div>
							</div>
							<div class="sub-area-inner">
								<div class="bar-inner">
									<h5 class="inner-title"><spring:message code="fap.jobad.incentive.detail" /></h5>
									<span class="inner-item">
										<textarea rows="4" cols="20" name="jobPayList[1].fap_job_pay_dtl" maxlength="200" placeholder="200<spring:message code="fap.placeholder.limit_characters" />"></textarea>
									</span>
								</div>
							</div>
						</div>
						
					</div>
					<!-- 잔업수당(기본급에 포함되지 않는) 끝 -->
		    	</div>
		    	
		    	<div class="job-ad-row m50">
		    		<input type="hidden" name="jobPayList[2].fap_job_pay_gb" value="C2203">
					<!-- 교통비유무 -->
					<div class="job-ad-lt point">
						<spring:message code="fap.jobad.transport_fee" />
						<span class="red-point"></span>
					</div>
					<div class="job-ad-rt radio-row" id="transport_ck_div">
						<span class="job-radio transport yes">
							<label class="job-radio-label">
								<code value="C0800"></code>
							</label>
						</span>
						<span class="job-radio transport no">
							<label class="job-radio-label">
								<code value="C0801"></code>
							</label>
						</span>
						<div class="sub-area display">
							<div class="sub-area-inner">
								<div class="bar-inner">
									<h5 class="inner-title"><spring:message code="fap.jobad.transport_fee.max" /></h5>
									<span class="inner-item">
										<input type="text" class="currency" name="jobPayList[2].fap_job_pay_info" ng-model="jobPayList[2].fap_job_pay_info" blur-currency/>
										<span class="hiddenTx">円</span>
									</span>
								</div>
							</div>
							<div class="sub-area-inner">
								<div class="bar-inner">
									<h5 class="inner-title"><spring:message code="fap.jobad.detail" /></h5>
									<span class="inner-item">
										<textarea rows="4" cols="20" name="jobPayList[2].fap_job_pay_dtl" maxlength="200" placeholder="<spring:message code="fap.placeholder.currency" />(200<spring:message code="fap.placeholder.limit_characters" />)"></textarea>
									</span>
								</div>
							</div>
							
						</div>
					</div>
		    	</div>
		    	
		    	<div class="job-ad-row m50">
		    		<input type="hidden" name="jobPayList[3].fap_job_pay_gb" value="C2204">
					<!-- 상여 유무 -->
					<div class="job-ad-lt point">
						<spring:message code="fap.jobad.incentive" />
						<span class="red-point"></span>
					</div>
					<div class="job-ad-rt radio-row" id="incentive_ck_div">
						<span class="job-radio incentive yes">
							<label class="job-radio-label">
								<code value="C0800"></code>
							</label>
						</span>
						<span class="job-radio incentive no">
							<label class="job-radio-label">
								<code value="C0801"></code>
							</label>
						</span>
						<div class="sub-area display">
							<div class="sub-area-inner">
								<div class="bar-inner">
									<h5 class="inner-title"><spring:message code="fap.jobad.incentive.fee" /></h5>
									<span class="inner-item">
										<input type="text" class="currency" name="jobPayList[3].fap_job_pay_info" ng-model="jobPayList[3].fap_job_pay_info" blur-currency/>
										<span class="hiddenTx">円</span>
									</span>
								</div>
							</div>
							<div class="sub-area-inner">
								<div class="bar-inner">
									<h5 class="inner-title"><spring:message code="fap.jobad.incentive.detail" /></h5>
									<span class="inner-item">
										<textarea rows="4" cols="20" name="jobPayList[3].fap_job_pay_dtl" maxlength="200" placeholder="<spring:message code="fap.placeholder.currency" />(200<spring:message code="fap.placeholder.limit_characters" />)"></textarea>
									</span>
								</div>
							</div>
						</div>
					</div>
		    	</div>
		    	
		    	<div class="job-ad-row m50">
					<!-- 기타 수당 -->
					<div class="job-ad-lt">
						<spring:message code="fap.jobad.extra_fee_title" />
					</div>
					<div class="job-ad-rt sal-row">
						<button type="button" class="btn-add" ng-click="add_job_pay()"></button>
						<button type="button" class="btn-remove" ng-click="remove_job_pay()"></button>
						<div class="job-extra-plus">
						</div>
					</div>
		    	</div>
		    	
		    </div>
		</div>
	
		<div id="recruit_pcs" class="job-ad-box scrollspy">
			<div class="job-ad-hd"> 
				<p class="job-ad-hd-tx">
		       		<spring:message code="fap.jobad.recruit_pcs" />
				</p>
				<p>
					<spring:message code="fap.jobad.recruit_pcs.comment" />
				</p>
			</div>
			
			<div class="job-ad-contents">
				<div class="job-ad-row">
					<!-- 전형종류 -->
					<div class="job-ad-lt point">
						<spring:message code="fap.jobad.recruit_pcs" />
						<span class="red-point"></span>
					</div>
					<div class="job-ad-rt sal-row">
						<button type="button" class="btn-add" ng-click="addRecruitPcs()"></button>
						<button type="button" class="btn-remove" ng-click="removeRecruitPcs()"></button>
					</div>
				</div>
				<div class="accordion scrollspy">
				</div>
			</div>
		</div>
		
		<div id="company_introduction" class="job-ad-box scrollspy">
			<div id="" class="job-ad-hd scrollspy">
				<p class="job-ad-hd-tx">
				 	<spring:message code="fap.jobad.company_introduction" />
				 </p>
			</div>
			
			<div class="job-ad-contents scrollspy">
				<div class="job-ad-row">
					<!-- 기업소개영상 -->
					<div class="job-ad-lt">
						<code value="C0700"></code>
					</div>
					<div class="job-ad-rt">
						<input type="hidden" value="C0700" name="jobFileList[0].fap_job_file_gb">
						<input type="file" name="jobFileList[0].job_ad_file" id="job_ad_file_video" accept="video/*">
						<label for="job_ad_file_video"><spring:message code="fap.placeholder.video_size" /></label>
					</div>
				</div>
				
				<div class="job-ad-row">
					<!-- 기업소개자료 -->
					<div class="job-ad-lt">
						<code value="C0701"></code>
					</div>
					<div class="job-ad-rt">
						<input type="hidden" value="C0701" name="jobFileList[1].fap_job_file_gb">	
						<input type="file" name="jobFileList[1].job_ad_file" id="job_ad_file_pdf" accept=".pdf">
						<label for="job_ad_file_pdf"><spring:message code="fap.placeholder.file_size" /></label>
					</div>
				</div>
				
				<div class="job-ad-row">
					<!-- 기업소개사진 -->
					<div class="job-ad-lt">
						<code value="C0702"></code>
					</div>
					<div class="job-ad-rt">
						<input type="hidden" value="C0702" name="jobFileList[2].fap_job_file_gb">	
						<input type="file" name="jobFileList[2].job_ad_file" id="job_ad_file_img" accept="image/*">
						<label for="job_ad_file_img"><spring:message code="fap.placeholder.file_size" /></label>
					</div>
				</div>
			</div>
		</div>
		
		
		<div id="etc" class="job-ad-box scrollspy">
			<div class="job-ad-hd">
				<p class="job-ad-hd-tx">
					<spring:message code="fap.common.etc" />
		       	</p>
			</div>
			<div class="job-ad-contents scrollspy">
				<div class="job-ad-row etc">
					<!-- SCIT 마스터 성적 필요 -->
					<h4><spring:message code="fap.jobad.etc.grade" /></h4>
					<span class="job-radio etc-grade yes">
						<label class="job-radio-label">
							<spring:message code="fap.jobad.etc.yes" />
						</label>
						<input type="radio" name="fap_job_ad_open_grade" value="C1600"/>
					</span>
					<span class="job-radio etc-grade no">
						<label class="job-radio-label">
							<spring:message code="fap.jobad.etc.no" />
						</label>
						<input type="radio" name="fap_job_ad_open_grade" value="C1601"/>
					</span>
				</div>
				
				<div class="job-ad-row etc">
					<!-- 재류자격 신청 시, 정보처리기사(산업기사) 필요 -->
					<h4><spring:message code="fap.jobad.etc.qual_dpe" /></h4>
					<span class="job-radio etc-qual_dpe yes">
						<label class="job-radio-label">
							<spring:message code="fap.jobad.etc.yes" />
						</label>
						<input type="radio" name="fap_job_ad_qual_dpe" value="C1700"/>
					</span>
					<span class="job-radio etc-qual_dpe no">
						<label class="job-radio-label">
							<spring:message code="fap.jobad.etc.no" />
						</label>
						<input type="radio" name="fap_job_ad_qual_dpe" value="C1701"/>
					</span>
				</div>
				
				<div class="job-ad-row etc">
					<!-- 채용조건으로서 정보처리기사(산업기사) 필요 -->
					<h4><spring:message code="fap.jobad.etc.terms_dpe" /></h4>
					<span class="job-radio etc-terms_dpe yes">
						<label class="job-radio-label">
							<spring:message code="fap.jobad.etc.yes" />
						</label>
						<input type="radio" name="fap_job_ad_terms_dpe" value="C1800"/>
					</span>
					<span class="job-radio etc-terms_dpe no">
						<label class="job-radio-label">
							<spring:message code="fap.jobad.etc.no" />
						</label>
						<input type="radio" name="fap_job_ad_terms_dpe" value="C1801"/>
					</span>
				</div>
				
				<div class="job-ad-row etc">
					<!-- 중복지원 여부 -->
					<h4><spring:message code="fap.jobad.etc.overlap" /></h4>
					<span class="job-radio etc-overlap yes">
						<label class="job-radio-label">
							<spring:message code="fap.jobad.etc.yes" />
						</label>
						<input type="radio" name="fap_job_ad_overlap" value="C2000"/>
					</span>
					<span class="job-radio etc-overlap no">
						<label class="job-radio-label">
							<spring:message code="fap.jobad.etc.no" />
						</label>
						<input type="radio" name="fap_job_ad_overlap" value="C2001"/>
					</span>
				</div>
				
				<div class="job-ad-row etc">
					<!-- 채용 시, SCIT 마스터 과정 수료조건 필수 동의 -->
					<h4><spring:message code="fap.jobad.etc.coc_agree" /></h4>
					<span class="job-radio etc-coc_agree yes">
						<label class="job-radio-label">
							<spring:message code="fap.jobad.etc.yes" />
						</label>
						<input type="radio" id="fap_job_ad_coc_agree" name="fap_job_ad_coc_agree" value="C1900"/>
					</span>
				</div>
				
				<div class="job-ad-row etc">
					<!-- 등록시 승인요청 문구-->
					<h4><spring:message code="fap.jobad.approval_requests.title" /></h4>
				</div>
				
			</div>
		</div>
		<div class="job-ad-btn">
			<button type="button" class="side-btn btn-gradient blue small" onclick="form_check(1);"><spring:message code="fap.jobad.register_jobad" /></button>
			<button type="button" class="side-btn btn-gradient red small" onclick="temp_save();"><spring:message code="fap.jobad.save_temp_jobad" /></button>
			<button type="button" class="side-btn btn-gradient cyan small" onclick="return_list()"><spring:message code="fap.jobfair.main.board.list"/></button>
		</div>
		</form>
		</div>
		<div class="side-bar">
			<div id="side-bar" class="" style="">
				<ul class="section table-of-contents">
	     		  <li><a href="#company_info"><spring:message code="fap.common.responsible_company_info" /></a></li>
			      <li><a href="#hire_info"><spring:message code="fap.jobad.hire_info" /></a></li>
			      <li><a href="#detail"><spring:message code="fap.jobad.detail" /></a></li>
			      <li><a href="#pay_detail"><spring:message code="fap.jobad.pay_detail" /></a></li>
			      <li><a href="#recruit_pcs"><spring:message code="fap.jobad.recruit_pcs"/></a></li>
			      <li><a href="#company_introduction"><spring:message code="fap.jobad.company_introduction"/></a></li>
			      <li><a href="#etc"><spring:message code="fap.common.etc" /></a></li>
			      <li><button class="side-btn btn-gradient red small" onclick="temp_save();"><spring:message code="fap.jobad.save_temp_jobad" /></button></li>
			      <li><button class="side-btn btn-gradient blue small" onclick="form_check(1);"><spring:message code="fap.jobad.register_jobad" /></button></li>
			      <li><button class="side-btn btn-gradient cyan small" onclick="return_list()"><spring:message code="fap.jobfair.main.board.list" /></button></li>
	     		 </ul>
     		 </div>
		</div>
		</div> <!-- subcontents end -->
		<div id="footerdiv">
		</div>
		<%@include file="../common_footer_fap.jsp"%>
	</div>
</body>
</html>
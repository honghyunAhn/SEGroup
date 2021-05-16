<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

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
		$("#job_ad_file_photo").change( function() {
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
		
		// angular.element("#company_job_ad_body").scope().initAccordion();
	});
	//innerHtml용 유효성체크
	function realTimeValidation(){
		//모든 input text trim
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
		
		//fap_job_ad_title
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
			//기업 일문명
			var comp_ja_nm = $("#comp_ja_nm").val();
			if(comp_ja_nm == null || comp_ja_nm == ''){
				
				alert('<spring:message code="fap.err.comp_ja_nm" />');
				$("#comp_ja_nm").focus();
				return false;
			}
			//기업 영문명
			var comp_en_nm = $("#comp_en_nm").val();
			if(comp_en_nm == null || comp_en_nm == ''){
				
				alert('<spring:message code="fap.err.comp_en_nm" />');
				$("#comp_en_nm").focus();
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
			var accordion_header = $('.accordion-header').length;
			if(accordion_header < 1){
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
			_insert_form();
		}
	}
	
	
	var myApp = angular.module('myapp', []);
	
	myApp.controller('JobAdController',['$scope','$compile', function($scope, $compile) {
	
		//주요 업무, 인재상, 기술상세
		var job_ideal_person = '${job_ideal_person}';
		job_ideal_person = job_ideal_person.replace(/(?:\r\n|\r|\n)/g, '\\r\\n');
	    var jobIdealPerson = JSON.parse(job_ideal_person);
	    $scope.jobIdealPerson = JSON.parse(job_ideal_person);
	    
		// 채용공고 기본 정보
		var job_ad = '${job_ad}';
		job_ad = job_ad.replace(/(?:\r\n|\r|\n)/g, '\\r\\n');
	    var jobAd = JSON.parse(job_ad);
	    $scope.jobAd = JSON.parse(job_ad);
		
		// 채용전형, 시험전형, 시험종류, 시험준비물, 시험감독관, 시험대상자, 시험문제파일
		var job_recruit_pcs = '${job_recruit_pcs}';
		job_recruit_pcs = job_recruit_pcs.replace(/(?:\r\n|\r|\n)/g, '\\r\\n');
	    var jobRecruitPcs = JSON.parse(job_recruit_pcs);
	    $scope.jobRecruitPcs = JSON.parse(job_recruit_pcs);
	   
		// 급여정보
		var jobAd_pay = '${jobAd_pay}';
	    jobAd_pay = jobAd_pay.replace(/(?:\r\n|\r|\n)/g, '\\r\\n');
	    var jobAdPay = JSON.parse(jobAd_pay);
	    $scope.jobAdPay = JSON.parse(jobAd_pay);
		
		// 기본 고용정보
		var jobAd_category = '${jobAd_category}';
		jobAd_category = jobAd_category.replace(/(?:\r\n|\r|\n)/g, '\\r\\n');
	    var jobAdCategory = JSON.parse(jobAd_category);
	    $scope.jobAdCategory = JSON.parse(jobAd_category);

	    //기업소개 파일 정보
	    var job_file = JSON.parse('${job_file}');
	    console.log(job_file);
	    
		//시험 파일 경로
	    var job_exam_file_path = '${job_exam_file_path}';

		/* 기업정보 */
		//회사명
		for(var i=0; i<jobAdCategory.JobCompList.length; i++){
			//영문명
			if(jobAdCategory.JobCompList[i].fap_job_comp_gb == 'C0200'){
				$("#comp_en_nm").val(jobAdCategory.JobCompList[i].fap_job_comp_nm);
			}
			//일문명
			if(jobAdCategory.JobCompList[i].fap_job_comp_gb == 'C0201'){
				$("#comp_ja_nm").val(jobAdCategory.JobCompList[i].fap_job_comp_nm);
			}
		}	
		
		/* 고용정보 */
		//모집직종
		if(jobAd.fap_job_ad_category_type != null){
			
			//ICT 계열
			if(jobAd.fap_job_ad_category_type == 'C5400'){
				$("#categoty_type_ict").parent().addClass("ck");
				$(".ict-area").toggleClass("category-none");
			}
			//기전계 등 기타계열
			else if(jobAd.fap_job_ad_category_type == 'C5401'){
				$("#categoty_type_etc").parent().addClass("ck");
				$(".etc-area").toggleClass("category-none");
			}
		}
		
		for(var i=0; i<jobAdCategory.JobCategoryList.length; i++){
			//시스템 엔지니어
			if(jobAdCategory.JobCategoryList[i].fap_job_category_gb == 'C3700'){
				$("input:checkbox[name='jobCategoryList[0].fap_job_category_gb']").prop("checked", true);
				$("input:checkbox[name='jobCategoryList[0].fap_job_category_gb']").parent().addClass("ck");
			}
			//네트워크 엔지니어
			if(jobAdCategory.JobCategoryList[i].fap_job_category_gb == 'C3701'){
				$("input:checkbox[name='jobCategoryList[1].fap_job_category_gb']").prop("checked", true);
				$("input:checkbox[name='jobCategoryList[1].fap_job_category_gb']").parent().addClass("ck");
			}
			//프로그래머
			if(jobAdCategory.JobCategoryList[i].fap_job_category_gb == 'C3702'){
				$("input:checkbox[name='jobCategoryList[2].fap_job_category_gb']").prop("checked", true);
				$("input:checkbox[name='jobCategoryList[2].fap_job_category_gb']").parent().addClass("ck");
			}
			//시스템 운용, 보호
			if(jobAdCategory.JobCategoryList[i].fap_job_category_gb == 'C3703'){
				$("input:checkbox[name='jobCategoryList[3].fap_job_category_gb']").prop("checked", true);
				$("input:checkbox[name='jobCategoryList[3].fap_job_category_gb']").parent().addClass("ck");
			}
			//기타
			if(jobAdCategory.JobCategoryList[i].fap_job_category_gb == 'C3704'){
				$("input:checkbox[name='jobCategoryList[4].fap_job_category_gb']").prop("checked", true);
				$("input:checkbox[name='jobCategoryList[4].fap_job_category_gb']").parent().addClass("ck");
				/* $("textarea[name='jobCategoryList[4].JobCategoryEtc.fap_job_category_etc_dtl']").parents(".sub-area").find(".sub-area-inner").show(); */
				$("textarea[name='jobCategoryList[4].JobCategoryEtc.fap_job_category_etc_dtl']").val(jobAdCategory.JobCategoryList[i].fap_job_category_dtl);				
				$(".etc-context").toggleClass("category-none");
			}
			//영업
			if(jobAdCategory.JobCategoryList[i].fap_job_category_gb == 'C3705'){
				$("input:checkbox[name='jobCategoryList[5].fap_job_category_gb']").prop("checked", true);
				$("input:checkbox[name='jobCategoryList[5].fap_job_category_gb']").parent().addClass("ck");
			}
			//기획,마케팅
			if(jobAdCategory.JobCategoryList[i].fap_job_category_gb == 'C3706'){
				$("input:checkbox[name='jobCategoryList[6].fap_job_category_gb']").prop("checked", true);
				$("input:checkbox[name='jobCategoryList[6].fap_job_category_gb']").parent().addClass("ck");
			}
			//서비스,판매
			if(jobAdCategory.JobCategoryList[i].fap_job_category_gb == 'C3707'){
				$("input:checkbox[name='jobCategoryList[7].fap_job_category_gb']").prop("checked", true);
				$("input:checkbox[name='jobCategoryList[7].fap_job_category_gb']").parent().addClass("ck");
			}
			//사무,관리
			if(jobAdCategory.JobCategoryList[i].fap_job_category_gb == 'C3708'){
				$("input:checkbox[name='jobCategoryList[8].fap_job_category_gb']").prop("checked", true);
				$("input:checkbox[name='jobCategoryList[8].fap_job_category_gb']").parent().addClass("ck");
			}
			//건축,토목
			if(jobAdCategory.JobCategoryList[i].fap_job_category_gb == 'C3709'){
				$("input:checkbox[name='jobCategoryList[9].fap_job_category_gb']").prop("checked", true);
				$("input:checkbox[name='jobCategoryList[9].fap_job_category_gb']").parent().addClass("ck");
			}
			//기계,전기,전자
			if(jobAdCategory.JobCategoryList[i].fap_job_category_gb == 'C3710'){
				$("input:checkbox[name='jobCategoryList[10].fap_job_category_gb']").prop("checked", true);
				$("input:checkbox[name='jobCategoryList[10].fap_job_category_gb']").parent().addClass("ck");
			}
		}
				
		//입사예정시기
		for(var i=0; i<jobAdCategory.JobJoinDtList.length; i++){
			//금년도하반기
			if(jobAdCategory.JobJoinDtList[i].fap_job_join_dt_gb == 'C1500'){
				$("input:checkbox[name='jobJoinDtList[0].fap_job_join_dt_gb']").prop("checked", true);
				$("input:checkbox[name='jobJoinDtList[0].fap_job_join_dt_gb']").parent().addClass("ck");
				if(jobAdCategory.JobJoinDtList[i].fap_job_join_dt_dtl != null && jobAdCategory.JobJoinDtList[i].fap_job_join_dt_dtl != ''){
					$("textarea[name='jobJoinDtList[0].fap_job_join_dt_dtl']").parents(".sub-area").find(".sub-area-inner").show();
					$("textarea[name='jobJoinDtList[0].fap_job_join_dt_dtl']").val(jobAdCategory.JobJoinDtList[i].fap_job_join_dt_dtl);	
				}
			}
			//내년도상반기
			if(jobAdCategory.JobJoinDtList[i].fap_job_join_dt_gb == 'C1501'){
				$("input:checkbox[name='jobJoinDtList[1].fap_job_join_dt_gb']").prop("checked", true);
				$("input:checkbox[name='jobJoinDtList[1].fap_job_join_dt_gb']").parent().addClass("ck");
				if(jobAdCategory.JobJoinDtList[i].fap_job_join_dt_dtl != null && jobAdCategory.JobJoinDtList[i].fap_job_join_dt_dtl != ''){
					$("textarea[name='jobJoinDtList[1].fap_job_join_dt_dtl']").parents(".sub-area").find(".sub-area-inner").show();
					$("textarea[name='jobJoinDtList[1].fap_job_join_dt_dtl']").val(jobAdCategory.JobJoinDtList[i].fap_job_join_dt_dtl);	
				}
			}
		}
		
		//고용형태
		if(jobAdCategory.fap_job_ad_hire_type != null){
			//정사원	
			if(jobAdCategory.fap_job_ad_hire_type == 'C0400'){
				$("#hire_type_regular").parent().addClass("ck");
			}
			//계약사원
			if(jobAdCategory.fap_job_ad_hire_type == 'C0401'){
				$("#hire_type_contract").parent().addClass("ck");
				$("#hire_type_contract").parents(".sub-area").find(".sub-area-inner").show();
				$(".emp-contract").css("display","block");
				if(jobAdCategory.JobJitList[0] != null){
					//정사원 전환 가능성 있음
					if(jobAdCategory.JobJitList[0].fap_job_jit_employee_isswitch == 'C3800'){
						$("#emp_switch_yes").parent().addClass("ck");
					}
					//정사원 전환 가능성 없음
					if(jobAdCategory.JobJitList[0].fap_job_jit_employee_isswitch == 'C3801'){
						$("#emp_switch_no").parent().addClass("ck");
					}
					//정사원 전환 가능성 미정
					if(jobAdCategory.JobJitList[0].fap_job_jit_employee_isswitch == 'C3802'){
						$("#emp_switch_yet").parent().addClass("ck");
					}
				}
			}
		}		
		
		//근무예정지
		for(var i=0; i<jobAdCategory.JobWorkplaceList.length; i++){
			//홋카이도, 토호쿠
			if(jobAdCategory.JobWorkplaceList[i].fap_job_workplace_gb == 'C3900'){
				$scope.workplace_hokkaido_tohoku = jobAdCategory.JobWorkplaceList[i].fap_job_workplace_gb;
				$("input:checkbox[name='jobWorkplaceList[0].fap_job_workplace_gb']").parent().addClass("ck");
				$("input:checkbox[name='jobWorkplaceList[0].fap_job_workplace_gb']").prop("checked", true);
				$(".area-work").find(".sub-area-inner").eq(0).show();
				//훗카이도, 토호쿠 세부 근무예정지
				for(var j=0; j<jobAdCategory.JobWorkplaceList[i].JobWorkplaceDtlList.length; j++){
					//훗카이도
					if(jobAdCategory.JobWorkplaceList[i].JobWorkplaceDtlList[j].fap_job_workplace_dtl_gb == 'C4000'){
						$scope.workplace_dtl_hokkaido = jobAdCategory.JobWorkplaceList[i].JobWorkplaceDtlList[j].fap_job_workplace_dtl_gb;
						$("input:checkbox[name='jobWorkplaceList[0].jobWorkplaceDtl.jobWorkplaceDtlList[0].fap_job_workplace_dtl_gb']").parent().addClass("ck");
						$("input:checkbox[name='jobWorkplaceList[0].jobWorkplaceDtl.jobWorkplaceDtlList[0].fap_job_workplace_dtl_gb']").prop("checked", true);						
					}
					//아오모리 현
					if(jobAdCategory.JobWorkplaceList[i].JobWorkplaceDtlList[j].fap_job_workplace_dtl_gb == 'C4001'){
						$scope.workplace_dtl_aomori = jobAdCategory.JobWorkplaceList[i].JobWorkplaceDtlList[j].fap_job_workplace_dtl_gb;
						$("input:checkbox[name='jobWorkplaceList[0].jobWorkplaceDtl.jobWorkplaceDtlList[1].fap_job_workplace_dtl_gb']").parent().addClass("ck");
						$("input:checkbox[name='jobWorkplaceList[0].jobWorkplaceDtl.jobWorkplaceDtlList[1].fap_job_workplace_dtl_gb']").prop("checked", true);						
					}
					//이와테 현
					if(jobAdCategory.JobWorkplaceList[i].JobWorkplaceDtlList[j].fap_job_workplace_dtl_gb == 'C4002'){
						$scope.workplace_dtl_iwate = jobAdCategory.JobWorkplaceList[i].JobWorkplaceDtlList[j].fap_job_workplace_dtl_gb;
						$("input:checkbox[name='jobWorkplaceList[0].jobWorkplaceDtl.jobWorkplaceDtlList[2].fap_job_workplace_dtl_gb']").parent().addClass("ck");
						$("input:checkbox[name='jobWorkplaceList[0].jobWorkplaceDtl.jobWorkplaceDtlList[2].fap_job_workplace_dtl_gb']").prop("checked", true);						
					}
					//미야기 현
					if(jobAdCategory.JobWorkplaceList[i].JobWorkplaceDtlList[j].fap_job_workplace_dtl_gb == 'C4003'){
						$scope.workplace_dtl_miyagi = jobAdCategory.JobWorkplaceList[i].JobWorkplaceDtlList[j].fap_job_workplace_dtl_gb;
						$("input:checkbox[name='jobWorkplaceList[0].jobWorkplaceDtl.jobWorkplaceDtlList[3].fap_job_workplace_dtl_gb']").parent().addClass("ck");
						$("input:checkbox[name='jobWorkplaceList[0].jobWorkplaceDtl.jobWorkplaceDtlList[3].fap_job_workplace_dtl_gb']").prop("checked", true);						
					}
					//아키타 현
					if(jobAdCategory.JobWorkplaceList[i].JobWorkplaceDtlList[j].fap_job_workplace_dtl_gb == 'C4004'){
						$scope.workplace_dtl_akita = jobAdCategory.JobWorkplaceList[i].JobWorkplaceDtlList[j].fap_job_workplace_dtl_gb;
						$("input:checkbox[name='jobWorkplaceList[0].jobWorkplaceDtl.jobWorkplaceDtlList[4].fap_job_workplace_dtl_gb']").parent().addClass("ck");
						$("input:checkbox[name='jobWorkplaceList[0].jobWorkplaceDtl.jobWorkplaceDtlList[4].fap_job_workplace_dtl_gb']").prop("checked", true);						
					}
					//야마가타 현
					if(jobAdCategory.JobWorkplaceList[i].JobWorkplaceDtlList[j].fap_job_workplace_dtl_gb == 'C4005'){
						$scope.workplace_dtl_yamagata= jobAdCategory.JobWorkplaceList[i].JobWorkplaceDtlList[j].fap_job_workplace_dtl_gb;
						$("input:checkbox[name='jobWorkplaceList[0].jobWorkplaceDtl.jobWorkplaceDtlList[5].fap_job_workplace_dtl_gb']").parent().addClass("ck");
						$("input:checkbox[name='jobWorkplaceList[0].jobWorkplaceDtl.jobWorkplaceDtlList[5].fap_job_workplace_dtl_gb']").prop("checked", true);						
					}
					//후쿠시마 현
					if(jobAdCategory.JobWorkplaceList[i].JobWorkplaceDtlList[j].fap_job_workplace_dtl_gb == 'C4006'){
						$scope.workplace_dtl_fukushima= jobAdCategory.JobWorkplaceList[i].JobWorkplaceDtlList[j].fap_job_workplace_dtl_gb;
						$("input:checkbox[name='jobWorkplaceList[0].jobWorkplaceDtl.jobWorkplaceDtlList[6].fap_job_workplace_dtl_gb']").parent().addClass("ck");
						$("input:checkbox[name='jobWorkplaceList[0].jobWorkplaceDtl.jobWorkplaceDtlList[6].fap_job_workplace_dtl_gb']").prop("checked", true);						
					}
				}
			}
			//칸토
			if(jobAdCategory.JobWorkplaceList[i].fap_job_workplace_gb == 'C3901'){
				$scope.workplace_kanto = jobAdCategory.JobWorkplaceList[i].fap_job_workplace_gb;
				$("input:checkbox[name='jobWorkplaceList[1].fap_job_workplace_gb']").parent().addClass("ck");
				$("input:checkbox[name='jobWorkplaceList[1].fap_job_workplace_gb']").prop("checked", true);
				$(".area-work").find(".sub-area-inner").eq(1).show();
				//칸토 세부 근무예정지
				for(var j=0; j<jobAdCategory.JobWorkplaceList[i].JobWorkplaceDtlList.length; j++){
					//이바라키
					if(jobAdCategory.JobWorkplaceList[i].JobWorkplaceDtlList[j].fap_job_workplace_dtl_gb == 'C4007'){
						$scope.workplace_dtl_ibaraki = jobAdCategory.JobWorkplaceList[i].JobWorkplaceDtlList[j].fap_job_workplace_dtl_gb;
						$("input:checkbox[name='jobWorkplaceList[1].jobWorkplaceDtl.jobWorkplaceDtlList[0].fap_job_workplace_dtl_gb']").parent().addClass("ck");
						$("input:checkbox[name='jobWorkplaceList[1].jobWorkplaceDtl.jobWorkplaceDtlList[0].fap_job_workplace_dtl_gb']").prop("checked", true);						
					}
					//토치키
					if(jobAdCategory.JobWorkplaceList[i].JobWorkplaceDtlList[j].fap_job_workplace_dtl_gb == 'C4008'){
						$scope.workplace_dtl_tochigi = jobAdCategory.JobWorkplaceList[i].JobWorkplaceDtlList[j].fap_job_workplace_dtl_gb;
						$("input:checkbox[name='jobWorkplaceList[1].jobWorkplaceDtl.jobWorkplaceDtlList[1].fap_job_workplace_dtl_gb']").parent().addClass("ck");
						$("input:checkbox[name='jobWorkplaceList[1].jobWorkplaceDtl.jobWorkplaceDtlList[1].fap_job_workplace_dtl_gb']").prop("checked", true);						
					}
					//군마
					if(jobAdCategory.JobWorkplaceList[i].JobWorkplaceDtlList[j].fap_job_workplace_dtl_gb == 'C4009'){
						$scope.workplace_dtl_gunma = jobAdCategory.JobWorkplaceList[i].JobWorkplaceDtlList[j].fap_job_workplace_dtl_gb;
						$("input:checkbox[name='jobWorkplaceList[1].jobWorkplaceDtl.jobWorkplaceDtlList[2].fap_job_workplace_dtl_gb']").parent().addClass("ck");
						$("input:checkbox[name='jobWorkplaceList[1].jobWorkplaceDtl.jobWorkplaceDtlList[2].fap_job_workplace_dtl_gb']").prop("checked", true);						
					}
					//사이타마
					if(jobAdCategory.JobWorkplaceList[i].JobWorkplaceDtlList[j].fap_job_workplace_dtl_gb == 'C4010'){
						$scope.workplace_dtl_saitama = jobAdCategory.JobWorkplaceList[i].JobWorkplaceDtlList[j].fap_job_workplace_dtl_gb;
						$("input:checkbox[name='jobWorkplaceList[1].jobWorkplaceDtl.jobWorkplaceDtlList[3].fap_job_workplace_dtl_gb']").parent().addClass("ck");
						$("input:checkbox[name='jobWorkplaceList[1].jobWorkplaceDtl.jobWorkplaceDtlList[3].fap_job_workplace_dtl_gb']").prop("checked", true);						
					}
					//치바
					if(jobAdCategory.JobWorkplaceList[i].JobWorkplaceDtlList[j].fap_job_workplace_dtl_gb == 'C4011'){
						$scope.workplace_dtl_chiba = jobAdCategory.JobWorkplaceList[i].JobWorkplaceDtlList[j].fap_job_workplace_dtl_gb;
						$("input:checkbox[name='jobWorkplaceList[1].jobWorkplaceDtl.jobWorkplaceDtlList[4].fap_job_workplace_dtl_gb']").parent().addClass("ck");
						$("input:checkbox[name='jobWorkplaceList[1].jobWorkplaceDtl.jobWorkplaceDtlList[4].fap_job_workplace_dtl_gb']").prop("checked", true);						
					}
					//도쿄
					if(jobAdCategory.JobWorkplaceList[i].JobWorkplaceDtlList[j].fap_job_workplace_dtl_gb == 'C4012'){
						$scope.workplace_dtl_tokyo = jobAdCategory.JobWorkplaceList[i].JobWorkplaceDtlList[j].fap_job_workplace_dtl_gb;
						$("input:checkbox[name='jobWorkplaceList[1].jobWorkplaceDtl.jobWorkplaceDtlList[5].fap_job_workplace_dtl_gb']").parent().addClass("ck");
						$("input:checkbox[name='jobWorkplaceList[1].jobWorkplaceDtl.jobWorkplaceDtlList[5].fap_job_workplace_dtl_gb']").prop("checked", true);						
					}
					//카나가와
					if(jobAdCategory.JobWorkplaceList[i].JobWorkplaceDtlList[j].fap_job_workplace_dtl_gb == 'C4013'){
						$scope.workplace_dtl_kanagawa = jobAdCategory.JobWorkplaceList[i].JobWorkplaceDtlList[j].fap_job_workplace_dtl_gb;
						$("input:checkbox[name='jobWorkplaceList[1].jobWorkplaceDtl.jobWorkplaceDtlList[6].fap_job_workplace_dtl_gb']").parent().addClass("ck");
						$("input:checkbox[name='jobWorkplaceList[1].jobWorkplaceDtl.jobWorkplaceDtlList[6].fap_job_workplace_dtl_gb']").prop("checked", true);						
					}
				}
			}			
			//호쿠리쿠, 코우신에츠
			if(jobAdCategory.JobWorkplaceList[i].fap_job_workplace_gb == 'C3902'){
				$scope.workplace_hokuriku_koushinetsu = jobAdCategory.JobWorkplaceList[i].fap_job_workplace_gb;
				$("input:checkbox[name='jobWorkplaceList[2].fap_job_workplace_gb']").parent().addClass("ck");
				$("input:checkbox[name='jobWorkplaceList[2].fap_job_workplace_gb']").prop("checked", true);
				$(".area-work").find(".sub-area-inner").eq(2).show();
				//호쿠리쿠, 코우신에츠 세부 근무예정지
				for(var j=0; j<jobAdCategory.JobWorkplaceList[i].JobWorkplaceDtlList.length; j++){
					//니가타
					if(jobAdCategory.JobWorkplaceList[i].JobWorkplaceDtlList[j].fap_job_workplace_dtl_gb == 'C4014'){
						$scope.workplace_dtl_nigata = jobAdCategory.JobWorkplaceList[i].JobWorkplaceDtlList[j].fap_job_workplace_dtl_gb;
						$("input:checkbox[name='jobWorkplaceList[2].jobWorkplaceDtl.jobWorkplaceDtlList[0].fap_job_workplace_dtl_gb']").parent().addClass("ck");
						$("input:checkbox[name='jobWorkplaceList[2].jobWorkplaceDtl.jobWorkplaceDtlList[0].fap_job_workplace_dtl_gb']").prop("checked", true);						
					}
					//토야마
					if(jobAdCategory.JobWorkplaceList[i].JobWorkplaceDtlList[j].fap_job_workplace_dtl_gb == 'C4015'){
						$scope.workplace_dtl_toyama = jobAdCategory.JobWorkplaceList[i].JobWorkplaceDtlList[j].fap_job_workplace_dtl_gb;
						$("input:checkbox[name='jobWorkplaceList[2].jobWorkplaceDtl.jobWorkplaceDtlList[1].fap_job_workplace_dtl_gb']").parent().addClass("ck");
						$("input:checkbox[name='jobWorkplaceList[2].jobWorkplaceDtl.jobWorkplaceDtlList[1].fap_job_workplace_dtl_gb']").prop("checked", true);						
					}
					//이시카와
					if(jobAdCategory.JobWorkplaceList[i].JobWorkplaceDtlList[j].fap_job_workplace_dtl_gb == 'C4016'){
						$scope.workplace_dtl_ishikawa = jobAdCategory.JobWorkplaceList[i].JobWorkplaceDtlList[j].fap_job_workplace_dtl_gb;
						$("input:checkbox[name='jobWorkplaceList[2].jobWorkplaceDtl.jobWorkplaceDtlList[2].fap_job_workplace_dtl_gb']").parent().addClass("ck");
						$("input:checkbox[name='jobWorkplaceList[2].jobWorkplaceDtl.jobWorkplaceDtlList[2].fap_job_workplace_dtl_gb']").prop("checked", true);						
					}
					//후쿠이
					if(jobAdCategory.JobWorkplaceList[i].JobWorkplaceDtlList[j].fap_job_workplace_dtl_gb == 'C4017'){
						$scope.workplace_dtl_hukui = jobAdCategory.JobWorkplaceList[i].JobWorkplaceDtlList[j].fap_job_workplace_dtl_gb;
						$("input:checkbox[name='jobWorkplaceList[2].jobWorkplaceDtl.jobWorkplaceDtlList[3].fap_job_workplace_dtl_gb']").parent().addClass("ck");
						$("input:checkbox[name='jobWorkplaceList[2].jobWorkplaceDtl.jobWorkplaceDtlList[3].fap_job_workplace_dtl_gb']").prop("checked", true);						
					}
					//야마나시
					if(jobAdCategory.JobWorkplaceList[i].JobWorkplaceDtlList[j].fap_job_workplace_dtl_gb == 'C4018'){
						$scope.workplace_dtl_yamanashi = jobAdCategory.JobWorkplaceList[i].JobWorkplaceDtlList[j].fap_job_workplace_dtl_gb;
						$("input:checkbox[name='jobWorkplaceList[2].jobWorkplaceDtl.jobWorkplaceDtlList[4].fap_job_workplace_dtl_gb']").parent().addClass("ck");
						$("input:checkbox[name='jobWorkplaceList[2].jobWorkplaceDtl.jobWorkplaceDtlList[4].fap_job_workplace_dtl_gb']").prop("checked", true);						
					}
					//나가노
					if(jobAdCategory.JobWorkplaceList[i].JobWorkplaceDtlList[j].fap_job_workplace_dtl_gb == 'C4019'){
						$scope.workplace_dtl_nagano = jobAdCategory.JobWorkplaceList[i].JobWorkplaceDtlList[j].fap_job_workplace_dtl_gb;
						$("input:checkbox[name='jobWorkplaceList[2].jobWorkplaceDtl.jobWorkplaceDtlList[5].fap_job_workplace_dtl_gb']").parent().addClass("ck");
						$("input:checkbox[name='jobWorkplaceList[2].jobWorkplaceDtl.jobWorkplaceDtlList[5].fap_job_workplace_dtl_gb']").prop("checked", true);						
					}
				}
			}			
			//토카이
			if(jobAdCategory.JobWorkplaceList[i].fap_job_workplace_gb == 'C3903'){
				$scope.workplace_tokai= jobAdCategory.JobWorkplaceList[i].fap_job_workplace_gb;
				$("input:checkbox[name='jobWorkplaceList[3].fap_job_workplace_gb']").parent().addClass("ck");
				$("input:checkbox[name='jobWorkplaceList[3].fap_job_workplace_gb']").prop("checked", true);
				$(".area-work").find(".sub-area-inner").eq(3).show();
				//토카이 세부 근무예정지
				for(var j=0; j<jobAdCategory.JobWorkplaceList[i].JobWorkplaceDtlList.length; j++){
					//기후
					if(jobAdCategory.JobWorkplaceList[i].JobWorkplaceDtlList[j].fap_job_workplace_dtl_gb == 'C4020'){
						$scope.workplace_dtl_gihu = jobAdCategory.JobWorkplaceList[i].JobWorkplaceDtlList[j].fap_job_workplace_dtl_gb;
						$("input:checkbox[name='jobWorkplaceList[3].jobWorkplaceDtl.jobWorkplaceDtlList[0].fap_job_workplace_dtl_gb']").parent().addClass("ck");
						$("input:checkbox[name='jobWorkplaceList[3].jobWorkplaceDtl.jobWorkplaceDtlList[0].fap_job_workplace_dtl_gb']").prop("checked", true);						
					}
					//시즈오카
					if(jobAdCategory.JobWorkplaceList[i].JobWorkplaceDtlList[j].fap_job_workplace_dtl_gb == 'C4021'){
						$scope.workplace_dtl_shizuoka = jobAdCategory.JobWorkplaceList[i].JobWorkplaceDtlList[j].fap_job_workplace_dtl_gb;
						$("input:checkbox[name='jobWorkplaceList[3].jobWorkplaceDtl.jobWorkplaceDtlList[1].fap_job_workplace_dtl_gb']").parent().addClass("ck");
						$("input:checkbox[name='jobWorkplaceList[3].jobWorkplaceDtl.jobWorkplaceDtlList[1].fap_job_workplace_dtl_gb']").prop("checked", true);						
					}
					//아이치
					if(jobAdCategory.JobWorkplaceList[i].JobWorkplaceDtlList[j].fap_job_workplace_dtl_gb == 'C4022'){
						$scope.workplace_dtl_aichi = jobAdCategory.JobWorkplaceList[i].JobWorkplaceDtlList[j].fap_job_workplace_dtl_gb;
						$("input:checkbox[name='jobWorkplaceList[3].jobWorkplaceDtl.jobWorkplaceDtlList[2].fap_job_workplace_dtl_gb']").parent().addClass("ck");
						$("input:checkbox[name='jobWorkplaceList[3].jobWorkplaceDtl.jobWorkplaceDtlList[2].fap_job_workplace_dtl_gb']").prop("checked", true);						
					}
					//미에
					if(jobAdCategory.JobWorkplaceList[i].JobWorkplaceDtlList[j].fap_job_workplace_dtl_gb == 'C4023'){
						$scope.workplace_dtl_mie = jobAdCategory.JobWorkplaceList[i].JobWorkplaceDtlList[j].fap_job_workplace_dtl_gb;
						$("input:checkbox[name='jobWorkplaceList[3].jobWorkplaceDtl.jobWorkplaceDtlList[3].fap_job_workplace_dtl_gb']").parent().addClass("ck");
						$("input:checkbox[name='jobWorkplaceList[3].jobWorkplaceDtl.jobWorkplaceDtlList[3].fap_job_workplace_dtl_gb']").prop("checked", true);						
					}
				}
			}
			//킨키
			if(jobAdCategory.JobWorkplaceList[i].fap_job_workplace_gb == 'C3904'){
				$scope.workplace_kinki= jobAdCategory.JobWorkplaceList[i].fap_job_workplace_gb;
				$("input:checkbox[name='jobWorkplaceList[4].fap_job_workplace_gb']").parent().addClass("ck");
				$("input:checkbox[name='jobWorkplaceList[4].fap_job_workplace_gb']").prop("checked", true);
				$(".area-work").find(".sub-area-inner").eq(4).show();
				//킨키 세부 근무예정지
				for(var j=0; j<jobAdCategory.JobWorkplaceList[i].JobWorkplaceDtlList.length; j++){
					//시가
					if(jobAdCategory.JobWorkplaceList[i].JobWorkplaceDtlList[j].fap_job_workplace_dtl_gb == 'C4024'){
						$scope.workplace_dtl_shiga = jobAdCategory.JobWorkplaceList[i].JobWorkplaceDtlList[j].fap_job_workplace_dtl_gb;
						$("input:checkbox[name='jobWorkplaceList[4].jobWorkplaceDtl.jobWorkplaceDtlList[0].fap_job_workplace_dtl_gb']").parent().addClass("ck");
						$("input:checkbox[name='jobWorkplaceList[4].jobWorkplaceDtl.jobWorkplaceDtlList[0].fap_job_workplace_dtl_gb']").prop("checked", true);						
					}
					//교토
					if(jobAdCategory.JobWorkplaceList[i].JobWorkplaceDtlList[j].fap_job_workplace_dtl_gb == 'C4025'){
						$scope.workplace_dtl_kyoto = jobAdCategory.JobWorkplaceList[i].JobWorkplaceDtlList[j].fap_job_workplace_dtl_gb;
						$("input:checkbox[name='jobWorkplaceList[4].jobWorkplaceDtl.jobWorkplaceDtlList[1].fap_job_workplace_dtl_gb']").parent().addClass("ck");
						$("input:checkbox[name='jobWorkplaceList[4].jobWorkplaceDtl.jobWorkplaceDtlList[1].fap_job_workplace_dtl_gb']").prop("checked", true);						
					}
					//오사카
					if(jobAdCategory.JobWorkplaceList[i].JobWorkplaceDtlList[j].fap_job_workplace_dtl_gb == 'C4026'){
						$scope.workplace_dtl_osaka = jobAdCategory.JobWorkplaceList[i].JobWorkplaceDtlList[j].fap_job_workplace_dtl_gb;
						$("input:checkbox[name='jobWorkplaceList[4].jobWorkplaceDtl.jobWorkplaceDtlList[2].fap_job_workplace_dtl_gb']").parent().addClass("ck");
						$("input:checkbox[name='jobWorkplaceList[4].jobWorkplaceDtl.jobWorkplaceDtlList[2].fap_job_workplace_dtl_gb']").prop("checked", true);						
					}
					//효고
					if(jobAdCategory.JobWorkplaceList[i].JobWorkplaceDtlList[j].fap_job_workplace_dtl_gb == 'C4027'){
						$scope.workplace_dtl_hyogo = jobAdCategory.JobWorkplaceList[i].JobWorkplaceDtlList[j].fap_job_workplace_dtl_gb;
						$("input:checkbox[name='jobWorkplaceList[4].jobWorkplaceDtl.jobWorkplaceDtlList[3].fap_job_workplace_dtl_gb']").parent().addClass("ck");
						$("input:checkbox[name='jobWorkplaceList[4].jobWorkplaceDtl.jobWorkplaceDtlList[3].fap_job_workplace_dtl_gb']").prop("checked", true);						
					}
					//나라
					if(jobAdCategory.JobWorkplaceList[i].JobWorkplaceDtlList[j].fap_job_workplace_dtl_gb == 'C4028'){
						$scope.workplace_dtl_nara = jobAdCategory.JobWorkplaceList[i].JobWorkplaceDtlList[j].fap_job_workplace_dtl_gb;
						$("input:checkbox[name='jobWorkplaceList[4].jobWorkplaceDtl.jobWorkplaceDtlList[4].fap_job_workplace_dtl_gb']").parent().addClass("ck");
						$("input:checkbox[name='jobWorkplaceList[4].jobWorkplaceDtl.jobWorkplaceDtlList[4].fap_job_workplace_dtl_gb']").prop("checked", true);						
					}
					//와카야마
					if(jobAdCategory.JobWorkplaceList[i].JobWorkplaceDtlList[j].fap_job_workplace_dtl_gb == 'C4029'){
						$scope.workplace_dtl_wakawama = jobAdCategory.JobWorkplaceList[i].JobWorkplaceDtlList[j].fap_job_workplace_dtl_gb;
						$("input:checkbox[name='jobWorkplaceList[4].jobWorkplaceDtl.jobWorkplaceDtlList[5].fap_job_workplace_dtl_gb']").parent().addClass("ck");
						$("input:checkbox[name='jobWorkplaceList[4].jobWorkplaceDtl.jobWorkplaceDtlList[5].fap_job_workplace_dtl_gb']").prop("checked", true);						
					}
				}
			}
			//츄고쿠, 시코쿠
			if(jobAdCategory.JobWorkplaceList[i].fap_job_workplace_gb == 'C3905'){
				$scope.workplace_chukoku_shikoku= jobAdCategory.JobWorkplaceList[i].fap_job_workplace_gb;
				$("input:checkbox[name='jobWorkplaceList[5].fap_job_workplace_gb']").parent().addClass("ck");
				$("input:checkbox[name='jobWorkplaceList[5].fap_job_workplace_gb']").prop("checked", true);
				$(".area-work").find(".sub-area-inner").eq(5).show();
				//츄고쿠, 시코쿠 세부 근무예정지
				for(var j=0; j<jobAdCategory.JobWorkplaceList[i].JobWorkplaceDtlList.length; j++){
					//톳토리
					if(jobAdCategory.JobWorkplaceList[i].JobWorkplaceDtlList[j].fap_job_workplace_dtl_gb == 'C4030'){
						$scope.workplace_dtl_tottori = jobAdCategory.JobWorkplaceList[i].JobWorkplaceDtlList[j].fap_job_workplace_dtl_gb;
						$("input:checkbox[name='jobWorkplaceList[5].jobWorkplaceDtl.jobWorkplaceDtlList[0].fap_job_workplace_dtl_gb']").parent().addClass("ck");
						$("input:checkbox[name='jobWorkplaceList[5].jobWorkplaceDtl.jobWorkplaceDtlList[0].fap_job_workplace_dtl_gb']").prop("checked", true);						
					}
					//시마네
					if(jobAdCategory.JobWorkplaceList[i].JobWorkplaceDtlList[j].fap_job_workplace_dtl_gb == 'C4031'){
						$scope.workplace_dtl_shimane = jobAdCategory.JobWorkplaceList[i].JobWorkplaceDtlList[j].fap_job_workplace_dtl_gb;
						$("input:checkbox[name='jobWorkplaceList[5].jobWorkplaceDtl.jobWorkplaceDtlList[1].fap_job_workplace_dtl_gb']").parent().addClass("ck");
						$("input:checkbox[name='jobWorkplaceList[5].jobWorkplaceDtl.jobWorkplaceDtlList[1].fap_job_workplace_dtl_gb']").prop("checked", true);						
					}
					//오카야마
					if(jobAdCategory.JobWorkplaceList[i].JobWorkplaceDtlList[j].fap_job_workplace_dtl_gb == 'C4032'){
						$scope.workplace_dtl_okayama= jobAdCategory.JobWorkplaceList[i].JobWorkplaceDtlList[j].fap_job_workplace_dtl_gb;
						$("input:checkbox[name='jobWorkplaceList[5].jobWorkplaceDtl.jobWorkplaceDtlList[2].fap_job_workplace_dtl_gb']").parent().addClass("ck");
						$("input:checkbox[name='jobWorkplaceList[5].jobWorkplaceDtl.jobWorkplaceDtlList[2].fap_job_workplace_dtl_gb']").prop("checked", true);						
					}
					//히로시마
					if(jobAdCategory.JobWorkplaceList[i].JobWorkplaceDtlList[j].fap_job_workplace_dtl_gb == 'C4033'){
						$scope.workplace_dtl_hiroshima = jobAdCategory.JobWorkplaceList[i].JobWorkplaceDtlList[j].fap_job_workplace_dtl_gb;
						$("input:checkbox[name='jobWorkplaceList[5].jobWorkplaceDtl.jobWorkplaceDtlList[3].fap_job_workplace_dtl_gb']").parent().addClass("ck");
						$("input:checkbox[name='jobWorkplaceList[5].jobWorkplaceDtl.jobWorkplaceDtlList[3].fap_job_workplace_dtl_gb']").prop("checked", true);						
					}
					//야마구치
					if(jobAdCategory.JobWorkplaceList[i].JobWorkplaceDtlList[j].fap_job_workplace_dtl_gb == 'C4034'){
						$scope.workplace_dtl_yamaguchi = jobAdCategory.JobWorkplaceList[i].JobWorkplaceDtlList[j].fap_job_workplace_dtl_gb;
						$("input:checkbox[name='jobWorkplaceList[5].jobWorkplaceDtl.jobWorkplaceDtlList[4].fap_job_workplace_dtl_gb']").parent().addClass("ck");
						$("input:checkbox[name='jobWorkplaceList[5].jobWorkplaceDtl.jobWorkplaceDtlList[4].fap_job_workplace_dtl_gb']").prop("checked", true);						
					}
					//토쿠시마
					if(jobAdCategory.JobWorkplaceList[i].JobWorkplaceDtlList[j].fap_job_workplace_dtl_gb == 'C4035'){
						$scope.workplace_dtl_tokushima= jobAdCategory.JobWorkplaceList[i].JobWorkplaceDtlList[j].fap_job_workplace_dtl_gb;
						$("input:checkbox[name='jobWorkplaceList[5].jobWorkplaceDtl.jobWorkplaceDtlList[5].fap_job_workplace_dtl_gb']").parent().addClass("ck");
						$("input:checkbox[name='jobWorkplaceList[5].jobWorkplaceDtl.jobWorkplaceDtlList[5].fap_job_workplace_dtl_gb']").prop("checked", true);						
					}
					//카가와
					if(jobAdCategory.JobWorkplaceList[i].JobWorkplaceDtlList[j].fap_job_workplace_dtl_gb == 'C4036'){
						$scope.workplace_dtl_kagawa = jobAdCategory.JobWorkplaceList[i].JobWorkplaceDtlList[j].fap_job_workplace_dtl_gb;
						$("input:checkbox[name='jobWorkplaceList[5].jobWorkplaceDtl.jobWorkplaceDtlList[6].fap_job_workplace_dtl_gb']").parent().addClass("ck");
						$("input:checkbox[name='jobWorkplaceList[5].jobWorkplaceDtl.jobWorkplaceDtlList[6].fap_job_workplace_dtl_gb']").prop("checked", true);						
					}
					//에히메
					if(jobAdCategory.JobWorkplaceList[i].JobWorkplaceDtlList[j].fap_job_workplace_dtl_gb == 'C4037'){
						$scope.workplace_dtl_ehime = jobAdCategory.JobWorkplaceList[i].JobWorkplaceDtlList[j].fap_job_workplace_dtl_gb;
						$("input:checkbox[name='jobWorkplaceList[5].jobWorkplaceDtl.jobWorkplaceDtlList[7].fap_job_workplace_dtl_gb']").parent().addClass("ck");
						$("input:checkbox[name='jobWorkplaceList[5].jobWorkplaceDtl.jobWorkplaceDtlList[7].fap_job_workplace_dtl_gb']").prop("checked", true);						
					}
					//코치
					if(jobAdCategory.JobWorkplaceList[i].JobWorkplaceDtlList[j].fap_job_workplace_dtl_gb == 'C4038'){
						$scope.workplace_dtl_kochi = jobAdCategory.JobWorkplaceList[i].JobWorkplaceDtlList[j].fap_job_workplace_dtl_gb;
						$("input:checkbox[name='jobWorkplaceList[5].jobWorkplaceDtl.jobWorkplaceDtlList[8].fap_job_workplace_dtl_gb']").parent().addClass("ck");
						$("input:checkbox[name='jobWorkplaceList[5].jobWorkplaceDtl.jobWorkplaceDtlList[8].fap_job_workplace_dtl_gb']").prop("checked", true);						
					}
				}
			}
			//큐슈, 오키나와
			if(jobAdCategory.JobWorkplaceList[i].fap_job_workplace_gb == 'C3906'){
				$scope.workplace_kyushu_okinawa= jobAdCategory.JobWorkplaceList[i].fap_job_workplace_gb;
				$("input:checkbox[name='jobWorkplaceList[6].fap_job_workplace_gb']").parent().addClass("ck");
				$("input:checkbox[name='jobWorkplaceList[6].fap_job_workplace_gb']").prop("checked", true);
				$(".area-work").find(".sub-area-inner").eq(6).show();
				//큐슈, 오키나와 세부 근무예정지
				for(var j=0; j<jobAdCategory.JobWorkplaceList[i].JobWorkplaceDtlList.length; j++){
					//후쿠오카
					if(jobAdCategory.JobWorkplaceList[i].JobWorkplaceDtlList[j].fap_job_workplace_dtl_gb == 'C4039'){
						$scope.workplace_dtl_hukuoka = jobAdCategory.JobWorkplaceList[i].JobWorkplaceDtlList[j].fap_job_workplace_dtl_gb;
						$("input:checkbox[name='jobWorkplaceList[6].jobWorkplaceDtl.jobWorkplaceDtlList[0].fap_job_workplace_dtl_gb']").parent().addClass("ck");
						$("input:checkbox[name='jobWorkplaceList[6].jobWorkplaceDtl.jobWorkplaceDtlList[0].fap_job_workplace_dtl_gb']").prop("checked", true);						
					}
					//사가
					if(jobAdCategory.JobWorkplaceList[i].JobWorkplaceDtlList[j].fap_job_workplace_dtl_gb == 'C4040'){
						$scope.workplace_dtl_saga = jobAdCategory.JobWorkplaceList[i].JobWorkplaceDtlList[j].fap_job_workplace_dtl_gb;
						$("input:checkbox[name='jobWorkplaceList[6].jobWorkplaceDtl.jobWorkplaceDtlList[1].fap_job_workplace_dtl_gb']").parent().addClass("ck");
						$("input:checkbox[name='jobWorkplaceList[6].jobWorkplaceDtl.jobWorkplaceDtlList[1].fap_job_workplace_dtl_gb']").prop("checked", true);						
					}
					//나가사키
					if(jobAdCategory.JobWorkplaceList[i].JobWorkplaceDtlList[j].fap_job_workplace_dtl_gb == 'C4041'){
						$scope.workplace_dtl_nagasaki = jobAdCategory.JobWorkplaceList[i].JobWorkplaceDtlList[j].fap_job_workplace_dtl_gb;
						$("input:checkbox[name='jobWorkplaceList[6].jobWorkplaceDtl.jobWorkplaceDtlList[2].fap_job_workplace_dtl_gb']").parent().addClass("ck");
						$("input:checkbox[name='jobWorkplaceList[6].jobWorkplaceDtl.jobWorkplaceDtlList[2].fap_job_workplace_dtl_gb']").prop("checked", true);						
					}
					//쿠마모토
					if(jobAdCategory.JobWorkplaceList[i].JobWorkplaceDtlList[j].fap_job_workplace_dtl_gb == 'C4042'){
						$scope.workplace_dtl_kumamoto = jobAdCategory.JobWorkplaceList[i].JobWorkplaceDtlList[j].fap_job_workplace_dtl_gb;
						$("input:checkbox[name='jobWorkplaceList[6].jobWorkplaceDtl.jobWorkplaceDtlList[3].fap_job_workplace_dtl_gb']").parent().addClass("ck");
						$("input:checkbox[name='jobWorkplaceList[6].jobWorkplaceDtl.jobWorkplaceDtlList[3].fap_job_workplace_dtl_gb']").prop("checked", true);						
					}
					//오이타
					if(jobAdCategory.JobWorkplaceList[i].JobWorkplaceDtlList[j].fap_job_workplace_dtl_gb == 'C4043'){
						$scope.workplace_dtl_oita = jobAdCategory.JobWorkplaceList[i].JobWorkplaceDtlList[j].fap_job_workplace_dtl_gb;
						$("input:checkbox[name='jobWorkplaceList[6].jobWorkplaceDtl.jobWorkplaceDtlList[4].fap_job_workplace_dtl_gb']").parent().addClass("ck");
						$("input:checkbox[name='jobWorkplaceList[6].jobWorkplaceDtl.jobWorkplaceDtlList[4].fap_job_workplace_dtl_gb']").prop("checked", true);						
					}
					//미야자키
					if(jobAdCategory.JobWorkplaceList[i].JobWorkplaceDtlList[j].fap_job_workplace_dtl_gb == 'C4044'){
						$scope.workplace_dtl_miyazaki = jobAdCategory.JobWorkplaceList[i].JobWorkplaceDtlList[j].fap_job_workplace_dtl_gb;
						$("input:checkbox[name='jobWorkplaceList[6].jobWorkplaceDtl.jobWorkplaceDtlList[5].fap_job_workplace_dtl_gb']").parent().addClass("ck");
						$("input:checkbox[name='jobWorkplaceList[6].jobWorkplaceDtl.jobWorkplaceDtlList[5].fap_job_workplace_dtl_gb']").prop("checked", true);						
					}
					//가고시마
					if(jobAdCategory.JobWorkplaceList[i].JobWorkplaceDtlList[j].fap_job_workplace_dtl_gb == 'C4045'){
						$scope.workplace_dtl_gagoshima = jobAdCategory.JobWorkplaceList[i].JobWorkplaceDtlList[j].fap_job_workplace_dtl_gb;
						$("input:checkbox[name='jobWorkplaceList[6].jobWorkplaceDtl.jobWorkplaceDtlList[6].fap_job_workplace_dtl_gb']").parent().addClass("ck");
						$("input:checkbox[name='jobWorkplaceList[6].jobWorkplaceDtl.jobWorkplaceDtlList[6].fap_job_workplace_dtl_gb']").prop("checked", true);						
					}
					//오키나와
					if(jobAdCategory.JobWorkplaceList[i].JobWorkplaceDtlList[j].fap_job_workplace_dtl_gb == 'C4046'){
						$scope.workplace_dtl_okinawa = jobAdCategory.JobWorkplaceList[i].JobWorkplaceDtlList[j].fap_job_workplace_dtl_gb;
						$("input:checkbox[name='jobWorkplaceList[6].jobWorkplaceDtl.jobWorkplaceDtlList[7].fap_job_workplace_dtl_gb']").parent().addClass("ck");
						$("input:checkbox[name='jobWorkplaceList[6].jobWorkplaceDtl.jobWorkplaceDtlList[7].fap_job_workplace_dtl_gb']").prop("checked", true);						
					}
				}
			}
			//전지역
			if(jobAdCategory.JobWorkplaceList[i].fap_job_workplace_gb == 'C3907'){
				$scope.workplace_all_area = jobAdCategory.JobWorkplaceList[i].fap_job_workplace_gb;
				$("input:checkbox[name='jobWorkplaceList[7].fap_job_workplace_gb']").parent().addClass("ck");
				$("input:checkbox[name='jobWorkplaceList[7].fap_job_workplace_gb']").prop("checked", true);				
			}
			//기타
			if(jobAdCategory.JobWorkplaceList[i].fap_job_workplace_gb == 'C3908'){
				$scope.workplace_etc = jobAdCategory.JobWorkplaceList[i].fap_job_workplace_gb;
				$("input:checkbox[name='jobWorkplaceList[8].fap_job_workplace_gb']").parent().addClass("ck");
				$("input:checkbox[name='jobWorkplaceList[8].fap_job_workplace_gb']").prop("checked", true);
				$(".area-work").find(".sub-area-inner").eq(7).show();
			}
		}
		
		//시용기간
		if(jobAdCategory.fap_job_ad_intern != null){
			//시용기간 있음
			if(jobAdCategory.fap_job_ad_intern == 'C0500'){
				$("#intern_yes").parent().addClass("ck");
				$("#intern_yes").prop("checked", true);
				$("#intern_yes").parents('.intern').nextAll(".sub-area").css("display","block");
				//시용기간 급여 같음
				if(jobAdCategory.JobTrialList[0] != null && jobAdCategory.JobTrialList[0].fap_job_trial_pay_equal == 'C2400'){
					$("#trial_pay_equal").parent().addClass("ck");
					$("#trial_pay_equal").prop("checked", true);
				}
				//시용기간 급여 다름
				if(jobAdCategory.JobTrialList[0] != null && jobAdCategory.JobTrialList[0].fap_job_trial_pay_equal == 'C2401'){			
					$("#trial_pay_not_equal").parent().addClass("ck");
					$("#trial_pay_not_equal").prop("checked", true);
				}			
			}
			//시용기간 없음
			if(jobAdCategory.fap_job_ad_intern == 'C0501'){
				$("#intern_no").parent().addClass("ck");
				$("#intern_no").prop("checked", true);
			}
		}
		
		//기숙사, 사택
		if(jobAdPay.fap_job_ad_isdorm != null){
			//기숙사, 사택 있음
			if(jobAdPay.fap_job_ad_isdorm == 'C0800'){
				$("#isdorm_yes").parent().addClass("ck");
				$("#isdorm_yes").parents('.isdorm').nextAll(".sub-area").css("display","block");
			}
			//기숙사, 사택 없음
			if(jobAdPay.fap_job_ad_isdorm == 'C0801'){
				$("#isdorm_no").parent().addClass("ck");
			}
		}		
		
		//보험 및 퇴직금 제도
		for(var i in jobAdPay.JobIsrList){
			//건강보험
			if(jobAdPay.JobIsrList[i].fap_job_isr_gb == 'C0600'){
				$("input:checkbox[name='jobIsrList[0].fap_job_isr_gb']").parent().addClass("ck");
				$("input:checkbox[name='jobIsrList[0].fap_job_isr_gb']").prop("checked", true);
			}
			//후생연금보험
			if(jobAdPay.JobIsrList[i].fap_job_isr_gb == 'C0601'){
				$("input:checkbox[name='jobIsrList[1].fap_job_isr_gb']").parent().addClass("ck");
				$("input:checkbox[name='jobIsrList[1].fap_job_isr_gb']").prop("checked", true);
			}
			//고용보험
			if(jobAdPay.JobIsrList[i].fap_job_isr_gb == 'C0602'){
				$("input:checkbox[name='jobIsrList[2].fap_job_isr_gb']").parent().addClass("ck");
				$("input:checkbox[name='jobIsrList[2].fap_job_isr_gb']").prop("checked", true);
			}
			//산재보험
			if(jobAdPay.JobIsrList[i].fap_job_isr_gb == 'C0603'){
				$("input:checkbox[name='jobIsrList[3].fap_job_isr_gb']").parent().addClass("ck");
				$("input:checkbox[name='jobIsrList[3].fap_job_isr_gb']").prop("checked", true);
			}
			//퇴직금제도
			if(jobAdPay.JobIsrList[i].fap_job_isr_gb == 'C0604'){
				$("input:checkbox[name='jobIsrList[4].fap_job_isr_gb']").parent().addClass("ck");
				$("input:checkbox[name='jobIsrList[4].fap_job_isr_gb']").prop("checked", true);
			}
		}
		
		/* 상세정보 */
		//주요업무
		for(var i in jobIdealPerson.fap_job_work){
			var count = $(".work-type-plus .work-type-content").length;		
			var context = '';
			context +='<div class="work-type-content">';
			context +='<div class="job-ad-contents">';
			context +='<div class="job-ad-row">';
			context +='<div class="job-ad-lt point">';
			if(count == 0)	context += '<spring:message code="fap.jobad.work" /><span class="red-point"></span>';
			context +='</div>';
			context +='<div class="job-ad-rt">';
			context +='<div class="job-ad-dropdown">';
			//자사에서 SI
			if(jobIdealPerson.fap_job_work[i].fap_job_work_gb == 'C0300'){
				context +='<div class="job-ad-select">';
				context +='<button type="button" class="job-ad-select-btn"><code value="C0300"></code></button>';
				context +='<input type="hidden" id="work-gb" name="jobWorkList[' + count + '].fap_job_work_gb" value="C0300">';
				context +='</div>';
			}				
			//타사에서 SI
			if(jobIdealPerson.fap_job_work[i].fap_job_work_gb == 'C0301'){
				context +='<div class="job-ad-select">';
				context +='<button type="button" class="job-ad-select-btn"><code value="C0301"></code></button>';
				context +='<input type="hidden" id="work-gb" name="jobWorkList[' + count + '].fap_job_work_gb" value="C0301">';
				context +='</div>';
			}				
			//자사 솔루션 개발
			if(jobIdealPerson.fap_job_work[i].fap_job_work_gb == 'C0302'){
				context +='<div class="job-ad-select">';
				context +='<button type="button" class="job-ad-select-btn"><code value="C0302"></code></button>';
				context +='<input type="hidden" id="work-gb" name="jobWorkList[' + count + '].fap_job_work_gb" value="C0302">';
				context +='</div>';
			}				
			//그외의 업무
			if(jobIdealPerson.fap_job_work[i].fap_job_work_gb == 'C0303'){
				context +='<div class="job-ad-select">';
				context +='<button type="button" class="job-ad-select-btn"><code value="C0303"></code></button>';
				context +='<input type="hidden" id="work-gb" name="jobWorkList[' + count + '].fap_job_work_gb" value="C0303">';
				context +='</div>';
			}		
			//영업
			if(jobIdealPerson.fap_job_work[i].fap_job_work_gb == 'C0304'){
				context +='<div class="job-ad-select">';
				context +='<button type="button" class="job-ad-select-btn"><code value="C0304"></code></button>';
				context +='<input type="hidden" id="work-gb" name="jobWorkList[' + count + '].fap_job_work_gb" value="C0304">';
				context +='</div>';
			}
			//기획,마케팅
			if(jobIdealPerson.fap_job_work[i].fap_job_work_gb == 'C0305'){
				context +='<div class="job-ad-select">';
				context +='<button type="button" class="job-ad-select-btn"><code value="C0305"></code></button>';
				context +='<input type="hidden" id="work-gb" name="jobWorkList[' + count + '].fap_job_work_gb" value="C0305">';
				context +='</div>';
			}
			//서비스,판매
			if(jobIdealPerson.fap_job_work[i].fap_job_work_gb == 'C0306'){
				context +='<div class="job-ad-select">';
				context +='<button type="button" class="job-ad-select-btn"><code value="C0306"></code></button>';
				context +='<input type="hidden" id="work-gb" name="jobWorkList[' + count + '].fap_job_work_gb" value="C0306">';
				context +='</div>';
			}
			//사무,관리
			if(jobIdealPerson.fap_job_work[i].fap_job_work_gb == 'C0307'){
				context +='<div class="job-ad-select">';
				context +='<button type="button" class="job-ad-select-btn"><code value="C0307"></code></button>';
				context +='<input type="hidden" id="work-gb" name="jobWorkList[' + count + '].fap_job_work_gb" value="C0307">';
				context +='</div>';
			}
			//건축,토목
			if(jobIdealPerson.fap_job_work[i].fap_job_work_gb == 'C0308'){
				context +='<div class="job-ad-select">';
				context +='<button type="button" class="job-ad-select-btn"><code value="C0308"></code></button>';
				context +='<input type="hidden" id="work-gb" name="jobWorkList[' + count + '].fap_job_work_gb" value="C0308">';
				context +='</div>';
			}
			//기계,전기,전자
			if(jobIdealPerson.fap_job_work[i].fap_job_work_gb == 'C0309'){
				context +='<div class="job-ad-select">';
				context +='<button type="button" class="job-ad-select-btn"><code value="C0309"></code></button>';
				context +='<input type="hidden" id="work-gb" name="jobWorkList[' + count + '].fap_job_work_gb" value="C0309">';
				context +='</div>';
			}
			context +='<div class="job-ad-select-option">';
			context +='<ul class="option-list">';
			context +='<li class="work-type selected" ng-if="jobIdealPerson.fap_job_work[i].fap_job_work_gb == \'C0300\' ">';
			context +='<button type="button" work-code="C0300"><code value="C0300"></code></button>';
			context +='</li>';
			context +='<li class="work-type" ng-if="jobIdealPerson.fap_job_work[i].fap_job_work_gb != \'C0300\' ">';
			context +='<button type="button" work-code="C0300"><code value="C0300"></code></button>';
			context +='</li>';
			context +='<li class="work-type selected" ng-if="jobIdealPerson.fap_job_work[i].fap_job_work_gb == \'C0301\' ">';
			context +='<button type="button" work-code="C0301"><code value="C0301"></code></button>';
			context +='</li>';
			context +='<li class="work-type" ng-if="jobIdealPerson.fap_job_work[i].fap_job_work_gb != \'C0301\' ">';
			context +='<button type="button" work-code="C0301"><code value="C0301"></code></button>';
			context +='</li>';
			context +='<li class="work-type selected" ng-if="jobIdealPerson.fap_job_work[i].fap_job_work_gb == \'C0302\' ">';
			context +='<button type="button" work-code="C0302"><code value="C0302"></code></button>';
			context +='</li>';
			context +='<li class="work-type" ng-if="jobIdealPerson.fap_job_work[i].fap_job_work_gb != \'C0302\' ">';
			context +='<button type="button" work-code="C0302"><code value="C0302"></code></button>';
			context +='</li>';
			context +='<li class="work-type selected" ng-if="jobIdealPerson.fap_job_work[i].fap_job_work_gb == \'C0304\' ">';
			context +='<button type="button" work-code="C0304"><code value="C0304"></code></button>';
			context +='</li>';
			context +='<li class="work-type" ng-if="jobIdealPerson.fap_job_work[i].fap_job_work_gb != \'C0304\' ">';
			context +='<button type="button" work-code="C0304"><code value="C0304"></code></button>';
			context +='</li>';
			context +='<li class="work-type selected" ng-if="jobIdealPerson.fap_job_work[i].fap_job_work_gb == \'C0305\' ">';
			context +='<button type="button" work-code="C0305"><code value="C0305"></code></button>';
			context +='</li>';
			context +='<li class="work-type" ng-if="jobIdealPerson.fap_job_work[i].fap_job_work_gb != \'C0305\' ">';
			context +='<button type="button" work-code="C0305"><code value="C0305"></code></button>';
			context +='</li>';
			context +='<li class="work-type selected" ng-if="jobIdealPerson.fap_job_work[i].fap_job_work_gb == \'C0306\' ">';
			context +='<button type="button" work-code="C0306"><code value="C0306"></code></button>';
			context +='</li>';
			context +='<li class="work-type" ng-if="jobIdealPerson.fap_job_work[i].fap_job_work_gb != \'C0306\' ">';
			context +='<button type="button" work-code="C0306"><code value="C0306"></code></button>';
			context +='</li>';
			context +='<li class="work-type selected" ng-if="jobIdealPerson.fap_job_work[i].fap_job_work_gb == \'C0307\' ">';
			context +='<button type="button" work-code="C0307"><code value="C0307"></code></button>';
			context +='</li>';
			context +='<li class="work-type" ng-if="jobIdealPerson.fap_job_work[i].fap_job_work_gb != \'C0307\' ">';
			context +='<button type="button" work-code="C0307"><code value="C0307"></code></button>';
			context +='</li>';
			context +='<li class="work-type selected" ng-if="jobIdealPerson.fap_job_work[i].fap_job_work_gb == \'C0308\' ">';
			context +='<button type="button" work-code="C0308"><code value="C0308"></code></button>';
			context +='</li>';
			context +='<li class="work-type" ng-if="jobIdealPerson.fap_job_work[i].fap_job_work_gb != \'C0308\' ">';
			context +='<button type="button" work-code="C0308"><code value="C0308"></code></button>';
			context +='</li>';
			context +='<li class="work-type selected" ng-if="jobIdealPerson.fap_job_work[i].fap_job_work_gb == \'C0309\' ">';
			context +='<button type="button" work-code="C0309"><code value="C0309"></code></button>';
			context +='</li>';
			context +='<li class="work-type" ng-if="jobIdealPerson.fap_job_work[i].fap_job_work_gb != \'C0309\' ">';
			context +='<button type="button" work-code="C0309"><code value="C0309"></code></button>';
			context +='</li>';
			context +='<li class="work-type selected" ng-if="jobIdealPerson.fap_job_work[i].fap_job_work_gb == \'C0303\' ">';
			context +='<button type="button" work-code="C0303"><code value="C0303"></code></button>';
			context +='</li>';
			context +='<li class="work-type" ng-if="jobIdealPerson.fap_job_work[i].fap_job_work_gb != \'C0303\' ">';
			context +='<button type="button" work-code="C0303"><code value="C0303"></code></button>';
			context +='</li>';
			context +='</ul>';
			context +='</div>';
			context +='</div>';
			context +='<span><spring:message code="fap.jobad.work.select" /></span>';
			context +='</div>';
			context +='</div>';
			context +='<div class="job-ad-row m10">';
			context +='<div class="job-ad-lt bnt-lt">';
			if(count == 0){
				context +='<button type="button" class="btn-add" ng-click="addWork()"></button>';
				context +='<button type="button" class="btn-remove" ng-click="removeWork()"></button>';
			}				
			context +='</div>';
			context +='<div class="job-ad-rt">';
			context +='<textarea rows="4" cols="20" name="jobWorkList[' + count + '].fap_job_work_dtl" maxlength="1000" ng-model="::jobIdealPerson.fap_job_work[' + i + '].fap_job_work_dtl" placeholder="1000<spring:message code="fap.placeholder.limit_characters" />"></textarea>';
			context +='</div>';
			context +='</div>';
			context +='</div>';
			context +='</div>';
			
			$(".work-type-plus").append($compile(context)($scope));
			
			work_event();
		}		
		
		//희망성별
		if(jobIdealPerson.fap_job_ad_gender != null){
			//남성
			if(jobIdealPerson.fap_job_ad_gender == 'C4200'){
				$("#gender_male").parent().addClass("ck");
			}
			//여성
			if(jobIdealPerson.fap_job_ad_gender == 'C4201'){
				$("#gender_female").parent().addClass("ck");
			}
			//성별 불문
			if(jobIdealPerson.fap_job_ad_gender == 'C4202'){
				$("#gender_no_matter").parent().addClass("ck");
			}
		}		
		
		//희망 연령
		if(jobIdealPerson.fap_job_ad_age != null){
			//25세 이하
			if(jobIdealPerson.fap_job_ad_age == 'C1400'){
				$("#under_25_age").parent().addClass("ck");
			}
			//30세 이하
			if(jobIdealPerson.fap_job_ad_age == 'C1401'){
				$("#under_30_age").parent().addClass("ck");
			}
			//35세 이하
			if(jobIdealPerson.fap_job_ad_age == 'C1402'){
				$("#under_35_age").parent().addClass("ck");
			}
			//연령 불문
			if(jobIdealPerson.fap_job_ad_age == 'C1403'){
				$("#age_no_matter").parent().addClass("ck");
			}
		}
		
		
		//업무에 필요한 일본어능력		
		if(jobIdealPerson.fap_job_ja_level != null){
			//JLPT N1
			if(jobIdealPerson.fap_job_ja_level.fap_job_ja_level_gb == 'C4400'){
				$("#ja_level_jlpt_n1").parent().addClass("ck");
			}
			//JLPT N2
			if(jobIdealPerson.fap_job_ja_level.fap_job_ja_level_gb == 'C4401'){
				$("#ja_level_jlpt_n2").parent().addClass("ck");
			}
			//JLPT N3
			if(jobIdealPerson.fap_job_ja_level.fap_job_ja_level_gb == 'C4402'){
				$("#ja_level_jlpt_n3").parent().addClass("ck");
			}
			//일본어 자격 불문
			if(jobIdealPerson.fap_job_ja_level.fap_job_ja_level_gb == 'C4403'){
				$("#ja_level_no_matter").parent().addClass("ck");
			}		
		}
		
		//우대사항
		for(var i in jobIdealPerson.fap_job_pref){			
			var count = $(".preferences-type-plus .preferences-type-content").length;
			var context = '';
			context +='<div class="preferences-type-content">';
			context +='<div class="job-ad-contents">';
			context +='<div class="job-ad-row">';
			context +='<div class="job-ad-lt">';
			if(count == 0) context +='<spring:message code="fap.jobad.preferences" />';				
			context +='</div>';
			context +='<div class="job-ad-rt">';
			context +='<div class="job-ad-dropdown">';
			//우대사항 없음
			if(jobIdealPerson.fap_job_pref[i].fap_job_pref_gb == 'C4106'){
				context +='<div class="job-ad-select">';
				context +='<button type="button" class="job-ad-select-btn"><code value="C4106"></code></button>';
				context +='<input type="hidden" id="preferences-gb" name="jobPrefList['+count+'].fap_job_pref_gb" value="C4106">';
				context +='</div>';
			}
			//특정 IT 스킬 소유자
			if(jobIdealPerson.fap_job_pref[i].fap_job_pref_gb == 'C4100'){
				context +='<div class="job-ad-select">';
				context +='<button type="button" class="job-ad-select-btn"><code value="C4100"></code></button>';
				context +='<input type="hidden" id="preferences-gb" name="jobPrefList['+count+'].fap_job_pref_gb" value="C4100">';
				context +='</div>';
			}
			//IT, 컴퓨터 관련 전공자 우대
			if(jobIdealPerson.fap_job_pref[i].fap_job_pref_gb == 'C4101'){
				context +='<div class="job-ad-select">';
				context +='<button type="button" class="job-ad-select-btn"><code value="C4101"></code></button>';
				context +='<input type="hidden" id="preferences-gb" name="jobPrefList['+count+'].fap_job_pref_gb" value="C4101">';
				context +='</div>';
			}				
			//경력자 우대
			if(jobIdealPerson.fap_job_pref[i].fap_job_pref_gb == 'C4102'){
				context +='<div class="job-ad-select">';
				context +='<button type="button" class="job-ad-select-btn"><code value="C4102"></code></button>';
				context +='<input type="hidden" id="preferences-gb" name="jobPrefList['+count+'].fap_job_pref_gb" value="C4102">';
				context +='</div>';
			}				
			//정보처리기사(산업기사) 취득자 우대
			if(jobIdealPerson.fap_job_pref[i].fap_job_pref_gb == 'C4103'){
				context +='<div class="job-ad-select">';
				context +='<button type="button" class="job-ad-select-btn"><code value="C4103"></code></button>';
				context +='<input type="hidden" id="preferences-gb" name="jobPrefList['+count+'].fap_job_pref_gb" value="C4103">';
				context +='</div>';
			}				
			//영어 상급자 우대
			if(jobIdealPerson.fap_job_pref[i].fap_job_pref_gb == 'C4104'){
				context +='<div class="job-ad-select">';
				context +='<button type="button" class="job-ad-select-btn"><code value="C4104"></code></button>';
				context +='<input type="hidden" id="preferences-gb" name="jobPrefList['+count+'].fap_job_pref_gb" value="C4104">';
				context +='</div>';
			}				
			//그외 우대 사항
			if(jobIdealPerson.fap_job_pref[i].fap_job_pref_gb == 'C4105'){
				context +='<div class="job-ad-select">';
				context +='<button type="button" class="job-ad-select-btn"><code value="C4105"></code></button>';
				context +='<input type="hidden" id="preferences-gb" name="jobPrefList['+count+'].fap_job_pref_gb" value="C4105">';
				context +='</div>';
			}				
			context +='<div class="job-ad-select-option">';
			context +='<ul class="option-list">';
			context +='<li class="preferences-type selected" ng-if="jobIdealPerson.fap_job_pref[i].fap_job_pref_gb == \'C4106\' ">';
			context +='<button type="button" preferences-code="C4106"><code value="C4106"></code></button>';
			context +='</li>';
			context +='<li class="preferences-type" ng-if="jobIdealPerson.fap_job_pref[i].fap_job_pref_gb != \'C4106\' ">';
			context +='<button type="button" preferences-code="C4106"><code value="C4106"></code></button>';
			context +='</li>';
			context +='<li class="preferences-type selected" ng-if="jobIdealPerson.fap_job_pref[i].fap_job_pref_gb == \'C4100\' ">';
			context +='<button type="button" preferences-code="C4100"><code value="C4100"></code></button>';
			context +='</li>';
			context +='<li class="preferences-type" ng-if="jobIdealPerson.fap_job_pref[i].fap_job_pref_gb != \'C4100\' ">';
			context +='<button type="button" preferences-code="C4100"><code value="C4100"></code></button>';
			context +='</li>';
			context +='<li class="preferences-type selected" ng-if="jobIdealPerson.fap_job_pref[i].fap_job_pref_gb == \'C4101\' ">';
			context +='<button type="button" preferences-code="C4101"><code value="C4101"></code></button>';
			context +='</li>';
			context +='<li class="preferences-type" ng-if="jobIdealPerson.fap_job_pref[i].fap_job_pref_gb != \'C4101\' ">';
			context +='<button type="button" preferences-code="C4101"><code value="C4101"></code></button>';
			context +='</li>';
			context +='<li class="preferences-type selected" ng-if="jobIdealPerson.fap_job_pref[i].fap_job_pref_gb == \'C4102\' ">';
			context +='<button type="button" preferences-code="C4102"><code value="C4102"></code></button>';
			context +='</li>';
			context +='<li class="preferences-type" ng-if="jobIdealPerson.fap_job_pref[i].fap_job_pref_gb != \'C4102\' ">';
			context +='<button type="button" preferences-code="C4102"><code value="C4102"></code></button>';
			context +='</li>';
			context +='<li class="preferences-type selected" ng-if="jobIdealPerson.fap_job_pref[i].fap_job_pref_gb == \'C4103\' ">';
			context +='<button type="button" preferences-code="C4103"><code value="C4103"></code></button>';
			context +='</li>';
			context +='<li class="preferences-type" ng-if="jobIdealPerson.fap_job_pref[i].fap_job_pref_gb != \'C4103\' ">';
			context +='<button type="button" preferences-code="C4103"><code value="C4103"></code></button>';
			context +='</li>';
			context +='<li class="preferences-type selected" ng-if="jobIdealPerson.fap_job_pref[i].fap_job_pref_gb == \'C4104\' ">';
			context +='<button type="button" preferences-code="C4104"><code value="C4104"></code></button>';
			context +='</li>';
			context +='<li class="preferences-type" ng-if="jobIdealPerson.fap_job_pref[i].fap_job_pref_gb != \'C4104\' ">';
			context +='<button type="button" preferences-code="C4104"><code value="C4104"></code></button>';
			context +='</li>';
			context +='<li class="preferences-type selected" ng-if="jobIdealPerson.fap_job_pref[i].fap_job_pref_gb == \'C4105\' ">';
			context +='<button type="button" preferences-code="C4105"><code value="C4105"></code></button>';
			context +='</li>';
			context +='<li class="preferences-type" ng-if="jobIdealPerson.fap_job_pref[i].fap_job_pref_gb != \'C4105\' ">';
			context +='<button type="button" preferences-code="C4105"><code value="C4105"></code></button>';
			context +='</li>';
			context +='</ul>';
			context +='</div>';
			context +='</div>';
			context +='<span><spring:message code="fap.jobad.work.select" /></span>';
			context +='</div>';
			context +='</div>';
			context +='<div class="job-ad-row m10">';
			context +='<div class="job-ad-lt bnt-lt">';
			if(count == 0){
				context +='<button type="button" class="btn-add" ng-click="addPref()"></button>'
				context +='<button type="button" class="btn-remove" ng-click="removePref()"></button>'
			}
			context +='</div>';
			context +='<div class="job-ad-rt">';
			context +='<textarea rows="4" cols="20" name="jobPrefList['+count+'].fap_job_pref_dtl" maxlength="200" ng-model="::jobIdealPerson.fap_job_pref[' + i + '].fap_job_pref_dtl" placeholder="200<spring:message code="fap.placeholder.limit_characters" />"></textarea>';
			context +='</div>';
			context +='</div>';
			context +='</div>';
			context +='</div>';
			
			$(".preferences-type-plus").append($compile(context)($scope));

			preferences_event();			
		}
				
		/*채용전형 불러오기 시작*/
		//채용전형(수정)
		for(var i in jobRecruitPcs){
			var count = $(".accordion .accordion-header").length;
			var context = '';
			//아코디언 제목
			if(jobRecruitPcs[i].fap_job_recruit_pcs_gb == 'C2500'){
				context += '<div class="accordion-header">';
				context += '<code value="C2500"></code>';
				context += '</div>';
			}
			if(jobRecruitPcs[i].fap_job_recruit_pcs_gb == 'C2501'){
				context += '<div class="accordion-header">';
				context += '<code value="C2501"></code>';
				context += '</div>';
			}
			if(jobRecruitPcs[i].fap_job_recruit_pcs_gb == 'C2502'){
				context += '<div class="accordion-header">';
				context += '<code value="C2502"></code>';
				context += '</div>';
			}
			if(jobRecruitPcs[i].fap_job_recruit_pcs_gb == 'C2503'){
				context += '<div class="accordion-header">';
				context += '<code value="C2503"></code>';
				context += '</div>';
			}
			if(jobRecruitPcs[i].fap_job_recruit_pcs_gb == 'C2504'){
				continue;
			}
			
			/* if(jobRecruitPcs[i].fap_job_recruit_pcs_gb == 'C2504'){
				context += '<div class="accordion-header">';
				context += '<code value="C2504"></code>';
				context += '</div>';
			} */
			
			context += '<div class="ui-accordion-content">';
			context += '<div class="ui-accordion-content-header">';
			context += '<input type="hidden" name="jobRecruitPcsList['+i+'].fap_job_recruit_pcs_od" value="{{jobRecruitPcs['+i+'].fap_job_recruit_pcs_od}}">';
			context += '<input type="hidden" name="jobRecruitPcsList['+i+'].fap_job_recruit_pcs_seq" value="{{jobRecruitPcs['+i+'].fap_job_recruit_pcs_seq}}">';
			context += '<input type="hidden" name="fap_job_recruit_pcs_seq_list" value="{{jobRecruitPcs['+i+'].fap_job_recruit_pcs_seq}}">';			
			context += '<input type="hidden" name="jobRecruitPcsList['+i+'].fap_job_recruit_pcs_udt_id" value="${fap_comp_id }">';			
			context += '<div class="job-ad-row">';
			context += '<div class="job-ad-lt">';
			context += '<spring:message code="fap.jobad.recruit_pcs_type" />';
			context += '</div>';
			context += '<div class="job-ad-rt">';
			context += '<div class="job-ad-dropdown">';
			
			//서류전형
			if(jobRecruitPcs[i].fap_job_recruit_pcs_gb == 'C2500'){
				context += '<div class="job-ad-select">';
				context += '<button type="button" class="job-ad-select-btn"><code value="C2500"></code></button>';
				context += '<input type="hidden" id="recruit-gb" name="jobRecruitPcsList['+count+'].fap_job_recruit_pcs_gb" value="C2500">';
				context += '</div>';
			}
			//평가시험
			if(jobRecruitPcs[i].fap_job_recruit_pcs_gb == 'C2501'){
				context += '<div class="job-ad-select">';
				context += '<button type="button" class="job-ad-select-btn"><code value="C2501"></code></button>';
				context += '<input type="hidden" id="recruit-gb" name="jobRecruitPcsList['+count+'].fap_job_recruit_pcs_gb" value="C2501">';
				context += '</div>';				
			}
			//면접
			if(jobRecruitPcs[i].fap_job_recruit_pcs_gb == 'C2502'){
				context += '<div class="job-ad-select">';
				context += '<button type="button" class="job-ad-select-btn"><code value="C2502"></code></button>';
				context += '<input type="hidden" id="recruit-gb" name="jobRecruitPcsList['+count+'].fap_job_recruit_pcs_gb" value="C2502">';
				context += '</div>';
			}
			//그외
			if(jobRecruitPcs[i].fap_job_recruit_pcs_gb == 'C2503'){
				context += '<div class="job-ad-select">';
				context += '<button type="button" class="job-ad-select-btn"><code value="C2503"></code></button>';
				context += '<input type="hidden" id="recruit-gb" name="jobRecruitPcsList['+count+'].fap_job_recruit_pcs_gb" value="C2503">';
				context += '</div>';
			}
			//일본현지면접
			/* if(jobRecruitPcs[i].fap_job_recruit_pcs_gb == 'C2504'){
				context += '<div class="job-ad-select">';
				context += '<button type="button" class="job-ad-select-btn"><code value="C2504"></code></button>';
				context += '<input type="hidden" id="recruit-gb" name="jobRecruitPcsList['+count+'].fap_job_recruit_pcs_gb" value="C2504">';
				context += '</div>';
			} */
			
			context += '<div class="job-ad-select-option">';
			context += '<ul class="option-list">';
			context += '<li class="recruit-type" ng-if="jobRecruitPcs[i].fap_job_recruit_pcs_gb == \'C2500\' ">';
			context += '<button type="button" recruit-code="C2500"><code value="C2500"></code></button>';
			context += '</li>';
			context += '<li class="recruit-type" ng-if="jobRecruitPcs[i].fap_job_recruit_pcs_gb != \'C2500\' ">';
			context += '<button type="button" recruit-code="C2500"><code value="C2500"></code></button>';
			context += '</li>';
			context += '<li class="recruit-type selected" ng-if="jobRecruitPcs[i].fap_job_recruit_pcs_gb == \'C2501\' ">';
			context += '<button type="button" recruit-code="C2501"><code value="C2501"></code></button>';
			context += '</li>';
			context += '<li class="recruit-type" ng-if="jobRecruitPcs[i].fap_job_recruit_pcs_gb != \'C2501\' ">';
			context += '<button type="button" recruit-code="C2501"><code value="C2501"></code></button>';
			context += '</li>';
			context += '<li class="recruit-type selected" ng-if="jobRecruitPcs[i].fap_job_recruit_pcs_gb == \'C2502\' ">';
			context += '<button type="button" recruit-code="C2502"><code value="C2502"></code></button>';
			context += '</li>';
			context += '<li class="recruit-type" ng-if="jobRecruitPcs[i].fap_job_recruit_pcs_gb != \'C2502\' ">';
			context += '<button type="button" recruit-code="C2502"><code value="C2502"></code></button>';
			context += '</li>';
			context += '<li class="recruit-type selected" ng-if="jobRecruitPcs[i].fap_job_recruit_pcs_gb == \'C2503\' ">';
			context += '<button type="button" recruit-code="C2503"><code value="C2503"></code></button>';
			context += '</li>';
			context += '<li class="recruit-type" ng-if="jobRecruitPcs[i].fap_job_recruit_pcs_gb != \'C2503\' ">';
			context += '<button type="button" recruit-code="C2503"><code value="C2503"></code></button>';
			context += '</li>';
			/* context += '<li class="recruit-type selected" ng-if="jobRecruitPcs[i].fap_job_recruit_pcs_gb == \'C2504\' ">';
			context += '<button type="button" recruit-code="C2504"><code value="C2504"></code></button>';
			context += '</li>';
			context += '<li class="recruit-type" ng-if="jobRecruitPcs[i].fap_job_recruit_pcs_gb != \'C2504\' ">';
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
			context += '<textarea rows="4" cols="20" name="jobRecruitPcsList['+count+'].fap_job_recruit_pcs_dtl" maxlength="400" ng-model="::jobRecruitPcs['+i+'].fap_job_recruit_pcs_dtl" placeholder="400<spring:message code="fap.placeholder.limit_characters" />"></textarea>';
			context += '</div>';
			context += '</div>';
			context += '</div>';			
			
			//시험전형
			if(jobRecruitPcs[i].fap_job_recruit_pcs_gb == 'C2501'){
				context += '<div class="ui-accordion-content-body">';
				context += '<div class="job-ad-row">';
				context += '<div class="job-ad-lt">';
				context += '<spring:message code="fap.jobad.exam_type" />';
				context += '</div>';
				context += '<div class="job-ad-rt">';
				context += '<div class="job-ad-dropdown">';
				context += '<div class="job-ad-select">';
				//필기시험
				if(jobRecruitPcs[i].job_exam.fap_job_exam_gb == 'C2600'){
					context += '<button type="button" class="job-ad-select-btn"><code value="C2600"></code></button>';
					context += '<input type="hidden" id="recruit-exam-type" name="jobRecruitPcsList['+count+'].jobExam.fap_job_exam_gb" value="C2600">';
					context += '</div>';
				}
				//WEB시험
				if(jobRecruitPcs[i].job_exam.fap_job_exam_gb == 'C2601'){
					context += '<button type="button" class="job-ad-select-btn"><code value="C2601"></code></button>';
					context += '<input type="hidden" id="recruit-exam-type" name="jobRecruitPcsList['+count+'].jobExam.fap_job_exam_gb" value="C2601">';
					context += '</div>';
				}				
				context += '<div class="job-ad-select-option">';
				context += '<ul class="option-list">';
				context += '<li class="recruit-exam-type selected" ng-if="jobRecruitPcs[i].job_exam.fap_job_exam_gb == \'C2600\' ">';
				context += '<button type="button" recruit-exam-type-code="C2600"><code value="C2600"></code></button>';
				context += '</li>';
				context += '<li class="recruit-exam-type" ng-if="jobRecruitPcs[i].job_exam.fap_job_exam_gb != \'C2600\' ">';
				context += '<button type="button" recruit-exam-type-code="C2600"><code value="C2600"></code></button>';
				context += '</li>';
				context += '<li class="recruit-exam-type selected" ng-if="jobRecruitPcs[i].job_exam.fap_job_exam_gb == \'C2601\' ">';
				context += '<button type="button" recruit-exam-type-code="C2601"><code value="C2601"></code></button>';
				context += '</li>';
				context += '<li class="recruit-exam-type" ng-if="jobRecruitPcs[i].job_exam.fap_job_exam_gb != \'C2601\' ">';
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
				//응시자 전원
				if(jobRecruitPcs[i].job_exam.fap_job_exam_obj == 'C2700'){
					context += '<div class="job-ad-select">';
					context += '<button type="button" class="job-ad-select-btn"><code value="C2700"></code></button>';
					context += '<input type="hidden" id="recruit-exam-obj-type" name="jobRecruitPcsList['+count+'].jobExam.fap_job_exam_obj" value="C2700">';
					context += '</div>';
				}
				//서류전형 합격자
				if(jobRecruitPcs[i].job_exam.fap_job_exam_obj == 'C2701'){
					context += '<div class="job-ad-select">';
					context += '<button type="button" class="job-ad-select-btn"><code value="C2701"></code></button>';
					context += '<input type="hidden" id="recruit-exam-obj-type" name="jobRecruitPcsList['+count+'].jobExam.fap_job_exam_obj" value="C2701">';
					context += '</div>';
				}
				//그 외
				if(jobRecruitPcs[i].job_exam.fap_job_exam_obj == 'C2702'){
					context += '<div class="job-ad-select">';
					context += '<button type="button" class="job-ad-select-btn"><code value="C2702"></code></button>';
					context += '<input type="hidden" id="recruit-exam-obj-type" name="jobRecruitPcsList['+count+'].jobExam.fap_job_exam_obj" value="C2702">';
					context += '</div>';
				}
				context += '<div class="job-ad-select-option">';
				context += '<ul class="option-list">';
				context += '<li class="recruit-exam-obj-type selected" ng-if="jobRecruitPcs[i].job_exam.fap_job_exam_obj == \'C2700\' ">';
				context += '<button type="button" recruit-exam-obj-type-code="C2700"><code value="C2700"></code></button>';
				context += '</li>';
				context += '<li class="recruit-exam-obj-type" ng-if="jobRecruitPcs[i].job_exam.fap_job_exam_obj != \'C2700\' ">';
				context += '<button type="button" recruit-exam-obj-type-code="C2700"><code value="C2700"></code></button>';
				context += '</li>';
				context += '<li class="recruit-exam-obj-type selected" ng-if="jobRecruitPcs[i].job_exam.fap_job_exam_obj == \'C2701\' ">';
				context += '<button type="button" recruit-exam-obj-type-code="C2701"><code value="C2701"></code></button>';
				context += '</li>';
				context += '<li class="recruit-exam-obj-type" ng-if="jobRecruitPcs[i].job_exam.fap_job_exam_obj != \'C2701\' ">';
				context += '<button type="button" recruit-exam-obj-type-code="C2701"><code value="C2701"></code></button>';
				context += '</li>';
				context += '<li class="recruit-exam-obj-type etc selected" ng-if="jobRecruitPcs[i].job_exam.fap_job_exam_obj == \'C2702\' ">';
				context += '<button type="button" recruit-exam-obj-type-code="C2702"><code value="C2702"></code></button>';
				context += '</li>';
				context += '<li class="recruit-exam-obj-type etc" ng-if="jobRecruitPcs[i].job_exam.fap_job_exam_obj != \'C2702\' ">';
				context += '<button type="button" recruit-exam-obj-type-code="C2702"><code value="C2702"></code></button>';
				context += '</li>';
				context += '</ul>';
				context += '</div>';
				context += '</div>';
				if(jobRecruitPcs[i].job_exam.fap_job_exam_obj == 'C2702'){				
					context += '<div class="sub-area display" style="display: block;">';
				}else{
					context += '<div class="sub-area display">';
				}
				context += '<div class="sub-area-inner">';
				context += '<div class="bar-inner">';
				context += '<h5 class="inner-title"><spring:message code="fap.jobad.exam_obj" /></h5>';
				context += '<span class="inner-item">';
				context += '<textarea rows="4" cols="20" name="jobRecruitPcsList['+count+'].jobExam.jobExamObjEtc.fap_job_exam_obj_etc_dtl" ng-model="::jobRecruitPcs['+i+'].job_exam.job_exam_obj_etc.fap_job_exam_obj_etc_dtl"></textarea>';
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
				//시험 대상자 이메일 필요
				if(jobRecruitPcs[i].job_exam.fap_job_exam_mail == 'C2800'){
					context += '<div class="job-ad-select">';
					context += '<button type="button" class="job-ad-select-btn"><code value="C2800"></code></button>';
					context += '<input type="hidden" id="recruit-exam-email-type" name="jobRecruitPcsList['+count+'].jobExam.fap_job_exam_mail" value="C2800">';
					context += '</div>';
				}
				//시험 대상자 이메일 필요없음
				if(jobRecruitPcs[i].job_exam.fap_job_exam_mail == 'C2801'){
					context += '<div class="job-ad-select">';
					context += '<button type="button" class="job-ad-select-btn"><code value="C2801"></code></button>';
					context += '<input type="hidden" id="recruit-exam-email-type" name="jobRecruitPcsList['+count+'].jobExam.fap_job_exam_mail" value="C2801">';
					context += '</div>';
				}
				context += '<div class="job-ad-select-option">';
				context += '<ul class="option-list">';
				context += '<li class="recruit-exam-email-type selected" ng-if="jobRecruitPcs[i].job_exam.fap_job_exam_mail == \'C2800\' ">';
				context += '<button type="button" recruit-exam-type-code="C2800"><code value="C2800"></code></button>';
				context += '</li>';
				context += '<li class="recruit-exam-email-type" ng-if="jobRecruitPcs[i].job_exam.fap_job_exam_mail != \'C2800\' ">';
				context += '<button type="button" recruit-exam-type-code="C2800"><code value="C2800"></code></button>';
				context += '</li>';
				context += '<li class="recruit-exam-email-type selected" ng-if="jobRecruitPcs[i].job_exam.fap_job_exam_mail == \'C2801\' ">';
				context += '<button type="button" recruit-exam-type-code="C2801"><code value="C2801"></code></button>';
				context += '</li>';
				context += '<li class="recruit-exam-email-type" ng-if="jobRecruitPcs[i].job_exam.fap_job_exam_mail != \'C2801\' ">';
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
				//시험 감독관 필요
				if(jobRecruitPcs[i].job_exam.fap_job_exam_sv == 'C2900'){
					context += '<div class="job-ad-select">';
					context += '<button type="button" class="job-ad-select-btn"><code value="C2900"></code></button>';
					context += '<input type="hidden" id="recruit-exam-sv-type" name="jobRecruitPcsList['+count+'].jobExam.fap_job_exam_sv" value="C2900">';
					context += '</div>';
				}
				//시험 감독관 불필요
				if(jobRecruitPcs[i].job_exam.fap_job_exam_sv == 'C2901'){
					context += '<div class="job-ad-select">';
					context += '<button type="button" class="job-ad-select-btn"><code value="C2901"></code></button>';
					context += '<input type="hidden" id="recruit-exam-sv-type" name="jobRecruitPcsList['+count+'].jobExam.fap_job_exam_sv" value="C2901">';
					context += '</div>';
				}
				//자택 수험 가능
				if(jobRecruitPcs[i].job_exam.fap_job_exam_sv == 'C2902'){
					context += '<div class="job-ad-select">';
					context += '<button type="button" class="job-ad-select-btn"><code value="C2902"></code></button>';
					context += '<input type="hidden" id="recruit-exam-sv-type" name="jobRecruitPcsList['+count+'].jobExam.fap_job_exam_sv" value="C2902">';
					context += '</div>';
				}
				//그 외
				if(jobRecruitPcs[i].job_exam.fap_job_exam_sv == 'C2903'){
					context += '<div class="job-ad-select">';
					context += '<button type="button" class="job-ad-select-btn"><code value="C2903"></code></button>';
					context += '<input type="hidden" id="recruit-exam-sv-type" name="jobRecruitPcsList['+count+'].jobExam.fap_job_exam_sv" value="C2903">';
					context += '</div>';
				}
				context += '<div class="job-ad-select-option">';
				context += '<ul class="option-list">';
				context += '<li class="recruit-exam-sv-type selected" ng-if="jobRecruitPcs[i].job_exam.fap_job_exam_sv == \'C2900\' ">';
				context += '<button type="button" recruit-exam-sv-code="C2900"><code value="C2900"></code></button>';
				context += '</li>';
				context += '<li class="recruit-exam-sv-type" ng-if="jobRecruitPcs[i].job_exam.fap_job_exam_sv != \'C2900\' ">';
				context += '<button type="button" recruit-exam-sv-code="C2900"><code value="C2900"></code></button>';
				context += '</li>';				
				context += '<li class="recruit-exam-sv-type selected" ng-if="jobRecruitPcs[i].job_exam.fap_job_exam_sv == \'C2901\' ">';
				context += '<button type="button" recruit-exam-sv-code="C2901"><code value="C2901"></code></button>';
				context += '</li>';
				context += '<li class="recruit-exam-sv-type" ng-if="jobRecruitPcs[i].job_exam.fap_job_exam_sv != \'C2901\' ">';
				context += '<button type="button" recruit-exam-sv-code="C2901"><code value="C2901"></code></button>';
				context += '</li>';
				context += '<li class="recruit-exam-sv-type selected" ng-if="jobRecruitPcs[i].job_exam.fap_job_exam_sv == \'C2902\' ">';
				context += '<button type="button" recruit-exam-sv-code="C2902"><code value="C2902"></code></button>';
				context += '</li>';
				context += '<li class="recruit-exam-sv-type" ng-if="jobRecruitPcs[i].job_exam.fap_job_exam_sv != \'C2902\' ">';
				context += '<button type="button" recruit-exam-sv-code="C2902"><code value="C2902"></code></button>';
				context += '</li>';
				context += '<li class="recruit-exam-sv-type etc selected" ng-if="jobRecruitPcs[i].job_exam.fap_job_exam_sv == \'C2903\' ">';
				context += '<button type="button" recruit-exam-sv-code="C2903"><code value="C2903"></code></button>';
				context += '</li>';
				context += '<li class="recruit-exam-sv-type etc" ng-if="jobRecruitPcs[i].job_exam.fap_job_exam_sv != \'C2903\' ">';
				context += '<button type="button" recruit-exam-sv-code="C2903"><code value="C2903"></code></button>';
				context += '</li>';
				context += '</ul>';
				context += '</div>';
				context += '</div>';
				if(jobRecruitPcs[i].job_exam.fap_job_exam_sv == 'C2903'){
					context += '<div class="sub-area display" style="display: block;">';
				}else{
					context += '<div class="sub-area display">';
				}
				context += '<div class="sub-area-inner">';
				context += '<div class="bar-inner">';
				context += '<h5 class="inner-title"><spring:message code="fap.jobad.exam_obj" /></h5>';
				context += '<span class="inner-item">';
				context += '<textarea rows="4" cols="20" name="jobRecruitPcsList['+count+'].jobExam.jobExamSvEtc.fap_job_exam_sv_etc_dtl" ng-model="::jobRecruitPcs['+i+'].job_exam.job_exam_sv_etc.fap_job_exam_sv_etc_dtl"></textarea>';
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
				//시험시 준비물 제한 없음
				if(jobRecruitPcs[i].job_exam.fap_job_exam_need == 'C3000'){
					context += '<div class="job-ad-select">';
					context += '<button type="button" class="job-ad-select-btn"><code value="C3000"></code></button>';
					context += '<input type="hidden" id="recruit-exam-need-type" name="jobRecruitPcsList['+count+'].jobExam.fap_job_exam_need" value="C3000">';
					context += '</div>';
				}
				//시험시 준비물 소지 불가
				if(jobRecruitPcs[i].job_exam.fap_job_exam_need == 'C3001'){
					context += '<div class="job-ad-select">';
					context += '<button type="button" class="job-ad-select-btn"><code value="C3001"></code></button>';
					context += '<input type="hidden" id="recruit-exam-need-type" name="jobRecruitPcsList['+count+'].jobExam.fap_job_exam_need" value="C3001">';
					context += '</div>';
				}
				//그 외
				if(jobRecruitPcs[i].job_exam.fap_job_exam_need == 'C3002'){
					context += '<div class="job-ad-select">';
					context += '<button type="button" class="job-ad-select-btn"><code value="C3002"></code></button>';
					context += '<input type="hidden" id="recruit-exam-need-type" name="jobRecruitPcsList['+count+'].jobExam.fap_job_exam_need" value="C3002">';
					context += '</div>';
				}				
				context += '<div class="job-ad-select-option">';
				context += '<ul class="option-list">';
				context += '<li class="recruit-exam-need-type selected" ng-if="jobRecruitPcs[i].job_exam.fap_job_exam_need == \'C3000\' ">';
				context += '<button type="button" recruit-exam-need-code="C3000"><code value="C3000"></code></button>';
				context += '</li>';
				context += '<li class="recruit-exam-need-type" ng-if="jobRecruitPcs[i].job_exam.fap_job_exam_need != \'C3000\' ">';
				context += '<button type="button" recruit-exam-need-code="C3000"><code value="C3000"></code></button>';
				context += '</li>';
				context += '<li class="recruit-exam-need-type selected" ng-if="jobRecruitPcs[i].job_exam.fap_job_exam_need == \'C3001\' ">';
				context += '<button type="button" recruit-exam-need-code="C3001"><code value="C3001"></code></button>';
				context += '</li>';
				context += '<li class="recruit-exam-need-type" ng-if="jobRecruitPcs[i].job_exam.fap_job_exam_need != \'C3001\' ">';
				context += '<button type="button" recruit-exam-need-code="C3001"><code value="C3001"></code></button>';
				context += '</li>';
				context += '<li class="recruit-exam-need-type etc selected" ng-if="jobRecruitPcs[i].job_exam.fap_job_exam_need == \'C3002\' ">';
				context += '<button type="button" recruit-exam-need-code="C3002"><code value="C3002"></code></button>';
				context += '</li>';
				context += '<li class="recruit-exam-need-type etc" ng-if="jobRecruitPcs[i].job_exam.fap_job_exam_need != \'C3002\' ">';
				context += '<button type="button" recruit-exam-need-code="C3002"><code value="C3002"></code></button>';
				context += '</li>';
				context += '</ul>';
				context += '</div>';
				context += '</div>';
				if(jobRecruitPcs[i].job_exam.fap_job_exam_need == 'C3002'){
					context += '<div class="sub-area display" style="display: block;">';
				}else{
					context += '<div class="sub-area display">';
				}				
				context += '<div class="sub-area-inner">';
				context += '<div class="bar-inner">';
				context += '<h5 class="inner-title"><spring:message code="fap.jobad.exam_obj" /></h5>';
				context += '<span class="inner-item">';
				context += '<textarea rows="4" cols="20" name="jobRecruitPcsList['+count+'].jobExam.jobExamNeedEtc.fap_job_exam_need_etc_dtl" ng-model="::jobRecruitPcs['+i+'].job_exam.job_exam_need_etc.fap_job_exam_need_etc_dtl"></textarea>';
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
								 
				var commonCodeNum = 3200;
				//시험 타입
				for(var j = 0; j < 6; j++){
					var flag = false;
					jobRecruitPcs[i].job_exam.job_exam_type.forEach(function (exam_type, index) {
						if(exam_type.fap_job_exam_type_gb == 'C'+commonCodeNum){
							context += '<span class="job-check long-check ck">';
							context += '<label class="job-check-label">';
							context += '<code value="' + exam_type.fap_job_exam_type_gb + '"></code>';
							context += '</label>';
							context += '<input type="checkbox" name="jobRecruitPcsList['+count+'].jobExam.jobExamTypeList['+j+'].fap_job_exam_type_gb" value="' + exam_type.fap_job_exam_type_gb + '" checked="checked">';
							context += '</span>';	
							flag = true;
						}
					});
					if(flag == false){
						context += '<span class="job-check long-check">';
						context += '<label class="job-check-label">';
						context += '<code value="C' + commonCodeNum + '"></code>';
						context += '</label>';
						context += '<input type="checkbox" name="jobRecruitPcsList['+count+'].jobExam.jobExamTypeList['+j+'].fap_job_exam_type_gb" value="C' + commonCodeNum + '" >';
						context += '</span>';
					}
					if(j == 3){
						context += '</div>';
						context += '</div>';
						context += '<div class="job-ad-row">';
						context += '<div class="job-ad-lt">';
						context += '</div>';
						context += '<div class="job-ad-rt check-row">';
					}
					commonCodeNum += 1;
				}
								 
				context += '</div>';
				context += '</div>';
				context += '<div class="job-ad-row m50">';
				context += '<div class="job-ad-lt">';
				context += '<spring:message code="fap.comp.exam_tm" />';
				context += '</div>';
				context += '<div class="job-ad-rt">';
				//소요 시간
				context += '<input type="text" name="jobRecruitPcsList['+count+'].jobExam.fap_job_exam_tm" ng-model="::jobRecruitPcs['+i+'].job_exam.fap_job_exam_tm">';
				context += '<span class="hiddenTx">分</span>';
				context += '</div>';
				context += '</div>';
				context += '<div class="job-ad-row">';
				context += '<div class="job-ad-lt">';
				context += '<spring:message code="fap.comp.exam_file" />';
				context += '</div>';
				context += '<div class="job-ad-rt" id="job-exam-file' + count + '">';
				//시험 파일
				if(jobRecruitPcs[i].job_exam.job_exam_file != null && jobRecruitPcs[i].job_exam.job_exam_file.fap_job_exam_file_origin != null){
					context += '<a class="job-ad-download" href="/file_download?origin=' + jobRecruitPcs[i].job_exam.job_exam_file.fap_job_exam_file_origin + '&saved=' + jobRecruitPcs[i].job_exam.job_exam_file.fap_job_exam_file_saved + '&path=' + job_exam_file_path + '/' + jobRecruitPcs[i].fap_job_ad_seq + '_' + jobRecruitPcs[i].fap_job_recruit_pcs_seq + '">';
					context += jobRecruitPcs[i].job_exam.job_exam_file.fap_job_exam_file_origin;
					context += '</a>'
					context += '<button type="button" class="btn-delete" onclick="update_job_exam_file(' + i + ')">Delete</button>';
				}else{
					context += '<input type="file" id="fap_job_exam_file" name="jobRecruitPcsList['+count+'].jobExam.jobExamFile.fap_job_exam_file">';
					context += '<label for="fap_job_exam_file"><spring:message code="fap.placeholder.file_size" /></label>';
					
				}
				context += '</div>';
				context += '<div id="job-ad-job-file-hidden-box">';
				if(jobRecruitPcs[i].job_exam.job_exam_file != null && jobRecruitPcs[i].job_exam.job_exam_file.fap_job_exam_file_origin != null){
					context += '<input type="hidden" value="' + jobRecruitPcs[i].job_exam.job_exam_file.fap_job_exam_file_origin + '" name="jobRecruitPcsList['+count+'].jobExam.jobExamFile.fap_job_exam_file_origin" />';
					context += '<input type="hidden" value="' + jobRecruitPcs[i].job_exam.job_exam_file.fap_job_exam_file_saved + '" name="jobRecruitPcsList['+count+'].jobExam.jobExamFile.fap_job_exam_file_saved" />';
					context += '<input type="hidden" value="' + job_exam_file_path + '/' + jobRecruitPcs[i].fap_job_ad_seq + '_' + jobRecruitPcs[i].fap_job_recruit_pcs_seq + '" name = "jobRecruitPcsList['+count+'].jobExam.jobExamFile.file_path" />';				
				}
				context += '</div>';
				context += '</div>';
				context += '</div>';
				
			}			
			
			//면접전형
			if(jobRecruitPcs[i].fap_job_recruit_pcs_gb == 'C2502'){
				context += '<div class="ui-accordion-content-body">';
				context += '<div class="job-ad-row">';
				context += '<div class="job-ad-lt">';
				context += '<spring:message code="fap.comp.itv_gb" />';
				context += '</div>';
				context += '<div class="job-ad-rt recruit-row">';
				context += '<div class="job-ad-dropdown">';
				//대면면접
				if(jobRecruitPcs[i].job_itv.fap_job_itv_gb == 'C3300'){
					context += '<div class="job-ad-select">';
					context += '<button type="button" class="job-ad-select-btn"><code value="C3300"></code></button>';
					context += '<input type="hidden" id="recruit-itv-gb-type" name="jobRecruitPcsList['+count+'].jobItv.fap_job_itv_gb" value="C3300">';
					context += '</div>';
				}
				//화상면접
				if(jobRecruitPcs[i].job_itv.fap_job_itv_gb == 'C3301'){
					context += '<div class="job-ad-select">';
					context += '<button type="button" class="job-ad-select-btn"><code value="C3301"></code></button>';
					context += '<input type="hidden" id="recruit-itv-gb-type" name="jobRecruitPcsList['+count+'].jobItv.fap_job_itv_gb" value="C3301">';
					context += '</div>';
				}				
				context += '<div class="job-ad-select-option">';
				context += '<ul class="option-list">';
				context += '<li class="recruit-itv-gb-type selected" ng-if="jobRecruitPcs[i].job_itv.fap_job_itv_gb == \'C3300\' ">';
				context += '<button type="button" recruit-itv-gb-type-code="C3300"><code value="C3300"></code></button>';
				context += '</li>';
				context += '<li class="recruit-itv-gb-type" ng-if="jobRecruitPcs[i].job_itv.fap_job_itv_gb != \'C3300\' ">';
				context += '<button type="button" recruit-itv-gb-type-code="C3300"><code value="C3300"></code></button>';
				context += '</li>';
				context += '<li class="recruit-itv-gb-type skype selected" ng-if="jobRecruitPcs[i].job_itv.fap_job_itv_gb == \'C3301\' ">';
				context += '<button type="button" recruit-itv-gb-type-code="C3301"><code value="C3301"></code></button>';
				context += '</li>';
				context += '<li class="recruit-itv-gb-type skype" ng-if="jobRecruitPcs[i].job_itv.fap_job_itv_gb != \'C3301\' ">';
				context += '<button type="button" recruit-itv-gb-type-code="C3301"><code value="C3301"></code></button>';
				context += '</li>';
				context += '</ul>';
				context += '</div>';
				context += '</div>';
				if(jobRecruitPcs[i].job_itv.fap_job_itv_gb == 'C3301'){
					context += '<div class="sub-area display" style="display: block;">';
				}else{
					context += '<div class="sub-area display">';
				}
				context += '<div class="sub-area-inner">';
				context += '<div class="bar-inner">';
				context += '<h5 class="inner-title"><spring:message code="fap.comp.itv_skype_id" /></h5>';
				context += '<span class="inner-item">';
				context += '<input type="text" name="jobRecruitPcsList['+count+'].jobItv.fap_job_itv_skype" ng-model="::jobRecruitPcs['+i+'].job_itv.fap_job_itv_skype">';
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
				//면접대상자 전원
				if(jobRecruitPcs[i].job_itv.fap_job_itv_obj == 'C3400'){
					context += '<div class="job-ad-select">';
					context += '<button type="button" class="job-ad-select-btn"><code value="C3400"></code></button>';
					context += '<input type="hidden" id="recruit-itv-obj-type" name="jobRecruitPcsList['+count+'].jobItv.fap_job_itv_obj" value="C3400">';
					context += '</div>';
				}
				//면접대상자 서류전형 합격자
				if(jobRecruitPcs[i].job_itv.fap_job_itv_obj == 'C3401'){
					context += '<div class="job-ad-select">';
					context += '<button type="button" class="job-ad-select-btn"><code value="C3401"></code></button>';
					context += '<input type="hidden" id="recruit-itv-obj-type" name="jobRecruitPcsList['+count+'].jobItv.fap_job_itv_obj" value="C3401">';
					context += '</div>';
				}
				//면접대상자 시험전형 합격자
				if(jobRecruitPcs[i].job_itv.fap_job_itv_obj == 'C3402'){
					context += '<div class="job-ad-select">';
					context += '<button type="button" class="job-ad-select-btn"><code value="C3402"></code></button>';
					context += '<input type="hidden" id="recruit-itv-obj-type" name="jobRecruitPcsList['+count+'].jobItv.fap_job_itv_obj" value="C3402">';
					context += '</div>';
				}
				//면접대상자 기타
				if(jobRecruitPcs[i].job_itv.fap_job_itv_obj == 'C3403'){
					context += '<div class="job-ad-select">';
					context += '<button type="button" class="job-ad-select-btn"><code value="C3403"></code></button>';
					context += '<input type="hidden" id="recruit-itv-obj-type" name="jobRecruitPcsList['+count+'].jobItv.fap_job_itv_obj" value="C3403">';
					context += '</div>';
				}
				context += '<div class="job-ad-select-option">';
				context += '<ul class="option-list">';
				context += '<li class="recruit-itv-obj-type selected" ng-if="jobRecruitPcs[i].job_itv.fap_job_itv_obj == \'C3400\' ">';
				context += '<button type="button" recruit-itv-obj-type-code="C3400"><code value="C3400"></code></button>';
				context += '</li>';
				context += '<li class="recruit-itv-obj-type" ng-if="jobRecruitPcs[i].job_itv.fap_job_itv_obj != \'C3400\' ">';
				context += '<button type="button" recruit-itv-obj-type-code="C3400"><code value="C3400"></code></button>';
				context += '</li>';
				context += '<li class="recruit-itv-obj-type selected" ng-if="jobRecruitPcs[i].job_itv.fap_job_itv_obj == \'C3401\' ">';
				context += '<button type="button" recruit-itv-obj-type-code="C3401"><code value="C3401"></code></button>';
				context += '</li>';
				context += '<li class="recruit-itv-obj-type" ng-if="jobRecruitPcs[i].job_itv.fap_job_itv_obj != \'C3401\' ">';
				context += '<button type="button" recruit-itv-obj-type-code="C3401"><code value="C3401"></code></button>';
				context += '</li>';
				context += '<li class="recruit-itv-obj-type selected" ng-if="jobRecruitPcs[i].job_itv.fap_job_itv_obj == \'C3402\' ">';
				context += '<button type="button" recruit-itv-obj-type-code="C3402"><code value="C3402"></code></button>';
				context += '</li>';
				context += '<li class="recruit-itv-obj-type" ng-if="jobRecruitPcs[i].job_itv.fap_job_itv_obj != \'C3402\' ">';
				context += '<button type="button" recruit-itv-obj-type-code="C3402"><code value="C3402"></code></button>';
				context += '</li>';
				context += '<li class="recruit-itv-obj-type etc selected" ng-if="jobRecruitPcs[i].job_itv.fap_job_itv_obj == \'C3403\' ">';
				context += '<button type="button" recruit-itv-obj-type-code="C3403"><code value="C3403"></code></button>';
				context += '</li>';
				context += '<li class="recruit-itv-obj-type etc" ng-if="jobRecruitPcs[i].job_itv.fap_job_itv_obj != \'C3403\' ">';
				context += '<button type="button" recruit-itv-obj-type-code="C3403"><code value="C3403"></code></button>';
				context += '</li>';
				context += '</ul>';
				context += '</div>';
				context += '</div>';
				if(jobRecruitPcs[i].job_itv.fap_job_itv_obj == 'C3403'){
					context += '<div class="sub-area display" style="display: block;">';
				}
				else{
					context += '<div class="sub-area display">';
				}
				context += '<div class="sub-area-inner">';
				context += '<div class="bar-inner">';
				context += '<h5 class="inner-title"><spring:message code="fap.common.etc" /></h5>';
				context += '<span class="inner-item">';
				context += '<textarea rows="4" cols="20" name="jobRecruitPcsList['+count+'].jobItv.jobItvObjEtc.fap_job_itv_obj_etc_dtl" ng-model="::jobRecruitPcs['+i+'].job_itv.job_itv_obj_etc.fap_job_itv_obj_etc_dtl"></textarea>';
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
				//개별면접
				if(jobRecruitPcs[i].job_itv.fap_job_itv_tp == 'C3500'){
					context += '<div class="job-ad-select">';
					context += '<button type="button" class="job-ad-select-btn"><code value="C3500"></code></button>';
					context += '<input type="hidden" id="recruit-itv-tp-type" name="jobRecruitPcsList['+count+'].jobItv.fap_job_itv_tp" value="C3500">';
					context += '</div>';
				}
				//그룹면접
				if(jobRecruitPcs[i].job_itv.fap_job_itv_tp == 'C3501'){
					context += '<div class="job-ad-select">';
					context += '<button type="button" class="job-ad-select-btn"><code value="C3501"></code></button>';
					context += '<input type="hidden" id="recruit-itv-tp-type" name="jobRecruitPcsList['+count+'].jobItv.fap_job_itv_tp" value="C3501">';
					context += '</div>';
				}
				//미정
				if(jobRecruitPcs[i].job_itv.fap_job_itv_tp == 'C3502'){
					context += '<div class="job-ad-select">';
					context += '<button type="button" class="job-ad-select-btn"><code value="C3502"></code></button>';
					context += '<input type="hidden" id="recruit-itv-tp-type" name="jobRecruitPcsList['+count+'].jobItv.fap_job_itv_tp" value="C3502">';
					context += '</div>';
				}
				//기타
				if(jobRecruitPcs[i].job_itv.fap_job_itv_tp == 'C3503'){
					context += '<div class="job-ad-select">';
					context += '<button type="button" class="job-ad-select-btn"><code value="C3503"></code></button>';
					context += '<input type="hidden" id="recruit-itv-tp-type" name="jobRecruitPcsList['+count+'].jobItv.fap_job_itv_tp" value="C3503">';
					context += '</div>';
				}				
				context += '<div class="job-ad-select-option">';
				context += '<ul class="option-list">';
				context += '<li class="recruit-itv-tp-type selected" ng-if="jobRecruitPcs[i].job_itv.fap_job_itv_tp == \'C3500\' ">';
				context += '<button type="button" recruit-itv-tp-type-code="C3500"><code value="C3500"></code></button>';
				context += '</li>';
				context += '<li class="recruit-itv-tp-type" ng-if="jobRecruitPcs[i].job_itv.fap_job_itv_tp != \'C3500\' ">';
				context += '<button type="button" recruit-itv-tp-type-code="C3500"><code value="C3500"></code></button>';
				context += '</li>';
				context += '<li class="recruit-itv-tp-type selected" ng-if="jobRecruitPcs[i].job_itv.fap_job_itv_tp == \'C3501\' ">';
				context += '<button type="button" recruit-itv-tp-type-code="C3501"><code value="C3501"></code></button>';
				context += '</li>';
				context += '<li class="recruit-itv-tp-type" ng-if="jobRecruitPcs[i].job_itv.fap_job_itv_tp != \'C3501\' ">';
				context += '<button type="button" recruit-itv-tp-type-code="C3501"><code value="C3501"></code></button>';
				context += '</li>';
				context += '<li class="recruit-itv-tp-type selected" ng-if="jobRecruitPcs[i].job_itv.fap_job_itv_tp == \'C3502\' ">';
				context += '<button type="button" recruit-itv-tp-type-code="C3502"><code value="C3502"></code></button>';
				context += '</li>';
				context += '<li class="recruit-itv-tp-type" ng-if="jobRecruitPcs[i].job_itv.fap_job_itv_tp != \'C3502\' ">';
				context += '<button type="button" recruit-itv-tp-type-code="C3502"><code value="C3502"></code></button>';
				context += '</li>';
				context += '<li class="recruit-itv-tp-type etc selected" ng-if="jobRecruitPcs[i].job_itv.fap_job_itv_tp == \'C3503\' ">';
				context += '<button type="button" recruit-itv-tp-type-code="C3503"><code value="C3503"></code></button>';
				context += '</li>';
				context += '<li class="recruit-itv-tp-type etc" ng-if="jobRecruitPcs[i].job_itv.fap_job_itv_tp != \'C3503\' ">';
				context += '<button type="button" recruit-itv-tp-type-code="C3503"><code value="C3503"></code></button>';
				context += '</li>';
				context += '</ul>';
				context += '</div>';
				context += '</div>';
				if(jobRecruitPcs[i].job_itv.fap_job_itv_tp == 'C3503'){
					context += '<div class="sub-area display" style="display: block;">';
				}else{
					context += '<div class="sub-area display">';
				}
				context += '<div class="sub-area-inner">';
				context += '<div class="bar-inner">';
				context += '<h5 class="inner-title"><spring:message code="fap.common.etc" /></h5>';
				context += '<span class="inner-item">';
				context += '<textarea rows="4" cols="20" name="jobRecruitPcsList['+count+'].jobItv.jobItvTpEtc.fap_job_itv_tp_etc_dtl" ng-model="::jobRecruitPcs['+i+'].job_itv.job_itv_tp_etc.fap_job_itv_tp_etc_dtl"></textarea>';
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
				context += '<input type="text" name="jobRecruitPcsList['+count+'].jobItv.fap_job_itv_tm" ng-model="::jobRecruitPcs['+i+'].job_itv.fap_job_itv_tm">';
				context += '<span class="hiddenTx">分</span>';
				context += '</div>';
				context += '</div>';
				context += '</div>';
			}
							
			//기타전형
			if(jobRecruitPcs[i].fap_job_recruit_pcs_gb == 'C2503'){
				context += '<div class="ui-accordion-content-body">';
				context += '<div class="job-ad-row">';
				context += '<div class="job-ad-lt">';
				context += '<spring:message code="fap.comp.test_etc_obj" />';
				context += '</div>';
				context += '<div class="job-ad-rt recruit-row">';
				context += '<div class="job-ad-dropdown">';
				//기타전형 대상자 전원
				if(jobRecruitPcs[i].job_test_etc.fap_job_test_etc_obj == 'C3600'){
					context += '<div class="job-ad-select">';
					context += '<button type="button" class="job-ad-select-btn"><code value="C3600"></code></button>';
					context += '<input type="hidden" id="recruit-test-etc-obj-type" name="jobRecruitPcsList['+count+'].jobTestEtc.fap_job_test_etc_obj" value="C3600">';
					context += '</div>';
				}
				//기타전형 대상자 서류전형 합격자
				if(jobRecruitPcs[i].job_test_etc.fap_job_test_etc_obj == 'C3601'){
					context += '<div class="job-ad-select">';
					context += '<button type="button" class="job-ad-select-btn"><code value="C3601"></code></button>';
					context += '<input type="hidden" id="recruit-test-etc-obj-type" name="jobRecruitPcsList['+count+'].jobTestEtc.fap_job_test_etc_obj" value="C3601">';
					context += '</div>';
				}
				//기타전형 대상자 시험전형 합격자
				if(jobRecruitPcs[i].job_test_etc.fap_job_test_etc_obj == 'C3602'){
					context += '<div class="job-ad-select">';
					context += '<button type="button" class="job-ad-select-btn"><code value="C3602"></code></button>';
					context += '<input type="hidden" id="recruit-test-etc-obj-type" name="jobRecruitPcsList['+count+'].jobTestEtc.fap_job_test_etc_obj" value="C3602">';
					context += '</div>';
				}
				//기타전형 대상자 기타
				if(jobRecruitPcs[i].job_test_etc.fap_job_test_etc_obj == 'C3603'){
					context += '<div class="job-ad-select">';
					context += '<button type="button" class="job-ad-select-btn"><code value="C3603"></code></button>';
					context += '<input type="hidden" id="recruit-test-etc-obj-type" name="jobRecruitPcsList['+count+'].jobTestEtc.fap_job_test_etc_obj" value="C3603">';
					context += '</div>';
				}
				
				context += '<div class="job-ad-select-option">';
				context += '<ul class="option-list">';
				context += '<li class="recruit-test-etc-obj-type selected" ng-if="jobRecruitPcs[i].job_test_etc.fap_job_test_etc_obj == \'C3600\' ">';
				context += '<button type="button" recruit-test-etc-obj-type-code="C3600"><code value="C3600"></code></button>';
				context += '</li>';
				context += '<li class="recruit-test-etc-obj-type" ng-if="jobRecruitPcs[i].job_test_etc.fap_job_test_etc_obj != \'C3600\' ">';
				context += '<button type="button" recruit-test-etc-obj-type-code="C3600"><code value="C3600"></code></button>';
				context += '</li>';
				context += '<li class="recruit-test-etc-obj-type selected" ng-if="jobRecruitPcs[i].job_test_etc.fap_job_test_etc_obj == \'C3601\' ">';
				context += '<button type="button" recruit-test-etc-obj-type-code="C3601"><code value="C3601"></code></button>';
				context += '</li>';
				context += '<li class="recruit-test-etc-obj-type" ng-if="jobRecruitPcs[i].job_test_etc.fap_job_test_etc_obj != \'C3601\' ">';
				context += '<button type="button" recruit-test-etc-obj-type-code="C3601"><code value="C3601"></code></button>';
				context += '</li>';
				context += '<li class="recruit-test-etc-obj-type selected" ng-if="jobRecruitPcs[i].job_test_etc.fap_job_test_etc_obj == \'C3602\' ">';
				context += '<button type="button" recruit-test-etc-obj-type-code="C3602"><code value="C3602"></code></button>';
				context += '</li>';
				context += '<li class="recruit-test-etc-obj-type" ng-if="jobRecruitPcs[i].job_test_etc.fap_job_test_etc_obj != \'C3602\' ">';
				context += '<button type="button" recruit-test-etc-obj-type-code="C3602"><code value="C3602"></code></button>';
				context += '</li>';
				context += '<li class="recruit-test-etc-obj-type etc selected" ng-if="jobRecruitPcs[i].job_test_etc.fap_job_test_etc_obj == \'C3603\' ">';
				context += '<button type="button" recruit-test-etc-obj-type-code="C3603"><code value="C3603"></code></button>';
				context += '</li>';
				context += '<li class="recruit-test-etc-obj-type etc" ng-if="jobRecruitPcs[i].job_test_etc.fap_job_test_etc_obj != \'C3603\' ">';
				context += '<button type="button" recruit-test-etc-obj-type-code="C3603"><code value="C3603"></code></button>';
				context += '</li>';
				context += '</ul>';
				context += '</div>';
				context += '</div>';
				if(jobRecruitPcs[i].job_test_etc.fap_job_test_etc_obj == 'C3603'){
					context += '<div class="sub-area display" style="display: block;">';
				}else{
					context += '<div class="sub-area display">';
				}
				context += '<div class="sub-area-inner">';
				context += '<div class="bar-inner">';
				context += '<h5 class="inner-title"><spring:message code="fap.common.etc" /></h5>';
				context += '<span class="inner-item">';
				context += '<textarea rows="4" cols="20" name="jobRecruitPcsList['+count+'].jobTestEtc.jobTestEtcObj.fap_job_test_etc_obj_dtl" ng-model="::jobRecruitPcs['+i+'].job_test_etc.job_test_etc_obj.fap_job_test_etc_obj_dtl"></textarea>';
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
				context += '<textarea rows="4" cols="20" name="jobRecruitPcsList['+count+'].jobTestEtc.fap_job_test_etc_dtl" ng-model="::jobRecruitPcs['+i+'].job_test_etc.fap_job_test_etc_dtl"></textarea>';
				context += '</div>';
				context += '</div>';
				context += '</div>';			
			}			
			
			$(".accordion:last").append($compile(context)($scope));	
			
			//아코디언 설정
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
		
		/* 채용전형 불러오기 끝 */
				
		
		//주요업무정보
		$scope.addWork = function() {
			
			var count = $(".work-type-plus .work-type-content").length;
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
			//실시간 유효성검사
			realTimeValidation();
			work_event();
			
		}
		
		$scope.removeWork = function() {
			var index = $(".work-type-plus .work-type-content").length;
			if(index > 1){
				$(".work-type-plus .work-type-content:last").remove();
			}			
		}
		
		//우대사항
		$scope.addPref = function() {
			var count = $(".preferences-type-plus .preferences-type-content").length;
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
			//실시간 유효성검사
			realTimeValidation();
			preferences_event();
			
		}
		
		$scope.removePref = function() {
			var index =$(".preferences-type-plus .preferences-type-content").length;
			if(index > 1 ){
				$(".preferences-type-plus .preferences-type-content:last").remove();
			}
			
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
			/* context += '<li class="recruit-type">';
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
			//실시간 유효성검사
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
			context += '<textarea rows="4" cols="20" name="jobRecruitPcsList['+count+'].jobExam.jobExamObjEtc.fap_job_exam_obj_etc_dtl"></textarea>';
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
			context += '<textarea rows="4" cols="20" name="jobRecruitPcsList['+count+'].jobExam.jobExamSvEtc.fap_job_exam_sv_etc_dtl"></textarea>';
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
			context += '<textarea rows="4" cols="20" name="jobRecruitPcsList['+count+'].jobExam.jobExamNeedEtc.fap_job_exam_need_etc_dtl"></textarea>';
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
			context += '<input type="text" name="jobRecruitPcsList['+count+'].jobExam.fap_job_exam_tm">';
			context += '<span class="hiddenTx">分</span>';
			context += '</div>';
			context += '</div>';
			context += '<div class="job-ad-row">';
			context += '<div class="job-ad-lt">';
			context += '<spring:message code="fap.comp.exam_file" />';
			context += '</div>';
			context += '<div class="job-ad-rt">';
			context += '<input type="file" id="jobRecruitPcsList['+count+'].jobExam.jobExamFile.fap_job_exam_file" name="jobRecruitPcsList['+count+'].jobExam.jobExamFile.fap_job_exam_file">';
			context += '<label for="jobRecruitPcsList['+count+'].jobExam.jobExamFile.fap_job_exam_file"><spring:message code="fap.placeholder.file_size" /></label>';
			context += '</div>';
			context += '</div>';
			context += '</div>';
			
			selected_obj.closest(".ui-accordion-content-header").nextAll(".ui-accordion-content-body").empty();
			selected_obj.closest(".ui-accordion-content-header").after($compile(context)($scope));
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
			context += '<input type="text" name="jobRecruitPcsList['+count+'].jobItv.fap_job_itv_skype">';
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
			context += '<textarea rows="4" cols="20" name="jobRecruitPcsList['+count+'].jobItv.jobItvObjEtc.fap_job_itv_obj_etc_dtl"></textarea>';
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
			context += '<textarea rows="4" cols="20" name="jobRecruitPcsList['+count+'].jobItv.jobItvTpEtc.fap_job_itv_tp_etc_dtl"></textarea>';
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
			context += '<input type="text" name="jobRecruitPcsList['+count+'].jobItv.fap_job_itv_tm">';
			context += '<span class="hiddenTx">分</span>';
			context += '</div>';
			context += '</div>';
			context += '</div>';
			
			selected_obj.closest(".ui-accordion-content-header").nextAll(".ui-accordion-content-body").empty();
			selected_obj.closest(".ui-accordion-content-header").after($compile(context)($scope));
			//실시간 유효성검사
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
			context += '<textarea rows="4" cols="20" name="jobRecruitPcsList['+count+'].jobTestEtc.jobTestEtcObj.fap_job_test_etc_obj_dtl"></textarea>';
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
			context += '<textarea rows="4" cols="20" name="jobRecruitPcsList['+count+'].jobTestEtc.fap_job_test_etc_dtl"></textarea>';
			context += '</div>';
			context += '</div>';
			context += '</div>';
			
			selected_obj.closest(".ui-accordion-content-header").nextAll(".ui-accordion-content-body").empty();
			selected_obj.closest(".ui-accordion-content-header").after($compile(context)($scope));
			//실시간 유효성검사
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
			context += '<input type="text" class="half" name="jobPayList['+count+'].fap_job_pay_dtl"  maxlength ="200" placeholder="200<spring:message code="fap.placeholder.limit_characters" />"/>';
			context += '</span>';
			context += '</div>';
			context += '<div class="inner-float">';
			context += '<h5 class="inner-title right-title"><spring:message code="fap.jobad.extra_fee" /></h5>';
			context += '<span class="inner-item right-title">';
			context += '<input type="text" class="currency half" name="jobPayList['+count+'].fap_job_pay_info" ng-model="::jobPayList['+count+'].fap_job_pay_info" blur-currency maxlength="9"/>';
			context += '<span class="hiddenTx">円</span>';
			context += '</span>';
			context += '</div>';
			context += '</div>';
			context += '</div>';
			context += '</div>';
			
			$(".job-extra-plus").append($compile(context)($scope));
			//실시간 유효성검사
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
			context += '<input type="text" class="currency half basic-fee" name="jobPayList[0].jobPayBase.jobPayBaseList[3].jobPayEtc.jobPayEtcList['+count+'].fap_job_pay_etc_info" ng-model="::jobPayList[0].jobPayBase.jobPayBaseList[3].jobPayEtc.jobPayEtcList['+count+'].fap_job_pay_etc_info" blur-currency maxlength ="9"/>';
			context += '<span class="hiddenTx">円</span>';
			context += '</span>';
			context += '</div>';
			context += '</div>';
			context += '</div>';
						
			$(".extra-fee-plus").append($compile(context)($scope));
			//실시간 유효성검사
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
		
		//급여 정보 뿌리기
		
		//기본급 합계 넣어주기
		if($scope.jobAdPay.JobPayList[0] != null){
			var total_base = 0;	//기본급 합계를 계산할 변수
			var jobPayBaseList = $scope.jobAdPay.JobPayList[0].JobPayBaseList;
			for(var i in jobPayBaseList){
				if(i == 3){
					continue;	//기타는 아래에서 계산
				}
				total_base = total_base + jobPayBaseList[i].fap_job_pay_base_info;
			}
			
			//기본급 기타 뿌려주기
			if($scope.jobAdPay.JobPayList[0].JobPayBaseList[3] != null){
				var jobPayEtcList = $scope.jobAdPay.JobPayList[0].JobPayBaseList[3].JobPayEtcList;
				for(var i in jobPayEtcList){
					//기본급 합계 기타 계산
					total_base = total_base + jobPayEtcList[i].fap_job_pay_etc_info;
					
					var count = $(".extra-fee-plus .sub-area-inner").length;
					var context = '';
					context += '<div class="sub-area-inner">';
					context += '<div class="bar-inner">';
					context += '<div class="inner-float">';
					context += '<h5 class="inner-title"><spring:message code="fap.jobad.extra_fee_name" /></h5>';
					context += '<span class="inner-item">';
					context += '<input type="text" class="half" name="jobPayList[0].jobPayBase.jobPayBaseList[3].jobPayEtc.jobPayEtcList[' + count + '].fap_job_pay_etc_nm" maxlength="15" ng-model="::jobAdPay.JobPayList[0].JobPayBaseList[3].JobPayEtcList[' + i + '].fap_job_pay_etc_nm" />';
					context += '</span>';
					context += '</div>';
					context += '<div class="inner-float">';
					context += '<h5 class="inner-title right-title"><spring:message code="fap.jobad.extra_fee" /></h5>';
					context += '<span class="inner-item right-title">';
					context += '<input type="text" class="currency half basic-fee" name="jobPayList[0].jobPayBase.jobPayBaseList[3].jobPayEtc.jobPayEtcList[' + count + '].fap_job_pay_etc_info" ng-model="::jobAdPay.JobPayList[0].JobPayBaseList[3].JobPayEtcList[' + i + '].fap_job_pay_etc_info" blur-currency maxlength ="9"/>';
					context += '<span class="hiddenTx">円</span>';
					context += '</span>';
					context += '</div>';
					context += '</div>';
					context += '</div>';
								
					$(".extra-fee-plus").append($compile(context)($scope));
				}
			}//기본급 기타 뿌려주기 끝
			
			//계산된 기본급 합계 넣어주기
			$(".basic-total").text(String(total_base).replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,'));
		}
		
		if($scope.jobAdPay.JobPayList[2] != null){
			//교통비 아리/나시 라벨 선택
			if($scope.jobAdPay.JobPayList[2].fap_job_pay_dtl == null){
				//교통비 없음을 클릭한경우
				var no = $(".job-radio.transport.no");
				$(no).addClass("ck");
				$(no).nextAll(".sub-area").css("display","none");
				$(no).nextAll(".sub-area").find("input[type='text']").val(0);
				$(no).nextAll(".sub-area").find("textarea").val("");
				$(no).nextAll(".sub-area").find("textarea").removeAttr("name");
			}else{
				//있음 or 선택을 안한경우
				var yes = $(".job-radio.transport.yes");
				$(yes).addClass("ck");
				$(yes).nextAll(".sub-area").css("display","block");
				$(yes).nextAll(".sub-area").find("textarea").attr("name", "jobPayList[2].fap_job_pay_dtl");
			}
			//교통비 아리/나시 라벨 선택 끝
		}
		
		if($scope.jobAdPay.JobPayList[3] != null){
			//상여 있음/없음 라벨 선택
			if($scope.jobAdPay.JobPayList[3].fap_job_pay_dtl == null){
				//상여 없음을 클릭한 경우
				var no = $(".job-radio.incentive.no");
				$(no).addClass("ck");
				$(no).nextAll(".sub-area").css("display","none");
				$(no).nextAll(".sub-area").find("input[type='text']").val(0);
				$(no).nextAll(".sub-area").find("textarea").val("");
				$(no).nextAll(".sub-area").find("textarea").removeAttr("name");
			}else{
				//있음 or 선택을 안한경우
				var yes = $(".job-radio.incentive.yes");
				$(yes).addClass("ck");
				$(yes).nextAll(".sub-area").css("display","block");
				$(yes).nextAll(".sub-area").find("textarea").attr("name", "jobPayList[3].fap_job_pay_dtl");
			}
			//상여 있음/없음 라벨 선택 끝
		}
		//기타수당 정보 뿌리기
		
		//기타수당 정보 뿌리기 끝
		var jobPayList = $scope.jobAdPay.JobPayList;
		for(var i in jobPayList){
			if(jobPayList[i].fap_job_pay_gb == "C2201"){
				//C2201 : 기타수당
				var count = $(".job-extra-plus .sub-area").length + 4;
				var context = '';
				context += '<div class="sub-area">';
				context += '<input type="hidden" name="jobPayList['+count+'].fap_job_pay_gb" value="C2201">';
				context += '<div class="sub-area-inner">';
				context += '<div class="bar-inner">';
				context += '<div class="inner-float">';
				context += '<h5 class="inner-title"><spring:message code="fap.jobad.extra_fee_name" /></h5>';
				context += '<span class="inner-item">';
				context += '<input type="text" class="half" name="jobPayList['+count+'].fap_job_pay_dtl" ng-model="::jobAdPay.JobPayList[' + i + '].fap_job_pay_dtl"  maxlength ="200" placeholder="200<spring:message code="fap.placeholder.limit_characters" />"/>';
				context += '</span>';
				context += '</div>';
				context += '<div class="inner-float">';
				context += '<h5 class="inner-title right-title"><spring:message code="fap.jobad.extra_fee" /></h5>';
				context += '<span class="inner-item right-title">';
				context += '<input type="text" class="currency half" name="jobPayList['+count+'].fap_job_pay_info" ng-model="::jobAdPay.JobPayList[' + i + '].fap_job_pay_info" blur-currency maxlength="9"/>';
				context += '<span class="hiddenTx">円</span>';
				context += '</span>';
				context += '</div>';
				context += '</div>';
				context += '</div>';
				context += '</div>';
				
				$(".job-extra-plus").append($compile(context)($scope));
			}
		}
		//급여 정보 뿌리기 끝
		//급여 끝
		
	//기타 동의 뿌려주기
		//SCIT 마스터 성적 필요
		if(jobAd.fap_job_ad_open_grade == "C1600"){
			//동의
			$(".job-radio.etc-grade.yes").addClass("ck");
			$(".job-radio.etc-grade.yes").find("input:radio[name='fap_job_ad_open_grade']").prop("checked", true);
		}else if(jobAd.fap_job_ad_open_grade == "C1601"){
			//비동의
			$(".job-radio.etc-grade.no").addClass("ck");
			$(".job-radio.etc-grade.no").find("input:radio[name='fap_job_ad_open_grade']").prop("checked", true);
		}
		
		//기타 - 재류자격(정처기)
		if(jobAd.fap_job_ad_qual_dpe == "C1700"){
			$(".job-radio.etc-qual_dpe.yes").addClass("ck");
			$(".job-radio.etc-qual_dpe.yes").find("input:radio[name='fap_job_ad_qual_dpe']").prop("checked", true);
		}else if(jobAd.fap_job_ad_qual_dpe == "C1701"){
			$(".job-radio.etc-qual_dpe.no").addClass("ck");
			$(".job-radio.etc-qual_dpe.no").find("input:radio[name='fap_job_ad_qual_dpe']").prop("checked", true);
		}
		
		//기타 - 채용조건(정처기)
		if(jobAd.fap_job_ad_terms_dpe == "C1800"){
			$(".job-radio.etc-terms_dpe.yes").addClass("ck");
			$(".job-radio.etc-terms_dpe.yes").find("input:radio[name='fap_job_ad_terms_dpe']").prop("checked", true);
		}else if(jobAd.fap_job_ad_terms_dpe == "C1801"){
			$(".job-radio.etc-terms_dpe.no").addClass("ck");
			$(".job-radio.etc-terms_dpe.no").find("input:radio[name='fap_job_ad_terms_dpe']").prop("checked", true);
		}
		
		//기타 - 수료
		if(jobAd.fap_job_ad_coc_agree == "C1900"){
			$(".job-radio.etc-coc_agree.yes").addClass("ck");
			$(".job-radio.etc-coc_agree.yes").find("input:radio[name='fap_job_ad_coc_agree']").prop("checked", true);
		}
		
		//기타 - 중복지원
		if(jobAd.fap_job_ad_overlap == "C2000"){
			$(".job-radio.etc-overlap.yes").addClass("ck");
			$(".job-radio.etc-overlap.yes").find("input:radio[name='fap_job_ad_overlap']").prop("checked", true);
		}else if(jobAd.fap_job_ad_overlap == "C2001"){
			$(".job-radio.etc-overlap.no").addClass("ck");
			$(".job-radio.etc-overlap.no").find("input:radio[name='fap_job_ad_overlap']").prop("checked", true);
		}
		
	//기타 동의 뿌려주기 끝
	
		/* 기업소개 파일 정보 뿌리기 */
		for(var i in job_file){
			if(job_file[i].fap_job_file_origin != null && job_file[i].fap_job_file_saved != null){
				
				var context = '';
				context += '<a class="job-ad-download" href="/file_download?origin=' + job_file[i].fap_job_file_origin + '&saved=' + job_file[i].fap_job_file_saved + '&path=' + job_file[i].file_path + '">';
				context += job_file[i].fap_job_file_origin;
				context += '</a>'
				
				if(job_file[i].fap_job_file_gb == "C0700"){
					//video
					context += '<input type="hidden" value="C0700" name="jobFileList[0].fap_job_file_gb" />';
					context += '<button class="btn-delete" type="button" onclick="update_job_file(\'video\')">';
					context += 'Delete';
					context += '</button>';
					$("#job_file_video_box").html(context);
				}else if(job_file[i].fap_job_file_gb == "C0701"){
					//pdf
					context += '<input type="hidden" value="C0701" name="jobFileList[1].fap_job_file_gb">';
					context += '<button class="btn-delete" type="button" onclick="update_job_file(\'pdf\')">';
					context += 'Delete';
					context += '</button>';
					$("#job_file_pdf_box").html(context);
				}else if(job_file[i].fap_job_file_gb == "C0702"){
					//photo
					context += '<input type="hidden" value="C0702" name="jobFileList[2].fap_job_file_gb">';
					context += '<button class="btn-delete" type="button" onclick="update_job_file(\'photo\')">';
					context += 'Delete';
					context += '</button>';
					$("#job_file_photo_box").html(context);
				}
				
			}
		}
		for(var i in job_file){
			var context = '';
			context += '<input type="hidden" name="jobFileList[' + i + '].fap_job_file_saved" value="' + job_file[i].fap_job_file_saved + '">';
			context += '<input type="hidden" name="jobFileList[' + i + '].fap_job_file_origin" value="' + job_file[i].fap_job_file_origin + '">';
			$("#job-ad-file-hidden-box").append(context);
		}
		/* 기업소개 파일 정보 뿌리기 끝*/
			
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
		
		//전형일정
		recruit_event();
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
		//면접구분
		recruit_itv_gb_type_event();			
		//면접대상자 구분
		recruit_itv_obj_type();			
		//면접형태 구분
		recruit_itv_tp_type();
		//면접구분
		recruit_itv_gb_type_event();			
		//면접대상자 구분
		recruit_itv_obj_type();			
		//면접형태 구분
		recruit_itv_tp_type();
		//기타전형 대상자 구분
		recruit_test_etc_obj_type();
		
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
				$(this).nextAll(".sub-area").find("textarea").attr("name", "jobPayList[3].fap_job_pay_dtl");
			}
			//없음 체크시
			else{
				$(this).nextAll(".sub-area").css("display","none");
				$(this).nextAll(".sub-area").find("input[type='text']").val(0);
				$(this).nextAll(".sub-area").find("textarea").val("");
				$(this).nextAll(".sub-area").find("textarea").removeAttr("name");
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
		
		/* 	if($(this).hasClass("ck")){
				$(this).nextAll(".sub-area").show();
				$(this).nextAll(".sub-area").find(".sub-area-inner").show();
			} */
			
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
	
	// 목록으로
	function return_list() {
		var fap_jobfair_seq = $('#fap_jobfair_seq').val();
		var fap_jobfair_divide_seq = $('#fap_jobfair_divide_seq').val();
		
		location.href='/fap/company/company_job_ad_management?fap_jobfair_seq='+fap_jobfair_seq+'&fap_jobfair_divide_seq='+fap_jobfair_divide_seq;
	}
	
	//회사소개 자료 이전자료 삭제하고 input:file 그리는 함수
	function update_job_file(type){
		var context = '';
		
		if(type == "video"){
			context += '<input type="hidden" value="C0700" name="jobFileList[0].fap_job_file_gb">';
			context += '<input type="file" name="jobFileList[0].job_ad_file" id="job_ad_file_video" accept="video/*">';
			context += '<label for="job_ad_file_video"><spring:message code="fap.placeholder.video_size" /></label>';
			$("#job_file_video_box").html(context);
		}else if(type == "pdf"){
			context += '<input type="hidden" value="C0701" name="jobFileList[1].fap_job_file_gb">';
			context += '<input type="file" name="jobFileList[1].job_ad_file" id="job_ad_file_pdf" accept=".pdf">';
			context += '<label for="job_ad_file_pdf"><spring:message code="fap.placeholder.file_size" /></label>';
			$("#job_file_pdf_box").html(context);
		}else if(type == "photo"){
			context += '<input type="hidden" value="C0702" name="jobFileList[2].fap_job_file_gb">';
			context += '<input type="file" name="jobFileList[2].job_ad_file" id="job_ad_file_img" accept="image/*">';
			context += '<label for="job_ad_file_img"><spring:message code="fap.placeholder.file_size" /></label>';
			$("#job_file_photo_box").html(context);
		}
	}
	
	//시험파일 수정후 빈 파일 만드는 함수
	function update_job_exam_file(count){
		var context = '';
		context += '<input type="file" id="fap_job_exam_file" name="jobRecruitPcsList['+count+'].jobExam.jobExamFile.fap_job_exam_file">';
		context += '<label for="fap_job_exam_file"><spring:message code="fap.placeholder.file_size" /></label>';
		$("#job-exam-file" + count).html(context);
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
	<div class="job-content">
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
			<input type="hidden" name="fap_job_ad_seq" value="{{jobAd.fap_job_ad_seq}}">
			
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
						<input class="input2" type="text" name="fap_job_ad_title" id="fap_job_ad_title" maxlength="50" ng-model="::jobAdCategory.fap_job_ad_title" placeholder="50<spring:message code="fap.placeholder.limit_characters" />">
					</div>
		    	</div>
		    	<div class="job-ad-row">
					<!-- 기업명(일본어) -->
					<div class="job-ad-lt point">
						<spring:message code="fap.comp.ja_nm" />
						<span class="red-point"></span>
					</div>
					<div class="job-ad-rt">
						<input type="text" class="input1" name="jobCompList[1].fap_job_comp_nm" id="comp_ja_nm" maxlength="50" placeholder="50<spring:message code="fap.placeholder.limit_characters" />" />
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
						<input type="text" class="input3" name="jobCompList[0].fap_job_comp_nm" id="comp_en_nm" maxlength="50" placeholder="50<spring:message code="fap.placeholder.limit_characters" />" />
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
						<input class="input2" type="text" id="fap_job_ad_major_business" name="fap_job_ad_major_business" ng-model="::jobAd.fap_job_ad_major_business" maxlength="100" placeholder="100<spring:message code="fap.placeholder.limit_characters" />">
					</div>
		    	</div>
				<div class="job-ad-row">
					<!-- 설립일, 자본금 -->
					<div class="job-ad-lt point">
						<spring:message code="fap.comp.est_dt" />
						<span class="red-point"></span>
					</div>
					<div class="job-ad-rt-md">
						<input class="input3" type="text" id="fap_job_ad_est_dt" name="fap_job_ad_est_dt" ng-model="::jobAd.fap_job_ad_est_dt" maxlength="15" placeholder="<spring:message code="fap.placeholder.est_dt" />">
					</div>
					<div class="job-ad-lt-md point">
							<spring:message code="fap.comp.stock" />
							<span class="red-point"></span>
					</div>
					<div class="job-ad-rt-la">
						<input class="input3 currency" type="text" id="fap_job_ad_stock" name="fap_job_ad_stock" ng-model="::jobAd.fap_job_ad_stock" blur-currency maxlength="22">
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
						<input class="input2 currency" type="text" id="fap_job_ad_3years_avg_sales" name="fap_job_ad_3years_avg_sales" ng-model="::jobAd.fap_job_ad_3years_avg_sales" blur-currency maxlength="22">
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
						<input class="input3 currency" type="text" id="fap_job_ad_employee_num" name="fap_job_ad_employee_num" ng-model="::jobAd.fap_job_ad_employee_num" blur-currency maxlength="9">
						<span class="hiddenTx">名</span>
					</div>
		    	</div>
		    	<div class="job-ad-row">
					<!-- 외국인 사원수, 한국인 사원수 -->
					<div class="job-ad-lt">
						<spring:message code="fap.comp.foreigner_num" />
					</div>
					<div class="job-ad-rt-md">
						<input class="input3 currency" type="text" name="fap_job_ad_foreigner_num" ng-model="::jobAd.fap_job_ad_foreigner_num" blur-currency maxlength="9">
						<span class="hiddenTx sm">名</span>
					</div>
					<div class="job-ad-lt-md">
						<spring:message code="fap.comp.korean_num" />
					</div>
					<div class="job-ad-rt-la">
						<input class="input3 currency" type="text" name="fap_job_ad_korean_num" ng-model="::jobAd.fap_job_ad_korean_num" blur-currency maxlength="9">
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
						<input class="input2" type="text" id="fap_job_ad_postcode" name="fap_job_ad_postcode" ng-model="::jobAd.fap_job_ad_postcode" maxlength="10" placeholder="<spring:message code="fap.placholder.postcode" />">
					</div>
		    	</div>
		    	<div class="job-ad-row">
					<!-- 주소 -->
					<div class="job-ad-lt point">
						<spring:message code="fap.comp.address" />
						<span class="red-point"></span>
					</div>
					<div class="job-ad-rt">
						<input class="input2" type="text" id="fap_job_ad_address" name="fap_job_ad_address" ng-model="::jobAd.fap_job_ad_address" maxlength="150">
					</div>
		    	</div>
		    	<div class="job-ad-row">
					<!-- 주소 -->
					<div class="job-ad-lt">
						<spring:message code="fap.comp.address_detail" />
					</div>
					<div class="job-ad-rt">
						<input class="input2" type="text" name="fap_job_ad_address_dtl" ng-model="::jobAd.fap_job_ad_address_dtl" maxlength="150">
					</div>
		    	</div>
				<div class="job-ad-row">
					<!-- 홈페이지 -->
					<div class="job-ad-lt">
						<spring:message code="fap.comp.homepage" />
					</div>
					<div class="job-ad-rt">
						<input class="input2" type="text" name="fap_job_ad_homepage" ng-model="::jobAd.fap_job_ad_homepage" maxlength="75">
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
								<input type="radio" name="fap_job_ad_category_type" id="categoty_type_ict" value="C5400" ng-model="::jobAd.fap_job_ad_category_type"/>
							</span>
							<span class="job-radio category-type etc-type">
								<label class="job-radio-label">
									<code value="C5401"></code>
								</label>
								<input type="radio" name="fap_job_ad_category_type" id="categoty_type_etc" value="C5401" ng-model="::jobAd.fap_job_ad_category_type" />
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
											<textarea rows="4" cols="20" name="jobCategoryList[4].JobCategoryEtc.fap_job_category_etc_dtl" maxlength="200" ng-model="::jobAdCategory.JobCategoryEtcList[0].fap_job_category_etc_dtl" placeholder="200<spring:message code="fap.placeholder.limit_characters" />"></textarea>
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
						<input class="input3" type="text" name="fap_job_ad_worktime" maxlength="15" ng-model="::jobAdCategory.fap_job_ad_worktime">
						<span class="hiddenTx sm">時間</span>
					</div>
					<div class="job-ad-lt-md">
						<spring:message code="fap.jobad.overtime" />
					</div>
					<div class="job-ad-rt-la">
						<input class="input3" type="text" name="fap_job_ad_overtime" maxlength="15" ng-model="::jobAdCategory.fap_job_ad_overtime">
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
							<input type="radio" name="fap_job_ad_hire_type" id="hire_type_regular" value="C0400" ng-model="::jobAdCategory.fap_job_ad_hire_type" />
						</span>
						<span class="job-radio hire-type contract">
							<label class="job-radio-label">
								<code value="C0401"></code>
							</label>
							<input type="radio" name="fap_job_ad_hire_type" id="hire_type_contract" value="C0401" ng-model="::jobAdCategory.fap_job_ad_hire_type" />
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
											<input type="radio" name="fap_job_jit_employee_isswitch" id="emp_switch_yes" value="C3800" ng-model="::jobAdCategory.JobJitList[0].fap_job_jit_employee_isswitch" />
										</span>
										<span class="job-radio emp-switch no">
											<label class="job-radio-label">
												<code value="C3801"></code>
											</label>
											<input type="radio" name="fap_job_jit_employee_isswitch" id="emp_switch_no" value="C3801" ng-model="::jobAdCategory.JobJitList[0].fap_job_jit_employee_isswitch" />
										</span>
										<span class="job-radio emp-switch yet">
											<label class="job-radio-label">
												<code value="C3802"></code>
											</label>
											<input type="radio" name="fap_job_jit_employee_isswitch" id="emp_switch_yet" value="C3802" ng-model="::jobAdCategory.JobJitList[0].fap_job_jit_employee_isswitch" />
										</span>
									</span>
								</div>
							</div>
							<div class="sub-area-inner emp-contract">
								<div class="bar-inner">
									<h5 class="inner-title"><spring:message code="fap.jobad.employee_term" /></h5>
									<span class="inner-item">
										<textarea rows="4" cols="20" name="fap_job_jit_employee_term" maxlength="200" ng-model="::jobAdCategory.JobJitList[0].fap_job_jit_employee_term" placeholder="200<spring:message code="fap.placeholder.limit_characters" />"></textarea>
									</span>
								</div>
							</div>
							<div class="sub-area-inner emp-contract">
								<div class="bar-inner">
									<h5 class="inner-title"><spring:message code="fap.jobad.employee_condition" /></h5>
									<span class="inner-item">
										<textarea rows="4" cols="20" name="fap_job_jit_employee_dtl" maxlength="200" ng-model="::jobAdCategory.JobJitList[0].fap_job_jit_employee_dtl" placeholder="200<spring:message code="fap.placeholder.limit_characters" />"></textarea>
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
						<input class="input2 currency" ng-model="::jobAdCategory.fap_job_ad_recruit_num" type="text" id="fap_job_ad_recruit_num" name="fap_job_ad_recruit_num" blur-currency maxlength="9">
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
								<input type="checkbox" name="jobWorkplaceList[0].fap_job_workplace_gb" value="C3900" ng-init="workplace_hokkaido_tohoku=workplace_hokkaido_tohoku=='C3900'" ng-model="::workplace_hokkaido_tohoku">
							</span>
							<span class="job-check long-check">
								<label class="job-check-label">
									<code value="C3901"></code>
								</label>
								<input type="checkbox" name="jobWorkplaceList[1].fap_job_workplace_gb" value="C3901" ng-init="workplace_kanto=workplace_kanto=='C3901'" ng-model="::workplace_kanto">
							</span>
							<span class="job-check long-check">
								<label class="job-check-label">
									<code value="C3902"></code>
								</label>
								<input type="checkbox" name="jobWorkplaceList[2].fap_job_workplace_gb" value="C3902" ng-init="workplace_hokuriku_koushinetsu=workplace_hokuriku_koushinetsu=='C3902'" ng-model="::workplace_hokuriku_koushinetsu">
							</span>
							<span class="job-check long-check">
								<label class="job-check-label">
									<code value="C3903"></code>
								</label>
								<input type="checkbox" name="jobWorkplaceList[3].fap_job_workplace_gb" value="C3903" ng-init="workplace_tokai=workplace_tokai=='C3903'" ng-model="::workplace_tokai">
							</span>
						</div>
						<div class="job-ad-inner-box p10">
							<span class="job-check long-check">
								<label class="job-check-label">
									<code value="C3904"></code>
								</label>
								<input type="checkbox" name="jobWorkplaceList[4].fap_job_workplace_gb" value="C3904" ng-init="workplace_kinki=workplace_kinki=='C3904'" ng-model="::workplace_kinki">
							</span>
							<span class="job-check long-check">
								<label class="job-check-label">
									<code value="C3905"></code>
								</label>
								<input type="checkbox" name="jobWorkplaceList[5].fap_job_workplace_gb" value="C3905" ng-init="workplace_chukoku_shikoku=workplace_chukoku_shikoku=='C3905'" ng-model="::workplace_chukoku_shikoku">
							</span>
							<span class="job-check long-check">
								<label class="job-check-label">
									<code value="C3906"></code>
								</label>
								<input type="checkbox" name="jobWorkplaceList[6].fap_job_workplace_gb" value="C3906" ng-init="workplace_kyushu_okinawa=workplace_kyushu_okinawa=='C3906'" ng-model="::workplace_kyushu_okinawa">
							</span>
							<span class="job-check long-check">
								<label class="job-check-label">
									<code value="C3907"></code>
								</label>
								<input type="checkbox" name="jobWorkplaceList[7].fap_job_workplace_gb" value="C3907" ng-init="workplace_all_area=workplace_all_area=='C3907'" ng-model="::workplace_all_area">
							</span>
						</div>
						<div class="job-ad-inner-box p10">
							<span class="job-check long-check">
								<label class="job-check-label">
									<code value="C3908"></code>
								</label>
								<input type="checkbox" name="jobWorkplaceList[8].fap_job_workplace_gb" value="C3908" ng-init="workplace_etc=workplace_etc=='C3908'" ng-model="::workplace_etc">
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
											<textarea rows="4" cols="20" name="jobWorkplaceList[8].JobWorkplaceEtc.fap_job_workplace_etc_address" maxlength="150" ng-model="::jobAdCategory.JobWorkplaceEtcList[0].fap_job_workplace_etc_address"></textarea>
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
							<input type="radio" name="fap_job_ad_intern" id="intern_yes" value="C0500" ng-model="::jobAdCategory.fap_job_ad_intern" />
						</span>
						<span class="job-radio intern no">
							<label class="job-radio-label">
								<code value="C0501"></code>
							</label>
							<input type="radio" name="fap_job_ad_intern" id="intern_no" value="C0501" ng-model="::jobAdCategory.fap_job_ad_intern" />
						</span>
						<div class="sub-area display">
							<div class="sub-area-inner">
								<div class="bar-inner">
									<h5 class="inner-title"><spring:message code="fap.jobad.jobtrial_pd" /></h5>
									<span class="inner-item">
										<input type="text" name="fap_job_trial_pd" maxlength="50" ng-model="::jobAdCategory.JobTrialList[0].fap_job_trial_pd" />
										<span class="hiddenTx"><spring:message code="fap.jobad.dorm_month" /></span>
									</span>
								</div>
							</div>
							<div class="sub-area-inner">
								<div class="bar-inner">
									<h5 class="inner-title"><spring:message code="fap.jobad.jobtrial_pay" /></h5>
									<span class="inner-item">
										<input type="text" class="currency" name="fap_job_trial_pay" ng-model="::jobAdCategory.JobTrialList[0].fap_job_trial_pay" blur-currency/>
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
											<input type="radio" name="fap_job_trial_pay_equal" id="trial_pay_equal" value="C2400" ng-model="::jobAdCategory.JobTrialList[0].fap_job_trial_pay_equal" />
										</span>
										<span class="job-radio trial-pay">
											<label class="job-radio-label">
												<code value="C2401"></code>
											</label>
											<input type="radio" name="fap_job_trial_pay_equal" id="trial_pay_not_equal" value="C2401" ng-model="::jobAdCategory.JobTrialList[0].fap_job_trial_pay_equal" />
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
							<input type="radio" name="fap_job_ad_isdorm" id="isdorm_yes" value="C0800" ng-model="::jobAdPay.fap_job_ad_isdorm" />
						</span>
						<span class="job-radio isdorm no">
							<label class="job-radio-label">
								<code value="C0801"></code>
							</label>
							<input type="radio" name="fap_job_ad_isdorm" id="isdorm_no" value="C0801" ng-model="::jobAdPay.fap_job_ad_isdorm" />
						</span>
						<div class="sub-area display">
							<div class="sub-area-inner">
								<div class="bar-inner">
									<h5 class="inner-title"><spring:message code="fap.jobad.dorm_lo" /></h5>
									<span class="inner-item">
										<input type="text" name="fap_job_dorm_lo" ng-model="::jobAdPay.JobDormList[0].fap_job_dorm_lo" maxlength="100" placeholder="100<spring:message code="fap.placeholder.limit_characters" />"/>
									</span>
								</div>
							</div>
							<div class="sub-area-inner">
								<div class="bar-inner">
									<h5 class="inner-title"><spring:message code="fap.jobad.dorm_cost" /></h5>
									<span class="inner-item">
										<input type="text" class="currency" name="fap_job_dorm_cost" ng-model="::jobAdPay.JobDormList[0].fap_job_dorm_cost" blur-currency/>
										<span class="hiddenTx">円/月</span>
									</span>
								</div>
							</div>
							<div class="sub-area-inner">
								<div class="bar-inner">
									<h5 class="inner-title"><spring:message code="fap.jobad.dorm_note" /></h5>
									<span class="inner-item">
										<textarea rows="4" cols="20" name="fap_job_dorm_note" ng-model="::jobAdPay.JobDormList[0].fap_job_dorm_note" maxlength="200" placeholder="<spring:message code="fap.placeholder.currency" />(200<spring:message code="fap.placeholder.limit_characters" />)"></textarea>
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
						<input class="input2" type="text" name="fap_job_ad_promotion" maxlength="100" ng-model="::jobAdPay.fap_job_ad_promotion" placeholder="100<spring:message code="fap.placeholder.limit_characters" />">
					</div>
		    	</div>
		    	<div class="job-ad-row">
					<!-- 휴일 -->
					<div class="job-ad-lt">
						<spring:message code="fap.jobad.vacation" />
					</div>
					<div class="job-ad-rt">
						<textarea rows="4" cols="20" name="fap_job_ad_vacation" maxlength="200" ng-model="::jobAdPay.fap_job_ad_vacation" placeholder="200<spring:message code="fap.placeholder.limit_characters" />"></textarea>
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
						<textarea rows="4" cols="20" name="fap_job_ad_welfare" maxlength="500" ng-model="::jobAdPay.fap_job_ad_welfare" placeholder="500<spring:message code="fap.placeholder.limit_characters" />"></textarea>
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
							<input type="radio" name="fap_job_ad_gender" id="gender_male" value="C4200" ng-model="::jobIdealPerson.fap_job_ad_gender" />
						</span>
						<span class="job-radio ad-gender">
							<label class="job-radio-label">
								<code value="C4201"></code>
							</label>
							<input type="radio" name="fap_job_ad_gender" id="gender_female" value="C4201" ng-model="::jobIdealPerson.fap_job_ad_gender" />
						</span>
						<span class="job-radio ad-gender">
							<label class="job-radio-label">
								<code value="C4202"></code>
							</label>
							<input type="radio" name="fap_job_ad_gender" id="gender_no_matter" value="C4202" ng-model="::jobIdealPerson.fap_job_ad_gender" />
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
							<input type="radio" name="fap_job_ad_age" value="C1400" id="under_25_age" ng-model="::jobIdealPerson.fap_job_ad_age" />
						</span>
						<span class="job-radio ad-age">
							<label class="job-radio-label">
								<code value="C1401"></code>
							</label>
							<input type="radio" name="fap_job_ad_age" id="under_30_age" value="C1401" ng-model="::jobIdealPerson.fap_job_ad_age" />
						</span>
						<span class="job-radio ad-age">
							<label class="job-radio-label">
								<code value="C1402"></code>
							</label>
							<input type="radio" name="fap_job_ad_age" id="under_35_age" value="C1402" ng-model="::jobIdealPerson.fap_job_ad_age" />
						</span>
						<span class="job-radio ad-age">
							<label class="job-radio-label">
								<code value="C1403"></code>
							</label>
							<input type="radio" name="fap_job_ad_age" id="age_no_matter" value="C1403" ng-model="::jobIdealPerson.fap_job_ad_age" />
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
							<input type="radio" name="fap_job_ja_level_gb" value="C4400" id="ja_level_jlpt_n1" ng-model="::jobIdealPerson.fap_job_ja_level.fap_job_ja_level_gb" />
						</span>
						<span class="job-radio ad-ja">
							<label class="job-radio-label">
								<code value="C4401"></code>
							</label>
							<input type="radio" name="fap_job_ja_level_gb" value="C4401" id="ja_level_jlpt_n2" ng-model="::jobIdealPerson.fap_job_ja_level.fap_job_ja_level_gb" />
						</span>
						<span class="job-radio ad-ja">
							<label class="job-radio-label">
								<code value="C4402"></code>
							</label>
							<input type="radio" name="fap_job_ja_level_gb" value="C4402" id="ja_level_jlpt_n3" ng-model="::jobIdealPerson.fap_job_ja_level.fap_job_ja_level_gb" />
						</span>
						<span class="job-radio ad-ja">
							<label class="job-radio-label">
								<code value="C4403"></code>
							</label>
							<input type="radio" name="fap_job_ja_level_gb" value="C4403" id="ja_level_no_matter" ng-model="::jobIdealPerson.fap_job_ja_level.fap_job_ja_level_gb" />
						</span>
						<div class="sub-area">
							<div class="sub-area-inner">
								<div class="bar-inner">
									<h5 class="inner-title"><spring:message code="fap.jobad.required_ja_level.detail" /></h5>
									<span class="inner-item">
										<textarea rows="4" cols="20" name="fap_job_ja_level_dtl" maxlength="200" ng-model="::jobIdealPerson.fap_job_ja_level.fap_job_ja_level_dtl" placeholder="200<spring:message code="fap.placeholder.limit_characters" />"></textarea>
									</span>
								</div>
							</div>
						</div>
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
						<textarea rows="4" cols="20" name="fap_job_ad_ideal_person" maxlength="800" ng-model="::jobIdealPerson.fap_job_ad_ideal_person" placeholder="800<spring:message code="fap.placeholder.limit_characters" />"></textarea>
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
										<input type="text" class="currency basic-fee" id="basic_pay_input" name="jobPayList[0].jobPayBase.jobPayBaseList[0].fap_job_pay_base_info" ng-model="::jobAdPay.JobPayList[0].JobPayBaseList[0].fap_job_pay_base_info" blur-currency/>
										<span class="hiddenTx">円</span>
									</span>
								</div>
							</div>
							<div class="sub-area-inner">
								<div class="bar-inner">
									<h5 class="inner-title"><spring:message code="fap.jobad.housing_fee" /></h5>
									<span class="inner-item">
										<input type="text" class="currency basic-fee" name="jobPayList[0].jobPayBase.jobPayBaseList[1].fap_job_pay_base_info" ng-model="::jobAdPay.JobPayList[0].JobPayBaseList[1].fap_job_pay_base_info" blur-currency/>
										<span class="hiddenTx">円</span>
									</span>
								</div>
							</div>
							<div class="sub-area-inner">
								<div class="bar-inner">
									<div class="inner-float">
										<h5 class="inner-title"><spring:message code="fap.jobad.service_overtime_fee" /></h5>
										<span class="inner-item">
											<input type="text" class="currency half basic-fee" name="jobPayList[0].jobPayBase.jobPayBaseList[2].fap_job_pay_base_info" ng-model="::jobAdPay.JobPayList[0].JobPayBaseList[2].fap_job_pay_base_info" blur-currency/>
											<span class="hiddenTx">円</span>
										</span>
									</div>
									<div class="inner-float">
										<h5 class="inner-title right-title"><spring:message code="fap.jobad.service_overtime_time" /></h5>
										<span class="inner-item right-title">
											<input type="text" class="currency half" name="jobPayList[0].jobPayBase.jobPayBaseList[2].jobServiceWork.fap_job_service_work_tm" ng-model="::jobAdPay.JobPayList[0].JobPayBaseList[2].JobServiceWorkList[0].fap_job_service_work_tm" blur-currency/>
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
										<textarea rows="4" cols="20" name="jobPayList[0].fap_job_pay_dtl" ng-model="::jobAdPay.JobPayList[0].fap_job_pay_dtl" maxlength="200" placeholder="200<spring:message code="fap.placeholder.limit_characters" />"></textarea>
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
											<input type="text" class="currency half" name="jobPayList[1].fap_job_pay_info" ng-model="::jobAdPay.JobPayList[1].fap_job_pay_info" blur-currency/>
											<span class="hiddenTx">円/時</span>
										</span>
									</div>
									<div class="inner-float">
										<h5 class="inner-title right-title"></h5>
										<span class="inner-item right-title">
											<input type="text" class="currency half" name="jobPayList[1].jobPayExtra.fap_job_pay_extra_tm" ng-model="::jobAdPay.JobPayList[1].JobPayExtraList[0].fap_job_pay_extra_tm" blur-currency/>
											<span class="hiddenTx">時間以上</span>
										</span>
									</div>
								</div>
							</div>
							<div class="sub-area-inner">
								<div class="bar-inner">
									<h5 class="inner-title"><spring:message code="fap.jobad.incentive.detail" /></h5>
									<span class="inner-item">
										<textarea rows="4" cols="20" name="jobPayList[1].fap_job_pay_dtl" ng-model="::jobAdPay.JobPayList[1].fap_job_pay_dtl" maxlength="200" placeholder="200<spring:message code="fap.placeholder.limit_characters" />"></textarea>
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
										<input type="text" class="currency" name="jobPayList[2].fap_job_pay_info" ng-model="::jobAdPay.JobPayList[2].fap_job_pay_info" blur-currency/>
										<span class="hiddenTx">円</span>
									</span>
								</div>
							</div>
							<div class="sub-area-inner">
								<div class="bar-inner">
									<h5 class="inner-title"><spring:message code="fap.jobad.detail" /></h5>
									<span class="inner-item">
										<textarea rows="4" cols="20" name="jobPayList[2].fap_job_pay_dtl" ng-model="::jobAdPay.JobPayList[2].fap_job_pay_dtl" maxlength="200" placeholder="<spring:message code="fap.placeholder.currency" />(200<spring:message code="fap.placeholder.limit_characters" />)"></textarea>
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
										<input type="text" class="currency" name="jobPayList[3].fap_job_pay_info" ng-model="::jobAdPay.JobPayList[3].fap_job_pay_info" blur-currency/>
										<span class="hiddenTx">円</span>
									</span>
								</div>
							</div>
							<div class="sub-area-inner">
								<div class="bar-inner">
									<h5 class="inner-title"><spring:message code="fap.jobad.incentive.detail" /></h5>
									<span class="inner-item">
										<textarea rows="4" cols="20" name="jobPayList[3].fap_job_pay_dtl" ng-model="::jobAdPay.JobPayList[3].fap_job_pay_dtl" maxlength="200" placeholder="<spring:message code="fap.placeholder.currency" />(200<spring:message code="fap.placeholder.limit_characters" />)"></textarea>
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
					<div class="job-ad-lt">
						<spring:message code="fap.jobad.recruit_pcs" />
					</div>
					<div class="job-ad-rt sal-row">
						<button type="button" class="btn-add" ng-click="addRecruitPcs()"></button>
						<button type="button" class="btn-remove" ng-click="removeRecruitPcs()"></button>
					</div>
				</div>
				<div class="accordion">
				
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
					<div id="job-ad-file-hidden-box">
					</div>
					<div class="job-ad-lt">
						<code value="C0700"></code>
					</div>
					<div class="job-ad-rt" id="job_file_video_box">
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
					<div class="job-ad-rt" id="job_file_pdf_box">
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
					<div class="job-ad-rt" id="job_file_photo_box">
						<input type="hidden" value="C0702" name="jobFileList[2].fap_job_file_gb">	
						<input type="file" name="jobFileList[2].job_ad_file" id="job_ad_file_photo" accept="image/*">
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
		</div>
	</div>
		<div id="footerdiv">
			<%@include file="../common_footer_fap.jsp"%>
		</div>
</body>
</html>
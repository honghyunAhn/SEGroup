<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Bridge Job Fair</title>
	<link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
	<script src="<c:url value="/resources/segroup/js/jquery-3.1.1.js" />"></script>
	<script src="<c:url value="/resources/segroup/js/jquery-ui.js" />"></script>
	<script src="<c:url value="/resources/segroup/js/angular.min.js" />"></script>
	<script src="<c:url value="/resources/segroup/js/datepicker.js" />"></script>
	<script src="<c:url value="/resources/segroup/js/jquery.timepicker.min.js" />"></script>
	<link rel="stylesheet" href="/resources/segroup/css/jquery.timepicker.css">	
	<!-- modal์ ์ํ bootstrap -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
	<link type="text/css" rel="stylesheet" href="<c:url value="/resources/segroup/society/fap/css/newAdminDefault.css" />" media="" />
	<script type="text/javascript">
		$(function() {			
			
			$('.registerModal').empty();
			cleanDatepicker();
			var setting = {
			        'minTime' : '00:00am',
			        'maxTime' : '23:55pm', 
			        'timeFormat' : 'H:i',
			        'step' : 5
			}
			
			minMax("fap_jobfair_st" , "fap_jobfair_et");
			minMax("fap_k_fair_st" , "fap_k_fair_et");			
			minMax("fap_j_fair_st" , "fap_j_fair_et");
			minMax("fap_post_season_st", "fap_post_season_et");
			minMax("fap_k_fair_app_st" , "fap_k_fair_app_et");			
			minMax("fap_j_fair_app_st" , "fap_j_fair_app_et");
			minMax("fap_post_season_app_st", "fap_post_season_app_et");
			minMax("fap_k_fair_user_date_st" , "fap_k_fair_user_date_et");			
			minMax("fap_j_fair_user_date_st" , "fap_j_fair_user_date_et");
			minMax("fap_post_season_user_date_st" , "fap_post_season_user_date_et");
			minMaxTime("fap_k_fair_user_time_st", "23:55pm", setting);
			minMaxTime("00:00am", "fap_k_fair_user_time_et", setting);
			minMaxTime("fap_j_fair_user_time_st", "23:55pm", setting);
			minMaxTime("00:00am", "fap_j_fair_user_time_et", setting);
			minMaxTime("fap_post_season_user_time_st", "23:55pm", setting);
			minMaxTime("00:00am", "fap_post_season_user_time_et", setting);
			
			/* minMax("fap_missmatching_st" , "fap_missmatching_et");
			minMax("fap_missmatching_app_st" , "fap_missmatching_app_et");
			minMax("fap_missmatching_user_date_st" , "fap_missmatching_user_date_et");
			minMaxTime("fap_missmatching_user_time_st", "fap_missmatching_user_time_et", setting); */
			
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
			
			$("#fap_jobfair_log_file").change(function() {
				var val = $(this).val();
	
				if (val == "") {
					$(this).val('');
					$("#imgDiv").empty();
					return;
				} else if (fileImageCheck(val)) {
					photoAjax();
				} else {
					$(this).val('');
					$("#imgDiv").empty();
					alert("์ด๋ฏธ์ง ํ์ผ์ด ์๋๋๋ค. gif, jpg, png ํ์๋ง ๊ฐ๋ฅ ํฉ๋๋ค.");
					return;
				}
			});			
		});
	
		// ์ฌ์ง AJAX
		function photoAjax() {
			var size = $("#fap_jobfair_log_file")[0].files[0].size;
			if (fileSizeCheck(size)) {
				var formData = new FormData();
				formData.append("file", $("#fap_jobfair_log_file")[0].files[0]);

				$.ajax({
					type : "POST",
					url : "/temporarily_upload",
					data : formData,
					processData : false,
					contentType : false,
					dataType : "json",
					success : function(data) {
						$("#imgDiv").empty();
						$("#imgDiv").html('<img alt="" src="/edu/temporarilyPath/'+data.savedfile+'" style="width: 440px;height: 180px;">');
					},
					error : function(e) {
						console.log(e);
					}
				});
			} else {
				$("#app_photo_file").val('');
				$("#imgDiv").empty();
				alert("ํ์ผ ์ฌ์ด์ฆ๋ 5MB ๊น์ง ์๋๋ค.");
			}
		}
		
		function fileSizeCheck(size) {
			//5MB
			var maxSize = 5242880;
			var fileSize = Math.round(size);
			if (fileSize > maxSize) {
				return false;
			}
			return true;
		}
		
		function fileImageCheck(name) {
			switch (name.substring(name.lastIndexOf('.') + 1).toLowerCase()) {
			case 'gif':
			case 'jpg':
			case 'png':
				return true;
			default:
				return false;
			}
		}				

	</script>
	
	<script type="text/javascript">
		//์?ํจ์ฑ ๊ฒ์ฌ
		function form_Check() {
			var fap_jobfair_title = $('#fap_jobfair_title').val();
			var fap_jobfair_st = $('#fap_jobfair_st').val();
			var fap_jobfair_et = $('#fap_jobfair_et').val();
			var fap_apply_max_multiple = $('#fap_apply_max_multiple').val();
			var fap_limit_interview_count = $('#fap_limit_interview_count').val();
			var fap_k_fair_st = $('#fap_k_fair_st').val();
			var fap_k_fair_et = $('#fap_k_fair_et').val();
			var fap_k_fair_app_st = $('#fap_k_fair_app_st').val();
			var fap_k_fair_app_et = $('#fap_k_fair_app_et').val();			
			var fap_j_fair_st = $('#fap_j_fair_st').val();
			var fap_j_fair_et = $('#fap_j_fair_et').val();
			var fap_j_fair_app_st = $('#fap_j_fair_app_st').val();
			var fap_j_fair_app_et = $('#fap_j_fair_app_et').val();
			var fap_post_season_st = $('#fap_post_season_st').val();
			var fap_post_season_et = $('#fap_post_season_et').val();
			var fap_post_season_app_st = $('#fap_post_season_app_st').val();
			var fap_post_season_app_et = $('#fap_post_season_app_et').val();
			var fap_k_fair_user_date_st = $('#fap_k_fair_user_date_st').val();
			var fap_k_fair_user_date_et = $('#fap_k_fair_user_date_et').val();			
			var fap_j_fair_user_date_st = $('#fap_j_fair_user_date_st').val();
			var fap_j_fair_user_date_et = $('#fap_j_fair_user_date_et').val();
			var fap_post_season_user_date_st = $('#fap_post_season_user_date_st').val();
			var fap_post_season_user_date_et = $('#fap_post_season_user_date_et').val();
			var fap_k_fair_user_time_st = $('#fap_k_fair_user_time_st').val();
			var fap_k_fair_user_time_et = $('#fap_k_fair_user_time_et').val();			
			var fap_j_fair_user_time_st = $('#fap_j_fair_user_time_st').val();
			var fap_j_fair_user_time_et = $('#fap_j_fair_user_time_et').val();
			var fap_post_season_user_time_st = $('#fap_post_season_user_time_st').val();
			var fap_post_season_user_time_et = $('#fap_post_season_user_time_et').val();
			
			/* var fap_missmatching_st = $('#fap_missmatching_st').val();
			var fap_missmatching_et = $('#fap_missmatching_et').val();
			var fap_missmatching_app_st = $('#fap_missmatching_app_st').val();
			var fap_missmatching_app_et = $('#fap_missmatching_app_et').val();
			var fap_missmatching_user_date_st = $('#fap_missmatching_user_date_st').val();
			var fap_missmatching_user_date_et = $('#fap_missmatching_user_date_et').val();
			var fap_missmatching_user_time_st = $('#fap_missmatching_user_time_st').val();
			var fap_missmatching_user_time_et = $('#fap_missmatching_user_time_et').val(); */
						
			//comma
			$.each($(".currency"),function(index,item){
				var commaValue = angular.element(item).val();
				angular.element(item).val(commaValue.replace(/,/g, ''));
			});
			
			//์์, ์ข๋ฃ์ผ ์ฒดํฌ
			if(fap_k_fair_st != '' && fap_k_fair_st < fap_jobfair_st){
				alert('K-fair ์์์ผ์ ์กํ์ด ์์์ผ ์ด์?์ด ๋? ์ ์์ต๋๋ค.');
				return false;
			}			
			if(fap_j_fair_st != '' && fap_j_fair_st < fap_jobfair_st){
				alert('J-fair ์์์ผ์ ์กํ์ด ์์์ผ ์ด์?์ด ๋? ์ ์์ต๋๋ค.');
				return false;
			}			
			if(fap_post_season_st != '' && fap_post_season_st < fap_jobfair_st){
				alert('ํฌ์คํธ์์ฆ ์์์ผ์ ์กํ์ด ์์์ผ ์ด์?์ด ๋? ์ ์์ต๋๋ค.');
				return false;
			}
			if(fap_k_fair_et != '' && fap_jobfair_et < fap_k_fair_et ){
				alert('K-fair ์ข๋ฃ์ผ์ ์กํ์ด ์ข๋ฃ์ผ ์ดํ๊ฐ ๋? ์ ์์ต๋๋ค.');
				return false;
			}
			if(fap_j_fair_et != '' && fap_jobfair_et < fap_j_fair_et ){
				alert('J-fair ์ข๋ฃ์ผ์ ์กํ์ด ์ข๋ฃ์ผ ์ดํ๊ฐ ๋? ์ ์์ต๋๋ค.');
				return false;
			}
			if(fap_post_season_et != '' && fap_jobfair_et < fap_post_season_et ){
				alert('ํฌ์คํธ์์ฆ ์ข๋ฃ์ผ์ ์กํ์ด ์ข๋ฃ์ผ ์ดํ๊ฐ ๋? ์ ์์ต๋๋ค.');
				return false;
			}
			
			//Job-fair
			if(fap_jobfair_title == ''){
				alert('์?๋ชฉ์ ํ์ ์๋?ฅ ์ฌํญ์๋๋ค.');
				$('#fap_jobfair_title').focus();
				return false;
			}			
			if(fap_jobfair_st == ''){
				alert('์์์ผ์ ํ์ ์๋?ฅ ์ฌํญ์๋๋ค.');
				$('#fap_jobfair_st').focus();
				return false;
			}			
			if(fap_jobfair_et == ''){
				alert('์ข๋ฃ์ผ์ ํ์ ์๋?ฅ ์ฌํญ์๋๋ค.');
				$('#fap_jobfair_et').focus();
				return false;
			}			
			if(!$("#checkBox_Seoul").is(":checked") & !$("#checkBox_Tokyo").is(":checked")){
				alert('๊ฐ์ต์ง๋ ํ์ ์๋?ฅ ์ฌํญ์๋๋ค.');
				return false;
			}			
			if(!$("#k_fair_checkbox").is(":checked") & !$("#j_fair_checkbox").is(":checked") & !$("#post_season_checkbox").is(":checked")){
				alert('์ธ๋ถ๊ตฌ๋ถ ํ์ ์๋?ฅ ์ฌํญ์๋๋ค.');
				return false;
			}			
			if($(':radio[name="fap_jobfair_eps"]:checked').length < 1){
				alert('๋ธ์ถ์ฌ๋ถ๋ ํ์ ์๋?ฅ ์ฌํญ์๋๋ค.');
				return false;
			}
			if($(':radio[name="fap_limit_interview_type"]:checked').length < 1){
				alert('์?ํ ๋์์ ํ์ ์๋?ฅ ์ฌํญ์๋๋ค.');
				return false;
			}
			if(fap_apply_max_multiple == 0 ){
				alert('์ง์๊ฐ๋ฅ ์ธ์ ๋ฐฐ์๋ ํ์ ์๋?ฅ ์ฌํญ์๋๋ค.');
				return false;
			}
			if(fap_limit_interview_count == 0){
				alert('ํ์ง์ธ์ ์?ํ ๋ฐฐ์๋ ํ์ ์๋?ฅ ์ฌํญ์๋๋ค.');
				return false;
			}
			if($("#fap_jobfair_log_file").val() == ""){
				alert('์กํ์ด ๋ก๊ณ?๋ ํ์ ์๋?ฅ ์ฌํญ์๋๋ค.');
				return false;
			}
			
			//K-fair
			if($("#k_fair_checkbox").is(":checked")){
				if(fap_k_fair_st == ''){
					alert('K-fair ์์์ผ์ ํ์ ์๋?ฅ ์ฌํญ์๋๋ค.');
					return false;
				}
				if(fap_k_fair_et == ''){
					alert('K-fair ์ข๋ฃ์ผ์ ํ์ ์๋?ฅ ์ฌํญ์๋๋ค.');
					return false;
				}
				if(fap_k_fair_app_st == ''){
					alert('K-fair ์ฑ์ฉ๊ธฐ์ ์ฐธ๊ฐ์์์ผ์ ํ์ ์๋?ฅ ์ฌํญ์๋๋ค.');
					return false;
				}
				if(fap_k_fair_app_et == ''){
					alert('K-fair ์ฑ์ฉ๊ธฐ์ ์ฐธ๊ฐ์ข๋ฃ์ผ์ ํ์ ์๋?ฅ ์ฌํญ์๋๋ค.');
					return false;
				}
				if(!$("#fap_k_fair_time_first").is(":checked") & !$("#fap_k_fair_time_not_first").is(":checked")){
					alert('K-fair ์ต์ด์ง์ ํ์ฉ์ฌ๋ถ๋ ํ์ ์๋?ฅ ์ฌํญ์๋๋ค.');
					return false;
				}				
				if(fap_k_fair_user_date_st == ''){
					alert('K-fair ์ง์์ ์ง์์์์ผ์ ํ์ ์๋?ฅ ์ฌํญ์๋๋ค.');
					return false;
				}
				if(fap_k_fair_user_date_et == ''){
					alert('K-fair ์ง์์ ์ง์์ข๋ฃ์ผ์ ํ์ ์๋?ฅ ์ฌํญ์๋๋ค.');
					return false;
				}
				if(fap_k_fair_user_time_st == ''){
					alert('K-fair ์ง์์ ์ง์์์์๊ฐ์ ํ์ ์๋?ฅ ์ฌํญ์๋๋ค.');
					return false;
				}
				if(fap_k_fair_user_time_et == ''){
					alert('K-fair ์ง์์ ์ง์์ข๋ฃ์๊ฐ์ ํ์ ์๋?ฅ ์ฌํญ์๋๋ค.');
					return false;
				}				
				if(!$("#k_fair_master_checkbox").is(":checked") & !$("#k_fair_k_move_checkbox").is(":checked") & !$("#k_fair_user_checkbox").is(":checked")& !$("#k_fair_jap_checkbox").is(":checked")){
					alert('K-fair ์ฑ์ฉ๋์์ ํ์ ์๋?ฅ ์ฌํญ์๋๋ค.');
					return false;
				}
				if(!$("#fap_jobfair_k_fair_eps").is(":checked") & !$("#fap_jobfair_k_fair_not_eps").is(":checked")){
					alert('K-fair ๋ธ์ถ์ฌ๋ถ๋ ํ์ ์๋?ฅ ์ฌํญ์๋๋ค.');
					return false;
				}
				if($('#fap_jobfair_k_fair_app_num').val() == 0){
					alert('K-fair ์ง๋ง๊ฐ๋ฅ ๊ฐ์๋ ํ์ ์๋?ฅ ์ฌํญ์๋๋ค.');
					return false;
				}				
			}
			
			//J-fair
			if($("#j_fair_checkbox").is(":checked")){
				if(fap_j_fair_st == ''){
					alert('J-fair ์์์ผ์ ํ์ ์๋?ฅ ์ฌํญ์๋๋ค.');
					return false;
				}
				if(fap_j_fair_et == ''){
					alert('J-fair ์ข๋ฃ์ผ์ ํ์ ์๋?ฅ ์ฌํญ์๋๋ค.');
					return false;
				}
				if(fap_j_fair_app_st == ''){
					alert('J-fair ์ฑ์ฉ๊ธฐ์ ์ฐธ๊ฐ์์์ผ์ ํ์ ์๋?ฅ ์ฌํญ์๋๋ค.');
					return false;
				}
				if(fap_j_fair_app_et == ''){
					alert('J-fair ์ฑ์ฉ๊ธฐ์ ์ฐธ๊ฐ์ข๋ฃ์ผ์ ํ์ ์๋?ฅ ์ฌํญ์๋๋ค.');
					return false;
				}
				if(!$("#fap_j_fair_time_first").is(":checked") & !$("#fap_j_fair_time_not_first").is(":checked") & !$("#fap_j_fair_time_missmatching").is(":checked")){
					alert('J-fair ์ต์ด์ง์ ํ์ฉ์ฌ๋ถ๋ ํ์ ์๋?ฅ ์ฌํญ์๋๋ค.');
					return false;
				}	
				if(fap_j_fair_user_date_st == ''){
					alert('J-fair ์ง์์ ์ง์์์์ผ์ ํ์ ์๋?ฅ ์ฌํญ์๋๋ค.');
					return false;
				}
				if(fap_j_fair_user_date_et == ''){
					alert('J-fair ์ง์์ ์ง์์ข๋ฃ์ผ์ ํ์ ์๋?ฅ ์ฌํญ์๋๋ค.');
					return false;
				}
				if(fap_j_fair_user_time_st == ''){
					alert('J-fair ์ง์์ ์ง์์์์๊ฐ์ ํ์ ์๋?ฅ ์ฌํญ์๋๋ค.');
					return false;
				}
				if(fap_j_fair_user_time_et == ''){
					alert('J-fair ์ง์์ ์ง์์ข๋ฃ์๊ฐ์ ํ์ ์๋?ฅ ์ฌํญ์๋๋ค.');
					return false;
				}
				if(!$("#j_fair_master_checkbox").is(":checked") & !$("#j_fair_k_move_checkbox").is(":checked") & !$("#j_fair_user_checkbox").is(":checked") & !$("#j_fair_jap_checkbox").is(":checked")){
					alert('J-fair ์ฑ์ฉ๋์์ ํ์ ์๋?ฅ ์ฌํญ์๋๋ค.');
					return false;
				}
				if(!$("#fap_jobfair_j_fair_eps").is(":checked") & !$("#fap_jobfair_j_fair_not_eps").is(":checked")){
					alert('J-fair ๋ธ์ถ์ฌ๋ถ๋ ํ์ ์๋?ฅ ์ฌํญ์๋๋ค.');
					return false;
				}
				if($('#fap_jobfair_j_fair_app_num').val() == 0){
					alert('J-fair ์ง๋ง๊ฐ๋ฅ ๊ฐ์๋ ํ์ ์๋?ฅ ์ฌํญ์๋๋ค.');
					return false;
				}	
			}
			
			//ํฌ์คํธ์์ฆ
			if($("#post_season_checkbox").is(":checked")){
				if(fap_post_season_st == ''){
					alert('ํฌ์คํธ์์ฆ ์์์ผ์ ํ์ ์๋?ฅ ์ฌํญ์๋๋ค.');
					return false;
				}
				if(fap_post_season_et == ''){
					alert('ํฌ์คํธ์์ฆ ์ข๋ฃ์ผ์ ํ์ ์๋?ฅ ์ฌํญ์๋๋ค.');
					return false;
				}
				if(fap_post_season_app_st == ''){
					alert('ํฌ์คํธ์์ฆ ์ฑ์ฉ๊ธฐ์ ์ฐธ๊ฐ์์์ผ์ ํ์ ์๋?ฅ ์ฌํญ์๋๋ค.');
					return false;
				}
				if(fap_post_season_app_et == ''){
					alert('ํฌ์คํธ์์ฆ ์ฑ์ฉ๊ธฐ์ ์ฐธ๊ฐ์ข๋ฃ์ผ์ ํ์ ์๋?ฅ ์ฌํญ์๋๋ค.');
					return false;
				}
				if(!$("#fap_post_season_time_first").is(":checked") & !$("#fap_post_season_time_not_first").is(":checked") & !$("#fap_post_season_time_missmatching").is(":checked")){
					alert('ํฌ์คํธ์์ฆ ์ต์ด์ง์ ํ์ฉ์ฌ๋ถ๋ ํ์ ์๋?ฅ ์ฌํญ์๋๋ค.');
					return false;
				}	
				if(fap_post_season_user_date_st == ''){
					alert('ํฌ์คํธ์์ฆ ์ง์์ ์ง์์์์ผ์ ํ์ ์๋?ฅ ์ฌํญ์๋๋ค.');
					return false;
				}
				if(fap_post_season_user_date_et == ''){
					alert('ํฌ์คํธ์์ฆ ์ง์์ ์ง์์ข๋ฃ์ผ์ ํ์ ์๋?ฅ ์ฌํญ์๋๋ค.');
					return false;
				}
				if(fap_post_season_user_time_st == ''){
					alert('ํฌ์คํธ์์ฆ ์ง์์ ์ง์์์์๊ฐ์ ํ์ ์๋?ฅ ์ฌํญ์๋๋ค.');
					return false;
				}
				if(fap_post_season_user_time_et == ''){
					alert('ํฌ์คํธ์์ฆ ์ง์์ ์ง์์ข๋ฃ์๊ฐ์ ํ์ ์๋?ฅ ์ฌํญ์๋๋ค.');
					return false;
				}				
				if(!$("#post_season_master_checkbox").is(":checked") & !$("#post_season_k_move_checkbox").is(":checked") & !$("#post_season_user_checkbox").is(":checked")){
					alert('ํฌ์คํธ์์ฆ ์ฑ์ฉ๋์์ ํ์ ์๋?ฅ ์ฌํญ์๋๋ค.');
					return false;
				}
				if(!$("#fap_jobfair_post_season_eps").is(":checked") & !$("#fap_jobfair_post_season_not_eps").is(":checked")){
					alert('ํฌ์คํธ์์ฆ ๋ธ์ถ์ฌ๋ถ๋ ํ์ ์๋?ฅ ์ฌํญ์๋๋ค.');
					return false;
				}
				if($('#fap_jobfair_post_season_app_num').val() == 0){
					alert('ํฌ์คํธ์์ฆ ์ง๋ง๊ฐ๋ฅ ๊ฐ์๋ ํ์ ์๋?ฅ ์ฌํญ์๋๋ค.');
					return false;
				}				
			}			
			
			/* //๋ฏธ์ค๋งค์นญ
			if($("#missmatching_checkbox").is(":checked")){
				if(fap_missmatching_st == ''){
					alert('๋ฏธ์ค๋งค์นญ ์์์ผ์ ํ์ ์๋?ฅ ์ฌํญ์๋๋ค.');
					return false;
				}
				if(fap_missmatching_et == ''){
					alert('๋ฏธ์ค๋งค์นญ ์ข๋ฃ์ผ์ ํ์ ์๋?ฅ ์ฌํญ์๋๋ค.');
					return false;
				}
				if(fap_missmatching_app_st == ''){
					alert('๋ฏธ์ค๋งค์นญ ์ฑ์ฉ๊ธฐ์ ์ฐธ๊ฐ์์์ผ์ ํ์ ์๋?ฅ ์ฌํญ์๋๋ค.');
					return false;
				}
				if(fap_missmatching_app_et == ''){
					alert('๋ฏธ์ค๋งค์นญ ์ฑ์ฉ๊ธฐ์ ์ฐธ๊ฐ์ข๋ฃ์ผ์ ํ์ ์๋?ฅ ์ฌํญ์๋๋ค.');
					return false;
				}
				if(!$("#fap_missmatching_time_first").is(":checked") & !$("#fap_missmatching_time_not_first").is(":checked") & !$("#fap_missmatching_time_missmatching").is(":checked")){
					alert('๋ฏธ์ค๋งค์นญ ์ต์ด์ง์ ํ์ฉ์ฌ๋ถ๋ ํ์ ์๋?ฅ ์ฌํญ์๋๋ค.');
					return false;
				}	
				if(fap_missmatching_user_date_st == ''){
					alert('๋ฏธ์ค๋งค์นญ ์ง์์ ์ง์์์์ผ์ ํ์ ์๋?ฅ ์ฌํญ์๋๋ค.');
					return false;
				}
				if(fap_missmatching_user_date_et == ''){
					alert('๋ฏธ์ค๋งค์นญ ์ง์์ ์ง์์ข๋ฃ์ผ์ ํ์ ์๋?ฅ ์ฌํญ์๋๋ค.');
					return false;
				}
				if(fap_missmatching_user_time_st == ''){
					alert('๋ฏธ์ค๋งค์นญ ์ง์์ ์ง์์์์๊ฐ์ ํ์ ์๋?ฅ ์ฌํญ์๋๋ค.');
					return false;
				}
				if(fap_missmatching_user_time_et == ''){
					alert('๋ฏธ์ค๋งค์นญ ์ง์์ ์ง์์ข๋ฃ์๊ฐ์ ํ์ ์๋?ฅ ์ฌํญ์๋๋ค.');
					return false;
				}				
				if(!$("#missmatching_master_checkbox").is(":checked") & !$("#missmatching_k_move_checkbox").is(":checked") & !$("#missmatching_user_checkbox").is(":checked")){
					alert('๋ฏธ์ค๋งค์นญ ์ฑ์ฉ๋์์ ํ์ ์๋?ฅ ์ฌํญ์๋๋ค.');
					return false;
				}
				if(!$("#fap_jobfair_missmatching_eps").is(":checked") & !$("#fap_jobfair_missmatching_not_eps").is(":checked")){
					alert('๋ฏธ์ค๋งค์นญ ๋ธ์ถ์ฌ๋ถ๋ ํ์ ์๋?ฅ ์ฌํญ์๋๋ค.');
					return false;
				}
				if($('#fap_jobfair_missmatching_app_num').val() == 0){
					alert('๋ฏธ์ค๋งค์นญ ์ง๋ง๊ฐ๋ฅ ๊ฐ์๋ ํ์ ์๋?ฅ ์ฌํญ์๋๋ค.');
					return false;
				}	
			} */
			
			//ํ์ฌ๊ทธ๋ฃน
			if($('#fap_comp_groupcode_0').val() == null || $('#fap_comp_groupcode_0').val() == ''){
				alert('ํ์ฌ๊ทธ๋ฃน์ ํ์ ์๋?ฅ ์ฌํญ์๋๋ค.');
				$('#fap_comp_groupcode_0').focus();
				return false;
			}
			if($('#fap_comp_stock_0').val() == null || $('#fap_comp_stock_0').val() == 0){
				alert('์๋ณธ๊ธ์ ํ์ ์๋?ฅ ์ฌํญ์๋๋ค.');
				$('#fap_comp_stock_0').focus();
				return false;
			}
			if($('#fap_comp_3years_avg_sales_0').val() == null || $('#fap_comp_3years_avg_sales_0').val() == 0){
				alert('๋งค์ถ์ก์ ํ์ ์๋?ฅ ์ฌํญ์๋๋ค.');
				$('#fap_comp_3years_avg_sales_0').focus();
				return false;
			}
			if($('#fap_comp_employee_num_0').val() == null || $('#fap_comp_employee_num_0').val() == 0){
				alert('์ฌ์์๋ ํ์ ์๋?ฅ ์ฌํญ์๋๋ค.');
				$('#fap_comp_employee_num_0').focus();
				return false;
			}	
			
			
		}			
	</script>
	
	<script type="text/javascript">	
		
	var myApp = angular.module('myapp', []);		
	
		myApp.controller('MainController', ['$scope','$compile','$http', function($scope,$compile,$http){	
			$http({
				method: 'POST',
				url: '/fap/admin/jobfair_search_list'
			}).then(function successCallback(response) {				
				$scope.opening_jobfair_draw(response);			
				$scope.jobfair_draw(response);
			}, function errorCallback(response) {

			});
			
			$scope.search_change = function(){
				var fap_jobfair_opening_flag = $('#opening_jobfair_Select').val();
				
				$http({
					method: 'POST',
					url: "/fap/admin/jobfair_search_list",
					params : {
						'fap_jobfair_opening_flag' : fap_jobfair_opening_flag
					}
				}).then(function successCallback(response) {
					
					$scope.jobfair_draw(response);
					 
				}, function errorCallback(response) {
				
				});
			}		
			
			$scope.opening_jobfair_draw = function(){
				var context = '';
				context += '<option selectcode value="C4502"></option>';
				context += '<option selectcode value="C4500"></option>';
				context += '<option selectcode value="C4501"></option>';
				$("#opening_jobfair_Select").html($compile(context)($scope));
			}
			
			$scope.jobfair_draw = function(response){
				$scope.results = response.data;
				var context = '';
				context += '<tr>';
				context += '<tr ng-repeat="result in results | filter:query">';
				context += '<td><input type="checkbox" name="fapJobfairCheck" value="{{result.fap_jobfair_seq}}" class="form-control"></td>';
				context += '<td><span>{{$index+1}}</span></td>';
				context += '<td><input type="text" value="{{result.fap_jobfair_seq}}"></td>';
				context += '<td><input type="text" value="{{result.fap_jobfair_title}}"></td>';
				context += '<td><input type="text" value="{{result.fap_jobfair_st}}"></td>';
				context += '<td><input type="text" value="{{result.fap_jobfair_et}}"></td>';
				context += '<td ng-if="result.fap_jobfair_eps == \'C1200\' ">';
				context += '<span selectcode value="C1200"></span>';
				context += '</td>';
				context += '<td ng-if="result.fap_jobfair_eps == \'C1201\' ">';
				context += '<span selectcode value="C1201"></span>';
				context += '</td>';
				context += '</tr>';

				$("#search_data").html($compile(context)($scope));
			}
			
			//ํ์ฌ๊ทธ๋ฃน ์ถ๊ฐ
			$scope.add_comp_group = function() {
				var compGroupClass = $(".comp_group_div");
				var compGroupIndex = compGroupClass.length;
				var context = '';
				context += '<div class="comp_group_div">';
				context += '<div class="form-row">';
				context += '<div class="form-group col-sm-2">';
				context += '	<input type="text" class="form-control" name="fap_comp_group_list[' + compGroupIndex + '].fap_comp_groupcode" id="fap_comp_groupcode_'+ compGroupIndex + '">';							
				context += '</div>';
				context += '<div class="form-group col-sm-4">';
				context += '	<input type="text" class="form-control currency" name="fap_comp_group_list[' + compGroupIndex + '].fap_comp_stock" id="fap_comp_stock_'+ compGroupIndex + '" ng-model="commaTest" blur-currency>';
				context += '</div>';
				context += '<div class="form-group col-sm-4">';
				context += '	<input type="text" class="form-control currency" name="fap_comp_group_list[' + compGroupIndex + '].fap_comp_3years_avg_sales" id="fap_comp_3years_avg_sales_'+ compGroupIndex + '" ng-model="commaTest" blur-currency>';
				context += '</div>';
				context += '<div class="form-group col-sm-2">';
				context += '	<input type="text" class="form-control currency" name="fap_comp_group_list[' + compGroupIndex + '].fap_comp_employee_num" id="fap_comp_employee_num_'+ compGroupIndex + '" ng-model="commaTest" blur-currency>';
				context += '</div>';
				context += '</div>';
				context += '</div>';
				
				$(".comp_group_div:last").after($compile(context)($scope));
			}
			
			//ํ์ฌ๊ทธ๋ฃน ์ญ์?
			$scope.delete_comp_group = function() {
				var compGroupIndex = $(".comp_group_div").length;
				if (compGroupIndex > 1) {
					$(".comp_group_div:last").remove();
				}
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
		
	</script>

	<script type="text/javascript">
	//์กํ์ด ์ธ๋ถ์?๋ณด๋ฅผ ์ฒดํฌํ ๊ฒฝ์ฐ๋ง ๋ธ์ถ
	$(document).ready(function(){
		$("#k_body").hide();		
		$("#j_body").hide();
		$("#p_body").hide();
		/* $("#m_body").hide();	 */	
		
	    $("#k_fair_checkbox").change(function(){
	        if($("#k_fair_checkbox").is(":checked")){
	            $("#k_body").show();
	        }else{
	            $("#k_body").hide();
	        }
	    });
	    
	    $("#j_fair_checkbox").change(function(){
	        if($("#j_fair_checkbox").is(":checked")){
	            $("#j_body").show();
	        }else{
	            $("#j_body").hide();
	        }
	    });
		
	    $("#post_season_checkbox").change(function(){
	        if($("#post_season_checkbox").is(":checked")){
	            $("#p_body").show();
	        }else{
	            $("#p_body").hide();
	        }
	    });	    
	    
	   /*  $("#missmatching_checkbox").change(function(){
	        if($("#missmatching_checkbox").is(":checked")){
	            $("#m_body").show();
	        }else{
	            $("#m_body").hide();
	        }
	    }); */
	    	    
	});
	</script>
	
	<script type="text/javascript">
	$(document).ready(function () {
		//์กํ์ด ์ญ์?
        $('#jobfair_delete_Btn').click(function () {
        
        	var fap_jobfair_seq_list = new Array();
        	$("input:checkbox[name=fapJobfairCheck]:checked").each(function(){
        		fap_jobfair_seq_list.push($(this).val());
        	});        	
        	
        	if(fap_jobfair_seq_list.length == 0){
          	 	alert('์ญ์?ํ? ์กํ์ด๋ฅผ ์?ํํ์ธ์.');
          		return;
            }
        	
            if (confirm("์?๋ง ์ญ์?ํ์๊ฒ?์ต๋๊น?") == true){
           		location.href="/fap/admin/jobfair_delete?fap_jobfair_seq_list=" + fap_jobfair_seq_list;
           	}else{
           	   return;
           }  
             
       });
		
		//์กํ์ด ์์?
		$('#jobfair_update_Btn').click(function(){
			var fap_jobfair_seq_list = new Array();
			$("input:checkbox[name=fapJobfairCheck]:checked").each(function(){
				fap_jobfair_seq_list.push($(this).val());
			});
			if(fap_jobfair_seq_list.length == 0){
          	 	alert('์์?ํ? ์กํ์ด๋ฅผ ์?ํํ์ธ์.');
          		return;
            }
			if(fap_jobfair_seq_list.length > 1){
				alert('์์?ํ? ์กํ์ด๋ ํ๋๋ง ์?ํํ์ธ์.');
				return;
			}
			fap_jobfair_seq = fap_jobfair_seq_list[0];
			location.href="/fap/admin/jobfair_update_form?fap_jobfair_seq=" + fap_jobfair_seq;
		});
			
		// [start] ์ถ๊ฐ์ง์ ๊ธฐ์์ค์? - ๋์
		$('#additionalApplyCompanyConfigured').click(function(){
			var fap_jobfair_seq_list = new Array();
			$("input:checkbox[name=fapJobfairCheck]:checked").each(function(){
				fap_jobfair_seq_list.push($(this).val());
			});
			if(fap_jobfair_seq_list.length == 0){
	      	 	alert('์์?ํ? ์กํ์ด๋ฅผ ์?ํํ์ธ์.');
	      		return;
	        }
			if(fap_jobfair_seq_list.length > 1){
				alert('์์?ํ? ์กํ์ด๋ ํ๋๋ง ์?ํํ์ธ์.');
				return;
			}
			fap_jobfair_seq = fap_jobfair_seq_list[0];
			location.href="/fap/admin/additional_apply_company_configured?fap_jobfair_seq=" + fap_jobfair_seq;
		});
		// [end] ์ถ๊ฐ์ง์ ๊ธฐ์์ค์? - ๋์
		
		// [start] ์ถ๊ฐ์ง์ ๊ธฐ์์ค์? - ๋์
		$('#applyBusinessRuleApplicationBtn').click(function(){
			var fap_jobfair_seq_list = new Array();
			$("input:checkbox[name=fapJobfairCheck]:checked").each(function(){
				fap_jobfair_seq_list.push($(this).val());
			});
			if(fap_jobfair_seq_list.length == 0){
	      	 	alert('์์?ํ? ์กํ์ด๋ฅผ ์?ํํ์ธ์.');
	      		return;
	        }
			if(fap_jobfair_seq_list.length > 1){
				alert('์์?ํ? ์กํ์ด๋ ํ๋๋ง ์?ํํ์ธ์.');
				return;
			}
			fap_jobfair_seq = fap_jobfair_seq_list[0];
			location.href="/fap/admin/apply_business_rule_application_form?fap_jobfair_seq=" + fap_jobfair_seq;
		});
		// [end] ์ถ๊ฐ์ง์ ๊ธฐ์์ค์? - ๋์
		
		// [start] ๋ฏธ์ค๋งค์นญ/์ถ๊ฐ์ง์ํ์ฉ - ๋ณํธ
		$('#miss_matching_btn').click(function(){
			var fap_jobfair_seq_list = new Array();
			$("input:checkbox[name=fapJobfairCheck]:checked").each(function(){
				fap_jobfair_seq_list.push($(this).val());
			});
			if(fap_jobfair_seq_list.length == 0){
	      	 	alert(' ๋ฏธ์ค๋งค์นญ/์ถ๊ฐ์ง์ํ์ฉ ํ? ์กํ์ด๋ฅผ ์?ํํ์ธ์.');
	      		return;
	        }
			if(fap_jobfair_seq_list.length > 1){
				alert(' ๋ฏธ์ค๋งค์นญ/์ถ๊ฐ์ง์ํ์ฉ ํ? ์กํ์ด๋ ํ๋๋ง ์?ํํ์ธ์.');
				return;
			}
			var fap_jobfair_seq = fap_jobfair_seq_list[0];
			
			location.href="/fap/admin/jobfair_applicable_time_management?fap_jobfair_seq=" + fap_jobfair_seq;
			
		});
		// [end] ๋ฏธ์ค๋งค์นญ/์ถ๊ฐ์ง์ํ์ฉ - ๋ณํธ
     });
	
	</script>
	
</head>
<body ng-app="myapp" ng-controller="MainController">
<%@include file="admin_menu.jsp"%>
	<div class="container">
		<br>
		<div class="page_title">
			<h2>JobFair ๊ด๋ฆฌ</h2>
		</div>
		<br>
		<div class="search_div">
			<div class="search_box">
				<table class="search_box">
					<colgroup>
						<col width="30%">
						<col width="80%">
					</colgroup>
					<tr>	
						<td>
							<select id="opening_jobfair_Select" onchange="angular.element(this).scope().search_change()"></select>
							<input type="text" ng-model="query" placeholder="๊ฒ์์ด ์๋?ฅ">
						</td>
					</tr>
					<tr>
						<td>
							<button class="btn btn-primary" data-toggle="modal" data-target="#registerModal">์กํ์ด ๋ฑ๋ก</button>
							<button id="jobfair_update_Btn" class="btn btn-info">์กํ์ด ์์?</button>
							<button id="jobfair_delete_Btn" class="btn btn-danger">์กํ์ด ์ญ์?</button>
						</td>
					</tr>
					<tr>
						<td>
							<button id="additionalApplyCompanyConfigured" class="btn btn-primary">์ถ๊ฐ์ง์ ๊ธฐ์์ค์?</button>
							<button id="applyBusinessRuleApplicationBtn" class="btn btn-danger">์ง์๋ฃฐ ์?์ฉ</button>
							<button id="miss_matching_btn" class="btn btn-info">๋ฏธ์ค๋งค์นญ/์ถ๊ฐ์ง์ํ์ฉ</button>
						</td>
					</tr>
				</table>
			</div>
		</div>
		<br><br>
		<table class="table">
			<thead>
				<tr>
					<th><span>์?ํ</span></th>
					<th><span>No</span></th>
					<th><span>์กํ์ด ์ํ์ค</span></th>
					<th><span>์?๋ชฉ</span></th>	
					<th><span>์์์ผ</span></th>
					<th><span>์ข๋ฃ์ผ</span></th>
					<th><span>๋ธ์ถ์ฌ๋ถ</span></th>
				</tr>
			</thead>
			<tbody id="search_data"></tbody>
		</table>	
		<br><br>
		<!-- ์กํ์ด ๋ฑ๋ก Modal -->
		<div class="modal fade" id="registerModal" tabindex="-1" role="dialog" aria-labelledby="modal" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title" id="modal">์กํ์ด ๋ฑ๋ก</h5>
						<button type="button" class="close" data-dismiss="modal" aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<form action="/fap/admin/jobfair_insert" method="post" onsubmit="return form_Check();" enctype="multipart/form-data">
						<div class="modal-body">					
							<!-- ์กํ์ด -->
							<div class="form-group">
								<label>์?๋ชฉ</label>
								<input type="text" name="fap_jobfair_title" id="fap_jobfair_title" class="form-control" maxlength="50">
							</div>
							<div class="form-row">
								<label>๊ฐ์ต๊ธฐ๊ฐ</label>
							</div> 
							<div class="form-row">
								<div class="form-group col-sm-6">								
									<input type="text" name="fap_jobfair_st" id="fap_jobfair_st" class="date_format" maxlength="20" value="">
								</div>
								<div class="form-group col-sm-6">
									<label>&nbsp;</label>
									<input type="text" name="fap_jobfair_et" id="fap_jobfair_et" class="date_format" maxlength="20" value="">
								</div>
							</div>
							<div class="form-row">
								<div class="form-group col-sm-2">
									<label>๊ฐ์ต์ง</label>
									<input type="checkbox" name="fap_jobfair_lo_list[0].fap_jobfair_lo" id="checkBox_Seoul" class="form-control" value="C0000">
								</div>
								<div class="form-group col-sm-2">
									<label>&nbsp;</label>
									<h5><code value="C0000"></code></h5>
								</div>
								<div class="form-group col-sm-2">
									<label>&nbsp;</label>
									<input type="checkbox" name="fap_jobfair_lo_list[1].fap_jobfair_lo" id="checkBox_Tokyo" class="form-control" value="C0001">
								</div>
								<div class="form-group col-sm-2">
									<label>&nbsp;</label>
									<h5><code value="C0001"></code></h5>
								</div>
							</div>						
							
							<div class="form-row">
								<div class="form-group col-sm-2">
									<label>์ธ๋ถ๊ตฌ๋ถ</label>
									<input type="checkbox" name="fap_jobfair_divide_gb_list[0].fap_jobfair_divide_gb" id="k_fair_checkbox" class="form-control" value="C0100">
								</div>
								<div class="form-group col-sm-2">
									<label>&nbsp;</label>
									<h5><code value="C0100"></code></h5>
								</div>	
								<div class="form-group col-sm-2">
									<label></label>
									<input type="checkbox" name="fap_jobfair_divide_gb_list[1].fap_jobfair_divide_gb" id="j_fair_checkbox" class="form-control" value="C0101">
								</div>
								<div class="form-group col-sm-2">
									<label>&nbsp;</label>
									<h5><code value="C0101"></code></h5>
								</div>
								<div class="form-group col-sm-2">
									<label></label>
									<input type="checkbox" name="fap_jobfair_divide_gb_list[2].fap_jobfair_divide_gb" id="post_season_checkbox" class="form-control" value="C0102">
								</div>
								<div class="form-group col-sm-2">
									<label>&nbsp;</label>
									<h5><code value="C0102"></code></h5>
								</div>
								<%-- <div class="form-group col-sm-2">
									<label>&nbsp;</label>
									<input type="checkbox" name="fap_jobfair_divide_gb_list[3].fap_jobfair_divide_gb" id="missmatching_checkbox" class="form-control" value="C0103">
								</div>	
								<div class="form-group col-sm-3">
									<label>&nbsp;</label>
									<h5><code value="C0103"></code></h5>
								</div>	 --%>							
							</div>						
							
							<div class="form-row">						
								<div class="form-group col-sm-2">
									<label>๋ธ์ถ์ฌ๋ถ</label>
									<input type="radio" name="fap_jobfair_eps" id="fap_jobfair_not_eps" class="form-control" value="C1200">
								</div>
								<div class="form-group col-sm-2">
									<label>&nbsp;</label>
									<h5><code value="C1200"></code></h5>
								</div>
								<div class="form-group col-sm-2">
									<label>&nbsp;</label>
									<input type="radio" name="fap_jobfair_eps" id="fap_jobfair_eps" class="form-control" value="C1201">
								</div>
								<div class="form-group col-sm-2">
									<label>&nbsp;</label>
									<h5><code value="C1201"></code></h5>
								</div>		
							</div>	
							
							<div class="form-row">
								<div class="form-group col-sm-6">
									<label>์ง์๊ฐ๋ฅ ์ธ์ ๋ฐฐ์</label>
									<select class="form-control" name="fap_apply_max_multiple" id="fap_apply_max_multiple">
										<option value="0">์?ํ</option>
										<option value="1">1</option>
										<option value="2">2</option>
										<option value="3">3</option>
										<option value="4">4</option>
										<option value="5">5</option>
										<option value="6">6</option>
										<option value="7">7</option>
										<option value="8">8</option>
										<option value="9">9</option>
										<option value="10">10</option>
									</select>
								</div>
								<div class="form-group col-sm-2">
									<label>&nbsp;</label>
									<h5 class="form-control">๋ฐฐ์</h5>
								</div>
							</div>	
							
							<div class="form-row">
								<div class="form-group col-sm-6">
									<label>ํ์ง์ธ์ ์?ํ ๋ฐฐ์</label>
									<select class="form-control" name="fap_limit_interview_count" id="fap_limit_interview_count">
										<option value="0">์?ํ</option>
										<option value="1">1</option>
										<option value="2">2</option>
										<option value="3">3</option>
										<option value="4">4</option>
										<option value="5">5</option>
										<option value="6">6</option>
										<option value="7">7</option>
										<option value="8">8</option>
										<option value="9">9</option>
										<option value="10">10</option>
									</select>
								</div>
								<div class="form-group col-sm-2">
									<label>&nbsp;</label>
									<h5 class="form-control">๋ฐฐ์</h5>
								</div>
							</div>
							
							<div class="form-row">
								<div class="form-group col-sm-2">
									<label>์?ํ ๋์</label>
									<input type="radio" name="fap_limit_interview_type" class="form-control" value="C5400">
								</div>
								<div class="form-group col-sm-2">
									<label>&nbsp;</label>
									<h5><code value="C5400"></code></h5>
								</div>
								<div class="form-group col-sm-2">
									<label>&nbsp;</label>
									<input type="radio" name="fap_limit_interview_type" class="form-control" value="C5401">
								</div>
								<div class="form-group col-sm-2">
									<label>&nbsp;</label>
									<h5><code value="C5401"></code></h5>
								</div>	
								<div class="form-group col-sm-2">
									<label>&nbsp;</label>
									<input type="radio" name="fap_limit_interview_type" class="form-control" value="C5402">
								</div>
								<div class="form-group col-sm-2">
									<label>&nbsp;</label>
									<h5><code value="C5402"></code></h5>
								</div>	
							</div>
							
							
							<div class="comp_group_div">
								<div class="form-row">
									<div class="form-group col-sm-2">
										<label>ํ์ฌ๊ทธ๋ฃน</label>
										<input type="text" class="form-control" name="fap_comp_group_list[0].fap_comp_groupcode" id="fap_comp_groupcode_0">									
									</div>
									<div class="form-group col-sm-4">
										<label>์๋ณธ๊ธ(์)โ</label>
										<input type="text" class="form-control currency" name="fap_comp_group_list[0].fap_comp_stock" id="fap_comp_stock_0" ng-model="commaTest" blur-currency>
									</div>
									<div class="form-group col-sm-4">
										<label>๋งค์ถ์ก(์)โ</label>
										<input type="text" class="form-control currency" name="fap_comp_group_list[0].fap_comp_3years_avg_sales" id="fap_comp_3years_avg_sales_0" ng-model="commaTest" blur-currency>
									</div>
									<div class="form-group col-sm-2">
										<label>์ฌ์(๋ช)โ</label>
										<input type="text" class="form-control currency" name="fap_comp_group_list[0].fap_comp_employee_num" id="fap_comp_employee_num_0" ng-model="commaTest" blur-currency>
									</div>
								</div>						
							</div>
							
							<div class="form-row">
								<img alt="" src="/resources/segroup/society/fap/images/main/plus_icon.png" id="plug_comp_group" ng-click="add_comp_group()">
								<img alt="" src="/resources/segroup/society/fap/images/main/minus_icon.png" id="minus_comp_group" ng-click="delete_comp_group()">
							</div>
							
							<br>					
							<div class="form-row">
									<label>๋ก๊ณ?(์?ํ์ฌํญ, ํฌ๊ธฐ๋ 400*300)</label>
									<input type="file" id="fap_jobfair_log_file" name="fap_jobfair_log_file" accept="image/*">					
							</div>
							<div class="form-row" id="imgDiv"></div>			
							
							<br><br>
							
							<!-- K-fair -->
							<div id="k_body" style="display: none;">
							------------------------------------------------------------------------
								<div class="form-row">
									<label>K-fair ๊ธฐ๊ฐ</label>
								</div>
								<div class="form-row">
									<div class="form-group col-sm-6">									
										<input type="text" name="fap_jobfair_divide_gb_list[0].fap_jobfair_divide_st" id="fap_k_fair_st" class="date_format" maxlength="20" value="">
									</div>
									<div class="form-group col-sm-6">
										<label>&nbsp;</label>
										<input type="text" name="fap_jobfair_divide_gb_list[0].fap_jobfair_divide_et" id="fap_k_fair_et" class="date_format" maxlength="20" value="">
									</div>
								</div>							
								<div class="form-row">
									<label>K-fair ์?์ฒญ๊ฐ๋ฅ๊ธฐ๊ฐ</label>
								</div>
								<div class="form-row">
									<div class="form-group col-sm-6">									
										<input type="text" name="fap_jobfair_divide_gb_list[0].fap_jobfair_divide_app_st" id="fap_k_fair_app_st" class="date_format" maxlength="20" value="">
									</div>
									<div class="form-group col-sm-6">
										<label>&nbsp;</label>
										<input type="text" name="fap_jobfair_divide_gb_list[0].fap_jobfair_divide_app_et" id="fap_k_fair_app_et" class="date_format" maxlength="20" value="">
									</div>
								</div>		
								
								<div class="form-row">
									<label>K-fair ์ง์์ ์ง์ํ๊ฐ ์ต์ด์ฌ๋ถ</label>
								</div>
								<div class="form-row">
									<div class="form-group col-sm-1">
										<input checked="checked" type="radio" name="fap_k_fair_applicable_time_list[0].fap_jobfair_applicable_time_first" id="fap_k_fair_time_first" class="form-control" value="D0300">
									</div>
									<div class="form-group col-sm-3">
										<h5><code value="D0300"></code></h5>
									</div>
									<%-- <div class="form-group col-sm-1">
										<input type="radio" name="fap_k_fair_applicable_time_list[0].fap_jobfair_applicable_time_first" id="fap_k_fair_time_not_first" class="form-control" value="D0301">
									</div>
									<div class="form-group col-sm-3">
										<h5><code value="D0301"></code></h5>
									</div>
									<div class="form-group col-sm-1">
										<input type="radio" name="fap_k_fair_applicable_time_list[0].fap_jobfair_applicable_time_first" id="fap_k_fair_time_missmatching" class="form-control" value="D0302">
									</div>
									<div class="form-group col-sm-3">
										<h5><code value="D0302"></code></h5>
									</div>	 --%>
								</div>
								
								<div class="form-row">
									<label>K-fair ์ง์์ ์ง์๊ฐ๋ฅ๊ธฐ๊ฐ</label>
								</div>
								<div class="form-row">
									<div class="form-group col-sm-3">									
										<input type="text" name="fap_k_fair_applicable_time_list[0].fap_jobfair_divide_user_date_st" id="fap_k_fair_user_date_st" class="date_format" value="" style="width: 100px;">
									</div>
									<div class="form-group col-sm-3">
										<label>&nbsp;</label>
										<input type="text" name="fap_k_fair_applicable_time_list[0].fap_jobfair_divide_user_time_st" id="fap_k_fair_user_time_st" class="time_format" value="" style="width: 80px;">&ensp;~
									</div>
									<div class="form-group col-sm-3">									
										<input type="text" name="fap_k_fair_applicable_time_list[0].fap_jobfair_divide_user_date_et" id="fap_k_fair_user_date_et" class="date_format" value="" style="width: 100px;">
									</div>
									<div class="form-group col-sm-3">
										<label>&nbsp;</label>
										<input type="text" name="fap_k_fair_applicable_time_list[0].fap_jobfair_divide_user_time_et" id="fap_k_fair_user_time_et" class="time_format" value="" style="width: 80px;">
									</div>
								</div>	
													
								<div class="form-row">
								<div class="form-group col-sm-2">
									<label style="width: 120px;">K-fair์ฑ์ฉ๋์</label>
									<input type="checkbox" name="fap_jobfair_k_fair_rc_list[0].fap_jobfair_divide_rc" id="k_fair_master_checkbox" class="form-control" value="A0101">
								</div>
								<div class="form-group col-sm-2">
									<label>&nbsp;</label>
									<h6><code value="A0101"></code></h6>
								</div>
								<div class="form-group col-sm-2">
									<label>&nbsp;</label>
									<input type="checkbox" name="fap_jobfair_k_fair_rc_list[1].fap_jobfair_divide_rc" id="k_fair_k_move_checkbox" class="form-control" value="A0106">
								</div>
								<div class="form-group col-sm-2">
									<label>&nbsp;</label>
									<h6><code value="A0106"></code></h6>
								</div>
								<div class="form-group col-sm-2">
									<label>&nbsp;</label>
									<input type="checkbox" name="fap_jobfair_k_fair_rc_list[2].fap_jobfair_divide_rc" id="k_fair_user_checkbox" class="form-control" value="A0100">
								</div>
								<div class="form-group col-sm-2">
									<label>&nbsp;</label>
									<h6><code value="A0100"></code></h6>
								</div>
								<div class="form-group col-sm-2">
									<label>&nbsp;</label>
									<input type="checkbox" name="fap_jobfair_k_fair_rc_list[3].fap_jobfair_divide_rc" id="k_fair_jap_checkbox" class="form-control" value="A0108">
								</div>
								<div class="form-group col-sm-2">
									<label>&nbsp;</label>
									<h6><code value="A0108"></code></h6>
								</div>
							</div>
							
							<div class="form-row">
							<div class="form-group col-sm-2">
									<label>๋ธ์ถ์ฌ๋ถ</label>
									<input type="radio" name="fap_jobfair_divide_gb_list[0].fap_jobfair_divide_gb_eps" id="fap_jobfair_k_fair_not_eps" class="form-control" value="C1300">
								</div>
								<div class="form-group col-sm-2">
									<label>&nbsp;</label>
									<h5><code value="C1300"></code></h5>
								</div>
								<div class="form-group col-sm-2">
									<label>&nbsp;</label>
									<input type="radio" name="fap_jobfair_divide_gb_list[0].fap_jobfair_divide_gb_eps" id="fap_jobfair_k_fair_eps" class="form-control" value="C1301">
								</div>
								<div class="form-group col-sm-2">
									<label>&nbsp;</label>
									<h5><code value="C1301"></code></h5>
								</div>		
							</div>
							
							<div class="form-row">
								<div class="form-group col-sm-6">
									<label>์ง๋ง๊ฐ๋ฅ ๊ฐ์</label>
									<select class="form-control" id="fap_jobfair_k_fair_app_num" name="fap_jobfair_divide_gb_list[0].fap_jobfair_divide_app_num">
										<option value="0">์?ํ</option>
										<option value="1">1</option>
										<option value="2">2</option>
										<option value="3">3</option>
										<option value="4">4</option>
										<option value="5">5</option>
										<option value="6">6</option>
										<option value="7">7</option>
										<option value="8">8</option>
										<option value="9">9</option>
										<option value="10">10</option>
									</select>
								</div>
								<div class="form-group col-sm-2">
									<label>&nbsp;</label>
									<h5 class="form-control">๊ฐ</h5>
								</div>
							</div>
							
								<div class="form-group">
									<label>K-fair ์ค๋ช</label>
									<textarea name="fap_jobfair_divide_gb_list[0].fap_jobfair_divide_detail" class="form-control" maxlength="600" style="height: 40px;" placeholder="K-fair ์ค๋ช์ ์์ฑํด์ฃผ์ธ์."></textarea>
								</div>
							</div>
							
							<!-- J-fair -->
							<div id="j_body" style="display: none;">
							------------------------------------------------------------------------
								<div class="form-row">
									<label>J-fair ๊ธฐ๊ฐ</label>
								</div>
								<div class="form-row">
									<div class="form-group col-sm-6">									
										<input type="text" name="fap_jobfair_divide_gb_list[1].fap_jobfair_divide_st" id="fap_j_fair_st" class="date_format" maxlength="20" value="">
									</div>
									<div class="form-group col-sm-6">
										<label>&nbsp;</label>
										<input type="text" name="fap_jobfair_divide_gb_list[1].fap_jobfair_divide_et" id="fap_j_fair_et" class="date_format" maxlength="20" value="">
									</div>
								</div>
								
								<div class="form-row">
									<label>J-fair ์?์ฒญ๊ฐ๋ฅ๊ธฐ๊ฐ</label>
								</div>
								<div class="form-row">
									<div class="form-group col-sm-6">									
										<input type="text" name="fap_jobfair_divide_gb_list[1].fap_jobfair_divide_app_st" id="fap_j_fair_app_st" class="date_format" maxlength="20" value="">
									</div>
									<div class="form-group col-sm-6">
										<label>&nbsp;</label>
										<input type="text" name="fap_jobfair_divide_gb_list[1].fap_jobfair_divide_app_et" id="fap_j_fair_app_et" class="date_format" maxlength="20" value="">
									</div>
								</div>
								
								<div class="form-row">
									<label>J-fair ์ง์์ ์ง์ํ๊ฐ ์ต์ด์ฌ๋ถ</label>
								</div>
								<div class="form-row">
									<div class="form-group col-sm-1">
										<input checked="checked" type="radio" name="fap_j_fair_applicable_time_list[0].fap_jobfair_applicable_time_first" id="fap_j_fair_time_first" class="form-control" value="D0300">
									</div>
									<div class="form-group col-sm-3">
										<h5><code value="D0300"></code></h5>
									</div>
									<%-- <div class="form-group col-sm-1">
										<input type="radio" name="fap_j_fair_applicable_time_list[0].fap_jobfair_applicable_time_first" id="fap_j_fair_time_not_first" class="form-control" value="D0301">
									</div>
									<div class="form-group col-sm-3">
										<h5><code value="D0301"></code></h5>
									</div>	
									<div class="form-group col-sm-1">
										<input type="radio" name="fap_j_fair_applicable_time_list[0].fap_jobfair_applicable_time_first" id="fap_j_fair_time_missmatching" class="form-control" value="D0302">
									</div>
									<div class="form-group col-sm-3">
										<h5><code value="D0302"></code></h5>
									</div>	 --%>
								</div>
								
								<div class="form-row">
									<label>J-fair ์ง์์ ์ง์๊ฐ๋ฅ๊ธฐ๊ฐ</label>
								</div>
								<div class="form-row">
									<div class="form-group col-sm-3">									
										<input type="text" name="fap_j_fair_applicable_time_list[0].fap_jobfair_divide_user_date_st" id="fap_j_fair_user_date_st" class="date_format" value="" style="width: 100px;">
									</div>
									<div class="form-group col-sm-3">
										<label>&nbsp;</label>
										<input type="text" name="fap_j_fair_applicable_time_list[0].fap_jobfair_divide_user_time_st" id="fap_j_fair_user_time_st" class="time_format" value="" style="width: 80px;">&ensp;~
									</div>
									<div class="form-group col-sm-3">									
										<input type="text" name="fap_j_fair_applicable_time_list[0].fap_jobfair_divide_user_date_et" id="fap_j_fair_user_date_et" class="date_format" value="" style="width: 100px;">
									</div>
									<div class="form-group col-sm-3">
										<label>&nbsp;</label>
										<input type="text" name="fap_j_fair_applicable_time_list[0].fap_jobfair_divide_user_time_et" id="fap_j_fair_user_time_et" class="time_format" value="" style="width: 80px;">
									</div>
								</div>	
								
								<div class="form-row">
								<div class="form-group col-sm-2">
									<label style="width: 120px;">J-fair์ฑ์ฉ๋์</label>
									<input type="checkbox" name="fap_jobfair_j_fair_rc_list[0].fap_jobfair_divide_rc" id="j_fair_master_checkbox" class="form-control" value="A0101">
								</div>
								<div class="form-group col-sm-2">
									<label>&nbsp;</label>
									<h6><code value="A0101"></code></h6>
								</div>
								<div class="form-group col-sm-2">
									<label>&nbsp;</label>
									<input type="checkbox" name="fap_jobfair_j_fair_rc_list[1].fap_jobfair_divide_rc" id="j_fair_k_move_checkbox" class="form-control" value="A0106">
								</div>
								<div class="form-group col-sm-2">
									<label>&nbsp;</label>
									<h6><code value="A0106"></code></h6>
								</div>
								<div class="form-group col-sm-2">
									<label>&nbsp;</label>
									<input type="checkbox" name="fap_jobfair_j_fair_rc_list[2].fap_jobfair_divide_rc" id="j_fair_user_checkbox" class="form-control" value="A0100">
								</div>
								<div class="form-group col-sm-2">
									<label>&nbsp;</label>
									<h6><code value="A0100"></code></h6>
								</div>
								<div class="form-group col-sm-2">
									<label>&nbsp;</label>
									<input type="checkbox" name="fap_jobfair_j_fair_rc_list[3].fap_jobfair_divide_rc" id="j_fair_jap_checkbox" class="form-control" value="A0108">
								</div>
								<div class="form-group col-sm-2">
									<label>&nbsp;</label>
									<h6><code value="A0108"></code></h6>
								</div>
							</div>
							
							<div class="form-row">
							<div class="form-group col-sm-2">
									<label>๋ธ์ถ์ฌ๋ถ</label>
									<input type="radio" name="fap_jobfair_divide_gb_list[1].fap_jobfair_divide_gb_eps" id="fap_jobfair_j_fair_not_eps" class="form-control" value="C1300">
								</div>
								<div class="form-group col-sm-2">
									<label>&nbsp;</label>
									<h5><code value="C1300"></code></h5>
								</div>
								<div class="form-group col-sm-2">
									<label>&nbsp;</label>
									<input type="radio" name="fap_jobfair_divide_gb_list[1].fap_jobfair_divide_gb_eps" id="fap_jobfair_j_fair_eps" class="form-control" value="C1301">
								</div>
								<div class="form-group col-sm-2">
									<label>&nbsp;</label>
									<h5><code value="C1301"></code></h5>
								</div>		
							</div>
							
							<div class="form-row">
								<div class="form-group col-sm-6">
									<label>์ง๋ง๊ฐ๋ฅ ๊ฐ์</label>
									<select class="form-control" id="fap_jobfair_j_fair_app_num" name="fap_jobfair_divide_gb_list[1].fap_jobfair_divide_app_num">
										<option value="0">์?ํ</option>
										<option value="1">1</option>
										<option value="2">2</option>
										<option value="3">3</option>
										<option value="4">4</option>
										<option value="5">5</option>
										<option value="6">6</option>
										<option value="7">7</option>
										<option value="8">8</option>
										<option value="9">9</option>
										<option value="10">10</option>
									</select>
								</div>
								<div class="form-group col-sm-2">
									<label>&nbsp;</label>
									<h5 class="form-control">๊ฐ</h5>
								</div>
							</div>
							
								<div class="form-group">
									<label>J-fair ์ค๋ช</label>
									<textarea name="fap_jobfair_divide_gb_list[1].fap_jobfair_divide_detail" class="form-control" maxlength="600" style="height: 40px;" placeholder="J-fair ์ค๋ช์ ์์ฑํด์ฃผ์ธ์."></textarea>
								</div>
							</div>
							
							<!-- ํฌ์คํธ์์ฆ -->
							<div id="p_body" style="display: none;">
							------------------------------------------------------------------------
								<div class="form-row">
									<label>ํฌ์คํธ์์ฆ ๊ธฐ๊ฐ</label>
								</div>
								<div class="form-row">
									<div class="form-group col-sm-6">									
										<input type="text" name="fap_jobfair_divide_gb_list[2].fap_jobfair_divide_st" id="fap_post_season_st" class="date_format" maxlength="20" value="">
									</div>
									<div class="form-group col-sm-6">
										<label>&nbsp;</label>
										<input type="text" name="fap_jobfair_divide_gb_list[2].fap_jobfair_divide_et" id="fap_post_season_et" class="date_format" maxlength="20" value="">
									</div>
								</div>
								
								<div class="form-row">
									<label>ํฌ์คํธ์์ฆ ์?์ฒญ๊ฐ๋ฅ๊ธฐ๊ฐ</label>
								</div>
								<div class="form-row">
									<div class="form-group col-sm-6">									
										<input type="text" name="fap_jobfair_divide_gb_list[2].fap_jobfair_divide_app_st" id="fap_post_season_app_st" class="date_format" maxlength="20" value="">
									</div>
									<div class="form-group col-sm-6">
										<label>&nbsp;</label>
										<input type="text" name="fap_jobfair_divide_gb_list[2].fap_jobfair_divide_app_et" id="fap_post_season_app_et" class="date_format" maxlength="20" value="">
									</div>
								</div>
								
								<div class="form-row">
									<label>ํฌ์คํธ์์ฆ ์ง์์ ์ง์ํ๊ฐ ์ต์ด์ฌ๋ถ</label>
								</div>
								<div class="form-row">
									<div class="form-group col-sm-1">
										<input checked="checked" type="radio" name="fap_post_season_applicable_time_list[0].fap_jobfair_applicable_time_first" id="fap_post_season_time_first" class="form-control" value="D0300">
									</div>
									<div class="form-group col-sm-3">
										<h5><code value="D0300"></code></h5>
									</div>
									<%-- <div class="form-group col-sm-1">
										<input type="radio" name="fap_post_season_applicable_time_list[0].fap_jobfair_applicable_time_first" id="fap_post_season_time_not_first" class="form-control" value="D0301">
									</div>
									<div class="form-group col-sm-3">
										<h5><code value="D0301"></code></h5>
									</div>	
									<div class="form-group col-sm-1">
										<input type="radio" name="fap_post_season_applicable_time_list[0].fap_jobfair_applicable_time_first" id="fap_post_season_time_missmatching" class="form-control" value="D0302">
									</div>
									<div class="form-group col-sm-3">
										<h5><code value="D0302"></code></h5>
									</div>	 --%>
								</div>
								
								<div class="form-row">
									<label>ํฌ์คํธ์์ฆ ์ง์์ ์ง์๊ฐ๋ฅ๊ธฐ๊ฐ</label>
								</div>
								<div class="form-row">
									<div class="form-group col-sm-3">									
										<input type="text" name="fap_post_season_applicable_time_list[0].fap_jobfair_divide_user_date_st" id="fap_post_season_user_date_st" class="date_format" value="" style="width: 100px;">
									</div>
									<div class="form-group col-sm-3">
										<label>&nbsp;</label>
										<input type="text" name="fap_post_season_applicable_time_list[0].fap_jobfair_divide_user_time_st" id="fap_post_season_user_time_st" class="time_format" value="" style="width: 80px;">&ensp;~
									</div>
									<div class="form-group col-sm-3">									
										<input type="text" name="fap_post_season_applicable_time_list[0].fap_jobfair_divide_user_date_et" id="fap_post_season_user_date_et" class="date_format" value="" style="width: 100px;">
									</div>
									<div class="form-group col-sm-3">
										<label>&nbsp;</label>
										<input type="text" name="fap_post_season_applicable_time_list[0].fap_jobfair_divide_user_time_et" id="fap_post_season_user_time_et" class="time_format" value="" style="width: 80px;">
									</div>
								</div>	
								
								<div class="form-row">
								<div class="form-group col-sm-2">
									<label style="width: 200px;">ํฌ์คํธ์์ฆ ์ฑ์ฉ๋์</label>
									<input type="checkbox" name="fap_jobfair_post_season_rc_list[0].fap_jobfair_divide_rc" id="post_season_master_checkbox" class="form-control" value="A0101">
								</div>
								<div class="form-group col-sm-2">
									<label>&nbsp;</label>
									<h6><code value="A0101"></code></h6>
								</div>
								<div class="form-group col-sm-2">
									<label>&nbsp;</label>
									<input type="checkbox" name="fap_jobfair_post_season_rc_list[1].fap_jobfair_divide_rc" id="post_season_k_move_checkbox" class="form-control" value="A0106">
								</div>
								<div class="form-group col-sm-2">
									<label>&nbsp;</label>
									<h6><code value="A0106"></code></h6>
								</div>
								<div class="form-group col-sm-2">
									<label>&nbsp;</label>
									<input type="checkbox" name="fap_jobfair_post_season_rc_list[2].fap_jobfair_divide_rc" id="post_season_user_checkbox" class="form-control" value="A0100">
								</div>
								<div class="form-group col-sm-2">
									<label>&nbsp;</label>
									<h6><code value="A0100"></code></h6>
								</div>
								<div class="form-group col-sm-2">
									<label>&nbsp;</label>
									<input type="checkbox" name="fap_jobfair_post_season_rc_list[3].fap_jobfair_divide_rc" id="post_season_user_checkbox" class="form-control" value="A0108">
								</div>
								<div class="form-group col-sm-2">
									<label>&nbsp;</label>
									<h6><code value="A0108"></code></h6>
								</div>
							</div>
							
							<div class="form-row">
							<div class="form-group col-sm-2">
									<label>๋ธ์ถ์ฌ๋ถ</label>
									<input type="radio" name="fap_jobfair_divide_gb_list[2].fap_jobfair_divide_gb_eps" id="fap_jobfair_post_season_not_eps" class="form-control" value="C1300">
								</div>
								<div class="form-group col-sm-2">
									<label>&nbsp;</label>
									<h5><code value="C1300"></code></h5>
								</div>
								<div class="form-group col-sm-2">
									<label>&nbsp;</label>
									<input type="radio" name="fap_jobfair_divide_gb_list[2].fap_jobfair_divide_gb_eps" id="fap_jobfair_post_season_eps" class="form-control" value="C1301">
								</div>
								<div class="form-group col-sm-2">
									<label>&nbsp;</label>
									<h5><code value="C1301"></code></h5>
								</div>		
							</div>
							
							<div class="form-row">
								<div class="form-group col-sm-6">
									<label>์ง๋ง๊ฐ๋ฅ ๊ฐ์</label>
									<select class="form-control" id="fap_jobfair_post_season_app_num" name="fap_jobfair_divide_gb_list[2].fap_jobfair_divide_app_num">
										<option value="0">์?ํ</option>
										<option value="1">1</option>
										<option value="2">2</option>
										<option value="3">3</option>
										<option value="4">4</option>
										<option value="5">5</option>
										<option value="6">6</option>
										<option value="7">7</option>
										<option value="8">8</option>
										<option value="9">9</option>
										<option value="10">10</option>
									</select>
								</div>
								<div class="form-group col-sm-2">
									<label>&nbsp;</label>
									<h5 class="form-control">๊ฐ</h5>
								</div>
							</div>
							
								<div class="form-group">
									<label>ํฌ์คํธ์์ฆ ์ค๋ช</label>
									<textarea name="fap_jobfair_divide_gb_list[2].fap_jobfair_divide_detail" class="form-control" maxlength="600" style="height: 40px;" placeholder="ํฌ์คํธ์์ฆ ์ค๋ช์ ์์ฑํด์ฃผ์ธ์."></textarea>
								</div>
							</div>	
							
							<%-- <!-- ๋ฏธ์ค๋งค์นญ -->
							<div id="m_body" style="display: none;">
							------------------------------------------------------------------------
								<div class="form-row">
									<label>๋ฏธ์ค๋งค์นญ ๊ธฐ๊ฐ</label>
								</div>
								<div class="form-row">
									<div class="form-group col-sm-6">									
										<input type="text" name="fap_jobfair_divide_gb_list[3].fap_jobfair_divide_st" id="fap_missmatching_st" class="date_format" maxlength="20" value="">
									</div>
									<div class="form-group col-sm-6">
										<label>&nbsp;</label>
										<input type="text" name="fap_jobfair_divide_gb_list[3].fap_jobfair_divide_et" id="fap_missmatching_et" class="date_format" maxlength="20" value="">
									</div>
								</div>							
								<div class="form-row">
									<label>๋ฏธ์ค๋งค์นญ ์?์ฒญ๊ฐ๋ฅ๊ธฐ๊ฐ</label>
								</div>
								<div class="form-row">
									<div class="form-group col-sm-6">									
										<input type="text" name="fap_jobfair_divide_gb_list[3].fap_jobfair_divide_app_st" id="fap_missmatching_app_st" class="date_format" maxlength="20" value="">
									</div>
									<div class="form-group col-sm-6">
										<label>&nbsp;</label>
										<input type="text" name="fap_jobfair_divide_gb_list[3].fap_jobfair_divide_app_et" id="fap_missmatching_app_et" class="date_format" maxlength="20" value="">
									</div>
								</div>	
								
								<div class="form-row">
									<label>๋ฏธ์ค๋งค์นญ ์ง์์ ์ง์ํ๊ฐ ์ต์ด์ฌ๋ถ</label>
								</div>
								<div class="form-row">
									<div class="form-group col-sm-1">
										<input type="radio" name="fap_missmatching_applicable_time_list[0].fap_jobfair_applicable_time_first" id="fap_missmatching_time_first" class="form-control" value="D0300">
									</div>
									<div class="form-group col-sm-3">
										<h5><code value="D0300"></code></h5>
									</div>
									<div class="form-group col-sm-1">
										<input type="radio" name="fap_missmatching_applicable_time_list[0].fap_jobfair_applicable_time_first" id="fap_missmatching_time_not_first" class="form-control" value="D0301">
									</div>
									<div class="form-group col-sm-3">
										<h5><code value="D0301"></code></h5>
									</div>	
									<div class="form-group col-sm-1">
										<input type="radio" name="fap_missmatching_applicable_time_list[0].fap_jobfair_applicable_time_first" id="fap_missmatching_time_missmatching" class="form-control" value="D0302">
									</div>
									<div class="form-group col-sm-3">
										<h5><code value="D0302"></code></h5>
									</div>		
								</div>
								
								<div class="form-row">
									<label>๋ฏธ์ค๋งค์นญ ์ง์์ ์ง์๊ฐ๋ฅ๊ธฐ๊ฐ</label>
								</div>
								<div class="form-row">
									<div class="form-group col-sm-3">									
										<input type="text" name="fap_missmatching_applicable_time_list[0].fap_jobfair_divide_user_date_st" id="fap_missmatching_user_date_st" class="date_format" value="" style="width: 100px;">
									</div>
									<div class="form-group col-sm-3">
										<label>&nbsp;</label>
										<input type="text" name="fap_missmatching_applicable_time_list[0].fap_jobfair_divide_user_time_st" id="fap_missmatching_user_time_st" class="time_format" value="" style="width: 80px;">&ensp;~
									</div>
									<div class="form-group col-sm-3">									
										<input type="text" name="fap_missmatching_applicable_time_list[0].fap_jobfair_divide_user_date_et" id="fap_missmatching_user_date_et" class="date_format" value="" style="width: 100px;">
									</div>
									<div class="form-group col-sm-3">
										<label>&nbsp;</label>
										<input type="text" name="fap_missmatching_applicable_time_list[0].fap_jobfair_divide_user_time_et" id="fap_missmatching_user_time_et" class="time_format" value="" style="width: 80px;">
									</div>
								</div>	
														
								<div class="form-row">
								<div class="form-group col-sm-2">
									<label style="width: 200px;">๋ฏธ์ค๋งค์นญ์ฑ์ฉ๋์</label>
									<input type="checkbox" name="fap_jobfair_missmatching_rc_list[0].fap_jobfair_divide_rc" id="missmatching_master_checkbox" class="form-control" value="A0101">
								</div>
								<div class="form-group col-sm-2">
									<label>&nbsp;</label>
									<h6><code value="A0101"></code></h6>
								</div>
								<div class="form-group col-sm-2">
									<label>&nbsp;</label>
									<input type="checkbox" name="fap_jobfair_missmatching_rc_list[1].fap_jobfair_divide_rc" id="missmatching_k_move_checkbox" class="form-control" value="A0106">
								</div>
								<div class="form-group col-sm-2">
									<label>&nbsp;</label>
									<h6><code value="A0106"></code></h6>
								</div>
								<div class="form-group col-sm-2">
									<label>&nbsp;</label>
									<input type="checkbox" name="fap_jobfair_missmatching_rc_list[2].fap_jobfair_divide_rc" id="missmatching_user_checkbox" class="form-control" value="A0100">
								</div>
								<div class="form-group col-sm-2">
									<label>&nbsp;</label>
									<h6><code value="A0100"></code></h6>
								</div>
							</div>
							
							<div class="form-row">
							<div class="form-group col-sm-2">
									<label>๋ธ์ถ์ฌ๋ถ</label>
									<input type="radio" name="fap_jobfair_divide_gb_list[3].fap_jobfair_divide_gb_eps" id="fap_jobfair_missmatching_not_eps" class="form-control" value="C1300">
								</div>
								<div class="form-group col-sm-2">
									<label>&nbsp;</label>
									<h5><code value="C1300"></code></h5>
								</div>
								<div class="form-group col-sm-2">
									<label>&nbsp;</label>
									<input type="radio" name="fap_jobfair_divide_gb_list[3].fap_jobfair_divide_gb_eps" id="fap_jobfair_missmatching_eps" class="form-control" value="C1301">
								</div>
								<div class="form-group col-sm-2">
									<label>&nbsp;</label>
									<h5><code value="C1301"></code></h5>
								</div>		
							</div>
							
							<div class="form-row">
								<div class="form-group col-sm-6">
									<label>์ง๋ง๊ฐ๋ฅ ๊ฐ์</label>
									<select class="form-control" id="fap_jobfair_missmatching_app_num" name="fap_jobfair_divide_gb_list[3].fap_jobfair_divide_app_num">
										<option value="0">์?ํ</option>
										<option value="1">1</option>
										<option value="2">2</option>
										<option value="3">3</option>
										<option value="4">4</option>
										<option value="5">5</option>
										<option value="6">6</option>
										<option value="7">7</option>
										<option value="8">8</option>
										<option value="9">9</option>
										<option value="10">10</option>
									</select>
								</div>
								<div class="form-group col-sm-2">
									<label>&nbsp;</label>
									<h5 class="form-control">๊ฐ</h5>
								</div>
							</div>
							
								<div class="form-group">
									<label>๋ฏธ์ค๋งค์นญ ์ค๋ช</label>
									<textarea name="fap_jobfair_divide_gb_list[3].fap_jobfair_divide_detail" class="form-control" maxlength="600" style="height: 40px;" placeholder="๋ฏธ์ค๋งค์นญ ์ค๋ช์ ์์ฑํด์ฃผ์ธ์."></textarea>
								</div>
							</div>		 --%>
																
						</div>						
						<!-- modal-body ๋ -->		
								
						<div class="modal-footer">
							<button type="button" class="btn btn-secondary" data-dismiss="modal">์ทจ์</button>
							<button type="submit" class="btn btn-primary">๋ฑ๋กํ๊ธฐ</button>
						</div>
						
					</form>
				</div>
			</div>
		</div>	
		<!-- ์กํ์ด ๋ฑ๋ก Modal ๋ -->
	</div>
</body>
</html>
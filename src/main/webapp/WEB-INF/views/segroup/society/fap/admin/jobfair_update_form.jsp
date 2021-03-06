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
	<script type="text/javascript">
		$(function() {					
			$('#updateModal').on('hidden.bs.modal', function (e) {
			  $(this).find('form')[0].reset()
			});
			
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
			minMax("fap_post_season_st" , "fap_post_season_et");
			minMax("fap_k_fair_app_st" , "fap_k_fair_app_et");			
			minMax("fap_j_fair_app_st" , "fap_j_fair_app_et");
			minMax("fap_post_season_app_st" , "fap_post_season_app_et");
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
			
			//ํ์ผ ๋ณ๊ฒฝ
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
				$("#fap_jobfair_log_file").val('');
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
			if(fap_apply_max_multiple == 0 ){
				alert('์ง์๊ฐ๋ฅ ์ธ์ ๋ฐฐ์๋ ํ์ ์๋?ฅ ์ฌํญ์๋๋ค.');
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
					alert('K-fair  ์ฑ์ฉ๊ธฐ์ ์ฐธ๊ฐ์์์ผ์ ํ์ ์๋?ฅ ์ฌํญ์๋๋ค.');
					return false;
				}
				if(fap_k_fair_app_et == ''){
					alert('K-fair ์ฑ์ฉ๊ธฐ์ ์ฐธ๊ฐ์ข๋ฃ์ผ์ ํ์ ์๋?ฅ ์ฌํญ์๋๋ค.');
					return false;
				}
				if(!$("#fap_k_fair_time_first").is(":checked") & !$("#fap_k_fair_time_not_first").is(":checked") & !$("#fap_k_fair_time_missmatching").is(":checked")){
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
				if(!$("#k_fair_master_checkbox").is(":checked") & !$("#k_fair_k_move_checkbox").is(":checked") & !$("#k_fair_user_checkbox").is(":checked") & !$("#k_fair_jap_checkbox").is(":checked")){
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
					alert('J-fair ์ฑ์ฉ๊ธฐ์ ์ฐธ๊ฐ์ผ์ ํ์ ์๋?ฅ ์ฌํญ์๋๋ค.');
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
			
			//ํฌ์คํธ ์์ฆ
			if($("#post_season_checkbox").is(":checked")){
				if(fap_post_season_st == ''){
					alert('ํฌ์คํธ ์์ฆ ์์์ผ์ ํ์ ์๋?ฅ ์ฌํญ์๋๋ค.');
					return false;
				}
				if(fap_post_season_et == ''){
					alert('ํฌ์คํธ ์์ฆ ์ข๋ฃ์ผ์ ํ์ ์๋?ฅ ์ฌํญ์๋๋ค.');
					return false;
				}
				if(fap_post_season_app_st == ''){
					alert('ํฌ์คํธ ์์ฆ ์ฑ์ฉ๊ธฐ์ ์ฐธ๊ฐ์์์ผ์ ํ์ ์๋?ฅ ์ฌํญ์๋๋ค.');
					return false;
				}
				if(fap_post_season_app_et == ''){
					alert('ํฌ์คํธ ์์ฆ ์ฑ์ฉ๊ธฐ์ ์ฐธ๊ฐ์ข๋ฃ์ผ์ ํ์ ์๋?ฅ ์ฌํญ์๋๋ค.');
					return false;
				}
				if(!$("#fap_post_season_time_first").is(":checked") & !$("#fap_post_season_time_not_first").is(":checked") & !$("#fap_post_season_time_missmatching").is(":checked")){
					alert('ํฌ์คํธ ์์ฆ ์ต์ด์ง์ ํ์ฉ์ฌ๋ถ๋ ํ์ ์๋?ฅ ์ฌํญ์๋๋ค.');
					return false;
				}	
				if(fap_post_season_user_date_st == ''){
					alert('ํฌ์คํธ ์์ฆ ์ง์์ ์ง์์์์ผ์ ํ์ ์๋?ฅ ์ฌํญ์๋๋ค.');
					return false;
				}
				if(fap_post_season_user_date_et == ''){
					alert('ํฌ์คํธ ์์ฆ ์ง์์ ์ง์์ข๋ฃ์ผ์ ํ์ ์๋?ฅ ์ฌํญ์๋๋ค.');
					return false;
				}
				if(fap_post_season_user_time_st == ''){
					alert('ํฌ์คํธ ์์ฆ ์ง์์ ์ง์์์์๊ฐ์ ํ์ ์๋?ฅ ์ฌํญ์๋๋ค.');
					return false;
				}
				if(fap_post_season_user_time_et == ''){
					alert('ํฌ์คํธ ์์ฆ ์ง์์ ์ง์์ข๋ฃ์๊ฐ์ ํ์ ์๋?ฅ ์ฌํญ์๋๋ค.');
					return false;
				}
				if(!$("#post_season_master_checkbox").is(":checked") & !$("#post_season_k_move_checkbox").is(":checked") & !$("#post_season_user_checkbox").is(":checked")){
					alert('ํฌ์คํธ ์์ฆ ์ฑ์ฉ๋์์ ํ์ ์๋?ฅ ์ฌํญ์๋๋ค.');
					return false;
				}
				if(!$("#fap_jobfair_post_season_eps").is(":checked") & !$("#fap_jobfair_post_season_not_eps").is(":checked")){
					alert('ํฌ์คํธ ์์ฆ ๋ธ์ถ์ฌ๋ถ๋ ํ์ ์๋?ฅ ์ฌํญ์๋๋ค.');
					return false;
				}
				if($('#fap_jobfair_post_season_app_num').val() == 0){
					alert('ํฌ์คํธ ์์ฆ ์ง๋ง๊ฐ๋ฅ ๊ฐ์๋ ํ์ ์๋?ฅ ์ฌํญ์๋๋ค.');
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
			if($('#fap_comp_stock_0').val() == null || $('#fap_comp_stock_0').val() == ''){
				alert('์๋ณธ๊ธ์ ํ์ ์๋?ฅ ์ฌํญ์๋๋ค.');
				$('#fap_comp_stock_0').focus();
				return false;
			}
			if($('#fap_comp_3years_avg_sales_0').val() == null || $('#fap_comp_3years_avg_sales_0').val() == ''){
				alert('๋งค์ถ์ก์ ํ์ ์๋?ฅ ์ฌํญ์๋๋ค.');
				$('#fap_comp_3years_avg_sales_0').focus();
				return false;
			}
			if($('#fap_comp_employee_num_0').val() == null || $('#fap_comp_employee_num_0').val() == ''){
				alert('์ฌ์์๋ ํ์ ์๋?ฅ ์ฌํญ์๋๋ค.');
				$('#fap_comp_employee_num_0').focus();
				return false;
			}
			
			//์ง์์ ์ง์ํ๊ฐ ์ฌ๋ถ : ์ถ๊ฐ๋ ๋ฏธ์ค๋งค์นญ์์ ์ต์ด๋ก ๋ณ๊ฒฝ๋ถ๊ฐ
			if($('#fap_k_fair_applicable_time_ck').val() == 'D0301' && $('input[name="fap_k_fair_applicable_time_list[0].fap_jobfair_applicable_time_first"]:checked').val() == 'D0300'){
				alert('K-fair์ ์ต์ด๋ก ๋ณ๊ฒฝํ? ์ ์์ต๋๋ค.');
				return false;
			}			
			if($('#fap_k_fair_applicable_time_ck').val() == 'D0302' && $('input[name="fap_k_fair_applicable_time_list[0].fap_jobfair_applicable_time_first"]:checked').val() == 'D0300'){
				alert('K-fair์ ์ต์ด๋ก ๋ณ๊ฒฝํ? ์ ์์ต๋๋ค.');
				return false;
			}
			if($('#fap_j_fair_applicable_time_ck').val() == 'D0301' && $('input[name="fap_j_fair_applicable_time_list[0].fap_jobfair_applicable_time_first"]:checked').val() == 'D0300'){
				alert('J-fair์ ์ต์ด๋ก ๋ณ๊ฒฝํ? ์ ์์ต๋๋ค.');
				return false;
			}			
			if($('#fap_j_fair_applicable_time_ck').val() == 'D0302' && $('input[name="fap_j_fair_applicable_time_list[0].fap_jobfair_applicable_time_first"]:checked').val() == 'D0300'){
				alert('J-fair์ ์ต์ด๋ก ๋ณ๊ฒฝํ? ์ ์์ต๋๋ค.');
				return false;
			}
			if($('#fap_post_season_applicable_time_ck').val() == 'D0301' && $('input[name="fap_post_season_applicable_time_list[0].fap_jobfair_applicable_time_first"]:checked').val() == 'D0300'){
				alert('ํฌ์คํธ์์ฆ์ ์ต์ด๋ก ๋ณ๊ฒฝํ? ์ ์์ต๋๋ค.');
				return false;
			}			
			if($('#fap_post_season_applicable_time_ck').val() == 'D0302' && $('input[name="fap_post_season_applicable_time_list[0].fap_jobfair_applicable_time_first"]:checked').val() == 'D0300'){
				alert('ํฌ์คํธ์์ฆ์ ์ต์ด๋ก ๋ณ๊ฒฝํ? ์ ์์ต๋๋ค.');
				return false;
			}
			
			//์ง์์ ์ง์๊ฐ๋ฅ ๊ธฐ๊ฐ :  ์ต์ด๋ณด๋ค ์ด์?์ ๊ธฐ๊ฐ์ผ๋ก ๋ณ๊ฒฝ๋ถ๊ฐ
			if($('#fap_k_fair_applicable_time_ck').val() == 'D0300' && $('input[name="fap_k_fair_applicable_time_list[0].fap_jobfair_applicable_time_first"]:checked').val() != 'D0300' ){
				var k_fair_st_ck = $('#fap_k_fair_user_date_st_ck').val() + " " + $('#fap_k_fair_user_time_st_ck').val();		//๊ธฐ์กด
				var k_fair_et_ck = $('#fap_k_fair_user_date_et_ck').val() + " " +$('#fap_k_fair_user_time_et_ck').val();		//๊ธฐ์กด
				var k_fair_st = $('#fap_k_fair_user_date_st').val() + " " + $('#fap_k_fair_user_time_st').val();		//๋ณ๊ฒฝ
				var k_fair_et = $('#fap_k_fair_user_date_et').val() + " " + $('#fap_k_fair_user_time_et').val();		//๋ณ๊ฒฝ
								
				if(k_fair_st < k_fair_st_ck){
					alert('K-fair์ ์ต์ด ์์์ผ ์ด์?์ด ๋? ์ ์์ต๋๋ค.');
					return false;
				}
				if(k_fair_st < k_fair_et_ck){
					alert('K-fair์ ์ต์ด ์ข๋ฃ์ผ ์ด์?์ด ๋? ์ ์์ต๋๋ค.');
					return false;
				}
			}
			if($('#fap_j_fair_applicable_time_ck').val() == 'D0300' && $('input[name="fap_j_fair_applicable_time_list[0].fap_jobfair_applicable_time_first"]:checked').val() != 'D0300' ){
				var j_fair_st_ck = $('#fap_j_fair_user_date_st_ck').val() + " " + $('#fap_j_fair_user_time_st_ck').val();		//๊ธฐ์กด
				var j_fair_et_ck = $('#fap_j_fair_user_date_et_ck').val() + " " +$('#fap_j_fair_user_time_et_ck').val();		//๊ธฐ์กด
				var j_fair_st = $('#fap_j_fair_user_date_st').val() + " " + $('#fap_j_fair_user_time_st').val();		//๋ณ๊ฒฝ
				var j_fair_et = $('#fap_j_fair_user_date_et').val() + " " + $('#fap_j_fair_user_time_et').val();		//๋ณ๊ฒฝ
								
				if(j_fair_st < j_fair_st_ck){
					alert('J-fair์ ์ต์ด ์์์ผ ์ด์?์ด ๋? ์ ์์ต๋๋ค.');
					return false;
				}
				if(j_fair_st < j_fair_et_ck){
					alert('J-fair์ ์ต์ด ์ข๋ฃ์ผ ์ด์?์ด ๋? ์ ์์ต๋๋ค.');
					return false;
				}
			}
			if($('#fap_post_season_applicable_time_ck').val() == 'D0300' && $('input[name="fap_post_season_applicable_time_list[0].fap_jobfair_applicable_time_first"]:checked').val() != 'D0300' ){
				var post_season_st_ck = $('#fap_post_season_user_date_st_ck').val() + " " + $('#fap_post_season_user_time_st_ck').val();		//๊ธฐ์กด
				var post_season_et_ck = $('#fap_post_season_user_date_et_ck').val() + " " +$('#fap_post_season_user_time_et_ck').val();		//๊ธฐ์กด
				var post_season_st = $('#fap_post_season_user_date_st').val() + " " + $('#fap_post_season_user_time_st').val();		//๋ณ๊ฒฝ
				var post_season_et = $('#fap_post_season_user_date_et').val() + " " + $('#fap_post_season_user_time_et').val();		//๋ณ๊ฒฝ
								
				if(post_season_st < post_season_st_ck){
					alert('ํฌ์คํธ์์ฆ์ ์ต์ด ์์์ผ ์ด์?์ด ๋? ์ ์์ต๋๋ค.');
					return false;
				}
				if(post_season_st < post_season_et_ck){
					alert('ํฌ์คํธ์์ฆ์ ์ต์ด ์ข๋ฃ์ผ ์ด์?์ด ๋? ์ ์์ต๋๋ค.');
					return false;
				}
			}
			
			//์ง์์ ์ง์๊ฐ๋ฅ ๊ธฐ๊ฐ : ์ถ๊ฐ -> ๋ฏธ์ค๋งค์นญ
			if($('#fap_k_fair_applicable_time_ck').val() == 'D0301' && $('input[name="fap_k_fair_applicable_time_list[0].fap_jobfair_applicable_time_first"]:checked').val() == 'D0302' ){
				var k_fair_st_ck = $('#fap_k_fair_user_date_st_ck').val() + " " + $('#fap_k_fair_user_time_st_ck').val();		//๊ธฐ์กด
				var k_fair_et_ck = $('#fap_k_fair_user_date_et_ck').val() + " " +$('#fap_k_fair_user_time_et_ck').val();		//๊ธฐ์กด
				var k_fair_st = $('#fap_k_fair_user_date_st').val() + " " + $('#fap_k_fair_user_time_st').val();		//๋ณ๊ฒฝ
				var k_fair_et = $('#fap_k_fair_user_date_et').val() + " " + $('#fap_k_fair_user_time_et').val();		//๋ณ๊ฒฝ
								
				if(k_fair_st < k_fair_st_ck){
					alert('K-fair์ ์ถ๊ฐ ์์์ผ ์ด์?์ด ๋? ์ ์์ต๋๋ค.');
					return false;
				}
				if(k_fair_st < k_fair_et_ck){
					alert('K-fair์ ์ถ๊ฐ ์ข๋ฃ์ผ ์ด์?์ด ๋? ์ ์์ต๋๋ค.');
					return false;
				}
			}
			if($('#fap_j_fair_applicable_time_ck').val() == 'D0301' && $('input[name="fap_j_fair_applicable_time_list[0].fap_jobfair_applicable_time_first"]:checked').val() == 'D0302' ){
				var j_fair_st_ck = $('#fap_j_fair_user_date_st_ck').val() + " " + $('#fap_j_fair_user_time_st_ck').val();		//๊ธฐ์กด
				var j_fair_et_ck = $('#fap_j_fair_user_date_et_ck').val() + " " +$('#fap_j_fair_user_time_et_ck').val();		//๊ธฐ์กด
				var j_fair_st = $('#fap_j_fair_user_date_st').val() + " " + $('#fap_j_fair_user_time_st').val();		//๋ณ๊ฒฝ
				var j_fair_et = $('#fap_j_fair_user_date_et').val() + " " + $('#fap_j_fair_user_time_et').val();		//๋ณ๊ฒฝ
								
				if(j_fair_st < j_fair_st_ck){
					alert('J-fair์ ์ถ๊ฐ ์์์ผ ์ด์?์ด ๋? ์ ์์ต๋๋ค.');
					return false;
				}
				if(j_fair_st < j_fair_et_ck){
					alert('J-fair์ ์ถ๊ฐ ์ข๋ฃ์ผ ์ด์?์ด ๋? ์ ์์ต๋๋ค.');
					return false;
				}
			}
			if($('#fap_post_season_applicable_time_ck').val() == 'D0301' && $('input[name="fap_post_season_applicable_time_list[0].fap_jobfair_applicable_time_first"]:checked').val() == 'D0302' ){
				var post_season_st_ck = $('#fap_post_season_user_date_st_ck').val() + " " + $('#fap_post_season_user_time_st_ck').val();		//๊ธฐ์กด
				var post_season_et_ck = $('#fap_post_season_user_date_et_ck').val() + " " +$('#fap_post_season_user_time_et_ck').val();		//๊ธฐ์กด
				var post_season_st = $('#fap_post_season_user_date_st').val() + " " + $('#fap_post_season_user_time_st').val();		//๋ณ๊ฒฝ
				var post_season_et = $('#fap_post_season_user_date_et').val() + " " + $('#fap_post_season_user_time_et').val();		//๋ณ๊ฒฝ
								
				if(post_season_st < post_season_st_ck){
					alert('ํฌ์คํธ์์ฆ์ ์ถ๊ฐ ์์์ผ ์ด์?์ด ๋? ์ ์์ต๋๋ค.');
					return false;
				}
				if(post_season_st < post_season_et_ck){
					alert('ํฌ์คํธ์์ฆ์ ์ถ๊ฐ ์ข๋ฃ์ผ ์ด์?์ด ๋? ์ ์์ต๋๋ค.');
					return false;
				}
			}		
			
			//์ง์์ ์ง์๊ฐ๋ฅ ๊ธฐ๊ฐ : ๋ฏธ์ค๋งค์นญ -> ์ถ๊ฐ
			if($('#fap_k_fair_applicable_time_ck').val() == 'D0302' && $('input[name="fap_k_fair_applicable_time_list[0].fap_jobfair_applicable_time_first"]:checked').val() == 'D0301' ){
				var k_fair_st_ck = $('#fap_k_fair_user_date_st_ck').val() + " " + $('#fap_k_fair_user_time_st_ck').val();		//๊ธฐ์กด
				var k_fair_et_ck = $('#fap_k_fair_user_date_et_ck').val() + " " +$('#fap_k_fair_user_time_et_ck').val();		//๊ธฐ์กด
				var k_fair_st = $('#fap_k_fair_user_date_st').val() + " " + $('#fap_k_fair_user_time_st').val();		//๋ณ๊ฒฝ
				var k_fair_et = $('#fap_k_fair_user_date_et').val() + " " + $('#fap_k_fair_user_time_et').val();		//๋ณ๊ฒฝ
								
				if(k_fair_st < k_fair_st_ck){
					alert('K-fair์ ๋ฏธ์ค๋งค์นญ ์์์ผ ์ด์?์ด ๋? ์ ์์ต๋๋ค.');
					return false;
				}
				if(k_fair_st < k_fair_et_ck){
					alert('K-fair์ ๋ฏธ์ค๋งค์นญ ์ข๋ฃ์ผ ์ด์?์ด ๋? ์ ์์ต๋๋ค.');
					return false;
				}
			}
			if($('#fap_j_fair_applicable_time_ck').val() == 'D0302' && $('input[name="fap_j_fair_applicable_time_list[0].fap_jobfair_applicable_time_first"]:checked').val() == 'D0301' ){
				var j_fair_st_ck = $('#fap_j_fair_user_date_st_ck').val() + " " + $('#fap_j_fair_user_time_st_ck').val();		//๊ธฐ์กด
				var j_fair_et_ck = $('#fap_j_fair_user_date_et_ck').val() + " " +$('#fap_j_fair_user_time_et_ck').val();		//๊ธฐ์กด
				var j_fair_st = $('#fap_j_fair_user_date_st').val() + " " + $('#fap_j_fair_user_time_st').val();		//๋ณ๊ฒฝ
				var j_fair_et = $('#fap_j_fair_user_date_et').val() + " " + $('#fap_j_fair_user_time_et').val();		//๋ณ๊ฒฝ
								
				if(j_fair_st < j_fair_st_ck){
					alert('J-fair์ ๋ฏธ์ค๋งค์นญ ์์์ผ ์ด์?์ด ๋? ์ ์์ต๋๋ค.');
					return false;
				}
				if(j_fair_st < j_fair_et_ck){
					alert('J-fair์ ๋ฏธ์ค๋งค์นญ ์ข๋ฃ์ผ ์ด์?์ด ๋? ์ ์์ต๋๋ค.');
					return false;
				}
			}
			if($('#fap_post_season_applicable_time_ck').val() == 'D0302' && $('input[name="fap_post_season_applicable_time_list[0].fap_jobfair_applicable_time_first"]:checked').val() == 'D0301' ){
				var post_season_st_ck = $('#fap_post_season_user_date_st_ck').val() + " " + $('#fap_post_season_user_time_st_ck').val();		//๊ธฐ์กด
				var post_season_et_ck = $('#fap_post_season_user_date_et_ck').val() + " " +$('#fap_post_season_user_time_et_ck').val();		//๊ธฐ์กด
				var post_season_st = $('#fap_post_season_user_date_st').val() + " " + $('#fap_post_season_user_time_st').val();		//๋ณ๊ฒฝ
				var post_season_et = $('#fap_post_season_user_date_et').val() + " " + $('#fap_post_season_user_time_et').val();		//๋ณ๊ฒฝ
								
				if(post_season_st < post_season_st_ck){
					alert('ํฌ์คํธ์์ฆ์ ๋ฏธ์ค๋งค์นญ ์์์ผ ์ด์?์ด ๋? ์ ์์ต๋๋ค.');
					return false;
				}
				if(post_season_st < post_season_et_ck){
					alert('ํฌ์คํธ์์ฆ์ ๋ฏธ์ค๋งค์นญ ์ข๋ฃ์ผ ์ด์?์ด ๋? ์ ์์ต๋๋ค.');
					return false;
				}
			}			
		}				
	</script>
	
	<script type="text/javascript">	
		
	var myApp = angular.module('myapp', []);						
		
		myApp.controller('updateController', ['$scope','$compile',	function($scope, $compile) {
			
			var fapJobfairJson = '${fapJobfairJson}';
			fapJobfairJson = fapJobfairJson.replace(/\\/ig,"\\\\");
			fapJobfairJson = fapJobfairJson.replace(/(?:\r\n|\r|\n)/g, '\\r\\n');
			var parsed = JSON.parse(fapJobfairJson);			
			$scope.jobfairInfo = parsed;
			console.log(parsed);
			
			$("#k_body").hide();			
			$("#j_body").hide();
			$("#p_body").hide();
			
			//์ง์๊ฐ๋ฅ ์ธ์ ๋ฐฐ์
			$(".modal-body #fap_apply_max_multiple").val(parsed.fap_apply_max_multiple);		//์กํ์ด ์ง์๊ฐ๋ฅ์ธ์
			
			//ํ์ง์ธ์ ์?ํ ๋ฐฐ์
			$(".modal-body #fap_limit_interview_count").val(parsed.fapjobfairLimitInterviewMap.fap_limit_interview_count);
			
			//๊ฐ์ต์ง
			for(var i=0; i<parsed.fapJobfairLoList.length; i++){
				//์์ธ
				if(parsed.fapJobfairLoList[i].fap_jobfair_lo == 'C0000'){
					$scope.lo1_check = parsed.fapJobfairLoList[i].fap_jobfair_lo;	//๊ฐ์ต์ง
					$(".modal-body #fap_jobfair_lo_seq_Seoul").val(parsed.fapJobfairLoList[i].fap_jobfair_lo_seq);		//๊ฐ์ต์ง ์ํ์ค					
				}
				//๋์ฟ
				if(parsed.fapJobfairLoList[i].fap_jobfair_lo == 'C0001'){
					$scope.lo2_check = parsed.fapJobfairLoList[i].fap_jobfair_lo;	//๊ฐ์ต์ง
					$(".modal-body #fap_jobfair_lo_seq_Tokyo").val(parsed.fapJobfairLoList[i].fap_jobfair_lo_seq);		//๊ฐ์ต์ง ์ํ์ค
				}
			}	
			
			//์ธ๋ถ๊ตฌ๋ถ
			for(var i=0; i<parsed.fapJobfairDivideList.length; i++){
				//K_fair
				if(parsed.fapJobfairDivideList[i].fap_jobfair_divide_gb == 'C0100'){
					$scope.k_fair_check = parsed.fapJobfairDivideList[i].fap_jobfair_divide_gb;		//K_fair ์ฒดํฌ
					$scope.k_fair_eps = parsed.fapJobfairDivideList[i].fap_jobfair_divide_gb_eps;		//K_fair ๋ธ์ถ ์ฌ๋ถ
					$(".modal-body #fap_jobfair_divide_k_fair_seq").val(parsed.fapJobfairDivideList[i].fap_jobfair_divide_seq);	//K_fair ์ํ์ค
					$("#k_body").show();		//k_body ๋ธ์ถ
					$(".modal-body #fap_k_fair_st").val(parsed.fapJobfairDivideList[i].fap_jobfair_divide_st);	//K-fair ์์์ผ
					$(".modal-body #fap_k_fair_et").val(parsed.fapJobfairDivideList[i].fap_jobfair_divide_et);	//K-fair ์ข๋ฃ์ผ
					$(".modal-body #fap_k_fair_app_st").val(parsed.fapJobfairDivideList[i].fap_jobfair_divide_app_st);	//K-fair ์?์ฒญ ์์์ผ
					$(".modal-body #fap_k_fair_app_et").val(parsed.fapJobfairDivideList[i].fap_jobfair_divide_app_et);	//K-fair ์?์ฒญ ์ข๋ฃ์ผ
					$(".modal-body #fap_jobfair_k_fair_app_num").val(parsed.fapJobfairDivideList[i].fap_jobfair_divide_app_num);	//K-fair ์ง๋ง๊ฐ๋ฅ ๊ฐ์					
					$(".modal-body #fap_jobfair_k_fair_detail").val(parsed.fapJobfairDivideList[i].fap_jobfair_divide_detail);		//K-fair ์ค๋ช					
					//K_fair ์ง์๊ฐ๋ฅ๊ธฐ๊ฐ
					 for(var j = 0; j < parsed.fapJobfairDivideList[i].fapJobfairApplicableTimeList.length; j++){
						$scope.k_fair_time_first = parsed.fapJobfairDivideList[i].fapJobfairApplicableTimeList[j].fap_jobfair_applicable_time_first;		//K_fair ์ง์ ์ต์ด์ฌ๋ถ
						$(".modal-body #fap_k_fair_applicable_time_ck").val(parsed.fapJobfairDivideList[i].fapJobfairApplicableTimeList[j].fap_jobfair_applicable_time_first);		//K_fair ์ง์ ์ต์ด์ฌ๋ถ ํผ์ฒดํฌ ์ฉ
						$(".modal-body #fap_k_fair_applicable_time_seq").val(parsed.fapJobfairDivideList[i].fapJobfairApplicableTimeList[j].fap_jobfair_applicable_time_seq);	//K-fair ์ง์๊ฐ๋ฅ๊ธฐ๊ฐ ์ํ์ค							
						
						if(parsed.fapJobfairDivideList[i].fapJobfairApplicableTimeList[j].fap_jobfair_applicable_time_st != null){
							var st = parsed.fapJobfairDivideList[i].fapJobfairApplicableTimeList[j].fap_jobfair_applicable_time_st.split(" ");
							var et = parsed.fapJobfairDivideList[i].fapJobfairApplicableTimeList[j].fap_jobfair_applicable_time_et.split(" ");
							var fap_jobfair_divide_k_fair_user_date_st = st[0];
							var fap_jobfair_divide_k_fair_user_time_st = st[1];
							var fap_jobfair_divide_k_fair_user_date_et = et[0];
							var fap_jobfair_divide_k_fair_user_time_et = et[1];
						}							
						$(".modal-body #fap_k_fair_user_date_st").val(fap_jobfair_divide_k_fair_user_date_st);			//K-fair ์ง์์์์ผ์
						$(".modal-body #fap_k_fair_user_time_st").val(fap_jobfair_divide_k_fair_user_time_st);			//K-fair ์ง์์์์๊ฐ
						$(".modal-body #fap_k_fair_user_date_et").val(fap_jobfair_divide_k_fair_user_date_et);		//K-fair ์ง์์ข๋ฃ์ผ์
						$(".modal-body #fap_k_fair_user_time_et").val(fap_jobfair_divide_k_fair_user_time_et);		//K-fair ์ง์์ข๋ฃ์๊ฐ
						$(".modal-body #fap_k_fair_user_date_st_ck").val(fap_jobfair_divide_k_fair_user_date_st);		//K-fair ์ง์์์์ผ์ ํผ์ฒดํฌ์ฉ
						$(".modal-body #fap_k_fair_user_time_st_ck").val(fap_jobfair_divide_k_fair_user_time_st);		//K-fair ์ง์์์์๊ฐ ํผ์ฒดํฌ์ฉ
						$(".modal-body #fap_k_fair_user_date_et_ck").val(fap_jobfair_divide_k_fair_user_date_et);		//K-fair ์ง์์ข๋ฃ์ผ์ ํผ์ฒดํฌ์ฉ
						$(".modal-body #fap_k_fair_user_time_et_ck").val(fap_jobfair_divide_k_fair_user_time_et);		//K-fair ์ง์์ข๋ฃ์๊ฐ ํผ์ฒดํฌ์ฉ
						
					}					
					//K-fair ์ฑ์ฉ๋์
					for(var k=0; k<parsed.fapJobfairDivideRcList.length; k++){
						if(parsed.fapJobfairDivideList[i].fap_jobfair_divide_seq == parsed.fapJobfairDivideRcList[k].fap_jobfair_divide_seq){
							if(parsed.fapJobfairDivideRcList[k].fap_jobfair_divide_rc == 'A0101'){
								$scope.k_fair_master = parsed.fapJobfairDivideRcList[k].fap_jobfair_divide_rc;		//K-fair ์ฑ์ฉ๋์ ๋ง์คํฐํ์
								$(".modal-body #fap_jobfair_k_fair_master_seq").val(parsed.fapJobfairDivideRcList[k].fap_jobfair_divide_rc_seq);		//K-fair ์ฑ์ฉ๋์ ๋ง์คํฐํ์ ์ํ์ค
							}
							if(parsed.fapJobfairDivideRcList[k].fap_jobfair_divide_rc == 'A0106'){
								$scope.k_fair_k_move = parsed.fapJobfairDivideRcList[k].fap_jobfair_divide_rc;		//K-fair ์ฑ์ฉ๋์ K-Moveํ์
								$(".modal-body #fap_jobfair_k_fair_k_move_seq").val(parsed.fapJobfairDivideRcList[k].fap_jobfair_divide_rc_seq);		//K-fair ์ฑ์ฉ๋์ ๋ง์คํฐํ์ ์ํ์ค
							}
							if(parsed.fapJobfairDivideRcList[k].fap_jobfair_divide_rc == 'A0100'){
								$scope.k_fair_user = parsed.fapJobfairDivideRcList[k].fap_jobfair_divide_rc;		//K-fair ์ฑ์ฉ๋์ ์ผ๋ฐํ์
								$(".modal-body #fap_jobfair_k_fair_user_seq").val(parsed.fapJobfairDivideRcList[k].fap_jobfair_divide_rc_seq);		//K-fair ์ฑ์ฉ๋์ ์ผ๋ฐํ์ ์ํ์ค
							}							
							if(parsed.fapJobfairDivideRcList[k].fap_jobfair_divide_rc == 'A0108'){
								$scope.k_fair_jap = parsed.fapJobfairDivideRcList[k].fap_jobfair_divide_rc;		//K-fair ์ฑ์ฉ๋์ ์ผ๋ณธ์ทจ์ํ๊ต
								$(".modal-body #fap_jobfair_k_fair_jap_seq").val(parsed.fapJobfairDivideRcList[k].fap_jobfair_divide_rc_seq);		//K-fair ์ฑ์ฉ๋์ ์ผ๋ณธ์ทจ์ํ๊ต ์ํ์ค
							}
						}
					}					
				}
				
				//J_fair
				if(parsed.fapJobfairDivideList[i].fap_jobfair_divide_gb == 'C0101'){
					$scope.j_fair_check = parsed.fapJobfairDivideList[i].fap_jobfair_divide_gb;		//J_fair ์ฒดํฌ
					$scope.j_fair_eps = parsed.fapJobfairDivideList[i].fap_jobfair_divide_gb_eps;	//J_fair ๋ธ์ถ ์ฌ๋ถ
					$(".modal-body #fap_jobfair_divide_j_fair_seq").val(parsed.fapJobfairDivideList[i].fap_jobfair_divide_seq);	//J_fair ์ํ์ค
					$("#j_body").show();		//j_body ๋ธ์ถ
					$(".modal-body #fap_j_fair_st").val(parsed.fapJobfairDivideList[i].fap_jobfair_divide_st);		//J-fair ์์์ผ
					$(".modal-body #fap_j_fair_et").val(parsed.fapJobfairDivideList[i].fap_jobfair_divide_et);	//J-fair ์ข๋ฃ์ผ
					$(".modal-body #fap_j_fair_app_st").val(parsed.fapJobfairDivideList[i].fap_jobfair_divide_app_st);		//J-fair ์?์ฒญ ์์์ผ
					$(".modal-body #fap_j_fair_app_et").val(parsed.fapJobfairDivideList[i].fap_jobfair_divide_app_et);		//J-fair ์?์ฒญ ์ข๋ฃ์ผ
					$(".modal-body #fap_jobfair_j_fair_app_num").val(parsed.fapJobfairDivideList[i].fap_jobfair_divide_app_num);		//J-fair ์ง๋ง๊ฐ๋ฅ ๊ฐ์					
					$(".modal-body #fap_jobfair_j_fair_detail").val(parsed.fapJobfairDivideList[i].fap_jobfair_divide_detail);		//J-fair ์ค๋ช
					//J_fair ์ง์๊ฐ๋ฅ๊ธฐ๊ฐ
					for(var j = 0; j < parsed.fapJobfairDivideList[i].fapJobfairApplicableTimeList.length; j++){
						
						$scope.j_fair_time_first = parsed.fapJobfairDivideList[i].fapJobfairApplicableTimeList[j].fap_jobfair_applicable_time_first;		//J_fair ์ง์ ์ต์ด์ฌ๋ถ
						$(".modal-body #fap_j_fair_applicable_time_ck").val(parsed.fapJobfairDivideList[i].fapJobfairApplicableTimeList[j].fap_jobfair_applicable_time_first);		//J_fair ์ง์ ์ต์ด์ฌ๋ถ ํผ์ฒดํฌ ์ฉ
						$(".modal-body #fap_j_fair_applicable_time_seq").val(parsed.fapJobfairDivideList[i].fapJobfairApplicableTimeList[j].fap_jobfair_applicable_time_seq);	//J-fair ์ง์๊ฐ๋ฅ๊ธฐ๊ฐ ์ํ์ค							
						
						if(parsed.fapJobfairDivideList[i].fapJobfairApplicableTimeList[j].fap_jobfair_applicable_time_st != null){
							var st = parsed.fapJobfairDivideList[i].fapJobfairApplicableTimeList[j].fap_jobfair_applicable_time_st.split(" ");
							var et = parsed.fapJobfairDivideList[i].fapJobfairApplicableTimeList[j].fap_jobfair_applicable_time_et.split(" ");
							var fap_jobfair_divide_j_fair_user_date_st = st[0];
							var fap_jobfair_divide_j_fair_user_time_st = st[1];
							var fap_jobfair_divide_j_fair_user_date_et = et[0];
							var fap_jobfair_divide_j_fair_user_time_et = et[1];
						}							
						$(".modal-body #fap_j_fair_user_date_st").val(fap_jobfair_divide_j_fair_user_date_st);		//J-fair ์ง์์์์ผ์
						$(".modal-body #fap_j_fair_user_time_st").val(fap_jobfair_divide_j_fair_user_time_st);		//J-fair ์ง์์์์๊ฐ
						$(".modal-body #fap_j_fair_user_date_et").val(fap_jobfair_divide_j_fair_user_date_et);		//J-fair ์ง์์ข๋ฃ์ผ์
						$(".modal-body #fap_j_fair_user_time_et").val(fap_jobfair_divide_j_fair_user_time_et);		//J-fair ์ง์์ข๋ฃ์๊ฐ
						$(".modal-body #fap_j_fair_user_date_st_ck").val(fap_jobfair_divide_j_fair_user_date_st);		//J-fair ์ง์์์์ผ์ ํผ์ฒดํฌ์ฉ
						$(".modal-body #fap_j_fair_user_time_st_ck").val(fap_jobfair_divide_j_fair_user_time_st);		//J-fair ์ง์์์์๊ฐ ํผ์ฒดํฌ์ฉ
						$(".modal-body #fap_j_fair_user_date_et_ck").val(fap_jobfair_divide_j_fair_user_date_et);		//J-fair ์ง์์ข๋ฃ์ผ์ ํผ์ฒดํฌ์ฉ
						$(".modal-body #fap_j_fair_user_time_et_ck").val(fap_jobfair_divide_j_fair_user_time_et);		//J-fair ์ง์์ข๋ฃ์๊ฐ ํผ์ฒดํฌ์ฉ
						
					}	 				
					//J-fair ์ฑ์ฉ๋์
					for(var k=0; k<parsed.fapJobfairDivideRcList.length; k++){
						if(parsed.fapJobfairDivideList[i].fap_jobfair_divide_seq == parsed.fapJobfairDivideRcList[k].fap_jobfair_divide_seq){
							
							if(parsed.fapJobfairDivideRcList[k].fap_jobfair_divide_rc == 'A0101'){
								$scope.j_fair_master = parsed.fapJobfairDivideRcList[k].fap_jobfair_divide_rc;		//J-fair ์ฑ์ฉ๋์ ๋ง์คํฐํ์
								$(".modal-body #fap_jobfair_j_fair_master_seq").val(parsed.fapJobfairDivideRcList[k].fap_jobfair_divide_rc_seq);		//J-fair ์ฑ์ฉ๋์ ๋ง์คํฐํ์ ์ํ์ค
							}
							if(parsed.fapJobfairDivideRcList[k].fap_jobfair_divide_rc == 'A0106'){
								$scope.j_fair_k_move = parsed.fapJobfairDivideRcList[k].fap_jobfair_divide_rc;		//J-fair ์ฑ์ฉ๋์ K-Moveํ์
								$(".modal-body #fap_jobfair_j_fair_k_move_seq").val(parsed.fapJobfairDivideRcList[k].fap_jobfair_divide_rc_seq);		//J-fair ์ฑ์ฉ๋์ ๋ง์คํฐํ์ ์ํ์ค
							}
							if(parsed.fapJobfairDivideRcList[k].fap_jobfair_divide_rc == 'A0100'){
								$scope.j_fair_user = parsed.fapJobfairDivideRcList[k].fap_jobfair_divide_rc;		//J-fair ์ฑ์ฉ๋์ ์ผ๋ฐํ์
								$(".modal-body #fap_jobfair_j_fair_user_seq").val(parsed.fapJobfairDivideRcList[k].fap_jobfair_divide_rc_seq);		//J-fair ์ฑ์ฉ๋์ ์ผ๋ฐํ์ ์ํ์ค
							}							
							if(parsed.fapJobfairDivideRcList[k].fap_jobfair_divide_rc == 'A0108'){
								$scope.j_fair_jap = parsed.fapJobfairDivideRcList[k].fap_jobfair_divide_rc;		//J-fair ์ฑ์ฉ๋์ ์ผ๋ณธ์ทจ์ํ๊ต
								$(".modal-body #fap_jobfair_j_fair_jap_seq").val(parsed.fapJobfairDivideRcList[k].fap_jobfair_divide_rc_seq);		//J-fair ์ฑ์ฉ๋์ ์ผ๋ฐํ์ ์ํ์ค
							}
						}
					}
				}				
				
				//ํฌ์คํธ ์์ฆ
				if(parsed.fapJobfairDivideList[i].fap_jobfair_divide_gb == 'C0102'){
					$scope.post_season_check = parsed.fapJobfairDivideList[i].fap_jobfair_divide_gb;		//ํฌ์คํธ ์์ฆ ์ฒดํฌ
					$scope.post_season_eps = parsed.fapJobfairDivideList[i].fap_jobfair_divide_gb_eps;	//ํฌ์คํธ ์์ฆ ๋ธ์ถ ์ฌ๋ถ
					$(".modal-body #fap_jobfair_divide_post_season_seq").val(parsed.fapJobfairDivideList[i].fap_jobfair_divide_seq);		//ํฌ์คํธ ์์ฆ ์ํ์ค
					$("#p_body").show();
					$(".modal-body #fap_post_season_st").val(parsed.fapJobfairDivideList[i].fap_jobfair_divide_st);		//ํฌ์คํธ ์์ฆ ์์์ผ
					$(".modal-body #fap_post_season_et").val(parsed.fapJobfairDivideList[i].fap_jobfair_divide_et);	//ํฌ์คํธ ์์ฆ ์ข๋ฃ์ผ
					$(".modal-body #fap_post_season_app_st").val(parsed.fapJobfairDivideList[i].fap_jobfair_divide_app_st);		//ํฌ์คํธ ์์ฆ ์?์ฒญ ์์์ผ
					$(".modal-body #fap_post_season_app_et").val(parsed.fapJobfairDivideList[i].fap_jobfair_divide_app_et);		//ํฌ์คํธ ์์ฆ ์?์ฒญ ์ข๋ฃ์ผ
					$(".modal-body #fap_jobfair_post_season_app_num").val(parsed.fapJobfairDivideList[i].fap_jobfair_divide_app_num);		//ํฌ์คํธ ์์ฆ ์ง๋ง๊ฐ๋ฅ ๊ฐ์					
					$(".modal-body #fap_jobfair_post_season_detail").val(parsed.fapJobfairDivideList[i].fap_jobfair_divide_detail);		//ํฌ์คํธ ์์ฆ ์ค๋ช
					//ํฌ์คํธ ์์ฆ ์ง์๊ฐ๋ฅ๊ธฐ๊ฐ
					for(var j = 0; j < parsed.fapJobfairDivideList[i].fapJobfairApplicableTimeList.length; j++){
						$scope.post_season_time_first = parsed.fapJobfairDivideList[i].fapJobfairApplicableTimeList[j].fap_jobfair_applicable_time_first;		//ํฌ์คํธ ์์ฆ ์ง์ ์ต์ด์ฌ๋ถ
						$(".modal-body #fap_post_season_applicable_time_ck").val(parsed.fapJobfairDivideList[i].fapJobfairApplicableTimeList[j].fap_jobfair_applicable_time_first);		//ํฌ์คํธ ์์ฆ ์ง์ ์ต์ด์ฌ๋ถ ํผ์ฒดํฌ ์ฉ
						$(".modal-body #fap_post_season_applicable_time_seq").val(parsed.fapJobfairDivideList[i].fapJobfairApplicableTimeList[j].fap_jobfair_applicable_time_seq);	//ํฌ์คํธ ์์ฆ ์ง์๊ฐ๋ฅ๊ธฐ๊ฐ ์ํ์ค							
						
						if(parsed.fapJobfairDivideList[i].fapJobfairApplicableTimeList[j].fap_jobfair_applicable_time_st != null){
							var st = parsed.fapJobfairDivideList[i].fapJobfairApplicableTimeList[j].fap_jobfair_applicable_time_st.split(" ");
							var et = parsed.fapJobfairDivideList[i].fapJobfairApplicableTimeList[j].fap_jobfair_applicable_time_et.split(" ");
							var fap_jobfair_divide_post_season_user_date_st = st[0];
							var fap_jobfair_divide_post_season_user_time_st = st[1];
							var fap_jobfair_divide_post_season_user_date_et = et[0];
							var fap_jobfair_divide_post_season_user_time_et = et[1];
						}							
						$(".modal-body #fap_post_season_user_date_st").val(fap_jobfair_divide_post_season_user_date_st);		//ํฌ์คํธ ์์ฆ ์ง์์์์ผ์
						$(".modal-body #fap_post_season_user_time_st").val(fap_jobfair_divide_post_season_user_time_st);		//ํฌ์คํธ ์์ฆ ์ง์์์์๊ฐ
						$(".modal-body #fap_post_season_user_date_et").val(fap_jobfair_divide_post_season_user_date_et);		//ํฌ์คํธ ์์ฆ ์ง์์ข๋ฃ์ผ์
						$(".modal-body #fap_post_season_user_time_et").val(fap_jobfair_divide_post_season_user_time_et);		//ํฌ์คํธ ์์ฆ ์ง์์ข๋ฃ์๊ฐ
						$(".modal-body #fap_post_season_user_date_st_ck").val(fap_jobfair_divide_post_season_user_date_st);		//ํฌ์คํธ ์์ฆ์ง์์์์ผ์ ํผ์ฒดํฌ์ฉ
						$(".modal-body #fap_post_season_user_time_st_ck").val(fap_jobfair_divide_post_season_user_time_st);		//ํฌ์คํธ ์์ฆ ์ง์์์์๊ฐ ํผ์ฒดํฌ์ฉ
						$(".modal-body #fap_post_season_user_date_et_ck").val(fap_jobfair_divide_post_season_user_date_et);		//ํฌ์คํธ ์์ฆ ์ง์์ข๋ฃ์ผ์ ํผ์ฒดํฌ์ฉ
						$(".modal-body #fap_post_season_user_time_et_ck").val(fap_jobfair_divide_post_season_user_time_et);		//ํฌ์คํธ ์์ฆ ์ง์์ข๋ฃ์๊ฐ ํผ์ฒดํฌ์ฉ
					
					}				
					//ํฌ์คํธ ์์ฆ ์ฑ์ฉ๋์
					for(var k=0; k<parsed.fapJobfairDivideRcList.length; k++){
						if(parsed.fapJobfairDivideList[i].fap_jobfair_divide_seq == parsed.fapJobfairDivideRcList[k].fap_jobfair_divide_seq){
							if(parsed.fapJobfairDivideRcList[k].fap_jobfair_divide_rc == 'A0101'){
								$scope.post_season_master = parsed.fapJobfairDivideRcList[k].fap_jobfair_divide_rc;		//ํฌ์คํธ ์์ฆ ์ฑ์ฉ๋์ ๋ง์คํฐํ์
								$(".modal-body #fap_jobfair_post_season_master_seq").val(parsed.fapJobfairDivideRcList[k].fap_jobfair_divide_rc_seq);		//ํฌ์คํธ ์์ฆ ์ฑ์ฉ๋์ ๋ง์คํฐํ์ ์ํ์ค
							}
							if(parsed.fapJobfairDivideRcList[k].fap_jobfair_divide_rc == 'A0106'){
								$scope.post_season_k_move = parsed.fapJobfairDivideRcList[k].fap_jobfair_divide_rc;		//ํฌ์คํธ ์์ฆ ์ฑ์ฉ๋์ K-Moveํ์
								$(".modal-body #fap_jobfair_post_season_k_move_seq").val(parsed.fapJobfairDivideRcList[k].fap_jobfair_divide_rc_seq);		//ํฌ์คํธ ์์ฆ ์ฑ์ฉ๋์ ๋ง์คํฐํ์ ์ํ์ค
							}
							if(parsed.fapJobfairDivideRcList[k].fap_jobfair_divide_rc == 'A0100'){
								$scope.post_season_user = parsed.fapJobfairDivideRcList[k].fap_jobfair_divide_rc;		//ํฌ์คํธ ์์ฆ ์ฑ์ฉ๋์ ์ผ๋ฐํ์
								$(".modal-body #fap_jobfair_post_season_user_seq").val(parsed.fapJobfairDivideRcList[k].fap_jobfair_divide_rc_seq);		//ํฌ์คํธ ์์ฆ ์ฑ์ฉ๋์ ์ผ๋ฐํ์ ์ํ์ค
							}							
							if(parsed.fapJobfairDivideRcList[k].fap_jobfair_divide_rc == 'A0108'){
								$scope.post_season_jap = parsed.fapJobfairDivideRcList[k].fap_jobfair_divide_rc;		//ํฌ์คํธ ์์ฆ ์ฑ์ฉ๋์ ์ผ๋ณธ์ทจ์ํ๊ต
								$(".modal-body #fap_jobfair_post_season_jap_seq").val(parsed.fapJobfairDivideRcList[k].fap_jobfair_divide_rc_seq);		//ํฌ์คํธ ์์ฆ ์ฑ์ฉ๋์ ์ผ๋ณธ์ทจ์ํ๊ต ์ํ์ค
							}
						}
					}
				}
				
				/* //๋ฏธ์ค๋งค์นญ
				if(parsed.fapJobfairDivideList[i].fap_jobfair_divide_gb == 'C0103'){
					$scope.missmatching_check = parsed.fapJobfairDivideList[i].fap_jobfair_divide_gb;		//๋ฏธ์ค๋งค์นญ ์ฒดํฌ
					$scope.missmatching_eps = parsed.fapJobfairDivideList[i].fap_jobfair_divide_gb_eps;	//๋ฏธ์ค๋งค์นญ ๋ธ์ถ ์ฌ๋ถ
					$(".modal-body #fap_jobfair_divide_missmatching_seq").val(parsed.fapJobfairDivideList[i].fap_jobfair_divide_seq);		//๋ฏธ์ค๋งค์นญ ์ํ์ค
					$("#m_body").show();
					$(".modal-body #fap_missmatching_st").val(parsed.fapJobfairDivideList[i].fap_jobfair_divide_st);		//๋ฏธ์ค๋งค์นญ ์์์ผ
					$(".modal-body #fap_missmatching_et").val(parsed.fapJobfairDivideList[i].fap_jobfair_divide_et);		//๋ฏธ์ค๋งค์นญ ์ข๋ฃ์ผ
					$(".modal-body #fap_missmatching_app_st").val(parsed.fapJobfairDivideList[i].fap_jobfair_divide_app_st);		//๋ฏธ์ค๋งค์นญ ์?์ฒญ ์์์ผ
					$(".modal-body #fap_missmatching_app_et").val(parsed.fapJobfairDivideList[i].fap_jobfair_divide_app_et);		//๋ฏธ์ค๋งค์นญ ์?์ฒญ ์ข๋ฃ์ผ
					$(".modal-body #fap_jobfair_missmatching_app_num").val(parsed.fapJobfairDivideList[i].fap_jobfair_divide_app_num);		//๋ฏธ์ค๋งค์นญ ์ง๋ง๊ฐ๋ฅ ๊ฐ์					
					$(".modal-body #fap_jobfair_missmatching_detail").val(parsed.fapJobfairDivideList[i].fap_jobfair_divide_detail);		//๋ฏธ์ค๋งค์นญ ์ค๋ช
					//๋ฏธ์ค๋งค์นญ ์ง์๊ฐ๋ฅ๊ธฐ๊ฐ
					for(var j = 0; j<parsed.fapJobfairApplicableTimeList.length; j++){
						if(parsed.fapJobfairDivideList[i].fap_jobfair_divide_seq == parsed.fapJobfairApplicableTimeList[j].fap_jobfair_divide_seq){
							$scope.missmatching_time_first = parsed.fapJobfairApplicableTimeList[j].fap_jobfair_applicable_time_first;		//๋ฏธ์ค๋งค์นญ ์ง์ ์ต์ด์ฌ๋ถ
							$(".modal-body #fap_missmatching_applicable_time_seq").val(parsed.fapJobfairApplicableTimeList[j].fap_jobfair_applicable_time_seq);		//๋ฏธ์ค๋งค์นญ ์ง์๊ฐ๋ฅ๊ธฐ๊ฐ ์ํ์ค							
							
							if(parsed.fapJobfairApplicableTimeList[j].fap_jobfair_applicable_time_st != null){
								var st = parsed.fapJobfairApplicableTimeList[j].fap_jobfair_applicable_time_st.split(" ");
								var et = parsed.fapJobfairApplicableTimeList[j].fap_jobfair_applicable_time_et.split(" ");
								var fap_jobfair_divide_user_date_st = st[0];
								var fap_jobfair_divide_user_time_st = st[1];
								var fap_jobfair_divide_user_date_et = et[0];
								var fap_jobfair_divide_user_time_et = et[1];
							}							
							$(".modal-body #fap_missmatching_user_date_st").val(fap_jobfair_divide_user_date_st);		//๋ฏธ์ค๋งค์นญ ์ง์์์์ผ์
							$(".modal-body #fap_missmatching_user_time_st").val(fap_jobfair_divide_user_time_st);		//๋ฏธ์ค๋งค์นญ ์ง์์์์๊ฐ
							$(".modal-body #fap_missmatching_user_date_et").val(fap_jobfair_divide_user_date_et);		//๋ฏธ์ค๋งค์นญ ์ง์์ข๋ฃ์ผ์
							$(".modal-body #fap_missmatching_user_time_et").val(fap_jobfair_divide_user_time_et);		//๋ฏธ์ค๋งค์นญ ์ง์์ข๋ฃ์๊ฐ
						}
					}					
					//๋ฏธ์ค๋งค์นญ ์ฑ์ฉ๋์
					for(var k=0; k<parsed.fapJobfairDivideRcList.length; k++){
						if(parsed.fapJobfairDivideList[i].fap_jobfair_divide_seq == parsed.fapJobfairDivideRcList[k].fap_jobfair_divide_seq){
							if(parsed.fapJobfairDivideRcList[k].fap_jobfair_divide_rc == 'A0101'){
								$scope.missmatching_master = parsed.fapJobfairDivideRcList[k].fap_jobfair_divide_rc;		//๋ฏธ์ค๋งค์นญ ์ฑ์ฉ๋์ ๋ง์คํฐํ์
								$(".modal-body #fap_jobfair_missmatching_master_seq").val(parsed.fapJobfairDivideRcList[k].fap_jobfair_divide_rc_seq);		//๋ฏธ์ค๋งค์นญ ์ฑ์ฉ๋์ ๋ง์คํฐํ์ ์ํ์ค
							}
							if(parsed.fapJobfairDivideRcList[k].fap_jobfair_divide_rc == 'A0106'){
								$scope.missmatching_k_move = parsed.fapJobfairDivideRcList[k].fap_jobfair_divide_rc;		//๋ฏธ์ค๋งค์นญ ์ฑ์ฉ๋์ K-Moveํ์
								$(".modal-body #fap_jobfair_missmatching_k_move_seq").val(parsed.fapJobfairDivideRcList[k].fap_jobfair_divide_rc_seq);		//๋ฏธ์ค๋งค์นญ ์ฑ์ฉ๋์ ๋ง์คํฐํ์ ์ํ์ค
							}
							if(parsed.fapJobfairDivideRcList[k].fap_jobfair_divide_rc == 'A0100'){
								$scope.missmatching_user = parsed.fapJobfairDivideRcList[k].fap_jobfair_divide_rc;		//๋ฏธ์ค๋งค์นญ ์ฑ์ฉ๋์ ์ผ๋ฐํ์
								$(".modal-body #fap_jobfair_missmatching_user_seq").val(parsed.fapJobfairDivideRcList[k].fap_jobfair_divide_rc_seq);		//๋ฏธ์ค๋งค์นญ ์ฑ์ฉ๋์ ์ผ๋ฐํ์ ์ํ์ค
							}							
						}
					}
				} */					
				
			}			
			
			//ํ์ฌ๊ทธ๋ฃน ์ถ๊ฐ				
			$scope.add_comp_group = function(){
				var compGroupClass = $(".comp_group_class");
				var index = compGroupClass.length;
				var context = '';
				context +='<div class="comp_group_class">';
				context += '<div class="form-row">';			
				context += '<div class="form-group col-sm-2">';
				context += '	<input type="text" class="form-control" name="fap_comp_group_list[' + index + '].fap_comp_groupcode" id="fap_comp_groupcode_'+ index +'">';							
				context += '</div>';
				context += '<div class="form-group col-sm-4">';
				context += '	<input type="text" class="form-control currency" name="fap_comp_group_list[' + index + '].fap_comp_stock" id="fap_comp_stock_'+ index +'" ng-model="commaTest" blur-currency>';
				context += '</div>';
				context += '<div class="form-group col-sm-4">';
				context += '	<input type="text" class="form-control currency" name="fap_comp_group_list[' + index + '].fap_comp_3years_avg_sales" id="fap_comp_3years_avg_sales_'+ index +'" ng-model="commaTest" blur-currency>';
				context += '</div>';
				context += '<div class="form-group col-sm-2">';
				context += '	<input type="text" class="form-control currency" name="fap_comp_group_list[' + index + '].fap_comp_employee_num" id="fap_comp_employee_num_'+ index +'" ng-model="commaTest" blur-currency>';
				context += '</div>';
				context += '</div>';
				context += '</div>';
				
				$('.comp_group_class:last').after($compile(context)($scope));
			}
			
			//ํ์ฌ๊ทธ๋ฃน ์ญ์?
			$scope.delete_comp_group = function(){
				var index = $(".comp_group_class").length;
				if(index > 1){
					$('.comp_group_class:last').remove();			
				}
			}			
			
			$scope.add_app_time = function(){
				var context = '';
				
			};
			
			$("#updateModal").modal();
			
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
		}]);
		
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
	$(document).ready(function(){
		//์กํ์ด ์ธ๋ถ์?๋ณด๋ฅผ ์ฒดํฌํ ๊ฒฝ์ฐ๋ง ๋ธ์ถ, ์ฒดํฌํด์?ํ ๊ฒฝ์ฐ ๊ฐ ์ด๊ธฐํ	
	    $("#k_fair_checkbox").change(function(){
	        if($("#k_fair_checkbox").is(":checked")){
	            $("#k_body").show();
	        }else{
	            $("#k_body").hide();
	            $("#k_body").find('input:hidden').each(function(){
	            	$(this).val('0');
	            });
	            $("#k_body").find('input:text, textarea').each(function(){
	            	$(this).val(' ');
	            });	            
	            $("#k_body").find('input:radio, input:checkbox').each(function(){
	            	$(this).removeAttr('checked');
	            	$(this).removeAttr('selected');
	            });
	        }
	    });    
	    
	    $("#j_fair_checkbox").change(function(){
	        if($("#j_fair_checkbox").is(":checked")){
	            $("#j_body").show();
	        }else{
	            $("#j_body").hide();
	            $("#j_body").find('input:hidden').each(function(){
	            	$(this).val('0');
	            });
	            $("#j_body").find('input:text, textarea').each(function(){
	            	$(this).val(' ');
	            });	            
	            $("#j_body").find('input:radio, input:checkbox').each(function(){
	            	$(this).removeAttr('checked');
	            	$(this).removeAttr('selected');
	            });
	        }
	    });
	    
	    $("#post_season_checkbox").change(function(){
	        if($("#post_season_checkbox").is(":checked")){
	            $("#p_body").show();
	        }else{
	            $("#p_body").hide();
	            $("#p_body").find('input:hidden').each(function(){
	            	$(this).val('0');
	            });
	            $("#p_body").find('input:text, textarea').each(function(){
	            	$(this).val(' ');
	            });	            
	            $("#p_body").find('input:radio, input:checkbox').each(function(){
	            	$(this).removeAttr('checked');
	            	$(this).removeAttr('selected');
	            });
	        }
	    });
	    
	    /* $("#missmatching_checkbox").change(function(){
	        if($("#missmatching_checkbox").is(":checked")){
	            $("#m_body").show();
	        }else{
	            $("#m_body").hide();
	            $("#m_body").find('input:hidden').each(function(){
	            	$(this).val('0');
	            });
	            $("#m_body").find('input:text, textarea').each(function(){
	            	$(this).val(' ');
	            });	            
	            $("#m_body").find('input:radio, input:checkbox').each(function(){
	            	$(this).removeAttr('checked');
	            	$(this).removeAttr('selected');
	            });
	        }
	    }); */
	    
	});
	
	
	</script>
	
	<script type="text/javascript">
	//๋ชจ๋ฌ์ฐฝ ๋ซ์ ์ ์กํ์ด ๊ด๋ฆฌํ์ด์ง๋ก ์ด๋
	$(document).ready(function () {
		$('#cancelBtn1, #cancelBtn2').click(function () {
		 	location.href="/fap/admin/jobfair_management";
		 });	       
      });
	</script>
	
	<script type="text/javascript">
		
	</script>
	
</head>
<body ng-app="myapp" ng-controller="updateController">
<!-- ์กํ์ด ์์? Modal -->
	<div class="modal fade" id="updateModal" tabindex="-1" role="dialog" aria-labelledby="modal" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="modal">์กํ์ด ์์?</h5>
					<button type="button" id="cancelBtn1" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<form action="/fap/admin/jobfair_update" method="post" onsubmit="return form_Check();" enctype="multipart/form-data">
					<div class="modal-body">					
						<input type="hidden" name="fap_jobfair_seq" id="fap_jobfair_seq" value="{{jobfairInfo.fap_jobfair_seq}}">
						<!-- ์กํ์ด -->
						<div class="form-group">
							<label>์?๋ชฉ</label>
							<input type="text" name="fap_jobfair_title" id="fap_jobfair_title"  value="{{jobfairInfo.fap_jobfair_title}}" class="form-control" maxlength="100">
						</div>
						<div class="form-row">
							<label>๊ฐ์ต๊ธฐ๊ฐ</label>
						</div>
						<div class="form-row">
							<div class="form-group col-sm-6">								
								<input type="text" name="fap_jobfair_st" id="fap_jobfair_st" value="{{jobfairInfo.fap_jobfair_st}}" class="date_format" maxlength="20">
							</div>
							<div class="form-group col-sm-6">
								<label>&nbsp;</label>
								<input type="text" name="fap_jobfair_et" id="fap_jobfair_et" value="{{jobfairInfo.fap_jobfair_et}}" class="date_format" maxlength="20">
							</div>
						</div>
						
						<div class="form-row">
							<div class="form-group col-sm-2">
								<label>๊ฐ์ต์ง</label>
								<input type="hidden" name="fap_jobfair_lo_list[0].fap_jobfair_lo_seq" id="fap_jobfair_lo_seq_Seoul" value="0">
								<input type="checkbox" name="fap_jobfair_lo_list[0].fap_jobfair_lo" id="checkBox_Seoul" ng-init="lo1_check=lo1_check=='C0000'" ng-model="lo1_check" class="form-control" value="C0000">
							</div>
							<div class="form-group col-sm-2">
								<label>&nbsp;</label>
								<h5><code value="C0000"></code></h5>
							</div>
							<div class="form-group col-sm-2">
								<label>&nbsp;</label>
								<input type="hidden" name="fap_jobfair_lo_list[1].fap_jobfair_lo_seq" id="fap_jobfair_lo_seq_Tokyo" value="0">
								<input type="checkbox" name="fap_jobfair_lo_list[1].fap_jobfair_lo" id="checkBox_Tokyo" ng-init="lo2_check=lo2_check=='C0001'" ng-model="lo2_check" class="form-control" value="C0001">
							</div>
							<div class="form-group col-sm-2">
								<label>&nbsp;</label>
								<h5><code value="C0001"></code></h5>
							</div>
						</div>
						
						<div class="form-row">
							<div class="form-group col-sm-2">
								<label>์ธ๋ถ๊ตฌ๋ถ</label>
								<input type="hidden" name="fap_jobfair_divide_gb_list[0].fap_jobfair_divide_seq" id="fap_jobfair_divide_k_fair_seq" value="0">
								<input type="checkbox" name="fap_jobfair_divide_gb_list[0].fap_jobfair_divide_gb" id="k_fair_checkbox" ng-init="k_fair_check=k_fair_check=='C0100'" ng-model="k_fair_check" class="form-control" value="C0100">
							</div>
							<div class="form-group col-sm-2">
								<label>&nbsp;</label>
								<h6><code value="C0100"></code></h6>
							</div>														
							<div class="form-group col-sm-2">
								<label>&nbsp;</label>
								<input type="hidden" name="fap_jobfair_divide_gb_list[1].fap_jobfair_divide_seq" id="fap_jobfair_divide_j_fair_seq"  value="0">
								<input type="checkbox" name="fap_jobfair_divide_gb_list[1].fap_jobfair_divide_gb" id="j_fair_checkbox" ng-init="j_fair_check=j_fair_check=='C0101'" ng-model="j_fair_check" class="form-control" value="C0101">
							</div>
							<div class="form-group col-sm-2">
								<label>&nbsp;</label>
								<h6><code value="C0101"></code></h6>
							</div>
							<div class="form-group col-sm-2">
								<label>&nbsp;</label>
								<input type="hidden" name="fap_jobfair_divide_gb_list[2].fap_jobfair_divide_seq" id="fap_jobfair_divide_post_season_seq" value="0">
								<input type="checkbox" name="fap_jobfair_divide_gb_list[2].fap_jobfair_divide_gb" id="post_season_checkbox" ng-init="post_season_check=post_season_check=='C0102'" ng-model="post_season_check"  class="form-control" value="C0102">
							</div>
							<div class="form-group col-sm-2">
								<label>&nbsp;</label>
								<h6><code value="C0102"></code></h6>
							</div>
						</div>
						
						<div class="form-row">						
							<div class="form-group col-sm-2">
								<label>๋ธ์ถ์ฌ๋ถ</label>
								<input type="radio" name="fap_jobfair_eps" id="fap_jobfair_not_eps" ng-model="jobfairInfo.fap_jobfair_eps" class="form-control" value="C1200">
							</div>
							<div class="form-group col-sm-2">
								<label>&nbsp;</label>
								<h5><code value="C1200"></code></h5>
							</div>
							<div class="form-group col-sm-2">
								<label>&nbsp;</label>
								<input type="radio" name="fap_jobfair_eps" id="fap_jobfair_eps" ng-model="jobfairInfo.fap_jobfair_eps" class="form-control" value="C1201">
							</div>
							<div class="form-group col-sm-2">
								<label>&nbsp;</label>
								<h5><code value="C1201"></code></h5>
							</div>		
						</div>	
						
						<div class="form-row">
							<div class="form-group col-sm-6">
								<label>์ง์๊ฐ๋ฅ ์ธ์ ๋ฐฐ์</label>
								<select class="form-control" name="fap_apply_max_multiple" id="fap_apply_max_multiple"  value="{{jobfairInfo.fap_apply_max_multiple}}">
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
								<select class="form-control" name="fap_limit_interview_count" id="fap_limit_interview_count" value="{{jobfairInfo.fapjobfairLimitInterviewMap.fap_limit_interview_count}}">
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
								<input type="radio" name="fap_limit_interview_type" class="form-control" value="C5400" ng-model="jobfairInfo.fapjobfairLimitInterviewMap.fap_limit_interview_type">
							</div>
							<div class="form-group col-sm-2">
								<label>&nbsp;</label>
								<h5><code value="C5400"></code></h5>
							</div>
							<div class="form-group col-sm-2">
								<label>&nbsp;</label>
								<input type="radio" name="fap_limit_interview_type" class="form-control" value="C5401" ng-model="jobfairInfo.fapjobfairLimitInterviewMap.fap_limit_interview_type">
							</div>
							<div class="form-group col-sm-2">
								<label>&nbsp;</label>
								<h5><code value="C5401"></code></h5>
							</div>	
							<div class="form-group col-sm-2">
								<label>&nbsp;</label>
								<input type="radio" name="fap_limit_interview_type" class="form-control" value="C5402" ng-model="jobfairInfo.fapjobfairLimitInterviewMap.fap_limit_interview_type">
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
								</div>
								<div class="form-group col-sm-4">
									<label>์๋ณธ๊ธ(์)โ</label>
								</div>
								<div class="form-group col-sm-4">
									<label>๋งค์ถ์ก(์)โ</label>
								</div>
								<div class="form-group col-sm-2">
									<label>์ฌ์(๋ช)โ</label>
								</div>
							</div>
							<div ng-switch="!!jobfairInfo.fapCompGroupSetList.length">
								<div ng-switch-when="true">
									<div class="comp_group_class" ng-repeat="compGroup in jobfairInfo.fapCompGroupSetList">
										<div class="form-row">
											<div class="form-group col-sm-2">
												<input type="text" class="form-control" name="fap_comp_group_list[{{$index}}].fap_comp_groupcode" id="fap_comp_groupcode_{{$index}}" ng-model="compGroup.fap_comp_groupcode">						
											</div>
											<div class="form-group col-sm-4">
												<input type="text" class="form-control currency" name="fap_comp_group_list[{{$index}}].fap_comp_stock" id="fap_comp_stock_{{$index}}" ng-model="compGroup.fap_comp_stock" blur-currency>
											</div>
											<div class="form-group col-sm-4">
												<input type="text" class="form-control currency" name="fap_comp_group_list[{{$index}}].fap_comp_3years_avg_sales" id="fap_comp_3years_avg_sales_{{$index}}" ng-model="compGroup.fap_comp_3years_avg_sales" blur-currency>
											</div>
											<div class="form-group col-sm-2">
												<input type="text" class="form-control currency" name="fap_comp_group_list[{{$index}}].fap_comp_employee_num" id="fap_comp_employee_num_{{$index}}" ng-model="compGroup.fap_comp_employee_num" blur-currency>
											</div>
										</div>
									</div>
								</div>
								<div ng-switch-default>
									<div class="comp_group_class">
										<div class="form-row">
											<div class="form-group col-sm-2">
												<input type="text" class="form-control" name="fap_comp_group_list[0].fap_comp_groupcode" id="fap_comp_groupcode_0">						
											</div>
											<div class="form-group col-sm-4">
												<input type="text" class="form-control currency" name="fap_comp_group_list[0].fap_comp_stock" id="fap_comp_stock_0" ng-model="commaTest" blur-currency>
											</div>
											<div class="form-group col-sm-4">
												<input type="text" class="form-control currency" name="fap_comp_group_list[0].fap_comp_3years_avg_sales" id="fap_comp_3years_avg_sales_0" ng-model="commaTest" blur-currency>
											</div>
											<div class="form-group col-sm-2">
												<input type="text" class="form-control currency" name="fap_comp_group_list[0].fap_comp_employee_num" id="fap_comp_employee_num_0" ng-model="commaTest" blur-currency>
											</div>
										</div>
									</div>							
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
								<input type="hidden" id="fap_jobfair_log_origin" name="fap_jobfair_log_origin" value="{{jobfairInfo.fap_jobfair_log_origin}}">
								<input type="hidden" id="fap_jobfair_log_saved" name="fap_jobfair_log_saved" value="{{jobfairInfo.fap_jobfair_log_saved}}">
						</div>
						<div class="form-row" id="imgDiv">
							<div>								
								<img id="fap_jobfair_log" class="jobfair_log_img" alt="" ng-src="${path}{{jobfairInfo.fap_jobfair_log_saved}}" style="width: 440px;height: 180px;">							
							</div>						
						</div>			
						
						<br><br>
						
						<!-- K-fair -->
						<div id="k_body" style="display: none;">
						------------------------------------------------------------------------
							<div class="form-row">
								<label>K-fair ๊ธฐ๊ฐ</label>
							</div>
							<div class="form-row">
								<div class="form-group col-sm-6">									
									<input type="text" name="fap_jobfair_divide_gb_list[0].fap_jobfair_divide_st" id="fap_k_fair_st"  class="date_format" maxlength="20" value="">
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
							<input type="hidden" id="fap_k_fair_applicable_time_ck" value="">
							<input type="hidden" name="fap_k_fair_applicable_time_list[0].fap_jobfair_applicable_time_seq" id="fap_k_fair_applicable_time_seq" value="0">
							<div class="form-row">
								<div class="form-group col-sm-1">
									<input type="radio" name="fap_k_fair_applicable_time_list[0].fap_jobfair_applicable_time_first" id="fap_k_fair_time_first" ng-model="k_fair_time_first" class="form-control" value="D0300">
								</div>
								<div class="form-group col-sm-3">
									<h5><code value="D0300"></code></h5>
								</div>
							</div>
							
							<div class="form-row">
								<label>K-fair ์ง์์ ์ง์๊ฐ๋ฅ๊ธฐ๊ฐ</label>
							</div>
							<div class="form-row">
								<div class="form-group col-sm-3">
									<input type="hidden" id="fap_k_fair_user_date_st_ck" value="">									
									<input type="text" name="fap_k_fair_applicable_time_list[0].fap_jobfair_divide_user_date_st" id="fap_k_fair_user_date_st" class="date_format" value="" style="width: 100px;">
								</div>
								<div class="form-group col-sm-3">
									<label>&nbsp;</label>
									<input type="hidden" id="fap_k_fair_user_time_st_ck" value="">
									<input type="text" name="fap_k_fair_applicable_time_list[0].fap_jobfair_divide_user_time_st" id="fap_k_fair_user_time_st" class="time_format" value="" style="width: 80px;">&ensp;~
								</div>
								<div class="form-group col-sm-3">
									<input type="hidden" id="fap_k_fair_user_date_et_ck" value="">									
									<input type="text" name="fap_k_fair_applicable_time_list[0].fap_jobfair_divide_user_date_et" id="fap_k_fair_user_date_et" class="date_format" value="" style="width: 100px;">
								</div>
								<div class="form-group col-sm-3">
									<label>&nbsp;</label>
									<input type="hidden" id="fap_k_fair_user_time_et_ck" value="">		
									<input type="text" name="fap_k_fair_applicable_time_list[0].fap_jobfair_divide_user_time_et" id="fap_k_fair_user_time_et" class="time_format" value="" style="width: 80px;">
								</div>
							</div>
											
							<div class="form-row">
							<div class="form-group col-sm-2">
								<label style="width: 120px;">K-fair์ฑ์ฉ๋์</label>
								<input type="hidden" name="fap_jobfair_k_fair_rc_list[0].fap_jobfair_divide_rc_seq" id="fap_jobfair_k_fair_master_seq" value="0">
								<input type="checkbox" name="fap_jobfair_k_fair_rc_list[0].fap_jobfair_divide_rc" id="k_fair_master_checkbox" ng-init="k_fair_master=k_fair_master=='A0101'" ng-model="k_fair_master" class="form-control" value="A0101">
							</div>
							<div class="form-group col-sm-2">
								<label>&nbsp;</label>
								<h6><code value="A0101"></code></h6>
							</div>
							<div class="form-group col-sm-2">
								<label>&nbsp;</label>
								<input type="hidden" name="fap_jobfair_k_fair_rc_list[1].fap_jobfair_divide_rc_seq" id="fap_jobfair_k_fair_k_move_seq" value="0">
								<input type="checkbox" name="fap_jobfair_k_fair_rc_list[1].fap_jobfair_divide_rc" id="k_fair_k_move_checkbox" ng-init="k_fair_k_move=k_fair_k_move=='A0106'" ng-model="k_fair_k_move" class="form-control" value="A0106">
							</div>
							<div class="form-group col-sm-2">
								<label>&nbsp;</label>
								<h6><code value="A0106"></code></h6>
							</div>
							<div class="form-group col-sm-2">
								<label>&nbsp;</label>
								<input type="hidden" name="fap_jobfair_k_fair_rc_list[2].fap_jobfair_divide_rc_seq" id="fap_jobfair_k_fair_user_seq" value="0">
								<input type="checkbox" name="fap_jobfair_k_fair_rc_list[2].fap_jobfair_divide_rc" id="k_fair_user_checkbox" ng-init="k_fair_user=k_fair_user=='A0100'" ng-model="k_fair_user" class="form-control" value="A0100">
							</div>
							<div class="form-group col-sm-2">
								<label>&nbsp;</label>
								<h6><code value="A0100"></code></h6>
							</div>
							<div class="form-group col-sm-2">
								<label>&nbsp;</label>
								<input type="hidden" name="fap_jobfair_k_fair_rc_list[3].fap_jobfair_divide_rc_seq" id="fap_jobfair_k_fair_jap_seq" value="0">
								<input type="checkbox" name="fap_jobfair_k_fair_rc_list[3].fap_jobfair_divide_rc" id="k_fair_jap_checkbox" ng-init="k_fair_jap=k_fair_jap=='A0108'" ng-model="k_fair_jap" class="form-control" value="A0108">
							</div>
							<div class="form-group col-sm-2">
								<label>&nbsp;</label>
								<h6><code value="A0108"></code></h6>
							</div>
						</div>
						
						<div class="form-row">
							<div class="form-group col-sm-2">
								<label>๋ธ์ถ์ฌ๋ถ</label>
								<input type="radio" name="fap_jobfair_divide_gb_list[0].fap_jobfair_divide_gb_eps" id="fap_jobfair_k_fair_not_eps" ng-model="k_fair_eps" class="form-control" value="C1300">
							</div>
							<div class="form-group col-sm-2">
								<label>&nbsp;</label>
								<h5><code value="C1300"></code></h5>
							</div>
							<div class="form-group col-sm-2">
								<label>&nbsp;</label>
								<input type="radio" name="fap_jobfair_divide_gb_list[0].fap_jobfair_divide_gb_eps" id="fap_jobfair_k_fair_eps" ng-model="k_fair_eps" class="form-control" value="C1301">
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
								<textarea name="fap_jobfair_divide_gb_list[0].fap_jobfair_divide_detail" id="fap_jobfair_k_fair_detail" class="form-control" maxlength="600" style="height: 40px;" placeholder="K-fair ์ค๋ช์ ์์ฑํด์ฃผ์ธ์."></textarea>
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
							<input type="hidden" id="fap_j_fair_applicable_time_ck" value="">
							<input type="hidden" name="fap_j_fair_applicable_time_list[0].fap_jobfair_applicable_time_seq" id="fap_j_fair_applicable_time_seq" value="0">							
							<div class="form-row">
								<div class="form-group col-sm-1">
									<input type="radio" name="fap_j_fair_applicable_time_list[0].fap_jobfair_applicable_time_first" id="fap_j_fair_time_first" ng-model="j_fair_time_first" class="form-control" value="D0300">
								</div>
								<div class="form-group col-sm-3">
									<h5><code value="D0300"></code></h5>
								</div>
							</div>
							
							<div class="form-row">
								<label>J-fair ์ง์์ ์ง์๊ฐ๋ฅ๊ธฐ๊ฐ</label>
							</div>
							<div class="form-row">
								<div class="form-group col-sm-3">
									<input type="hidden" id="fap_j_fair_user_date_st_ck" value="">											
									<input type="text" name="fap_j_fair_applicable_time_list[0].fap_jobfair_divide_user_date_st" id="fap_j_fair_user_date_st" class="date_format" value="" style="width: 100px;">
								</div>
								<div class="form-group col-sm-3">
									<label>&nbsp;</label>
									<input type="hidden" id="fap_j_fair_user_time_st_ck" value="">
									<input type="text" name="fap_j_fair_applicable_time_list[0].fap_jobfair_divide_user_time_st" id="fap_j_fair_user_time_st" class="time_format" value="" style="width: 80px;">&ensp;~
								</div>
								<div class="form-group col-sm-3">
									<input type="hidden" id="fap_j_fair_user_date_et_ck" value="">										
									<input type="text" name="fap_j_fair_applicable_time_list[0].fap_jobfair_divide_user_date_et" id="fap_j_fair_user_date_et" class="date_format" value="" style="width: 100px;">
								</div>
								<div class="form-group col-sm-3">
									<label>&nbsp;</label>
									<input type="hidden" id="fap_j_fair_user_time_et_ck" value="">	
									<input type="text" name="fap_j_fair_applicable_time_list[0].fap_jobfair_divide_user_time_et" id="fap_j_fair_user_time_et" class="time_format" value="" style="width: 80px;">
								</div>
							</div>
							
							<div class="form-row">
							<div class="form-group col-sm-2">
								<label style="width: 120px;">J-fair์ฑ์ฉ๋์</label>
								<input type="hidden" name="fap_jobfair_j_fair_rc_list[0].fap_jobfair_divide_rc_seq" id="fap_jobfair_j_fair_master_seq" value="0">
								<input type="checkbox" name="fap_jobfair_j_fair_rc_list[0].fap_jobfair_divide_rc" id="j_fair_master_checkbox" ng-init="j_fair_master=j_fair_master=='A0101'" ng-model="j_fair_master" class="form-control" value="A0101">
							</div>
							<div class="form-group col-sm-2">
								<label>&nbsp;</label>
								<h6><code value="A0101"></code></h6>
							</div>
							<div class="form-group col-sm-2">
								<label>&nbsp;</label>
								<input type="hidden" name="fap_jobfair_j_fair_rc_list[1].fap_jobfair_divide_rc_seq" id="fap_jobfair_j_fair_k_move_seq" value="0">
								<input type="checkbox" name="fap_jobfair_j_fair_rc_list[1].fap_jobfair_divide_rc" id="j_fair_k_move_checkbox" ng-init="j_fair_k_move=j_fair_k_move=='A0106'" ng-model="j_fair_k_move" class="form-control" value="A0106">
							</div>
							<div class="form-group col-sm-2">
								<label>&nbsp;</label>
								<h6><code value="A0106"></code></h6>
							</div>
							<div class="form-group col-sm-2">
								<label>&nbsp;</label>
								<input type="hidden" name="fap_jobfair_j_fair_rc_list[2].fap_jobfair_divide_rc_seq" id="fap_jobfair_j_fair_user_seq" value="0">
								<input type="checkbox" name="fap_jobfair_j_fair_rc_list[2].fap_jobfair_divide_rc" id="j_fair_user_checkbox" ng-init="j_fair_user=j_fair_user=='A0100'" ng-model="j_fair_user" class="form-control" value="A0100">
							</div>
							<div class="form-group col-sm-2">
								<label>&nbsp;</label>
								<h6><code value="A0100"></code></h6>
							</div>
							<div class="form-group col-sm-2">
								<label>&nbsp;</label>
								<input type="hidden" name="fap_jobfair_j_fair_rc_list[3].fap_jobfair_divide_rc_seq" id="fap_jobfair_j_fair_jap_seq" value="0">
								<input type="checkbox" name="fap_jobfair_j_fair_rc_list[3].fap_jobfair_divide_rc" id="j_fair_jap_checkbox" ng-init="j_fair_jap=j_fair_jap=='A0108'" ng-model="j_fair_jap" class="form-control" value="A0108">
							</div>
							<div class="form-group col-sm-2">
								<label>&nbsp;</label>
								<h6><code value="A0108"></code></h6>
							</div>
						</div>
						
						<div class="form-row">
						<div class="form-group col-sm-2">
								<label>๋ธ์ถ์ฌ๋ถ</label>
								<input type="radio" name="fap_jobfair_divide_gb_list[1].fap_jobfair_divide_gb_eps" id="fap_jobfair_j_fair_not_eps" ng-model="j_fair_eps" class="form-control" value="C1300">
							</div>
							<div class="form-group col-sm-2">
								<label>&nbsp;</label>
								<h5><code value="C1300"></code></h5>
							</div>
							<div class="form-group col-sm-2">
								<label>&nbsp;</label>
								<input type="radio" name="fap_jobfair_divide_gb_list[1].fap_jobfair_divide_gb_eps" id="fap_jobfair_j_fair_eps" ng-model="j_fair_eps" class="form-control" value="C1301">
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
								<textarea name="fap_jobfair_divide_gb_list[1].fap_jobfair_divide_detail" id="fap_jobfair_j_fair_detail" class="form-control" maxlength="600" style="height: 40px;" placeholder="J-fair ์ค๋ช์ ์์ฑํด์ฃผ์ธ์."></textarea>
							</div>
						</div>
						
						<!-- ํฌ์คํธ ์์ฆ -->
						<div id="p_body" style="display: none;">
						------------------------------------------------------------------------
							<div class="form-row">
								<label>ํฌ์คํธ ์์ฆ ๊ธฐ๊ฐ</label>
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
								<label>ํฌ์คํธ ์์ฆ ์?์ฒญ๊ฐ๋ฅ๊ธฐ๊ฐ</label>
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
								<label>ํฌ์คํธ ์์ฆ ์ง์์ ์ง์ํ๊ฐ ์ต์ด์ฌ๋ถ</label>
							</div>
							<input type="hidden" id="fap_post_season_applicable_time_ck" value="">
							<input type="hidden" name="fap_post_season_applicable_time_list[0].fap_jobfair_applicable_time_seq" id="fap_post_season_applicable_time_seq" value="0">							
							<div class="form-row">
								<div class="form-group col-sm-1">
									<input type="radio" name="fap_post_season_applicable_time_list[0].fap_jobfair_applicable_time_first" id="fap_post_season_time_first" ng-model="post_season_time_first" class="form-control" value="D0300">
								</div>
								<div class="form-group col-sm-3">
									<h5><code value="D0300"></code></h5>
								</div>
							</div>
							
							<div class="form-row">
								<label>ํฌ์คํธ ์์ฆ ์ง์์ ์ง์๊ฐ๋ฅ๊ธฐ๊ฐ</label>
							</div>
							<div class="form-row">
								<div class="form-group col-sm-3">
									<input type="hidden" id="fap_post_season_user_date_st_ck" value="">										
									<input type="text" name="fap_post_season_applicable_time_list[0].fap_jobfair_divide_user_date_st" id="fap_post_season_user_date_st" class="date_format" value="" style="width: 100px;">
								</div>
								<div class="form-group col-sm-3">
									<label>&nbsp;</label>
									<input type="hidden" id="fap_post_season_user_time_st_ck" value="">	
									<input type="text" name="fap_post_season_applicable_time_list[0].fap_jobfair_divide_user_time_st" id="fap_post_season_user_time_st" class="time_format" value="" style="width: 80px;">&ensp;~
								</div>
								<div class="form-group col-sm-3">
									<input type="hidden" id="fap_post_season_user_date_et_ck" value="">										
									<input type="text" name="fap_post_season_applicable_time_list[0].fap_jobfair_divide_user_date_et" id="fap_post_season_user_date_et" class="date_format" value="" style="width: 100px;">
								</div>
								<div class="form-group col-sm-3">
									<label>&nbsp;</label>
									<input type="hidden" id="fap_post_season_user_time_et_ck" value="">		
									<input type="text" name="fap_post_season_applicable_time_list[0].fap_jobfair_divide_user_time_et" id="fap_post_season_user_time_et" class="time_format" value="" style="width: 80px;">
								</div>
							</div>
							
							<div class="form-row">
							<div class="form-group col-sm-2">
								<label style="width: 200px;">ํฌ์คํธ์์ฆ ์ฑ์ฉ๋์</label>
								<input type="hidden" name="fap_jobfair_post_season_rc_list[0].fap_jobfair_divide_rc_seq" id="fap_jobfair_post_season_master_seq" value="0">
								<input type="checkbox" name="fap_jobfair_post_season_rc_list[0].fap_jobfair_divide_rc" id="post_season_master_checkbox" ng-init="post_season_master=post_season_master=='A0101'" ng-model="post_season_master" class="form-control" value="A0101">
							</div>
							<div class="form-group col-sm-2">
								<label>&nbsp;</label>
								<h6><code value="A0101"></code></h6>
							</div>
							<div class="form-group col-sm-2">
								<label>&nbsp;</label>
								<input type="hidden" name="fap_jobfair_post_season_rc_list[1].fap_jobfair_divide_rc_seq" id="fap_jobfair_post_season_k_move_seq" value="0">
								<input type="checkbox" name="fap_jobfair_post_season_rc_list[1].fap_jobfair_divide_rc" id="post_season_k_move_checkbox" ng-init="post_season_k_move=post_season_k_move=='A0106'" ng-model="post_season_k_move" class="form-control" value="A0106">
							</div>
							<div class="form-group col-sm-2">
								<label>&nbsp;</label>
								<h6><code value="A0106"></code></h6>
							</div>
							<div class="form-group col-sm-2">
								<label>&nbsp;</label>
								<input type="hidden" name="fap_jobfair_post_season_rc_list[2].fap_jobfair_divide_rc_seq" id="fap_jobfair_post_season_user_seq" value="0">
								<input type="checkbox" name="fap_jobfair_post_season_rc_list[2].fap_jobfair_divide_rc" id="post_season_user_checkbox" ng-init="post_season_user=post_season_user=='A0100'" ng-model="post_season_user" class="form-control" value="A0100">
							</div>
							<div class="form-group col-sm-2">
								<label>&nbsp;</label>
								<h6><code value="A0100"></code></h6>
							</div>
							<div class="form-group col-sm-2">
								<label>&nbsp;</label>
								<input type="hidden" name="fap_jobfair_post_season_rc_list[3].fap_jobfair_divide_rc_seq" id="fap_jobfair_post_season_jap_seq" value="0">
								<input type="checkbox" name="fap_jobfair_post_season_rc_list[3].fap_jobfair_divide_rc" id="post_season_jap_checkbox" ng-init="post_season_jap=post_season_jap=='A0108'" ng-model="post_season_jap" class="form-control" value="A0108">
							</div>
							<div class="form-group col-sm-2">
								<label>&nbsp;</label>
								<h6><code value="A0108"></code></h6>
							</div>
						</div>
						
						<div class="form-row">
						<div class="form-group col-sm-2">
								<label>๋ธ์ถ์ฌ๋ถ</label>
								<input type="radio" name="fap_jobfair_divide_gb_list[2].fap_jobfair_divide_gb_eps" id="fap_jobfair_post_season_not_eps" ng-model="post_season_eps" class="form-control" value="C1300">
							</div>
							<div class="form-group col-sm-2">
								<label>&nbsp;</label>
								<h5><code value="C1300"></code></h5>
							</div>
							<div class="form-group col-sm-2">
								<label>&nbsp;</label>
								<input type="radio" name="fap_jobfair_divide_gb_list[2].fap_jobfair_divide_gb_eps" id="fap_jobfair_post_season_eps" ng-model="post_season_eps" class="form-control" value="C1301">
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
								<label>ํฌ์คํธ ์์ฆ ์ค๋ช</label>
								<textarea name="fap_jobfair_divide_gb_list[2].fap_jobfair_divide_detail" id="fap_jobfair_post_season_detail" class="form-control" maxlength="600" style="height: 40px;" placeholder="ํฌ์คํธ ์์ฆ ์ค๋ช์ ์์ฑํด์ฃผ์ธ์."></textarea>
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
							<input type="hidden" name="fap_missmatching_applicable_time_list[0].fap_jobfair_applicable_time_seq" id="fap_missmatching_applicable_time_seq" value="0">
							<div class="form-row">
								<div class="form-group col-sm-1">
									<input type="radio" name="fap_missmatching_applicable_time_list[0].fap_jobfair_applicable_time_first" id="fap_missmatching_time_first" ng-model="missmatching_time_first" class="form-control" value="D0300">
								</div>
								<div class="form-group col-sm-3">
									<h5><code value="D0300"></code></h5>
								</div>
								<div class="form-group col-sm-1">
									<input type="radio" name="fap_missmatching_applicable_time_list[0].fap_jobfair_applicable_time_first" id="fap_missmatching_time_not_first" ng-model="missmatching_time_first" class="form-control" value="D0301">
								</div>
								<div class="form-group col-sm-3">
									<h5><code value="D0301"></code></h5>
								</div>
								<div class="form-group col-sm-1">
									<input type="radio" name="fap_missmatching_applicable_time_list[0].fap_jobfair_applicable_time_first" id="fap_missmatching_time_missmatching" ng-model="missmatching_time_first" class="form-control" value="D0302">
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
								<label style="width: 150px;">๋ฏธ์ค๋งค์นญ ์ฑ์ฉ๋์</label>
								<input type="hidden" name="fap_jobfair_missmatching_rc_list[0].fap_jobfair_divide_rc_seq" id="fap_jobfair_missmatching_master_seq" value="0">
								<input type="checkbox" name="fap_jobfair_missmatching_rc_list[0].fap_jobfair_divide_rc" id="missmatching_master_checkbox" ng-init="missmatching_master=missmatching_master=='A0101'" ng-model="missmatching_master" class="form-control" value="A0101">
							</div>
							<div class="form-group col-sm-2">
								<label>&nbsp;</label>
								<h6><code value="A0101"></code></h6>
							</div>
							<div class="form-group col-sm-2">
								<label>&nbsp;</label>
								<input type="hidden" name="fap_jobfair_missmatching_rc_list[1].fap_jobfair_divide_rc_seq" id="fap_jobfair_missmatching_k_move_seq" value="0">
								<input type="checkbox" name="fap_jobfair_missmatching_rc_list[1].fap_jobfair_divide_rc" id="missmatching_k_move_checkbox" ng-init="missmatching_k_move=missmatching_k_move=='A0106'" ng-model="missmatching_k_move" class="form-control" value="A0106">
							</div>
							<div class="form-group col-sm-2">
								<label>&nbsp;</label>
								<h6><code value="A0106"></code></h6>
							</div>
							<div class="form-group col-sm-2">
								<label>&nbsp;</label>
								<input type="hidden" name="fap_jobfair_missmatching_rc_list[2].fap_jobfair_divide_rc_seq" id="fap_jobfair_missmatching_user_seq" value="0">
								<input type="checkbox" name="fap_jobfair_missmatching_rc_list[2].fap_jobfair_divide_rc" id="missmatching_user_checkbox" ng-init="missmatching_user=missmatching_user=='A0100'" ng-model="missmatching_user" class="form-control" value="A0100">
							</div>
							<div class="form-group col-sm-2">
								<label>&nbsp;</label>
								<h6><code value="A0100"></code></h6>
							</div>
						</div>
						
						<div class="form-row">
							<div class="form-group col-sm-2">
								<label>๋ธ์ถ์ฌ๋ถ</label>
								<input type="radio" name="fap_jobfair_divide_gb_list[3].fap_jobfair_divide_gb_eps" id="fap_jobfair_missmatching_not_eps" ng-model="missmatching_eps" class="form-control" value="C1300">
							</div>
							<div class="form-group col-sm-2">
								<label>&nbsp;</label>
								<h5><code value="C1300"></code></h5>
							</div>
							<div class="form-group col-sm-2">
								<label>&nbsp;</label>
								<input type="radio" name="fap_jobfair_divide_gb_list[3].fap_jobfair_divide_gb_eps" id="fap_jobfair_missmatching_eps" ng-model="missmatching_eps" class="form-control" value="C1301">
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
								<textarea name="fap_jobfair_divide_gb_list[3].fap_jobfair_divide_detail" id="fap_jobfair_missmatching_detail" class="form-control" maxlength="600" style="height: 40px;" placeholder="๋ฏธ์ค๋งค์นญ ์ค๋ช์ ์์ฑํด์ฃผ์ธ์."></textarea>
							</div>
						</div>	 --%>					
															
					</div>
					<div class="modal-footer">
						<button type="button" id="cancelBtn2" class="btn btn-secondary" data-dismiss="modal">์ทจ์</button>
						<button type="submit" class="btn btn-primary">์์?ํ๊ธฐ</button>
					</div>
				</form>
			</div>
		</div>
	</div>	
	<!-- ์กํ์ด ์์? Modal ๋ -->
</body>
</html>
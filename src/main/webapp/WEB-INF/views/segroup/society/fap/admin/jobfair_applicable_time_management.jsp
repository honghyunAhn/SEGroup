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
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js"></script>
  	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.2.1/js/bootstrap.min.js"></script>
  	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css">
	
	<script type="text/javascript">
	$(function() {	
		cleanDatepicker();
		var setting = {
		        'minTime' : '00:00am',
		        'maxTime' : '23:55pm', 
		        'timeFormat' : 'H:i',
		        'step' : 5
		}
		minMax("fap_jobfair_applicable_time_st_date", "fap_jobfair_applicable_time_et_date");
		minMaxTime("fap_jobfair_applicable_time_st_time", "fap_jobfair_applicable_time_et_time");
		
		minMax("fap_jobfair_applicable_time_st_date_update", "fap_jobfair_applicable_time_et_date_update");
		minMaxTime("fap_jobfair_applicable_time_st_time_update", "fap_jobfair_applicable_time_et_time_update");
		
		/* minMax("fap_jobfair_st" , "fap_jobfair_et");
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
		minMaxTime("00:00am", "fap_post_season_user_time_et", setting); */
		
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
		
		
	});
		
	
	
	
	</script>
	
	
	
	<script type="text/javascript">	
		
	var myApp = angular.module('myapp', []);	
	
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
	
	myApp.directive('selectcode', ['$http',function($http){
		return {
			restrict: "A",
			replace: true,
			scope : {
				value : '@'
			},
			controller: function ($scope, $element, $attrs) {				
				$http({
					method: 'POST',
					url: '/codeconverter',
			  		responseType: 'text',
					params : {
						code : $attrs.value
					}
				}).then(function successCallback(response) {
		    		$scope.filterParams = response.data;
				}, function errorCallback(response) {
					console.log(response);
				});
			}
			,template: "<option>{{filterParams}}</option>"
		}
	}]);
	
	
	
	
	myApp.controller('MainController', ['$scope','$compile','$http', function($scope,$compile,$http){	
		
	var context = '';
		
	//var app_time_map_json = JSON.parse('${app_time_map_json}');
	//console.log(app_time_map_json);
	
	var jobfair_info = '${jobfair_info_json}';
	jobfair_info = jobfair_info.replace(/(?:\r\n|\r|\n)/g, '\\r\\n');
	jobfair_info = JSON.parse(jobfair_info);
	console.log(jobfair_info);
		
	/* [start] ์กํ์ด ์ธ๋ถ select box option ๊ทธ๋ฆฌ๊ธฐ */
	
	var fapJobfairDivideList = jobfair_info.fapJobfairDivideList;
	
	if(fapJobfairDivideList != null){
		context = '';
		
		context += '<option hidden value="0">์?ํํด์ฃผ์ธ์</option>';
		for(var i in fapJobfairDivideList){
			context += '<option seq="' + fapJobfairDivideList[i].fap_jobfair_divide_seq + '" value="' + fapJobfairDivideList[i].fap_jobfair_divide_gb + '" selectcode></option>';
		}
		
		$("#jobfair_divide_select_box").append($compile(context)($scope));
		
	}
	
	
	/* [end] ์กํ์ด ์ธ๋ถ select box option ๊ทธ๋ฆฌ๊ธฐ */
	
	
	
	
	
	
	
	
	
	//[start]] ์ถ๊ฐํ๊ฐ ๊ทธ๋ฆฌ๊ธฐ
	/* var app_time_list = app_time_map_json.jobfair_applicable_time_list;
	
	if(app_time_list == null || app_time_list.length == 0){
		
	}else{
		for(var i in app_time_list){
			
			var count = 0;
		
			count = Number(i) + 1;
			
			context += '<tr>';
			context += '<td>' + count + '</td>';
			context += '<td>' + app_time_list[i].fap_jobfair_applicable_time_seq + '</td>';
			context += '<td><code value="' + app_time_list[i].fap_jobfair_divide_gb + '"></code></td>';
			context += '<td>' + app_time_list[i].fap_jobfair_applicable_time_st + '</td>';
			context += '<td>' + app_time_list[i].fap_jobfair_applicable_time_et + '</td>';
			context += '<td><code value="' + app_time_list[i].fap_jobfair_applicable_time_first + '"></code></td>';
			context += '<td><code value="' + app_time_list[i].fap_jobfair_applicable_time_deadline_gb + '"></code></td>';
			
			context += '</tr>';
			
			
		}
		$("#table_body").append($compile(context)($scope));
	} */
	//[end] ๋ฏธ์ค๋งค์นญ/์ถ๊ฐํ๊ฐ ๊ทธ๋ฆฌ๊ธฐ
	
	
	
	//[start] ์ต์ดํ๊ฐ ๊ทธ๋ฆฌ๊ธฐ
/* 	context = '';
	var option_context = '';
	var app_time_list_first = app_time_map_json.jobfair_applicable_time_list_first;
	
	if(app_time_list_first == null || app_time_list_first.length == 0){
		
	}else{
		for(var i in app_time_list_first){
			
			var count = 0;
		
			count = Number(i) + 1;
			
			context += '<tr>';
			context += '<td>' + count + '</td>';
			context += '<td>' + app_time_list_first[i].fap_jobfair_applicable_time_seq + '</td>';
			context += '<td><code value="' + app_time_list_first[i].fap_jobfair_divide_gb + '"></code></td>';
			context += '<td>' + app_time_list_first[i].fap_jobfair_applicable_time_st + '</td>';
			context += '<td>' + app_time_list_first[i].fap_jobfair_applicable_time_et + '</td>';
			context += '<td><code value="' + app_time_list_first[i].fap_jobfair_applicable_time_first + '"></code></td>';
			context += '<td><code value="' + app_time_list_first[i].fap_jobfair_applicable_time_deadline_gb + '"></code></td>';
			context += '</tr>';
			irst[i].fap_jobfair_divide_gb + '" selectcode></option>';
		}
		$("#table_body_first").append($compile(context)($scope));
		$("#modal_select").append($compile(option_context)($scope));
	} */
	//[end] ์ต์ดํ๊ฐ ๊ทธ๋ฆฌ๊ธฐ
	
	
	
	/* -----------------------[start] scope ํจ์ ์์ญ -----------------------*/
	
	
	//[start] main table ๊ทธ๋ฆฌ๋ ํจ์(์กํ์ด์ธ๋ถ select box onchange)
	$scope.select_change = function(){
		
		$("#insert_modal_btn").show();
		
		var can_insert = true;
		$("#insert_modal_btn").attr("disabled", false);
		$("#insert_modal_btn_dtl").html("");
		
		var seq = $("#jobfair_divide_select_box option:selected").attr("seq");
		
		$http({
			method: 'POST',
			url: "/fap/admin/jobfair_applicable_time_management",
	  		responseType: 'text',
			params : {
				fap_jobfair_divide_seq : seq
			}
		
		}).then(function successCallback(response) {
			
    		console.log(response.data);
    		
    		//table body ๋ด์ฉ ์ด๊ธฐํ
    		$("#table_body").html("");
    		$("#table_body_first").html("");
    		
    		//[start] ์ต์ดํ๊ฐ ํ์ด๋ธ ๊ทธ๋ฆฌ๊ธฐ
    		var app_time_list_first = response.data.jobfair_applicable_time_list_first;
    		
    		
    		
    		if(app_time_list_first == null || app_time_list_first.length == 0){
    			
    		}else{
    			context = '';
    			for(var i in app_time_list_first){
    				
    				var count = 0;
    			
    				count = Number(i) + 1;
    				
    				context += '<tr>';
    				context += '<td>' + count + '</td>';
    				context += '<td>' + app_time_list_first[i].fap_jobfair_applicable_time_seq + '</td>';
    				context += '<td>' + app_time_list_first[i].fap_jobfair_applicable_time_st + '</td>';
    				context += '<td>' + app_time_list_first[i].fap_jobfair_applicable_time_et + '</td>';
    				context += '<td>' + app_time_list_first[i].fap_jobfair_applicable_time_nm + '</td>';
    				context += '<td><code value="' + app_time_list_first[i].fap_jobfair_applicable_time_first + '"></code></td>';
    				context += '<td><code value="' + app_time_list_first[i].fap_jobfair_applicable_time_deadline_gb + '"></code></td>';
    				context += '</tr>';
    				
    				
    				$("#first_end_date").val(app_time_list_first[i].fap_jobfair_applicable_time_et);

    				if(app_time_list_first[i].fap_jobfair_applicable_time_deadline_gb == 'D0400'){
						can_insert = false;
    				}
    				
    			}
    			$("#table_body_first").append($compile(context)($scope));
    			if(!can_insert){
					$("#insert_modal_btn").attr("disabled", true);
					$("#insert_modal_btn_dtl").html("<font color='red'>์งํ๋๊ณ?์๋ ์ถ๊ฐํ๊ฐ๊ฐ ์ง์๋ฐ ๋ฃฐ์?์ฉ์ด ์๋ฃ๋ํ ์ถ๊ฐ ๋ฑ๋ก์ด ๊ฐ๋ฅํฉ๋๋ค.</font>");
				}
    		
    		}//[end] ์ต์ดํ๊ฐ ํ์ด๋ธ ๊ทธ๋ฆฌ๊ธฐ
    		
    		//[start] ๋ฏธ์ค๋งค์นญ/์ถ๊ฐํ๊ฐ ๊ทธ๋ฆฌ๊ธฐ
    		var app_time_list = response.data.jobfair_applicable_time_list;
    	 
			if(app_time_list == null || app_time_list.length == 0){
				
			}else{
				context = '';
				for(var i in app_time_list){
					
					var count = 0;
				
					count = Number(i) + 1;
					
					context += '<tr>';
					context += '<td>' + count + '</td>';
					context += '<td>' + app_time_list[i].fap_jobfair_applicable_time_seq + '</td>';
					context += '<td>' + app_time_list[i].fap_jobfair_applicable_time_st + '</td>';
					context += '<td>' + app_time_list[i].fap_jobfair_applicable_time_et + '</td>';
					context += '<td>' + app_time_list[i].fap_jobfair_applicable_time_nm + '</td>';
					context += '<td><code value="' + app_time_list[i].fap_jobfair_applicable_time_first + '"></code></td>';
					context += '<td><code value="' + app_time_list[i].fap_jobfair_applicable_time_deadline_gb + '"></code></td>';
					
					if(app_time_list[i].fap_jobfair_applicable_time_deadline_gb == 'D0400'){
						//์์ง ๋ฃฐ์?์ฉ์ด ์๋์๊ฒฝ์ฐ ์์? ๊ฐ๋ฅ(๋น๊ณ?๋์ ์์?๋ฒํผ์ ๋ฐ์์ค๋ค.)
						context += '<td><button type="button" class="btn btn-primary" data-toggle="modal" data-target="#update_modal">์์?</button</td>';
						context += '<button type="button" class="btn btn-danger" onclick="delete_apptime(' + app_time_list[i].fap_jobfair_applicable_time_seq + ')">์ญ์?</button>'
					}else{
						context += '<td>-</td>'
					}
					
					context += '</tr>';
					
					if(app_time_list[i].fap_jobfair_applicable_time_deadline_gb == 'D0400'){
						can_insert = false;	//insert ๋ฒํผ disabled ์ฒ๋ฆฌํด์ฃผ๋ ๋ณ์
						
						// ์์?modal์ data ์๋?ฅํด์ฃผ๋ ์ฝ๋
						$("#fap_jobfair_applicable_time_nm_update").val(app_time_list[i].fap_jobfair_applicable_time_nm);
						$("#fap_jobfair_divide_seq_update").val(app_time_list[i].fap_jobfair_divide_seq);
						$("#fap_jobfair_applicable_time_seq_update").val(app_time_list[i].fap_jobfair_applicable_time_seq);
						
						var st = app_time_list[i].fap_jobfair_applicable_time_st;
						var st_date = st.substring(0, st.indexOf(" ") + 1);
						var st_time = st.substring(st.indexOf(" ") + 1);
						
						$("#fap_jobfair_applicable_time_st_date_update").val(st_date);
						$("#fap_jobfair_applicable_time_st_time_update").val(st_time);
						
						var et = app_time_list[i].fap_jobfair_applicable_time_et;
						var et_date = et.substring(0, et.indexOf(" ") + 1);
						var et_time = et.substring(et.indexOf(" ") + 1);
						
						$("#fap_jobfair_applicable_time_et_date_update").val(et_date);
						$("#fap_jobfair_applicable_time_et_time_update").val(et_time);
						
						
						if(app_time_list[i].fap_jobfair_applicable_time_first == 'D0302'){
							$("#update_D0302").prop('checked', true);
							$("#update_D0302").attr('checked', true);
						}else if(app_time_list[i].fap_jobfair_applicable_time_first == 'D0301'){
							$("#update_D0301").prop('checked', true);
							$("#update_D0301").attr('checked', true);
						}
						
					}
					
				}
				$("#table_body").append($compile(context)($scope));
				if(!can_insert){
					$("#insert_modal_btn").attr("disabled", true);
					$("#insert_modal_btn_dtl").html("<font color='red'>์งํ๋๊ณ?์๋ ์ถ๊ฐํ๊ฐ๊ฐ ์ง์๋ฐ ๋ฃฐ์?์ฉ์ด ์๋ฃ๋ํ ์ถ๊ฐ ๋ฑ๋ก์ด ๊ฐ๋ฅํฉ๋๋ค.</font>");
				}

				
			}//[end] ๋ฏธ์ค๋งค์นญ/์ถ๊ฐํ๊ธฐ ๊ทธ๋ฆฌ๊ธฐ
    		
    		
    		
		}, function errorCallback(response) {
			
			console.log(response);
		});
		
	}//[end] main table ๊ทธ๋ฆฌ๋ ํจ์(์กํ์ด์ธ๋ถ select box onchange)
	
	
	
	
	/* ----------------------[end] scope ํจ์ ์์ญ -------------------------*/
	
	
	
		
	}])
		
		
		</script>
	
	
	<script type="text/javascript">
		
		
		
		$(document).ready(function(){
			  $("#search_keyword").on("keyup", function() {
			    var value = $(this).val().toLowerCase();
			    $("#searched_table tbody tr").filter(function() {
			      $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1);
			    });
			  });
			});
		
		
		function insert(){
			
						
			//[start] ํผ์ฒดํฌ
			
			/*์ผ์?๋ช์นญ*/
			var fap_jobfair_applicable_time_nmVal=$("#fap_jobfair_applicable_time_nm").val();
		     
			if(fap_jobfair_applicable_time_nmVal==null || fap_jobfair_applicable_time_nmVal==''){
				alert("ํ์ํญ๋ชฉ ์๋๋ค.");
			    $("#fap_jobfair_applicable_time_nm").focus();
			    return;
			}
			
			/* ์์๋?์ง */
			var fap_jobfair_applicable_time_st_date = $("#fap_jobfair_applicable_time_st_date").val();
			if(fap_jobfair_applicable_time_st_date == null || fap_jobfair_applicable_time_st_date == ''){
				alert("ํ์ํญ๋ชฉ ์๋๋ค.");
				 $("#fap_jobfair_applicable_time_st_date").focus();
				 return;
			}
			
			var fap_jobfair_applicable_time_st_time = $("#fap_jobfair_applicable_time_st_time").val();
			if(fap_jobfair_applicable_time_st_time == null || fap_jobfair_applicable_time_st_time == ''){
				alert("ํ์ํญ๋ชฉ ์๋๋ค.");
				 $("#fap_jobfair_applicable_time_st_time").focus();
				 return;
			}
			
			var first_end_date = $("#first_end_date").val();
			var first_end_date_form = new Date();
			first_end_date_form = parse_date(first_end_date);
			
			var insert_date = fap_jobfair_applicable_time_st_date + " " + fap_jobfair_applicable_time_st_time;
			var insert_date_form = new Date();
			insert_date = parse_date(insert_date);
			
			if(first_end_date_form >= insert_date){
				alert("์ถ๊ฐ์ง์์ ์ต์ดํ๊ฐ ๋ง๊ฐ ์ดํ๋ถํฐ ์์ํ? ์ ์์ต๋๋ค.");
				$("#fap_jobfair_applicable_time_st_date").val("");
				$("#fap_jobfair_applicable_time_st_time").val("");
				
				$("#fap_jobfair_applicable_time_st_date").focus();
				return;
			}
			
			/* ์ข๋ฃ๋?์ง */
			var fap_jobfair_applicable_time_et_date = $("#fap_jobfair_applicable_time_et_date").val();
			if(fap_jobfair_applicable_time_et_date == null || fap_jobfair_applicable_time_et_date == ''){
				alert("ํ์ํญ๋ชฉ ์๋๋ค.");
				 $("#fap_jobfair_applicable_time_et_date").focus();
				 return;
			}
			
			var fap_jobfair_applicable_time_et_time = $("#fap_jobfair_applicable_time_et_time").val();
			if(fap_jobfair_applicable_time_et_time == null || fap_jobfair_applicable_time_et_time == ''){
				alert("ํ์ํญ๋ชฉ ์๋๋ค.");
				 $("#fap_jobfair_applicable_time_et_time").focus();
				 return;
			}
			
			var fap_jobfair_applicable_time_first = $('#form_insert_job_applicabletime input[name="fap_jobfair_applicable_time_first"]:checked').val();
			if(fap_jobfair_applicable_time_first == null || fap_jobfair_applicable_time_first == ''){
				alert("์ถ๊ฐ์ง์ ์?ํ์ ํ์์๋๋ค.");
				return;

			}
			
			
			
			
			//[end] ํผ์ฒดํฌ
			
			//insert์ ํ์ํ ์ถ๊ฐ parameter ๋ฃ์ด์ฃผ๊ธฐ
			var fap_jobfair_applicable_time_st = '';
			fap_jobfair_applicable_time_st = fap_jobfair_applicable_time_st_date + ' ' + fap_jobfair_applicable_time_st_time;
			$("#fap_jobfair_applicable_time_st").val(fap_jobfair_applicable_time_st);
			
			var fap_jobfair_applicable_time_et = '';
			fap_jobfair_applicable_time_et = fap_jobfair_applicable_time_et_date + ' ' + fap_jobfair_applicable_time_et_time;
			$("#fap_jobfair_applicable_time_et").val(fap_jobfair_applicable_time_et);
			
			var fap_jobfair_divide_seq = $("#jobfair_divide_select_box option:selected").attr("seq");
			$("#fap_jobfair_divide_seq").val(fap_jobfair_divide_seq);
			
			$("#form_insert_job_applicabletime").submit();
			
		}
		
	
	
		function update(){
			//[start] ํผ์ฒดํฌ
			
			var fap_jobfair_applicable_time_nm_update = $("#fap_jobfair_applicable_time_nm_update").val();
			if(fap_jobfair_applicable_time_nm_update == null || fap_jobfair_applicable_time_nm_update == ''){
				alert("ํ์ํญ๋ชฉ ์๋๋ค.");
				 $("#fap_jobfair_applicable_time_nm_update").focus();
				 return;
			}
			
			var fap_jobfair_applicable_time_st_date_update = $("#fap_jobfair_applicable_time_st_date_update").val();
			if(fap_jobfair_applicable_time_st_date_update == null || fap_jobfair_applicable_time_st_date_update == ''){
				alert("ํ์ํญ๋ชฉ ์๋๋ค.");
				 $("#fap_jobfair_applicable_time_st_date_update").focus();
				 return;
			}
			
			var fap_jobfair_applicable_time_st_time_update = $("#fap_jobfair_applicable_time_st_time_update").val();
			if(fap_jobfair_applicable_time_st_time_update == null || fap_jobfair_applicable_time_st_time_update == ''){
				alert("ํ์ํญ๋ชฉ ์๋๋ค.");
				 $("#fap_jobfair_applicable_time_st_time_update").focus();
				 return;
			}
			
			var fap_jobfair_applicable_time_et_date_update = $("#fap_jobfair_applicable_time_et_date_update").val();
			if(fap_jobfair_applicable_time_et_date_update == null || fap_jobfair_applicable_time_et_date_update == ''){
				alert("ํ์ํญ๋ชฉ ์๋๋ค.");
				 $("#fap_jobfair_applicable_time_et_date_update").focus();
				 return;
			}
			
			var fap_jobfair_applicable_time_et_time_update = $("#fap_jobfair_applicable_time_et_time_update").val();
			if(fap_jobfair_applicable_time_et_time_update == null || fap_jobfair_applicable_time_et_time_update == ''){
				alert("ํ์ํญ๋ชฉ ์๋๋ค.");
				 $("#fap_jobfair_applicable_time_et_time_update").focus();
				 return;
			}
			
			var fap_jobfair_applicable_time_first = $('#form_update_job_applicabletime input[name="fap_jobfair_applicable_time_first"]:checked').val();
			if(fap_jobfair_applicable_time_first == null || fap_jobfair_applicable_time_first == ''){
				alert("์ถ๊ฐ์ง์ ์?ํ์ ํ์์๋๋ค.");
				return;

			}
			
			//[end] ํผ์ฒดํฌ
			
			//update์ ํ์ํ ์ถ๊ฐ parameter ๋ฃ์ด์ฃผ๊ธฐ
			var fap_jobfair_applicable_time_st_update = '';
			fap_jobfair_applicable_time_st_update = $("#fap_jobfair_applicable_time_st_date_update").val() + ' ' + $("#fap_jobfair_applicable_time_st_time_update").val();
			$("#fap_jobfair_applicable_time_st_update").val(fap_jobfair_applicable_time_st_update);
			
			var fap_jobfair_applicable_time_et_update = '';
			fap_jobfair_applicable_time_et_update = $("#fap_jobfair_applicable_time_et_date_update").val() + ' ' + $("#fap_jobfair_applicable_time_et_time_update").val();
			$("#fap_jobfair_applicable_time_et_update").val(fap_jobfair_applicable_time_et_update);
			
			$("#form_update_job_applicabletime").submit();
			
		}
		
		
		function delete_apptime(fap_jobfair_applicable_time_seq) {
			var fap_jobfair_seq = ${jobfair_info.fap_jobfair_seq};
		    var fap_jobfair_divide_seq =  $("#jobfair_divide_select_box option:selected").attr("seq");
			if(confirm("์ญ์?ํ์๊ฒ?์ต๋๊น?")){
				location.href = "/fap/admin/delete_job_applicabletime?fap_jobfair_applicable_time_seq=" + fap_jobfair_applicable_time_seq +"&fap_jobfair_divide_seq=" + fap_jobfair_divide_seq +"&fap_jobfair_seq=" + fap_jobfair_seq;
			}
		}
		
		function parse_date(value){
			
			var year = value.substring(0, 4);
			var month = value.substring(5, 7);
			var day = value.substring(8, 10);
			var hour = value.substring(11, 13);
			var minute = value.substring(14, 16);
			var second = value.substring(17, 19);

			value = new Date(year, month, day, hour, minute, second);
			return value;
		}
		
	</script>
	
		

</head>
<body ng-app="myapp" ng-controller="MainController">
 <%@include file="admin_menu.jsp"%>
	<!-- ์ง๋ฅ๊ฐ๋ฅ์๊ฐ์ ์ต์ดํ๊ฐ ์๊ฐ๊ณผ ๋น๊ตํ๊ธฐ์ํ ๋ณ์ -->
	<input type="hidden" id="first_end_date">
<br>
	<div class="page_title">
		<h2>JobFair ์ง์์๊ฐ ๊ด๋ฆฌ</h2>
	</div>
	<br>
	 
	<h3>์?ํํ ์กํ์ด : ${jobfair_info.fap_jobfair_title}</h3>
	<br>
	์กํ์ด ์ธ๋ถ : 
	<select id="jobfair_divide_select_box" onchange="angular.element(this).scope().select_change()">
		
	</select>
	<hr>
	<h4>์ต์ดํ๊ฐ</h4>
	<table class="table table-hover">
		<thead>
			<tr>
				<th><span>No</span></th>
				<th><span>์ง์์๊ฐ๊ด๋ฆฌ ์ํ์ค</span></th>				
				<th><span>์์์ผ</span></th>
				<th><span>์ข๋ฃ์ผ</span></th>
				<th><span>์ง์์๊ฐ๋ช</span></th>
				<th><span>๊ตฌ๋ถ</span></th>
				<th><span>๋ฃฐ ์?์ฉ ์ฌ๋ถ</span></th>
			</tr>
		</thead>
		<tbody id="table_body_first">

		</tbody>
	</table>
	<br>
	<hr>
	<h3>์ถ๊ฐํ๊ฐ</h3>
	<input class="form-control" type="text" id="search_keyword" placeholder="๊ฒ์์ด">
	<table id="searched_table" class="table table-hover">
		<thead>
			<tr>
				<th><span>No</span></th>
				<th><span>์ง์์๊ฐ๊ด๋ฆฌ ์ํ์ค</span></th>
				<th><span>์์์ผ</span></th>
				<th><span>์ข๋ฃ์ผ</span></th>
				<th><span>์ง์์๊ฐ๋ช</span></th>
				<th><span>๊ตฌ๋ถ</span></th>
				<th><span>๋ฃฐ ์?์ฉ ์ฌ๋ถ</span></th>
				<th><span>๋น๊ณ?</span>
			</tr>
		</thead>
		<tbody id="table_body">
				
		</tbody>
	</table>	
	
	<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#insert_modal" id="insert_modal_btn" style="display: none">
    	์ง์๊ฐ๋ฅ์๊ฐ ์ถ๊ฐ
	</button>
	<span id="insert_modal_btn_dtl">
	</span>
	
	<!-- ๋ฑ๋ก Modal -->
	<div class="modal" id="insert_modal">
		<div class="modal-dialog">
		 	<div class="modal-content">
		
				<!-- Modal Header -->
				<div class="modal-header">
					<h4 class="modal-title">์ง์๊ฐ๋ฅ์๊ฐ ๋ฑ๋ก</h4>
					<button type="button" class="close" data-dismiss="modal">&times;</button>
				</div>
				
				<!-- Modal body -->
				<div class="modal-body">
					<form action="/fap/admin/insert_job_applicabletime" method="post" id="form_insert_job_applicabletime">
						<div class="hidden-box">
							<input type="hidden" name="fap_jobfair_divide_seq" id="fap_jobfair_divide_seq">
							<input type="hidden" name="fap_jobfair_applicable_time_st" id="fap_jobfair_applicable_time_st">
							<input type="hidden" name="fap_jobfair_applicable_time_et" id="fap_jobfair_applicable_time_et">			
							<input type="hidden" name="fap_jobfair_seq" value="${jobfair_info.fap_jobfair_seq}">						
						</div>
						<div class="form-row">
							<div class="form-group col-sm-2">
								<label>์ถ๊ฐ์ง์</label>
							</div>
							<div class="form-group col-sm-1">
								<input type="radio" value="D0301" name="fap_jobfair_applicable_time_first" class="form-control">
							</div>&nbsp;&nbsp;
							<div class="form-group col-sm-2">
								<label>์ผ์? ๋ช์นญ</label>
							</div>
							<div class="form-group col-sm-3">									
								<input type="text"  id="fap_jobfair_applicable_time_nm" name="fap_jobfair_applicable_time_nm" value="" style="width: 100px;">
							</div>
						</div>
						
						<div class="form-row">
							<label>์ง์๊ฐ๋ฅ์๊ฐ</label>
						</div>
						<div class="form-row">
							<div class="form-group col-sm-3">									
								<input type="text" id="fap_jobfair_applicable_time_st_date" class="date_format" value="" style="width: 100px;">
							</div>
							<div class="form-group col-sm-3">
								<label>&nbsp;</label>
								<input type="text" id="fap_jobfair_applicable_time_st_time" class="time_format" value="" style="width: 80px;">&ensp;~
							</div>
							<div class="form-group col-sm-3">									
								<input type="text" id="fap_jobfair_applicable_time_et_date" class="date_format" value="" style="width: 100px;">
							</div>
							<div class="form-group col-sm-3">
								<label>&nbsp;</label>
								<input type="text" id="fap_jobfair_applicable_time_et_time" class="time_format" value="" style="width: 80px;">
							</div>
						</div>
					</form>
				</div>
				
				<!-- Modal footer -->
				<div class="modal-footer">
					
					<button type="button" class="btn btn-primary" onclick="insert()">๋ฑ๋ก</button>
					<button type="button" class="btn btn-danger" data-dismiss="modal">๋ซ๊ธฐ</button>
				</div>
			      
			</div>
		</div>
	</div>
	
	
	<!-- ์์? Modal -->
	<div class="modal" id="update_modal">
		<div class="modal-dialog">
		 	<div class="modal-content">
		
				<!-- Modal Header -->
				<div class="modal-header">
					<h4 class="modal-title">์ง์๊ฐ๋ฅ์๊ฐ ์์?</h4>
					<button type="button" class="close" data-dismiss="modal">&times;</button>
				</div>
				
				<!-- Modal body -->
				<div class="modal-body">
					<form action="/fap/admin/update_job_applicabletime" method="post" id="form_update_job_applicabletime">
						<div class="hidden-box">
							<input type="hidden" name="fap_jobfair_divide_seq" id="fap_jobfair_divide_seq_update">
							<input type="hidden" name="fap_jobfair_applicable_time_seq" id="fap_jobfair_applicable_time_seq_update">
							<input type="hidden" name="fap_jobfair_applicable_time_st" id="fap_jobfair_applicable_time_st_update">
							<input type="hidden" name="fap_jobfair_applicable_time_et" id="fap_jobfair_applicable_time_et_update">							
							<input type="hidden" name="fap_jobfair_seq" value="${jobfair_info.fap_jobfair_seq}">
						</div>
						<div class="form-row">
							<div class="form-group col-sm-2">
								<label>์ถ๊ฐ์ง์</label>
							</div>
							<div class="form-group col-sm-1">
								<input type="radio" value="D0301" name="fap_jobfair_applicable_time_first" class="form-control" id="update_D0301">
							</div>
							<div class="form-group col-sm-2">
								<label>์ผ์? ๋ช์นญ</label>
							</div>
							<div class="form-group col-sm-3">									
								<input type="text" name="fap_jobfair_applicable_time_nm" id="fap_jobfair_applicable_time_nm_update" value="" style="width: 100px;">
							</div>
						</div>
						
						<div class="form-row">
							<label>์ง์๊ฐ๋ฅ์๊ฐ</label>
						</div>
						<div class="form-row">
							<div class="form-group col-sm-3">									
								<input type="text" id="fap_jobfair_applicable_time_st_date_update" class="date_format" value="" style="width: 100px;">
							</div>
							<div class="form-group col-sm-3">
								<label>&nbsp;</label>
								<input type="text" id="fap_jobfair_applicable_time_st_time_update" class="time_format" value="" style="width: 80px;">&ensp;~
							</div>
							<div class="form-group col-sm-3">									
								<input type="text" id="fap_jobfair_applicable_time_et_date_update" class="date_format" value="" style="width: 100px;">
							</div>
							<div class="form-group col-sm-3">
								<label>&nbsp;</label>
								<input type="text" id="fap_jobfair_applicable_time_et_time_update" class="time_format" value="" style="width: 80px;">
							</div>
						</div>
					</form>
				</div>
				
				<!-- Modal footer -->
				<div class="modal-footer">					
					<button type="button" class="btn btn-primary" onclick="update()">์์?</button>
					<button type="button" class="btn btn-danger" data-dismiss="modal">๋ซ๊ธฐ</button>
				</div>
			      
			</div>
		</div>
	</div>
	
	
</body>
</html>
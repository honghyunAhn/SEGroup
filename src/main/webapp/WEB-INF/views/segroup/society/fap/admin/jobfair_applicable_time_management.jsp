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
	<!-- modal을 위한 bootstrap -->
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
		
	/* [start] 잡페어 세부 select box option 그리기 */
	
	var fapJobfairDivideList = jobfair_info.fapJobfairDivideList;
	
	if(fapJobfairDivideList != null){
		context = '';
		
		context += '<option hidden value="0">선택해주세요</option>';
		for(var i in fapJobfairDivideList){
			context += '<option seq="' + fapJobfairDivideList[i].fap_jobfair_divide_seq + '" value="' + fapJobfairDivideList[i].fap_jobfair_divide_gb + '" selectcode></option>';
		}
		
		$("#jobfair_divide_select_box").append($compile(context)($scope));
		
	}
	
	
	/* [end] 잡페어 세부 select box option 그리기 */
	
	
	
	
	
	
	
	
	
	//[start]] 추가허가 그리기
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
	//[end] 미스매칭/추가허가 그리기
	
	
	
	//[start] 최초허가 그리기
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
	//[end] 최초허가 그리기
	
	
	
	/* -----------------------[start] scope 함수 영역 -----------------------*/
	
	
	//[start] main table 그리는 함수(잡페어세부 select box onchange)
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
    		
    		//table body 내용 초기화
    		$("#table_body").html("");
    		$("#table_body_first").html("");
    		
    		//[start] 최초허가 테이블 그리기
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
					$("#insert_modal_btn_dtl").html("<font color='red'>진행되고있는 추가허가가 지원및 룰적용이 완료된후 추가 등록이 가능합니다.</font>");
				}
    		
    		}//[end] 최초허가 테이블 그리기
    		
    		//[start] 미스매칭/추가허가 그리기
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
						//아직 룰적용이 안됐을경우 수정 가능(비고란에 수정버튼의 뛰워준다.)
						context += '<td><button type="button" class="btn btn-primary" data-toggle="modal" data-target="#update_modal">수정</button</td>';
						context += '<button type="button" class="btn btn-danger" onclick="delete_apptime(' + app_time_list[i].fap_jobfair_applicable_time_seq + ')">삭제</button>'
					}else{
						context += '<td>-</td>'
					}
					
					context += '</tr>';
					
					if(app_time_list[i].fap_jobfair_applicable_time_deadline_gb == 'D0400'){
						can_insert = false;	//insert 버튼 disabled 처리해주는 변수
						
						// 수정modal의 data 입력해주는 코드
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
					$("#insert_modal_btn_dtl").html("<font color='red'>진행되고있는 추가허가가 지원및 룰적용이 완료된후 추가 등록이 가능합니다.</font>");
				}

				
			}//[end] 미스매칭/추가허기 그리기
    		
    		
    		
		}, function errorCallback(response) {
			
			console.log(response);
		});
		
	}//[end] main table 그리는 함수(잡페어세부 select box onchange)
	
	
	
	
	/* ----------------------[end] scope 함수 영역 -------------------------*/
	
	
	
		
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
			
						
			//[start] 폼체크
			
			/*일정명칭*/
			var fap_jobfair_applicable_time_nmVal=$("#fap_jobfair_applicable_time_nm").val();
		     
			if(fap_jobfair_applicable_time_nmVal==null || fap_jobfair_applicable_time_nmVal==''){
				alert("필수항목 입니다.");
			    $("#fap_jobfair_applicable_time_nm").focus();
			    return;
			}
			
			/* 시작날짜 */
			var fap_jobfair_applicable_time_st_date = $("#fap_jobfair_applicable_time_st_date").val();
			if(fap_jobfair_applicable_time_st_date == null || fap_jobfair_applicable_time_st_date == ''){
				alert("필수항목 입니다.");
				 $("#fap_jobfair_applicable_time_st_date").focus();
				 return;
			}
			
			var fap_jobfair_applicable_time_st_time = $("#fap_jobfair_applicable_time_st_time").val();
			if(fap_jobfair_applicable_time_st_time == null || fap_jobfair_applicable_time_st_time == ''){
				alert("필수항목 입니다.");
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
				alert("추가지원은 최초허가 마감 이후부터 시작할 수 있습니다.");
				$("#fap_jobfair_applicable_time_st_date").val("");
				$("#fap_jobfair_applicable_time_st_time").val("");
				
				$("#fap_jobfair_applicable_time_st_date").focus();
				return;
			}
			
			/* 종료날짜 */
			var fap_jobfair_applicable_time_et_date = $("#fap_jobfair_applicable_time_et_date").val();
			if(fap_jobfair_applicable_time_et_date == null || fap_jobfair_applicable_time_et_date == ''){
				alert("필수항목 입니다.");
				 $("#fap_jobfair_applicable_time_et_date").focus();
				 return;
			}
			
			var fap_jobfair_applicable_time_et_time = $("#fap_jobfair_applicable_time_et_time").val();
			if(fap_jobfair_applicable_time_et_time == null || fap_jobfair_applicable_time_et_time == ''){
				alert("필수항목 입니다.");
				 $("#fap_jobfair_applicable_time_et_time").focus();
				 return;
			}
			
			var fap_jobfair_applicable_time_first = $('#form_insert_job_applicabletime input[name="fap_jobfair_applicable_time_first"]:checked').val();
			if(fap_jobfair_applicable_time_first == null || fap_jobfair_applicable_time_first == ''){
				alert("추가지원 선택은 필수입니다.");
				return;

			}
			
			
			
			
			//[end] 폼체크
			
			//insert에 필요한 추가 parameter 넣어주기
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
			//[start] 폼체크
			
			var fap_jobfair_applicable_time_nm_update = $("#fap_jobfair_applicable_time_nm_update").val();
			if(fap_jobfair_applicable_time_nm_update == null || fap_jobfair_applicable_time_nm_update == ''){
				alert("필수항목 입니다.");
				 $("#fap_jobfair_applicable_time_nm_update").focus();
				 return;
			}
			
			var fap_jobfair_applicable_time_st_date_update = $("#fap_jobfair_applicable_time_st_date_update").val();
			if(fap_jobfair_applicable_time_st_date_update == null || fap_jobfair_applicable_time_st_date_update == ''){
				alert("필수항목 입니다.");
				 $("#fap_jobfair_applicable_time_st_date_update").focus();
				 return;
			}
			
			var fap_jobfair_applicable_time_st_time_update = $("#fap_jobfair_applicable_time_st_time_update").val();
			if(fap_jobfair_applicable_time_st_time_update == null || fap_jobfair_applicable_time_st_time_update == ''){
				alert("필수항목 입니다.");
				 $("#fap_jobfair_applicable_time_st_time_update").focus();
				 return;
			}
			
			var fap_jobfair_applicable_time_et_date_update = $("#fap_jobfair_applicable_time_et_date_update").val();
			if(fap_jobfair_applicable_time_et_date_update == null || fap_jobfair_applicable_time_et_date_update == ''){
				alert("필수항목 입니다.");
				 $("#fap_jobfair_applicable_time_et_date_update").focus();
				 return;
			}
			
			var fap_jobfair_applicable_time_et_time_update = $("#fap_jobfair_applicable_time_et_time_update").val();
			if(fap_jobfair_applicable_time_et_time_update == null || fap_jobfair_applicable_time_et_time_update == ''){
				alert("필수항목 입니다.");
				 $("#fap_jobfair_applicable_time_et_time_update").focus();
				 return;
			}
			
			var fap_jobfair_applicable_time_first = $('#form_update_job_applicabletime input[name="fap_jobfair_applicable_time_first"]:checked').val();
			if(fap_jobfair_applicable_time_first == null || fap_jobfair_applicable_time_first == ''){
				alert("추가지원 선택은 필수입니다.");
				return;

			}
			
			//[end] 폼체크
			
			//update에 필요한 추가 parameter 넣어주기
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
			if(confirm("삭제하시겠습니까?")){
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
	<!-- 지능가능시간을 최초허가 시간과 비교하기위한 변수 -->
	<input type="hidden" id="first_end_date">
<br>
	<div class="page_title">
		<h2>JobFair 지원시간 관리</h2>
	</div>
	<br>
	 
	<h3>선택한 잡페어 : ${jobfair_info.fap_jobfair_title}</h3>
	<br>
	잡페어 세부 : 
	<select id="jobfair_divide_select_box" onchange="angular.element(this).scope().select_change()">
		
	</select>
	<hr>
	<h4>최초허가</h4>
	<table class="table table-hover">
		<thead>
			<tr>
				<th><span>No</span></th>
				<th><span>지원시간관리 시퀀스</span></th>				
				<th><span>시작일</span></th>
				<th><span>종료일</span></th>
				<th><span>지원시간명</span></th>
				<th><span>구분</span></th>
				<th><span>룰 적용 여부</span></th>
			</tr>
		</thead>
		<tbody id="table_body_first">

		</tbody>
	</table>
	<br>
	<hr>
	<h3>추가허가</h3>
	<input class="form-control" type="text" id="search_keyword" placeholder="검색어">
	<table id="searched_table" class="table table-hover">
		<thead>
			<tr>
				<th><span>No</span></th>
				<th><span>지원시간관리 시퀀스</span></th>
				<th><span>시작일</span></th>
				<th><span>종료일</span></th>
				<th><span>지원시간명</span></th>
				<th><span>구분</span></th>
				<th><span>룰 적용 여부</span></th>
				<th><span>비고</span>
			</tr>
		</thead>
		<tbody id="table_body">
				
		</tbody>
	</table>	
	
	<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#insert_modal" id="insert_modal_btn" style="display: none">
    	지원가능시간 추가
	</button>
	<span id="insert_modal_btn_dtl">
	</span>
	
	<!-- 등록 Modal -->
	<div class="modal" id="insert_modal">
		<div class="modal-dialog">
		 	<div class="modal-content">
		
				<!-- Modal Header -->
				<div class="modal-header">
					<h4 class="modal-title">지원가능시간 등록</h4>
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
								<label>추가지원</label>
							</div>
							<div class="form-group col-sm-1">
								<input type="radio" value="D0301" name="fap_jobfair_applicable_time_first" class="form-control">
							</div>&nbsp;&nbsp;
							<div class="form-group col-sm-2">
								<label>일정 명칭</label>
							</div>
							<div class="form-group col-sm-3">									
								<input type="text"  id="fap_jobfair_applicable_time_nm" name="fap_jobfair_applicable_time_nm" value="" style="width: 100px;">
							</div>
						</div>
						
						<div class="form-row">
							<label>지원가능시간</label>
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
					
					<button type="button" class="btn btn-primary" onclick="insert()">등록</button>
					<button type="button" class="btn btn-danger" data-dismiss="modal">닫기</button>
				</div>
			      
			</div>
		</div>
	</div>
	
	
	<!-- 수정 Modal -->
	<div class="modal" id="update_modal">
		<div class="modal-dialog">
		 	<div class="modal-content">
		
				<!-- Modal Header -->
				<div class="modal-header">
					<h4 class="modal-title">지원가능시간 수정</h4>
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
								<label>추가지원</label>
							</div>
							<div class="form-group col-sm-1">
								<input type="radio" value="D0301" name="fap_jobfair_applicable_time_first" class="form-control" id="update_D0301">
							</div>
							<div class="form-group col-sm-2">
								<label>일정 명칭</label>
							</div>
							<div class="form-group col-sm-3">									
								<input type="text" name="fap_jobfair_applicable_time_nm" id="fap_jobfair_applicable_time_nm_update" value="" style="width: 100px;">
							</div>
						</div>
						
						<div class="form-row">
							<label>지원가능시간</label>
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
					<button type="button" class="btn btn-primary" onclick="update()">수정</button>
					<button type="button" class="btn btn-danger" data-dismiss="modal">닫기</button>
				</div>
			      
			</div>
		</div>
	</div>
	
	
</body>
</html>
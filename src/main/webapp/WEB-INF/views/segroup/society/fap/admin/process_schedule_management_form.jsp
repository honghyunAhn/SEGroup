<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">	
	<link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
	<script src="<c:url value="/resources/segroup/js/jquery-3.1.1.js" />"></script>
	<script src="<c:url value="/resources/segroup/js/jquery-ui.js" />"></script>
	<script src="<c:url value="/resources/segroup/js/angular.min.js" />"></script>
	<script src="<c:url value="/resources/segroup/js/datepicker.js" />"></script>	
	<script src="<c:url value="/resources/segroup/js/jquery.timepicker.min.js" />"></script>
	<link rel="stylesheet" href="/resources/segroup/css/jquery.timepicker.css">
	<!-- modal을 위한 bootstrap 시작-->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>

	<!--  modal을 위한 bootstrap 끝 -->	
	<title>Bridge Job Fair</title>
	<style>
		.x_icon{
		display:none;
		}
	</style>
	<script type="text/javascript">
		$(function() {
					
			cleanDatepicker();
			var setting = {
			        'minTime' : '00:00am',
			        'maxTime' : '23:55pm', 
			        'timeFormat' : 'H:i',
			        'step' : 5
			}
			
			minMax("fap_job_review_date_st" , "fap_job_review_date_et");
			minMaxTime("fap_job_review_time_st", "23:55pm", setting);
			minMaxTime("00:00am", "fap_job_review_time_et", setting);	
			minMax("fap_job_exam_date_st" , "fap_job_exam_date_et");
			minMaxTime("fap_job_exam_time_st", "23:55pm", setting);	
			minMaxTime("00:00am", "fap_job_exam_time_et", setting);
			minMax("fap_job_itv_date_st" , "fap_job_itv_date_et");
			minMaxTime("fap_job_itv_time_st", "23:55pm", setting);	
			minMaxTime("00:00am", "fap_job_itv_time_et", setting);			
			minMax("fap_job_test_etc_date_st" , "fap_job_test_etc_date_et");
			minMaxTime("fap_job_test_etc_time_st", "23:55pm", setting);	
			minMaxTime("00:00am", "fap_job_test_etc_time_et", setting);	
			
			
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
		
		myApp.controller('ScheduleSetController', ['$scope','$compile','$http','$timeout', function($scope,$compile,$http,$timeout){
			
			var fap_jobfair_seq = "${fap_jobfair_seq}";
			var fap_jobfair_divide_seq = "${fap_jobfair_divide_seq}";
			var fap_job_recruit_pcs_sch_ck = "${fap_job_recruit_pcs_sch_ck}";
			var comp_nm = "${comp_nm}";
			$scope.fap_jobfair_divide_seq = fap_jobfair_divide_seq;
			$scope.fap_job_recruit_pcs_sch_ck = fap_job_recruit_pcs_sch_ck;
			$scope.comp_nm = comp_nm;
			
			//설정후 재검색
			if(fap_jobfair_seq != 0 || fap_jobfair_divide_seq != 0 || fap_job_recruit_pcs_sch_ck != "" || comp_nm != ""){
				if(fap_jobfair_seq != 0){
					//jobfair_divide 활성화
					$("#jobfair_divide_hidden").prop("selected", true);
					$("#select_jobfair_divide").html("<option value=\'"+0+"\' id=\"jobfair_divide_hidden\" seq=\'"+0+"\'  hidden>선택</option>");
					$("#select_jobfair_divide").attr("disabled", false);
					
					$http({
						method : 'POST',
						url : '/fap/admin/select_jobfair_divide',
						responseType : 'text',
						params : {
							fap_jobfair_seq: $("#select_jobfair option:selected").val()
						}
					}).then(function successCallback(response) {
						//jobfair_divide에 option 추가
						for(var i in response.data){
							$("#select_jobfair_divide").append($compile("<option selectcode value=" 
									+ response.data[i].fap_jobfair_divide_gb + " seq=\"" + response.data[i].fap_jobfair_divide_seq + "\"></option>")($scope));
						}
						//잡페어 세부 선택
						for(var i in response.data){
							if(fap_jobfair_divide_seq == response.data[i].fap_jobfair_divide_seq){
								$('#select_jobfair_divide option[seq='+fap_jobfair_divide_seq+']').attr("selected", "selected");
							}
						}
						
					}, function errorCallback(response) {
						
					});
				}
				
				//채용공고 검색
				 $http({
					method: 'POST',
					url: "/fap/admin/job_ad_info_search",
					params : {
						fap_jobfair_seq : fap_jobfair_seq
						, fap_jobfair_divide_seq : fap_jobfair_divide_seq
						, fap_job_recruit_pcs_sch_ck : fap_job_recruit_pcs_sch_ck
						, comp_nm : comp_nm
					}
				}).then(function successCallback(response) {
					 $scope.job_ad = response.data;
					 
					//채용전형 검색
					 $http({
							method: 'POST',
							url: "/fap/admin/recruit_process_info_search",
							params : {
								fap_jobfair_seq : fap_jobfair_seq
								, fap_jobfair_divide_seq : fap_jobfair_divide_seq
								, fap_job_recruit_pcs_sch_ck : fap_job_recruit_pcs_sch_ck
								, comp_nm : comp_nm
							}
						}).then(function successCallback(results) {
							 $scope.recruit_pcs = results.data;
							 
							 if(results.data.length > 0){
								 $scope.result_draw(results);
							 }else{
								 $scope.no_results_draw();
							 }
						}, function errorCallback(response) {
							
						});
					 
				}, function errorCallback(response) {
					
				});
				
				//채용공고, 채용전형 정보 검색결과
				$scope.result_draw = function(){				
					
					var context = '';				
					context += '<tr ng-repeat="ad in job_ad">';
					context += '<td>{{ad.fap_job_ad_title}}</td>';
					context += '<td>{{ad.fap_comp_en_nm}}</td>';
					context += '<td>';
					context += '	<span ng-repeat="pcs in recruit_pcs">';
					context += '<span ng-if="ad.fap_job_ad_seq == pcs.fap_job_ad_seq && pcs.fap_job_recruit_pcs_gb == \'C2500\' ">';
					context += '<code value="C2500" ng-click="reviewPcs(pcs.fap_job_recruit_pcs_seq)" id={{pcs.fap_job_recruit_pcs_seq}}></code> &emsp; >> &emsp;';
					context += '</span>';
					context += '<span ng-if="ad.fap_job_ad_seq == pcs.fap_job_ad_seq && pcs.fap_job_recruit_pcs_gb == \'C2501\' ">';
					context += '<code value="C2501" ng-click="examPcs(pcs.fap_job_recruit_pcs_seq)" id={{pcs.fap_job_recruit_pcs_seq}}></code> &emsp; >> &emsp;';
					context += '</span>';
					context += '<span ng-if="ad.fap_job_ad_seq == pcs.fap_job_ad_seq && pcs.fap_job_recruit_pcs_gb == \'C2502\' ">';
					context += '<code value="C2502" ng-click="itvPcs(pcs.fap_job_recruit_pcs_seq)" id={{pcs.fap_job_recruit_pcs_seq}}></code> &emsp; >> &emsp;';
					context += '</span>';
					context += '<span ng-if="ad.fap_job_ad_seq == pcs.fap_job_ad_seq && pcs.fap_job_recruit_pcs_gb == \'C2503\' ">';
					context += '<code value="C2503" ng-click="testEtcPcs(pcs.fap_job_recruit_pcs_seq)" id={{pcs.fap_job_recruit_pcs_seq}}></code> &emsp; >> &emsp;';
					context += '</span>';
					context += '<span ng-if="ad.fap_job_ad_seq == pcs.fap_job_ad_seq && pcs.fap_job_recruit_pcs_gb == \'C2504\' ">';
					context += '<code value="C2504" id={{pcs.fap_job_recruit_pcs_seq}}></code>   &emsp; >> &emsp;';
					context += '</span>';
					context += '</span>';
					context += '</td>';
					context += '</tr>';
					
					$("#search_data").html($compile(context)($scope));		
					
				}
				
				//검색 결과 없을 시 초기화
				$scope.no_results_draw = function(){	
					var context = '';
					$("#search_data").html($compile(context)($scope));
				}
				
			}
			
			//검색창 변경
			$scope.select_change = function(flag){
				
				if(flag == 1){
					//jobfair_divide 활성화
					if($("#select_jobfair option:selected").val() != 0 ){
						$("#jobfair_divide_hidden").prop("selected", true);
						$("#select_jobfair_divide").html("<option value=\'"+0+"\' id=\"jobfair_divide_hidden\" seq=\"" + 0 + "\"  hidden>선택</option>");					
						$("#select_jobfair_divide").attr("disabled", false);	
					}else{
						$("#jobfair_divide_hidden").prop("selected", true);
						$("#select_jobfair_divide").html("<option value=\'"+0+"\' id=\"jobfair_divide_hidden\" seq=\"" + 0 + "\"  hidden>선택불가</option>");					
						$("#select_jobfair_divide").attr("disabled", true);	
					}				
				
					$http({
						method : 'POST',
						url : '/fap/admin/select_jobfair_divide',
						responseType : 'text',
						params : {
							fap_jobfair_seq: $("#select_jobfair option:selected").val()
						}
					}).then(function successCallback(response) {
						//jobfair_divide에 option 추가
						for(var i in response.data){
							$("#select_jobfair_divide").append($compile("<option selectcode value=" 
									+ response.data[i].fap_jobfair_divide_gb + " seq=\"" + response.data[i].fap_jobfair_divide_seq + "\"></option>")($scope));
						}					
						
					}, function errorCallback(response) {
					
					});					
				}				
						
			//채용공고 검색
			 $http({
				method: 'POST',
				url: "/fap/admin/job_ad_info_search",
				params : {
					fap_jobfair_seq : $('#select_jobfair').val()
					, fap_jobfair_divide_seq : $('#select_jobfair_divide option:selected').attr('seq')
					, fap_job_recruit_pcs_sch_ck : $('#setSelect').val()
					, comp_nm : $('#searchCompNm').val()
				}
			}).then(function successCallback(response) {
				 $scope.job_ad = response.data;
				 
				//채용전형 검색
				 $http({
						method: 'POST',
						url: "/fap/admin/recruit_process_info_search",
						params : {
							fap_jobfair_seq : $('#select_jobfair').val()
							, fap_jobfair_divide_seq : $('#select_jobfair_divide option:selected').attr('seq')
							, fap_job_recruit_pcs_sch_ck : $('#setSelect').val()
							, comp_nm : $('#searchCompNm').val()
						}
					}).then(function successCallback(results) {
						$scope.jobfair_seq = $('#select_jobfair').val();
						 $scope.recruit_pcs = results.data;
						 
						 if(results.data.length > 0){
							 $scope.result_draw(results);
						 }else{
							 $scope.no_results_draw();
						 }
						 
					}, function errorCallback(response) {
					
					});
				 
			}, function errorCallback(response) {
			
			});
			
			//채용공고, 채용전형 정보 검색결과
			$scope.result_draw = function(){				
				
				var context = '';				
				context += '<tr ng-repeat="ad in job_ad">';
				context += '<td>{{ad.fap_job_ad_title}}</td>';
				context += '<td>{{ad.fap_comp_en_nm}}</td>';
				context += '<td>';
				context += '	<span ng-repeat="pcs in recruit_pcs">';
				context += '<span ng-if="ad.fap_job_ad_seq == pcs.fap_job_ad_seq && pcs.fap_job_recruit_pcs_gb == \'C2500\' ">';
				context += '<code value="C2500" ng-click="reviewPcs(pcs.fap_job_recruit_pcs_seq)" id={{pcs.fap_job_recruit_pcs_seq}}></code> &emsp; >> &emsp;';
				context += '</span>';
				context += '<span ng-if="ad.fap_job_ad_seq == pcs.fap_job_ad_seq && pcs.fap_job_recruit_pcs_gb == \'C2501\' ">';
				context += '<code value="C2501" ng-click="examPcs(pcs.fap_job_recruit_pcs_seq)" id={{pcs.fap_job_recruit_pcs_seq}}></code> &emsp; >> &emsp;';
				context += '</span>';
				context += '<span ng-if="ad.fap_job_ad_seq == pcs.fap_job_ad_seq && pcs.fap_job_recruit_pcs_gb == \'C2502\' ">';
				context += '<code value="C2502" ng-click="itvPcs(pcs.fap_job_recruit_pcs_seq)" id={{pcs.fap_job_recruit_pcs_seq}}></code> &emsp; >> &emsp;';
				context += '</span>';
				context += '<span ng-if="ad.fap_job_ad_seq == pcs.fap_job_ad_seq && pcs.fap_job_recruit_pcs_gb == \'C2503\' ">';
				context += '<code value="C2503" ng-click="testEtcPcs(pcs.fap_job_recruit_pcs_seq)" id={{pcs.fap_job_recruit_pcs_seq}}></code> &emsp; >> &emsp;';
				context += '</span>';
				context += '<span ng-if="ad.fap_job_ad_seq == pcs.fap_job_ad_seq && pcs.fap_job_recruit_pcs_gb == \'C2504\' ">';
				context += '<code value="C2504" id={{pcs.fap_job_recruit_pcs_seq}}></code>   &emsp; >> &emsp;';
				context += '</span>';
				context += '</span>';
				context += '</td>';
				context += '</tr>';
				
				$("#search_data").html($compile(context)($scope));		
				
			}
			
			//검색 결과 없을 시 초기화
			$scope.no_results_draw = function(){	
				var context = '';
				$("#search_data").html($compile(context)($scope));
			}
		}
		//검색 종료	
		
		//설정할 서류전형 검색
		$scope.reviewPcs = function(fap_job_recruit_pcs_seq){
			$http({
				method: 'POST',
				url: "/fap/admin/review_process_select",
				params : {
					fap_job_recruit_pcs_seq : fap_job_recruit_pcs_seq
				}
			}).then(function successCallback(reviewResponse) {
				$scope.review = reviewResponse.data;
				
				//서류전형 시작일
				if(reviewResponse.data.fap_job_recruit_pcs_sch_st != null){
					var st = reviewResponse.data.fap_job_recruit_pcs_sch_st.split(" ");
					$(".modal-body #fap_job_review_date_st").val(st[0]);
					$(".modal-body #fap_job_review_time_st").val(st[1]);
				}
				//서류전형 종료일
				if(reviewResponse.data.fap_job_recruit_pcs_sch_et != null){
					var et = reviewResponse.data.fap_job_recruit_pcs_sch_et.split(" ");					
					$(".modal-body #fap_job_review_date_et").val(et[0]);
					$(".modal-body #fap_job_review_time_et").val(et[1]);
				}							
				//서류전형 색상지정
				if(reviewResponse.data.fap_job_recruit_pcs_sch_color != null){
					$scope.color(reviewResponse.data);	
				}else{
					$(".modal-body .colorSelect").val('');
					$(".modal-body .colorSelect").attr("style", "background-color : #ffffff");					
				}				
				//검색 키워드
				$scope.keyword();												
				//서류전형 모달창
				$("#reviewModal").modal();
				
			}, function errorCallback(reviewResponse) {
			
			});
		}
		
		//설정할 시험전형 검색
		$scope.examPcs = function(fap_job_recruit_pcs_seq){
			$http({
				method: 'POST',
				url: "/fap/admin/exam_process_select",
				params : {
					fap_job_recruit_pcs_seq : fap_job_recruit_pcs_seq
				}
			}).then(function successCallback(examResponse) {
				console.log(examResponse);
				$scope.exam = examResponse.data;
				//첨부파일 있을경우 삭제 아이콘 
				var fap_job_exam_file_saved = examResponse.data.fap_job_exam_file_saved;				 
				if(fap_job_exam_file_saved!=null){
					$(".x_icon").show();
				}
				var fap_job_exam_file_seq = examResponse.data.fap_job_exam_file_seq;
				if(fap_job_exam_file_seq != null || fap_job_exam_file_seq!=0 ){
					$("#fap_job_exam_file_seq").val(fap_job_exam_file_seq);
				}
				
				//시험전형 시작일
				if(examResponse.data.fap_job_recruit_pcs_sch_st != null){
					var st = examResponse.data.fap_job_recruit_pcs_sch_st.split(" ");
					$(".modal-body #fap_job_exam_date_st").val(st[0]);
					$(".modal-body #fap_job_exam_time_st").val(st[1]);
				}
				//시험전형 종료일
				if(examResponse.data.fap_job_recruit_pcs_sch_et != null){
					var et = examResponse.data.fap_job_recruit_pcs_sch_et.split(" ");
					$(".modal-body #fap_job_exam_date_et").val(et[0]);
					$(".modal-body #fap_job_exam_time_et").val(et[1]);
				}
				//시험전형 색상
				if(examResponse.data.fap_job_recruit_pcs_sch_color != null){
					$scope.color(examResponse.data);	
				}else{
					$(".modal-body .colorSelect").val('');
					$(".modal-body .colorSelect").attr("style", "background-color : #ffffff");
				}				
				//검색 키워드
				$scope.keyword();								
				//시험전형 모달창
				$("#examModal").modal();
				
				$timeout(function() {
					
					$.each($(".fap_job_exam_type_gb"), function(index, item){
						var cd = $(this).attr("cd");
						var context = '<code value="'+cd+'"></code>';
						$(this).html(context);
					})

					$compile(".fap_job_exam_type_gb")($scope);
				
				}, 0);
				
			}, function errorCallback(examResponse) {
			
			});
		}
		
		//설정할 면접전형 검색
		$scope.itvPcs = function(fap_job_recruit_pcs_seq){
			$http({
				method: 'POST',
				url: '/fap/admin/interview_process_select',
				params: {
					fap_job_recruit_pcs_seq : fap_job_recruit_pcs_seq
				}
			}).then(function successCallback(itvResponse){
				$scope.itv = itvResponse.data;
				
				//면접전형 종료일
				if(itvResponse.data.fap_job_recruit_pcs_sch_st != null){
					var st = itvResponse.data.fap_job_recruit_pcs_sch_st.split(" ");
					$(".modal-body #fap_job_itv_date_st").val(st[0]);
					$(".modal-body #fap_job_itv_time_st").val(st[1]);	
				}
				//면접전형 종료일
				if(itvResponse.data.fap_job_recruit_pcs_sch_et != null){
					var et = itvResponse.data.fap_job_recruit_pcs_sch_et.split(" ");
					$(".modal-body #fap_job_itv_date_et").val(et[0]);
					$(".modal-body #fap_job_itv_time_et").val(et[1]);	
				}
				//면접전형 색상
				if(itvResponse.data.fap_job_recruit_pcs_sch_color != null){
					$scope.color(itvResponse.data);
				}else{
					$(".modal-body .colorSelect").val('');
					$(".modal-body .colorSelect").attr("style", "background-color : #ffffff");
				}				
				//검색 키워드
				$scope.keyword();				
				//면접전형 모달창
				$("#itvModal").modal();
				
			}, function errorCallback(itvResponse){
			
			});
		}
		
		//설정할 기타전형 검색
		$scope.testEtcPcs = function(fap_job_recruit_pcs_seq){
			$http({
				method: 'POST',
				url: '/fap/admin/test_etc_process_select',
				params: {
					fap_job_recruit_pcs_seq : fap_job_recruit_pcs_seq
				}
			}).then(function successCallback(testEtcResponse){
				$scope.etc = testEtcResponse.data;
				
				//기타전형 시작일
				if(testEtcResponse.data.fap_job_recruit_pcs_sch_st != null){
					var st = testEtcResponse.data.fap_job_recruit_pcs_sch_st.split(" ");
					$(".modal-body #fap_job_test_etc_date_st").val(st[0]);
					$(".modal-body #fap_job_test_etc_time_st").val(st[1]);
				}
				//기타전형 종료일
				if(testEtcResponse.data.fap_job_recruit_pcs_sch_et != null){
					var et = testEtcResponse.data.fap_job_recruit_pcs_sch_et.split(" ");
					$(".modal-body #fap_job_test_etc_date_et").val(et[0]);
					$(".modal-body #fap_job_test_etc_time_et").val(et[1]);
				}
				//기타전형 색상
				if(testEtcResponse.data.fap_job_recruit_pcs_sch_color != null){
					$scope.color(testEtcResponse.data);
				}else{
					$(".modal-body .colorSelect").val('');
					$(".modal-body .colorSelect").attr("style", "background-color : #ffffff");
				}				
				//검색 키워드
				$scope.keyword();				
				//기타전형 모달창
				$("#testEtcModal").modal();
				
			}, function errorCallback(testEtcResponse){
			
			});
		}
		
		//검색 키워드 전달
		$scope.keyword = function(){
			$(".modal-body .fap_jobfair_seq").val($('#select_jobfair').val());
			$(".modal-body .fap_jobfair_divide_seq").val($('#select_jobfair_divide option:selected').attr('seq'));
			$(".modal-body .fap_job_recruit_pcs_sch_ck").val($('#setSelect').val());
			$(".modal-body .comp_nm").val($('#searchCompNm').val());
		}
		
		//색상 지정
		$scope.color = function(color){
			 if(color.fap_job_recruit_pcs_sch_color == "C4600") {
				 $(".modal-body .colorSelect").attr("style", "background-color : #ed090d");
            }else if(color.fap_job_recruit_pcs_sch_color == "C4601") {
            	$(".modal-body .colorSelect").attr("style", "background-color : #ff6100");
            }else if(color.fap_job_recruit_pcs_sch_color == "C4602") {
            	$(".modal-body .colorSelect").attr("style", "background-color : #fcfc80");
            }else if(color.fap_job_recruit_pcs_sch_color == "C4603") {
            	$(".modal-body .colorSelect").attr("style", "background-color : #abfc80");
            }else if(color.fap_job_recruit_pcs_sch_color == "C4604") {
            	$(".modal-body .colorSelect").attr("style", "background-color : #8cf7f0");
            }else if(color.fap_job_recruit_pcs_sch_color == "C4605") {
            	$(".modal-body .colorSelect").attr("style", "background-color : #3b41ed");
            }else if(color.fap_job_recruit_pcs_sch_color == "C4606") {
            	$(".modal-body .colorSelect").attr("style", "background-color : #8716e2");
            }else if(color.fap_job_recruit_pcs_sch_color == "C4607") {
            	$(".modal-body .colorSelect").attr("style", "background-color : #fcb0b9");
            }else if(color.fap_job_recruit_pcs_sch_color == "C4608") {
            	$(".modal-body .colorSelect").attr("style", "background-color : #c1bfc0");
            }else{
            	$(".modal-body .colorSelect").attr("style", "background-color : #ffffff");
            }
		}		
		
		
		//첨부파일 삭제
		$scope.deleteFile = function( ){			 
			    var fap_job_exam_file_saved = $("input[name=fap_job_exam_file_saved]").val();			 
				$(".uploadedFile").remove();
				
				$.ajax({
					beforeSend: function(xhr) {
					     xhr.setRequestHeader("AJAX", true);
					}
					, type : "POST"
					, url : "/fap/admin/delete_job_exam_file_uploaded"
					, data : {fap_job_exam_file_saved : fap_job_exam_file_saved}
					, success : function(data) {
			
					},
					error : function(e) {
						console.log(e);						 
					}
				});				
			}
			
			
		
		}]);		
		
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
				
	</script>
	<script type="text/javascript">
		//색상 변경
		$(document).ready(function(){
	        $(".colorSelect").change(function(){
	            if($(this).val()=="C4600") {
	            	$(this).attr("style", "background-color : #ed090d");
	            }else if($(this).val()=="C4601") {
	            	$(this).attr("style", "background-color : #ff6100");
	            }else if($(this).val()=="C4602") {
	            	$(this).attr("style", "background-color : #fcfc80");;
	            }else if($(this).val()=="C4603") {
	            	$(this).attr("style", "background-color : #abfc80");;
	            }else if($(this).val()=="C4604") {
	            	$(this).attr("style", "background-color : #8cf7f0");;
	            }else if($(this).val()=="C4605") {
	            	$(this).attr("style", "background-color : #3b41ed");;
	            }else if($(this).val()=="C4606") {
	            	$(this).attr("style", "background-color : #8716e2");;
	            }else if($(this).val()=="C4607") {
	            	$(this).attr("style", "background-color : #fcb0b9");;
	            }else if($(this).val()=="C4608") {
	            	$(this).attr("style", "background-color : #c1bfc0");;
	            }else{
	            	$(this).attr("style", "background-color : #ffffff");;
	            }
	        });
	    });
		
		//유효성 검사
		function review_form_check() {			
			//서류전형
			if($('#fap_job_review_date_st').val() == null || $('#fap_job_review_date_st').val() == ''){
				alert('서류전형 시작일을 설정하세요.');
				return false;
			}
			if($('#fap_job_review_date_et').val() == null || $('#fap_job_review_date_et').val() == ''){
				alert('서류전형 종료일을 설정하세요.');
				return false;
			}
			if($('#fap_job_review_time_st').val() == null || $('#fap_job_review_time_st').val() == ''){
				alert('서류전형 시작시간을 설정하세요.');
				return false;
			}
			if($('#fap_job_review_time_et').val() == null || $('#fap_job_review_time_et').val() == ''){
				alert('서류전형 종료시간을 설정하세요.');
				return false;
			}
			if($('#fap_job_review_pcs_sch_color').val() == null || $('#fap_job_review_pcs_sch_color').val() == ''){
				alert('서류전형 표시 색상을 설정하세요.');
				return false;
			}
		}	
		function exam_form_check() {		
			//시험전형
			if($('#fap_job_exam_date_st').val() == null || $('#fap_job_exam_date_st').val() == ''){
				alert('시험전형 시작일을 설정하세요.');
				return false;
			}
			if($('#fap_job_exam_date_et').val() == null || $('#fap_job_exam_date_et').val() == ''){
				alert('시험전형 종료일을 설정하세요.');
				return false;
			}
			if($('#fap_job_exam_time_st').val() == null || $('#fap_job_exam_time_st').val() == ''){
				alert('시험전형 시작 시간을 설정하세요.');
				return false;
			}
			if($('#fap_job_exam_time_et').val() == null || $('#fap_job_exam_time_et').val() == ''){
				alert('시험전형 종료 시간을 설정하세요.');
				return false;
			}
			if($('#fap_job_exam_pcs_sch_lo').val() == null || $('#fap_job_exam_pcs_sch_lo').val() == ''){
				alert('시험전형 장소를 설정하세요.');
				return false;
			}
			if($('#fap_job_exam_pcs_sch_color').val() == null || $('#fap_job_exam_pcs_sch_color').val() == ''){
				alert('시험전형 표시 색상을 설정하세요.');
				return false;
			}
		}
		function itv_form_check() {	
			//면접전형
			if($('#fap_job_itv_date_st').val() == null || $('#fap_job_itv_date_st').val() == ''){
				alert('면접전형 시작일을 설정하세요.');
				return false;
			}
			if($('#fap_job_itv_date_et').val() == null || $('#fap_job_itv_date_et').val() == ''){
				alert('면접전형 종료일을 설정하세요.');
				return false;
			}
			if($('#fap_job_itv_time_st').val() == null || $('#fap_job_itv_time_st').val() == ''){
				alert('면접전형 시작 시간을 설정하세요.');
				return false;
			}
			if($('#fap_job_itv_time_et').val() == null || $('#fap_job_itv_time_et').val() == ''){
				alert('면접전형 종료 시간을 설정하세요.');
				return false;
			}
			if($('#fap_job_itv_pcs_sch_lo').val() == null || $('#fap_job_itv_pcs_sch_lo').val() == ''){
				alert('면접 장소를 설정하세요.');
				return false;
			}
			if($('#fap_job_itv_pcs_sch_waitingroom').val() == null || $('#fap_job_itv_pcs_sch_waitingroom').val() == ''){
				alert('대기실을 설정하세요.');
				return false;
			}			
			if($('#fap_job_itv_pcs_sch_color').val() == null || $('#fap_job_itv_pcs_sch_color').val() == ''){
				alert('면접전형 표시 색상을 설정하세요.');
				return false;
			}
		}
		function test_etc_form_check() {	
			//기타전형
			if($('#fap_job_test_etc_date_st').val() == null || $('#fap_job_test_etc_date_st').val() == ''){
				alert('기타전형 시작일을 설정하세요.');
				return false;
			}
			if($('#fap_job_test_etc_date_et').val() == null || $('#fap_job_test_etc_date_et').val() == ''){
				alert('기타전형 종료일을 설정하세요.');
				return false;
			}
			if($('#fap_job_test_etc_time_st').val() == null || $('#fap_job_test_etc_time_st').val() == ''){
				alert('기타전형 시작 시간을 설정하세요.');
				return false;
			}
			if($('#fap_job_test_etc_time_et').val() == null || $('#fap_job_test_etc_time_et').val() == ''){
				alert('기타전형 종료 시간을 설정하세요.');
				return false;
			}
			if($('#fap_job_test_etc_pcs_sch_lo').val() == null || $('#fap_job_test_etc_pcs_sch_lo').val() == ''){
				alert('기타전형 장소를 설정하세요.');
				return false;
			}
			if($('#fap_job_test_etc_pcs_sch_color').val() == null || $('#fap_job_test_etc_pcs_sch_color').val() == ''){
				alert('기타전형 표시 색상을 설정하세요.');
				return false;
			}
		}
	</script>
	<style type="text/css">
	.fap_job_exam_type_gb{
		border: 1px solid #888;
		padding: 5px;
		margin-bottom: 10px;
		margin-right: 5px;
	}
	</style>
</head>
<body id="myBody" ng-app="myapp" ng-controller="ScheduleSetController">
<%@include file="admin_menu.jsp"%>
	<br>
	<div class="page_title">
		<h2>채용전형 일정관리</h2>
	</div>
	<br>
	<div class="search_div">
		<table class="search_table">
			<tr>
				<th>잡페어명으로 검색</th>	
				<td>
					<select onchange="angular.element(this).scope().select_change(1)" id="select_jobfair">
						<option value="0" >선택</option>
						<optgroup label="진행중인 잡페어" flag="1">
							<c:forEach var="jobfair" items="${jobfair_map.jobfair_list_now}">
								<option value="${jobfair.fap_jobfair_seq}" <c:if test="${fap_jobfair_seq == jobfair.fap_jobfair_seq}">selected</c:if>>${jobfair.fap_jobfair_title}</option>
							</c:forEach>
						</optgroup>
						<optgroup label="예정된 잡페어" flag="2">
							<c:forEach var="jobfair" items="${jobfair_map.jobfair_list_before}">
								<option value="${jobfair.fap_jobfair_seq}" <c:if test="${fap_jobfair_seq == jobfair.fap_jobfair_seq}">selected</c:if>>${jobfair.fap_jobfair_title}</option>
							</c:forEach>
						</optgroup>						
					</select>
				</td>			
			</tr>
			<tr>
				<th>잡페어 세부로 검색</th>	
				<td>
					<select onchange="angular.element(this).scope().select_change()" id="select_jobfair_divide" disabled="disabled">
						<option value="0" id="jobfair_divide_hidden" seq="0" hidden>선택 불가</option>						
					</select>
				</td>
			<tr>
			<tr>
				<th>설정 여부로 검색</th>	
				<td>
					<select id="setSelect" onchange="angular.element(this).scope().select_change()" ng-model="fap_job_recruit_pcs_sch_ck">
						<option value="">선택</option>
						<option selectcode value="C5000"></option>
						<option selectcode value="C5001"></option>					
					</select>
				</td>
			<tr>
				<th>회사명으로 검색</th>
				<td>
					<input type="text" id="searchCompNm"  ng-model="comp_nm">
				</td>
				<td class="td_search" colspan="2">
					<button type="button" class="btn_search" ng-click="select_change()">검색</button>
				</td>
			</tr>
		</table>				
	
		<br><br>
		
		<table class="table">
			<thead>
				<tr>
					<th style="width: 200px;">채용공고 제목 &emsp;</th>
					<th style="width: 200px;">회사명 &emsp;</th>
					<th>채용전형 &emsp;</th>					
				</tr>
			</thead>
			<tbody id="search_data">
			
			</tbody>
		</table>
	</div>
	
	<!-- 서류전형 일정설정 등록 MODAL 시작-->
	<div class="modal fade" id="reviewModal" tabindex="-1" role="dialog" aria-labelledby="modal" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
			
				<div class="modal-header">
					<h5 class="modal-title" id="modal">서류전형 일정설정</h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				
				<form action="/fap/admin/review_process_schedule_update" method="post" onsubmit="return review_form_check();" enctype="multipart/form-data">
					<div class="modal-body">
						<input type="hidden" name="fap_job_recruit_pcs_sch_seq" value="{{review.fap_job_recruit_pcs_sch_seq}}">
						<input type="hidden" name="fap_job_recruit_pcs_seq" value="{{review.fap_job_recruit_pcs_seq}}">
						<input type="hidden" name="fap_jobfair_seq" class="fap_jobfair_seq" value="0">
						<input type="hidden" name="fap_jobfair_divide_seq" class="fap_jobfair_divide_seq" value="0">
						<input type="hidden" name="fap_job_recruit_pcs_sch_ck" class="fap_job_recruit_pcs_sch_ck" value="">
						<input type="hidden" name="comp_nm" class="comp_nm" value="">
												
						<div class="form-group">
							<div class="form-row">
								<label>서류 전형 시작일</label>
							</div>
							<div class="form-row">
								<input type="text" id="fap_job_review_date_st" name="fap_job_review_date_st">&emsp;
								<input type="text" id="fap_job_review_time_st" name="fap_job_review_time_st">
							</div>		
							<div class="form-row">
								<label>서류 전형 마감일</label>
							</div>
							<div class="form-row">
								<input type="text" id="fap_job_review_date_et" name="fap_job_review_date_et" >&emsp;
								<input type="text" id="fap_job_review_time_et" name="fap_job_review_time_et" >
							</div>							
						</div>
						<div class="form-row">
							<label>제출서류 목록</label>
						</div>
						<div class="form-row">
							<textarea id="fap_job_recruit_pcs_dtl" name="fap_job_recruit_pcs_dtl" class="form-control" maxlength="500" style="width: 490px; height: 100px;" ng-model="review.fap_job_recruit_pcs_dtl"></textarea>
						</div>
						<div class="form-row">
								<label>표시 색상</label>
							</div>
						<div class="form-row">
							<select id="fap_job_review_pcs_sch_color" name="fap_job_recruit_pcs_sch_color" class="colorSelect" ng-model="review.fap_job_recruit_pcs_sch_color">
								<option value="" style="background-color: #ffffff">선택</option>
								<option selectcode value="C4600" style="background-color: #ed090d" ></option>
								<option selectcode value="C4601" style="background-color: #ff6100"></option>
								<option selectcode value="C4602" style="background-color: #fcfc80"></option>
								<option selectcode value="C4603" style="background-color: #abfc80"></option>
								<option selectcode value="C4604" style="background-color: #8cf7f0"></option>
								<option selectcode value="C4605" style="background-color: #3b41ed"></option>
								<option selectcode value="C4606" style="background-color: #8716e2"></option>
								<option selectcode value="C4607" style="background-color: #fcb0b9"></option>
								<option selectcode value="C4608" style="background-color: #c1bfc0"></option>									
							</select>								
						</div>
					</div>
										
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
						<button type="submit" class="btn btn-primary">설정하기</button>
					</div>
					
				</form>
			</div>
		</div>
	</div>
	<!-- 서류전형 일정설정 등록 MODAL 종료-->
	
	<!-- 시험전형 일정설정 등록 MODAL 시작-->
	<div class="modal fade" id="examModal" tabindex="-1" role="dialog" aria-labelledby="modal" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
			
				<div class="modal-header">
					<h5 class="modal-title" id="modal">시험전형 일정설정</h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				
				<form action="/fap/admin/exam_process_schedule_update" method="post" onsubmit="return exam_form_check();" enctype="multipart/form-data">
					<div class="modal-body">
						<input type="hidden" name="fap_job_recruit_pcs_seq" value="{{exam.fap_job_recruit_pcs_seq}}">
						<input type="hidden" name="fap_job_recruit_pcs_sch_seq" value="{{exam.fap_job_recruit_pcs_sch_seq}}">
					    <input type="hidden" name="fap_job_exam_seq" value="{{exam.fap_job_exam_seq}}"> 	 	  	 
						<input type="hidden" name="fap_jobfair_seq" class="fap_jobfair_seq" value="0">
						<input type="hidden" name="fap_jobfair_divide_seq" class="fap_jobfair_divide_seq" value="0">
						<input type="hidden" name="fap_job_recruit_pcs_sch_ck" class="fap_job_recruit_pcs_sch_ck" value="">
						<input type="hidden" name="comp_nm" class="comp_nm" value="">
						 
						<div class="form-group">
							<div class="form-row">
								<label>시험 시작일자</label>&emsp;&emsp;&emsp;&emsp;&emsp;<label>시험 시작시간</label>
							</div>
							<div class="form-row">
								<input type="text" id="fap_job_exam_date_st" name="fap_job_exam_date_st" >&emsp;
								<input type="text" id="fap_job_exam_time_st" name="fap_job_exam_time_st">
							</div>
							<div class="form-row">
								<label>시험 종료일자</label>&emsp;&emsp;&emsp;&emsp;&emsp;<label>시험 종료시간</label>
							</div>
							<div class="form-row">
								<input type="text" id="fap_job_exam_date_et" name="fap_job_exam_date_et">&emsp;
								<input type="text" id="fap_job_exam_time_et" name="fap_job_exam_time_et">
							</div>	
							<div class="form-row">
								<label>시험 장소</label>
							</div>
							<div class="form-row">
								<input type="text" id="fap_job_exam_pcs_sch_lo" name="fap_job_recruit_pcs_sch_lo" value="{{exam.fap_job_recruit_pcs_sch_lo}}" style="width: 490px;">
							</div>	
							<div class="form-row">
								<label>시험 상세내용</label>
							</div>
							<div class="form-row">
								<textarea id="fap_job_exam_pcs_sch_detail" name="fap_job_recruit_pcs_sch_detail" maxlength="500" style="width: 490px; height: 100px;">{{exam.fap_job_recruit_pcs_sch_detail}}</textarea>
							</div>	
							<div class="form-row">
								<label>표시 색상</label>
							</div>
							<div class="form-row">
								<select id="fap_job_exam_pcs_sch_color" name="fap_job_recruit_pcs_sch_color" class="colorSelect" ng-model="exam.fap_job_recruit_pcs_sch_color">
									<option value="" style="background-color: #ffffff">선택</option>
									<option selectcode value="C4600" style="background-color: #ed090d" ></option>
									<option selectcode value="C4601" style="background-color: #ff6100"></option>
									<option selectcode value="C4602" style="background-color: #fcfc80"></option>
									<option selectcode value="C4603" style="background-color: #abfc80"></option>
									<option selectcode value="C4604" style="background-color: #8cf7f0"></option>
									<option selectcode value="C4605" style="background-color: #3b41ed"></option>
									<option selectcode value="C4606" style="background-color: #8716e2"></option>
									<option selectcode value="C4607" style="background-color: #fcb0b9"></option>
									<option selectcode value="C4608" style="background-color: #c1bfc0"></option>									
								</select>								
							</div>					
						</div>	
						
						<div class="form-group">
							<div class="form-row">
								<label>시험 대상자</label>
							</div>
							<div class="form-row">
								<select id="fap_job_exam_obj" name="fap_job_exam_obj" ng-model="exam.fap_job_exam_obj">
									<option selectcode value="C2700"></option>
									<option selectcode value="C2701"></option>
									<option selectcode value="C2702"></option>
								</select>
								&emsp;<input type="text" id="fap_job_exam_obj_etc_dtl" name="fap_job_exam_obj_etc_dtl" value="{{exam.fap_job_exam_obj_etc_dtl}}">					
							</div>
							<div class="form-row">
								<label>시험구분</label>
							</div>
							<div class="form-row">
								<select id="fap_job_exam_gb" name="fap_job_exam_gb" ng-model="exam.fap_job_exam_gb">
									<option selectcode value="C2600"></option>
									<option selectcode value="C2601"></option>
								</select>								
							</div>
							<div class="form-row">
								<label>상세시험 종류</label>
							</div>
							<div class="form-row">
								<div ng-repeat="recruitExam in exam.fapRecruitExamList">
									<div class="fap_job_exam_type_gb" cd="{{recruitExam.fap_job_exam_type_gb}}"></div>
								</div>
								<!-- <select id="fap_job_exam_type_gb" name="fap_job_exam_type_gb" ng-model="exam.fap_job_exam_type_gb">
									<option selectcode value="C3200"></option>
									<option selectcode value="C3201"></option>
									<option selectcode value="C3202"></option>
									<option selectcode value="C3203"></option>
									<option selectcode value="C3204"></option>
									<option selectcode value="C3205"></option>
								</select> -->
							</div>
							<div class="form-row">
								<label>시험 대상자 메일주소 필요여부</label>
							</div>
							<div class="form-row">
								<select id="fap_job_exam_mail" name="fap_job_exam_mail" ng-model="exam.fap_job_exam_mail">
									<option selectcode value="C2800"></option>
									<option selectcode value="C2801"></option>
								</select>								
							</div>
							<div class="form-row">
								<label>소요 시간</label>
							</div>
							<div class="form-row">
								<input type="text" id="fap_job_exam_tm" name="fap_job_exam_tm" value="{{exam.fap_job_exam_tm}}">
							</div>	
							<div class="form-row">
								<label>감독관</label>
							</div>
							<div class="form-row">
								<select id="fap_job_exam_sv" name="fap_job_exam_sv" ng-model="exam.fap_job_exam_sv">
									<option selectcode value="C2900"></option>
									<option selectcode value="C2901"></option>
									<option selectcode value="C2902"></option>
									<option selectcode value="C2903"></option>
								</select>
								&emsp;<input type="text" id="fap_job_exam_sv_etc_dtl" name="fap_job_exam_sv_etc_dtl" value="{{exam.fap_job_exam_sv_etc_dtl}}">								
							</div>
							<div class="form-row">
								<label>준비물</label>
							</div>
							<div class="form-row">
								<select id="fap_job_exam_need" name="fap_job_exam_need" ng-model="exam.fap_job_exam_need">
									<option selectcode value="C3000"></option>
									<option selectcode value="C3001"></option>
									<option selectcode value="C3002"></option>
								</select>
								&emsp;<input type="text" id="fap_job_exam_need_etc_dtl" name="fap_job_exam_need_etc_dtl" value="{{fap_job_exam_need_etc_dtl}}">
							</div>
						</div>
						<div class="form-row">
								<label>시험문제 파일</label>
						</div>
						<div class="form-row">
							<input type="hidden" name="fap_job_exam_file_origin" value="{{exam.fap_job_exam_file_origin}}">
							<input type="hidden" name="fap_job_exam_file_saved" value="{{exam.fap_job_exam_file_saved}}">
							&emsp;<input type="file" name="fap_job_exam_file" id="fap_job_exam_file" src="${path}{{exam.fap_job_exam_file_saved}}" >
							<span class="uploadedFile">
							    <a href="/file_download?origin={{exam.fap_job_exam_file_origin}}&saved={{exam.fap_job_exam_file_saved}}&path=/fap/company/job_recruit_exam_file/" >{{exam.fap_job_exam_file_origin}}</a>  
							    <img class="x_icon" ng-click='deleteFile()' src="<c:url value="/resources/segroup/society/fap/images/main/deletePic.png" />" alt=""  style="height:20px;" />
							</span>
						</div>						
						
						<div class="modal-footer">
							<button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
							<button type="submit" class="btn btn-primary" >설정하기</button>
						</div>
					
					</div>
				</form>
			</div>
		</div>
	</div>
	<!-- 시험전형 일정설정 등록 MODAL 종료-->
	
	<!-- 면접전형 일정설정 등록 MODAL 시작-->
	<div class="modal fade" id="itvModal" tabindex="-1" role="dialog" aria-labelledby="modal" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
			
				<div class="modal-header">
					<h5 class="modal-title" id="modal">면접전형 일정설정</h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				
				<form action="/fap/admin/interview_process_schedule_update" method="post" onsubmit="return itv_form_check();" enctype="multipart/form-data">
					<div class="modal-body">
						<input type="hidden" name="fap_job_recruit_pcs_seq" value="{{itv.fap_job_recruit_pcs_seq}}">
						<input type="hidden" name="fap_job_recruit_pcs_sch_seq" value="{{itv.fap_job_recruit_pcs_sch_seq}}">
						<input type="hidden" name="fap_job_itv_seq" value="{{itv.fap_job_itv_seq}}">
						<input type="hidden" name="fap_jobfair_seq" class="fap_jobfair_seq" value="0">
						<input type="hidden" name="fap_jobfair_divide_seq" class="fap_jobfair_divide_seq" value="0">
						<input type="hidden" name="fap_job_recruit_pcs_sch_ck" class="fap_job_recruit_pcs_sch_ck" value="">
						<input type="hidden" name="comp_nm" class="comp_nm" value="">
						
						<div class="form-group">
							<div class="form-row">
								<label>면접 시작일자</label>&emsp;&emsp;&emsp;&emsp;&emsp;<label>면접 시작시간</label>
							</div>
							<div class="form-row">
								<input type="text" id="fap_job_itv_date_st" name="fap_job_itv_date_st" >&emsp;
								<input type="text" id="fap_job_itv_time_st" name="fap_job_itv_time_st">
							</div>
							<div class="form-row">
								<label>면접 종료일자</label>&emsp;&emsp;&emsp;&emsp;&emsp;<label>면접 종료시간</label>
							</div>
							<div class="form-row">
								<input type="text" id="fap_job_itv_date_et" name="fap_job_itv_date_et">&emsp;
								<input type="text" id="fap_job_itv_time_et" name="fap_job_itv_time_et">
							</div>	
							<div class="form-row">
								<label>면접 장소</label>
							</div>
							<div class="form-row">
								<input type="text" id="fap_job_itv_pcs_sch_lo" name="fap_job_recruit_pcs_sch_lo" style="width:490px;" value="{{itv.fap_job_recruit_pcs_sch_lo}}">
							</div>	
							<div class="form-row">
								<label>대기실</label>
							</div>
							<div class="form-row">
								<input type="text" id="fap_job_itv_pcs_sch_waitingroom" name="fap_job_recruit_pcs_sch_waitingroom" style="width:490px;" value="{{itv.fap_job_recruit_pcs_sch_waitingroom}}">
							</div>	
							<div class="form-row">
								<label>면접 상세내용</label>
							</div>
							<div class="form-row">
								<textarea id="fap_job_itv_pcs_sch_detail" name="fap_job_recruit_pcs_sch_detail" maxlength="500" style="width: 490px; height: 100px;">{{itv.fap_job_recruit_pcs_sch_detail}}</textarea>
							</div>	
							<div class="form-row">
								<label>표시 색상</label>
							</div>
							<div class="form-row">
								<select id="fap_job_itv_pcs_sch_color" name="fap_job_recruit_pcs_sch_color" class="colorSelect" ng-model="itv.fap_job_recruit_pcs_sch_color">
									<option value="" style="background-color: #ffffff">선택</option>
									<option selectcode value="C4600" style="background-color: #ed090d" ></option>
									<option selectcode value="C4601" style="background-color: #ff6100"></option>
									<option selectcode value="C4602" style="background-color: #fcfc80"></option>
									<option selectcode value="C4603" style="background-color: #abfc80"></option>
									<option selectcode value="C4604" style="background-color: #8cf7f0"></option>
									<option selectcode value="C4605" style="background-color: #3b41ed"></option>
									<option selectcode value="C4606" style="background-color: #8716e2"></option>
									<option selectcode value="C4607" style="background-color: #fcb0b9"></option>
									<option selectcode value="C4608" style="background-color: #c1bfc0"></option>									
								</select>									
							</div>					
						</div>						
						
						<div class="form-group">
							<div class="form-row">
								<label>면접 대상자</label>
							</div>
							<div class="form-row">
								<select id="fap_job_itv_obj" name="fap_job_itv_obj" ng-model="itv.fap_job_itv_obj">
									<option selectcode value="C3400"></option>
									<option selectcode value="C3401"></option>
									<option selectcode value="C3402"></option>
									<option selectcode value="C3403"></option>
								</select>
								&emsp;<input type="text" id="fap_job_itv_obj_etc_dtl" name="fap_job_itv_obj_etc_dtl" value="{{itv.fap_job_itv_obj_etc_dtl}}">
							</div>
							<div class="form-row">
								<label>면접 구분</label>
							</div>
							<div class="form-row">
								<select id="fap_job_itv_gb" name="fap_job_itv_gb" ng-model="itv.fap_job_itv_gb">
									<option selectcode value="C3300"></option>
									<option selectcode value="C3301"></option>
								</select>								
							</div>
							<div class="form-row">
								<label>면접 방식</label>
							</div>
							<div class="form-row">
								<select id="fap_job_itv_tp" name="fap_job_itv_tp" ng-model="itv.fap_job_itv_tp">
									<option selectcode value="C3500"></option>
									<option selectcode value="C3501"></option>
									<option selectcode value="C3502"></option>
									<option selectcode value="C3503"></option>
								</select>
								&emsp;<input type="text" id="fap_job_itv_tp_etc_dtl" name="fap_job_itv_tp_etc_dtl" value="{{itv.fap_job_itv_tp_etc_dtl}}">								
							</div>
							<div class="form-row">
								<label>소요 시간</label>
							</div>
							<div class="form-row">
								<input type="text" id="fap_job_itv_tm" name="fap_job_itv_tm" value="{{itv.fap_job_itv_tm}}">
							</div>	
							<div class="form-row">
								<label>면접 상세내용</label>
							</div>
							<div class="form-row">
								<textarea id="fap_job_itv_pcs_dtl" name="fap_job_recruit_pcs_dtl" maxlength="500" style="width: 490px; height: 100px;" placeholder="화상면접인 경우에는 skype 아이디를 입력하세요.">{{itv.fap_job_recruit_pcs_dtl}}</textarea>
							</div>	
						</div>
					</div>
					
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
						<button type="submit" class="btn btn-primary">설정하기</button>
					</div>
					
				</form>
			</div>
		</div>
	</div>
	<!-- 면접전형 일정설정 등록 MODAL 종료-->
	
	<!-- 기타전형 일정설정 등록 MODAL 시작-->
	<div class="modal fade" id="testEtcModal" tabindex="-1" role="dialog" aria-labelledby="modal" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
			
				<div class="modal-header">
					<h5 class="modal-title" id="modal">기타전형 일정설정</h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				
				<form action="/fap/admin/test_etc_process_schedule_update" method="post" onsubmit="return test_etc_form_check();" enctype="multipart/form-data">
					<div class="modal-body">
						<input type="hidden" name="fap_job_recruit_pcs_seq" value="{{etc.fap_job_recruit_pcs_seq}}">
						<input type="hidden" name="fap_job_recruit_pcs_sch_seq" value="{{etc.fap_job_recruit_pcs_sch_seq}}">
						<input type="hidden" name="fap_job_test_etc_seq" value="{{etc.fap_job_test_etc_seq}}">
						<input type="hidden" name="fap_jobfair_seq" class="fap_jobfair_seq" value="0">
						<input type="hidden" name="fap_jobfair_divide_seq" class="fap_jobfair_divide_seq" value="0">
						<input type="hidden" name="fap_job_recruit_pcs_sch_ck" class="fap_job_recruit_pcs_sch_ck" value="">
						<input type="hidden" name="comp_nm" class="comp_nm" value="">
						
						<div class="form-group">
							<div class="form-row">
								<label>기타전형 시작일자</label>&emsp;&emsp;&emsp;<label>기타전형 시작시간</label>
							</div>
							<div class="form-row">
								<input type="text" id="fap_job_test_etc_date_st" name="fap_job_test_etc_date_st" >&emsp;
								<input type="text" id="fap_job_test_etc_time_st" name="fap_job_test_etc_time_st">
							</div>
							<div class="form-row">
								<label>기타전형 종료일자</label>&emsp;&emsp;&emsp;<label>기타전형 종료시간</label>
							</div>
							<div class="form-row">
								<input type="text" id="fap_job_test_etc_date_et" name="fap_job_test_etc_date_et">&emsp;
								<input type="text" id="fap_job_test_etc_time_et" name="fap_job_test_etc_time_et">
							</div>	
							<div class="form-row">
								<label>기타전형 장소</label>
							</div>
							<div class="form-row">
								<input type="text" id="fap_job_test_etc_pcs_sch_lo" name="fap_job_recruit_pcs_sch_lo" style="width: 490px;" value="{{etc.fap_job_recruit_pcs_sch_lo}}">
							</div>
							<div class="form-row">
								<label>기타전형 상세내용</label>
							</div>
							<div class="form-row">
								<textarea id="fap_job_test_etc_pcs_sch_detail" name="fap_job_recruit_pcs_sch_detail" maxlength="500" style="width: 490px; height: 100px;">{{etc.fap_job_recruit_pcs_sch_detail}}</textarea>
							</div>	
							<div class="form-row">
								<label>표시 색상</label>
							</div>
							<div class="form-row">
								<select id="fap_job_test_etc_pcs_sch_color" name="fap_job_recruit_pcs_sch_color" class="colorSelect" ng-model="etc.fap_job_recruit_pcs_sch_color">
									<option value="" style="background-color: #ffffff">선택</option>
									<option selectcode value="C4600" style="background-color: #ed090d" ></option>
									<option selectcode value="C4601" style="background-color: #ff6100"></option>
									<option selectcode value="C4602" style="background-color: #fcfc80"></option>
									<option selectcode value="C4603" style="background-color: #abfc80"></option>
									<option selectcode value="C4604" style="background-color: #8cf7f0"></option>
									<option selectcode value="C4605" style="background-color: #3b41ed"></option>
									<option selectcode value="C4606" style="background-color: #8716e2"></option>
									<option selectcode value="C4607" style="background-color: #fcb0b9"></option>
									<option selectcode value="C4608" style="background-color: #c1bfc0"></option>									
								</select>									
							</div>	
						</div>						
						
						<div class="form-group">
							<div class="form-row">
								<label>기타전형 대상자</label>
							</div>
							<div class="form-row">
								<select id="fap_job_test_etc_obj" name="fap_job_test_etc_obj" ng-model="etc.fap_job_test_etc_obj">
									<option selectcode value="C3600"></option>
									<option selectcode value="C3601"></option>
									<option selectcode value="C3602"></option>
									<option selectcode value="C3603"></option>
								</select>
								&emsp;<input type="text" id="fap_job_test_etc_obj_dtl" name="fap_job_test_etc_obj_dtl" value="{{etc.fap_job_test_etc_obj_dtl}}">
							</div>
							<div class="form-row">
								<label>기타전형 상세내용</label>
							</div>
							<div class="form-row">
								<textarea id="fap_job_test_etc_dtl" name="fap_job_test_etc_dtl" maxlength="500" style="width: 490px; height: 100px;">{{etc.fap_job_test_etc_dtl}}</textarea>
							</div>	
						</div>
					</div>
					
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
						<button type="submit" class="btn btn-primary">설정하기</button>
					</div>
					
				</form>
			</div>
		</div>
	</div>
	<!-- 기타전형 일정설정 등록 MODAL 종료-->	
		
</body>
</html>
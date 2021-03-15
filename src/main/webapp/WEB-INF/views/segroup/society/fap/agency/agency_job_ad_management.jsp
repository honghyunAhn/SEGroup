<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Bridge Job Fair</title>
<script src="<c:url value="/resources/segroup/js/jquery-3.1.1.js" />"></script>
<script src="<c:url value="/resources/segroup/js/angular.min.js" />"></script>

<link type="text/css" rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto:400,500">
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/segroup/society/fap/css/default.css" />" />
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/segroup/society/fap/css/popModal.css" />" />

<script type="text/javascript">
	var myApp = angular.module('myapp', []);
	
	myApp.controller('JobAdController',['$scope','$compile', '$http', function($scope, $compile, $http) {
		
		/* ------------------------- 파라미터 scope에 담는 구역 -------------------------- */
		//select 박스 그리는데 필요한 잡페어 리스트
		var jobfair_map = JSON.parse('${jobfair_map}');
		
		//잡페어 리스트 default값 선택해주기 위한 변수
		$scope.fap_jobfair_divide_seq = '${fap_jobfair_divide_seq}';
		$scope.fap_jobfair_seq = '${fap_jobfair_seq}';
		$scope.chosen_fap_comp_id = '${chosen_fap_comp_id}';
		$scope.chosen_fap_comp_ja_nm = '${chosen_fap_comp_ja_nm}';
		
		//session에 선택한 회사 아이디가 있을때 로그인 옆에 띄어준다
		if($scope.chosen_fap_comp_ja_nm != ''){
			$("#chosenCompNm").html($scope.chosen_fap_comp_ja_nm);
		}
		
		//현재 클릭된 버튼 저장 scope
		$scope.cur_seleted_btn = 'progressing';
		/* ------------------------- 파라미터 scope에 담는 구역 끝 -------------------------- */
		
		/* -------------------------- [start] jobfair selectbox 그리기 시작 -------------------------- */
		if($scope.chosen_fap_comp_id != '') {
			//jobfair box option 그리기
			$http({
				method : 'POST',
				url : '/fap/agency/agency_company_jobfair_list_search',
				responseType : 'text',
				params : {
					fap_comp_id: $scope.chosen_fap_comp_id
				},
				headers : {
					"AJAX" : true
				}
			}).then(function successCallback(response) {
				//jobfair에 option 추가
				$("#select_jobfair").html($compile("<option hidden value=" + 0 + "><spring:message code="fap.comp.select" /></option>")($scope));
				for(var i in response.data){
					if(response.data[i].fap_jobfair_seq == $scope.fap_jobfair_seq){
						$("#select_jobfair").append($compile("<option selected value=" + response.data[i].fap_jobfair_seq + ">" + response.data[i].fap_jobfair_title + "</option>")($scope));
					}else{
						$("#select_jobfair").append($compile("<option value=" + response.data[i].fap_jobfair_seq + ">" + response.data[i].fap_jobfair_title + "</option>")($scope));
					}
					
				}
				
			}, function errorCallback(response) {
				if(response.status == 403){
					alert('<spring:message code="com.login.ajaxSesstion" javaScriptEscape="true" />');
					location.href = "/fap/agency/agency_login";
				}
			});
			
			//jobfair_divide 비활성화
			$("#jobfair_divide_hidden").prop("selected", true);
			$("#select_jobfair_divide").html("<option value=\'"+0+"\' id=\"jobfair_divide_hidden\" seq=\"" + 0 + "\"  hidden><spring:message code="fap.comp.select_imposible" /></option>");					
			$("#select_jobfair_divide").attr("disabled", true);
			
			//var cur_seleted_btn_val = $scope.cur_seleted_btn;
			//$scope.chosen_fap_comp_id = $('#select_company option:selected').attr('comp_id');
			
			$("#select_jobfair").attr("disabled", false);
			
			
			if($scope.fap_jobfair_seq != 0){
				//jobfair divide option 그리기
				//jobfair_divide 활성화
				if($("#select_jobfair option:selected").val() != 0 ){
					$("#jobfair_divide_hidden").prop("selected", true);
					$("#select_jobfair_divide").html("<option value=\'"+0+"\' id=\"jobfair_divide_hidden\" seq=\"" + 0 + "\"  hidden><spring:message code="fap.comp.select" /></option>");					
					$("#select_jobfair_divide").attr("disabled", false);	
				}else{
					$("#jobfair_divide_hidden").prop("selected", true);
					$("#select_jobfair_divide").html("<option value=\'"+0+"\' id=\"jobfair_divide_hidden\" seq=\"" + 0 + "\"  hidden><spring:message code="fap.comp.select_imposible" /></option>");					
					$("#select_jobfair_divide").attr("disabled", true);	
				}										
				
				$http({
					method : 'POST',
					url : '/fap/agency/agency_jobfair_divide_list_search',
					responseType : 'text',
					params : {
						fap_jobfair_seq: $scope.fap_jobfair_seq
						, fap_comp_id : $scope.chosen_fap_comp_id
					},
					headers : {
						"AJAX" : true
					}
				}).then(function successCallback(response) {
					console.log(response.data);
					//jobfair_divide에 option 추가
					for(var i in response.data){
						if($scope.fap_jobfair_divide_seq == response.data[i].fap_jobfair_divide_seq){
							$("#select_jobfair_divide").append($compile("<option selected selectcode value=" 
									+ response.data[i].fap_jobfair_divide_gb + " seq=\"" + response.data[i].fap_jobfair_divide_seq + "\"></option>")($scope));
						}else{
							$("#select_jobfair_divide").append($compile("<option selectcode value=" 
									+ response.data[i].fap_jobfair_divide_gb + " seq=\"" + response.data[i].fap_jobfair_divide_seq + "\"></option>")($scope));
						}
						
					}				
					
					$scope.draw_prgressing_job_ad_list();	//채용공고 리스트 그리기 함수 실행
					
				}, function errorCallback(response) {
					if(response.status == 403){
						alert('<spring:message code="com.login.ajaxSesstion" javaScriptEscape="true" />');
						location.href = "/fap/agency/agency_login";
					}
				});
			}
			
		}
		
		
		
		/* var context = '';
		context +=	'<select onchange="angular.element(this).scope().select_change(1)" id="select_jobfair" ng-model="::fap_jobfair_seq">';
		if($scope.fap_jobfair_seq == 0){
		context +=		'<option value= "0" hidden><spring:message code="fap.jobad.please_select" /></option>';
		}
		//진행중인 잡페어
		context +=		'<optgroup label="<spring:message code="fap.jobfair.jobfair_on_air" />" flag="1">';
		jobfair_map.jobfair_list_now.forEach(function (jobfair, index) {
			context +=	'<option value="' + jobfair.fap_jobfair_seq + '">' + jobfair.fap_jobfair_title + '</option>';
		});
		context +=		'</optgroup>';
		//예정된 잡페어
		context +=		'<optgroup label="<spring:message code="fap.jobad.jobfair_planned" />" flag="2">';
		jobfair_map.jobfair_list_before.forEach(function (jobfair, index) {
			context +=	'<option value="' + jobfair.fap_jobfair_seq + '">' + jobfair.fap_jobfair_title + '</option>';
		});
		context +=		'</optgroup>';
		//종료된 잡페어
		context +=		'<optgroup label="<spring:message code="fap.jobfair.closed_jobfair" />" flag="2">" flag="3">';
		jobfair_map.jobfair_list_after.forEach(function (jobfair, index) {
			context +=	'<option value="' + jobfair.fap_jobfair_seq + '">' + jobfair.fap_jobfair_title + '</option>';
		});
		context +=		'</optgroup>';
		context +=	'</select>';
		context+='&nbsp;';
		context +=	'<select onchange="angular.element(this).scope().select_change(2)" id="select_jobfair_detail" disabled="disabled">';
		context +=		'<option value="" id="jobfair_detail_hidden" hidden><spring:message code="fap.jobad.please_select" /></option>';
		context +=	'</select>';
		context+='&nbsp;';
		context +=	'<select onchange="angular.element(this).scope().select_change(3)" id="select_company" disabled="disabled">';
		context +=		'<option value="" id="client_comp_id_hidden" hidden><spring:message code="fap.jobad.please_select" /></option>';
		context +=	'</select>';
		$("#select-box-layout").append($compile(context)($scope));
		$("#select_jobfair_detail").attr("disabled", false);
		$("#select_company").attr("disabled", false);
		
		//잡페어 세부 비동기로 불러오는 부분
		$http({
			method : 'POST',
			url : '/fap/company_roadmap/select_jobfair_divide',
			responseType : 'text',
			params : {
				fap_jobfair_seq: '${fap_jobfair_seq}'
			}
		}).then(function successCallback(response) {
			//jobfair_detail에 option 추가
			for(var i in response.data){
				$('#select_jobfair_detail').append($compile('<option selectcode value="' 
						+ response.data[i].fap_jobfair_divide_gb + '" seq="' + response.data[i].fap_jobfair_divide_seq + '"></option>')($scope));
			}
			if($scope.fap_jobfair_divide_seq != 0){
				$('#select_jobfair_detail option').each(function(index, item) {
					if($(item).attr('seq') == $scope.fap_jobfair_divide_seq){
						$(item).prop('selected', true);
					}
				});
			}
		}, function errorCallback(response) {
			console.log(response);
		});
		
		var first_params = {};
		first_params['fap_jobfair_seq'] = '${fap_jobfair_seq}';
		first_params['fap_jobfair_divide_seq'] = '${fap_jobfair_divide_seq}';
		
		//회사아이디 비동기로 불러오는 부분
		$http({
			method : 'POST',
			url : '/fap/agency/select_in_job_management_company_list',
			headers: {'Content-Type': 'application/json'},
			data: JSON.stringify(first_params),
			XMLHttpRequestResponseType: 'json'
		}).then(function successCallback(response) {
			for(var i in response.data){
				$("#select_company").append($compile('<option comp_id=' + response.data[i].fap_comp_id + '>'+ response.data[i].fap_comp_ja_nm + '</option>')($scope));
			}
			if($scope.chosen_fap_comp_id != null || $scope.chosen_fap_comp_id != ''){
				$('#select_company option').each(function(index, item) {
					if($(item).attr('comp_id') == $scope.chosen_fap_comp_id){
						$(item).prop('selected', true);
					}
				});
				
				//처음페이지 강제로 진행중인 회사 띄워주는 부분
				var params = {};
				var fap_jobfair_divide_seq = $scope.fap_jobfair_divide_seq;;
				var fap_jobfair_seq = $scope.fap_jobfair_seq;
				var chosen_fap_comp_id = $scope.chosen_fap_comp_id;
				var stateFlag = 'progressing';
				$scope.cur_seleted_btn = 'progressing';
				params['fap_jobfair_divide_seq'] = fap_jobfair_divide_seq;
				params['fap_jobfair_seq'] = fap_jobfair_seq;
				params['chosen_fap_comp_id'] = chosen_fap_comp_id;
				params['stateFlag'] = stateFlag;
				
	 			$http({
					url : 'agency_select_per_state_job_ad_list',
					method : 'post',
					headers: {'Content-Type': 'application/json'},
					data: JSON.stringify(params),
					XMLHttpRequestResponseType: 'json'
				}).then(function successCallback(response) {
					var resultJobAds = response.data.perStateJobAdList;
					var context = '';	
					context += '		<ul class="tit1">';
					context += '			<li class="wid1">No</li>';
					context += '			<li class="wid2"><spring:message code="fap.jobad.title" /></li>';
					context += '			<li class="wid3"><spring:message code="fap.jobad.attended_jobfair" /></li>';
					context += '			<li class="wid4"><spring:message code="fap.jobad.jobfair_divide" /></li>';
					context += '			<li class="wid5"><spring:message code="fap.jobad.state" /></li>';
					context += '			<li class="wid6"><spring:message code="fap.jobad.applicant_num" /></li>';
					context += '			<li class="wid7">Q&amp;A</li>';
					context += '		</ul>';
				if(resultJobAds.length > 0){
					resultJobAds.forEach(function (jobAd, index) {
						context += '	<ul class="tit2">';
						context += '		<li class="wid1">' + (index + 1) + '</li>';
						context += '		<li class="wid2">';
						context += '			<ul class="tit3">';
						context += '			<li class="wid7" title="' + fap_job_ad_title + '"><a href="" ng-click="agency_job_ad_update_form(' + jobAd.fap_job_ad_seq + ')">';
						context += '				' + jobAd.fap_job_ad_title + '';
						context += '			</a></li>';
						context += '				<li class="wid8"><spring:message code="fap.jobad.accepted_period" /> : ';
						context += '					' + jobAd.fap_jobfair_applicable_time_st + ' ~ ' + jobAd.fap_jobfair_applicable_time_et + '';
						context += '				</li>';
						context += '				<li class="wid9"><spring:message code="fap.jobad.job_category" /> : ';
						jobAd.JobCateList.forEach(function (cate, cat_index) {
							if(cat_index !=0){
								context += ', ';
							}
							context += '				<code value="' + cate.fap_job_category_gb + '"></code>';
						});
						context += '				</li>';
						context += '				<li class="wid10"><spring:message code="fap.jobad.workplace" /> : ';
						jobAd.JobWorkplaceList.forEach(function (wp, wp_index) {
							wp.JobWorkplaceDtlList.forEach(function (wp_dtl, wp_dtl_index) {
									context += '		<code value="' + wp_dtl.fap_job_workplace_dtl_gb + '"></code>';
							});
						});
						context += '				</li>';
						context += '			</ul>';
						context += '		</li>';
						context += '		<li class="wid3">';
						context += '			' + jobAd.fap_jobfair_title + '';
						context += '		</li>';
						context += '		<li class="wid4">';
						context += '			<code value="' + jobAd.fap_jobfair_divide_gb + '"></code>';
						context += '		</li>';
						context += '		<li class="wid5">';
						context += '			<code value="' + jobAd.fap_job_ad_state + '"></code>';
						context += '		</li>';
						context += '		<li class="wid6">';
						context += '			' + jobAd.fap_job_ad_apply_num + '';
						context += '		</li>';
						context += '		<li class="wid7">';
						context += '			' + jobAd.fap_job_ad_question_num + '';
						context += '		</li>';
						context += '	</ul>';
					});
				} else{
					context += '<h3><spring:message code="fap.jobad.jobad_on_process" /></h3>';	
				}
				//버튼 색상변경 부분
				$('#progressingAdBtn').css('background', '#dadada');
				$('#standbyAdBtn').css('background', '#fff');
				$('#completedAdBtn').css('background', '#fff');
				$('#tempedAdBtn').css('background', '#fff');
				$("#nowBBS").children().remove();
				$("#nowBBS").append($compile(context)($scope));
				if(fap_jobfair_divide_seq > 0){
					$("#chosenCompNm").html(response.data.chosen_fap_comp_ja_nm);	
				}
				
				}, function errorCallback(response) {
					console.log(response);
				});
			}
		}, function errorCallback(response) {
			console.log(response);
		}); */
		
		/* ------------------------- [end] jobfair selectbox 그리기 종료 -------------------------- */
		
		$scope.select_change = function(flag) {
			
			if(flag == 0){
				//기업명 선택
				
				$http({
					method : 'POST',
					url : '/fap/agency/agency_company_jobfair_list_search',
					responseType : 'text',
					params : {
						fap_comp_id: $("#select_company option:selected").attr("comp_id")
					},
					headers : {
						"AJAX" : true
					}
				}).then(function successCallback(response) {
					console.log(response);
					//jobfair에 option 추가
					$("#select_jobfair").html($compile("<option hidden value=" + 0 + "><spring:message code="fap.comp.select" /></option>")($scope));
					for(var i in response.data){
						$("#select_jobfair").append($compile("<option value=" + response.data[i].fap_jobfair_seq + ">" + response.data[i].fap_jobfair_title + "</option>")($scope));
					}
					
					$("#chosenCompNm").html($("#select_company option:selected").val());
					
				}, function errorCallback(response) {
					if(response.status == 403){
						alert('<spring:message code="com.login.ajaxSesstion" javaScriptEscape="true" />');
						location.href = "/fap/agency/agency_login";
					}
				});
				
				//jobfair_divide 비활성화
				$("#jobfair_divide_hidden").prop("selected", true);
				$("#select_jobfair_divide").html("<option value=\'"+0+"\' id=\"jobfair_divide_hidden\" seq=\"" + 0 + "\"  hidden><spring:message code="fap.comp.select_imposible" /></option>");					
				$("#select_jobfair_divide").attr("disabled", true);
				
				var cur_seleted_btn_val = $scope.cur_seleted_btn;
				$scope.chosen_fap_comp_id = $('#select_company option:selected').attr('comp_id');
				
				
				$("#select_jobfair").attr("disabled", false);
				
			} else if(flag == 1){
				//잡페어 선택
				
				//jobfair_divide 활성화
				if($("#select_jobfair option:selected").val() != 0 ){
					$("#jobfair_divide_hidden").prop("selected", true);
					$("#select_jobfair_divide").html("<option value=\'"+0+"\' id=\"jobfair_divide_hidden\" seq=\"" + 0 + "\"  hidden><spring:message code="fap.comp.select" /></option>");					
					$("#select_jobfair_divide").attr("disabled", false);	
				}else{
					$("#jobfair_divide_hidden").prop("selected", true);
					$("#select_jobfair_divide").html("<option value=\'"+0+"\' id=\"jobfair_divide_hidden\" seq=\"" + 0 + "\"  hidden><spring:message code="fap.comp.select_imposible" /></option>");					
					$("#select_jobfair_divide").attr("disabled", true);	
				}										
				
				$scope.fap_jobfair_seq = $('#select_jobfair option:selected').val();
				
				$http({
					method : 'POST',
					url : '/fap/agency/agency_jobfair_divide_list_search',
					responseType : 'text',
					params : {
						fap_jobfair_seq: $("#select_jobfair option:selected").val()
						, fap_comp_id : $("#select_company option:selected").attr("comp_id")
					},
					headers : {
						"AJAX" : true
					}
				}).then(function successCallback(response) {
					//jobfair_divide에 option 추가
					for(var i in response.data){
						$("#select_jobfair_divide").append($compile("<option selectcode value=" 
								+ response.data[i].fap_jobfair_divide_gb + " seq=\"" + response.data[i].fap_jobfair_divide_seq + "\"></option>")($scope));
					}					
					
				}, function errorCallback(response) {
					if(response.status == 403){
						alert('<spring:message code="com.login.ajaxSesstion" javaScriptEscape="true" />');
						location.href = "/fap/agency/agency_login";
					}
				});
			
			}else {
				//잡페어 세부 선택
				$scope.fap_jobfair_divide_seq = $('#select_jobfair_divide option:selected').attr('seq');
				
				switch(cur_seleted_btn_val){
				case 'progressing' : 
					$scope.draw_prgressing_job_ad_list();
					break;
				case 'standby' :
					$scope.draw_standby_job_ad_list();
					break;
				case 'completed' :
					$scope.draw_completed_job_ad_list();
					break;
				case 'temped': 
					$scope.draw_temped_job_ad_list();
					break;
				default: 
					$scope.draw_prgressing_job_ad_list();
					break;
				}
			}
		}
		
		
		/* $scope.select_change = function(flag){
			//flag(1:jobfair select box 선택, 2:divide select box 선택, 3:comp id box 선택)
			if(flag == 1){
				$('#jobfair_detail_hidden').prop('selected', true);
				$('#select_jobfair_detail').attr('disabled', false);
				$('#select_jobfair_detail').html('<option value="" id="jobfair_detail_hidden" hidden><spring:message code="fap.jobad.please_select" /></option>');
				
				$('#client_comp_id_hidden').prop('selected', true);
				$('#select_company').attr('disabled', false);
				$('#select_company').html('<option value="" id="jobfair_detail_hidden" hidden><spring:message code="fap.jobad.please_select" /></option>');
				
				$scope.fap_jobfair_seq = $('#select_jobfair option:selected').val();
				
				$http({
					method : 'POST',
					url : '/fap/company_roadmap/select_jobfair_divide',
					responseType : 'text',
					params : {
						fap_jobfair_seq: $('#select_jobfair option:selected').val()
					}
				}).then(function successCallback(response) {
					for(var i in response.data){
						$('#select_jobfair_detail').append($compile('<option selectcode value="'
								+ response.data[i].fap_jobfair_divide_gb + '" seq="' + response.data[i].fap_jobfair_divide_seq + '"></option>')($scope));
					}
					//메뉴쪽 회사명 초기화
					$("#chosenCompNm").html('');	
				}, function errorCallback(response) {
					console.log(response);
				});
				
			}else if(flag ==2){				
				$('#client_comp_id_hidden').prop('selected', true);
				$('#select_company').attr('disabled', false);
				
				$('#select_company').html('<option value="" id="jobfair_detail_hidden" hidden><spring:message code="fap.jobad.please_select" /></option>');
				
				$scope.fap_jobfair_divide_seq = $('#select_jobfair_detail option:selected').attr('seq');
				
				var params = {};
				params['fap_jobfair_seq'] = $scope.fap_jobfair_seq;
				params['fap_jobfair_divide_seq'] = $('#select_jobfair_detail option:selected').attr('seq');
				
				$http({
					method : 'POST',
					url : '/fap/agency/select_in_job_management_company_list',
					headers: {'Content-Type': 'application/json'},
					data: JSON.stringify(params),
					XMLHttpRequestResponseType: 'json'
				}).then(function successCallback(response) {
					//jobfair_detail에 option 추가
					for(var i in response.data){
						$('#select_company').append($compile('<option comp_id="'
								+ response.data[i].fap_comp_id + '">' + response.data[i].fap_comp_ja_nm + '</option>')($scope));
					}
					//메뉴쪽 회사명 초기화
					$("#chosenCompNm").html('');
				}, function errorCallback(response) {
					console.log(response);
				});
				
			}else{
				var cur_seleted_btn_val = $scope.cur_seleted_btn;
				$scope.chosen_fap_comp_id = $('#select_company option:selected').attr('comp_id');
				
				switch(cur_seleted_btn_val){
				case 'progressing' : 
					$scope.draw_prgressing_job_ad_list();
					break;
				case 'standby' :
					$scope.draw_standby_job_ad_list();
					break;
				case 'completed' :
					$scope.draw_completed_job_ad_list();
					break;
				case 'temped': 
					$scope.draw_temped_job_ad_list();
					break;
				default: 
					$scope.draw_prgressing_job_ad_list();
					break;
				}
			}
		} */	
		//[end] jobfair selectbox 그리기 종료
		
		$scope.update_job_ad_state = function(flag, fap_job_ad_seq, fap_jobfair_seq, fap_jobfair_divide_seq) {
			
			var params = {};
			var fap_job_ad_state = (flag == 1) ? 'C2104' : 'C2100';
			
			params['fap_jobfair_divide_seq'] = fap_jobfair_divide_seq;
			params['fap_jobfair_seq'] = fap_jobfair_seq;
			params['fap_job_ad_seq'] = fap_job_ad_seq;
			params['fap_job_ad_state'] = fap_job_ad_state;			
			
			$http({
				url : '/fap/agency/update_job_ad_state',
				method : 'post',
				headers: {
					'Content-Type': 'application/json',
					"AJAX" : true
				},
				data: JSON.stringify(params),
				XMLHttpRequestResponseType: 'json'
			}).then(function successCallback(response) {
				var cur_seleted_btn_val = $scope.cur_seleted_btn;
				switch(cur_seleted_btn_val){
				case 'progressing' : 
					$scope.draw_prgressing_job_ad_list();
					break;
				case 'standby' :
					$scope.draw_standby_job_ad_list();
					break;
				case 'completed' :
					$scope.draw_completed_job_ad_list();
					break;
				case 'temped': 
					$scope.draw_temped_job_ad_list();
					break;
				default: 
					$scope.draw_prgressing_job_ad_list();
					break;
				}
			}, function errorCallback(response) {
				console.log(response);
				if(response.status == 403){
					alert('<spring:message code="com.login.ajaxSesstion" javaScriptEscape="true" />');
					location.href = "/fap/agency/agency_login";
				}
			});
		}		
			
		$scope.agency_job_ad_update_form = function(fap_job_ad_seq) {
			$('#fap_job_ad_seq').val(fap_job_ad_seq);
			$('#agency_job_ad_update_form').submit();
		}
		
		$scope.agency_job_ad_read_form = function(fap_job_ad_seq) {
			$('#fap_job_ad_seq_read').val(fap_job_ad_seq);
			$('#agency_job_ad_read_form').submit();
		}
				
		//[start] 진행중인 채용공고 시작
		$scope.draw_prgressing_job_ad_list = function() {
			var params = {};
			var fap_jobfair_divide_seq = $scope.fap_jobfair_divide_seq;
			var fap_jobfair_seq = $scope.fap_jobfair_seq;
			var chosen_fap_comp_id = $scope.chosen_fap_comp_id;
			var stateFlag = 'progressing';
			$scope.cur_seleted_btn = 'progressing';
			params['fap_jobfair_divide_seq'] = fap_jobfair_divide_seq;
			params['fap_jobfair_seq'] = fap_jobfair_seq;
			params['chosen_fap_comp_id'] = chosen_fap_comp_id;
			params['stateFlag'] = stateFlag;
			
			console.log(params);
			
 			$http({
				url : 'agency_select_per_state_job_ad_list',
				method : 'post',
				headers: {
					'Content-Type': 'application/json',
					"AJAX" : true
				},
				data: JSON.stringify(params),
				XMLHttpRequestResponseType: 'json'
			}).then(function successCallback(response) {
				var resultJobAds = response.data.perStateJobAdList;
				var context = '';	
				context += '		<ul class="tit1">';
				context += '			<li class="wid1">No</li>';
				context += '			<li class="wid2"><spring:message code="fap.jobad.title" /></li>';
				context += '			<li class="wid3"><spring:message code="fap.jobad.attended_jobfair" /></li>';
				context += '			<li class="wid4"><spring:message code="fap.jobad.jobfair_divide" /></li>';
				context += '			<li class="wid5"><spring:message code="fap.jobad.state" /></li>';
				context += '			<li class="wid6">Q&amp;A</li>';
				context += '			<li class="wid7"><spring:message code="fap.comp.applicant_status" /></li>';
				context += '		</ul>';
			if(resultJobAds.length > 0){
				resultJobAds.forEach(function (jobAd, index) {
					context += '	<ul class="tit2">';
					context += '		<li class="wid1">' + (index + 1) + '</li>';
					context += '		<li class="wid2">';
					context += '			<ul class="tit3">';
					context += '			<li class="wid7" title="' + jobAd.fap_job_ad_title + '"><a href="" ng-click="agency_job_ad_read_form(' + jobAd.fap_job_ad_seq + ')">';
					context += '				' + jobAd.fap_job_ad_title + '';
					context += '			</a></li>';
					context += '				<li class="wid8"><spring:message code="fap.jobad.accepted_period" /> : ';
					context += '					' + jobAd.fap_jobfair_applicable_time_st + ' ~ ' + jobAd.fap_jobfair_applicable_time_et + '';
					context += '				</li>';
					context += '				<li class="wid9"><spring:message code="fap.jobad.job_category" /> : ';
					jobAd.JobCateList.forEach(function (cate, cat_index) {
						if(cat_index !=0){
							context += ', ';
						}
						context += '				<code value="' + cate.fap_job_category_gb + '"></code>';
					});
					context += '				</li>';
					context += '				<li class="wid10"><spring:message code="fap.jobad.workplace" /> : ';
					jobAd.JobWorkplaceList.forEach(function (wp, wp_index) {
						wp.JobWorkplaceDtlList.forEach(function (wp_dtl, wp_dtl_index) {
								context += '		<code value="' + wp_dtl.fap_job_workplace_dtl_gb + '"></code>';
						});
					});
					context += '				</li>';
					context += '			</ul>';
					context += '		</li>';
					context += '		<li class="wid3">';
					context += '			' + jobAd.fap_jobfair_title + '';
					context += '		</li>';
					context += '		<li class="wid4">';
					context += '			<code value="' + jobAd.fap_jobfair_divide_gb + '"></code>';
					context += '		</li>';
					context += '		<li class="wid5">';
					context += '			<code value="' + jobAd.fap_job_ad_state + '"></code>';
					context += '		</li>';
					context += '		<li class="wid6">';
					context += '			<a href="/fap/agency/agency_job_qna_management?fap_job_ad_seq=' + jobAd.fap_job_ad_seq + '"><button style="left: 22px; width: 69px;"><spring:message code="fap.jobad.qna.to_qna_page" /></button></a>';
					context += '		</li>';
					context += '		<li class="wid7">';
					context += '			<button onclick="show_applicant('+2+','+$scope.fap_jobfair_divide_seq+', '+jobAd.fap_job_ad_seq+', \''+$scope.chosen_fap_comp_id+'\')" style="right: 13px;"><spring:message code="fap.comp.applicant_status" /></button>';
					context += '		</li>';
					context += '	</ul>';
				});
			} else{
				context += '<h3><spring:message code="fap.jobad.jobad_on_process" /></h3>';	
			}
			//버튼 색상변경 부분
			$('#progressingAdBtn').css('background', '#dadada');
			$('#standbyAdBtn').css('background', '#fff');
			$('#completedAdBtn').css('background', '#fff');
			$('#tempedAdBtn').css('background', '#fff');
			$("#nowBBS").children().remove();
			$("#nowBBS").append($compile(context)($scope));
			/* if(fap_jobfair_divide_seq > 0){
				$("#chosenCompNm").html(response.data.chosen_fap_comp_ja_nm);	
			} */
			
			}, function errorCallback(response) {
				console.log(response);
				if(response.status == 403){
					alert('<spring:message code="com.login.ajaxSesstion" javaScriptEscape="true" />');
					location.href = "/fap/agency/agency_login";
				}
			});
		};
		//[end] 진행중인 채용공고 종료
		
		//[start] 대기중인 채용공고 시작
		$scope.draw_standby_job_ad_list = function() {
			var params = {};
			var fap_jobfair_divide_seq = $scope.fap_jobfair_divide_seq;
			var fap_jobfair_seq = $scope.fap_jobfair_seq;
			var chosen_fap_comp_id = $scope.chosen_fap_comp_id;
			var stateFlag = 'standby';
			$scope.cur_seleted_btn = 'standby';
			params['fap_jobfair_divide_seq'] = fap_jobfair_divide_seq;
			params['fap_jobfair_seq'] = fap_jobfair_seq;
			params['chosen_fap_comp_id'] = chosen_fap_comp_id;
			params['stateFlag'] = stateFlag;
 			
			$http({
				url : 'agency_select_per_state_job_ad_list',
				method : 'post',
				headers: {
					'Content-Type': 'application/json',
					"AJAX" : true
				},
				data: JSON.stringify(params),
				XMLHttpRequestResponseType: 'json'
			}).then(function successCallback(response) {
				var resultJobAds = response.data.perStateJobAdList;
				var context = '';	
				context += '		<ul class="tit1">';
				context += '			<li class="wid1">No</li>';
				context += '			<li class="wid2"><spring:message code="fap.jobad.title" /></li>';
				context += '			<li class="wid3"><spring:message code="fap.jobad.attended_jobfair" /></li>';
				context += '			<li class="wid4"><spring:message code="fap.jobad.jobfair_divide" /></li>';
				context += '			<li class="wid5"><spring:message code="fap.jobad.state" /></li>';
				context += '			<li class="wid6"><spring:message code="fap.jobad.insurance_note" /></li>';
				context += '		</ul>';
			if(resultJobAds.length > 0){
				resultJobAds.forEach(function (jobAd, index) {
					context += '	<ul class="tit2">';
					context += '		<li class="wid1">' + (index + 1) + '</li>';
					context += '		<li class="wid2">';
					
					//승인요청중은 읽기폼으로(C2104), 대기중이면 수정폼으로 링크
					context += '			<ul class="tit3">';
					if(jobAd.fap_job_ad_state == 'C2104'){
						context += '			<li class="wid7" title="' + jobAd.fap_job_ad_title + '"><a href="" ng-click="agency_job_ad_read_form(' + jobAd.fap_job_ad_seq + ')">';
						context += '				' + jobAd.fap_job_ad_title + '';
						context += '			</a></li>';
					}else{
						context += '			<li class="wid7" title="' + jobAd.fap_job_ad_title + '"><a href="" ng-click="agency_job_ad_update_form(' + jobAd.fap_job_ad_seq + ')">';
						context += '				' + jobAd.fap_job_ad_title + '';
						context += '			</a></li>';
					}
					
					
					context += '				<li class="wid8"><spring:message code="fap.jobad.accepted_period" /> : ';
					context += '					' + jobAd.fap_jobfair_applicable_time_st + ' ~ ' + jobAd.fap_jobfair_applicable_time_et + '';
					context += '				</li>';
					context += '				<li class="wid9"><spring:message code="fap.jobad.job_category" /> : ';
					jobAd.JobCateList.forEach(function (cate, cat_index) {
						if(cat_index !=0){
							context += ', ';
						}
						context += '				<code value="' + cate.fap_job_category_gb + '"></code>';
					});
					context += '				</li>';
					context += '				<li class="wid10"><spring:message code="fap.jobad.workplace" /> : ';
					
					jobAd.JobWorkplaceList.forEach(function (wp, wp_index) {
						wp.JobWorkplaceDtlList.forEach(function (wp_dtl, wp_dtl_index) {
								context += '		<code value="' + wp_dtl.fap_job_workplace_dtl_gb + '"></code>';
						});
					});
					context += '				</li>';
					context += '			</ul>';
					context += '		</li>';
					context += '		<li class="wid3">';
					context += '			' + jobAd.fap_jobfair_title + '';
					context += '		</li>';
					context += '		<li class="wid4">';
					context += '			<code value="' + jobAd.fap_jobfair_divide_gb + '"></code>';
					context += '		</li>';
					context += '		<li class="wid5">';
						context += 			'<code value="' + jobAd.fap_job_ad_state + '"></code>';
					context += '		</li>';
					context += '		<li class="wid6">';
					if(jobAd.fap_job_ad_state == 'C2100'){
						context += '		<button ng-click="update_job_ad_state(1, ' + jobAd.fap_job_ad_seq + ', ' + jobAd.fap_jobfair_seq + ', ' + jobAd.fap_jobfair_divide_seq + ')"><spring:message code="fap.jobad.approval_requests" /></button>';
						
					}else{
						context += '		<button ng-click="update_job_ad_state(2, ' + jobAd.fap_job_ad_seq + ', ' + jobAd.fap_jobfair_seq + ', ' + jobAd.fap_jobfair_divide_seq + ')"><spring:message code="fap.jobad.request_cancelled" /></button>';
					}
					context += '		</li>';
					context += '	</ul>';
				});
			} else{
				context += '<h3><spring:message code="fap.jobad.jobad_on_process" /></h3>';	
			}
			$('#progressingAdBtn').css('background', '#fff');
			$('#standbyAdBtn').css('background', '#dadada');
			$('#completedAdBtn').css('background', '#fff');
			$('#tempedAdBtn').css('background', '#fff');
			$("#nowBBS").children().remove();
			$("#nowBBS").append($compile(context)($scope));
			/* if(fap_jobfair_divide_seq > 0){
				$("#chosenCompNm").html(response.data.chosen_fap_comp_ja_nm);	
			} */
			
			}, function errorCallback(response) {
				console.log(response);
				if(response.status == 403){
					alert('<spring:message code="com.login.ajaxSesstion" javaScriptEscape="true" />');
					location.href = "/fap/agency/agency_login";
				}
			});
		};
		//[end] 대기중인 채용공고 종료
		
		//[start] 마감된 채용공고 시작
		$scope.draw_completed_job_ad_list = function() {
			var params = {};
			var fap_jobfair_divide_seq = $scope.fap_jobfair_divide_seq;
			var fap_jobfair_seq = $scope.fap_jobfair_seq;
			var chosen_fap_comp_id = $scope.chosen_fap_comp_id;
			var stateFlag = 'completed';
			$scope.cur_seleted_btn = 'completed';
			params['fap_jobfair_divide_seq'] = fap_jobfair_divide_seq;
			params['fap_jobfair_seq'] = fap_jobfair_seq;
			params['chosen_fap_comp_id'] = chosen_fap_comp_id;
			params['stateFlag'] = stateFlag;
			
 			$http({
				url : 'agency_select_per_state_job_ad_list',
				method : 'post',
				headers: {
					'Content-Type': 'application/json',
					"AJAX" : true
				},
				data: JSON.stringify(params),
				XMLHttpRequestResponseType: 'json'
			}).then(function successCallback(response) {
				var resultJobAds = response.data.perStateJobAdList;
				var context = '';
				context += '		<ul class="tit1">';
				context += '			<li class="wid1">No</li>';
				context += '			<li class="wid2"><spring:message code="fap.jobad.title" /></li>';
				context += '			<li class="wid3"><spring:message code="fap.jobad.attended_jobfair" /></li>';
				context += '			<li class="wid4"><spring:message code="fap.jobad.jobfair_divide" /></li>';
				context += '			<li class="wid5"><spring:message code="fap.jobad.state" /></li>';
				context += '			<li class="wid6">Q&amp;A</li>';
				context += '			<li class="wid7"><spring:message code="fap.comp.applicant_status" /></li>';
				context += '		</ul>';
			if(resultJobAds.length > 0){
				resultJobAds.forEach(function (jobAd, index) {
					context += '	<ul class="tit2">';
					context += '		<li class="wid1">' + (index + 1) + '</li>';
					context += '		<li class="wid2">';
					context += '			<ul class="tit3">';
					context += '			<li class="wid7" title="' + jobAd.fap_job_ad_title + '"><a href="" ng-click="agency_job_ad_read_form(' + jobAd.fap_job_ad_seq + ')">';
					context += '				' + jobAd.fap_job_ad_title + '';
					context += '			</a></li>';
					context += '				<li class="wid8"><spring:message code="fap.jobad.accepted_period" /> : ';
					context += '					' + jobAd.fap_jobfair_applicable_time_st + ' ~ ' + jobAd.fap_jobfair_applicable_time_et + '';
					context += '				</li>';
					context += '				<li class="wid9"><spring:message code="fap.jobad.job_category" /> : ';
					jobAd.JobCateList.forEach(function (cate, cat_index) {	
						if(cat_index !=0){
							context += ', ';
						}
						context += '				<code value="' + cate.fap_job_category_gb + '"></code>';
					});
					context += '				</li>';
					context += '				<li class="wid10"><spring:message code="fap.jobad.workplace" /> : ';
					jobAd.JobWorkplaceList.forEach(function (wp, wp_index) {
						wp.JobWorkplaceDtlList.forEach(function (wp_dtl, wp_dtl_index) {
								context += '		<code value="' + wp_dtl.fap_job_workplace_dtl_gb + '"></code>';
						});
					});
					context += '				</li>';
					context += '			</ul>';
					context += '		</li>';
					context += '		<li class="wid3">';
					context += '			' + jobAd.fap_jobfair_title + '';
					context += '		</li>';
					context += '		<li class="wid4">';
					context += '			<code value="' + jobAd.fap_jobfair_divide_gb + '"></code>';
					context += '		</li>';
					context += '		<li class="wid5">';
					context += '			<code value="' + jobAd.fap_job_ad_state + '"></code>';
					context += '		</li>';
					context += '		<li class="wid6">';
					context += '			<a href="/fap/agency/agency_job_qna_management?fap_job_ad_seq=' + jobAd.fap_job_ad_seq + '"><button style="left: 22px; width: 69px;"><spring:message code="fap.jobad.qna.to_qna_page" /></button></a>';
					context += '		</li>';
					context += '		<li class="wid7">';
					context += '			<button onclick="show_applicant('+1+','+$scope.fap_jobfair_divide_seq+', '+jobAd.fap_job_ad_seq+', \'${fap_comp_id}\')" style="left: 19px; width: 74px;"><spring:message code="fap.comp.applicant_status" /></button>';
					context += '		</li>';
					context += '	</ul>';
				});
			} else{
				context += '<h3><spring:message code="fap.jobad.jobad_on_process" /></h3>';	
			}
			$('#progressingAdBtn').css('background', '#fff');
			$('#standbyAdBtn').css('background', '#fff');
			$('#completedAdBtn').css('background', '#dadada');
			$('#tempedAdBtn').css('background', '#fff');
			$("#nowBBS").children().remove();
			$("#nowBBS").append($compile(context)($scope));
			/* if(fap_jobfair_divide_seq > 0){
				$("#chosenCompNm").html(response.data.chosen_fap_comp_ja_nm);	
			} */
			
			}, function errorCallback(response) {
				console.log(response);
				if(response.status == 403){
					alert('<spring:message code="com.login.ajaxSesstion" javaScriptEscape="true" />');
					location.href = "/fap/agency/agency_login";
				}
			});
		};
		//[end] 마감된 채용공고 종료
		
		//[start] 채용공고 저장함 시작
		$scope.draw_temped_job_ad_list = function() {
			var params = {};
			var fap_jobfair_divide_seq = $scope.fap_jobfair_divide_seq;
			var fap_jobfair_seq = $scope.fap_jobfair_seq;
			var chosen_fap_comp_id = $scope.chosen_fap_comp_id;
			var stateFlag = 'temped';
			$scope.cur_seleted_btn = 'temped';
			params['fap_jobfair_divide_seq'] = fap_jobfair_divide_seq;
			params['fap_jobfair_seq'] = fap_jobfair_seq;
			params['chosen_fap_comp_id'] = chosen_fap_comp_id;
			params['stateFlag'] = stateFlag;
			
 			$http({
				url : 'agency_select_per_state_job_ad_list',
				method : 'post',
				headers: {
					'Content-Type': 'application/json',
					"AJAX" : true
				},
				data: JSON.stringify(params),
				XMLHttpRequestResponseType: 'json'
			}).then(function successCallback(response) {
				var resultJobAds = response.data.perStateJobAdList;
				var context = '';
				context += '		<ul class="tit1">';
				context += '			<li class="wid1">No</li>';
				context += '			<li class="wid2"><spring:message code="fap.jobad.title" /></li>';
				context += '			<li class="wid3"><spring:message code="fap.jobad.attended_jobfair" /></li>';
				context += '			<li class="wid4"><spring:message code="fap.jobad.jobfair_divide" /></li>';
				context += '			<li class="wid5"><spring:message code="fap.jobad.state" /></li>';
				context += '			<li class="wid6"><spring:message code="fap.jobad.regist_date" /></li>';
				context += '			<li class="wid7"><spring:message code="fap.jobad.edit_date" /></li>';
				context += '			<li class="wid8"><spring:message code="fap.jobad.delete_button" /></li>';
				context += '		</ul>';
			if(resultJobAds.length > 0){
				resultJobAds.forEach(function (jobAd, index) {
					context += '	<ul class="tit2">';
					context += '		<li class="wid1">' + (index + 1) + '</li>';
					context += '		<li class="wid2">';
					context += '			<ul class="tit3">';
					context += '			<li class="wid7" title="' + jobAd.fap_job_ad_title + '"><a href="" ng-click="agency_job_ad_update_form(' + jobAd.fap_job_ad_seq + ')">';
					context += '				' + jobAd.fap_job_ad_title + '';
					context += '			</a></li>';
					context += '				<li class="wid8"><spring:message code="fap.jobad.accepted_period" /> : ';
					context += '					' + jobAd.fap_jobfair_applicable_time_st + ' ~ ' + jobAd.fap_jobfair_applicable_time_et + '';
					context += '				</li>';
					context += '				<li class="wid9"><spring:message code="fap.jobad.job_category" /> : ';
					jobAd.JobCateList.forEach(function (cate, cat_index) {	
						if(cat_index !=0){
							context += ', ';
						}
						context += '				<code value="' + cate.fap_job_category_gb + '"></code>';
					});
					context += '				</li>';
					context += '				<li class="wid10"><spring:message code="fap.jobad.workplace" /> : ';
					
					jobAd.JobWorkplaceList.forEach(function (wp, wp_index) {
						wp.JobWorkplaceDtlList.forEach(function (wp_dtl, wp_dtl_index) {
								context += '		<code value="' + wp_dtl.fap_job_workplace_dtl_gb + '"></code>';
						});
					});
					context += '				</li>';
					context += '			</ul>';
					context += '		</li>';
					context += '		<li class="wid3">';
					context += '			' + jobAd.fap_jobfair_title + '';
					context += '		</li>';
					context += '		<li class="wid4">';
					context += '			<code value="' + jobAd.fap_jobfair_divide_gb + '"></code>';
					context += '		</li>';
					context += '		<li class="wid5">';
					context += '			<code value="' + jobAd.fap_job_ad_state + '"></code>';
					context += '		</li>';
					context += '		<li class="wid6">';
					context += '			' + jobAd.fap_job_ad_ins_dt + '';
					context += '		</li>';
					context += '		<li class="wid7">';
					context += '			' + jobAd.fap_job_ad_udt_dt + '';
					context += '		</li>';
					context += '		<li class="wid8">';
					context += '			<button ng-click="delete_job_ad_box('+jobAd.fap_job_ad_seq+')">Delete</button>';
					context += '		</li>';
					context += '	</ul>';
				});
			} else{
				context += '<h3><spring:message code="fap.jobad.jobad_on_process" /></h3>';	
			}
			$('#progressingAdBtn').css('background', '#fff');
			$('#standbyAdBtn').css('background', '#fff');
			$('#completedAdBtn').css('background', '#fff');
			$('#tempedAdBtn').css('background', '#dadada');
			$("#nowBBS").children().remove();
			$("#nowBBS").append($compile(context)($scope));
			/* if(fap_jobfair_divide_seq > 0){
				$("#chosenCompNm").html(response.data.chosen_fap_comp_ja_nm);	
			} */
			
			}, function errorCallback(response) {
				console.log(response);
				if(response.status == 403){
					alert('<spring:message code="com.login.ajaxSesstion" javaScriptEscape="true" />');
					location.href = "/fap/agency/agency_login";
				}
			});
		};
		//[end] 채용공고 저장함 종료
				
		$scope.delete_job_ad_box = function (fap_job_ad_seq) {
			if(confirm('<spring:message code="fap.jobad.delete.comment" javaScriptEscape="true" />')){
				
				$http({
					url : 'job_ad_delete'
					, method : 'post'
					, params : {
						fap_job_ad_seq : fap_job_ad_seq
					}
					,headers : {
						"AJAX" : true
					}
				}).then(function successCallback(response) {
					
					if(response.data == 1){
						alert('<spring:message code="fap.jobad.delete.complete.comment" javaScriptEscape="true" />');
						$scope.draw_temped_job_ad_list();
					} else {
						alert('<spring:message code="fap.jobad.delete.fail.comment" javaScriptEscape="true" />');
					}
					
				}, function errorCallback(response) {
					if(response.status == 403){
						alert('<spring:message code="com.login.ajaxSesstion" javaScriptEscape="true" />');
						location.href = "/fap/agency/agency_login";
					}
				});

			} else {
				return;
			}
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
	
	function insert_param_set() {
		var jobfair_seq = $('#select_jobfair option:selected').val();
		var jobfair_divide_seq = $('#select_jobfair_divide option:selected').attr('seq');
		var chosen_fap_comp_id = $('#select_company option:selected').attr('comp_id');
		
		if(jobfair_seq == null || jobfair_seq == 0){
			//잡페어를 선택해주세요.
			alert('<spring:message code="fap.jobad.select_jobfair_alert" />');
			return false;
		}
		
		if(jobfair_divide_seq == null || jobfair_divide_seq == 0){
			//잡페어 세부를 선택해주세요.
			alert('<spring:message code="fap.jobad.select_jobfair_divide_alert" />');
			return false;
		}
		
		if(chosen_fap_comp_id == null || chosen_fap_comp_id == ''){
			//회사를 선택해주세요.
			alert('<spring:message code="fap.jobad.select_join_company_alert" />');
			return false;
		}
		
		$("#insert_fap_jobfair_seq").val(jobfair_seq);
		$("#insert_fap_jobfair_divide_seq").val(jobfair_divide_seq);
		
		return true;
		
	} 	
	
	function show_applicant (flag,fap_jobfair_divide_seq, fap_job_ad_seq, fap_comp_id){
		var fap_job_ad_state = (flag ==1)? 'C2102' : 'C2101';
		var form = document.createElement("form");
        var parm = new Array();
        var input = new Array();

        form.action = "/fap/agency/agency_applicant_status_per_job_ad";
        form.method = "post";
        
		/* [name, value] */
		parm.push( ['fap_jobfair_divide_seq', fap_jobfair_divide_seq ] );
		parm.push( ['fap_job_ad_seq', fap_job_ad_seq ] );
        parm.push( ['fap_comp_id', fap_comp_id ] );        
        
        for (var i = 0; i < parm.length; i++) {
            input[i] = document.createElement("input");
            input[i].setAttribute("type", "hidden");
            input[i].setAttribute('name', parm[i][0]);
            input[i].setAttribute("value", parm[i][1]);
            form.appendChild(input[i]);
        }
        
        input2 = document.createElement("input");
        input2.setAttribute("type", "hidden");
        input2.setAttribute('name', "fap_job_ad_state");
        input2.setAttribute("value", fap_job_ad_state);
        form.appendChild(input2);
        
        document.body.appendChild(form);
        form.submit();
	}
</script>
</head>
<body ng-app="myapp" ng-controller="JobAdController">
<%@include file="agency_menu.jsp"%>
<div class="join-wrap">
	<div id="subcontents">
		<h1><spring:message code="fap.common.manage_jobad" /></h1>
		<h6><span class="red"><spring:message code="fap.jobad.approval_requests.title" /></span></h6>
		
		
		
		
		
		
		
		<div id="nowBox">
		
			<div class="nowfind" id="select-box-layout">
				<h5><spring:message code="fap.comp.login_invite_phrase" /></h5>
				<div id="calendar-contents">
					<div id="top">
						<div>
							<span><spring:message code="fap.comp.search_comp_nm" /> : </span>
							<select onchange="angular.element(this).scope().select_change(0)" id="select_company" style="width: 200px; height: 26px;" ng-model="chosen_fap_comp_ja_nm">
								<option hidden value=""><spring:message code="fap.comp.select" /></option>
								<option comp_id="${resultMap.agency_info.fap_comp_id}" value="${resultMap.agency_info.fap_comp_ja_nm}" <c:if test="${agency == resultMap.agency_info.fap_comp_id}">selected</c:if>>${resultMap.agency_info.fap_comp_ja_nm}</option>
								<c:forEach var="company" items="${resultMap.select_approval_comp}">
									<option comp_id="${company.fap_comp_id}" value="${company.fap_comp_ja_nm}" <c:if test="${fap_comp_id == company.fap_comp_id}">selected</c:if>>${company.fap_comp_ja_nm}</option>
								</c:forEach>
							</select>
							&emsp;&emsp;
							<span><spring:message code="fap.jobad.search_per_jobfair" /></span>
							<%-- <span><spring:message code="fap.comp.search_jobfair" /> : </span> --%>
							<select onchange="angular.element(this).scope().select_change(1)" id="select_jobfair" style="width: 200px; height: 26px;" disabled="disabled">
								<option value="0" ><spring:message code="fap.comp.select_imposible" /></option>
								<c:forEach var="jobfair" items="${jobfair_list}">
									<option value="${jobfair.fap_jobfair_seq}" <c:if test="${fap_jobfair_seq == jobfair.fap_jobfair_seq}">selected</c:if>>${jobfair.fap_jobfair_title}</option>
								</c:forEach>
							</select>
							&emsp;&emsp;
							<%-- <span><spring:message code="fap.comp.search_jobfair_divide" /> : </span> --%>
							<select onchange="angular.element(this).scope().select_change()" id="select_jobfair_divide" disabled="disabled" style="width: 100px; height: 26px;">
								<option value="0" id="jobfair_divide_hidden" seq="0" hidden><spring:message code="fap.comp.select_imposible" /></option>
							</select>
						</div>		
					</div>
					<input type="hidden" id="fap_comp_id" value="${jobfair_list[0].fap_comp_id }">
					
					<div id="calendar" style="margin-top: 10px;">
					
					</div>
				</div>
				
			</div>
			
			<div id="rewrite_tab">
				<button id="progressingAdBtn" class="btn btn-primary2" ng-click="draw_prgressing_job_ad_list()"><spring:message code="fap.jobad.ad_on_process" /></button>
				
				<button id="standbyAdBtn" class="btn btn-primary2" ng-click="draw_standby_job_ad_list()"><spring:message code="fap.jobad.ad_stand_by" /></button>
				
				<button id="completedAdBtn" class="btn btn-primary2" ng-click="draw_completed_job_ad_list()"><spring:message code="fap.jobad.ad_completed" /></button>
				
				<button id="tempedAdBtn" class="btn btn-primary2" ng-click="draw_temped_job_ad_list()"><spring:message code="fap.jobad.ad_storage" /></button>
			</div>
			
			<div id="nowBBS">
				<!-- 채용공고 들어가는 부분 -->
			</div>
			
			<!-- 채용공고 수정페이지로 이동하는 폼 -->
			<form id="agency_job_ad_update_form" action="agency_job_ad_update_form" method="get">
				<input type="hidden" name="fap_job_ad_seq" id="fap_job_ad_seq" value="0">
			</form>
			<form id="agency_job_ad_read_form" action="agency_job_ad_read_form" method="get">
				<input type="hidden" name="fap_job_ad_seq" id="fap_job_ad_seq_read" value="0">
			</form>
			
			<form action="agency_job_ad_insert_form" method="post" onsubmit="javascript:return insert_param_set()">
				<input type="hidden" name="fap_jobfair_seq" id="insert_fap_jobfair_seq" value="${fap_jobfair_seq}">
				<input type="hidden" name="fap_jobfair_divide_seq" id="insert_fap_jobfair_divide_seq" value="${fap_jobfair_divide_seq}">
				<div id="recruitBtn"><button class="btn btn-primary"><spring:message code="fap.jobad.write_jobad" /></button></div>
			</form>		
			
		</div>
	</div>
</div>		 
	<%@include file="agency_footer.jsp"%>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Bridge Job Fair</title>
	<link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
	<link type="text/css" rel="stylesheet" href="<c:url value="/resources/segroup/society/fap/css/popModal.css" />">
	<link rel="stylesheet" type="text/css" href="<c:url value="/resources/segroup/society/fap/css/default.css" />" />
	<link type="text/css" rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto:400,500">		
	<script src="<c:url value="/resources/segroup/js/jquery-3.1.1.js" />"></script>
	<script src="<c:url value="/resources/segroup/js/jquery-ui.js" />"></script>
	<script src="<c:url value="/resources/segroup/js/angular.min.js" />"></script>	
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
	<script type="text/javascript">
		$(function() {
			$('#logout').off("click").on("click", function() {
				$('#logoutForm').submit();
				return false;
			});
			
			$('#nav li').hover(function() {
				$('ul', this).slideDown(200);
				$(this).children('a:first').addClass("hov");
			}, function() {
				$('ul', this).slideUp(100);
				$(this).children('a:first').removeClass("hov");		
			});
		})
		
		
	</script>
	<script type="text/javascript">
		var myApp = angular.module('myapp', []);		
		
		myApp.controller('RequiredDocController', ['$scope','$compile','$http', function($scope,$compile,$http){
				
				//개인내정서류 검색 후
				if('${fap_ad_seq}' != null && '${fap_ad_seq}' != 0){
					var fap_job_ad_seq = '${fap_ad_seq}';
					if('${comp_id}' != null && '${comp_id}' != ''){
						var fap_comp_id = '${comp_id}';
						$(".modal-body #fap_comp_id").val(fap_comp_id);
					}					
					if('${fap_divide_seq}' != null && '${fap_divide_seq}' != 0){
						var fap_jobfair_divide_seq = '${fap_divide_seq}';
					}
					
					//채용공고 재설정
					$http({
						method: 'POST',
						url: "/fap/agency/agency_job_ad_list_search",
						params : {
							fap_job_ad_seq : fap_job_ad_seq
							, fap_comp_id : fap_comp_id
							, fap_jobfair_divide_seq : fap_jobfair_divide_seq
						},
						headers : {
							"AJAX" : true
						}
					}).then(function successCallback(response) {
						//검색한 채용공고 목록
						$scope.job_ad_draw_3(response);
						
					}, function errorCallback(response) {
						if(response.status == 403){
							alert('<spring:message code="com.login.ajaxSesstion" javaScriptEscape="true" />');
							location.href = "/fap/agency/agency_login";
						}
					});					
					
					//검색한 채용공고 목록
					$scope.job_ad_draw_3 = function(response){
						$scope.job_ad_3 = response.data;
						var context = '';
						context += '<option value="0"><spring:message code="fap.comp.select_job_ad" /></option>';
						context += '<option ng-repeat="ad_3 in job_ad_3" value="{{ad_3.fap_job_ad_seq}}" ng-selected="${fap_ad_seq} == ad_3.fap_job_ad_seq">{{ad_3.fap_job_ad_title}}</option>';
						
						$("#select_job_ad").html($compile(context)($scope)); 	
					}					
					
					// 선택한 채용공고에 해당하는 공통 내정서류 전체 검색
					$http({
						method: 'POST',
						url: "/fap/agency/agency_common_required_doc_search_list",
						params : {
							fap_job_ad_seq : fap_job_ad_seq
							, fap_comp_id : fap_comp_id
						},
						headers : {
							"AJAX" : true
						}
					}).then(function successCallback(response) {
						$scope.common_required_doc_draw_3(response);
						
						$(".modal-body #fap_job_ad_seq").val(fap_job_ad_seq);
						
							$http({
								method: 'POST',
								url: "/fap/agency/agency_nominee_info_search_list",
								params : {
									fap_job_ad_seq : fap_job_ad_seq
									, fap_comp_id : fap_comp_id
								}
							}).then(function successCallback(response) {
								$scope.nominee_draw_3(response);
							}, function errorCallback(response) {
								
							});
						
					}, function errorCallback(response) {
						if(response.status == 403){
							alert('<spring:message code="com.login.ajaxSesstion" javaScriptEscape="true" />');
							location.href = "/fap/agency/agency_login";
						}
					});
					
					//검색한 공통 내정서류 리스트 
					$scope.common_required_doc_draw_3 = function(response){
						$scope.results_3 = response.data;
						var context = '';
						context += '<ul ng-if="results_3.length == 0"><li><h3><spring:message code="fap.comp.nominee_required_doc_no_list" /></h3></li></ul>';
						context += '<ul ng-repeat="result_3 in results_3" class="title2">';
		            	context += '<li class="wid1">{{result_3.fap_common_required_doc_title}}</li>';
		                context += '<li class="wid2">{{result_3.fap_common_required_doc_origin}}</li>';
		                context += '<li class="wid3"><button value="{{result_3.fap_common_required_doc_detail}}" ng-click="detail(result_3.fap_common_required_doc_detail)" class="detailBtn"><spring:message code="fap.common.details" /></button></li>';
		                context += '<li class="wid4"><button value="{{result_3.fap_common_required_doc_seq}}" ng-click="update(result_3.fap_common_required_doc_seq)" class="updateBtn"><spring:message code="fap.common.update.btn" /></button></li>';
		                context += '<li class="wid5"><button value="{{result_3.fap_common_required_doc_seq}}" class="deleteBtn" ng-click="delete_required_doc(result_3.fap_common_required_doc_seq, result_3.fap_common_required_doc_saved, result_3.fap_comp_id, result_3.fap_job_ad_seq, result_3.fap_jobfair_seq, result_3.fap_jobfair_divide_seq)"><spring:message code="fap.comp.required_doc_delete" /></button></li>';
		            	context += '</ul>';			
						
						$("#nuguBB2").html($compile(context)($scope)); 	
					}
					
					//검색한 내정자 정보 
					$scope.nominee_draw_3 = function(response){
						$scope.nominees_3 = response.data;
						context = '';
						context += '<ul ng-if="nominees_3.length == 0"><li><h3><spring:message code="fap.comp.nominee_required_doc_no_list" /></h3></li></ul>';
						context += '<ul ng-repeat="nominee_3 in nominees_3" class="tit2">';
						context += '<li class="wid1">{{$index+1}}</li>';
						context += '<li class="wid2" ng-if="nominee_3.nomineeNmList[0].fap_resume_lang_gb == \'B3100\' ">{{nominee_3.nomineeNmList[0].fap_resume_nm}}</li>';
						context += '<li class="wid3" ng-if="nominee_3.nomineeNmList[1].fap_resume_lang_gb == \'B3101\' ">{{nominee_3.nomineeNmList[1].fap_resume_nm}}</li>';
						context += '<li class="wid4" ng-if="nominee_3.nomineeNmList[2].fap_resume_lang_gb == \'B3102\' ">{{nominee_3.nomineeNmList[2].fap_resume_nm}}</li>';
						context += '<li class="wid5" ng-if="nominee_3.nomineeNmList[3].fap_resume_lang_gb == \'B3103\' ">{{nominee_3.nomineeNmList[3].fap_resume_nm}}</li>';
						context += '<li class="wid6" ng-if="nominee_3.fap_resume_gender == \'A0000\' "><code value="A0000"></code></li>';
						context += '<li class="wid6" ng-if="nominee_3.fap_resume_gender == \'A0001\' "><code value="A0000"></code></li>';
						context += '<li class="wid7">{{nominee_3.fap_resume_birth}}</li>';
						context += '<li class="wid8"><button value="{{nominee_3.fap_nominee_seq}}" ng-click="personal_doc(nominee_3.fap_nominee_seq)" class="personalDocBtn"><spring:message code="fap.comp.nominee_doc" /></button></li>';
	                	context += '</ul>';					
						
						$("#nuguBB4").html($compile(context)($scope));
						
					}
					
					//등록, 수정, 삭제 후 잡페어 세부 선택한 경우
					if('${fap_divide_seq}' != null && '${fap_divide_seq}' != 0){
						var fap_jobfair_divide_seq = '${fap_divide_seq}';
						$(".modal-body #fap_jobfair_divide_seq").val(fap_jobfair_divide_seq);
						//jobfair_divide 활성화
						$("#jobfair_divide_hidden").prop("selected", true);
						$("#select_jobfair_divide").html("<option value=\'"+0+"\' id=\"jobfair_divide_hidden\" seq=\"" + 0 + "\"  hidden><spring:message code="fap.comp.select" /></option>");					
						$("#select_jobfair_divide").attr("disabled", false);	
										
						$http({
							method : 'POST',
							url : '/fap/agency/agency_jobfair_divide_list_search',
							responseType : 'text',
							params : {
								fap_jobfair_seq: $("#select_jobfair option:selected").val()
								, fap_comp_id : $("#fap_comp_id").val()
							},
							headers : {
								"AJAX" : true
							}
						}).then(function successCallback(response) {
							var fap_jobfair_divide_seq = '${fap_divide_seq}';
							if(response.data.length > 1){
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
							}						
							
						}, function errorCallback(response) {
							if(response.status == 403){
								alert('<spring:message code="com.login.ajaxSesstion" javaScriptEscape="true" />');
								location.href = "/fap/agency/agency_login";
							}
						});					
					}
					
					//등록, 수정, 삭제 후 잡페어 세부 선택 안한 경우
					if('${fap_jobfair_seq}' != 0 && '${fap_jobfair_divide_seq}' == 0){
						$("#jobfair_divide_hidden").prop("selected", true);
						$("#select_jobfair_divide").html("<option value=\'"+0+"\' id=\"jobfair_divide_hidden\" seq=\"" + 0 + "\"  hidden><spring:message code="fap.comp.select" /></option>");					
						$("#select_jobfair_divide").attr("disabled", false);	
										
						$http({
							method : 'POST',
							url : '/fap/agency/agency_jobfair_divide_list_search',
							responseType : 'text',
							params : {
								fap_jobfair_seq: $("#select_jobfair option:selected").val()
								, fap_comp_id : $("#fap_comp_id").val()
							},
							headers : {
								"AJAX" : true
							}
						}).then(function successCallback(response) {
							var fap_jobfair_divide_seq = '${fap_jobfair_divide_seq}';
							if(response.data.length > 1){
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
							}						
							
						}, function errorCallback(response) {
							if(response.status == 403){
								alert('<spring:message code="com.login.ajaxSesstion" javaScriptEscape="true" />');
								location.href = "/fap/agency/agency_login";
							}
						});
					}					
				}
			
			
				//등록, 수정, 삭제 후 잡페어 세부 선택한 경우
				if('${fap_jobfair_divide_seq}' != 0){
					var fap_jobfair_divide_seq = '${fap_jobfair_divide_seq}';
					$(".modal-body #fap_jobfair_divide_seq").val(fap_jobfair_divide_seq);
					//jobfair_divide 활성화
					$("#jobfair_divide_hidden").prop("selected", true);
					$("#select_jobfair_divide").html("<option value=\'"+0+"\' id=\"jobfair_divide_hidden\" seq=\"" + 0 + "\"  hidden><spring:message code="fap.comp.select" /></option>");					
					$("#select_jobfair_divide").attr("disabled", false);	
									
					$http({
						method : 'POST',
						url : '/fap/agency/agency_jobfair_divide_list_search',
						responseType : 'text',
						params : {
							fap_jobfair_seq: $("#select_jobfair option:selected").val()
							, fap_comp_id : $("#fap_comp_id").val()
						},
						headers : {
							"AJAX" : true
						}
					}).then(function successCallback(response) {
						var fap_jobfair_divide_seq = '${fap_jobfair_divide_seq}';
						if(response.data.length > 1){
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
						}						
						
					}, function errorCallback(response) {
						if(response.status == 403){
							alert('<spring:message code="com.login.ajaxSesstion" javaScriptEscape="true" />');
							location.href = "/fap/agency/agency_login";
						}
					});					
				}
				
				//등록, 수정, 삭제 후 잡페어 세부 선택 안한 경우
				if('${fap_jobfair_seq}' != 0 && '${fap_jobfair_divide_seq}' == 0){
					$("#jobfair_divide_hidden").prop("selected", true);
					$("#select_jobfair_divide").html("<option value=\'"+0+"\' id=\"jobfair_divide_hidden\" seq=\"" + 0 + "\"  hidden><spring:message code="fap.comp.select" /></option>");					
					$("#select_jobfair_divide").attr("disabled", false);	
									
					$http({
						method : 'POST',
						url : '/fap/agency/agency_jobfair_divide_list_search',
						responseType : 'text',
						params : {
							fap_jobfair_seq: $("#select_jobfair option:selected").val()
							, fap_comp_id : $("#fap_comp_id").val()
						},
						headers : {
							"AJAX" : true
						}
					}).then(function successCallback(response) {
						var fap_jobfair_divide_seq = '${fap_jobfair_divide_seq}';
						if(response.data.length > 1){
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
						}						
						
					}, function errorCallback(response) {
						if(response.status == 403){
							alert('<spring:message code="com.login.ajaxSesstion" javaScriptEscape="true" />');
							location.href = "/fap/agency/agency_login";
						}
					});
				}
				
				
				//선택한 채용공고 정보
				if('${fap_job_ad_seq}' != 0){					
					var fap_job_ad_seq = '${fap_job_ad_seq}';
					var fap_jobfair_seq = $("#select_jobfair option:selected").val();
					var fap_comp_id = '${fap_comp_id}';
					if('${fap_jobfair_divide_seq}' != null){
						var fap_jobfair_divide_seq = '${fap_jobfair_divide_seq}';
					}
					//채용공고 재설정
					$http({
						method: 'POST',
						url: "/fap/agency/agency_job_ad_list_search",
						params : {
							fap_jobfair_seq: fap_jobfair_seq
							, fap_jobfair_divide_seq: fap_jobfair_divide_seq
							, fap_job_ad_seq : fap_job_ad_seq
							, fap_comp_id : fap_comp_id
						},
						headers : {
							"AJAX" : true
						}
					}).then(function successCallback(response) {
						//검색한 채용공고 목록
						$scope.job_ad_draw_1(response);
						
					}, function errorCallback(response) {
						if(response.status == 403){
							alert('<spring:message code="com.login.ajaxSesstion" javaScriptEscape="true" />');
							location.href = "/fap/agency/agency_login";
						}
					});					
					
					//검색한 채용공고 목록
					$scope.job_ad_draw_1 = function(response){
						$scope.job_ad_1 = response.data;
						var context = '';
						context += '<option value="0"><spring:message code="fap.comp.select_job_ad" /></option>';
						context += '<option ng-repeat="ad_1 in job_ad_1" value="{{ad_1.fap_job_ad_seq}}" ng-selected="${fap_job_ad_seq} == ad_1.fap_job_ad_seq">{{ad_1.fap_job_ad_title}}</option>';
						
						$("#select_job_ad").html($compile(context)($scope)); 	
					}
					
					
					
					// 선택한 채용공고에 해당하는 공통 내정서류 전체 검색
					$http({
						method: 'POST',
						url: "/fap/agency/agency_common_required_doc_search_list",
						params : {
							fap_job_ad_seq : fap_job_ad_seq
							, fap_comp_id : fap_comp_id
						},
						headers : {
							"AJAX" : true
						}
					}).then(function successCallback(response) {
						$scope.common_required_doc_draw_1(response);
						
						$(".modal-body #fap_job_ad_seq").val(fap_job_ad_seq);
						$(".modal-body #fap_jobfair_seq").val(fap_jobfair_seq);	
						$(".modal-body #fap_jobfair_divide_seq").val(fap_jobfair_divide_seq);
						$(".modal-body #fap_comp_id").val(fap_comp_id);	
						
							$http({
								method: 'POST',
								url: "/fap/agency/agency_nominee_info_search_list",
								params : {
									fap_job_ad_seq : fap_job_ad_seq
									, fap_comp_id : fap_comp_id
								}
							}).then(function successCallback(response) {
								$scope.nominee_draw_1(response);
							}, function errorCallback(response) {
								
							});
						
					}, function errorCallback(response) {
						if(response.status == 403){
							alert('<spring:message code="com.login.ajaxSesstion" javaScriptEscape="true" />');
							location.href = "/fap/agency/agency_login";
						}
					});
					
					//검색한 공통 내정서류 리스트 
					$scope.common_required_doc_draw_1 = function(response){
						$scope.results_1 = response.data;
						var context = '';
						context += '<ul ng-if="results_3.length == 0"><li><h3><spring:message code="fap.comp.nominee_required_doc_no_list" /></h3></li></ul>';
						context += '<ul ng-repeat="result_1 in results_1" class="title2">';
		            	context += '<li class="wid1">{{result_1.fap_common_required_doc_title}}</li>';
		                context += '<li class="wid2">{{result_1.fap_common_required_doc_origin}}</li>';
		                context += '<li class="wid3"><button value="{{result_1.fap_common_required_doc_detail}}" ng-click="detail(result_1.fap_common_required_doc_detail)" class="detailBtn"><spring:message code="fap.common.details" /></button></li>';
		                context += '<li class="wid4"><button value="{{result_1.fap_common_required_doc_seq}}" ng-click="update(result_1.fap_common_required_doc_seq)" class="updateBtn"><spring:message code="fap.comp.required_doc_update" /></button></li>';
		                context += '<li class="wid5"><button value="{{result_1.fap_common_required_doc_seq}}" class="deleteBtn" ng-click="delete_required_doc(result_1.fap_common_required_doc_seq, result_1.fap_common_required_doc_saved, result_1.fap_comp_id, result_1.fap_job_ad_seq, result_1.fap_jobfair_seq, result_1.fap_jobfair_divide_seq)"><spring:message code="fap.comp.required_doc_delete" /></button></li>';
		            	context += '</ul>';			
						
						$("#nuguBB2").html($compile(context)($scope)); 	
					}
					
					//검색한 내정자 정보 
					$scope.nominee_draw_1 = function(response){
						$scope.nominees_1 = response.data;
						context = '';
						context += '<ul ng-if="nominees_1.length == 0"><li><h3><spring:message code="fap.comp.nominee_required_doc_no_list" /></h3></li></ul>';
						context += '<ul ng-repeat="nominee_1 in nominees_1" class="tit2">';
						context += '<li class="wid1">{{$index+1}}</li>';
						context += '<li class="wid2" ng-if="nominee_1.nomineeNmList[0].fap_resume_lang_gb == \'B3100\' ">{{nominee_1.nomineeNmList[0].fap_resume_nm}}</li>';
						context += '<li class="wid3" ng-if="nominee_1.nomineeNmList[1].fap_resume_lang_gb == \'B3101\' ">{{nominee_1.nomineeNmList[1].fap_resume_nm}}</li>';
						context += '<li class="wid4" ng-if="nominee_1.nomineeNmList[2].fap_resume_lang_gb == \'B3102\' ">{{nominee_1.nomineeNmList[2].fap_resume_nm}}</li>';
						context += '<li class="wid5" ng-if="nominee_1.nomineeNmList[3].fap_resume_lang_gb == \'B3103\' ">{{nominee_1.nomineeNmList[3].fap_resume_nm}}</li>';
						context += '<li class="wid6" ng-if="nominee_1.fap_resume_gender == \'A0000\' "><code value="A0000"></code></li>';
						context += '<li class="wid6" ng-if="nominee_1.fap_resume_gender == \'A0001\' "><code value="A0000"></code></li>';
						context += '<li class="wid7">{{nominee_1.fap_resume_birth}}</li>';
						context += '<li class="wid8"><button value="{{nominee_1.fap_nominee_seq}}" ng-click="personal_doc(nominee_1.fap_nominee_seq)" class="personalDocBtn"><spring:message code="fap.comp.nominee_doc" /></button></li>';
	                	context += '</ul>';					
						
						$("#nuguBB4").html($compile(context)($scope));
						
					}
					
				}
			
			
	    		//검색창 변경
				$scope.search_change = function(flag){
					
					var context = '';
					$("#nuguBB2").html($compile(context)($scope)); 
					$("#nuguBB4").html($compile(context)($scope));
	    			
					//기업명 선택
					if(flag == 0){
						//잡페어 검색
						$http({
							method : 'POST',
							url : '/fap/agency/agency_company_jobfair_list_search',
							responseType : 'text',
							params : {
								fap_comp_id: $("#select_company option:selected").val()
							},
							headers : {
								"AJAX" : true
							}
						}).then(function successCallback(response) {
							//jobfair에 option 추가
							$("#select_jobfair").html($compile("<option value=" + 0 + "><spring:message code="fap.comp.select" /></option>")($scope));
							for(var i in response.data){
								$("#select_jobfair").append($compile("<option value=" + response.data[i].fap_jobfair_seq + ">" + response.data[i].fap_jobfair_title + "</option>")($scope));
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
						
					}
					
					//잡페어 선택
					if(flag == 1){
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
								fap_jobfair_seq: $("#select_jobfair option:selected").val()
								, fap_comp_id : $("#select_company option:selected").val()
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
						
					}
					
					//채용공고 재설정
					$http({
						method: 'POST',
						url: "/fap/agency/agency_job_ad_list_search",
						params : {
							fap_jobfair_seq: $("#select_jobfair option:selected").val()
							, fap_jobfair_divide_seq: $("#select_jobfair_divide option:selected").attr('seq')
							, fap_comp_id : $("#select_company option:selected").val()
						},
						headers : {
							"AJAX" : true
						}
					}).then(function successCallback(response) {
						//검색한 채용공고 목록
						$scope.job_ad_draw_2(response);
						
					}, function errorCallback(response) {
						if(response.status == 403){
							alert('<spring:message code="com.login.ajaxSesstion" javaScriptEscape="true" />');
							location.href = "/fap/agency/agency_login";
						}
					});	
					
					//검색한 채용공고 목록
					$scope.job_ad_draw_2 = function(response){
						$scope.job_ad_2 = response.data;
						var context = '';
						context += '<option value="0"><spring:message code="fap.comp.select_job_ad" /></option>';
						context += '<option ng-repeat="ad_2 in job_ad_2" value="{{ad_2.fap_job_ad_seq}}">{{ad_2.fap_job_ad_title}}</option>';
						
						$("#select_job_ad").html($compile(context)($scope)); 	
					}					
					
				}   
					
				//채용공고 변경
				$scope.job_ad_change = function(){
					var fap_job_ad_seq = $('#select_job_ad option:selected').val();
					var fap_comp_id = $("#select_company option:selected").val();
					var fap_jobfair_seq = $("#select_jobfair option:selected").val();
					var fap_jobfair_divide_seq = $("#select_jobfair_divide option:selected").attr('seq');
					
		    		// 선택한 채용공고에 해당하는 공통 내정서류 전체 검색
					$http({
						method: 'POST',
						url: "/fap/agency/agency_common_required_doc_search_list",
						params : {
							fap_job_ad_seq : fap_job_ad_seq
							, fap_comp_id : fap_comp_id
						},
						headers : {
							"AJAX" : true
						}
					}).then(function successCallback(response) {
						console.log(response);
						$scope.common_required_doc_draw_2(response);
						$(".modal-body #fap_job_ad_seq").val(fap_job_ad_seq);
						$(".modal-body #fap_jobfair_seq").val(fap_jobfair_seq);	
						$(".modal-body #fap_jobfair_divide_seq").val(fap_jobfair_divide_seq);	
						$(".modal-body #fap_comp_id").val(fap_comp_id);
						
							$http({
								method: 'POST',
								url: "/fap/agency/agency_nominee_info_search_list",
								params : {
									fap_job_ad_seq : fap_job_ad_seq
									, fap_comp_id : fap_comp_id
								}
							}).then(function successCallback(response) {
								$scope.nominee_draw_2(response);
							}, function errorCallback(response) {
								
							});
						
					}, function errorCallback(response) {
						if(response.status == 403){
							alert('<spring:message code="com.login.ajaxSesstion" javaScriptEscape="true" />');
							location.href = "/fap/agency/agency_login";
						}
					});
		    		
					//검색한 공통 내정서류 리스트 
					$scope.common_required_doc_draw_2 = function(response){
						$scope.results_2 = response.data;
						var context = '';
						context += '<ul ng-if="results_2.length == 0"><li><h3><spring:message code="fap.comp.nominee_required_doc_no_list" /></h3></li></ul>';
						context += '<ul ng-repeat="result_2 in results_2" class="title2">';
		            	context += '<li class="wid1">{{result_2.fap_common_required_doc_title}}</li>';
		                context += '<li class="wid2">{{result_2.fap_common_required_doc_origin}}</li>';
		                context += '<li class="wid3"><button value="{{result_2.fap_common_required_doc_detail}}" ng-click="detail(result_2.fap_common_required_doc_detail)" class="detailBtn"><spring:message code="fap.common.details" /></button></li>';
		                context += '<li class="wid4"><button value="{{result_2.fap_common_required_doc_seq}}" ng-click="update(result_2.fap_common_required_doc_seq)" class="updateBtn"><spring:message code="fap.comp.required_doc_update" /></button></li>';
		                context += '<li class="wid5" ><button value="{{result_2.fap_common_required_doc_seq}}" class="deleteBtn" ng-click="delete_required_doc(result_2.fap_common_required_doc_seq, result_2.fap_common_required_doc_saved, result_2.fap_comp_id, result_2.fap_job_ad_seq, result_2.fap_jobfair_seq, result_2.fap_jobfair_divide_seq)"><spring:message code="fap.comp.required_doc_delete" /></button></li>';
		            	context += '</ul>';			
						
						$("#nuguBB2").html($compile(context)($scope)); 	
					}
		    		
					//검색한 내정자 정보 
					$scope.nominee_draw_2 = function(response){
						$scope.nominees_2 = response.data;						
						context = '';
						context += '<ul ng-if="nominees_2.length == 0"><li><h3><spring:message code="fap.comp.nominee_required_doc_no_list" /></h3></li></ul>';
						context += '<ul ng-repeat="nominee_2 in nominees_2" class="tit2">';
						context += '<li class="wid1">{{$index+1}}</li>';
						context += '<li class="wid2" ng-if="nominee_2.nomineeNmList[0].fap_resume_lang_gb == \'B3100\' ">{{nominee_2.nomineeNmList[0].fap_resume_nm}}</li>';
						context += '<li class="wid3" ng-if="nominee_2.nomineeNmList[1].fap_resume_lang_gb == \'B3101\' ">{{nominee_2.nomineeNmList[1].fap_resume_nm}}</li>';
						context += '<li class="wid4" ng-if="nominee_2.nomineeNmList[2].fap_resume_lang_gb == \'B3102\' ">{{nominee_2.nomineeNmList[2].fap_resume_nm}}</li>';
						context += '<li class="wid5" ng-if="nominee_2.nomineeNmList[3].fap_resume_lang_gb == \'B3103\' ">{{nominee_2.nomineeNmList[3].fap_resume_nm}}</li>';
						context += '<li class="wid6" ng-if="nominee_2.fap_resume_gender == \'A0000\' "><code value="A0000"></code></li>';
						context += '<li class="wid6" ng-if="nominee_2.fap_resume_gender == \'A0001\' "><code value="A0000"></code></li>';
						context += '<li class="wid7">{{nominee_2.fap_resume_birth}}</li>';
						context += '<li class="wid8"><button value="{{nominee_2.fap_nominee_seq}}" ng-click="personal_doc(nominee_2.fap_nominee_seq)" class="personalDocBtn"><spring:message code="fap.comp.nominee_doc" /></button></li>';
	                	context += '</ul>';					
						
						$("#nuguBB4").html($compile(context)($scope));
						
					}
		    		
				}	
    					  		
		
			//개인서류 등록 페이지로 이동
			$scope.personal_doc = function(fap_nominee_seq){
				var fap_nominee_seq = fap_nominee_seq;
				location.href = "/fap/agency/agency_personal_required_doc_management?fap_nominee_seq=" + fap_nominee_seq;
			}
			
			//세부내용 모달로 띄우기
			$scope.detail = function(fap_common_required_doc_detail){
				var fap_common_required_doc_detail = fap_common_required_doc_detail;
				$("#required_doc_detail").val(fap_common_required_doc_detail);				
				$("#detailModal").modal();
			}			
			
			//수정할 내정서류 검색
			$scope.update = function(fap_common_required_doc_seq){
				var fap_common_required_doc_seq = fap_common_required_doc_seq;
				$http({
					method: 'POST',
					url: "/fap/agency/agency_common_required_doc_search",
					params : {
						'fap_common_required_doc_seq' : fap_common_required_doc_seq
					},
					headers : {
						"AJAX" : true
					}
				}).then(function successCallback(response) {
					$scope.update_required_doc_draw(response.data);
					$("#updateModal").modal();
				}, function errorCallback(response) {
					if(response.status == 403){
						alert('<spring:message code="com.login.ajaxSesstion" javaScriptEscape="true" />');
						location.href = "/fap/agency/agency_login";
					}
				});
			}
			
			//수정할 내정서류 MODAL
			$scope.update_required_doc_draw = function(result){
				$scope.result = result;
				var context = '';
				context += '<div class="modal fade" id="updateModal" tabindex="-1" role="dialog" aria-labelledby="modal" aria-hidden="true">';
				context += '<div class="modal-dialog">';
				context += '<div class="modal-content">';					
				context += '	<div class="modal-header">';
				context += '<h3 class="modal-title" id="modal"><spring:message code="fap.comp.common_required_doc_update" /></h3>';
				context += '<button type="button" class="close" data-dismiss="modal" aria-label="Close">';
				context += '<span aria-hidden="true">&times;</span>';
				context += '</button>';
				context += '</div>';
				context += '<form action="/fap/agency/agency_common_required_doc_update" method="post" onsubmit="return update_form_Check();" enctype="multipart/form-data">';
				context += '<div class="modal-body">';
				context += '<input type="hidden" name="fap_common_required_doc_seq" value="'+result.fap_common_required_doc_seq+'">';
				context += '<input type="hidden" name="fap_job_ad_seq" value="'+result.fap_job_ad_seq+'">';
				context += '<input type="hidden" name="fap_jobfair_seq" value="'+result.fap_jobfair_seq+'">';
				context += '<input type="hidden" name="fap_jobfair_divide_seq" value="'+result.fap_jobfair_divide_seq+'">';
				context += '<input type="hidden" name="fap_comp_id" value="'+result.fap_comp_id+'">';
				context += '<input type="hidden" name="fap_common_required_doc_origin" value="'+result.fap_common_required_doc_origin+'">';
				context += '<input type="hidden" name="fap_common_required_doc_saved" value="'+result.fap_common_required_doc_saved+'">';
				context += '<div class="form-group">';
				context += '<label><spring:message code="fap.comp.required_doc_title" /></label>';
				context += '<input type="text" name="fap_common_required_doc_title" id="fap_common_required_doc_update_title" value="'+result.fap_common_required_doc_title+'" class="form-control" maxlength="100">';
				context += '</div>';
				context += '<div class="form-row">';
				context += '<label><spring:message code="fap.common.details" /></label>';
				context += '</div>';
				context += '<div class="form-row">';
				context += '<textarea name="fap_common_required_doc_detail" id="fap_common_required_doc_update_detail" class="form-control" maxlength="500" style="text-align: inherit; width:670px; height: 100px;" >{{result.fap_common_required_doc_detail}}</textarea>';
				context += '</div>';
				context += '</div>';
				context += '<div class="form-group">';
				context += '<div class="file_update_div">';
				context += '<input type="button" value="'+result.fap_common_required_doc_origin+'" id="updateFileBtn" class="file_update_button" />';
				context += '<input type="file" class="file_input_hidden" name="fap_common_required_doc_file" id="fap_common_required_doc_update_file" value="'+result.fap_common_required_doc_origin+'" onchange="file_change(this.files[0].name)" >';
				context += '</div>';
				context += '</div>';							
				context += '<div class="modal-footer">';
				context += '<button type="button" class="btn btn-primary" data-dismiss="modal"><spring:message code="fap.comp.modal_cancel" /></button>';
				context += '<button type="submit" class="btn btn-primary"><spring:message code="fap.comp.required_doc_update" /></button>';
				context += '</div>';							
				context += '</form>';
				context += '</div>';
				context += '</div>';
				context += '</div>';
				
				$("#update_required_doc_div").html($compile(context)($scope)); 	
			}
			
			$scope.delete_required_doc =  function (
					fap_common_required_doc_seq
					, fap_common_required_doc_saved
					, fap_comp_id
					, fap_job_ad_seq
					, fap_jobfair_seq
					, fap_jobfair_divide_seq){
				
				var form = document.createElement("form");
		        var parm = new Array();
		        var input = new Array();

		        form.action = "/fap/agency/agency_common_required_doc_delete";
		        form.method = "post";
		        
				/* [name, value] */
		        parm.push( ['fap_common_required_doc_seq', fap_common_required_doc_seq ] );
		        parm.push( ['fap_common_required_doc_saved', fap_common_required_doc_saved ] );
		        parm.push( ['fap_comp_id', fap_comp_id ] );
		        parm.push( ['fap_job_ad_seq', fap_job_ad_seq ] );
		        parm.push( ['fap_jobfair_seq', fap_jobfair_seq ] );
		        parm.push( ['fap_jobfair_divide_seq', fap_jobfair_divide_seq ] );
		        
		        for (var i = 0; i < parm.length; i++) {
		            input[i] = document.createElement("input");
		            input[i].setAttribute("type", "hidden");
		            input[i].setAttribute('name', parm[i][0]);
		            input[i].setAttribute("value", parm[i][1]);
		            form.appendChild(input[i]);
		        }
		        document.body.appendChild(form);
		        form.submit();
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
	
	</script>
	<script type="text/javascript">
		//유효성 검사
		function form_Check() {
			var fap_common_required_doc_title = $('#fap_common_required_doc_title').val();
			var fap_common_required_doc_file = $('#fap_common_required_doc_file').val();
			var fap_job_ad_seq =$('#fap_job_ad_seq').val();
			
			//채용공고 선택
			if(fap_job_ad_seq == null || fap_job_ad_seq == 0){
				alert('<spring:message code="fap.err.select_job_ad" />');
				return false;
			}
			
			//서류제목
			if(fap_common_required_doc_title == ''){
				alert('<spring:message code="fap.err.title_input" />');
				$('#fap_common_required_doc_title').focus();
				return false;
			}
			//서류파일
			if(fap_common_required_doc_file == ''){
				alert('<spring:message code="fap.err.doc_input" />');
				return false;
			}			
		}
		
		function update_form_Check() {
			var fap_common_required_doc_update_title = $('#fap_common_required_doc_update_title').val();						
			//수정한 서류제목
			if(fap_common_required_doc_update_title == ''){
				alert('<spring:message code="fap.err.title_input" />');
				$('#fap_common_required_doc_title').focus();
				return false;
			}		
		}
		
		//파일명 변경
		function file_change(file_name){
			var file_name= file_name
			$('#updateFileBtn').val(file_name);
		}	
		
	</script>
	<script type="text/javascript">
		//수정 파일명 변경
		$(document).ready(function() { 
		    $("#fap_common_required_doc_update_file").on("change", function() { 
		    	$("#updateFileBtn").html(this.value); 
		    }); 
		});
		
		//등록 MODAL
		function register(){
			if($('#select_job_ad option:selected').val() == 0){
				alert('<spring:message code="fap.err.select_job_ad" />');
				return false;
			}
			$("#registerModal").modal();
		}
		
	</script>
	<style type="text/css">
		#top {
			background : #eee;
			border-bottom : 1px solid #ddd;
			padding : 0 10px;
			line-height : 40px;
			font-size : 12px;
			margin-top: 30px;
			text-align: left;
		}
	</style>
</head>
<body ng-app="myapp" ng-controller="RequiredDocController">
	<%@include file="agency_menu.jsp"%>

	<div id="subcontents">
       <div>      		
      		<h1><spring:message code="fap.comp.common_required_doc_management" /></h1>
       </div>
	 	<div>
	 	<div id="top">
	 		<span><spring:message code="fap.comp.search_comp_nm" /> : </span>
			<select onchange="angular.element(this).scope().search_change(0)" id="select_company" style="width: 150px; height: 26px;">
				<option value="${resultMap.agency_info.fap_comp_id}" <c:if test="${fap_comp_id == resultMap.agency_info.fap_comp_id}">selected</c:if>>${resultMap.agency_info.fap_comp_ja_nm}</option>
				<c:forEach var="company" items="${resultMap.select_approval_comp}">
					<option value="${company.fap_comp_id}" <c:if test="${fap_comp_id == company.fap_comp_id}">selected</c:if>>${company.fap_comp_ja_nm}</option>
				</c:forEach>
			</select>
      		<span><spring:message code="fap.comp.search_jobfair" /> : </span>
			<select onchange="angular.element(this).scope().search_change(1)" id="select_jobfair" style="width: 200px; height: 26px;">
				<option value="0" ><spring:message code="fap.comp.select" /></option>
				<c:forEach var="jobfair" items="${company_jobfair_list}">
					<option value="${jobfair.fap_jobfair_seq}" <c:if test="${fap_jobfair_seq == jobfair.fap_jobfair_seq}">selected</c:if>>${jobfair.fap_jobfair_title}</option>
				</c:forEach>
			</select>
			<span><spring:message code="fap.comp.search_jobfair_divide" /> : </span>
			<select onchange="angular.element(this).scope().search_change()" id="select_jobfair_divide" disabled="disabled" style="width: 100px; height: 26px;">
				<option value="0" id="jobfair_divide_hidden" seq="0" hidden><spring:message code="fap.comp.select_imposible" /></option>
			</select>
			<span><spring:message code="fap.comp.search_job_ad" /> : </span>
	      	<select id="select_job_ad" onchange="angular.element(this).scope().job_ad_change()" style="width: 200px; height: 26px;">
			<option value="0"><spring:message code="fap.comp.select_job_ad" /></option>
			<c:forEach var="job_ad" items="${company_job_ad_list}">									
				<option value="${job_ad.fap_job_ad_seq}" <c:if test="${fap_job_ad_seq == job_ad.fap_job_ad_seq}">selected</c:if> >${job_ad.fap_job_ad_title}</option>		
			</c:forEach>
			</select>
		</div>		
      </div>
      <br><br>
      
	<div id="nugu">
		<div id="nuguBox">
		 	<ul>
		        <li class="jointxt1"><spring:message code="fap.comp.common_required_doc_insert" />&ensp;		       	 	
		       	 	<img alt="" src="/resources/segroup/society/fap/images/main/plus_icon.png" onclick="register()">
		        </li>
		        <li class="jointxt2"><img src="/resources/segroup/society/fap/images/login_bar.gif" /></li>
				<li> 
        		<div id="nuguBB1">
	                <ul class="title1">
	                	<li class="wid1"><spring:message code="fap.comp.required_doc_title" /></li>
	                    <li class="wid2"><spring:message code="fap.comp.required_doc_file" /></li>
	                    <li class="wid3"><spring:message code="fap.comp.required_doc_detail" /></li>
	                    <li class="wid4"><spring:message code="fap.comp.required_doc_update" /></li>
	                    <li class="wid5"><spring:message code="fap.comp.required_doc_delete" /></li>
	                </ul>
	             </div>
	             <div id="nuguBB2">   
	                 	                
				</div>
    		</ul>

		   <ul>
		        <li class="jointxt1"><spring:message code="fap.comp.nominee" /></li>
		        <li class="jointxt2"><img src="/resources/segroup/society/fap/images/login_bar.gif" /></li>
		        <li> 
	        		<div id="nuguBB3">
		                <ul class="tit1">
		                	<li class="wid1"><spring:message code="fap.comp.required_no" /></li>
		                    <li class="wid2"><spring:message code="fap.comp.nominee_ko_nm" /></li>
		                    <li class="wid3"><spring:message code="fap.comp.nominee_en_nm" /></li>
		                    <li class="wid4"><spring:message code="fap.comp.nominee_han_nm" /></li>
		                    <li class="wid5"><spring:message code="fap.comp.nominee_ja_nm" /></li>
		                    <li class="wid6"><spring:message code="fap.comp.nominee_gender" /></li>
		                    <li class="wid7"><spring:message code="fap.comp.nominee_birth" /></li>
		                    <li class="wid8"><spring:message code="fap.comp.nominee_doc" /></li>
		                </ul>		                
		            </div>
		            <div id="nuguBB4">    
		                
		             </div>        
		        </li>
		    </ul> 
		</div>

		 <input type="hidden" id="fap_comp_id" value="${company_info.fap_comp_id }">
	
	</div>
</div>

	<%@include file="agency_footer.jsp"%>
		
	<!-- 내정자 공통서류 등록 MODAL 시작-->
	<div class="modal fade" id="registerModal" tabindex="-1" role="dialog" aria-labelledby="modal" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
			
				<div class="modal-header">
					<h3 class="modal-title" id="modal"><spring:message code="fap.comp.common_required_doc_insert" /></h3>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				
				<form action="/fap/agency/agency_common_required_doc_insert" method="post" onsubmit="return form_Check();" enctype="multipart/form-data">
					<div class="modal-body">					
						<!-- 잡페어 -->
						<input type="hidden" id="fap_job_ad_seq" name="fap_job_ad_seq" value="0">
						<input type="hidden" id="fap_jobfair_seq" name="fap_jobfair_seq" value="0">
						<input type="hidden" id="fap_jobfair_divide_seq" name="fap_jobfair_divide_seq" value="0">
						<input type="hidden" id="fap_comp_id" name="fap_comp_id" value="">
						<div class="form-group">
							<label><spring:message code="fap.comp.required_doc_title" /></label>
							<input type="text" name="fap_common_required_doc_title" id="fap_common_required_doc_title" class="form-control" maxlength="100">
						</div>
						<div class="form-row">
							<label><spring:message code="fap.common.details" /></label>
						</div>
						<div class="form-row">
							<textarea name="fap_common_required_doc_detail" id="fap_common_required_doc_detail" class="form-control" maxlength="500" style=" width:670px; height: 100px;"></textarea>
						</div>
					</div>
					<div class="form-group">
						&emsp;<input type="file" name="fap_common_required_doc_file" id="fap_common_required_doc_file">
					</div>
					
					<div class="modal-footer">
						<button type="button" class="btn btn-primary" data-dismiss="modal"><spring:message code="fap.comp.modal_cancel" /></button>
						<button type="submit" class="btn btn-primary"><spring:message code="fap.comp.modal_insert" /></button>
					</div>
					
				</form>
			</div>
		</div>
	</div>
	<!-- 내정자 공통서류 등록 MODAL 종료-->
	
	<!-- 내정자 공통서류 수정 MODAL 시작-->
		<div id="update_required_doc_div">
		
		</div>
	<!-- 내정자 공통서류 수정 MODAL 종료-->

	<!-- 내정자 공통서류 상세 MODAL 시작-->
	<div class="modal fade" id="detailModal" tabindex="-1" role="dialog" aria-labelledby="modal" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">			
				<div class="modal-header">
					<h3 class="modal-title" id="modal"><spring:message code="fap.comp.required_doc_detail" /></h3>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>				
					<div class="modal-body">
						<div class="form-row">
							<label><spring:message code="fap.common.details" /></label>
						</div>
						<div class="form-row">
							<textarea id="required_doc_detail" class="form-control" maxlength="500" style=" width:670px; height: 100px;"></textarea>
						</div>
					</div>
			</div>
		</div>
	</div>
	<!-- 내정자 공통서류 상세 MODAL 종료-->

	
</body>
</html>
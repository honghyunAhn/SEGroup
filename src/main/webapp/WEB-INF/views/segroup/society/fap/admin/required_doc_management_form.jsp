<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Bridge Job Fair</title>
	<script src="<c:url value="/resources/segroup/js/jquery-3.1.1.js" />"></script>
	<script src="<c:url value="/resources/segroup/js/jquery-ui.js" />"></script>
	<script src="<c:url value="/resources/segroup/js/angular.min.js" />"></script>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
	<script type="text/javascript">
		$(function() {
			$('#logout').off("click").on("click", function() {
				$('#logoutForm').submit();
				return false;
			});
		})
	</script>
	<script type="text/javascript">
		var myApp = angular.module('myapp', []);		
		
		myApp.controller('RequiredDocController', ['$scope','$compile','$http', function($scope,$compile,$http){	
						
			//1. 내정자 공통서류 수정, 삭제 후
			if('${fap_job_ad_seq}' != null && '${fap_job_ad_seq}' != 0 && '${fap_comp_id}' != null && '${fap_comp_id}' != ''){
				var fap_job_ad_seq = '${fap_job_ad_seq}';
				var fap_jobfair_seq = '${fap_jobfair_seq}';
				var fap_comp_id = '${fap_comp_id}';
				console.log('1111111');
				
				
				$http({
					method: 'POST',
					url: "/fap/admin/common_required_doc_search_list",
					params : {
						'fap_job_ad_seq' : fap_job_ad_seq, 'fap_comp_id' : fap_comp_id
					}
				}).then(function successCallback(response) {
					$scope.common_required_doc_draw(response);
					$(".modal-body #fap_job_ad_seq").val(fap_job_ad_seq);
					
					$http({
						method: 'POST',
						url: "/fap/admin/nominee_info_search_list",
						params : {
							'fap_job_ad_seq' : fap_job_ad_seq, 'fap_comp_id' : fap_comp_id
						}
					}).then(function successCallback(response) {							
							$scope.nominee_draw_1(response);
							
							//검색창 변경 시 채용공고목록 검색
							$http({
								method: 'POST',
								url: "/fap/admin/job_ad_list_search",
								params : {
									'fap_jobfair_seq' : fap_jobfair_seq, 'fap_comp_id' : fap_comp_id
								}
							}).then(function successCallback(response) {
								//fap_job_ad_select에 option 추가
								$scope.job_ad_draw_1(response);
								
								//등록 폼에 hidden값 추가
								$('#fap_jobfair_seq').val(fap_jobfair_seq);
								$('#fap_comp_id').val(fap_comp_id);
								$('#fap_job_ad_seq').val(fap_job_ad_seq);
								
							}, function errorCallback(response) {
								
							});
							
							//검색한 채용공고 목록
							$scope.job_ad_draw_1 = function(response){
								$scope.job_Ad_1 = response.data;
								var context = '';
								context += '<option value="0">채용공고 선택</option>';
								context += '<option ng-repeat="ad_1 in job_Ad_1" value="{{ad_1.fap_job_ad_seq}}" ng-selected="${fap_job_ad_seq} == ad_1.fap_job_ad_seq " >{{ad_1.fap_job_ad_title}}</option>';
								
								$("#fap_job_ad_select").html($compile(context)($scope)); 	
							}
							
						}, function errorCallback(response) {
						
						});					
				}, function errorCallback(response) {
					
				});
				
				//검색한 공통 내정서류 리스트 
				$scope.common_required_doc_draw = function(response){
					$scope.results = response.data;
					var context = '';
					context += '<tr ng-repeat="result in results | filter:query">';
					context += '<td><input type="text" value="{{result.fap_common_required_doc_title}}" readonly="readonly"></td>';
					context += '<td><span><input type="text" value="{{result.fap_common_required_doc_origin}}" style="width: 400px;" readonly="readonly"></span></td>';
					context += '<td><button value="{{result.fap_common_required_doc_detail}}" ng-click="detail(result.fap_common_required_doc_detail)">설명보기</button></td>';
					context += '<td><a href="/file_download?origin={{result.fap_common_required_doc_origin}}&saved={{result.fap_common_required_doc_saved}}&path=/fap/company/required_doc_file/{{result.fap_comp_id}}_{{result.fap_job_ad_seq}}"><button value="{{result.fap_common_required_doc_seq}}">다운로드</button></a></td>';
					context += '<td><button value="{{result.fap_common_required_doc_seq}}" ng-click="update(result.fap_common_required_doc_seq)">수정</button></td>';
					context += '<td><a href="/fap/admin/common_required_doc_delete?fap_common_required_doc_seq={{result.fap_common_required_doc_seq}}&fap_common_required_doc_saved={{result.fap_common_required_doc_saved}}&fap_comp_id={{result.fap_comp_id}}&fap_job_ad_seq={{result.fap_job_ad_seq}}&fap_jobfair_seq={{result.fap_jobfair_seq}}"><button value="{{result.fap_common_required_doc_seq}}">삭제</button></a></td>';
					context += '</tr>';
					
					$("#search_data").html($compile(context)($scope)); 	
				}
				
				//검색한 내정자 정보 
				$scope.nominee_draw_1 = function(response){
					var fap_job_ad_seq = $('#fap_job_ad_select').val();
					$scope.nominees_1 = response.data;				
					var index = 1;
					context = '';
					context += '<tr ng-repeat="nomi_1 in nominees_1 | filter:query">';
					context += '<td>';
					context += '{{$index+1}}';
					context += '</td>';	
					context += '<td ng-if="nomi_1.nomineeNmList[0].fap_resume_lang_gb == \'B3100\' ">';
					context += '{{nomi_1.nomineeNmList[0].fap_resume_nm}}';
					context += '</td>';	
					context += '<td ng-if="nomi_1.nomineeNmList[1].fap_resume_lang_gb == \'B3101\' ">';
					context += '{{nomi_1.nomineeNmList[1].fap_resume_nm}}';
					context += '</td>';
					context += '<td ng-if="nomi_1.nomineeNmList[2].fap_resume_lang_gb == \'B3102\' ">';
					context += '{{nomi_1.nomineeNmList[2].fap_resume_nm}}';
					context += '</td>';
					context += '<td ng-if="nomi_1.nomineeNmList[3].fap_resume_lang_gb == \'B3103\' ">';
					context += '{{nomi_1.nomineeNmList[3].fap_resume_nm}}';
					context += '</td>';
					context += '<td ng-if="nomi_1.fap_resume_gender == \'A0000\' ">';
					context += '<span selectcode value="A0000"></span>';
					context += '</td>';
					context += '<td ng-if="nomi_1.fap_resume_gender == \'A0001\' ">';
					context += '<span selectcode value="A0001"></span>';
					context += '</td>';
					context += '<td>{{nomi_1.fap_resume_birth}}</td>';
					context += '<td><button value="{{nomi_1.fap_nominee_seq}}" ng-click="personal_doc(nomi_1.fap_nominee_seq, ad_seq)">개인서류</button></td>';
					context += '</tr>';
					
					$("#nominee_data").html($compile(context)($scope));
					
				}
				
			}
			
			//2. 개인서류 이동 후
			if('${job_ad_seq}' != 0){
				var fap_job_ad_seq = '${job_ad_seq}';
				var fap_comp_id = $('#fap_jobfair_comp_select').val();
				var fap_jobfair_seq = $('#fap_jobfair_select').val();
				console.log('2222222');
				console.log(fap_job_ad_seq);
				console.log(fap_comp_id);
				console.log(fap_jobfair_seq);
				
				$http({
					method: 'POST',
					url: "/fap/admin/common_required_doc_search_list",
					params : {
						'fap_job_ad_seq' : fap_job_ad_seq, 'fap_comp_id' : fap_comp_id
					}
				}).then(function successCallback(response) {
					$scope.common_required_doc_draw_2(response);
					$(".modal-body #fap_job_ad_seq").val(fap_job_ad_seq);
					
					$http({
						method: 'POST',
						url: "/fap/admin/nominee_info_search_list", 
						params : {
							'fap_job_ad_seq' : fap_job_ad_seq, 'fap_comp_id' : fap_comp_id
						}
					}).then(function successCallback(response) {							
							$scope.nominee_draw_2(response);
							
							//검색창 변경 시 채용공고목록 검색
							$http({
								method: 'POST',
								url: "/fap/admin/job_ad_list_search",
								params : {
									'fap_jobfair_seq' : fap_jobfair_seq, 'fap_comp_id' : fap_comp_id
								}
							}).then(function successCallback(response) {
								//fap_job_ad_select에 option 추가
								$scope.job_ad_draw_4(response);
								
								//등록 폼에 hidden값 추가
								$('#fap_jobfair_seq').val(fap_jobfair_seq);
								$('#fap_comp_id').val(fap_comp_id);
								$('#fap_job_ad_seq').val(fap_job_ad_seq);
								
							}, function errorCallback(response) {
								
							});
							
						}, function errorCallback(response) {
						
						});					
				}, function errorCallback(response) {
					
				});
				
				//검색한 채용공고 목록
				$scope.job_ad_draw_4 = function(response){
					$scope.job_Ad_4 = response.data;
					var context = '';
					context += '<option value="0">채용공고 선택</option>';
					context += '<option ng-repeat="ad_4 in job_Ad_4" value="{{ad_4.fap_job_ad_seq}}" ng-selected="${job_ad_seq} == ad_4.fap_job_ad_seq">{{ad_4.fap_job_ad_title}}</option>';
					
					$("#fap_job_ad_select").html($compile(context)($scope)); 	
				}
				
				//검색한 공통 내정서류 리스트 
				$scope.common_required_doc_draw_2 = function(response){
					$scope.docu = response.data;
					var context = '';
					context += '<tr ng-repeat="doc in docu | filter:query">';
					context += '<td><input type="text" value="{{doc.fap_common_required_doc_title}}" readonly="readonly"></td>';
					context += '<td><span><input type="text" value="{{doc.fap_common_required_doc_origin}}" style="width: 400px;" readonly="readonly"></span></td>';
					context += '<td><button value="{{doc.fap_common_required_doc_detail}}" ng-click="detail(doc.fap_common_required_doc_detail)">설명보기</button></td>';
					context += '<td><a href="/file_download?origin={{doc.fap_common_required_doc_origin}}&saved={{doc.fap_common_required_doc_saved}}&path=/fap/company/required_doc_file/{{doc.fap_comp_id}}_{{doc.fap_job_ad_seq}}"><button value="{{doc.fap_common_required_doc_seq}}">다운로드</button></a></td>';
					context += '<td><button value="{{doc.fap_common_required_doc_seq}}" ng-click="update(doc.fap_common_required_doc_seq)">수정</button></td>';
					context += '<td><a href="/fap/admin/common_required_doc_delete?fap_common_required_doc_seq={{doc.fap_common_required_doc_seq}}&fap_common_required_doc_saved={{doc.fap_common_required_doc_saved}}&fap_comp_id={{doc.fap_comp_id}}&fap_job_ad_seq={{doc.fap_job_ad_seq}}&fap_jobfair_seq={{doc.fap_jobfair_seq}}"><button value="{{doc.fap_common_required_doc_seq}}">삭제</button></a></td>';
					context += '</tr>';
					
					$("#search_data").html($compile(context)($scope)); 	
				}
				
				//검색한 내정자 정보 
				$scope.nominee_draw_2 = function(response){
					var fap_job_ad_seq = $('#fap_job_ad_select').val();
					$scope.nominee_2 = response.data;
					context = '';
					context += '<tr ng-repeat="nomi_2 in nominee_2 | filter:query">';
					context += '<td>';
					context += '{{$index+1}}';
					context += '</td>';	
					context += '<td ng-if="nomi_2.nomineeNmList[0].fap_resume_lang_gb == \'B3100\' ">';
					context += '{{nomi_2.nomineeNmList[0].fap_resume_nm}}';
					context += '</td>';	
					context += '<td ng-if="nomi_2.nomineeNmList[1].fap_resume_lang_gb == \'B3101\' ">';
					context += '{{nomi_2.nomineeNmList[1].fap_resume_nm}}';
					context += '</td>';	
					context += '<td ng-if="nomi_2.nomineeNmList[2].fap_resume_lang_gb == \'B3102\' ">';
					context += '{{nomi_2.nomineeNmList[2].fap_resume_nm}}';
					context += '</td>';	
					context += '<td ng-if="nomi_2.nomineeNmList[3].fap_resume_lang_gb == \'B3103\' ">';
					context += '{{nomi_2.nomineeNmList[3].fap_resume_nm}}';
					context += '</td>';	
					context += '<td ng-if="nomi_2.fap_resume_gender == \'A0000\' ">';
					context += '<span selectcode value="A0000"></span>';
					context += '</td>';
					context += '<td ng-if="nomi_2.fap_resume_gender == \'A0001\' ">';
					context += '<span selectcode value="A0001"></span>';
					context += '</td>';
					context += '<td>{{nomi_2.fap_resume_birth}}</td>';
					context += '<td><button value="{{nomi_2.fap_nominee_seq}}" ng-click="personal_doc(nomi_2.fap_nominee_seq, ad_seq)">개인서류</button></td>';
					context += '</tr>';
					
					$("#nominee_data").html($compile(context)($scope));
					
				}				
				
			}
			
			//3. 검색창 변경
			$scope.search_change = function(){
				var fap_jobfair_seq = $('#fap_jobfair_select').val();
				var fap_comp_id = $('#fap_jobfair_comp_select').val();
				var fap_job_ad_seq = $('#fap_job_ad_select').val();
				$scope.ad_seq = fap_job_ad_seq;
				$scope.comp_id = fap_comp_id;	
				
				//삭제나 수정 후 잡페어 선택창 변경
				if(fap_jobfair_seq != '${fap_jobfair_seq}'){
					var context = ''							
					$("#search_data").html($compile(context)($scope));
					$("#nominee_data").html($compile(context)($scope));
				}
				
				//잡페어 선택 시 회사목록 검색
				if(fap_jobfair_seq != 0){
					$http({
						method: 'POST',
						url: "/fap/admin/job_ad_comp_list_select",
						params : {
							'fap_jobfair_seq' : fap_jobfair_seq
						}
					}).then(function successCallback(response) {
						//fap_jobfair_comp_select에 option 추가
						$scope.comp_draw(response);
						
						//회사 미선택 시 div 삭제
						if(fap_comp_id == ''){
							var context = ''							
							$("#search_data").html($compile(context)($scope));
							$("#nominee_data").html($compile(context)($scope));
						}
						//삭제나 수정 후 회사 선택창 변경
						if(fap_comp_id != '${fap_comp_id}'){
							var context = ''							
							$("#search_data").html($compile(context)($scope));
							$("#nominee_data").html($compile(context)($scope));
						}
						
					}, function errorCallback(response) {
						
					});
				}
				
				//검색창 변경 시 채용공고목록 검색
				$http({
					method: 'POST',
					url: "/fap/admin/job_ad_list_search",
					params : {
						'fap_jobfair_seq' : fap_jobfair_seq, 'fap_comp_id' : fap_comp_id
					}
				}).then(function successCallback(response) {
					//fap_job_ad_select에 option 추가
					$scope.job_ad_draw_2(response);
					
				}, function errorCallback(response) {
					
				});
				
				//검색한 채용공고 목록
				$scope.job_ad_draw_2 = function(response){
					$scope.job_Ad_2 = response.data;
					var context = '';
					context += '<option value="0">채용공고 선택</option>';
					context += '<option ng-repeat="ad_2 in job_Ad_2" value="{{ad_2.fap_job_ad_seq}}" >{{ad_2.fap_job_ad_title}}</option>';
					
					$("#fap_job_ad_select").html($compile(context)($scope)); 	
				}
				
				
				//채용공고 변경 시 내정자 공통서류, 내정자 정보 검색
				if(fap_job_ad_seq != 0){
					$scope.ad_seq = $('#fap_job_ad_select').val();
					$http({
						method: 'POST',
						url: "/fap/admin/common_required_doc_search_list",
						params : {
							'fap_job_ad_seq' : fap_job_ad_seq, 'fap_comp_id' : fap_comp_id
						}
					}).then(function successCallback(response) {
						$scope.common_required_doc_draw(response);
						$(".modal-body #fap_job_ad_seq").val(fap_job_ad_seq);
						
						$http({
							method: 'POST',
							url: "/fap/admin/nominee_info_search_list",
							params : {
								'fap_job_ad_seq' : fap_job_ad_seq, 'fap_comp_id' : fap_comp_id
							}
						}).then(function successCallback(response) {							
								$scope.nominee_draw_3(response);
								
								//검색창 변경 시 채용공고목록 검색
								$http({
									method: 'POST',
									url: "/fap/admin/job_ad_list_search",
									params : {
										'fap_jobfair_seq' : fap_jobfair_seq, 'fap_comp_id' : fap_comp_id
									}
								}).then(function successCallback(response) {
									//fap_job_ad_select에 option 추가
									$scope.job_ad_draw_3(response);
									
									//등록 폼에 hidden값 추가
									$('#fap_jobfair_seq').val(fap_jobfair_seq);
									$('#fap_comp_id').val(fap_comp_id);
									$('#fap_job_ad_seq').val(fap_job_ad_seq);
									
								}, function errorCallback(response) {
									
								});
								
							}, function errorCallback(response) {
							
							});					
					}, function errorCallback(response) {
						
					});
					
					//검색한 채용공고 목록
					$scope.job_ad_draw_3 = function(response){
						$scope.job_Ad_3 = response.data;
						var context = '';
						context += '<option value="0">채용공고 선택</option>';
						context += '<option ng-repeat="ad_3 in job_Ad_3" value="{{ad_3.fap_job_ad_seq}}" ng-selected="ad_seq == ad_3.fap_job_ad_seq">{{ad_3.fap_job_ad_title}}</option>';
						
						$("#fap_job_ad_select").html($compile(context)($scope)); 	
					}
				
				}else{					
					var context = ''							
					$("#search_data").html($compile(context)($scope));
					$("#nominee_data").html($compile(context)($scope));
				}
				
					//검색한 공통 내정서류 리스트 
					$scope.common_required_doc_draw = function(response){
						$scope.results = response.data;
						var context = '';
						context += '<tr ng-repeat="result in results | filter:query">';
						context += '<td><input type="text" value="{{result.fap_common_required_doc_title}}" readonly="readonly"></td>';
						context += '<td><span><input type="text" value="{{result.fap_common_required_doc_origin}}" style="width: 400px;" readonly="readonly"></span></td>';
						context += '<td><button value="{{result.fap_common_required_doc_detail}}" ng-click="detail(result.fap_common_required_doc_detail)">설명보기</button></td>';
						context += '<td><a href="/file_download?origin={{result.fap_common_required_doc_origin}}&saved={{result.fap_common_required_doc_saved}}&path=/fap/company/required_doc_file/{{result.fap_comp_id}}_{{result.fap_job_ad_seq}}"><button value="{{result.fap_common_required_doc_seq}}">다운로드</button></a></td>';
						context += '<td><button value="{{result.fap_common_required_doc_seq}}" ng-click="update(result.fap_common_required_doc_seq)">수정</button></td>';
						context += '<td><a href="/fap/admin/common_required_doc_delete?fap_common_required_doc_seq={{result.fap_common_required_doc_seq}}&fap_common_required_doc_saved={{result.fap_common_required_doc_saved}}&fap_comp_id={{result.fap_comp_id}}&fap_job_ad_seq={{result.fap_job_ad_seq}}&fap_jobfair_seq={{result.fap_jobfair_seq}}"><button value="{{result.fap_common_required_doc_seq}}">삭제</button></a></td>';
						context += '</tr>';
						
						$("#search_data").html($compile(context)($scope)); 	
					}
					
					//검색한 내정자 정보 
					$scope.nominee_draw_3 = function(response){
						$scope.nominee_3 = response.data;
						context = '';
						context += '<tr ng-repeat="nomi_3 in nominee_3 | filter:query">';
						context += '<td>';
						context += '{{$index+1}}';
						context += '</td>';	
						context += '<td ng-if="nomi_3.nomineeNmList[0].fap_resume_lang_gb == \'B3100\' ">';
						context += '{{nomi_3.nomineeNmList[0].fap_resume_nm}}';
						context += '</td>';
						context += '<td ng-if="nomi_3.nomineeNmList[1].fap_resume_lang_gb == \'B3101\' ">';
						context += '{{nomi_3.nomineeNmList[1].fap_resume_nm}}';
						context += '</td>';	
						context += '<td ng-if="nomi_3.nomineeNmList[2].fap_resume_lang_gb == \'B3102\' ">';
						context += '{{nomi_3.nomineeNmList[2].fap_resume_nm}}';
						context += '</td>';	
						context += '<td ng-if="nomi_3.nomineeNmList[3].fap_resume_lang_gb == \'B3103\' ">';
						context += '{{nomi_3.nomineeNmList[3].fap_resume_nm}}';
						context += '</td>';	
						context += '<td ng-if="nomi_3.fap_resume_gender == \'A0000\' ">';
						context += '<span selectcode value="A0000"></span>';
						context += '</td>';
						context += '<td ng-if="nomi_3.fap_resume_gender == \'A0001\' ">';
						context += '<span selectcode value="A0001"></span>';
						context += '</td>';
						context += '<td>{{nomi_3.fap_resume_birth}}</td>';
						context += '<td><button value="{{nomi_3.fap_nominee_seq}}" ng-click="personal_doc(nomi_3.fap_nominee_seq, ad_seq)">개인서류</button></td>';
						context += '</tr>';
						
						$("#nominee_data").html($compile(context)($scope));
						
					}
					
				}
				
				//검색한 회사 목록
				$scope.comp_draw = function(response){
					$scope.job_ad_comp_list = response.data;					
					var context ='';
					context += '<option value="">회사 선택</option>';
					context += '<option ng-repeat="comp_list in job_ad_comp_list" value="{{comp_list.fap_comp_id}}" ng-selected="comp_id == comp_list.fap_comp_id">{{comp_list.fap_comp_en_nm}}</option>';
					
					$("#fap_jobfair_comp_select").html($compile(context)($scope)); 	
				}					
			
			//개인서류 등록 페이지로 이동
			$scope.personal_doc = function(fap_nominee_seq, fap_job_ad_seq){
				var fap_nominee_seq = fap_nominee_seq;
				location.href = "/fap/admin/personal_required_doc_management?fap_nominee_seq=" + fap_nominee_seq + "&fap_job_ad_seq=" + fap_job_ad_seq;
			}
			
			//세부내용 alert로 띄우기
			$scope.detail = function(fap_common_required_doc_detail){
				var fap_common_required_doc_detail = fap_common_required_doc_detail;
				alert(fap_common_required_doc_detail);
			}			
			
			//수정할 내정서류 검색
			$scope.update = function(fap_common_required_doc_seq){
				var fap_common_required_doc_seq = fap_common_required_doc_seq;
				$http({
					method: 'POST',
					url: "/fap/admin/common_required_doc_select",
					params : {
						'fap_common_required_doc_seq' : fap_common_required_doc_seq
					}
				}).then(function successCallback(response) {
					$scope.update_required_doc_draw(response.data);
					$("#updateModal").modal();
				}, function errorCallback(response) {
				
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
				context += '<h5 class="modal-title" id="modal">내정자 공통서류 수정</h5>';
				context += '<button type="button" class="close" data-dismiss="modal" aria-label="Close">';
				context += '<span aria-hidden="true">&times;</span>';
				context += '</button>';
				context += '</div>';
				context += '<form action="/fap/admin/common_required_doc_update" method="post" onsubmit="return update_form_Check();" enctype="multipart/form-data">';
				context += '<div class="modal-body">';
				context += '<input type="hidden" name="fap_common_required_doc_seq" value="'+result.fap_common_required_doc_seq+'">';
				context += '<input type="hidden" name="fap_job_ad_seq" value="'+result.fap_job_ad_seq+'">';
				context += '<input type="hidden" name="fap_comp_id" value="'+result.fap_comp_id+'">';
				context += '<input type="hidden" name="fap_common_required_doc_origin" value="'+result.fap_common_required_doc_origin+'">';
				context += '<input type="hidden" name="fap_common_required_doc_saved" value="'+result.fap_common_required_doc_saved+'">';
				context += '<div class="form-group">';
				context += '<label>서류 제목</label>';
				context += '<input type="text" name="fap_common_required_doc_title" id="fap_common_required_doc_update_title" value="'+result.fap_common_required_doc_title+'" class="form-control" maxlength="100">';
				context += '</div>';
				context += '<div class="form-row">';
				context += '<label>서류 상세</label>';
				context += '</div>';
				context += '<div class="form-row">';
				context += '<input type="text" name="fap_common_required_doc_detail" id="fap_common_required_doc_update_detail" value="'+result.fap_common_required_doc_detail+'" class="form-control" maxlength="500" style="text-align: inherit; width:490px; height: 100px;" >';
				context += '</div>';
				context += '</div>';
				context += '<div class="form-group">';
				context += '<div class="file_input_div">';
				context += '<input type="button" value="'+result.fap_common_required_doc_origin+'" id="updateFileBtn" class="file_input_button" />';
				context += '<input type="file" class="file_input_hidden" name="fap_common_required_doc_file" id="fap_common_required_doc_update_file" value="'+result.fap_common_required_doc_origin+'" onchange="file_change(this.files[0].name)" >';
				context += '</div>';
				context += '</div>';							
				context += '<div class="modal-footer">';
				context += '<button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>';
				context += '<button type="submit" class="btn btn-primary">수정하기</button>';
				context += '</div>';							
				context += '</form>';
				context += '</div>';
				context += '</div>';
				context += '</div>';
				
				$("#update_required_doc_div").html($compile(context)($scope)); 	
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
				alert('채용공고를 선택하세요.');
				return false;
			}
			
			//서류제목
			if(fap_common_required_doc_title == ''){
				alert('제목은 필수 입력 사항입니다.');
				$('#fap_common_required_doc_title').focus();
				return false;
			}
			//서류파일
			if(fap_common_required_doc_file == ''){
				alert('서류는 필수 입력 사항입니다.');
				return false;
			}			
		}
		
		function update_form_Check() {
			var fap_common_required_doc_update_title = $('#fap_common_required_doc_update_title').val();						
			//수정한 서류제목
			if(fap_common_required_doc_update_title == ''){
				alert('제목은 필수 입력 사항입니다.');
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
	</script>
	
	<style type="text/css">
		.file_input_div
		{
		margin : 10px;
		position: relative;
		width: 450px;
		height: 50px;
		overflow: hidden;
		}
		 
		.file_input_button
		{
		width: 450px;
		position: absolute;
		top: 0px;
		background-color: #464946;
		color: #FFFFFF;
		border-style: solid;
		}
		 
		.file_input_hidden
		{
		font-size: 45px;
		position: absolute;
		right: 0px;
		top: 0px;
		opacity: 0;
		 
		filter: alpha(opacity=0);
		-ms-filter: "alpha(opacity=0)";
		-khtml-opacity: 0;
		-moz-opacity: 0;
		}

	</style>
</head>
<body ng-app="myapp" ng-controller="RequiredDocController">
<!--<sec:authorize access="isAuthenticated()">
	<sec:authentication property="details" var="check" />
</sec:authorize>
<form id="logoutForm" action="/fap/company/logout" method="post" style="display: none">
	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
</form>
<c:if test="${not empty check }">
	<a href="#none" id="logout">로그아웃</a>
</c:if>-->

<%@include file="admin_menu.jsp"%>
	<br>
	<div class="page_title">
		<h2>관리자 내정서류관리 페이지</h2>
	</div>
	<br>
 

	<table>
		<thead>
			<tr>
				<th>내정서류 관리</th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td>
					<select id="fap_jobfair_select" onchange="angular.element(this).scope().search_change()">
						<option value="0">잡페어 선택</option>
						<c:forEach var="jobfair" items="${jobfair_list}">									
							<option value="${jobfair.fap_jobfair_seq}" <c:if test="${fap_jobfair_seq == jobfair.fap_jobfair_seq}">selected</c:if>>${jobfair.fap_jobfair_title}</option>		
						</c:forEach>
					</select>
				</td>
			</tr>
			<tr>
				<td>
					<select id="fap_jobfair_comp_select" onchange="angular.element(this).scope().search_change()">
						<option value="">회사 선택</option>
						<c:forEach var="comp" items="${comp_list}">
							<option value="${comp.fap_comp_id}" <c:if test="${fap_comp_id == comp.fap_comp_id}">selected</c:if>>${comp.fap_comp_en_nm}</option>		
						</c:forEach>
					</select>					
				</td>
			</tr>
			<tr>
				<td>
					<select id="fap_job_ad_select" onchange="angular.element(this).scope().search_change()">
						<option value="0">채용공고 선택</option>
						
					</select>					
				</td>
			</tr>
		</tbody>
	</table>
	<br>

	<h4 style="display: inline;">내정자 공통서류</h4>
	<img alt="" src="/resources/segroup/society/fap/images/main/plus_icon.png" data-toggle="modal" data-target="#registerModal">
	<br>
	
	<div id="fap_required_doc_div">
		<table border="1" bordercolor="black">
			<thead>
				<tr>
				<th>내정서류제목&emsp;</th>
				<th>내정서류파일&emsp;</th>
				<th>설명보기&emsp;</th>
				<th>다운로드&emsp;</th>
				<th>수정&emsp;</th>
				<th>삭제&emsp;</th>
				</tr>
			</thead>
			<tbody id="search_data">
			
			</tbody>
		</table>	
	</div>
	<br><br><br><br><br>
	
	<h4>내정자</h4>
	
	<div id="nominee_div">
		<table border="1" bordercolor="black">
			<thead>
				<tr>
					<th>No&emsp;</th>
					<th>이름(한글)&emsp;</th>
					<th>이름(영어)&emsp;</th>
					<th>이름(한자)&emsp;</th>
					<th>이름(일어)&emsp;</th>
					<th>성별&emsp;</th>
					<th>생년월일&emsp;</th>
					<th>개인서류&emsp;</th>
				</tr>
			</thead>
			<tbody id="nominee_data">
			
			</tbody>
		</table>
	</div>
		
	<!-- 내정자 공통서류 등록 MODAL 시작-->
	<div class="modal fade" id="registerModal" tabindex="-1" role="dialog" aria-labelledby="modal" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
			
				<div class="modal-header">
					<h5 class="modal-title" id="modal">내정자 공통서류 등록</h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				
				<form action="/fap/admin/common_required_doc_insert" method="post" onsubmit="return form_Check();" enctype="multipart/form-data">
					<div class="modal-body">					
						<!-- 잡페어 -->
						<input type="hidden" id="fap_jobfair_seq" name="fap_jobfair_seq" value="0">
						<input type="hidden" id="fap_comp_id" name="fap_comp_id" value="">
						<input type="hidden" id="fap_job_ad_seq" name="fap_job_ad_seq" value="0">
						
						
						<div class="form-group">
							<label>서류 제목</label>
							<input type="text" name="fap_common_required_doc_title" id="fap_common_required_doc_title" class="form-control" maxlength="100">
						</div>
						<div class="form-row">
							<label>서류 상세</label>
						</div>
						<div class="form-row">
							<textarea name="fap_common_required_doc_detail" id="fap_common_required_doc_detail" class="form-control" maxlength="500" style=" width:490px; height: 100px;"></textarea>
						</div>
					</div>
					<div class="form-group">
						&emsp;<input type="file" name="fap_common_required_doc_file" id="fap_common_required_doc_file">
					</div>
					
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
						<button type="submit" class="btn btn-primary">등록하기</button>
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
</body>
</html>
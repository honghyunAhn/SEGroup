<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<script src="<c:url value="/resources/segroup/js/jquery-3.1.1.js" />"></script>
	<script src="<c:url value="/resources/segroup/js/jquery-ui.js" />"></script>
	<script src="<c:url value="/resources/segroup/js/angular.min.js" />"></script>
	<!-- modal을 위한 bootstrap 시작-->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
	<!--  modal을 위한 bootstrap 끝 -->	
	<link type="text/css" rel="stylesheet" href="<c:url value="/resources/segroup/society/fap/css/newAdminDefault.css" />" media="" />
	<title>Bridge Job Fair</title>
	
	<script type="text/javascript">	
		
		var myApp = angular.module('myapp', []);	
		
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
		
		myApp.controller('PermissionController', ['$scope','$compile','$http', function($scope,$compile,$http){			
	        
	        //검색 변경
			$scope.search_change = function(flag){
				
				//채용기업명 변경
				if(flag == 1){
					//채용공고 검색
					$http({
						method: 'POST',
						url: "/fap/admin/search_qna_job_ad",
						params : {
							fap_comp_id : $('#compSelect').val()
						}
					}).then(function successCallback(response) {
						 $scope.job_ad_draw(response);
					}, function errorCallback(response) {
					
					});
					
					//채용공고
					$scope.job_ad_draw = function(response){
						$scope.job_ad = response.data;
						var context = '';
						context += '<option value="">선택</option>';
						context += '<option value="{{ad.fap_job_ad_seq}}" ng-repeat="ad in job_ad">{{ad.fap_job_ad_title}}</option>';
						$("#jobAdSelect").html($compile(context)($scope));
					}
				}
				
				var fap_comp_id = $('#compSelect').val();
	        	var fap_job_ad_seq = $('#jobAdSelect').val();				
				var fap_job_qna_question_per = $('#perSelect').val();
				var user_nm = $('#searchName').val();
				
				//질문 정보 검색
				$http({
					method: 'POST',
					url: "/fap/admin/search_job_qna_question_info",
					params : {
						fap_comp_id : fap_comp_id
						, fap_job_ad_seq : fap_job_ad_seq
						, fap_job_qna_question_per : fap_job_qna_question_per
						, user_nm : user_nm
					}
				}).then(function successCallback(response) {
					 console.log(response);
					 $scope.list_draw(response);
				}, function errorCallback(response) {
				
				});
				
				//hidden에 value 입력
				$("#fap_comp_id").val(fap_comp_id);
				$("#fap_job_ad_seq").val(fap_job_ad_seq);
				$("#fap_job_qna_question_per").val(fap_job_qna_question_per);
				$("#user_nm").val(user_nm);		
				
			}
			
			//승인여부 선택
			$scope.per_draw = function(){
				var context = '';
				context += '<option value="">선택</option>';
				context += '<option selectcode value="C5100"></option>';
				context += '<option selectcode value="C5101"></option>';
				$("#perSelect").html($compile(context)($scope));
			}
			
			$scope.per_draw();	
			
			//검색결과 리스트
			$scope.list_draw = function(response){
				$scope.results = response.data;
				var context = '';				
				context += '<tr>';
				context += '<tr ng-repeat="result in results | filter:query">';
				context += '<td><input type="checkbox" name="checkBoxs" value="{{result.fap_job_qna_question_seq}}" class="form-control"></td>';
				context += '<td>{{$index+1}}</td>';				
				context += '<td>{{result.fap_comp_en_nm}}</td>';				
				context += '<td>{{result.fap_job_ad_title}}</td>';
				context += '<td ng-click="qna_content(result.fap_job_qna_question_seq, result.fap_job_qna_question_content)">{{result.fap_job_qna_question_title}}</td>';	
				context += '<td>{{result.user_nm}}</td>';
				context += '<td>{{result.fap_job_qna_question_ins_dt}}</td>';
				context += '<td ng-if="result.fap_job_qna_question_per == \'C5100\' ">';				
				context += '<span selectcode value="C5100"></span>';
				context += '</td>';
				context += '<td ng-if="result.fap_job_qna_question_per == \'C5101\' ">';				
				context += '<span selectcode value="C5101"></span>';
				context += '</td>';
				context += '<td ng-if="result.fap_job_qna_refuse_reason == null"><button ng-click="insert_refuse_reason(result.fap_job_qna_question_seq)" class="btn_search" style="width:100%;">작성</button></td>';
				context += '<td ng-if="result.fap_job_qna_refuse_reason != null"><button ng-click="update_refuse_reason(result.fap_job_qna_question_seq, result.fap_job_qna_refuse_reason)" class="btn_search" style="width:100%; background-color:crimson;">수정</button></td>';
				context += '</tr>';

				$("#search_data").html($compile(context)($scope)); 				
							
			}
			
			//질문내용 읽기 modal
			$scope.qna_content = function(seq, content){
				$("#question_content").val(content);					
				$("#contentModal").modal();
			}
			
			//미승인사유 작성 modal
			$scope.insert_refuse_reason = function(seq){
				$(".modal-body #insert_fap_job_qna_question_seq").val(seq);
				$("#insertModal").modal();
			}
			//미승인사유 수정 modal
			$scope.update_refuse_reason = function(seq, reason){
				$(".modal-body #update_fap_job_qna_question_seq").val(seq);
				$(".modal-body #update_fap_job_qna_refuse_reason").val(reason);				
				$("#updateModal").modal();
			}
			
		}]);		
		
		var allChecked = false;
		function all_agree(){
			if(!allChecked) {
				//해당화면에 전체 checkbox들을 체크해준다
				$("input[type=checkbox]").prop("checked",true);
				allChecked = true;
			} else {
				//해당화면에 모든 checkbox들의 체크를해제시킨다.
				$("input[type=checkbox]").prop("checked",false);
	            allChecked = false;
			}
		}
	
		function qna_permission() {
			//질문 승인
			var fap_jobfair_user_qna_seq_list = new Array();
			$("input:checkbox[name=checkBoxs]:checked").each(function(){
				fap_jobfair_user_qna_seq_list.push($(this).val());
			});
			if(fap_jobfair_user_qna_seq_list.length == 0){
          	 	alert('승인할 지원자를 선택하세요.');
          		return;
            }
			
			//hidden value값 가져오기
			var fap_comp_id = $("#fap_comp_id").val();
			var fap_job_ad_seq = $("#fap_job_ad_seq").val();
			var fap_job_qna_question_per = $("#fap_job_qna_question_per").val();
			var user_nm = $("#user_nm").val();
			
			location.href="/fap/admin/jobfair_user_qna_permission?fap_jobfair_user_qna_seq_list=" + fap_jobfair_user_qna_seq_list + "&fap_comp_id=" + fap_comp_id
					+ "&fap_job_ad_seq=" + fap_job_ad_seq + "&fap_job_qna_question_per=" + fap_job_qna_question_per + "&user_nm" + user_nm;

	     }
		
		function qna_nonpermission() {
			//질문 승인
			var fap_jobfair_user_qna_seq_list = new Array();
			$("input:checkbox[name=checkBoxs]:checked").each(function(){
				fap_jobfair_user_qna_seq_list.push($(this).val());
			});
			if(fap_jobfair_user_qna_seq_list.length == 0){
          	 	alert('미승인할 지원자를 선택하세요.');
          		return;
            }
			
			//hidden value값 가져오기
			var fap_comp_id = $("#fap_comp_id").val();
			var fap_job_ad_seq = $("#fap_job_ad_seq").val();
			var fap_job_qna_question_per = $("#fap_job_qna_question_per").val();
			var user_nm = $("#user_nm").val();
			
			location.href="/fap/admin/jobfair_user_qna_nonpermission?fap_jobfair_user_qna_seq_list=" + fap_jobfair_user_qna_seq_list + "&fap_comp_id=" + fap_comp_id
					+ "&fap_job_ad_seq=" + fap_job_ad_seq + "&fap_job_qna_question_per=" + fap_job_qna_question_per + "&user_nm" + user_nm;

	     }
			
	</script>
	
	<style type="text/css">
	#myModal, #modal_dialog, #modal_content, #modal_body {
		height: 1px;
	}
	
	.wrap {
		width: 95%;
		position: relative;
		display: inline-block;
	}
	
	.wrap textarea {
		width: 100%;
		resize: none;
		line-height: 1.6em;
	}
	
	.wrap span {
		position: absolute;
		bottom: 10px;
		right: 1px;
	}
	
	#counter {
		background: rgba(255, 0, 0, 0.5);
		border-radius: 0.5em;
		padding: 0 .5em 0 .5em;
		font-size: 0.75em;
	}
	</style>
		
</head>
<body id="myBody" ng-app="myapp" ng-controller="PermissionController">
 <%@include file="admin_menu.jsp"%>
	<div class="container">
		<br>
		<div class="page_title">
			<h2>JobFair 지원자 채용공고 질문 승인 페이지</h2>
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
						<th>채용기업명으로 검색</th>
						<td>
							<select id="compSelect" onchange="angular.element(this).scope().search_change(1)" class="selectMid">
								<option value="">선택</option>
								<c:forEach var="comp" items="${qna_comp_list}" varStatus="status">
									<option value="${comp.fap_comp_id}">${comp.fap_comp_en_nm }</option>
								</c:forEach>
							</select>
						</td>
					</tr>
					<tr>
						<th>채용공고로 검색</th>	
						<td>
							<select id="jobAdSelect" onchange="angular.element(this).scope().search_change(2)" class="selectMid">
								<option value="0">선택</option>						
							</select>
						</td>
					</tr>
					<tr>
						<th>승인 여부로 검색</th>	
						<td>
							<select id="perSelect" onchange="angular.element(this).scope().search_change(3)" class="selectMid">
							</select>
						</td>
					</tr>
					<tr>
						<th>질문자명으로 검색</th>
						<td>
							<input type="text" id="searchName">
							<button type="button" class="btn_search" ng-click="search_change()">검색</button>
						</td>
					</tr>
				</table>
				<div class="sub_search_box">
					<button type="button" class="btn_search" onclick="qna_permission()">질문승인</button>
					<button type="button" class="btn_search" onclick="qna_nonpermission()">질문 미승인</button>
					<button type="button" class="btn_search" onclick="all_agree()">전체선택 / 해제</button>
				</div>
			</div>
		</div>
		<table class="table" style="margin-top: 70px;">
			<thead>
				<tr>
					<th>선택 &emsp;</th>
					<th>No &emsp;</th>
					<th>채용기업 &nbsp;</th>
					<th>채용공고 &nbsp;</th>
					<th>질문제목 &emsp;</th>
					<th>질문자 &emsp;</th>
					<th>등록일 &nbsp;</th>
					<th>승인여부 &nbsp;</th>
					<th>미승인사유 &emsp;</th>
				</tr>
			</thead>
			<tbody id="search_data">
			</tbody>
		</table>
	</div>
	<input type="hidden" id="fap_comp_id" name="fap_comp_id" value="">
	<input type="hidden" id="fap_job_ad_seq" name="fap_job_ad_seq" value="0">
	<input type="hidden" id="fap_job_qna_question_per" name="fap_job_qna_question_per" value="">
	<input type="hidden" id="user_nm" name="user_nm" value="">
	
	
	<!-- 채용공고 QNA질문 내용 MODAL 시작-->
	<div class="modal fade" id="contentModal" tabindex="-1" role="dialog" aria-labelledby="modal" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">			
				<div class="modal-header">
					<h4 class="modal-title" id="modal">질문내용</h4>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>				
					<div class="modal-body">
						<div class="form-row">
							<label></label>
						</div>
						<div class="form-row">
							<textarea id="question_content" class="form-control" maxlength="500" style="text-align: inherit; width:670px; height: 200px;"></textarea>
						</div>
					</div>
			</div>
		</div>
	</div>
	<!-- 채용공고 QNA질문 내용 MODAL 종료-->
	
	<!-- 승인거절사유 등록 MODAL 시작-->
	<div class="modal fade" id="insertModal" tabindex="-1" role="dialog" aria-labelledby="modal" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
			
				<div class="modal-header">
					<h4 class="modal-title" id="modal">미승인사유 작성</h4>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				
				<form action="/fap/admin/insert_qna_question_refuse_reason" method="post" onsubmit="return form_Check();" enctype="multipart/form-data">
					<div class="modal-body">					
						<!-- 잡페어 -->
						<input type="hidden" id="insert_fap_job_qna_question_seq" name="fap_job_qna_question_seq" value="0">
						<div class="form-row">
							<label>미승인사유</label>
						</div>
						<div class="form-row">
							<textarea name="fap_job_qna_refuse_reason" id="insert_fap_job_qna_refuse_reason" class="form-control" maxlength="500" style="width: 670px; height: 100px;"></textarea>
						</div>
					</div>
					
					<div class="modal-footer">
						<button type="button" class="btn btn-primary" data-dismiss="modal"><spring:message code="fap.comp.modal_cancel" /></button>
						<button type="submit" class="btn btn-primary"><spring:message code="fap.comp.modal_insert" /></button>
					</div>
					
				</form>
			</div>
		</div>
	</div>
	<!-- 승인거절사유 등록 MODAL 종료-->
	
	<!-- 승인거절사유 수정 MODAL 시작-->
	<div class="modal fade" id="updateModal" tabindex="-1" role="dialog" aria-labelledby="modal" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
			
				<div class="modal-header">
					<h4 class="modal-title" id="modal">미승인사유 수정</h4>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				
				<form action="/fap/admin/update_qna_question_refuse_reason" method="post" onsubmit="return form_Check();" enctype="multipart/form-data">
					<div class="modal-body">					
						<!-- 잡페어 -->
						<input type="hidden" id="update_fap_job_qna_question_seq" name="fap_job_qna_question_seq" value="0">
						<div class="form-row">
							<label>미승인사유</label>
						</div>
						<div class="form-row">
							<textarea name="fap_job_qna_refuse_reason" id="update_fap_job_qna_refuse_reason" class="form-control" maxlength="500" style="width: 670px; height: 100px;"></textarea>
						</div>
					</div>
					
					<div class="modal-footer">
						<button type="button" class="btn btn-primary" data-dismiss="modal"><spring:message code="fap.comp.modal_cancel" /></button>
						<button type="submit" class="btn btn-primary"><spring:message code="fap.common.update.btn" /></button>
					</div>
					
				</form>
			</div>
		</div>
	</div>
	<!-- 승인거절사유 수정 MODAL 종료-->
	
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">	
	<script src="<c:url value="/resources/segroup/js/jquery-3.1.1.js" />"></script>
	<script src="<c:url value="/resources/segroup/js/angular.min.js" />"></script>
	<!-- modal을 위한 bootstrap -->
	<link rel="stylesheet" type="text/css" href="<c:url value="/resources/segroup/society/fap/css/adminDefault.css" />" />
	<link rel="stylesheet" type="text/css" href="<c:url value="/resources/segroup/society/fap/css/default.css" />" />
	<link type="text/css" rel="stylesheet" href="<c:url value="/resources/segroup/society/fap/css/popModal.css" />">
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
	<title>Bridge Job Fair</title>
	<script type="text/javascript">
		$(function(){
			
			$(".resume_print").off("click").on("click",function(){
				
				var check_flag = false;
				var context = '';
				
				$.each($("input:checkbox[name='applier_check']:checked"),function(index,item){
					check_flag = true;
					var fap_resume_seq = $(this).attr("resume_seq");
					context += '<input type="hidden" name="fap_resume_seq" value="'+fap_resume_seq+'">';
				})
				
				if(!check_flag){
					alert('<spring:message code="fap.comp.app_print_comment" />');
				}else{
					$("#resume_popup").html(context);
					
					var popupX = (window.screen.width / 2) - ( 1200 / 2 );
			        var popupY = (window.screen.height / 2) - ( 700 / 2 ) - 50;
					
					var resume_popup = document.resume_popup;
					window.open('','resume_print',"width=1200,height=700,left='+popupX+',top='+popupY+',screenX='+popupX+',screenY='+popupY+',toolbar=no,location=no,directories=no,status=no,menubar=no,resizable=yes,scrollbars=no,copyhistory=no,scrollbars=yes");
					resume_popup.target = 'resume_print';
					resume_popup.submit();
				}
				
			})
		})
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
		
		myApp.controller('AdminController', ['$scope','$compile','$http','$timeout', function($scope,$compile,$http,$timeout){
			$scope.open_pt_change = function(){
				$scope.open_pt_init();
			}
			
			$scope.search_nm = function(){
				$scope.open_pt_init();
			}
			
			$scope.open_pt_init = function(){
				var searchNm = $("#searchName").val();
				var countPerPage = $("#count_per_page").val();
				var fap_open_pt_seq = $('#open_pt_title option:selected').val();
				if(fap_open_pt_seq == ""){
					alert("설명회를 선택해 주세요");
					return;
				}
				
				var fap_open_pt_gb = $("#fap_open_pt_gb").val();
				var page = $("#page").val();
				
				$http({
					url: "/fap/admin/fap_open_edu_applier_list",
					method: 'post',
					params: {
							fap_open_pt_seq : fap_open_pt_seq,
							fap_open_pt_gb : fap_open_pt_gb,
							searchNm : searchNm,
							page : page,
							countPerPage : countPerPage
					},
				}).then(function successCallback(response) {
					$scope.open_pt_list_draw(response.data);
				}, function errorCallback(response) {
					console.log(response);
				});
			}
			
			$scope.open_pt_list_draw = function(data){
				
				var count = '총 : '+data.count+'명';
				var num = ($("#page").val() - 1) * 10 + 1;
				var context = '';
				
				$.each(data.result,function(index, item){
					context += '<tr>';
					context += '<td><input type="checkbox" class="dispaly_block resume-check" resume_seq="'+item.fap_resume_seq+'" name="applier_check" value="'+item.fap_open_pt_apply_seq+'"></td>';
					context += '<td>'+num+'</td>';
					context += '<td>'+item.user_nm+'</td>';
					context += '<td>'+item.user_birth+'</td>';
					context += '<td><code value="'+item.user_sex+'"></code></td>';
					context += '<td>'+item.user_email+'</td>';
					context += '<td>'+item.user_phone+'</td>';
					context += '<td>'+item.user_sc_nm+'</td>';
					if(item.fap_personal_user_edu_level == 'B3300'){
						context += '<td><code value="'+item.user_sc_major+'"></code></td>';
					}else{
						context += '<td>'+item.user_sc_major+'</td>';
					}
					context += '<td><button value="'+item.fap_resume_seq+'" id="'+item.user_id+'" ng-click="resumeModal($event)">확인</button></td>';
					context += '<td><code value="'+item.fap_open_pt_resume_gb+'"></code></td>';
					context += '<td><button value="'+item.fap_open_pt_resume_seq+'" ng-click="settingModal($event)">적용</button></td>';
					context += '<td>'+item.fap_open_pt_apply_ins_dt+'</td>';
					context += '</tr>';
					num++;
				})
				
				var pageNavi = '';
				if(data.navi.endPageGroup != 1){
					pageNavi += '<div class="faq-body-page">';
					pageNavi += '<div class="page-navi">';
					pageNavi += '<ul>';
					pageNavi += '<li>';
					if(data.navi.currentPage <= 1){
						pageNavi += '<span class="left-arrow">&lt;</span>';
					}else{
						pageNavi += '<a ng-click="pageFnc(\''+(data.navi.currentPage - 1)+'\')">&lt;</a>';
					}
					pageNavi += '</li>';
					for(var i=data.navi.startPageGroup; i <=data.navi.endPageGroup; i++){
						pageNavi += '<li>';
						if(data.navi.currentPage == i){
							pageNavi += '<span class="now">'+i+'</span>';
						}else{
							pageNavi += '<a ng-click="pageFnc(\''+i+'\')">'+i+'</a>';
						}
						pageNavi += '</li>';
					}
					pageNavi += '<li>';
					if(data.navi.currentPage >= data.navi.totalPageCount){
						pageNavi += '<span class="left-arrow">&gt;</span>';
					}else{
						pageNavi += '<a ng-click="pageFnc(\''+(data.navi.currentPage +1)+'\')">&gt;</a>';
					}
					pageNavi += '</li>';
					pageNavi += '</ul>';
					pageNavi += '</div>';
					pageNavi += '</div>';
				}
										
				$(".tbody").html($compile(context)($scope));
				$(".total_count").html(count);
				$(".page_div").html($compile(pageNavi)($scope));
			}
			
			$scope.pageFnc = function(page){
				$("#page").val(page);
				$scope.open_pt_init();
			}
			
			$scope.checked_all = function(){
				$("input:checkbox[name='applier_check']").prop("checked", true);
			}
			
			$scope.print_excel = function(){
				var seq_list = [];
				
				$("input:checkbox[name='applier_check']:checked").each(function() { 
			        seq_list.push($(this).val());
			   });
				
				if(seq_list.length == 0){
					alert("엑셀출력할 대상을 선택해 주세요.");
					return false;
				}else{
					var context = '';
					$.each(seq_list, function(index,item){
						context += '<input type="hidden" name="seq_list" value="'+item+'">';
					})
					$("#excel_form").html(context);
					$("#excel_form").submit();
				}
				
			}
			
			//이력서 출력 
			$scope.resumeModal = function(e) {
				var user_id = $(e.currentTarget).attr('id');
				var fap_resume_seq = $(e.currentTarget).val();
				$('#myModal').modal('show');
				
				$http({
					url: "/fap/admin/fap_open_edu_applier_resume_select",
					method: 'post',
					params: {
								fap_resume_seq : fap_resume_seq
								,user_id : user_id
							},
					dataType: 'json'
				}).then(function successCallback(response) {
					
					console.log(response);
					
					var wholeResumeJson = JSON.stringify(response.data);
					var replaceJson = wholeResumeJson.replace(/(?:\r\n|\r|\n)/g, '<br />');
					$scope.resumeApply = JSON.parse(replaceJson);
					
					$timeout(function() {
						
						$.each($(".span-code"), function(index, item){
							var cd = $(this).attr("cd");
							var context = '<code value="'+cd+'"></code>';
							$(this).html(context);
						})

						$compile(".span-code")($scope);
					
						$.each($(".readonly_textarea"),function(index,item){
							$(this).css('height', $(this).prop('scrollHeight')+12);
						})
						
						$.each($(".readonly_textarea_pr"),function(index,item){
							$(this).css('height', $(this).prop('scrollHeight')+12);
						})
					}, 0);
					
					
				}, function errorCallback(response) {
					console.log(response);
				});
			}
			
			$scope.settingModal = function(e){
				var fap_open_pt_resume_seq = $(e.currentTarget).val();
				
				$("#settingModal").modal('show');
				
				var context = '<table class="table">';
				context += '<tr>';
				context += '<td>';
				context += '<input type="radio" class="dispaly_inline_block" name="resume_gb" value="D1401" />';
				context += '<code value="D1401"></code>';
				context += '</td>';
				context += '<td>';
				context += '<input type="radio" class="dispaly_inline_block" name="resume_gb" value="D1402" />';
				context += '<code value="D1402"></code>';
				context += '</td>';
				context += '</tr>';
				context += '</table>';
				
				$(".modal-body").html($compile(context)($scope));
				
				$("#fap_open_pt_resume_seq").val(fap_open_pt_resume_seq);
			}
		
			$scope.setting_save = function(){
				var fap_open_pt_resume_gb = $(":input:radio[name=resume_gb]:checked").val();
				var fap_open_pt_resume_seq = $("#fap_open_pt_resume_seq").val();
				
				if(typeof fap_open_pt_resume_gb == 'undefined'){
					alert("합/불을 선택해 주세요.");
					return false;
				}else{
					$http({
						url: "/fap/admin/fap_open_edu_applier_resume_update",
						method: 'post',
						params: {
							fap_open_pt_resume_seq : fap_open_pt_resume_seq,
							fap_open_pt_resume_gb : fap_open_pt_resume_gb
						},
					}).then(function successCallback(response) {
						$("#settingModal").modal('hide');
						$scope.open_pt_init();
					}, function errorCallback(response) {
						console.log(response);
					});
				}
			}
			
		}]);
	</script>
</head>
<body ng-app="myapp" ng-controller="AdminController">
    <%@include file="admin_menu.jsp"%>
    <br>
	<div class="page_title">
		<h2>오픈잡페어 구직자 교육 지원자 관리</h2>
	</div>
	<br>
	<div class="custom_div">
		<table class="search_box">
			<tr>
				<th>과정명으로 검색</th>
				<td>
					<select id="open_pt_title" ng-model="open_pt_title" ng-change="open_pt_change()">
						<option value="">---구직자 교육을 선택해주세요---</option>
						<c:forEach var="data" items="${result }">
							<option value="${data.fap_open_pt_seq }">${data.fap_open_pt_title }</option>
						</c:forEach>
					</select>
				</td>
				<td></td>
			</tr>
			<tr>
				<th>이름으로 검색</th>
				<td>
					<input type="text" id="searchName">
				</td>
				<td class="td_search" colspan="2">
					<button type="button" class="btn_search" ng-click="search_nm()">검색</button>
				</td>
			</tr>
		</table>
	</div>
	<div class="custom_div">
		<div class="count_wrap">
			<div class="count_per_page_div">
				<select id="count_per_page">
					<option value="10">10개씩 보기</option>
					<option value="50">50개씩 보기</option>
					<option value="100">100개씩 보기</option>
					<option value="1000">1000개씩 보기</option>
				</select>
			</div>
			<div class="total_count">
			</div>
			<div class="print_wrap">
				<button type="button" class="btn_search" ng-click="checked_all()">전체선택</button>
				<button type="button" class="btn_search" ng-click="print_excel()">엑셀출력</button>
				<button type="button" class="btn_search resume_print">이력서인쇄</button>
			</div>
		</div>
		<table class="table">
			<thead>
				<tr>
					<th></th>
					<th>No</th>
					<th>이름</th>
					<th>생년월일</th>
					<th>성별</th>
					<th>이메일</th>
					<th>전화번호</th>
					<th>최종학력</th>
					<th>전공</th>
					<th>이력서 정보</th>
					<th>진행상태</th>
					<th>합/불 처리</th>
					<th>신청일</th>
				</tr>
			</thead>
			<tbody class="tbody">
			</tbody>
		</table>
	</div>
	<div class="page_div">
	</div>
	
	<input type="hidden" id="fap_open_pt_gb" name="fap_open_pt_gb" value="D1001">
	<input type="hidden" id="page" name="page" value="1">
	<input type="hidden" id="searchNm" name="searchNm">
	<input type="hidden" id="fap_open_pt_seq" name="fap_open_pt_seq">
	
	<form action="/fap/admin/fap_open_edu_print_excel" method="post" id="excel_form">
		
	</form>
	
	
	<!-- Modal --------------->
  <div class="modal fade" id="myModal" role="dialog">
    <div class="modal-dialog" style="max-width: 1200px;">
      <!-- Modal content------------------------->
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal">&times;</button>
          <h4 class="modal-title" id="title"></h4>
        </div>
        <div class="modal-body">
        	<div class="resume_wrap">
				<div class="resume_sub">
				
					<div class="userjoinBox">
						<div id="sub3_bbs2" class="basic_top">
							<h2><spring:message code="fap.resume.user_info" /></h2>
							<ul class="tit1">
								<li class="photo">
									<img alt="" ng-src="/fap/user/resume_photo_image/{{resumeApply.fap_resume_pic_saved}}">
								</li>
							</ul>
							<ul class="tit2 first">
								<li class="wid1"><code value="B3100"></code></li>
								<li class="wid2">
									<span ng-bind="resumeApply.resumeNameList[0].fap_resume_nm"></span>
								</li>
								<li class="wid3"><spring:message code="fap.resume.user_nationality" /></li>
								<li class="wid4">
									<span ng-bind="resumeApply.fap_resume_nationality"></span>
								</li>
							</ul>
							<ul class="tit2">
								<li class="wid1"><code value="B3102"></code></li>
								<li class="wid2">
									<span ng-bind="resumeApply.resumeNameList[2].fap_resume_nm"></span>
								</li>
								<li class="wid3"><code value="B3103"></code></li>
								<li class="wid4">
									<span ng-bind="resumeApply.resumeNameList[3].fap_resume_nm"></span>
								</li>						
							</ul>
							<ul class="tit2">
								<li class="wid1"><code value="B3101"></code></li>
								<li class="wid2">
									<span ng-bind="resumeApply.resumeNameList[1].fap_resume_nm"></span>
								</li>
								<li class="wid3"><spring:message code="fap.resume.user_dependent" /></li>
								<li class="wid4">
									<span ng-bind="resumeApply.fap_resume_dependents"></span><spring:message code="com.placeholder.people" />
								</li>						
							</ul>
						</div>
						<div id="sub3_bbs2">
							<ul class="tit3">
								<li class="wid1"><spring:message code="fap.resume.user_birth" /></li>
								<li class="wid2_birth">
									<span ng-bind="resumeApply.fap_resume_birth.substr(0,4)"></span><spring:message code="com.placeholder.year" />
								</li>
								<li class="wid2_birth">
									<span ng-bind="resumeApply.fap_resume_birth.substr(5,2)"></span><spring:message code="com.placeholder.month" />
								</li>
								<li class="wid2_birth"> 
									<span ng-bind="resumeApply.fap_resume_birth.substr(8,2)"></span><spring:message code="com.placeholder.day" />
								</li>
							</ul>
							<ul class="tit3">
								<li class="wid1"><spring:message code="fap.resume.user_address" /></li>
								<li class="wid2 resumeAddr" ng-repeat="addr in resumeApply.resumeAddrList">	
									<span ng-bind="addr.fap_resume_address"></span>
								</li>
							</ul>
							<ul class="tit3">
								<li class="wid1"><spring:message code="fap.resume.user_gender" /></li>
								<li class="wid2">
									<div class="span-code" cd="{{resumeApply.fap_resume_gender}}"></div>
								</li>
							</ul>
							<ul class="tit3">
								<li class="wid1"><spring:message code="fap.resume.user_married_or_not" /></li>
								<li class="wid2">
									<div class="span-code" cd="{{resumeApply.fap_resume_marital}}"></div>
								</li>
							</ul>
						</div><!-- <div id="sub3_bbs2"> -->
					</div> <!-- <div id="userjoinBox"> -->		
		
					<!-- ------------------------------------기본정보---------------------------------------------->
					<div class="userjoinBox">
						<h2><spring:message code="fap.resume.edu_history" /></h2>
						<div class="sub3_bbs3 resume_edu" ng-repeat="eduHistory in resumeApply.resumeEduList">
							<ul class="tit2 title">
								<li class="wid1"><spring:message code="fap.resume.edu_entrance" /></li>
								<li class="wid2"><spring:message code="fap.resume.edu_graduation" /></li>
								<li class="wid3"><spring:message code="fap.resume.edu_period" /></li>
								<li class="wid4"><spring:message code="fap.resume.edu_graduated_or_not" /></li>
							</ul>
							<ul class="tit2">
								<li class="wid1">
									<span ng-bind="eduHistory.fap_resume_edu_er_dt"></span>
								</li>
								<li class="wid2">
									<span ng-bind="eduHistory.fap_resume_edu_gd_dt"></span>
								</li>
								<li class="wid3">
									<span ng-bind="eduHistory.fap_resume_edu_pd_summary"></span>
								</li>
								<li class="wid4">
									<div class="span-code" cd="{{eduHistory.fap_resume_edu_gd_ck}}"></div>
								</li>
							</ul>
							<ul class="tit3">
								<li class="wid1"><spring:message code="fap.resume.edu_school_nm" /></li>
								<li class="wid2">
									<span ng-bind="eduHistory.fap_resume_edu_sc_nm"></span>
								</li>
							</ul>
							<ul class="tit3">
								<li class="wid1"><spring:message code="fap.resume.edu_curriculum" /></li>
								<li class="wid2">
									<span ng-bind="eduHistory.fap_resume_edu_coll"></span>
								</li>					
							</ul>
							<ul class="tit3">
								<li class="wid1"><spring:message code="fap.resume.edu_major_field" /></li>
								<li class="wid2">
									<div class="span-code" cd="{{eduHistory.fap_resume_edu_field}}"></div>
								</li>					
							</ul>
							<ul class="tit3">
								<li class="wid1"><spring:message code="fap.resume.edu_major_nm" /></li>
								<li class="wid2">
									<span ng-bind="eduHistory.fap_resume_edu_major"></span>
								</li>					
							</ul>
							<ul class="tit3">
								<li class="wid1"><spring:message code="fap.resume.edu_remarks" /></li>
								<li class="wid2 textarea">
									<textarea class="readonly_textarea" ng-bind="eduHistory.fap_resume_edu_note" readonly="readonly"></textarea>
								</li>
							</ul>					
						</div><!-- <div id="sub3_bbs3"> -->
					</div><!-- <div id="userjoinBox"> -->
					<!-- ------------------------------------학력관련 교육이수 ---------------------------------------------->
					<div class="userjoinBox">
						<h2><spring:message code="fap.resume.career" /></h2>
						<div class="sub3_bbs3 resume_crr" ng-repeat ="career in resumeApply.resumeCareerList">
							<ul class="tit2 title">
								<li class="wid1"><spring:message code="fap.resume.career_service_start_day" /></li>
								<li class="wid2"><spring:message code="fap.resume.career_service_completion_day" /></li>
								<li class="wid3"><spring:message code="fap.resume.edu_period" /></li>
								<li class="wid4"><spring:message code="fap.resume.career_position" /></li>
							</ul>
							<ul class="tit2">
								<li class="wid1">
									<span ng-bind="career.fap_resume_crr_st"></span>
								</li>
								<li class="wid2">
									<span ng-bind="career.fap_resume_crr_et"></span>
								</li>
								<li class="wid3">
									<span ng-bind="career.fap_resume_crr_pd_summary"></span>
								</li>
								<li class="wid4">
									<span ng-bind="career.fap_resume_crr_job_position"></span>
								</li>
							</ul>
							<ul class="tit3">
								<li class="wid1"><spring:message code="fap.resume.career_comp_nm" /></li>
								<li class="wid2">
									<span ng-bind="career.fap_resume_crr_comp_nm"></span>
								</li>
							</ul>
							<ul class="tit3">
								<li class="wid1"><spring:message code="fap.resume.career_comp_major_business" /></li>
								<li class="wid2">
									<span ng-bind="career.fap_resume_crr_major_bussiness"></span>
								</li>					
							</ul>
							<ul class="tit3">
								<li class="wid1"><spring:message code="fap.resume.career_field" /></li>
								<li class="wid2">
									<div class="span-code" cd="{{career.fap_resume_crr_gb}}"></div>
								</li>					
							</ul>
							<ul class="tit3">
								<li class="wid1"><spring:message code="fap.resume.career_responsibility" /></li>
								<li class="wid2 textarea">
									<textarea class="readonly_textarea" ng-bind="career.fap_resume_crr_job_function" readonly="readonly"></textarea>
								</li>
							</ul>					
						</div>
					</div>	
					<!-- ------------------------------------사회 경력 ---------------------------------------------->
					<div class="userjoinBox">
						<h2><spring:message code="fap.resume.certification" /></h2>
						<div class="sub3_bbs3 resume_license" ng-repeat="license in resumeApply.resumeLicenseList">
							<ul class="tit2 title">
								<li class="wid1"><spring:message code="fap.resume.certification_license" /></li>
								<li class="wid2"><spring:message code="fap.resume.certification_obtained_year" /></li>
								<li class="wid3"><spring:message code="fap.resume.certification_obtained_month" /></li>
								<li class="wid4"><spring:message code="fap.resume.certification_issuing_organization" /></li>
							</ul>
							<ul class="tit2">
								<li class="wid1">
									<div class="span-code" cd="{{license.fap_resume_license_nm}}"></div>
								</li>
								<li class="wid2">
									<span ng-bind="license.fap_resume_license_get_year"></span>
								</li>
								<li class="wid3">
									<span ng-bind="license.fap_resume_license_get_month"></span>
								</li>
								<li class="wid4">
									<span ng-bind="license.fap_resume_license_issuing_organization"></span>
								</li>
							</ul>
							<ul class="tit3">
								<li class="wid1"><spring:message code="fap.resume.certification_score" /></li>
								<li class="wid2">
									<span ng-bind="license.fap_resume_license_score"></span>
								</li>
							</ul>
							<ul class="tit3">
								<li class="wid1"><spring:message code="fap.resume.certification_remarks" /></li>
								<li class="wid2 textarea">
									<textarea class="readonly_textarea" ng-bind="license.fap_resume_license_note" readonly="readonly"></textarea>
								</li>
							</ul>					
						</div><!-- <div id="sub3_bbs3"> -->
					</div>
					<!-- ----------------------------자격(기술 및 외국어 역량 중심) --------------------------------------------->
					<div class="userjoinBox page-break">
						<h2><spring:message code="fap.resume.talent" /></h2>
						<div class="sub3_bbs7 resume_talent" ng-repeat="talent in resumeApply.resumeTalentList">
							<ul class="tit2">
								<li class="wid1"><spring:message code="fap.resume.talent_number" /></li>
								<li class="wid2"><spring:message code="fap.resume.talent_context" /></li>
							</ul>
							<ul class="tit3">
								<li class="wid1">{{$index+1}}</li>
								<li class="wid2 textarea">
									<textarea class="readonly_textarea_talent" ng-bind="talent.fap_resume_talent_content" readonly="readonly"></textarea>
								</li>
							</ul>				
						</div><!-- <div id="sub3_bbs7"> -->
					</div><!-- <div id="userjoinBox"> -->				
					<!-- ----------------------------역량/재능(ICT, 외국어, 인간관계 등 업무 관련 상세) --------------------------------------------->
					<div class="userjoinBox">
						<h2><spring:message code="fap.resume.project_development_career" /></h2>
						<div class="sub3_bbs3 resume_project" ng-repeat="project in resumeApply.resumeProjectList">
							<ul class="tit2 title">
								<li class="wid1"><spring:message code="fap.resume.project_development_start_date" /></li>
								<li class="wid2"><spring:message code="fap.resume.project_development_end_date" /></li>
								<li class="wid3"><spring:message code="fap.resume.edu_period" /></li>
								<li class="wid4"><spring:message code="fap.resume.project_development_member" /></li>
							</ul>
							<ul class="tit2">
								<li class="wid1">
									<span ng-bind="project.fap_resume_project_st"></span>
								</li>
								<li class="wid2">
									<span ng-bind="project.fap_resume_project_et"></span>
								</li>
								<li class="wid3">
									<span ng-bind="project.fap_resume_project_pd_summary"></span>
								</li>
								<li class="wid4">
									<span ng-bind="project.fap_resume_project_peoples_num"></span>
									<spring:message code="com.placeholder.people" />
								</li>
							</ul>
							<ul class="tit3">
								<li class="wid1"><spring:message code="fap.resume.project_nm" /></li>
								<li class="wid2">
									<span ng-bind="project.fap_resume_project_nm"></span>
								</li>
							</ul>
							<ul class="tit3">
								<li class="wid1"><spring:message code="fap.resume.project_main_service" /></li>
								<li class="wid2 textarea">
									<textarea class="readonly_textarea" ng-bind="project.fap_resume_project_service" readonly="readonly"></textarea>
								</li>					
							</ul>
							<ul class="tit3">
								<li class="wid1"><spring:message code="fap.resume.project_charge_filed" /></li>
								<li class="wid2 textarea">
									<textarea class="readonly_textarea" ng-bind="project.fap_resume_project_responsibility" readonly="readonly"></textarea>
								</li>
							</ul>
							<ul class="tit3">
								<li class="wid1"><spring:message code="fap.resume.project_used_technique" /></li>
								<li class="wid2 textarea">
									<textarea class="readonly_textarea" ng-bind="project.fap_resume_project_technique" readonly="readonly"></textarea>
								</li>
							</ul>					
						</div><!-- <div id="sub3_bbs3"> -->
					</div>		
					<!-- ----------------------------SW 프로젝트 개발경력 --------------------------------------------->
					<div class="userjoinBox page-break">
						<h2><spring:message code="fap.resume.self_introduction" /></h2>
						<div class="sub3_bbs8">
							<ul class="tit2">
								<li class="wid1">
									<code value="B4100"></code>
								</li>					
							</ul>
							<ul class="tit3">
								<li class="wid1">
									<textarea class="readonly_textarea_pr" ng-bind="resumeApply.resumeProfileList[0].fap_resume_pr_content" readonly="readonly"></textarea>
								</li>						
							</ul>
							<ul class="tit2">
								<li class="wid1">
									<code value="B4101"></code>
								</li>
							</ul>
							<ul class="tit3">
								<li class="wid1">
									<textarea class="readonly_textarea_pr" ng-bind="resumeApply.resumeProfileList[1].fap_resume_pr_content" readonly="readonly"></textarea>
								</li>						
							</ul>
							<ul class="tit2">
								<li class="wid1">
									<code value="B4102"></code>
								</li>
							</ul>
							<ul class="tit3">
								<li class="wid1">
									<textarea class="readonly_textarea_pr" ng-bind="resumeApply.resumeProfileList[2].fap_resume_pr_content" readonly="readonly"></textarea>
								</li>						
							</ul>
						</div> <!-- <div id="sub3_bbs8"> -->
					</div><!-- <div id="userjoinBox"> -->				
					<!-- ----------------------------------------------자기소개서----------- --------------------------------------------->
					<div class="userjoinBox resumeFileDiv">
						<h2><spring:message code="fap.resume.self_introduction_video_portfolio" /></h2>
						<div id="sub3_bbs9">
							<ul class="tit2 resumeFile" ng-switch="!!resumeApply.resumeFileList[0].fap_resume_file_origin">
								<li class="wid1"><spring:message code="fap.resume.self_introduction_file" /></li>	
								<li class="wid2" ng-switch-when="true">
									<a class="display-inline" ng-href="/file_download?origin={{resumeApply.resumeFileList[0].fap_resume_file_origin}}&saved={{resumeApply.resumeFileList[0].fap_resume_file_saved}}&path=/fap/user/resume_movie_file">
										{{resumeApply.resumeFileList[0].fap_resume_file_origin}}
									</a>
								</li>
							</ul>
							<ul class="tit2 resumeFile" ng-switch="!!resumeApply.resumeFileList[1].fap_resume_file_origin">
								<li class="wid1"></li>
								<li class="wid2" ng-switch-when="true">
									<a class="display-inline" ng-href="/file_download?origin={{resumeApply.resumeFileList[1].fap_resume_file_origin}}&saved={{resumeApply.resumeFileList[1].fap_resume_file_saved}}&path=/fap/user/resume_portfolio_file">
										{{resumeApply.resumeFileList[1].fap_resume_file_origin}}
									</a>
								</li>
							</ul>	
							<ul class="tit2 resumeFile" ng-switch="!!resumeApply.resumeFileList[2].fap_resume_file_origin">
								<li class="wid1"></li>	
								<li class="wid2" ng-switch-when="true">
									<a class="display-inline" ng-href="/file_download?origin={{resumeApply.resumeFileList[2].fap_resume_file_origin}}&saved={{resumeApply.resumeFileList[2].fap_resume_file_saved}}&path=/fap/user/resume_project_file">
										{{resumeApply.resumeFileList[2].fap_resume_file_origin}}
									</a>
								</li>
							</ul>	
							<ul class="tit2">
								<li class="wid1"><spring:message code="fap.resume.self_introduction_url" /></li>
								<li class="wid2">
									<a href="{{resumeApply.fap_resume_url}}" target="_blank">{{resumeApply.fap_resume_url}}</a>
								</li>
							</ul>		
						</div> <!-- <div id="sub3_bbs9"> -->
					</div><!-- <div id="userjoinBox"> -->				
					<!-- ----------------------------------------------개인 동영상 및 포트폴리오 파일----------- --------------------------------------------->
				</div>
				</div>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        </div>
      </div>
    </div>
  </div>  
  <!-- end of Resume Modal -->
  
  <!-- 합불 모달 -->
	<div class="modal fade" id="settingModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	  <div class="modal-dialog modal-lg">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h4 class="modal-title" id="myModalLabel">합/불 설정</h4>
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	      </div>
	      <div class="modal-body">
	      	
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
	        <button type="button" class="btn btn-primary" ng-click="setting_save()">저장</button>
	      </div>
	    </div>
	  </div>
	</div>
  
  	<input type="hidden" id="fap_open_pt_resume_seq">
	
<form action="/fap/admin/applicant_resume_print_form" method="post" name="resume_popup" id="resume_popup">
	
</form>
	
</body>
</html>
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
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
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
		$scope.cur_seleted_btn = '${cur_seleted_btn}';
		/* ------------------------- 파라미터 scope에 담는 구역 끝 -------------------------- */
		
		/* -------------------------- [start] jobfair selectbox 그리기 시작 -------------------------- */
		var context = '';
		context +=	'<select onchange="angular.element(this).scope().select_change(1)" id="select_jobfair" ng-model="::fap_jobfair_seq">';
		if($scope.fap_jobfair_seq == 0){
		context +=		'<option value= "0" hidden>선택해주세요.</option>';
		}
		//진행중인 잡페어
		context +=		'<optgroup label="진행중인 잡페어" flag="1">';
		jobfair_map.jobfair_list_now.forEach(function (jobfair, index) {
			context +=	'<option value="' + jobfair.fap_jobfair_seq + '">' + jobfair.fap_jobfair_title + '</option>';
		});
		context +=		'</optgroup>';
		//예정된 잡페어
		context +=		'<optgroup label="예정된 잡페어" flag="2">';
		jobfair_map.jobfair_list_before.forEach(function (jobfair, index) {
			context +=	'<option value="' + jobfair.fap_jobfair_seq + '">' + jobfair.fap_jobfair_title + '</option>';
		});
		//종료된 잡페어
		context +=		'</optgroup>';
		context +=		'<optgroup label="종료된 잡페어" flag="3">';
		jobfair_map.jobfair_list_after.forEach(function (jobfair, index) {
			context +=	'<option value="' + jobfair.fap_jobfair_seq + '">' + jobfair.fap_jobfair_title + '</option>';
		});
		context +=		'</optgroup>';
		context +=	'</select>';
		context+='&nbsp;';
		context +=	'<select onchange="angular.element(this).scope().select_change(2)" id="select_jobfair_detail" disabled="disabled">';
		context +=		'<option value="" id="jobfair_detail_hidden" hidden>선택해주세요.</option>';
		context +=	'</select>';
		$('#select-box-layout').append($compile(context)($scope));
		$('#select_jobfair_detail').attr('disabled', false);
		
		$http({
			method : 'POST',
			url : '/fap/admin/select_jobfair_divide',
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
		});
		
		/* ------------------------- [end] jobfair selectbox 그리기 종료 -------------------------- */
		
		$scope.select_change = function(flag){
			//flag(1:jobfair select box 선택, 2:divide select box 선택)
			if(flag == 1){
				
				$('#jobfair_detail_hidden').prop('selected', true);
				$('#select_jobfair_detail').html('<option value="" id="jobfair_detail_hidden" hidden>선택해주세요.</option>');
				$('#select_jobfair_detail').attr('disabled', false);
				
				$scope.fap_jobfair_seq = $('#select_jobfair option:selected').val();
				
				$http({
					method : 'POST',
					url : '/fap/admin/select_jobfair_divide',
					responseType : 'text',
					params : {
						fap_jobfair_seq: $('#select_jobfair option:selected').val()
					}
				}).then(function successCallback(response) {
					for(var i in response.data){
						$('#select_jobfair_detail').append($compile('<option selectcode value="' 
								+ response.data[i].fap_jobfair_divide_gb + '" seq="' + response.data[i].fap_jobfair_divide_seq + '"></option>')($scope));
					}
					$("#nowBBS").children().remove();
					
				}, function errorCallback(response) {
					console.log(response);
				});
				
			}else if(flag ==2){
				//셀렉트 박스 변경될 때 채용공고 처음 그려주는 곳(체크)
				$scope.fap_jobfair_divide_seq = $('#select_jobfair_detail option:selected').attr('seq');
				
				var cur_seleted_btn_val = $scope.cur_seleted_btn;
				switch(cur_seleted_btn_val){
				case 'approvalRequest' : 
					$scope.draw_approvalRequest_job_ad_list();
					break;
				case 'progressing' :
					$scope.draw_progressing_job_ad_list();
					break;
				case 'standby' :
					$scope.draw_standby_job_ad_list();
					break;
				case 'completed' :
					$scope.draw_completed_job_ad_list();
					break;
				default :
					$scope.draw_standby_job_ad_list();
					break;
				}
				
			}
		}	
		//[end] jobfair selectbox 그리기 종료
				
		//[start] 승인요청중인 채용공고 시작
		$scope.draw_approvalRequest_job_ad_list = function(orderType,orderValue) {
			var params = {};
			var fap_jobfair_divide_seq = $scope.fap_jobfair_divide_seq;
			var fap_jobfair_seq = $scope.fap_jobfair_seq;
			var stateFlag = 'approvalRequest';
			$scope.cur_seleted_btn = 'approvalRequest';
			
			//검색관련
			var searchSelect = document.getElementById("searchSelect");
			var searchKey= searchSelect.options[searchSelect.selectedIndex].value;				 			
			var searchValue = document.getElementById("searchInput").value;	
			
			params['fap_jobfair_divide_seq'] = fap_jobfair_divide_seq;
			params['fap_jobfair_seq'] = fap_jobfair_seq;
			params['stateFlag'] = stateFlag;
			params['searchKey']=searchKey;
			params['searchValue']=searchValue;
			params['orderType']=orderType;	
			params['orderValue']=orderValue;	
			
 			$http({
				url : 'admin_select_per_state_job_ad_list',
				method : 'post',
				headers: {'Content-Type': 'application/json'},
				data: JSON.stringify(params),
				XMLHttpRequestResponseType: 'json'
			}).then(function successCallback(response) {				
				var resultJobAds = response.data;
				
				var context = '';	
				context += '		<ul class="tit1">';
				context += '			<li class="wid1">No</li>';
				context += '			<li class="wid2">채용공고 제목</li>';
				context += '			<li class="wid3">회사명&nbsp;<img class="arrow  fap_comp_ja_nm" src="/resources/segroup/society/fap/images/main/triangle_down_white.png;" orderType="fap_comp_ja_nm" ng-click="order_change($event)"  style="width: 20px;  "><br>(일본어)&emsp;</li>';
				context += '			<li class="wid3">회사명&nbsp;<img class="arrow  fap_comp_en_nm" src="/resources/segroup/society/fap/images/main/triangle_down_white.png;" orderType="fap_comp_en_nm" ng-click="order_change($event)"  style="width: 20px; "><br>(영어)</li>';
				context += '			<li class="wid4">기업그룹코드&nbsp;<img class="arrow  fap_job_ad_groupcode" src="/resources/segroup/society/fap/images/main/triangle_down_white.png;" orderType="fap_job_ad_groupcode"  ng-click="order_change($event)"  style="width: 20px; "></li>';
				context += '			<li class="wid5">지원자 수&nbsp;<img class="arrow  fap_job_ad_apply_num" src="/resources/segroup/society/fap/images/main/triangle_down_white.png;" orderType="fap_job_ad_apply_num"  ng-click="order_change($event)"  style="width: 20px; "><br><small>(서울/광주/일반)</small></li>';
				context += '			<li class="wid7">공고대상 설정</li>';
				context += '			<li class="wid6">지원룰 타입</li>';
				context += '			<li class="wid6">미스매칭 여부</li>';
				context += '			<li class="wid7">승인</li>';
				context += '		</ul>';
			if(resultJobAds.length > 0){
				resultJobAds.forEach(function (jobAd, index) {
					context += '	<ul class="tit2">';
					context += '		<li class="wid1">' + (index + 1) + '</li>';
					context += '		<li class="wid2">';
					context += '         <div class="ad_title">';
					context += '			<a href="" ng-click="job_ad_read(' + jobAd.fap_job_ad_seq + ')" title="'+jobAd.fap_job_ad_title+'">';
					context += '				' + jobAd.fap_job_ad_title + '';
					context += '			</a>';
					context += '         </div>'
					context += '		</li>';
					context += '		<li class="wid3">';
					context += '     <div class="ad_title" title="' + jobAd.fap_comp_ja_nm + '">';
					context += '			' + jobAd.fap_comp_ja_nm + '';
					context += '     </div>';
					context += '		</li>';
					context += '		<li class="wid3">';
					context += '     <div class="ad_title" title="' + jobAd.fap_comp_en_nm + '">';
					context += '			' + jobAd.fap_comp_en_nm + '';
					context += '     </div>';
					context += '		</li>';
					context += '		<li class="wid4">';
					if(jobAd.fap_job_ad_groupcode == undefined){
						context += '			등록되지<br>않았습니다.';
					}else if(jobAd.fap_job_ad_groupcode == 'D0500'){
						context += '			<code value="' + jobAd.fap_job_ad_groupcode + '"></code>';
					}else{
						context += '			' + jobAd.fap_job_ad_groupcode + '';
					}
					context += '		</li>';
					context += '		<li class="wid5">';
					context += '			' + jobAd.fap_job_ad_apply_num_sc + '/' +jobAd.fap_job_ad_apply_num_sw+'/'+jobAd.fap_job_ad_apply_num_general+'';
					context += '		</li>';
					context += '		<li class="wid7">';
					context += '         <button onclick="openShowModal('+jobAd.fap_job_ad_seq+')">설정</button>'
					context += '		</li>';
					context += '		<li class="wid6">';
					context += '			<select id="select_is_rule_type' + jobAd.fap_job_ad_seq + '" style="width:120px;">';
					context +=					'<option value="D2000" name="fap_job_ad_rule_type" selectcode ng-selected="\'D2000\' == \''+jobAd.fap_job_ad_rule_type+'\' "></option>';
					context +=					'<option value="D2001" name="fap_job_ad_rule_type" selectcode ng-selected="\'D2001\' == \''+jobAd.fap_job_ad_rule_type+'\' "></option>';
					context += '			</select>';
					context += '		</li>';
					context += '		<li class="wid6">';
					context += '			<select id="select_is_mismatching' + jobAd.fap_job_ad_seq + '" style="width:120px;">';
					context +=					'<option value="C4900" name="fap_job_ad_is_mismatching">일반지원</option>';
					context +=					'<option value="C4901" name="fap_job_ad_is_mismatching">미스매칭</option>';
					context += '			</select>';
					context += '		</li>';
					context += '		<li class="wid7">';
					context += '			<a href="" ng-click="admin_update_job_ad_state(1, ' + jobAd.fap_job_ad_seq + ', ' + jobAd.fap_jobfair_seq + ')">';
					context += '				승인하기';
					context += '			</a>';
					context += '		</li>';
					context += '	</ul>';
				});
			} else{
				context += '<h3><spring:message code="fap.jobad.jobad_on_process" /></h3>';	
			}
			//버튼 색상변경 부분
			$('#approvalRequestAdBtn').css('background', '#dadada');
			$('#progressingAdBtn').css('background', '#fff');
			$('#standbyAdBtn').css('background', '#fff');
			$('#completedAdBtn').css('background', '#fff');
			$("#nowBBS").children().remove();
			$("#nowBBS").append($compile(context)($scope));
			$scope.initialize(orderType, orderValue);
			
			}, function errorCallback(response) {
				console.log(response);
			});
		};
		//[end] 승인요청중인 채용공고 종료
		
		//[start] 진행중인 채용공고 시작
		$scope.draw_progressing_job_ad_list = function(orderType,orderValue) {
			var params = {};
			var fap_jobfair_divide_seq = $scope.fap_jobfair_divide_seq;
			var fap_jobfair_seq = $scope.fap_jobfair_seq;
			var stateFlag = 'progressing';
			$scope.cur_seleted_btn = 'progressing';
			
			//검색관련
			var searchSelect = document.getElementById("searchSelect");
			var searchKey= searchSelect.options[searchSelect.selectedIndex].value;				 			
			var searchValue = document.getElementById("searchInput").value;	 
			
			params['fap_jobfair_divide_seq'] = fap_jobfair_divide_seq;
			params['fap_jobfair_seq'] = fap_jobfair_seq;
			params['stateFlag'] = stateFlag;
			params['searchKey']=searchKey;
			params['searchValue']=searchValue;
			params['orderType']=orderType;	
			params['orderValue']=orderValue;	
			
 			$http({
				url : 'admin_select_per_state_job_ad_list',
				method : 'post',
				headers: {'Content-Type': 'application/json'},
				data: JSON.stringify(params),
				XMLHttpRequestResponseType: 'json'
			}).then(function successCallback(response) {
				var resultJobAds = response.data;
				$scope.resultJobAds = resultJobAds;
				console.log(resultJobAds);
				var context = '';	
				context += '		<ul class="tit1">';
				context += '			<li class="wid1">No</li>';
				context += '			<li class="wid2">채용공고 제목</li>';
				context += '			<li class="wid3">회사명&nbsp;<img class="arrow  fap_comp_ja_nm" src="/resources/segroup/society/fap/images/main/triangle_down_white.png;" orderType="fap_comp_ja_nm" ng-click="order_change($event)"  style="width: 20px;  "><br>(일본어)&emsp;</li>';
				context += '			<li class="wid3">회사명&nbsp;<img class="arrow  fap_comp_en_nm" src="/resources/segroup/society/fap/images/main/triangle_down_white.png;" orderType="fap_comp_en_nm" ng-click="order_change($event)"  style="width: 20px; "><br>(영어)</li>';
				context += '			<li class="wid4">기업그룹코드&nbsp;<img class="arrow  fap_job_ad_groupcode" src="/resources/segroup/society/fap/images/main/triangle_down_white.png;" orderType="fap_job_ad_groupcode"  ng-click="order_change($event)"  style="width: 20px; "></li>';
				context += '			<li class="wid5">지원자 수&nbsp;<img class="arrow  fap_job_ad_apply_num" src="/resources/segroup/society/fap/images/main/triangle_down_white.png;" orderType="fap_job_ad_apply_num"  ng-click="order_change($event)"  style="width: 20px; "><br><small>(서울/광주/일반)</small></li>';
				context += '			<li class="wid5">지원가능 인원</li>';
				context += '			<li class="wid5">현지제한 인원</li>';
				context += '			<li class="wid7">공고대상 설정</li>';
				context += '			<li class="wid7">지원룰 타입</li>';
				context += '			<li class="wid6">미스매칭 여부</li>';
				context += '			<li class="wid7">승인취소</li>';
				context += '			<li class="wid7">채용공고 마감</li>';
				context += '		</ul>';
			if(resultJobAds.length > 0){
				resultJobAds.forEach(function (jobAd, index) {
					context += '	<ul class="tit2">';
					context += '		<li class="wid1">' + (index + 1) + '</li>';
					context += '		<li class="wid2">';
					context += '    <div class="ad_title">';
					context += '			<a href="" ng-click="job_ad_read(' + jobAd.fap_job_ad_seq + ')" title="'+jobAd.fap_job_ad_title+'">';
					context += '				' + jobAd.fap_job_ad_title + '';
					context += '			</a>';
					context += '    </div>';
					context += '		</li>';
					context += '		<li class="wid3">';
					context += '     <div class="ad_title" title="' + jobAd.fap_comp_ja_nm + '">';
					context += '			' + jobAd.fap_comp_ja_nm + '';
					context += '     </div>';
					context += '		</li>';
					context += '		<li class="wid3">';
					context += '    <div class="ad_title" title="' + jobAd.fap_comp_en_nm + '">';
					context += '			' + jobAd.fap_comp_en_nm + '';
					context += '    </div>';
					context += '		</li>';
					context += '		<li class="wid4">';
				if(jobAd.fap_job_ad_groupcode == undefined){
					context += '			등록되지<br>않았습니다.';
				}else if(jobAd.fap_job_ad_groupcode == 'D0500'){
					context += '			<code value="' + jobAd.fap_job_ad_groupcode + '"></code>';
					
				}else{
					context += '			' + jobAd.fap_job_ad_groupcode + '';
				}
					console.log(jobAd);
					context += '		</li>';
					context += '		<li class="wid5">';
					context += '			' + jobAd.fap_job_ad_apply_num_sc + '/' +jobAd.fap_job_ad_apply_num_sw+'/'+jobAd.fap_job_ad_apply_num_general+'';
					context += '		</li>';
					context += '		<li class="wid5">';
					context += '			<input type="number" class="fap_job_app_per_settled_num" value="'+jobAd.fap_job_app_per_settled_num+'">';
					context += '			<button class="per_settled_update_btn" per_num="'+jobAd.fap_job_app_per_seq+'">변경</button>';
					context += '		</li>';
					
					context += '		<li class="wid5">';
					context += '			<input type="number" class="fap_job_itv_per_settled_num" value="'+jobAd.fap_job_itv_per_settled_num+'">';
					context += '			<button class="itv_per_settled_update_btn" per_num="'+jobAd.fap_job_itv_per_seq+'">변경</button>';
					context += '		</li>';
					
					context += '		<li class="wid7">';
					context += '         <button onclick="openShowModal('+jobAd.fap_job_ad_seq+')">설정</button>'
					context += '		</li>';
					context += '		<li class="wid7">';
					context += '         <code value="'+jobAd.fap_job_ad_rule_type+'"></code>';
					context += '		</li>';
					context += '		<li class="wid6">';
					context += '			<select id="mismatchingGbSelectBox' + jobAd.fap_job_ad_seq + '" ad_seq="' + jobAd.fap_job_ad_seq +'" onchange="angular.element(this).scope().change_of_mismatching(this)" style="width:120px;">';
					if(jobAd.fap_job_ad_is_mismatching == 'C4900'){
						context +=				'<option selectcode value="C4900" id="normal" name="fap_job_ad_is_mismatching" selected="selected"></option>';
						context +=				'<option selectcode value="C4901" id="mismatching" name="fap_job_ad_is_mismatching"></option>';
					}else if(jobAd.fap_job_ad_is_mismatching == 'C4901'){
						context +=				'<option selectcode value="C4901" id="normal" name="fap_job_ad_is_mismatching" selected="selected"></option>';
						context +=				'<option selectcode value="C4900" id="mismatching" name="fap_job_ad_is_mismatching"></option>';
					}
					context += '			</select>';
					context += '		</li>';
					context += '		<li class="wid7">';
					context += '			<a href="" ng-click="admin_update_job_ad_state(2, ' + jobAd.fap_job_ad_seq + ', ' + jobAd.fap_jobfair_seq + ')">';
					context += '				취소';
					context += '			</a>';
					context += '		</li>';
					context += '		<li class="wid7">';
					context += '			<a href="" ng-click="admin_update_job_ad_state(3, ' + jobAd.fap_job_ad_seq + ', ' + jobAd.fap_jobfair_seq + ')">';
					context += '				마감';
					context += '			</a>';
					context += '		</li>';
					context += '	</ul>';
						
				});
			} else{
				context += '<h3><spring:message code="fap.jobad.jobad_on_process" /></h3>';	
			}
		
			//버튼 색상변경 부분
			
			$('#approvalRequestAdBtn').css('background', '#fff');
			$('#progressingAdBtn').css('background', '#dadada');
			$('#standbyAdBtn').css('background', '#fff');
			$('#completedAdBtn').css('background', '#fff');
			$("#nowBBS").children().remove();
			$("#nowBBS").append($compile(context)($scope));
			$scope.initialize(orderType, orderValue);
			
			$(".per_settled_update_btn").on("click",function(){
				var fap_job_app_per_seq = $(this).attr("per_num");
				var fap_job_app_per_settled_num = $(this).prevAll(".fap_job_app_per_settled_num").val();
				
				if(fap_job_app_per_settled_num == null || fap_job_app_per_settled_num <= 0){
					$(this).prevAll(".fap_job_app_per_settled_num").val(0);
					$(this).prevAll(".fap_job_app_per_settled_num").focus();
					alert("0명 이상의 지원가능인원을 입력해 주세요");
					return ;
				}
				
				var per_params = {};
				per_params['fap_job_app_per_seq'] = fap_job_app_per_seq;
				per_params['fap_job_app_per_settled_num'] = fap_job_app_per_settled_num;
				
	 			$http({
					url : 'admin_job_app_per_update',
					method : 'post',
					headers: {'Content-Type': 'application/json'},
					data: JSON.stringify(per_params),
					XMLHttpRequestResponseType: 'json'
				}).then(function successCallback(response) {
					alert("지원가능 인원을 변경하였습니다.");
				}, function errorCallback(response) {
					console.log(response);
				});
				
				
			});
			
			$(".itv_per_settled_update_btn").on("click",function(){
				var fap_job_itv_per_seq = $(this).attr("per_num");
				var fap_job_itv_per_settled_num = $(this).prevAll(".fap_job_itv_per_settled_num").val();
				
				if(fap_job_itv_per_settled_num == null || fap_job_itv_per_settled_num <= 0){
					$(this).prevAll(".fap_job_itv_per_settled_num").val(0);
					$(this).prevAll(".fap_job_itv_per_settled_num").focus();
					alert("0명 이상의 현지제한인원을 입력해 주세요");
					return ;
				}
				
				var itv_params = {};
				itv_params['fap_job_itv_per_seq'] = fap_job_itv_per_seq;
				itv_params['fap_job_itv_per_settled_num'] = fap_job_itv_per_settled_num;
				
				$http({
					url : 'admin_job_itv_per_update',
					method : 'post',
					headers: {'Content-Type': 'application/json'},
					data: JSON.stringify(itv_params),
					XMLHttpRequestResponseType: 'json'
				}).then(function successCallback(response) {
					alert("현지제한 인원을 변경하였습니다.");
				}, function errorCallback(response) {
					console.log(response);
				});
				
			});
			
			
			}, function errorCallback(response) {
				console.log(response);
			});
		};
		//[end] 진행중인 채용공고 종료
		
		$scope.change_of_mismatching = function (curSelectedBox) {
			var changedSeleted = $(curSelectedBox).val();
			var fap_job_ad_seq = Number($(curSelectedBox).attr('id').replace(/[^0-9]/g,''));
			var flag = confirm('변경하시겠습니까?');
			if(flag == false){
				if(changedSeleted == 'C4901'){
					$(curSelectedBox).val('C4900');
				}else if(changedSeleted == 'C4900'){
					$(curSelectedBox).val('C4901');
				}
				return false;
			}
			
			var params = {};
			params['fap_job_ad_seq'] = fap_job_ad_seq;
			params['fap_job_ad_is_mismatching'] = changedSeleted;
			
 			$http({
				url : 'admin_update_mismatching',
				method : 'post',
				headers: {'Content-Type': 'application/json'},
				data: JSON.stringify(params),
				responseType : 'text'
			}).then(function successCallback(response) {
				alert("변경완료");
			}, function errorCallback(response) {
				console.log(response);
			});
		};
		 
		//[start] 대기중인 채용공고 시작
		$scope.draw_standby_job_ad_list = function(orderType,orderValue) {
			var params = {};
			var fap_jobfair_divide_seq = $scope.fap_jobfair_divide_seq;
			var fap_jobfair_seq = $scope.fap_jobfair_seq;
			var stateFlag = 'standby';
			$scope.cur_seleted_btn = 'standby';
			
			//검색관련
			var searchSelect = document.getElementById("searchSelect");
			var searchKey= searchSelect.options[searchSelect.selectedIndex].value;				 			
			var searchValue = document.getElementById("searchInput").value;	 
			
			params['fap_jobfair_divide_seq'] = fap_jobfair_divide_seq;
			params['fap_jobfair_seq'] = fap_jobfair_seq;
			params['stateFlag'] = stateFlag;
			params['searchKey']=searchKey;
		    params['searchValue']=searchValue;
			params['orderType']=orderType;	
			params['orderValue']=orderValue;	
			
 			$http({
				url : 'admin_select_per_state_job_ad_list',
				method : 'post',
				headers: {'Content-Type': 'application/json'},
				data: JSON.stringify(params),
				XMLHttpRequestResponseType: 'json'
			}).then(function successCallback(response) {
				var resultJobAds = response.data;
				var context = '';	
				context += '		<ul class="tit1">';
				context += '			<li class="wid1">No</li>';
				context += '			<li class="wid2">채용공고 제목</li>';
				context += '			<li class="wid3">회사명&nbsp;<img class="arrow  fap_comp_ja_nm" src="/resources/segroup/society/fap/images/main/triangle_down_white.png;" orderType="fap_comp_ja_nm" ng-click="order_change($event)"  style="width: 20px;  "><br>(일본어)&emsp;</li>';
				context += '			<li class="wid3">회사명&nbsp;<img class="arrow  fap_comp_en_nm" src="/resources/segroup/society/fap/images/main/triangle_down_white.png;" orderType="fap_comp_en_nm" ng-click="order_change($event)"  style="width: 20px; "><br>(영어)</li>';
				context += '			<li class="wid4">기업그룹코드&nbsp;<img class="arrow  fap_job_ad_groupcode" src="/resources/segroup/society/fap/images/main/triangle_down_white.png;" orderType="fap_job_ad_groupcode"  ng-click="order_change($event)"  style="width: 20px; "></li>';
				context += '			<li class="wid5">채용공고 상태</li>';
				context += '			<li class="wid6">미스매칭 여부</li>';
				context += '		</ul>';
			if(resultJobAds.length > 0){
				resultJobAds.forEach(function (jobAd, index) {
					context += '	<ul class="tit2">';
					context += '		<li class="wid1">' + (index + 1) + '</li>';
					context += '		<li class="wid2">';
					context += '			<a href="" ng-click="job_ad_read(' + jobAd.fap_job_ad_seq + ')" title="'+jobAd.fap_job_ad_title+'">';
					context += '				' + jobAd.fap_job_ad_title + '';
					context += '			</a>';
					context += '		</li>';				 
					context += '		<li class="wid3">';
					context += '			' + jobAd.fap_comp_ja_nm + '';
					context += '		</li>';				 
					context += '		<li class="wid3">';
					context += '			' + jobAd.fap_comp_en_nm + '';
					context += '		</li>';
					context += '		<li class="wid4">';
				if(jobAd.fap_job_ad_groupcode == undefined){
					context += '			등록되지<br>않았습니다.';
				}else if(jobAd.fap_job_ad_groupcode == 'D0500'){
					context += '			<code value="' + jobAd.fap_job_ad_groupcode + '"></code>';
				}else{
					context += '			' + jobAd.fap_job_ad_groupcode + '';
				}
					context += '		</li>';
					context += '		<li class="wid5">';
					context += '			<code value="' + jobAd.fap_job_ad_state + '"></code>';
					context += '		</li>';
					context += '		<li class="wid6">';
					context += '			<code value="' + jobAd.fap_job_ad_is_mismatching + '"></code>';
					context += '		</li>';
					context += '	</ul>';
				});
			} else{
				context += '<h3><spring:message code="fap.jobad.jobad_on_process" /></h3>';	
			}
			//버튼 색상변경 부분
			$('#approvalRequestAdBtn').css('background', '#fff');
			$('#progressingAdBtn').css('background', '#fff');
			$('#standbyAdBtn').css('background', '#dadada');
			$('#completedAdBtn').css('background', '#fff');
			$("#nowBBS").children().remove();
			$("#nowBBS").append($compile(context)($scope));
			$scope.initialize(orderType, orderValue);
			
			}, function errorCallback(response) {
				console.log(response);
			});
		};
		//[end] 대기중인 채용공고 종료
		
		//[start] 마감된 채용공고 시작
		$scope.draw_completed_job_ad_list = function(orderType,orderValue) {
			var params = {};
			var fap_jobfair_divide_seq = $scope.fap_jobfair_divide_seq;
			var fap_jobfair_seq = $scope.fap_jobfair_seq;
			var stateFlag = 'completed';
			$scope.cur_seleted_btn = 'completed';
			
			//검색관련
			var searchSelect = document.getElementById("searchSelect");
			var searchKey= searchSelect.options[searchSelect.selectedIndex].value;				 			
			var searchValue = document.getElementById("searchInput").value;	 
			
			params['fap_jobfair_divide_seq'] = fap_jobfair_divide_seq;
			params['fap_jobfair_seq'] = fap_jobfair_seq;
			params['stateFlag'] = stateFlag;
			params['searchKey']=searchKey;
			params['searchValue']=searchValue;
			params['orderType']=orderType;	
			params['orderValue']=orderValue;	
			
 			$http({
				url : 'admin_select_per_state_job_ad_list',
				method : 'post',
				headers: {'Content-Type': 'application/json'},
				data: JSON.stringify(params),
				XMLHttpRequestResponseType: 'json'
			}).then(function successCallback(response) {
				var resultJobAds = response.data;
				var context = '';	
				context += '		<ul class="tit1">';
				context += '			<li class="wid1">No</li>';
				context += '			<li class="wid2">채용공고 제목</li>';
				context += '			<li class="wid3">회사명&nbsp;<img class="arrow  fap_comp_ja_nm" src="/resources/segroup/society/fap/images/main/triangle_down_white.png;" orderType="fap_comp_ja_nm" ng-click="order_change($event)"  style="width: 20px;  "><br>(일본어)&emsp;</li>';
				context += '			<li class="wid3">회사명&nbsp;<img class="arrow  fap_comp_en_nm" src="/resources/segroup/society/fap/images/main/triangle_down_white.png;" orderType="fap_comp_en_nm" ng-click="order_change($event)"  style="width: 20px; "><br>(영어)</li>';
				context += '			<li class="wid4">기업그룹코드&nbsp;<img class="arrow  fap_job_ad_groupcode" src="/resources/segroup/society/fap/images/main/triangle_down_white.png;" orderType="fap_job_ad_groupcode"  ng-click="order_change($event)"  style="width: 20px; "></li>';
				context += '			<li class="wid5">지원자 수&nbsp;<img class="arrow  fap_job_ad_apply_num" src="/resources/segroup/society/fap/images/main/triangle_down_white.png;" orderType="fap_job_ad_apply_num"  ng-click="order_change($event)"  style="width: 20px; "><br><small>(서울/광주/일반)</small></li>';
				context += '			<li class="wid6">Q&amp;A</li>';
				context += '			<li class="wid7">지원룰 타입</li>';
				context += '			<li class="wid7">미스매칭 여부</li>';
				context += '			<li class="wid7">마감취소</li>';
				context += '		</ul>';
			if(resultJobAds.length > 0){
				resultJobAds.forEach(function (jobAd, index) {
					context += '	<ul class="tit2">';
					context += '		<li class="wid1">' + (index + 1) + '</li>';
					context += '		<li class="wid2">';
					context += '    <div class="ad_title">';
					context += '			<a href="" ng-click="job_ad_read(' + jobAd.fap_job_ad_seq + ')" title="'+jobAd.fap_job_ad_title+'">';
					context += '				' + jobAd.fap_job_ad_title + '';
					context += '			</a>';
					context += '    </div>';
					context += '		</li>';
					context += '		<li class="wid3">';
					context += '     <div class="ad_title" title="' + jobAd.fap_comp_ja_nm + '">';
					context += '			' + jobAd.fap_comp_ja_nm + '';
					context += '     </div>';
					context += '		</li>';
					context += '		<li class="wid3">';
					context += '    <div class="ad_title" title="' + jobAd.fap_comp_en_nm + '">';
					context += '			' + jobAd.fap_comp_en_nm + '';
					context += '    </div>';
					context += '		</li>';
					context += '		<li class="wid4">';
				if(jobAd.fap_job_ad_groupcode == undefined){
					context += '			등록되지<br>않았습니다.';
				}else if(jobAd.fap_job_ad_groupcode == 'D0500'){
					context += '			<code value="' + jobAd.fap_job_ad_groupcode + '"></code>';
				}else{
					context += '			' + jobAd.fap_job_ad_groupcode + '';
				}
					context += '		</li>';
					context += '		<li class="wid5">';
					context += '			' + jobAd.fap_job_ad_apply_num_sc + '/' +jobAd.fap_job_ad_apply_num_sw+'/'+jobAd.fap_job_ad_apply_num_general+'';
					context += '		</li>';
					context += '		<li class="wid6">';
					context += '			' + jobAd.fap_job_ad_question_num + '';
					context += '		</li>';
					context += '		<li class="wid7">';
					context += '			<code value="' + jobAd.fap_job_ad_rule_type + '"></code>';
					context += '		</li>';
					context += '		<li class="wid7">';
					context += '			<code value="' + jobAd.fap_job_ad_is_mismatching + '"></code>';
					context += '		</li>';
					context += '		<li class="wid7">';
					context += '			<a href="" ng-click="admin_update_job_ad_state(4, ' + jobAd.fap_job_ad_seq + ', ' + jobAd.fap_jobfair_seq + ')">';
					context += '				마감취소';
					context += '			</a>';
					context += '	 <input type="hidden" id="select_is_mismatching+${jobAd.fap_job_ad_seq}" />';
					context += '		</li>';
					context += '	</ul>';
				});
			} else{
				context += '<h3><spring:message code="fap.jobad.jobad_on_process" /></h3>';	
			}
			//버튼 색상변경 부분
			$('#approvalRequestAdBtn').css('background', '#fff');
			$('#progressingAdBtn').css('background', '#fff');
			$('#standbyAdBtn').css('background', '#fff');
			$('#completedAdBtn').css('background', '#dadada');
			$("#nowBBS").children().remove();
			$("#nowBBS").append($compile(context)($scope));
			$scope.initialize(orderType, orderValue);
			
			}, function errorCallback(response) {
				console.log(response);
			});
		};
		//[end] 마감된 채용공고 종료
		
		$scope.admin_update_job_ad_state = function(flag, fap_job_ad_seq, fap_jobfair_seq) {
			var params = {};
			 
			if (flag==1){ // flag 1: 승인요청중에서 승인하기를 클릭 -> 진행중(C2101)으로 변경
	 			var fap_job_ad_is_mismatching = $('#select_is_mismatching'+fap_job_ad_seq + ' option:selected').val();
				var fap_job_ad_rule_type = $('#select_is_rule_type'+fap_job_ad_seq + ' option:selected').val();
				var fap_job_ad_state='C2101'; 
			}else if(flag==2){  // flag 2: 진행중에서 승인취소하기를 클릭 -> 대기중(C2100)으로 변경.
				var fap_job_ad_state='C2100';
			}else if(flag==3){ // flag 3: 진행중에서 채용공고 마감하기를 클릭 -> 마감(C2102)으로  변경.
				var fap_job_ad_state='C2102';
			}else if(flag=4){  // flag 3: 마감된 채용공고에서 마감취소를 클릭 -> 진행중(C2101)으로  변경.
				var fap_job_ad_state='C2101';
			}
		
	
			params['fap_job_ad_seq'] = fap_job_ad_seq;
			params['fap_jobfair_seq'] = fap_jobfair_seq;
			params['fap_job_ad_state'] = fap_job_ad_state;
			params['fap_job_ad_is_mismatching'] = fap_job_ad_is_mismatching;
			params['fap_job_ad_rule_type'] = fap_job_ad_rule_type;
			
 			$http({
				url : '/fap/admin/update_job_ad_state',
				method : 'post',
				headers: {'Content-Type': 'application/json'},
				data: JSON.stringify(params),
				XMLHttpRequestResponseType: 'json'
			}).then(function successCallback(response) {
				if(response.data){
					var cur_seleted_btn_val = $scope.cur_seleted_btn;
					switch(cur_seleted_btn_val){
					case 'approvalRequest' : 
						$scope.draw_approvalRequest_job_ad_list();
						break;
					case 'progressing' :
						$scope.draw_progressing_job_ad_list();
						break;
					case 'standby' :
						$scope.draw_standby_job_ad_list();
						break;
					case 'completed' :
						$scope.draw_completed_job_ad_list();
						break;	
					default : 
						$scope.draw_standby_job_ad_list();
						break;
					}
				}else{
					console.log(response);
					alert("지원 가능한 추가지원시간이 없습니다.");
				}
			}, function errorCallback(response) {
			});
		}	
		
		
		
		$scope.job_ad_read = function(fap_job_ad_seq){
			location.href = "/fap/admin/job_ad_read_form?fap_job_ad_seq=" + fap_job_ad_seq+"&cur_seleted_btn="+$scope.cur_seleted_btn;
		}
		
		var cur_seleted_btn_val = $scope.cur_seleted_btn;
		switch(cur_seleted_btn_val){
		case 'approvalRequest' : 
			$scope.draw_approvalRequest_job_ad_list();
			break;
		case 'progressing' :
			$scope.draw_progressing_job_ad_list();
			break;
		case 'standby' :
			$scope.draw_standby_job_ad_list();
			break;
		case 'completed' :
			$scope.draw_completed_job_ad_list();
			break;				
		default :
			$scope.draw_standby_job_ad_list();
			break;
		}
		
		//검색
		$scope.search =function(){		  
				$scope.fap_jobfair_divide_seq = $('#select_jobfair_detail option:selected').attr('seq');			
				 
				var cur_seleted_btn_val = $scope.cur_seleted_btn;
				switch(cur_seleted_btn_val){
				case 'approvalRequest' : 
					$scope.draw_approvalRequest_job_ad_list();
					break;
				case 'progressing' :
					$scope.draw_progressing_job_ad_list();
					break;
				case 'standby' :
					$scope.draw_standby_job_ad_list();
					break;
				case 'completed' :
					$scope.draw_completed_job_ad_list();
					break;	
				default : 
					$scope.draw_standby_job_ad_list();
					break;
				} 
		}
		
		//정렬
		$scope.order_change = function(e){			
			var orderType = $(e.currentTarget	).attr('orderType');
			var orderValue = '';		
			
			if ($(e.currentTarget).hasClass('desc')) {							
				$(e.currentTarget).removeClass('desc').addClass('asc');
				orderValue = 'asc';				 
			} else if ($(e.currentTarget).hasClass('asc')) {					
				$(e.currentTarget).removeClass('asc').addClass('desc');
				orderValue = 'desc';
			} else{
				$(e.currentTarget).addClass('desc');
				orderValue = 'desc';
			}
		
			   $scope.fap_jobfair_divide_seq = $('#select_jobfair_detail option:selected').attr('seq');			
				var cur_seleted_btn_val = $scope.cur_seleted_btn;	
				switch(cur_seleted_btn_val){
				case 'approvalRequest' : 
					$scope.draw_approvalRequest_job_ad_list(orderType, orderValue);
					break;
				case 'progressing' :
					$scope.draw_progressing_job_ad_list(orderType, orderValue);
					break;
				case 'standby' :
					$scope.draw_standby_job_ad_list(orderType, orderValue);
					break;
				case 'completed' :
					$scope.draw_completed_job_ad_list(orderType, orderValue);
					break;	
				default : 
					$scope.draw_standby_job_ad_list(orderType, orderValue);
					break;
				}	
		}
		
		$scope.initialize=function(orderType, orderValue){	
			$.each($('.arrow'), function(index,item){
				if($(this).hasClass(orderType) && orderValue=='asc'){					
				 $(this).removeClass('desc').addClass(orderValue);
				 $(this).attr('src','/resources/segroup/society/fap/images/main/triangle_up_white.png');
				}else{					
				 	$(this).removeClass('asc').addClass(orderValue);
					$(this).attr('src','/resources/segroup/society/fap/images/main/triangle_down_white.png');
				}	
			})
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
	
	function openShowModal(seq){
		
		var fap_job_ad_seq = seq;
		
		$.ajax({
			beforeSend: function(xhr) {
			     xhr.setRequestHeader("AJAX", true);
			},
			url : "/fap/admin/ad_show_code_select",
			type : 'post',
			contentType: 'application/json',
			data : JSON.stringify(fap_job_ad_seq),
			success : function(response) {
				var context = '';
				
				$.each(response.com_code_arr,function(index, item){
					context += '<input type="checkbox" name="show_checkbox" class="com_show_ch" style="display: inline-block;" value="'+item.com_code+'">'+item.com_code_nm+'<br>';
				});
				context += '<input type="hidden" id="fap_job_ad_seq_hid" value="'+fap_job_ad_seq+'">';
				
				$("#job_ad_show_content").html(context);
				
				$.each($(".com_show_ch"), function(index, item){
					$.each(response.ad_code_arr, function(index2, item2){
						
						if($(item).val() == item2.fap_job_ad_show_gb){
							$(item).prop("checked",true);
						}
						
					})
				});
				
				$('#job_ad_show_modal').modal('show');
			}
			, error : function(e) {
				if(e.status == 403){
					alert('<spring:message code="com.login.ajaxSesstion" javaScriptEscape="true" />');
					location.href = "/fap/admin/admin_login";
				}
			}
		})
	}
	
	function show_insert(){
		var code_arr = [];
		var fap_job_ad_seq = $("#fap_job_ad_seq_hid").val();
		
		$("input[name=show_checkbox]:checked").each(function(){
			code_arr.push($(this).val());
		})
		
		var paramMap = {};
			paramMap['code_arr'] = code_arr;
			paramMap['fap_job_ad_seq'] = fap_job_ad_seq;
		
		$.ajax({
			beforeSend: function(xhr) {
			     xhr.setRequestHeader("AJAX", true);
			},
			url : "/fap/admin/ad_show_code_insert",
			type : 'post',
			contentType: 'application/json',
			data : JSON.stringify(paramMap),
			success : function(response) {
				
			}
			,error : function(e){
				if(e.status == 403){
					alert('<spring:message code="com.login.ajaxSesstion" javaScriptEscape="true" />');
					location.href = "/fap/admin/admin_login";
				}
			}
		})
		
		
		$('#job_ad_show_modal').modal('hide');
	}
	
</script>
</head>
<body ng-app="myapp" ng-controller="JobAdController">
	<%@include file="admin_menu.jsp"%>
	<div class="join-wrap">
		<div id="subcontents" class="admin">
			<h1>
				<spring:message code="fap.common.manage_jobad" />
			</h1>
			<h6>
				<spring:message code="fap.comp.login_invite_phrase" />
			</h6>

			<div id="nowBox">

				<div class="nowfind" id="select-box-layout">
					<spring:message code="fap.jobad.search_per_jobfair" />
				</div>
				<!-- 검색 -->
				<div class="searchDiv">
					   <table>
						  <tr>
							  <td>
							  		<select id="searchSelect"  name="searchSelect" style=" width: 150px; height:28px;"   >
										<option value="searchJaNm">회사명(일본어)</option>
										<option value="searchEnNm">회사명(영어)</option>
									</select>
							  </td>
							   <td>
							   		<input type="text" id="searchInput" name="searchInput"  class="input1" style="width: 700px; height:28px;" placeholder="">
							   	</td>
							   	<td>
									<input  type="button" class="btn_search"   value="검색" ng-click="search()" style="width: 100px; height:28px;">
							   </td>
						  </tr>
					  </table>		
				</div>
		
				<div id="rewrite_tab">
				<button id="approvalRequestAdBtn" class="btn btn-primary2" ng-click="draw_approvalRequest_job_ad_list()">승인요청중인 채용공고</button>
				
				<button id="progressingAdBtn" class="btn btn-primary2" ng-click="draw_progressing_job_ad_list()">진행중인 채용공고</button>
				
				<button id="standbyAdBtn" class="btn btn-primary2" ng-click="draw_standby_job_ad_list()">대기중인 채용공고</button>
				
				<button id="completedAdBtn" class="btn btn-primary2" ng-click="draw_completed_job_ad_list()">마감된 채용공고</button>
			</div>
			
			<div id="nowBBS">
				<!-- 채용공고 들어가는 부분 -->
			</div>
			
		</div>
	</div>
</div>		 

<!-- 공고대상 설정 모달 -->
<div class="modal fade" id="job_ad_show_modal" role="dialog">
	
	<!-- Modal dialog------------------------->
	<div class="modal-dialog" id="modal-dialog">
	
		<!-- 1 Modal content------------------------->
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title" id="title">
					채용공고 대상 설정
				</h4>
			</div>
			
			<!-- body 시작-->
			<div class="job_ad_show_body" style="text-align: center;">
				<div id="job_ad_show_content" style="text-align:center;">
					
				</div>

       		</div>
			<!-- body 끝 -->

			<div class="modal-footer">
				<button type="button" id="show_insert_btn" class="btn btn-default" onclick="show_insert()">변경</button>
				<button type="button" id="show_close_btn" class="btn btn-default" data-dismiss="modal">닫기</button>
			</div>
		
		</div>
		<!-- modal content div 종료 -->
		
	</div>
	<!-- modal-dialog div 종료 -->
	
</div>  


</body>
</html>

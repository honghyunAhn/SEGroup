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
		//현재 클릭된 버튼 저장 scope
		$scope.cur_seleted_btn = 'progressing';
		/* ------------------------- 파라미터 scope에 담는 구역 끝 -------------------------- */
		
		/* --------------------------- [start] jobfair selectbox 그리기 시작 -------------------------- */
		var context = '';
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
		//종료된 잡페어
		context +=		'</optgroup>';
		context +=		'<optgroup label="<spring:message code="fap.jobfair.closed_jobfair" />" flag="3">';
		jobfair_map.jobfair_list_after.forEach(function (jobfair, index) {
			context +=	'<option value="' + jobfair.fap_jobfair_seq + '">' + jobfair.fap_jobfair_title + '</option>';
		});
		context +=		'</optgroup>';
		context +=	'</select>';
		context+='&nbsp;';
		context +=	'<select onchange="angular.element(this).scope().select_change(2)" id="select_jobfair_detail" disabled="disabled">';
		context +=		'<option value="" id="jobfair_detail_hidden" hidden><spring:message code="fap.jobad.please_select" /></option>';
		context +=	'</select>';
		$('#select-box-layout').append($compile(context)($scope));
		$('#select_jobfair_detail').attr('disabled', false);
		
		$http({
			method : 'POST',
			url : '/fap/company_roadmap/select_jobfair_divide',
			responseType : 'text',
			params : {
				fap_jobfair_seq: '${fap_jobfair_seq}'
			},
			headers : {
				"AJAX" : true
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
				//처음 페이지 들어왔을 때 진행중인 채용공고 일단 강제 실행
				var params = {};
				var fap_jobfair_divide_seq = $scope.fap_jobfair_divide_seq;
				var fap_jobfair_seq = $scope.fap_jobfair_seq;
				var stateFlag = 'progressing';
				$scope.cur_seleted_btn = 'progressing';
				params['fap_jobfair_divide_seq'] = fap_jobfair_divide_seq;
				params['fap_jobfair_seq'] = fap_jobfair_seq;
				params['stateFlag'] = stateFlag;
				
	 			$http({
					url : 'company_select_per_state_job_ad_list',
					method : 'post',
					headers: {'Content-Type': 'application/json'},
					data: JSON.stringify(params),
					XMLHttpRequestResponseType: 'json'
				}).then(function successCallback(response) {
					var resultJobAds = response.data;
					var context = '';	
					context += '		<ul class="tit1">';
					context += '			<li class="wid1">No</li>';
											//채용공고 제목
					context += '			<li class="wid2"><spring:message code="fap.jobad.title" /></li>';
											//참가한 잡페어
					context += '			<li class="wid3"><spring:message code="fap.jobad.attended_jobfair" /></li>';
											//잡페어 세부
					context += '			<li class="wid4"><spring:message code="fap.jobad.jobfair_divide" /></li>';
											//상태
					context += '			<li class="wid5"><spring:message code="fap.jobad.state" /></li>';
											//지원자수
					context += '			<li class="wid6">Q&amp;A</li>';
											//지원현황
					context += '			<li class="wid7"><spring:message code="fap.comp.applicant_status" /></li>';
					context += '		</ul>';
				if(resultJobAds.length > 0){
					resultJobAds.forEach(function (jobAd, index) {
						context += '	<ul class="tit2">';
						context += '		<li class="wid1">' + (index + 1) + '</li>';
						context += '		<li class="wid2">';
						context += '			<ul class="tit3">';
						context += '			<li class="wid7"><a href="" ng-click="company_job_ad_read_form(' + jobAd.fap_job_ad_seq + ')">';
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
							context += '				<code value="'+ cate.fap_job_category_gb +'"></code>';
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
						//context += '			' + jobAd.fap_job_ad_question_num + '';
						context += '			<a href="/fap/company/company_job_qna_management?fap_job_ad_seq=' + jobAd.fap_job_ad_seq + '"><button><spring:message code="fap.jobad.qna.to_qna_page" /></button></a>';
						context += '		</li>';
						context += '		<li class="wid7">';
						//context += '			' + jobAd.fap_job_ad_apply_num + '';
						context += '			<button onclick="show_applicant('+2+','+$scope.fap_jobfair_divide_seq+', '+jobAd.fap_job_ad_seq+', \'${fap_comp_id}\')"><spring:message code="fap.comp.applicant_status" /></button>';
						context += '		</li>';
						context += '	</ul>';
					});
				} else{
					//등록된 채용공고 없는 메시지
					context += '<h3><spring:message code="fap.jobad.jobad_on_process" /></h3>';	
				}
				$('#progressingAdBtn').css('background', '#dadada');
				$('#standbyAdBtn').css('background', '#fff');
				$('#completedAdBtn').css('background', '#fff');
				$('#tempedAdBtn').css('background', '#fff');
				$("#nowBBS").children().remove();
				$("#nowBBS").append($compile(context)($scope));
				
				}, function errorCallback(response) {
					console.log(response);
				});
			}
		}, function errorCallback(response) {
			console.log(response);
			if(response.status == 403){
				alert('<spring:message code="com.login.ajaxSesstion" javaScriptEscape="true" />');
				location.href = "/fap/company/company_login";
			}
		});
		
		/* ------------------------- [end] jobfair selectbox 그리기 종료 -------------------------- */
		
		$scope.select_change = function(flag){
			//flag(1:jobfair select box 선택, 2:divide select box 선택)
			if(flag == 1){
				
				$('#jobfair_detail_hidden').prop('selected', true);
				$('#select_jobfair_detail').html('<option value="" id="jobfair_detail_hidden" hidden><spring:message code="fap.jobad.please_select" /></option>');
				$('#select_jobfair_detail').attr('disabled', false);
				
				$scope.fap_jobfair_seq = $('#select_jobfair option:selected').val();
				
				$http({
					method : 'POST',
					url : '/fap/company_roadmap/select_jobfair_divide',
					responseType : 'text',
					params : {
						fap_jobfair_seq: $('#select_jobfair option:selected').val()
					},
					headers : {
						"AJAX" : true
					}
				}).then(function successCallback(response) {
					for(var i in response.data){
						$('#select_jobfair_detail').append($compile('<option selectcode value="' 
								+ response.data[i].fap_jobfair_divide_gb + '" seq="' + response.data[i].fap_jobfair_divide_seq + '"></option>')($scope));
					}
					
				}, function errorCallback(response) {
					console.log(response);
					if(response.status == 403){
						alert('<spring:message code="com.login.ajaxSesstion" javaScriptEscape="true" />');
						location.href = "/fap/company/company_login";
					}
				});
				
			}else if(flag ==2){
				//셀렉트 박스 변경될 때 채용공고 처음 그려주는 곳(체크)
				$scope.fap_jobfair_divide_seq = $('#select_jobfair_detail option:selected').attr('seq');
				
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
				default : 
					$scope.draw_temped_job_ad_list();
					break;
				}
				
			}
		}	
		//[end] jobfair selectbox 그리기 종료
		
		$scope.update_job_ad_state = function(flag, fap_job_ad_seq, fap_jobfair_seq, fap_jobfair_divide_seq) {
			var params = {};
			
			var fap_job_ad_state = (flag == 1) ? 'C2104' : 'C2100';
			
			params['fap_jobfair_divide_seq'] = fap_jobfair_divide_seq;
			params['fap_jobfair_seq'] = fap_jobfair_seq;
			params['fap_job_ad_seq'] = fap_job_ad_seq;
			params['fap_job_ad_state'] = fap_job_ad_state;			
			
			$http({
				url : '/fap/company/update_job_ad_state',
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
				default : 
					$scope.draw_temped_job_ad_list();
					break;
				}
			}, function errorCallback(response) {
				console.log(response);
				if(response.status == 403){
					alert('<spring:message code="com.login.ajaxSesstion" javaScriptEscape="true" />');
					location.href = "/fap/company/company_login";
				}
			});
		}		
			
		$scope.company_job_ad_update_form = function(fap_job_ad_seq) {
			$('#fap_job_ad_seq_update').val(fap_job_ad_seq);
			$('#company_job_ad_update_form').submit();
		}
		
		$scope.company_job_ad_read_form = function(fap_job_ad_seq) {
			$('#fap_job_ad_seq_read').val(fap_job_ad_seq);
			$('#company_job_ad_read_form').submit();
		}
				
		//[start] 진행중인 채용공고 시작
		$scope.draw_prgressing_job_ad_list = function() {
			var params = {};
			var fap_jobfair_divide_seq = $scope.fap_jobfair_divide_seq;
			var fap_jobfair_seq = $scope.fap_jobfair_seq;
			var stateFlag = 'progressing';
			$scope.cur_seleted_btn = 'progressing';
			params['fap_jobfair_divide_seq'] = fap_jobfair_divide_seq;
			params['fap_jobfair_seq'] = fap_jobfair_seq;
			params['stateFlag'] = stateFlag;
			
 			$http({
				url : 'company_select_per_state_job_ad_list',
				method : 'post',
				headers: {
					'Content-Type': 'application/json',
					"AJAX" : true
				},
				data: JSON.stringify(params),
				XMLHttpRequestResponseType: 'json'
			}).then(function successCallback(response) {
				var resultJobAds = response.data;
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
					context += '			<li class="wid7"><a href="" ng-click="company_job_ad_read_form(' + jobAd.fap_job_ad_seq + ')">';
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
					//채용공고별 Q&A 관리
					//context += '			' + jobAd.fap_job_ad_question_num + '';
					context += '			<a href="/fap/company/company_job_qna_management?fap_job_ad_seq=' + jobAd.fap_job_ad_seq + '"><button style="left: 22px; width: 69px;"><spring:message code="fap.jobad.qna.to_qna_page" /></button></a>'
					context += '		</li>';
					//채용공고별 지원자 관리
					context += '		<li class="wid7">';
					context += '			<button onclick="show_applicant('+2+','+$scope.fap_jobfair_divide_seq+', '+jobAd.fap_job_ad_seq+', \'${fap_comp_id}\')" style="left: 19px; width: 80px;"><spring:message code="fap.comp.applicant_status" /></button>';
					context += '		</li>';
					//[END] 채용공고별 지원자 관리 
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
			
			}, function errorCallback(response) {
				console.log(response);
				if(response.status == 403){
					alert('<spring:message code="com.login.ajaxSesstion" javaScriptEscape="true" />');
					location.href = "/fap/company/company_login";
				}
			});
		};
		//[end] 진행중인 채용공고 종료
		
		//[start] 대기중인 채용공고 시작
		$scope.draw_standby_job_ad_list = function() {
			var params = {};
			var fap_jobfair_divide_seq = $scope.fap_jobfair_divide_seq;
			var fap_jobfair_seq = $scope.fap_jobfair_seq;
			var stateFlag = 'standby';
			$scope.cur_seleted_btn = 'standby';
			params['fap_jobfair_divide_seq'] = fap_jobfair_divide_seq;
			params['fap_jobfair_seq'] = fap_jobfair_seq;
			params['stateFlag'] = stateFlag;
 			$http({
				url : 'company_select_per_state_job_ad_list',
				method : 'post',
				headers: {
					'Content-Type': 'application/json',
					"AJAX" : true
				},
				data: JSON.stringify(params),
				XMLHttpRequestResponseType: 'json'
			}).then(function successCallback(response) {
				var resultJobAds = response.data;
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
						context += '			<li class="wid7"><a href="" ng-click="company_job_ad_read_form(' + jobAd.fap_job_ad_seq + ')">';
						context += '				' + jobAd.fap_job_ad_title + '';
						context += '			</a></li>';
					}else{
						context += '			<li class="wid7"><a href="" ng-click="company_job_ad_update_form(' + jobAd.fap_job_ad_seq + ')">';
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
			
			}, function errorCallback(response) {
				console.log(response);
				if(response.status == 403){
					alert('<spring:message code="com.login.ajaxSesstion" javaScriptEscape="true" />');
					location.href = "/fap/company/company_login";
				}
			});
		};
		//[end] 대기중인 채용공고 종료
		
		//[start] 마감된 채용공고 시작
		$scope.draw_completed_job_ad_list = function() {
			var params = {};
			var fap_jobfair_divide_seq = $scope.fap_jobfair_divide_seq;
			var fap_jobfair_seq = $scope.fap_jobfair_seq;
			var stateFlag = 'completed';
			$scope.cur_seleted_btn = 'completed';
			params['fap_jobfair_divide_seq'] = fap_jobfair_divide_seq;
			params['fap_jobfair_seq'] = fap_jobfair_seq;
			params['stateFlag'] = stateFlag;
			
 			$http({
				url : 'company_select_per_state_job_ad_list',
				method : 'post',
				headers: {
					'Content-Type': 'application/json',
					"AJAX" : true
				},
				data: JSON.stringify(params),
				XMLHttpRequestResponseType: 'json'
			}).then(function successCallback(response) {
				var resultJobAds = response.data;
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
					context += '			<li class="wid7"><a href="" ng-click="company_job_ad_read_form(' + jobAd.fap_job_ad_seq + ')">';
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
					context += '			<a href="/fap/company/company_job_qna_management?fap_job_ad_seq=' + jobAd.fap_job_ad_seq + '"><button style="left: 22px; width: 69px;"><spring:message code="fap.jobad.qna.to_qna_page" /></button></a>'
					context += '		</li>';
					context += '		<li class="wid7">';
					context += '			<button onclick="show_applicant('+1+','+$scope.fap_jobfair_divide_seq+', '+jobAd.fap_job_ad_seq+', \'${fap_comp_id}\')" style="left: 19px; width: 80px;"><spring:message code="fap.comp.applicant_status" /></button>';
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
			
			}, function errorCallback(response) {
				console.log(response);
				if(response.status == 403){
					alert('<spring:message code="com.login.ajaxSesstion" javaScriptEscape="true" />');
					location.href = "/fap/company/company_login";
				}
			});
		};
		//[end] 마감된 채용공고 종료
		
		//[start] 채용공고 저장함 시작
		$scope.draw_temped_job_ad_list = function() {
			var params = {};
			var fap_jobfair_divide_seq = $scope.fap_jobfair_divide_seq;
			var fap_jobfair_seq = $scope.fap_jobfair_seq;
			var stateFlag = 'temped';
			$scope.cur_seleted_btn = 'temped';
			params['fap_jobfair_divide_seq'] = fap_jobfair_divide_seq;
			params['fap_jobfair_seq'] = fap_jobfair_seq;
			params['stateFlag'] = stateFlag;
			
 			$http({
				url : 'company_select_per_state_job_ad_list',
				method : 'post',
				headers: {
					'Content-Type': 'application/json',
					"AJAX" : true
				},
				data: JSON.stringify(params),
				XMLHttpRequestResponseType: 'json'
			}).then(function successCallback(response) {
				var resultJobAds = response.data;
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
					context += '			<li class="wid7" title="' + jobAd.fap_job_ad_title + '"><a href="" ng-click="company_job_ad_update_form(' + jobAd.fap_job_ad_seq + ')">';
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
			
			}, function errorCallback(response) {
				console.log(response);
				if(response.status == 403){
					alert('<spring:message code="com.login.ajaxSesstion" javaScriptEscape="true" />');
					location.href = "/fap/company/company_login";
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
					},
					headers : {
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
						location.href = "/fap/company/company_login";
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
		var jobfair_divide_seq = $('#select_jobfair_detail option:selected').attr('seq');
		
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
		
		$('#insert_fap_jobfair_seq').val(jobfair_seq);
		$('#insert_fap_jobfair_divide_seq').val(jobfair_divide_seq);
		
		return true;
		
	} 	
	function show_applicant (flag,fap_jobfair_divide_seq, fap_job_ad_seq, fap_comp_id){	 
		var jobfair_seq = $('#select_jobfair option:selected').val();
		var jobfair_title = $('#select_jobfair option:selected').html();
		var jobfair_devide_gb = $('#select_jobfair_detail option:selected').html();
		var fap_job_ad_state = (flag ==1)? 'C2102' : 'C2101';
		var form = document.createElement("form");
        var parm = new Array();
        var input = new Array();
 		
        form.action = "/fap/company/applicant_status_per_job_ad";
        form.method = "post";
        
		/* [name, value] */
		parm.push( ['fap_jobfair_divide_seq', fap_jobfair_divide_seq ] );
		parm.push( ['fap_job_ad_seq', fap_job_ad_seq ] );
        parm.push( ['fap_comp_id', fap_comp_id ] );
        parm.push( ['fap_jobfair_seq', jobfair_seq ] );
        parm.push( ['fap_jobfair_title', jobfair_title ] );
        parm.push( ['fap_jobfair_devide_gb', jobfair_devide_gb ] );
        
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
<%@include file="company_menu.jsp"%>
<div class="join-wrap">
	<div id="subcontents">
		<h1><spring:message code="fap.common.manage_jobad" /></h1>
		<h6></h6>		
		<div id="nowBox">
			<div class="nowfind" id="select-box-layout">
				<h5><spring:message code="fap.comp.login_invite_phrase" /></h5>
				<spring:message code="fap.jobad.search_per_jobfair" />
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
			<form id="company_job_ad_update_form" action="company_job_ad_update_form" method="get">
				<input type="hidden" name="fap_job_ad_seq" id="fap_job_ad_seq_update" value="0">
			</form>
			<!-- 채용공고 읽기페이지로 이동하는 폼 -->
			<form id="company_job_ad_read_form" action="company_job_ad_read_form" method="get">
				<input type="hidden" name="fap_job_ad_seq" id="fap_job_ad_seq_read" value="0">
			</form>
			
			<form action="company_job_ad_insert_form" method="post" onsubmit="javascript:return insert_param_set()">
				<input type="hidden" name="fap_jobfair_seq" id="insert_fap_jobfair_seq" value="${fap_jobfair_seq}">
				<input type="hidden" name="fap_jobfair_divide_seq" id="insert_fap_jobfair_divide_seq" value="${fap_jobfair_divide_seq}">
				<input type="hidden" name="fap_comp_id" value="${fap_comp_id}">
				<div id="recruitBtn"><button class="btn btn-primary" onclick="return insert_param_set();"><spring:message code="fap.jobad.write_jobad" /></button></div>
			</form>
			
		</div>
	</div>
</div>		 
	<%@include file="company_footer.jsp"%>
</body>
</html>
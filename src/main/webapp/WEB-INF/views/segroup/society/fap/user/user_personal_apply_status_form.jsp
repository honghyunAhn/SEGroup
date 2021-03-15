<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

	<script src="<c:url value="/resources/segroup/js/jquery-3.1.1.js" />"></script>
	<script src="<c:url value="/resources/segroup/js/angular.min.js" />"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
	
	<link rel="stylesheet" type="text/css" href="<c:url value="/resources/segroup/society/fap/css/userDefault.css" />" />
	<link rel="stylesheet" type="text/css" href="<c:url value="/resources/segroup/society/fap/css/popModal.css" />" />

	<script type="text/javascript">
	 	var myApp = angular.module('myapp', []);
	
		myApp.controller('PersonalApplicationStatusController', ['$scope', '$compile', '$http','$timeout', function($scope, $compile, $http,$timeout) {
			
			//[start] 지원 이력서보기 모달창 출력 시작(남유송)
			$scope.openResumeDetailModal = function (e) {
				var fap_resume_seq = $(e.currentTarget).attr('resume_seq');
				var user_id = $('#user_id').val();
				$('#resumeInfoModal').modal('show');
				$http({
					url: 'select_user_resume_info_read',
					method: 'post',
					params: { 'fap_resume_seq' : fap_resume_seq 
								,'user_id' : user_id
					},
					XMLHttpRequestResponseType: 'json',
					headers : {
						"AJAX" : true
					}
				}).then(function successCallback(response) {
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
					
					}, 0);
					
				}, function errorCallback(response) {
					console.log(response);
					if(response.status == 403){
						alert('<spring:message code="com.login.ajaxSesstion" javaScriptEscape="true" />');
						location.href = "/fap/user/user_login";
					}
				});
			}
			//[start] 지원 이력서보기 모달창 출력 종료(남유송)
			
			//[start] 진행상황 상세정보 모달창 출력 시작
			$scope.openDetailInfoModal = function (e, status) {
				$('#detaildInfoModal').modal('show');
				var compName = $(e.currentTarget).attr('name') + ' 전형정보 상세보기';
				$http({
					url: 'select_apply_status_detail_info_modal',
					method: 'post',
					params: {
								fap_job_app_info_seq : $(e.currentTarget).attr('seq')
								,status : status
							},
					XMLHttpRequestResponseType: 'json',
					headers : {
						"AJAX" : true
					}
				}).then(function successCallback(response) {
					var applyDetailInfoList = response.data;
					$('#nameH3').children().remove();
					$('#applyStatusDiv').children().remove();
					var context = '';
					context += '<br>';
					$.each(applyDetailInfoList, function(index, applyDetailInfo){
						context +=	'<table class="applyDetailTb" id="applyDetailTb">';
						context +=		'<tr>';
						context +=			'<th class="adth1">';
						context +=				'' + applyDetailInfo.fap_job_recruit_pcs_od + '. <code value="'+ applyDetailInfo.fap_job_recruit_pcs_gb +'"></code>';
						context +=			'</th>';
						context +=		'</tr>';
						context +=		'<tr>';
						context +=			'<td class="adtd1">';
						if(applyDetailInfo.fap_job_app_rt_acp == undefined){
							context +=			'승인대기중';
						}else if(applyDetailInfo.fap_job_app_rt_acp.length > 5){
							context +=			'<code value="' + applyDetailInfo.fap_job_app_rt_acp.substring(0, 5) + '"></code> ' + applyDetailInfo.fap_job_app_rt_acp.substring(6, 7) + '순위';
						}else{
							context +=			'<code value="'+ applyDetailInfo.fap_job_app_rt_acp +'"></code>';
						}
						context +=			'<td>';
						context +=		'</tr>';
						context +=	'</table>';
					});
					$('#nameH3').html(compName);
					$('#applyStatusDiv').append($compile(context)($scope));
				}, function errorCallback(response) {
					console.log(response);
					if(response.status == 403){
						alert('<spring:message code="com.login.ajaxSesstion" javaScriptEscape="true" />');
						location.href = "/fap/user/user_login";
					}
				});
			}
			//[end] 진행상황 상세정보 모달창 출력 종료 
			
			//[start] 최종확정 모달창 출력 시작
			$scope.openFinalResultModal = function(e){
				$('#finalResultModal').modal('show');
				
				$('.final_decision_radio').removeClass('ck');
				$('.final_decision_radio').find('input:radio[name="fap_job_app_choice_comp_gb"]').prop('checked', false);
				
				var compName = $(e.currentTarget).attr('name');
				var fap_job_app_final_rt_seq = $(e.currentTarget).attr('seq');
				var fap_job_app_choice_comp_gb = $(e.currentTarget).attr('gb');
				var fap_comp_en_nm = $(e.currentTarget).attr('enname');
				
				$('input:radio[name="fap_job_app_choice_comp_gb"][value="'+fap_job_app_choice_comp_gb+'"]').prop('checked',true);
				
				$(':input:radio[name="fap_job_app_choice_comp_gb"]:checked').closest(".final_decision_radio").addClass("ck");
				
				$('#final_decision_name').html(compName);
				$('#fap_job_app_final_rt_seq').val(fap_job_app_final_rt_seq);
				$("#selected_fap_comp_en_nm").val(fap_comp_en_nm);
			}
			//[end] 최종확정 모달창 출력 종료
			
			//최종확정 저장 시작
			$scope.saveFinalDecision = function(e){
				if(confirm("저장하시겠습니까?")){
					
					var fap_jobfair_divide_seq = $("#fap_jobfair_divide_seq").val();
					var fap_job_app_final_rt_seq = $("#fap_job_app_final_rt_seq").val();
					var fap_job_app_choice_comp_gb = $(':input:radio[name="fap_job_app_choice_comp_gb"]:checked').val();
					var fap_comp_en_nm = $("#selected_fap_comp_en_nm").val();
					
					var paramMap = {};
					paramMap['fap_jobfair_divide_seq'] = fap_jobfair_divide_seq;
					paramMap['fap_job_app_final_rt_seq'] = fap_job_app_final_rt_seq;
					paramMap['fap_job_app_choice_comp_gb'] = fap_job_app_choice_comp_gb;
					
					$http({
	    				method: 'POST',
	    				url: "/fap/user/user_personal_apply_final_decision",
	    				headers: {
	    					'Content-Type': 'application/json',
	    					"AJAX" : true
	    				},
	    				data : JSON.stringify(paramMap),
	    				XMLHttpRequestResponseType: 'json'
	    			}).then(function successCallback(response) {
	    				if(response.data == 1){
	    					alert("이미 확정한 기업이 있습니다.\n수정을 원하시면 확정한 기업을 먼저 변경해주세요.");
	    				}else{
	    					alert("정상처리되었습니다.");
	    				}
	    				$('#finalResultModal').modal('hide');
	    				location.reload();
	    			}, function errorCallback(response) {
	    					console.log(response);
	    					if(response.status == 403){
	    						alert('<spring:message code="com.login.ajaxSesstion" javaScriptEscape="true" />');
	    						location.href = "/fap/user/user_login";
	    					}
	    			});
					
				}
			}
			//최종확정 저장 종료
						
			//[start] 승인 전 지원정보 삭제 시작
			$scope.deleteCurApplyInfo = function (e) {
				var realApply = confirm('정말 지원을 취소 하시겠습니까?');
				if(realApply == false){
					return false;
				}
	 			$http({
					url: 'delete_current_apply_info',
					method: 'post',
					params: {fap_job_app_info_seq : $(e.currentTarget).attr('seq')},
					XMLHttpRequestResponseType: 'json',
					headers : {
						"AJAX" : true
					}
				}).then(function successCallback(response) {
					
					if(response == null || response == ''){
						location.href = "/fap/user/user_main";
					}
					
					switch(response.data){
					case 'deleteSuccess' : 
						alert('해당회사에 대한 지원이 취소되었습니다.');
						location.href = '<c:url value="/fap/user/user_personal_apply_status_form" />';
						break;
					default : 
						alert('지원을 취소할 수 없습니다. 관리자에게 문의하세요.');
						break;
					}
					$scope.personalApplyStatus();
				}, function errorCallback(response) {
					console.log(response);
					if(response.status == 403){
						alert('<spring:message code="com.login.ajaxSesstion" javaScriptEscape="true" />');
						location.href = "/fap/user/user_login";
					}
				});
			}
			//[end] 승인 전 지원정보 삭제 종료
			
			//[start] 변경 후 순위 저장 시작
			$scope.saveChangeRank = function () {
				var allRankInfoTr = $('#rank_change_modal_apply_before_tbd').find('tr');
				var appInfoMapAry = new Array();
				var type_check = false;
				
				$.each(allRankInfoTr, function(index, item){
					if($(item).html() != null && $(item).html() != ''){
						
						if(($(this).find(".rctd1").text() != 1) && $(this).find(".rctd2 span").attr("value") == 'D2000'){
							type_check = true;
							return ;
						}
						
						var appInfoMap = {};
						appInfoMap['fap_job_app_info_seq'] = Number($(item).children().val());
						appInfoMap['fap_job_app_info_rank'] = Number($(item).attr('id').replace(/[^0-9]/g,''));
						appInfoMapAry.push(appInfoMap);
					}
				});
				
				if(type_check){
					alert("E Type의 채용공고는 1지망으로 지원해야 합니다.");
					return;
				}
				
				$http({
					url: 'request_apply_info_rank_change',
					method: 'post',
					headers: {
						'Content-Type': 'application/json',
						"AJAX" : true
					},
					data: JSON.stringify(appInfoMapAry),
					XMLHttpRequestResponseType: 'json'
				}).then(function successCallback(response) {
					if(response.data == 'changeSuccess'){
						alert('지망순위가 변경되었습니다.');
						location.href = '<c:url value="/fap/user/user_personal_apply_status_form" />';
					}
					else{
						alert('변경할 목록이 없습니다.');
					}
					
				}, function errorCallback(response) {
					if(response.status == 403){
						alert('<spring:message code="com.login.ajaxSesstion" javaScriptEscape="true" />');
						location.href = "/fap/user/user_login";
					}
				});
			}
			//[end] 변경 후 순위 저장 종료
			
			//[start] 지망순위 모달창 출력 시작
			$scope.openappliedCompanyRankEditInfoModal = function () {
				//모달열기
				$('#appliedCompanyRankEditInfoModal').modal('show');
				
				$http({
					url: 'select_applied_company_rank_edit_info_modal',
					method: 'post',
					XMLHttpRequestResponseType: 'json',
					headers : {
						"AJAX" : true
					}
				}).then(function successCallback(response) {
					
					if(response == null || response == ''){
						location.href = "/fap/user/user_main";
					}
					
					$('#myApplyCount').html('나의지망개수 : ' + response.data.perUserFixedCount + '개');
					//지망순위 변경여부 판단 배열
					var arrayRankChangeDecisionArray = new Array();
					for(var i=1; i<=response.data.perUserFixedCount; i++){
						arrayRankChangeDecisionArray[i] = i;
					}
					//[start] 최종합격이거나 진행중인 전형 출력 시작
					var acceptedAndProcessingPersonalApplyStatusList = response.data.acceptedAndProcessingPersonalApplyStatusList;
					var context1 = '';
					$('#rank_change_modal_apply_after_tbd').children().remove();
					for(var i in acceptedAndProcessingPersonalApplyStatusList){
						context1 += '<tr>';
						context1 += '<td class="astd1">' + acceptedAndProcessingPersonalApplyStatusList[i].fap_job_app_info_rank + '</td>';
						/* if(acceptedAndProcessingPersonalApplyStatusList[i].fap_job_ad_groupcode == 'D0500'){
							context1 += '<td class="astd2"> - </td>';
						}else{
							context1 += '<td class="astd2">' + acceptedAndProcessingPersonalApplyStatusList[i].fap_job_ad_groupcode + '</td>';
						} */
						context1 += '<td class="astd2"><code value="'+acceptedAndProcessingPersonalApplyStatusList[i].fap_job_ad_rule_type+'"></code></td>';
						context1 += '<td class="astd3">' + acceptedAndProcessingPersonalApplyStatusList[i].fap_comp_ja_nm + '</td>';
						context1 += '<td class="astd4"><code value="' + acceptedAndProcessingPersonalApplyStatusList[i].fap_job_app_rt_acp + '"></code></td>';
						context1 += '</tr>';
						arrayRankChangeDecisionArray[acceptedAndProcessingPersonalApplyStatusList[i].fap_job_app_info_rank] = 0;
					}
					$('#rank_change_modal_apply_after_tbd').append($compile(context1)($scope));
					//[end] 최종합격이거나 진행중인 전형 출력 종료
					
					//[start] 불합격된 전형 출력 시작
					var unAcceptedPersonalApplyStatusList = response.data.unAcceptedPersonalApplyStatusList;
					var context2 = '';
					$('#rank_change_modal_apply_unaccepted_tbd').children().remove();
					for(var i in unAcceptedPersonalApplyStatusList){
						context2 += '<tr>';
						context2 += '<td class="astd1">' + unAcceptedPersonalApplyStatusList[i].fap_job_app_info_rank + '</td>';
						/* if(unAcceptedPersonalApplyStatusList[i].fap_job_ad_groupcode == 'D0500'){
							context2 += '<td class="astd2"> - </td>';							
						}else{
							context2 += '<td class="astd2">' + unAcceptedPersonalApplyStatusList[i].fap_job_ad_groupcode + '</td>';
						} */
						context2 += '<td class="astd2"><code value="'+unAcceptedPersonalApplyStatusList[i].fap_job_ad_rule_type+'"></code></td>';
						context2 += '<td class="astd3">' + unAcceptedPersonalApplyStatusList[i].fap_comp_ja_nm + '</td>';
						context2 += '<td class="astd4">불합격</td>';
						context2 += '</tr>';
						arrayRankChangeDecisionArray[unAcceptedPersonalApplyStatusList[i].fap_job_app_info_rank] = 0;
					}
					$('#rank_change_modal_apply_unaccepted_tbd').append($compile(context2)($scope));
					//[end] 불합격된 전형 출력 종료
					
					//[start] 승인전 전형 출력 시작
					var approvalBeforePersonalApplyStatusList = response.data.approvalBeforePersonalApplyStatusList;
					var context3 = '';
					$('#rank_change_modal_apply_before_tbd').children().remove();
					for(var i=1; i<arrayRankChangeDecisionArray.length; i++){
						var innerCount = 0;
						for(var j in approvalBeforePersonalApplyStatusList){
							if(i == approvalBeforePersonalApplyStatusList[j].fap_job_app_info_rank){
								context3 += '<tr id="orderByApplyRankTr'+ approvalBeforePersonalApplyStatusList[j].fap_job_app_info_rank +'">';
								context3 += '<input type="hidden" id="fap_job_app_info_seq" name="fap_job_app_info_seq" value="'+ approvalBeforePersonalApplyStatusList[j].fap_job_app_info_seq +'">';
								context3 += '<td class="rctd1">' + approvalBeforePersonalApplyStatusList[j].fap_job_app_info_rank + '</td>';
								/* if(approvalBeforePersonalApplyStatusList[j].fap_job_ad_groupcode == 'D0500'){
									context3 += '<td class="rctd2"> - </td>';	
								}else{
									context3 += '<td class="rctd2">' + approvalBeforePersonalApplyStatusList[j].fap_job_ad_groupcode + '</td>';
								} */
								context3 += '<td class="rctd2"><code value="'+approvalBeforePersonalApplyStatusList[j].fap_job_ad_rule_type+'"></code></td>';
								context3 += '<td class="rctd3">' + approvalBeforePersonalApplyStatusList[j].fap_comp_ja_nm + '</td>';
								context3 += '<td class="rctd4"><button type="button" seq="' + approvalBeforePersonalApplyStatusList[j].fap_job_app_info_rank + '" onclick="applyInfoRankUp(this)" class="btn btn-primary">위로</button></td>';
								context3 += '<td class="rctd5"><button type="button" seq="' + approvalBeforePersonalApplyStatusList[j].fap_job_app_info_rank + '" onclick="applyInfoRankDown(this)" class="btn btn-danger">아래로</button></td>';
								context3 += '</tr>';
								innerCount = 1;
							}	
						}
						if(innerCount == 0 && arrayRankChangeDecisionArray[i] != 0){
							context3 += '<tr id="orderByApplyRankTr'+ i +'">';
							context3 += '</tr>';
						}
					}
					context3 += '</tbody>';
					$('#rank_change_modal_apply_before_tbd').append($compile(context3)($scope));
					//[end] 승인전 전형 출력 종료
				}, function errorCallback(response) {
					console.log(response);
					if(response.status == 403){
						alert('<spring:message code="com.login.ajaxSesstion" javaScriptEscape="true" />');
						location.href = "/fap/user/user_login";
					}
				});
			}
			//[end] 지원기업편집 모달창 출력 종료
			
			$timeout(function() {
				
				$.each($(".div-code"), function(index, item){
					var cd = $(this).attr("cd");
					var context = '<code value="'+cd+'"></code>';
					$(this).html(context);
				})

				$compile(".div-code")($scope);
			
			}, 0);
			
		}]);
		
		//selectcode
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
		}]);
		
		//codeconverter
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
		
		//[start] 해당 기업 지망 올리기 시작
		function applyInfoRankUp(culButton) {
			//현재 클릭한 지망순위 담는 tr
			var curRankTrId = '#orderByApplyRankTr' + $(culButton).attr('seq');
			var curRank = $(curRankTrId).attr('id').replace(/[^0-9]/g,'');
			//현재 클릭된 버튼의 하나위에 이동가능한 지망순위 담는 tr
			var preRankTrId = $(curRankTrId).prev().attr('id');
			if(preRankTrId == undefined){return false;}
			var preRank = $(curRankTrId).prev().attr('id').replace(/[^0-9]/g,'');
			
			//현재 열의 지망순위와 하나 위에 지망열을 바꿔주는 부분
			$(curRankTrId).children().eq(1).html(preRank);
			$(curRankTrId).prev().children().eq(1).html(curRank);
			//현재 열과 하나 위에 열의 버튼 시퀀스를 바꿔주는 부분
			$(curRankTrId).children().eq(4).children().attr('seq', preRank);
			$(curRankTrId).children().eq(5).children().attr('seq', preRank);
			$(curRankTrId).prev().children().eq(4).children().attr('seq', curRank);
			$(curRankTrId).prev().children().eq(5).children().attr('seq', curRank);

			//열을 바꿔주기위해 html을 저장해주는 부분
			var curHtmlInfo = $(curRankTrId).html();
			var preHtmlInfo = $(curRankTrId).prev().html();
			
			//현재 열 지망정보를 하나 위의 지망정보로 변경하는 부분
			$(curRankTrId).html(preHtmlInfo);
			$(curRankTrId).prev().html(curHtmlInfo);
		}
		//[end] 해당 기업 지망 올리기 종료
		
		//[start] 해당 기업 지망 내기기 시작
		function applyInfoRankDown(culButton) {
			//현재 클릭한 지망순위 담는 tr
			var curRankTrId = '#orderByApplyRankTr' + $(culButton).attr('seq');
			var curRank = $(curRankTrId).attr('id').replace(/[^0-9]/g,'');
			//현재 클릭된 버튼의 하나 아래에 이동가능한 지망순위 담는 tr
			var nextRankTrId = $(curRankTrId).next().attr('id');
			if(nextRankTrId == undefined){return false;}
			var nextRank = $(curRankTrId).next().attr('id').replace(/[^0-9]/g,'');
			
			//현재 열의 지망순위와 하나 아래에 지망열을 바꿔주는 부분
			$(curRankTrId).children().eq(1).html(nextRank);
			$(curRankTrId).next().children().eq(1).html(curRank);
			//현재 열과 하나 아래에 열의 버튼 시퀀스를 바꿔주는 부분
			$(curRankTrId).children().eq(4).children().attr('seq', nextRank);
			$(curRankTrId).children().eq(5).children().attr('seq', nextRank);
			$(curRankTrId).next().children().eq(4).children().attr('seq', curRank);
			$(curRankTrId).next().children().eq(5).children().attr('seq', curRank);

			//열을 바꿔주기위해 html을 저장해주는 부분
			var curHtmlInfo = $(curRankTrId).html();
			var nextHtmlInfo = $(curRankTrId).next().html();
			
			//현재 열 지망정보를 하나 위의 지망정보로 변경하는 부분
			$(curRankTrId).html(nextHtmlInfo);
			$(curRankTrId).next().html(curHtmlInfo);
		}
		//[end] 해당 기업 지망 내리기 종료
		
		$(function(){
			$(".final_decision_radio").on("click", function(){
				$('.final_decision_radio').removeClass('ck');
				$('.final_decision_radio').find('input:radio[name="fap_job_app_choice_comp_gb"]').prop('checked', false);
				
				$(this).addClass("ck");
				$(this).find('input:radio[name="fap_job_app_choice_comp_gb"]').prop('checked', true);
			})
			
			$.each($(".final_decision_textarea"),function(index,item){
				$(this).css('height', $(this).prop('scrollHeight')+12);
			})
		})
		
	</script>
	<title>Bridge Job Fair</title>
</head>

<body ng-app="myapp" ng-controller="PersonalApplicationStatusController">
	<sec:authorize access="hasAnyRole('ROLE_A0100', 'ROLE_A0101', 'ROLE_A0102', 'ROLE_A0106', 'ROLE_A0108')">
	<sec:authentication property="details.user" var="detail" />
	</sec:authorize>
	<!-- userId 정보 가져와주세요 -->
	<input type="hidden" name="user_id" value="${detail.user_id}" id="user_id">
	<input type="hidden" name="fap_resume_ins_id" value="${detail.user_id}">
	<input type="hidden" name="fap_resume_udt_id" value="${detail.user_id}">
	<%@include file="user_menu.jsp"%>
	
	<div class="join-wrap">
		<div id="subcontents">
			<h1>개인지원현황</h1>
			<h6><span class="red">다양한 준비로 더 많은 취업성공을 이끕니다!</span></h6>
			<c:if test="${ not empty finalDecision}">
				<textarea class="final_decision_textarea" disabled="disabled">${finalDecision.fap_jobfair_final_decision_time_ct }</textarea>
			</c:if>
			
			<c:if test="${not empty finalPersonalApplyStatusListMap.unAcceptedPersonalApplyStatusList or not empty finalPersonalApplyStatusListMap.acceptedAndProcessingPersonalApplyStatusList or not empty finalPersonalApplyStatusListMap.approvalBeforePersonalApplyStatusList}">
				<div style="text-align: right;">
					<button type="button" class="btn4 btn-primary" ng-click="openappliedCompanyRankEditInfoModal()" 
						style="height: 50px;">
		        		지원순위변경
				    </button>
			    </div>
		    </c:if>
			
			<%--승인된 채용공고 종료 --%>
			<c:if test="${not empty finalPersonalApplyStatusListMap.acceptedAndProcessingPersonalApplyStatusList}">
				<h4 style="text-align: left;">승인된 기업 지원현황</h4>
				<div id="applyBox">
					<div id="applyBBS">
						<ul class="tit1">
							<li class="wid1">지망</li>
							<li class="wid2">채용공고 제목</li>
							<li class="wid3">기업명</li>
							<li class="wid4">타입</li>
							<li class="wid5">승인일</li>
							<li class="wid6">이력서보기</li>
							<li class="wid7">진행상황</li>
							<li class="wid8">상세정보</li>
							<li class="wid8">최종확정</li>
	 					</ul>
	 					
						<c:forEach var="acceptedAndProcessingPersonalApplyStatusList" items="${finalPersonalApplyStatusListMap.acceptedAndProcessingPersonalApplyStatusList}" varStatus="status">
		 					<ul class="tit2">
								<li class="wid1">${acceptedAndProcessingPersonalApplyStatusList.fap_job_app_info_rank}</li>
								<li class="wid2">
									<a href="<c:url value="/fap/user/user_job_advertisement_read_form?fap_job_ad_seq=${acceptedAndProcessingPersonalApplyStatusList.fap_job_ad_seq}" />" title="${acceptedAndProcessingPersonalApplyStatusList.fap_job_ad_title}">
										${acceptedAndProcessingPersonalApplyStatusList.fap_job_ad_title}
									</a>
								</li>
								<li class="wid3">${acceptedAndProcessingPersonalApplyStatusList.fap_comp_ja_nm}</li>
								<%-- <c:choose>
									<c:when test="${acceptedAndProcessingPersonalApplyStatusList.fap_job_ad_groupcode eq 'D0500'}">
										<li class="wid4"><code value="${acceptedAndProcessingPersonalApplyStatusList.fap_job_ad_groupcode}"></code></li>	
									</c:when>
									<c:otherwise>
										<li class="wid4">${acceptedAndProcessingPersonalApplyStatusList.fap_job_ad_groupcode}</li>
									</c:otherwise>
								</c:choose> --%>
								<li class="wid4">
									<code value="${acceptedAndProcessingPersonalApplyStatusList.fap_job_ad_rule_type}"></code>
								</li>
								<li class="wid5">
									${acceptedAndProcessingPersonalApplyStatusList.fap_job_app_info_ins_dt}
						      	</li>
								<li class="wid6">
									<button type="button" resume_seq="${acceptedAndProcessingPersonalApplyStatusList.fap_resume_seq}" ng-click="openResumeDetailModal($event)" class="btn btn-primary">보기</button>
								</li>
								<li class="wid7"><code value="${acceptedAndProcessingPersonalApplyStatusList.fap_job_app_final_rt_acp_user}"></code></li>
								<li class="wid8">
									<br>
									<button type="button" name="${acceptedAndProcessingPersonalApplyStatusList.fap_comp_ja_nm}" seq="${acceptedAndProcessingPersonalApplyStatusList.fap_job_app_info_seq}" ng-click="openDetailInfoModal($event, 'after')" class="btn btn-primary">확인</button>
								</li>
								<li class="wid8">
									<c:choose>
										<c:when test="${empty finalDecision}">
											<div class="div-code" cd="${acceptedAndProcessingPersonalApplyStatusList.fap_job_app_choice_comp_gb}"></div>
										</c:when>
										<c:otherwise>
											<c:choose>
												<c:when test="${acceptedAndProcessingPersonalApplyStatusList.fap_job_app_final_rt_acp_user != 'D0001' && acceptedAndProcessingPersonalApplyStatusList.fap_job_app_final_rt_acp_user != 'D0004'}">
													<div class="div-code" cd="${acceptedAndProcessingPersonalApplyStatusList.fap_job_app_choice_comp_gb}"></div>
												</c:when>
												<c:otherwise>
													<c:choose>
														<c:when test="${acceptedAndProcessingPersonalApplyStatusList.fap_job_app_final_btn_gb == 'D1801' }">
															<div class="div-code" cd="${acceptedAndProcessingPersonalApplyStatusList.fap_job_app_choice_comp_gb}"></div>
														</c:when>
														<c:when test="${acceptedAndProcessingPersonalApplyStatusList.fap_job_app_final_rt_acp_user == 'D0004'}">
															<div class="div-code" cd="${acceptedAndProcessingPersonalApplyStatusList.fap_job_app_choice_comp_gb}"></div>
														</c:when>
														<c:otherwise>
															<c:choose>
																<c:when test="${finalPersonalApplyStatusListMap.eTypeFlag && acceptedAndProcessingPersonalApplyStatusList.fap_job_ad_rule_type == 'D2000' }">
																	<button type="button" name="${acceptedAndProcessingPersonalApplyStatusList.fap_comp_ja_nm}" seq="${acceptedAndProcessingPersonalApplyStatusList.fap_job_app_final_rt_seq}" enname="${acceptedAndProcessingPersonalApplyStatusList.fap_comp_en_nm}"  gb="${acceptedAndProcessingPersonalApplyStatusList.fap_job_app_choice_comp_gb}" class="btn btn-primary" ng-click="openFinalResultModal($event)">확인</button>																
																</c:when>
																<c:when test="${finalPersonalApplyStatusListMap.eTypeFlag && acceptedAndProcessingPersonalApplyStatusList.fap_job_ad_rule_type != 'D2000' }">
																	-
																</c:when>
																<c:otherwise>
																	<button type="button" name="${acceptedAndProcessingPersonalApplyStatusList.fap_comp_ja_nm}" seq="${acceptedAndProcessingPersonalApplyStatusList.fap_job_app_final_rt_seq}" enname="${acceptedAndProcessingPersonalApplyStatusList.fap_comp_en_nm}"  gb="${acceptedAndProcessingPersonalApplyStatusList.fap_job_app_choice_comp_gb}" class="btn btn-primary" ng-click="openFinalResultModal($event)">확인</button>
																</c:otherwise>
															</c:choose>
														</c:otherwise>
													</c:choose>
												</c:otherwise>
											</c:choose>
										</c:otherwise>
									</c:choose>
								</li>
							</ul>
						</c:forEach>	
					</div>
				</div>
				<br>
			</c:if>
			<%--승인된 채용공고 종료 --%>
			
			<%--승인전 채용공고 종료 --%>
			<c:if test="${not empty finalPersonalApplyStatusListMap.approvalBeforePersonalApplyStatusList}">
				<h4 style="text-align: left;">승인전 기업 지원현황</h4>
				<div id="applyBox">
					<div id="applyBBS">
						<ul class="tit1">
							<li class="wid1">지망</li>
							<li class="wid2">채용공고 제목</li>
							<li class="wid3">기업명</li>
							<li class="wid4">타입</li>
							<li class="wid5">전형상황</li>
							<li class="wid6">비고</li>
							<li class="wid7">이력서보기</li>
							<li class="wid8">상세정보</li>
							<li class="wid9">지원취소</li>
	 					</ul>
	 					
						<c:forEach var="approvalBeforePersonalApplyStatusList" items="${finalPersonalApplyStatusListMap.approvalBeforePersonalApplyStatusList}" varStatus="status">
		 					<ul class="tit2">
								<li class="wid1">${approvalBeforePersonalApplyStatusList.fap_job_app_info_rank}</li>
								<li class="wid2">
									<a href="<c:url value="/fap/user/user_job_advertisement_read_form?fap_job_ad_seq=${approvalBeforePersonalApplyStatusList.fap_job_ad_seq}" />" title="${approvalBeforePersonalApplyStatusList.fap_job_ad_title}">
										${approvalBeforePersonalApplyStatusList.fap_job_ad_title}
									</a>
								</li>
								<li class="wid3">${approvalBeforePersonalApplyStatusList.fap_comp_ja_nm}</li>
								<%-- <c:choose>
									<c:when test="${approvalBeforePersonalApplyStatusList.fap_job_ad_groupcode eq 'D0500'}">
										<li class="wid4"><code value="${approvalBeforePersonalApplyStatusList.fap_job_ad_groupcode}"></code></li>	
									</c:when>
									<c:otherwise>
										<li class="wid4">${approvalBeforePersonalApplyStatusList.fap_job_ad_groupcode}</li>
									</c:otherwise>
								</c:choose> --%>
								<li class="wid4">
									<code value="${approvalBeforePersonalApplyStatusList.fap_job_ad_rule_type}"></code>
								</li>
								<li class="wid5">승인대기</li>
								<c:choose>
									<c:when test="${approvalBeforePersonalApplyStatusList.adPerPossibleQuarter eq -1 or approvalBeforePersonalApplyStatusList.fap_job_app_info_rank <= approvalBeforePersonalApplyStatusList.adPerPossibleQuarter}">
										<li class="wid6"> - </li>	
									</c:when>
									<c:when test="${approvalBeforePersonalApplyStatusList.adPerPossibleQuarter == 0}">
										<li class="wid6"><h5 style="color: red;">더 이상 지원이 불가능 합니다.</h5></li>
									</c:when>
									<c:otherwise>
										<li class="wid6"><h5 style="color: red;">${approvalBeforePersonalApplyStatusList.adPerPossibleQuarter} 지망 이상으로<br>지망을 올려주세요.</h5></li>
									</c:otherwise>
								</c:choose>
								
								<li class="wid7">
									<button type="button" resume_seq="${approvalBeforePersonalApplyStatusList.fap_resume_seq}" ng-click="openResumeDetailModal($event)" class="btn btn-primary">보기</button>
								</li>
								<li class="wid8">
									<br>
									<button type="button" name="${approvalBeforePersonalApplyStatusList.fap_comp_ja_nm}" seq="${approvalBeforePersonalApplyStatusList.fap_job_app_info_seq}" ng-click="openDetailInfoModal($event, 'before')" class="btn btn-primary">확인</button>
								</li>
								<li class="wid9">
									<br>
									<button type="button" seq="${approvalBeforePersonalApplyStatusList.fap_job_app_info_seq}" ng-click="deleteCurApplyInfo($event)" class="btn btn-primary">지원취소</button>
								</li>
							</ul>
						</c:forEach>	
					</div>
				</div>
				<br>
			</c:if>
			<%--승인전 채용공고 종료 --%>
			
			<%--불합격된 채용공고 종료 --%>
			<c:if test="${not empty finalPersonalApplyStatusListMap.unAcceptedPersonalApplyStatusList}">
				<h4 style="text-align: left;">불합격된 기업 지원현황</h4>
				<div id="applyBox">
					<div id="applyBBS">
						<ul class="tit1">
							<li class="wid1">지망</li>
							<li class="wid2">채용공고 제목</li>
							<li class="wid3">기업명</li>
							<li class="wid4">타입</li>
							<li class="wid5">승인일</li>
							<li class="wid6">이력서보기</li>
							<li class="wid7">진행상황</li>
							<li class="wid8">상세정보</li>
	 					</ul>
	 					
						<c:forEach var="unAcceptedPersonalApplyStatusList" items="${finalPersonalApplyStatusListMap.unAcceptedPersonalApplyStatusList}" varStatus="status">
		 					<ul class="tit2">
								<li class="wid1">${unAcceptedPersonalApplyStatusList.fap_job_app_info_rank}</li>
								<li class="wid2">
									<a href="<c:url value="/fap/user/user_job_advertisement_read_form?fap_job_ad_seq=${unAcceptedPersonalApplyStatusList.fap_job_ad_seq}" />" title="${unAcceptedPersonalApplyStatusList.fap_job_ad_title}">
										${unAcceptedPersonalApplyStatusList.fap_job_ad_title}
									</a>
								</li>
								<li class="wid3">${unAcceptedPersonalApplyStatusList.fap_comp_ja_nm}</li>
								<%-- <c:choose>
									<c:when test="${unAcceptedPersonalApplyStatusList.fap_job_ad_groupcode eq 'D0500'}">
										<li class="wid4"><code value="${unAcceptedPersonalApplyStatusList.fap_job_ad_groupcode}"></code></li>	
									</c:when>
									<c:otherwise>
										<li class="wid4">${unAcceptedPersonalApplyStatusList.fap_job_ad_groupcode}</li>
									</c:otherwise>
								</c:choose> --%>
								<li class="wid4">
									<code value="${unAcceptedPersonalApplyStatusList.fap_job_ad_rule_type}"></code>
								</li>
								<li class="wid5">
									${unAcceptedPersonalApplyStatusList.fap_job_app_info_ins_dt}
						      	</li>
								<li class="wid6">
									<button type="button" resume_seq="${unAcceptedPersonalApplyStatusList.fap_resume_seq}" ng-click="openResumeDetailModal($event)" class="btn btn-primary">보기</button>	
								</li>
								<li class="wid7">불합격</li>
								<li class="wid8">
									<br>
									<button type="button" name="${unAcceptedPersonalApplyStatusList.fap_comp_ja_nm}" seq="${unAcceptedPersonalApplyStatusList.fap_job_app_info_seq}" ng-click="openDetailInfoModal($event, 'after')" class="btn btn-primary">확인</button>
								</li>
							</ul>
						</c:forEach>	
					</div>
				</div>
				<br>
			</c:if>
			<%--불합격된 채용공고 종료 --%>
			
		</div>
	</div>	
	
	<!--------------- 최종확정 모달 시작 --------------->
	<div class="modal fade" id="finalResultModal" role="dialog">
	
		<!-- Modal dialog------------------------->
		<div class="modal-dialog" id="modal-dialog">
		
			<!-- 1 Modal content------------------------->
			<div class="modal-content">
				<div class="modal-header">
					<h4 class="modal-title" id="title">
						최종확정
					</h4>
				</div>
				
				<!-- body 시작-->
				<div class="final_decision_modal_body" id="final_decision_modal_body">
					<br><br>
					<h3 id="final_decision_name"></h3>
					<br>
					<div class="final_decision_status_div" id="final_decision_status_div">
						<c:choose>
							<c:when test="${finalPersonalApplyStatusListMap.eTypeFlag }">
								<span class="final_decision_radio">
									<label class="final_decision_radio_label">
										<code value="D0701"></code>
									</label>
									<input type="radio" id="final_decision_yes" name="fap_job_app_choice_comp_gb" value="D0701">
								</span>
							</c:when>
							<c:otherwise>
								<span class="final_decision_radio">
									<label class="final_decision_radio_label">
										<code value="D0701"></code>
									</label>
									<input type="radio" id="final_decision_yes" name="fap_job_app_choice_comp_gb" value="D0701">
								</span>
								<span class="final_decision_radio">
									<label class="final_decision_radio_label">
										<code value="D0702"></code>
									</label>
									<input type="radio" id="final_decision_no" name="fap_job_app_choice_comp_gb" value="D0702">
								</span>
									<span class="final_decision_radio">
									<label class="final_decision_radio_label">
										<code value="D0700"></code>
									</label>
									<input type="radio" id="final_decision_stay" name="fap_job_app_choice_comp_gb" value="D0700">
								</span>
								<p>* 확정기간 동안은 변경이 가능합니다.</p>
							</c:otherwise>
						</c:choose>
					</div>
					<br>
        		</div>
        		<input type="hidden" name="fap_job_app_final_rt_seq" id="fap_job_app_final_rt_seq">
        		<input type="hidden" name="fap_jobfair_divide_seq" id="fap_jobfair_divide_seq" value="${fap_jobfair_divide_seq }">
				<input type="hidden" name="fap_comp_en_nm" id="selected_fap_comp_en_nm">
				<!-- body 끝 -->

				<div class="modal-footer">
					<button type="button" id="finalDecisionModalBtnSave" class="btn btn-default" ng-click="saveFinalDecision()">저장</button>
					<button type="button" id="finalDecisionModalBtnClose" class="btn btn-default" data-dismiss="modal">닫기</button>
				</div>
			
			</div>
			<!-- modal content div 종료 -->
			
		</div>
		<!-- modal-dialog div 종료 -->
		
	</div>  
	<!-- modal fade div 종료 -->
	<!--------------- 최종확정 모달 끝 --------------->
	
	<!--------------- 상세정보 모달 시작 --------------->
	<div class="modal fade" id="detaildInfoModal" role="dialog">
	
		<!-- Modal dialog------------------------->
		<div class="modal-dialog" id="modal-dialog">
		
			<!-- 1 Modal content------------------------->
			<div class="modal-content">
				<div class="modal-header">
					<h4 class="modal-title" id="title">
						상세정보
					</h4>
				</div>
				
				<!-- body 시작-->
				<div class="apply_detail_modal_body" id="apply_detail_modal_body">
					<br><br>
					<h3 id="nameH3"></h3>
					<br>
					<div class="applyStatusDiv" id="applyStatusDiv">
					</div>
        		</div>
				<!-- body 끝 -->

				<div class="modal-footer">
					<button type="button" id="closeModalBtnClose" class="btn btn-default" data-dismiss="modal">닫기</button>
				</div>
			
			</div>
			<!-- modal content div 종료 -->
			
		</div>
		<!-- modal-dialog div 종료 -->
		
	</div>  
	<!-- modal fade div 종료 -->
	<!--------------- 상세정보 모달 끝 --------------->
	
	
	<!--------------- 지원기업편집 모달 시작 --------------->
	<div class="modal fade" id="appliedCompanyRankEditInfoModal" role="dialog">
	
		<!-- Modal dialog------------------------->
		<div class="modal-dialog" id="modal-dialog">
		
			<!-- 1 Modal content------------------------->
			<div class="modal-content">
				<div class="modal-header">
					<h4 class="modal-title" id="title">
						지원기업정보
					</h4>
				</div>
				
				<!-- body 시작-->
				<div class="rank_change_modal_body">
					<h4 style="text-align: right; padding-right: 2%;" id="myApplyCount"></h4>
					<br>
	        		<!-- 최종합격이거나 진행중인 지원기업현황 테이블 시작 -->
		            <table class="applyStatusTb" id="rank_change_modal_apply_after_tb">
		            	<caption><h3>승인완료</h3></caption>
						<thead id="rank_change_modal_apply_after_tbh">
							<tr>
								<th class="asth1" scope="col">지망</th>
								<th class="asth2" scope="col">타입</th>
								<th class="asth3" scope="col">기업명</th>
								<th class="asth4" scope="col">전형상황</th>
							</tr>
						</thead>
						<tbody id="rank_change_modal_apply_after_tbd">
						</tbody>
					</table>
					<!-- 최종합격이거나 진행중인 지원기업현황 테이블 종료 -->
					<br><br>
					
					<!-- 관리자 승인 전 지원기업현황 테이블 시작 -->
					<table class="rankChangeTb" id="rank_change_modal_apply_before_tb">
						<caption><h3>승인대기</h3></caption>
						<thead id="rank_change_modal_apply_before_tbh">
							<tr>
								<th class="rcth1" scope="col">지망</th>
								<th class="rcth2" scope="col">타입</th>
								<th class="rcth3" scope="col">기업명</th>
								<th class="rcth4" scope="col">지망 위로</th>
								<th class="rcth5" scope="col">지망 아래로</th>
							</tr>
						</thead>
						<tbody id="rank_change_modal_apply_before_tbd">
						</tbody>
					</table>
					<!-- 관리자 승인 전 지원기업현황 테이블 종료 -->
					<br><br>
					
					<!-- 불합격된 지원기업현황 테이블 시작 -->
					<table class="applyStatusTb" id="rank_change_modal_apply_unaccepted_tb">
						<caption><h3>불합격</h3></caption>
						<thead id="rank_change_modal_apply_unaccepted_tbh">
							<tr>
								<th class="asth1" scope="col">지망</th>
								<th class="asth2" scope="col">타입</th>
								<th class="asth3" scope="col">기업명</th>
								<th class="asth4" scope="col">전형상황</th>
							</tr>
						</thead>
						<tbody id="rank_change_modal_apply_unaccepted_tbd">
						</tbody>
					</table>
					<!-- 불합격된 지원기업현황 테이블 종료 -->
					<br>
        		</div>
				<!-- body 끝 -->

				<div class="modal-footer">
					<button type="button" id="rankChangeModalBtnSave" class="btn btn-default" ng-click="saveChangeRank()">저장</button>
					<button type="button" id="rankChangeModalBtnClose" class="btn btn-default" data-dismiss="modal">닫기</button>
				</div>
			
			</div>
			<!-- modal content div 종료 -->
			
		</div>
		<!-- modal-dialog div 종료 -->
		
	</div>  
	<!-- modal fade div 종료 -->
	<!--------------- 지원기업편집 모달 끝 --------------->
	
	<!--------------- 이력서 모달 시작(남유송) --------------->
	<div class="modal fade" id="resumeInfoModal" role="dialog">
	
		<!-- Modal dialog------------------------->
		<div class="modal-dialog" id="modal-dialog" style="max-width: 1200px;">
		
			<!-- 1 Modal content------------------------->
			<div class="modal-content">
				<div class="modal-header">
		          <h4 class="modal-title" id="title"><span ng-bind="resumeApply.fap_resume_title"></span></h4>
		          <button type="button" class="close" data-dismiss="modal">&times;</button>
		        </div>
				
				<!-- body 시작-->
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
							<div class="userjoinBox">
								<h2>
									<spring:message code="fap.resume.talent" />
								</h2>
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
							<!-- ----------------------------역량/재능(ICT, 외국어, 인간관계 등 업무 관련 상세) --------------------------------------------->
							<div class="userjoinBox">
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
							<div class="userjoinBox">
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
						
						<!-- body 끝 -->
		        </div>
		        <div class="modal-footer">
		          <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
		        </div>
				
			</div>
			<!-- modal content div 종료 -->
			
		</div>
		<!-- modal-dialog div 종료 -->
		
	</div>  
	<!-- modal fade div 종료 -->
	<!--------------- 이력서 모달 끝(남유송) --------------->
	
	<%@include file="../common_footer_fap.jsp"%>
</body>
</html>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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

	<link rel="stylesheet" type="text/css" href="<c:url value="/resources/segroup/society/fap/css/userDefault.css" />" />
	<link rel="stylesheet" type="text/css" href="<c:url value="/resources/segroup/society/fap/css/popModal.css" />" />
	
	<script type="text/javascript">
		var myApp = angular.module('myapp', []);
		
		myApp.controller('TotalApplicationStatusController', ['$scope', '$compile', '$http', function($scope, $compile, $http) {
			$scope.openTotalDetailInfoModal = function (e) {
				var fap_job_ad_seq = $(e.currentTarget).attr('seq');
				//Ajax처리시 요청대기시간이 길 수 도있어서 먼저 삭제시켜주고 요청한다.
				$('#company_apply_status_tbd').children().remove();
				$('#perRankStatusDiv').children().remove();
				$('#myRankStatusDiv').children().remove();
				$('#totalDetaildInfoModal').modal('show');
				
				$http({
					url: 'select_total_apply_status_detail_info_modal',
					method: 'post',
					params: {fap_job_ad_seq : fap_job_ad_seq},
					XMLHttpRequestResponseType: 'json',
					headers : {
						"AJAX" : true
					}
				}).then(function successCallback(response) {
					//[start]전체지원현황 출력해주는 부분 시작
					console.log(response.data);
					
					var companyApplyInfo = response.data.companyApplyInfo;
					
					var context1 = '';
					context1 += '<tr>';
					context1 += 	'<td class="castd1">';
					context1 += 		companyApplyInfo.fap_comp_ja_nm;
					context1 += 	'</td>';
					context1 += 	'<td class="castd2">';
					if(companyApplyInfo.fap_job_ad_groupcode == 'D0500'){
						context1 += 	'-';
					}else{
						context1 += 	companyApplyInfo.fap_job_ad_groupcode;	
					}
					context1 += 	'</td>';
					context1 += 	'<td class="castd3">';
					context1 += 		companyApplyInfo.fap_job_ad_recruit_num;
					context1 += 	'</td>';
					context1 += 	'<td class="castd4">';
					context1 += 		companyApplyInfo.fap_job_app_per_settled_num;
					context1 += 	'</td>';
					context1 += 	'<td class="castd5">';
					context1 += 		companyApplyInfo.now_apply_nums;
					context1 += 	'</td>';
					context1 += '</tr>';
					$('#company_apply_status_tbd').append($compile(context1)($scope));
					//[end]전체지원현황 출력해주는 부분 종료
					
					//[start]지망개수 별 현황 출력해주는 부분 시작
					var rankPerApplyRankList = response.data.rankPerApplyRankList;
					var maxApplyRank = response.data.maxApplyRank;
					context2 = '';
					context2 = '<h3 style="margin-bottom:10px; text-align: left;">지망 순위 현황</h3>';
					$.each(rankPerApplyRankList, function(index, rankPerApplyRank){
						for(var i=1; i<=maxApplyRank; i++){
							if(rankPerApplyRank[i] != undefined) {
								context2 +=	'<table class="perRankStatusTb" id="perRankStatusTb">';
								context2 +=		'<tr>';
								context2 +=			'<th class="prsdth">';
								context2 +=				i + '지망';
								context2 +=			'</th>';
								context2 +=		'</tr>';
								context2 +=		'<tr>';
								context2 +=			'<td class="prsdtd">';
								context2 +=				rankPerApplyRank[i] + '명';
								context2 +=			'<td>';
								context2 +=		'</tr>';
								context2 +=	'</table>';
							}
						}	
					});
					$('#perRankStatusDiv').append($compile(context2)($scope));
					//[end]지망개수 별 현황 출력해주는 부분 종료
					
					//[start]나의지망순위 정보 시작
					var myApplyRank = response.data.myApplyRank;
					var applyPossibleQuarter = response.data.applyPossibleQuarter;
					var applyPerSettledNum = response.data.applyPerSettledNum;
					
					context3 = '';
					if(applyPerSettledNum <= 0){
						context3 += '<h3 style="color:red;"> 지망가능순위 : 더 이상 지원이 불가능 합니다.</h3>';
					}else if(applyPossibleQuarter == 0 && companyApplyInfo.fap_job_app_per_settled_num > 0){
						context3 += '<h3 style="color:blue;"> 지망가능순위 : 현재 자유롭게 지원이 가능합니다.</h3>';
					}else{
						context3 += '<h3 style="color:blue;"> 지망가능순위 : '+ applyPossibleQuarter +'지망이상만 지원이 가능합니다.</h3>';
					}
					//
					if(myApplyRank < 1){
						context3 += '<h3> 나의지망순위 : -</h3>';
					}else{
						context3 += '<h3> 나의지망순위 : '+ myApplyRank + '지망</h3>';
					}
					//
					if(applyPossibleQuarter != 0 && myApplyRank > applyPossibleQuarter){
						context3 += '<h4 style="color:red;">&nbsp;&nbsp;*나의 지망순위를 '+ applyPossibleQuarter + '이상으로 올려야합니다.</h4>';
					}
					$('#myRankStatusDiv').append($compile(context3)($scope));
					//[end]나의지망순위 정보 종료
				}, function errorCallback(response) {
					console.log(response);
					if(response.status == 403){
						alert('<spring:message code="com.login.ajaxSesstion" javaScriptEscape="true" />');
						location.href = "/fap/user/user_login";
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
	
</head>
<body ng-app="myapp" ng-controller="TotalApplicationStatusController">
	<%@include file="user_menu.jsp"%>
	
	<div class="join-wrap">
		<div id="subcontents">
			<h1>전체지원현황</h1>
			<h6><span class="red">다양한 준비로 더 많은 취업성공을 이끕니다!</span></h6>
			
			<div id="nowBox">
				<div id="nowBBS">
					<ul class="tit1">
						<li class="wid1">No</li>
						<!-- 임시로 width값 조정 -->
						<li class="wid2" style="width: 33%;">채용공고 제목</li>
						<li class="wid3">회사명</li>
						<li class="wid3">타입</li>
						<li class="wid4">채용예정인원</li>
						<li class="wid5">지원가능인원</li>
						<li class="wid6">현재지원인원</li>
						<%--
							<li class="wid7">자세한 지원정보 보기</li>
						 --%>
 					
 					</ul>
 					
					<c:forEach var="perJobfairTotalApply" items="${perJobfairTotalApplyList}" varStatus="status">
	 					<ul class="tit2">
							<li class="wid1">${status.count}</li>
							<!-- 임시로 width값 조정 -->
							<li class="wid2" title="${perJobfairTotalApply.fap_job_ad_title}" style="width: 33%;">${perJobfairTotalApply.fap_job_ad_title}</li>
							<li class="wid3 ellipsis" title="${perJobfairTotalApply.fap_comp_ja_nm }">
								${perJobfairTotalApply.fap_comp_ja_nm }
							</li>
							<li class="wid3">
								<code value="${perJobfairTotalApply.fap_job_ad_rule_type }"></code>
							</li>
							<%-- <li class="wid3">
								<c:choose>
									<c:when test="${perJobfairTotalApply.fap_job_ad_groupcode == 'D0500'}">
										-
									</c:when>
									<c:otherwise>
										${perJobfairTotalApply.fap_job_ad_groupcode}
									</c:otherwise>
								</c:choose>
							</li> --%>
							<li class="wid4">${perJobfairTotalApply.fap_job_ad_recruit_num}</li>
							<li class="wid5">${perJobfairTotalApply.fap_job_app_per_settled_num}</li>
							<li class="wid6">${perJobfairTotalApply.now_apply_nums}</li>
							<%--
								<li class="wid7">
									<br>
									<button type="button" seq="${perJobfairTotalApply.fap_job_ad_seq}" ng-click="openTotalDetailInfoModal($event)" class="btn btn-primary">보기</button>
								</li>
							 --%>
						</ul>
					</c:forEach>	
				</div>
			</div>
		</div>
	</div>
	
	<!--------------- 상세정보 모달 시작 --------------->
	<div class="modal fade" id="totalDetaildInfoModal" role="dialog">
	
		<!-- Modal dialog------------------------->
		<div class="modal-dialog" id="modal-dialog">
		
			<!-- 1 Modal content------------------------->
			<div class="modal-content" style="margin-left: -10%; width: 120%; height: 120%;">
				<div class="modal-header">
					<h4 class="modal-title" id="title">
						상세정보
					</h4>
				</div>
				
				<!-- body 시작-->
				<div class="rank_change_modal_body" style="width: 90%;">
					<br><br>
	        		<!-- 회사 채용예정인원, 지원가능인원, 전체지원인원 출력 테이블 시작 -->
		            <table class="companyApplyStatusTb">
		            	<caption><h3 style="margin-bottom:10px;">전체지원현황</h3></caption>
						<thead id="company_apply_status_tbh">
							<tr>
								<th class="casth1" scope="col">회사명</th>
								<th class="casth2" scope="col">그룹</th>
								<th class="casth3" scope="col">채용예정인원</th>
								<th class="casth4" scope="col">지원가능인원</th>
								<th class="casth5" scope="col">지원된인원</th>
							</tr>
						</thead>
						<tbody id="company_apply_status_tbd">
						</tbody>
					</table>
					<!-- 회사 채용예정인원, 지원가능인원, 전체지원인원 출력 테이블 종료 -->
					<!-- 단어 설명 문구 시작 -->
					<div class="textExplainDiv">
						<div>
							<p><small><font color="red">● 잔여 지원 가능 인원 = 지원 가능 인원 - 지원된인원</font></small></p>
							<p><small><font color="red">● 지원된인원은 이전 지원기간에 지원이 완료된 인원</font></small></p>
						</div>
					</div>
					<!-- 단어 설명 문구 종료 -->
					<!-- 현재기업 지망 현황 출력 테이블 시작 -->
					<div class="perRankStatusDiv" id="perRankStatusDiv">
					</div>
					<!-- 현재기업 지망 현황 출력 테이블 종료 -->
					<div class="ruleExplainDiv">
						<div>
							<p><small><font color="red">● 지원은 잔여 지원 가능 인원 수 만큼 지원가능 합니다.</font></small></p>
							<p><small><font color="red">● 잔여 지원 가능 인원 수를 초과할 경우에는 아래와 같은 룰을 따릅니다.</font></small></p>
						</div>
					</div>
					<!-- 나의 지망관련과 현재 지망가능한 지망 정보 출력 테이블 시작 -->
					<div class="myRankStatusDiv" id="myRankStatusDiv">
					</div>
					<!-- 나의 지망관련과 현재 지망가능한 지망 정보 출력 테이블 종료 -->
					<br>
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
	
	<%@include file="../common_footer_fap.jsp"%>	
</body>
</html>
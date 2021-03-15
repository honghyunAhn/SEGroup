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

	<script src="<c:url value="/resources/segroup/society/fap/js/popModal.js" />"></script>
	<script src="<c:url value="/resources/segroup/society/fap/js/popModal2.js" />"></script>
	
	
	<link rel="stylesheet" type="text/css" href="<c:url value="/resources/segroup/society/fap/css/userDefault.css" />" />
	<link rel="stylesheet" type="text/css" href="<c:url value="/resources/segroup/society/fap/css/popModal.css" />" />
	
	<script>
		var myApp = angular.module('myapp', []);
		
		myApp.controller('jobAdSearchController',['$scope','$compile', '$http', function($scope, $compile, $http) {
			
			// [start] 상세조건검색
	 		$scope.companySearchDetect = function() {
	 			if($('#searchCompanyButton').prop('disabled') == true){
					return false;
				}
				$('#searchCompanyButton').prop('disabled', true);
				$('#searchCompanyButton').html('검색중입니다.');
				
	 			var allSearchInfoInput = $('#sub1_group').find('input');
	 			var selectedGroupCodeList = new Array();
	 			var selectedWorkGbList = new Array();
	 			var selectedWorkplaceGbList = new Array();
	 			var selectedRecruitPcsGbList = new Array();
	 			var searchedCompanyName = '';
	 			
				for(var i=0; i<allSearchInfoInput.length; i++){
					if($(allSearchInfoInput[i]).is(':checked') == true || $(allSearchInfoInput[i]).attr('id') == 'fap_comp_ja_nm'){
						var beCheckedBoxName = $(allSearchInfoInput[i]).attr('name');
						var beCheckedBoxValue = $(allSearchInfoInput[i]).val();
						switch(beCheckedBoxName){
					    	case 'fap_job_ad_groupcode'   : selectedGroupCodeList.push(beCheckedBoxValue);		break;
					    	case 'fap_job_work_gb' 		  : selectedWorkGbList.push(beCheckedBoxValue);			break;
					    	case 'fap_job_workplace_gb'   : selectedWorkplaceGbList.push(beCheckedBoxValue);	break;
					    	case 'fap_job_recruit_pcs_gb' : selectedRecruitPcsGbList.push(beCheckedBoxValue);	break;
					    	default 					  : searchedCompanyName = beCheckedBoxValue; 			break;
						}
					}
				}		
				//컨트롤러로 가져가기 위한 map형태의 배열
	  			var selectedCompanyInfoMap = {};
	  			selectedCompanyInfoMap['selectedGroupCodeList'] = selectedGroupCodeList;
	  			selectedCompanyInfoMap['selectedWorkGbList'] = selectedWorkGbList;
	  			selectedCompanyInfoMap['selectedWorkplaceGbList'] = selectedWorkplaceGbList;
	  			selectedCompanyInfoMap['selectedRecruitPcsGbList'] = selectedRecruitPcsGbList;
	  			selectedCompanyInfoMap['searchedCompanyName'] = searchedCompanyName;
			
 	   			$http({
					url: 'search_job_advertisement_list',
					method: 'post',
					headers: {
						'Content-Type': 'application/json',
						"AJAX" : true
					},
					data: JSON.stringify(selectedCompanyInfoMap),
					XMLHttpRequestResponseType: 'json'
				}).then(function successCallback(response) {
					
					if(response == null || response == ''){
						location.href = "/fap/user/user_main";
					}
					
					var jobAdvertisementList = response.data;
					var context = '';
					context +='<ul class="tit1">';
					context +=	'<li class="wid1">No</li>';
					context +=	'<li class="wid2 tx_ct">채용공고</li>';
					context +=	'<li class="wid3">기업명</li>';
					context +=	'<li class="wid4">타입</li>';
					context +=	'<li class="wid3">잡페어 기간</li>';
					context +='</ul>';
					if(jobAdvertisementList.length < 1){
						context += '<h2 style="text-align:center;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;검색된 회사가 없습니다.</h2>';
					}else{
						$.each(jobAdvertisementList, function(index,jobAdvertisement){
							context +=	'<ul id="drawSeachedUl" class="tit2">';
							context +=		'<li class="wid1 lh65">' + (index+1) + '</li>';
							context +=		'<li class="wid2">';
							context +=			'<div class="jobname ellipsis">';
							context +=				'<a href="<c:url value="/fap/user/user_job_advertisement_read_form?fap_job_ad_seq=' + jobAdvertisement.fap_job_ad_seq + '" />" title="'+jobAdvertisement.fap_job_ad_title+'">' + jobAdvertisement.fap_job_ad_title + '</a>';
							context +=			'</div>';
							context +=			'<div class="jobgwork ellipsis">';
							context +=				'모집직종:';
							$.each(jobAdvertisement.categoryList, function(index, category){
								context += 			((index+1) % 2 == 0) ? '/&nbsp;' : '';
								context +=			'<code value="' + category.fap_job_category_gb + '"></code>';	
							});
							context +=			'</div>';
							context +=			'<div class="jobgpack ellipsis">';
							context +=				'근무지:';
							$.each(jobAdvertisement.workPlaceList, function(index, workPlace){
								context += 			((index+1) % 2 == 0) ? '/&nbsp;' : '';
								context +=			'<code value="' + workPlace.fap_job_workplace_gb + '"></code>';	
							});
							context +=			'</div>';
							/* context +=			'<div class="jobgroup">';
							context +=				'그룹:';
							if(jobAdvertisement.fap_job_ad_groupcode == 'D0500'){
								context +=			'<code value="' + jobAdvertisement.fap_job_ad_groupcode + '"></code>';
							}else{
								context +=			jobAdvertisement.fap_job_ad_groupcode;	
							}
							context +=			'</div>'; */
							context +=		'</li>';
							context +=		'<li class="wid3 ellipsis lh65" title="'+jobAdvertisement.fap_comp_ja_nm+'">';
							context +=			jobAdvertisement.fap_comp_ja_nm;
							context +=		'</li>';
							context +=		'<li class="wid4 lh65">';
							context +=			'<code value="'+jobAdvertisement.fap_job_ad_rule_type+'"></code>';
							context +=		'</li>';
							context +=		'<li class="wid3 lh65">';
							context +=			jobAdvertisement.fap_jobfair_divide_st;
							context +=		'	~ ';
							context +=			jobAdvertisement.fap_jobfair_divide_et;
							context +=		'</li>';
							context +=	'</ul>';
						});
					}
					context += '</ul>';
					$('#sub1_bbs').children().remove();
					$('#sub1_bbs').append($compile(context)($scope));
					$('#searchCompanyButton').prop('disabled', false);
					$('#searchCompanyButton').html('검색');
				}, function errorCallback(response) {
					console.log(response);
					if(response.status == 403){
						alert('<spring:message code="com.login.ajaxSesstion" javaScriptEscape="true" />');
						location.href = "/fap/user/user_login";
					}else{
						$('#searchCompanyButton').prop('disabled', false);
						$('#searchCompanyButton').html('검색');
					}
				});
			}
	 		// [end] 상세조건검색
		
	 		// [start] 검색한 채용공고 읽기
			$scope.connectJobAdvertisementAnchor = function(e) {
				var call_advertisement_read_form = $(e.currentTarget).attr('data-id');
				document.getElementById(call_advertisement_read_form).submit();
			}
			// [end] 검색한 채용공고 읽기
			
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
<body ng-app="myapp" ng-controller="jobAdSearchController">
	
	<%@include file="user_menu.jsp"%>
	
	<div id="subcontents">
		
		<div id="sub1Box">
			<br>
			<h1>채용상세검색</h1>
			<h6><span class="red">다양한 준비로 더 많은 취업성공을 이끕니다!</span></h6>
			
			<div id="sub1_tab"></div>
		
			<div id="sub1_group">
 				<%-- <ul class="group1">
		        	<li class="tit1">
		        		<a id="popModal_ex1">
		        			<img src="<c:url value="/resources/segroup/society/fap/images/quest.gif" />" />
		        		</a> 기업규모별 :
					</li>
					
					<div style="display:none;">
                        <div id="content" style=" width: 600px;">
                        	<c:forEach var="companyGroupCode" items="${companyGroupCodeList}" varStatus="status">
	                            - ${companyGroupCode.fap_comp_groupcode} : ${companyGroupCode.fap_comp_employee_num}명 이상, 자본금 ${companyGroupCode.fap_comp_3years_avg_sales}엔 이상, 매출액 ${companyGroupCode.fap_comp_stock}엔 이상<br />
	                            <c:if test="${status.count ne fn:length(companyGroupCodeList)}">
	                            	<br>
	                            </c:if>
                            </c:forEach> 
							<div class="popModal_footer">
                                <button type="button" class="btn2 btn-primary" data-popmodal-but="ok">ok</button>
                                <button type="button" class="btn2 btn-default" data-popmodal-but="cancel">cancel</button>
							</div>
						</div>
					</div>
					
					<li class="tit2">
						<c:forEach var="companyGroupCode" items="${companyGroupCodeList}" varStatus="status">
		            		<input type="checkbox" id="fap_job_ad_groupcode${status.count}" name="fap_job_ad_groupcode" value="${companyGroupCode.fap_comp_groupcode}" />
		            		<label for="fap_job_ad_groupcode${status.count}"><span></span>${companyGroupCode.fap_comp_groupcode}</label>
						</c:forEach>
	               </li>
				</ul> --%>
					
				<ul class="group1">
					<li class="tit1">주요업무별 : </li>
					<li class="tit2">
		            		<input type="checkbox" id="fap_job_work_gb1" name="fap_job_work_gb" value="C0300" />
		            		<label for="fap_job_work_gb1"><span></span>자사SI</label>&nbsp;&nbsp;
		            		
		            		<input type="checkbox" id="fap_job_work_gb2" name="fap_job_work_gb" value="C0301" />
		            		<label for="fap_job_work_gb2"><span></span>타사SI</label>&nbsp;&nbsp;
		            		
		            		<input type="checkbox" id="fap_job_work_gb3" name="fap_job_work_gb" value="C0302" />
		            		<label for="fap_job_work_gb3"><span></span>자사솔루션</label>&nbsp;&nbsp;
		            		
		            		<input type="checkbox" id="fap_job_work_gb4" name="fap_job_work_gb" value="C0303" />
		            		<label for="fap_job_work_gb4"><span></span>기타업무</label>&nbsp;&nbsp;
					</li>
				</ul>
				
				<ul class="group1">
					<li class="tit1" style="vertical-align: top;">근무지역별 : </li>
					<li class="tit2">
						<input type="checkbox" id="fap_job_workplace_gb1" name="fap_job_workplace_gb" value="C3900" />
	            		<label for="fap_job_workplace_gb1"><span></span>홋카이도,토호쿠</label>&nbsp;&nbsp;
	            		
	            		<input type="checkbox" id="fap_job_workplace_gb2" name="fap_job_workplace_gb" value="C3901" />
	            		<label for="fap_job_workplace_gb2"><span></span>간토</label>&nbsp;&nbsp;
	            		
	            		<input type="checkbox" id="fap_job_workplace_gb3" name="fap_job_workplace_gb" value="C3902" />
	            		<label for="fap_job_workplace_gb3"><span></span>호쿠리쿠,코우신에츠</label>&nbsp;&nbsp;
	            		
	            		<input type="checkbox" id="fap_job_workplace_gb4" name="fap_job_workplace_gb" value="C3903" />
	            		<label for="fap_job_workplace_gb4"><span></span>토카이</label>&nbsp;&nbsp;
	            		
	            		<input type="checkbox" id="fap_job_workplace_gb5" name="fap_job_workplace_gb" value="C3904" />
	            		<label for="fap_job_workplace_gb5"><span></span>킨키(칸사이)</label>&nbsp;&nbsp;
	            		
	            		<input type="checkbox" id="fap_job_workplace_gb6" name="fap_job_workplace_gb" value="C3905" />
	            		<label for="fap_job_workplace_gb6"><span></span>츄고쿠,시코쿠</label>&nbsp;&nbsp;<br><br>
	            		
	            		<input type="checkbox" id="fap_job_workplace_gb7" name="fap_job_workplace_gb" value="C3906" />
	            		<label for="fap_job_workplace_gb7"><span></span>큐슈,오키나와</label>&nbsp;&nbsp;
	            		
	            		<input type="checkbox" id="fap_job_workplace_gb8" name="fap_job_workplace_gb" value="C3907" />
	            		<label for="fap_job_workplace_gb8"><span></span>전지역</label>&nbsp;&nbsp;
	            		
	            		<input type="checkbox" id="fap_job_workplace_gb9" name="fap_job_workplace_gb" value="C3908" />
	            		<label for="fap_job_workplace_gb9"><span></span>기타(해외포함)</label>&nbsp;&nbsp;
					</li>
				</ul>
				
				<ul class="group1">
					<li class="tit1">전형형태별 : </li>
					<li class="tit2">
						<input type="checkbox" id="fap_job_recruit_pcs_gb1" name="fap_job_recruit_pcs_gb" value="C3301" />
	            		<label for="fap_job_recruit_pcs_gb1"><span></span>화상면접</label>&nbsp;&nbsp;
	            		
	            		<input type="checkbox" id="fap_job_recruit_pcs_gb2" name="fap_job_recruit_pcs_gb" value="C2600" />
	            		<label for="fap_job_recruit_pcs_gb2"><span></span>필기시험</label>&nbsp;&nbsp;
	            		
	            		<input type="checkbox" id="fap_job_recruit_pcs_gb3" name="fap_job_recruit_pcs_gb" value="C2601" />
	            		<label for="fap_job_recruit_pcs_gb3"><span></span>Web시험</label>&nbsp;&nbsp;
	            		
	            		<input type="checkbox" id="fap_job_recruit_pcs_gb4" name="fap_job_recruit_pcs_gb" value="C2503" />
	            		<label for="fap_job_recruit_pcs_gb4"><span></span>기타</label>&nbsp;&nbsp;
	            	</li>
				</ul>
				
				<ul class="group1">
					<li class="tit1">기업이름검색</li>
					<li class="tit2">
						<input type="text" id="fap_comp_ja_nm" name="fap_comp_ja_nm" placeholder="기업명을 입력해주세요."/>
						<button type="button" class="btn4 btn-primary" id="searchCompanyButton"
	            		 	ng-click="companySearchDetect()" style="height: 50px;">
	            			검색
	            		</button>
					</li>
				</ul>
				<!-- 검색된 회사 출력부분 여기서부터 -->
				<h2 style="width: 100%;">검색한 채용공고 목록</h2>
				<div id="sub1_bbs">
					<!-- 검색 목록 출력되는 부분 -->
				</div>
			</div>
		</div>
	</div>
	
	<%@include file="../common_footer_fap.jsp"%>	
</body>
</html>
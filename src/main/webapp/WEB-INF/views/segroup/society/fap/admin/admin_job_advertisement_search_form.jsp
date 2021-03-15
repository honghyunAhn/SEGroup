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
<script src="<c:url value="/resources/segroup/js/jquery-3.1.1.js" />"></script>
<script src="<c:url value="/resources/segroup/js/angular.min.js" />"></script>
<script src="<c:url value="/resources/segroup/society/fap/js/popModal.js" />"></script>
<script src="<c:url value="/resources/segroup/society/fap/js/popModal2.js" />"></script>
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/segroup/society/fap/css/userDefault.css" />" />
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/segroup/society/fap/css/popModal.css" />" />
<style type="text/css">
.group1{display:none;}
#searchAdList{display:none;}
</style>
<script>
var myApp = angular.module('myapp', []);

myApp.controller('jobAdAdminSearchController',['$scope','$compile', '$http', function($scope, $compile, $http) {
	
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
			
			/*셀렉트 박스 변경될 때 채용공고 처음 그려주는 곳(체크)*/
			
			//기업규모별 그룹코드 호출
			var fap_jobfair_seq = $('#select_jobfair option:selected').val();
 
			$http({
				method : 'POST',
				url : '/fap/admin/admin_select_company_group_code_list',
				responseType : 'json',
				params : {
					fap_jobfair_seq: fap_jobfair_seq 
				}
			}).then(function successCallback(response) {
				 $('.group1').show();
				 $('#searchAdList').show();
			 
				 $('#compGroupCode').children().remove();
				 $('#content').children().remove();
	
				 for(var i in response.data){  					
					var context='';
					context += '<input type="checkbox" id="fap_job_ad_groupcode'+i+'" name="fap_job_ad_groupcode" value='+response.data[i].fap_comp_groupcode+' />';
					context += '<label for="fap_job_ad_groupcode'+i+'"><span></span>'+response.data[i].fap_comp_groupcode+'&nbsp;&nbsp;</label>';
					context += '&nbsp;';
					$('#compGroupCode').append($compile(context)($scope));			
									 
					var context2 = '<div>';
					context2 += '- '+response.data[i].fap_comp_groupcode+' : '+response.data[i].fap_comp_employee_num+'명 이상, ';
					context2 +='자본금 '+response.data[i].fap_comp_3years_avg_sales+ '엔 이상, ';
					context2 +='매출액 '+response.data[i].fap_comp_stock + '엔 이상<br />';
					$('#content').append($compile(context2)($scope));			
				}				
			});
		}
	}	
	//[end] jobfair selectbox 그리기 종료
			
			// [start] 상세조건검색
	 		$scope.companySearchDetect = function(e) {
 			   var stateFlag = $(e.currentTarget).attr('stateFlag');
 		       console.log("stateFlag:"+stateFlag);	      
		
	 			if($('#searchCompanyButton').prop('disabled') == true){
					return false;
				}
				$('#searchCompanyButton').prop('disabled', true);
				$('#searchCompanyButton').html('검색중');
				
				var fap_jobfair_seq = $scope.fap_jobfair_seq;
				$scope.fap_jobfair_divide_seq = $('#select_jobfair_detail option:selected').attr('seq');
				var fap_jobfair_divide_seq = $scope.fap_jobfair_divide_seq;
	 			
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
	  			selectedCompanyInfoMap['fap_jobfair_seq'] = fap_jobfair_seq;
	  			selectedCompanyInfoMap['fap_jobfair_divide_seq'] = fap_jobfair_divide_seq;
	  			selectedCompanyInfoMap['stateFlag'] = stateFlag;
	  			selectedCompanyInfoMap['selectedGroupCodeList'] = selectedGroupCodeList;
	  			selectedCompanyInfoMap['selectedWorkGbList'] = selectedWorkGbList;
	  			selectedCompanyInfoMap['selectedWorkplaceGbList'] = selectedWorkplaceGbList;
	  			selectedCompanyInfoMap['selectedRecruitPcsGbList'] = selectedRecruitPcsGbList;
	  			selectedCompanyInfoMap['searchedCompanyName'] = searchedCompanyName;
			
 	   			$http({
					url: 'admin_search_job_advertisement_list',
					method: 'post',
					headers: {
						'Content-Type': 'application/json',
						"AJAX" : true
					},
					data: JSON.stringify(selectedCompanyInfoMap),
					XMLHttpRequestResponseType: 'json'
				}).then(function successCallback(response) {
					
					if(response == null || response == ''){
						location.href = "/fap/admin/admin_main";
					}
					
					var jobAdvertisementList = response.data;
					var context = '';
					context +='<ul class="tit1">';
					context +=	'<li class="wid1">No</li>';
					context +=	'<li class="wid2">제목</li>';
					context +=	'<li class="wid3">기업명</li>';
					context +=	'<li class="wid4">잡페어 기간</li>';
					context +=	'<li class="wid5">등록일</li>';
					context +='</ul>';
					if(jobAdvertisementList.length < 1){
						context += '<h2 style="text-align:center;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;검색된 회사가 없습니다.</h2>';
					}else{
						$.each(jobAdvertisementList, function(index,jobAdvertisement){
							context +=	'<ul id="drawSeachedUl" class="tit2">';
							context +=		'<li class="wid1">' + (index+1) + '</li>';
							context +=		'<li class="wid2">';
							context +=			'<div class="jobname">';
							context +=				'<a href="<c:url value="/fap/admin/job_ad_read_form?fap_job_ad_seq=' + jobAdvertisement.fap_job_ad_seq + '" />">' + jobAdvertisement.fap_job_ad_title + '</a>';
							context +=			'</div>';
							context +=			'<div class="jobgwork">';
							context +=				'모집직종:';
							$.each(jobAdvertisement.categoryList, function(index, category){
								context += 			((index+1) % 2 == 0) ? '/&nbsp;' : '';
								context +=			'<code value="' + category.fap_job_category_gb + '"></code>';	
							});
							context +=			'</div>';
							context +=			'<div class="jobgpack">';
							context +=				'근무지:';
							$.each(jobAdvertisement.workPlaceList, function(index, workPlace){
								context += 			((index+1) % 2 == 0) ? '/&nbsp;' : '';
								context +=			'<code value="' + workPlace.fap_job_workplace_gb + '"></code>';	
							});
							context +=			'</div>';
							context +=			'<div class="jobgroup">';
							context +=				'그룹:';
							if(jobAdvertisement.fap_job_ad_groupcode == 'D0500'){
								context +=			'<code value="' + jobAdvertisement.fap_job_ad_groupcode + '"></code>';
							}else{
								context +=			jobAdvertisement.fap_job_ad_groupcode;	
							}
							context +=			'</div>';
							context +=		'</li>';
							context +=		'<li class="wid3">';
							context +=			jobAdvertisement.fap_comp_ja_nm;
							context +=		'</li>';
							context +=		'<li class="wid4">';
							context +=			jobAdvertisement.fap_jobfair_divide_st;
							context +=		'	~ <br>';
							context +=			jobAdvertisement.fap_jobfair_divide_et;
							context +=		'</li>';
							context += 		'<li class="wid5">' + jobAdvertisement.fap_job_ad_udt_dt + '</li>';
							context +=	'</ul>';
						});
					}
					context += '</ul>';
					
					//버튼 색상변경 부분
				       if(stateFlag=='progressing'){
				         $('#progressingAdBtn').css('background', '#dadada');						
				         $('#completedAdBtn').css('background', '#fff');						
				       }else if(stateFlag=='completed'){
				         $('#progressingAdBtn').css('background', '#fff');						
				         $('#completedAdBtn').css('background', '#dadada');	
				       }else if(stateFlag=='' || stateFlag==null){
				         stateFlag='progressing';
				         $('#progressingAdBtn').css('background', '#dadada');						
				         $('#completedAdBtn').css('background', '#fff');		
				       }
					$('#sub1_bbs').children().remove();
					$('#sub1_bbs').append($compile(context)($scope));
					$('#searchCompanyButton').prop('disabled', false);
					$('#searchCompanyButton').html('검색');
				}, function errorCallback(response) {
					console.log(response);
					if(response.status == 403){
						alert('<spring:message code="com.login.ajaxSesstion" javaScriptEscape="true" />');
						location.href = "/fap/admin/admin_login";
					}else{
						$('#searchCompanyButton').prop('disabled', false);
						$('#searchCompanyButton').html('검색');
					}
				});
			}
	 		// [end] 상세조건검색
	
	  
	
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
<title>Bridge Job Fair</title>
</head>
<body ng-app="myapp" ng-controller="jobAdAdminSearchController">
<%@include file="admin_menu.jsp"%>
	<div class="join-wrap"> 
		 <div id="subcontents">		  
			   <h1>채용상세검색</h1>
		       <h6 style="color:red;"><span>※조건에 따른 채용공고를 검색해 보세요.</span></h6>
		       <div id="sub1Box">
		       <!-- 잡페어선택 -->
		      		   <div class="subFind" id="select-box-layout"><spring:message code="fap.jobad.search_per_jobfair" />&nbsp;</div> 								   
				<!-- 검색조건 -->
					   <div id="sub1_group">					    					
			 				<ul class="group1" >
			 					<li class="tit1">
					        		<a id="popModal_ex1">
					        			<img src="<c:url value="/resources/segroup/society/fap/images/quest.gif" />" />
					        		</a> 기업규모별 :
								</li>
								<div style="display:none;">
									<div id="content" style=" width: 600px;">
			                            <div class="popModal_footer">
			                                <button type="button" class="btn2 btn-primary" data-popmodal-but="ok">ok</button>
			                                <button type="button" class="btn2 btn-default" data-popmodal-but="cancel">cancel</button>
									    </div>
									</div>
								</div>
								<li class="tit2" id="compGroupCode">					 
			              		</li>
			 				</ul>
			 				
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
									<button type="button" class="btn3 btn-primary" id="searchCompanyButton"
				            		 	ng-click="companySearchDetect($event)" style="height: 33px; width: 80px;"  >
				            			검색
				            		</button>
								</li>								
							</ul>
							<ul class="group1">
								<li>
								<div id="rewrite_tab" >
									<button id="progressingAdBtn" class="btn btn-primary2" stateFlag="progressing" ng-click="companySearchDetect($event)">진행중인 채용공고</button>
									<button id="completedAdBtn" class="btn btn-primary2" stateFlag="completed" ng-click="companySearchDetect($event)">마감된 채용공고</button>
								</div>
								</li>
							</ul>
							
			 				<h2 id="searchAdList" style="width: 100%;">검색한 채용공고 목록</h2>
							<div id="sub1_bbs">
								<!-- 검색 목록 출력되는 부분 -->
						</div>			 				
	 				</div>					
			   </div><!--sub1Box  -->		 
		 </div>
	 </div>
</body>

</html>
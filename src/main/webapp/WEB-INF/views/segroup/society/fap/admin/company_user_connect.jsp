<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Bridge Job Fair</title>
</head>
<script src="<c:url value="/resources/segroup/js/jquery-3.1.1.js" />"></script>
<script src="<c:url value="/resources/segroup/js/angular.min.js" />"></script>

<script type="text/javascript">
	
	var myApp = angular.module('myapp', []);

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
	
	myApp.controller('ConnectManagementController',['$scope','$compile', '$http', function($scope, $compile, $http) {
		
		$scope.delete_request = function (fap_comp_user_request_seq) {
			
			$http({
				url : '/fap/admin/connect_request_delete'
				, method : 'post'
				, params : {
					fap_comp_user_request_seq : fap_comp_user_request_seq
				}
			}).then(function successCallback(response) {
					if(response.data == 0){
						alert('<spring:message code="fap.comp.error_occurrence" />');
					} else if(response.data == 1){
						alert('<spring:message code="fap.comp.agency_connect_delete_alert" />');
						location.reload();
					}
			   }, function errorCallback(response) {
					
			});
			
		}
		
		$scope.changePageLoadListThree = function(clickedPage) {
			
			$http({
				url : 'unconnect_company_paging'
				, method : 'post'
				, params : {
					clickedPage : clickedPage
				}
			}).then(function successCallback(response) {
				
				var totalCount = response.data.companyUserTotalCount;
				var currentPage = response.data.repNaviThree.currentPage;
				var pagePerGroup = response.data.repNaviThree.pagePerGroup;
				var num = totalCount - ((pagePerGroup) * (currentPage - 1));
				
				$('.before-unconnect-table-tbd').children().remove();
				var InfoContext = '';
				$('.before-pagethree').children().remove();
				var pageContext = '';
				
				//[start] 리스트 정보 innerHtml로 그려주기 시작
				$.each(response.data.company_user, function(index, companyUserLoadList){
					
					InfoContext += '<tr>';
					InfoContext += '<td><input type="checkbox" name="comp_user_id_list" value="' + companyUserLoadList.user_id + '"></td>';
					InfoContext += '<td>' + (num - index) + '</td>';
					InfoContext += '<td>' + companyUserLoadList.user_id + '</td>';
					InfoContext += '<td>' + companyUserLoadList.user_nm + '</td>';
					InfoContext += '<td>' + companyUserLoadList.user_email + '</td>';
					InfoContext += '<td><code value="' + companyUserLoadList.user_flag + '"></code></td>';
					InfoContext += '</tr>';					
				});
				//[end] 리스트 정보 inner로 그려주기 종료
			
				//[start] 페이지정보 innerHtml로 그려주기 시작
				
				pageContext += '<button ng-click="changePageLoadListThree(' + (response.data.repNaviThree.currentPage - response.data.repNaviThree.pagePerGroup) + ')">◁◁</button>';
				pageContext += '<button ng-click="changePageLoadListThree(' + (response.data.repNaviThree.currentPage - 1) + ')">◀</button>';
				
				for(var i=response.data.repNaviThree.startPageGroup; i<=response.data.repNaviThree.endPageGroup; i++){
					
					if(i == response.data.repNaviThree.currentPage){
						pageContext += '<span class="now">' + i + '</span>';
					}else{
						pageContext += '<button ng-click="changePageLoadListThree(' + i + ')">' + i + '</button>';
					}
					
				}
				
				pageContext += '<button ng-click="changePageLoadListThree(' + (response.data.repNaviThree.currentPage + 1) + ')">▶</button>';
				pageContext += '<button ng-click="changePageLoadListThree(' + (response.data.repNaviThree.currentPage + response.data.repNaviThree.pagePerGroup) + ')">▷▷</button>';
				
				//[end] 페이지정보 inner로 그려주기 종료
				
				$('.before-unconnect-table-tbd').append($compile(InfoContext)($scope));
				$('.before-pagethree').append($compile(pageContext)($scope));
				
			   }, function errorCallback(response) {
					
			});
			
		}
		
		$scope.changePageLoadList = function(clickedPage) {
			
			$http({
				url : 'connect_request_paging'
				, method : 'post'
				, params : {
					clickedPage : clickedPage
				}
			}).then(function successCallback(response) {
				
				var totalCount = response.data.requestTotalCount;
				var currentPage = response.data.repNavi.currentPage;
				var pagePerGroup = response.data.repNavi.pagePerGroup;
				var num = totalCount - ((pagePerGroup) * (currentPage - 1));
				
				$('.before-request-table-tbd').children().remove();
				var InfoContext = '';
				$('.before-page').children().remove();
				var pageContext = '';
				
				//[start] 리스트 정보 innerHtml로 그려주기 시작
				$.each(response.data.request_list, function(index, requestLoadList){
					
					InfoContext += '<tr>';
					InfoContext += '<td>' + (num - index) + '</td>';
					InfoContext += '<td><code value="' + requestLoadList.user_flag + '"></code></td>';
					InfoContext += '<td>' + requestLoadList.user_id + '</td>';
					InfoContext += '<td>' + requestLoadList.fap_comp_ja_nm + '</td>';
					InfoContext += '<td>' + requestLoadList.fap_comp_en_nm + '</td>';
					InfoContext += '<td><button ng-click="delete_request(' + requestLoadList.fap_comp_user_request_seq + ')">요청삭제</button>';
					InfoContext += '</tr>';		
								
				});
				//[end] 리스트 정보 inner로 그려주기 종료
			
				//[start] 페이지정보 innerHtml로 그려주기 시작
				
				pageContext += '<button ng-click="changePageLoadList(' + (response.data.repNavi.currentPage - response.data.repNavi.pagePerGroup) + ')">◁◁</button>';
				pageContext += '<button ng-click="changePageLoadList(' + (response.data.repNavi.currentPage - 1) + ')">◀</button>';
				
				for(var i=response.data.repNavi.startPageGroup; i<=response.data.repNavi.endPageGroup; i++){
					
					if(i == response.data.repNavi.currentPage){
						pageContext += '<span class="now">' + i + '</span>';
					}else{
						pageContext += '<button ng-click="changePageLoadList(' + i + ')">' + i + '</button>';
					}
					
				}
				
				pageContext += '<button ng-click="changePageLoadList(' + (response.data.repNavi.currentPage + 1) + ')">▶</button>';
				pageContext += '<button ng-click="changePageLoadList(' + (response.data.repNavi.currentPage + response.data.repNavi.pagePerGroup) + ')">▷▷</button>';
				
				//[end] 페이지정보 inner로 그려주기 종료
				
				$('.before-request-table-tbd').append($compile(InfoContext)($scope));
				$('.before-page').append($compile(pageContext)($scope));
				
			   }, function errorCallback(response) {
					
			});
			
		}
		
	$scope.changePageLoadListFour = function(clickedPage) {
			
			$http({
				url : 'unconnect_agency_paging'
				, method : 'post'
				, params : {
					clickedPage : clickedPage
				}
			}).then(function successCallback(response) {
				
				var totalCount = response.data.agencyUserTotalCount;
				var currentPage = response.data.repNaviFour.currentPage;
				var pagePerGroup = response.data.repNaviFour.pagePerGroup;
				var num = totalCount - ((pagePerGroup) * (currentPage - 1));
				
				$('.before-unconnect-agency-table-tbd').children().remove();
				var InfoContext = '';
				$('.before-pagefour').children().remove();
				var pageContext = '';
				
				//[start] 리스트 정보 innerHtml로 그려주기 시작
				$.each(response.data.agency_user, function(index, agnecyUserLoadList){
					
					InfoContext += '<tr>';
					InfoContext += '<td><input type="checkbox" name="ag_user_id_list" value="' + agnecyUserLoadList.user_id + '"></td>';
					InfoContext += '<td>' + (num - index) + '</td>';
					InfoContext += '<td>' + agnecyUserLoadList.user_id + '</td>';
					InfoContext += '<td>' + agnecyUserLoadList.user_nm + '</td>';
					InfoContext += '<td>' + agnecyUserLoadList.user_email + '</td>';
					InfoContext += '<td><code value="' + agnecyUserLoadList.user_flag + '"></code></td>';
					InfoContext += '</tr>';					
				});
				//[end] 리스트 정보 inner로 그려주기 종료
			
				//[start] 페이지정보 innerHtml로 그려주기 시작
				
				pageContext += '<button ng-click="changePageLoadListFour(' + (response.data.repNaviFour.currentPage - response.data.repNaviFour.pagePerGroup) + ')">◁◁</button>';
				pageContext += '<button ng-click="changePageLoadListFour(' + (response.data.repNaviFour.currentPage - 1) + ')">◀</button>';
				
				for(var i=response.data.repNaviFour.startPageGroup; i<=response.data.repNaviFour.endPageGroup; i++){
					
					if(i == response.data.repNaviFour.currentPage){
						pageContext += '<span class="now">' + i + '</span>';
					}else{
						pageContext += '<button ng-click="changePageLoadListFour(' + i + ')">' + i + '</button>';
					}
					
				}
				
				pageContext += '<button ng-click="changePageLoadListFour(' + (response.data.repNaviFour.currentPage + 1) + ')">▶</button>';
				pageContext += '<button ng-click="changePageLoadListFour(' + (response.data.repNaviFour.currentPage + response.data.repNaviFour.pagePerGroup) + ')">▷▷</button>';
				
				//[end] 페이지정보 inner로 그려주기 종료
				
				$('.before-unconnect-agency-table-tbd').append($compile(InfoContext)($scope));
				$('.before-pagefour').append($compile(pageContext)($scope));
				
			   }, function errorCallback(response) {
					
			});
			
		}
		
	$scope.changePageLoadListFive = function(clickedPage) {
		
		$http({
			url : 'connect_company_paging'
			, method : 'post'
			, params : {
				clickedPage : clickedPage
			}
		}).then(function successCallback(response) {
			
			var totalCount = response.data.connectCompanyTotalCount;
			var currentPage = response.data.repNaviFive.currentPage;
			var pagePerGroup = response.data.repNaviFive.pagePerGroup;
			var num = totalCount - ((pagePerGroup) * (currentPage - 1));
			
			$('.before-connect-company-table-tbd').children().remove();
			var InfoContext = '';
			$('.before-pagefive').children().remove();
			var pageContext = '';
			
			//[start] 리스트 정보 innerHtml로 그려주기 시작
			$.each(response.data.company_list, function(index, connectCompanyLoadList){
				
				InfoContext += '<tr>';
				InfoContext += '<td><input type="radio" name="comp_id_list" value="' + connectCompanyLoadList.fap_comp_id + '"></td>';
				InfoContext += '<td>' + (num - index) + '</td>';
				InfoContext += '<td><code value="' + connectCompanyLoadList.user_flag + '"></code></td>';
				InfoContext += '<td>' + connectCompanyLoadList.fap_comp_id + '</td>';
				InfoContext += '<td>' + connectCompanyLoadList.fap_comp_ja_nm + '</td>';
				InfoContext += '<td>' + connectCompanyLoadList.fap_comp_en_nm + '</td>';
				InfoContext += '</tr>';					
			});
			//[end] 리스트 정보 inner로 그려주기 종료
		
			//[start] 페이지정보 innerHtml로 그려주기 시작
			
			pageContext += '<button ng-click="changePageLoadListFive(' + (response.data.repNaviFive.currentPage - response.data.repNaviFive.pagePerGroup) + ')">◁◁</button>';
			pageContext += '<button ng-click="changePageLoadListFive(' + (response.data.repNaviFive.currentPage - 1) + ')">◀</button>';
			
			for(var i=response.data.repNaviFive.startPageGroup; i<=response.data.repNaviFive.endPageGroup; i++){
				
				if(i == response.data.repNaviFive.currentPage){
					pageContext += '<span class="now">' + i + '</span>';
				}else{
					pageContext += '<button ng-click="changePageLoadListFive(' + i + ')">' + i + '</button>';
				}
				
			}
			
			pageContext += '<button ng-click="changePageLoadListFive(' + (response.data.repNaviFive.currentPage + 1) + ')">▶</button>';
			pageContext += '<button ng-click="changePageLoadListFive(' + (response.data.repNaviFive.currentPage + response.data.repNaviFive.pagePerGroup) + ')">▷▷</button>';
			
			//[end] 페이지정보 inner로 그려주기 종료
			
			$('.before-connect-company-table-tbd').append($compile(InfoContext)($scope));
			$('.before-pagefive').append($compile(pageContext)($scope));
			
		   }, function errorCallback(response) {
				
		});
		
	}
	
	$scope.changePageLoadListSix = function(clickedPage) {
		
		$http({
			url : 'connect_agency_paging'
			, method : 'post'
			, params : {
				clickedPage : clickedPage
			}
		}).then(function successCallback(response) {
			
			var totalCount = response.data.connectAgencyTotalCount;
			var currentPage = response.data.repNaviSix.currentPage;
			var pagePerGroup = response.data.repNaviSix.pagePerGroup;
			var num = totalCount - ((pagePerGroup) * (currentPage - 1));
			
			$('.before-connect-agency-table-tbd').children().remove();
			var InfoContext = '';
			$('.before-pagesix').children().remove();
			var pageContext = '';
			
			//[start] 리스트 정보 innerHtml로 그려주기 시작
			$.each(response.data.agency_list, function(index, connectAgencyLoadList){
				
				InfoContext += '<tr>';
				InfoContext += '<td><input type="radio" name="ag_id_list" value="' + connectAgencyLoadList.fap_comp_id + '"></td>';
				InfoContext += '<td>' + (num - index) + '</td>';
				InfoContext += '<td><code value="' + connectAgencyLoadList.user_flag + '"></code></td>';
				InfoContext += '<td>' + connectAgencyLoadList.fap_comp_id + '</td>';
				InfoContext += '<td>' + connectAgencyLoadList.fap_comp_ja_nm + '</td>';
				InfoContext += '<td>' + connectAgencyLoadList.fap_comp_en_nm + '</td>';
				InfoContext += '</tr>';					
			});
			//[end] 리스트 정보 inner로 그려주기 종료
		
			//[start] 페이지정보 innerHtml로 그려주기 시작
			
			pageContext += '<button ng-click="changePageLoadListSix(' + (response.data.repNaviSix.currentPage - response.data.repNaviSix.pagePerGroup) + ')">◁◁</button>';
			pageContext += '<button ng-click="changePageLoadListSix(' + (response.data.repNaviSix.currentPage - 1) + ')">◀</button>';
			
			for(var i=response.data.repNaviSix.startPageGroup; i<=response.data.repNaviSix.endPageGroup; i++){
				
				if(i == response.data.repNaviSix.currentPage){
					pageContext += '<span class="now">' + i + '</span>';
				}else{
					pageContext += '<button ng-click="changePageLoadListSix(' + i + ')">' + i + '</button>';
				}
				
			}
			
			pageContext += '<button ng-click="changePageLoadListSix(' + (response.data.repNaviSix.currentPage + 1) + ')">▶</button>';
			pageContext += '<button ng-click="changePageLoadListSix(' + (response.data.repNaviSix.currentPage + response.data.repNaviSix.pagePerGroup) + ')">▷▷</button>';
			
			//[end] 페이지정보 inner로 그려주기 종료
			
			$('.before-connect-agency-table-tbd').append($compile(InfoContext)($scope));
			$('.before-pagesix').append($compile(pageContext)($scope));
			
		   }, function errorCallback(response) {
				
		});
		
	}
	
	$scope.changePageLoadListSeven = function(clickedPage) {
		
		$http({
			url : 'unconnect_company_paging_sub'
			, method : 'post'
			, params : {
				clickedPage : clickedPage
			}
		}).then(function successCallback(response) {
			
			var totalCount = response.data.companyUserTotalCount;
			var currentPage = response.data.repNaviSeven.currentPage;
			var pagePerGroup = response.data.repNaviSeven.pagePerGroup;
			var num = totalCount - ((pagePerGroup) * (currentPage - 1));
			
			$('.company-sub-table-tbd').children().remove();
			var InfoContext = '';
			$('.before-pageseven').children().remove();
			var pageContext = '';
			
			//[start] 리스트 정보 innerHtml로 그려주기 시작
			$.each(response.data.company_user, function(index, companySubList){
				
				InfoContext += '<tr>';
				InfoContext += '<td><input type="checkbox" name="comp_user_id_list" value="' + companySubList.user_id + '"></td>';
				InfoContext += '<td>' + (num - index) + '</td>';
				InfoContext += '<td>' + companySubList.user_id + '</td>';
				InfoContext += '<td>' + companySubList.user_nm + '</td>';
				InfoContext += '<td>' + companySubList.user_email + '</td>';
				InfoContext += '<td><code value="' + companySubList.user_flag + '"></code></td>';
				InfoContext += '</tr>';					
				
			});
			//[end] 리스트 정보 inner로 그려주기 종료
		
			//[start] 페이지정보 innerHtml로 그려주기 시작
			
			pageContext += '<button ng-click="changePageLoadListSeven(' + (response.data.repNaviSeven.currentPage - response.data.repNaviSeven.pagePerGroup) + ')">◁◁</button>';
			pageContext += '<button ng-click="changePageLoadListSeven(' + (response.data.repNaviSeven.currentPage - 1) + ')">◀</button>';
			
			for(var i=response.data.repNaviSeven.startPageGroup; i<=response.data.repNaviSeven.endPageGroup; i++){
				
				if(i == response.data.repNaviSeven.currentPage){
					pageContext += '<span class="now">' + i + '</span>';
				}else{
					pageContext += '<button ng-click="changePageLoadListSeven(' + i + ')">' + i + '</button>';
				}
				
			}
			
			pageContext += '<button ng-click="changePageLoadListSeven(' + (response.data.repNaviSeven.currentPage + 1) + ')">▶</button>';
			pageContext += '<button ng-click="changePageLoadListSeven(' + (response.data.repNaviSeven.currentPage + response.data.repNaviSeven.pagePerGroup) + ')">▷▷</button>';
			
			//[end] 페이지정보 inner로 그려주기 종료
			
			$('.company-sub-table-tbd').append($compile(InfoContext)($scope));
			$('.before-pageseven').append($compile(pageContext)($scope));
			
		   }, function errorCallback(response) {
				
		});
		
	}
	
	$scope.changePageLoadListEight = function(clickedPage) {
	
	$http({
		url : 'unconnect_agency_paging_sub'
		, method : 'post'
		, params : {
			clickedPage : clickedPage
		}
	}).then(function successCallback(response) {
		
		var totalCount = response.data.agencyUserTotalCount;
		var currentPage = response.data.repNaviEight.currentPage;
		var pagePerGroup = response.data.repNaviEight.pagePerGroup;
		var num = totalCount - ((pagePerGroup) * (currentPage - 1));
		
		$('.agency-sub-table-tbd').children().remove();
		var InfoContext = '';
		$('.before-pageeight').children().remove();
		var pageContext = '';
		
		//[start] 리스트 정보 innerHtml로 그려주기 시작
		$.each(response.data.agency_user, function(index, agencySubList){
			
			InfoContext += '<tr>';
			InfoContext += '<td><input type="checkbox" name="ag_user_id_list" value="' + agencySubList.user_id + '"></td>';
			InfoContext += '<td>' + (num - index) + '</td>';
			InfoContext += '<td>' + agencySubList.user_id + '</td>';
			InfoContext += '<td>' + agencySubList.user_nm + '</td>';
			InfoContext += '<td>' + agencySubList.user_email + '</td>';
			InfoContext += '<td><code value="' + agencySubList.user_flag + '"></code></td>';
			InfoContext += '</tr>';		
			
		});
		//[end] 리스트 정보 inner로 그려주기 종료
	
		//[start] 페이지정보 innerHtml로 그려주기 시작
		
		pageContext += '<button ng-click="changePageLoadListEight(' + (response.data.repNaviEight.currentPage - response.data.repNaviEight.pagePerGroup) + ')">◁◁</button>';
		pageContext += '<button ng-click="changePageLoadListEight(' + (response.data.repNaviEight.currentPage - 1) + ')">◀</button>';
		
		for(var i=response.data.repNaviEight.startPageGroup; i<=response.data.repNaviEight.endPageGroup; i++){
			
			if(i == response.data.repNaviEight.currentPage){
				pageContext += '<span class="now">' + i + '</span>';
			}else{
				pageContext += '<button ng-click="changePageLoadListEight(' + i + ')">' + i + '</button>';
			}
			
		}
		
		pageContext += '<button ng-click="changePageLoadListEight(' + (response.data.repNaviEight.currentPage + 1) + ')">▶</button>';
		pageContext += '<button ng-click="changePageLoadListEight(' + (response.data.repNaviEight.currentPage + response.data.repNaviEight.pagePerGroup) + ')">▷▷</button>';
		
		//[end] 페이지정보 inner로 그려주기 종료
		
		$('.agency-sub-table-tbd').append($compile(InfoContext)($scope));
		$('.before-pageeight').append($compile(pageContext)($scope));
		
	   }, function errorCallback(response) {
			
	});
	
	}
	
	}]);
	
	function list_change(list_ck) {
		
		if(list_ck == 'company'){
			$('#company').show();
			$('#agency').hide();
			$('#uncertain_company').hide();
		} else if(list_ck == 'agency'){
			$('#agency').show();
			$('#company').hide();
			$('#uncertain_company').hide();
		} else if(list_ck == 'uncertain_company'){
			$('#uncertain_company').show();
			$('#company').hide();
			$('#agency').hide();
		}
		
	} // function end
	
	function company_user_connect(ck) {
		var user_id_list = [];
		
		if(ck == 'company'){
			// 채용 기업 유저 아이디
			$("input[name='comp_user_id_list']:checked").each(function () {
				var id = $(this).val();
				user_id_list.push(id);
			});
			
			// 채용 기업 아이디
			var comp_id = $("input:radio[name='comp_id_list']:checked").val();
		} else if(ck == 'agency'){
			// 에이전시 유저 아이디
			$("input[name='ag_user_id_list']:checked").each(function () {
				var id = $(this).val();
				user_id_list.push(id);
			});

			// 에이전시 아이디
			var comp_id = $("input:radio[name='ag_id_list']:checked").val();
		} else if(ck == 'uncertain_company'){
			// 기업 유저, 에이전시 유저 아이디
			$("input[name='unconnect_user_list']:checked").each(function () {
				var id = $(this).val();
				user_id_list.push(id);
			});
			
			// 불명확한 기업 아이디
			var comp_id = $("input:radio[name='uncertain_company_id']:checked").val();
		}
		
		jQuery.ajaxSettings.traditional = true;
		
		$.ajax({
			beforeSend: function(xhr) {
			     xhr.setRequestHeader("AJAX", true);
			}
			, url : '/fap/admin/company_user_connect'
			, type : 'post'
			, data : {
				user_id_list : user_id_list
				, fap_comp_id : comp_id
			}
			, success : function() {
				
				location.reload();
			}
			, error : function(e) {
				if(e.status == 403){
					alert('<spring:message code="com.login.ajaxSesstion" javaScriptEscape="true" />');
					location.href = "/fap/admin/admin_login";
				}
			}
		});
		
	} // function end
	
</script>

<script type="text/javascript">

//페이징관련 함수
function changePageLoadListTwo(clickedPage) {
	
	$.ajax({
		beforeSend: function(xhr) {
		     xhr.setRequestHeader("AJAX", true);
		},
		url : 'uncertain_company_paging',
		type : 'post',
		data : {'clickedPage' : clickedPage},
        dataType : 'json', 
		success : function(map) {
			var totalCount = map.uncertainTotalCount;
			var currentPage = map.repNaviTwo.currentPage;
			var pagePerGroup = map.repNaviTwo.pagePerGroup;
			var num = totalCount - ((pagePerGroup) * (currentPage - 1))
			
			$('.before-uncertain-table-tbd').children().remove();
			var InfoContext = '';
			$('.before-pagetwo').children().remove();
			var pageContext = '';
			
			//[start] 리스트 정보 innerHtml로 그려주기 시작
			$.each(map.select_uncertain_company, function(index, uncertainLoadList){
				InfoContext += '<tr>';
				InfoContext += '<td><input type="radio" name="uncertain_company_id" value="' + uncertainLoadList.fap_comp_id + '"></td>';
				InfoContext += '<td>' + (num - index) + '</td>';
				InfoContext += '<td>' + uncertainLoadList.fap_comp_id + '</td>';
				InfoContext += '<td>' + uncertainLoadList.fap_comp_ja_nm + '</td>';
				InfoContext += '<td>' + uncertainLoadList.fap_comp_en_nm + '</td>';
				InfoContext += '</tr>';					
			});
			//[end] 리스트 정보 inner로 그려주기 종료
			
			//[start] 페이지정보 innerHtml로 그려주기 시작
			
			pageContext += '<a href="javascript:changePageLoadListTwo(' + (map.repNaviTwo.currentPage - map.repNaviTwo.pagePerGroup) + ')">◁◁</a>';
			pageContext += '<a href="javascript:changePageLoadListTwo(' + (map.repNaviTwo.currentPage - 1) + ')">◀</a>';
			
			for(var i=map.repNaviTwo.startPageGroup; i<=map.repNaviTwo.endPageGroup; i++){
				
				if(i == map.repNaviTwo.currentPage){
					pageContext += '<span class="now">' + i + '</span>';
				}else{
					pageContext += '<a href="javascript:changePageLoadListTwo(' + i + ')">' + i + '</a>';
				}
				
			}
			
			pageContext += '<a href="javascript:changePageLoadListTwo(' + (map.repNaviTwo.currentPage + 1) + ')">▶</a>';
			pageContext += '<a href="javascript:changePageLoadListTwo(' + (map.repNaviTwo.currentPage + map.repNaviTwo.pagePerGroup) + ')">▷▷</a>';
			
			//[end] 페이지정보 inner로 그려주기 종료
			
			$('.before-uncertain-table-tbd').append(InfoContext);
			$('.before-pagetwo').append(pageContext);
		},
		error : function(response) {
			console.log(response);
			if(response.status == 403){
				alert('<spring:message code="com.login.ajaxSesstion" javaScriptEscape="true" />');
				location.href = "/fap/admin/admin_login";
			}
		}
	});	
} 
</script>



<body ng-app="myapp" ng-controller="ConnectManagementController">
<%@include file="admin_menu.jsp"%>
	<br>
	<div class="page_title">
		<h2>기업-담당자 연결</h2>
	</div>
	<br>
	<label><input type="radio" name="list_ck" onclick="list_change('company')" checked="checked">채용 기업</label>
	<label><input type="radio" name="list_ck" onclick="list_change('agency')" >에이전시</label>
	<label><input type="radio" name="list_ck" onclick="list_change('uncertain_company')">불명확한 기업</label>

	<div id="request_list">
		<h3>요청 현황</h3>
		<table>
			<tr>
				<td>No.</td>
				<td>회원 아이디</td>
				<td>기업 일본명</td>
				<td>기업 영문명</td>
			</tr>
			<tbody class="before-request-table-tbd">
			<c:forEach var="data" items="${request_list}" varStatus="status">
				<tr>
					<td>${status.count}</td>
					<td><code value="${data.user_flag}"></code></td>
					<td>${data.user_id}</td>
					<td>${data.fap_comp_ja_nm}</td>
					<td>${data.fap_comp_en_nm}</td>
					<td>
						<button ng-click="delete_request(${data.fap_comp_user_request_seq})">요청삭제</button>
					</td>
				</tr>
			</c:forEach>
			</tbody>
		</table>
		
		<div class="before-page">
		<button ng-click="changePageLoadList(${repNavi.currentPage - repNavi.pagePerGroup})">◁◁</button>
		<button ng-click="changePageLoadList(${repNavi.currentPage - 1})">◀</button>
			<c:forEach var="i" begin="${repNavi.startPageGroup}" end="${repNavi.endPageGroup}" step="1">
						
						<c:choose>					
							<c:when test="${i eq repNavi.currentPage}">
								<span class="now">${i}</span>
							</c:when>
							<c:otherwise>
								<button ng-click="changePageLoadList(${i})">${i}</button>
							</c:otherwise>
						</c:choose>							
			</c:forEach>
		
		<button ng-click="changePageLoadList(${repNavi.currentPage + 1})">▶</button>
		<button ng-click="changePageLoadList(${repNavi.currentPage + repNavi.pagePerGroup})">▷▷</button>
		
		</div>
		
	</div>

<!-- -------------------------------------------------------------------------------------------------------------- -->

	<div id="company">
		<h3>회원</h3>
		<table>
			<tr>
				<td></td>
				<td>No.</td>
				<td>회원 아이디</td>
				<td>회원 이름</td>
				<td>회원 이메일</td>
				<td>회원 구분</td>
			</tr>
			<tbody class="before-unconnect-table-tbd">
			<c:forEach var="data" items="${company_user}" varStatus="status">
				<tr>
					<td><input type="checkbox" name="comp_user_id_list" value="${data.user_id}"></td>
					<td>${companyUserLoadNum - (status.count-1)}</td>
					<td>${data.user_id}</td>
					<td>${data.user_nm}</td>
					<td>${data.user_email}</td>
					<td><code value="${data.user_flag}"></code></td>
				</tr>
			</c:forEach>
			</tbody>
		</table>
	
		<div class="before-pagethree">
					
		<button ng-click="changePageLoadListThree(${repNaviThree.currentPage - repNaviThree.pagePerGroup})">◁◁</button>
		<button ng-click="changePageLoadListThree(${repNaviThree.currentPage - 1})">◀</button>
			<c:forEach var="i" begin="${repNaviThree.startPageGroup}" end="${repNaviThree.endPageGroup}" step="1">
						
						<c:choose>					
							<c:when test="${i eq repNaviThree.currentPage}">
								<span class="now">${i}</span>
							</c:when>
							<c:otherwise>
								<button ng-click="changePageLoadListThree(${i})">${i}</button>
							</c:otherwise>
						</c:choose>							
			</c:forEach>
		<button ng-click="changePageLoadListThree(${repNaviThree.currentPage + 1})">▶</button>
		<button ng-click="changePageLoadListThree(${repNaviThree.currentPage + repNaviThree.pagePerGroup})">▷▷</button>
		</div>
-------------------------------------------------------------------------------------------------------
	
		<h3>회사</h3>
		<table>
			<tr>
				<td></td>
				<td>No.</td>
				<td>회사 구분</td>
				<td>회사 아이디</td>
				<td>회사 일어명</td>
				<td>회사 영문명</td>
			</tr>
			<tbody class="before-connect-company-table-tbd">
			<c:forEach var="data" items="${company_list}" varStatus="status">
				<tr>
					<td><input type="radio" name="comp_id_list" value="${data.fap_comp_id}"></td>
					<td>${connectCompanyLoadNum - (status.count-1)}</td>
					<td><code value="${data.user_flag}"></code></td>
					<td>${data.fap_comp_id}</td>
					<td>${data.fap_comp_ja_nm}</td>
					<td>${data.fap_comp_en_nm}</td>
				</tr>
			</c:forEach>
			</tbody>
		</table>

		<div class="before-pagefive">
					
		<button ng-click="changePageLoadListFive(${repNaviFive.currentPage - repNaviFive.pagePerGroup})">◁◁</button>
		<button ng-click="changePageLoadListFive(${repNaviFive.currentPage - 1})">◀</button>
			<c:forEach var="i" begin="${repNaviFive.startPageGroup}" end="${repNaviFive.endPageGroup}" step="1">
						
						<c:choose>					
							<c:when test="${i eq repNaviFive.currentPage}">
								<span class="now">${i}</span>
							</c:when>
							<c:otherwise>
								<button ng-click="changePageLoadListFive(${i})">${i}</button>
							</c:otherwise>
						</c:choose>							
			</c:forEach>
		<button ng-click="changePageLoadListFive(${repNaviFive.currentPage + 1})">▶</button>
		<button ng-click="changePageLoadListFive(${repNaviFive.currentPage + repNaviFive.pagePerGroup})">▷▷</button>
		</div>

	<button onclick="company_user_connect('company')">연결</button>
	</div>

<!-- ----------------------------------------분기--------------------------------------------- -->

	<div id="agency" style="display: none;">
		<h3>회원</h3>
		<table>
			<tr>
				<td></td>
				<td>No.</td>
				<td>회원 아이디</td>
				<td>회원 이름</td>
				<td>회원 이메일</td>
				<td>회원 구분</td>
			</tr>
			<tbody class="before-unconnect-agency-table-tbd">
			<c:forEach var="data" items="${agency_user}" varStatus="status">
				<tr>
					<td><input type="checkbox" name="ag_user_id_list" value="${data.user_id}"></td>
					<td>${agencyUserLoadNum - (status.count-1)}</td>
					<td>${data.user_id}</td>
					<td>${data.user_nm}</td>
					<td>${data.user_email}</td>
					<td><code value="${data.user_flag}"></code></td>
				</tr>
			</c:forEach>
			</tbody>
		</table>
		<div class="before-pagefour">
					
		<button ng-click="changePageLoadListFour(${repNaviFour.currentPage - repNaviFour.pagePerGroup})">◁◁</button>
		<button ng-click="changePageLoadListFour(${repNaviFour.currentPage - 1})">◀</button>
			<c:forEach var="i" begin="${repNaviFour.startPageGroup}" end="${repNaviFour.endPageGroup}" step="1">
						
						<c:choose>					
							<c:when test="${i eq repNaviFour.currentPage}">
								<span class="now">${i}</span>
							</c:when>
							<c:otherwise>
								<button ng-click="changePageLoadListFour(${i})">${i}</button>
							</c:otherwise>
						</c:choose>							
			</c:forEach>
		<button ng-click="changePageLoadListFour(${repNaviFour.currentPage + 1})">▶</button>
		<button ng-click="changePageLoadListFour(${repNaviFour.currentPage + repNaviFour.pagePerGroup})">▷▷</button>
		</div>
-------------------------------------------------------------------------------------------------------
	
		<h3>회사</h3>
		<table>
			<tr>
				<td></td>
				<td>No.</td>
				<td>회사 구분</td>
				<td>회사 아이디</td>
				<td>회사 일어명</td>
				<td>회사 영문명</td>
			</tr>
			<tbody class="before-connect-agency-table-tbd">
			<c:forEach var="data" items="${agency_list}" varStatus="status">
				<tr>
					<td><input type="radio" name="ag_id_list" value="${data.fap_comp_id}"></td>
					<td>${connectAgencyLoadNum - (status.count-1)}</td>
					<td><code value="${data.user_flag}"></code></td>
					<td>${data.fap_comp_id}</td>
					<td>${data.fap_comp_ja_nm}</td>
					<td>${data.fap_comp_en_nm}</td>
				</tr>
			</c:forEach>
			</tbody>
		</table>
		
		<div class="before-pagesix">
					
		<button ng-click="changePageLoadListSix(${repNaviSix.currentPage - repNaviSix.pagePerGroup})">◁◁</button>
		<button ng-click="changePageLoadListSix(${repNaviSix.currentPage - 1})">◀</button>
			<c:forEach var="i" begin="${repNaviSix.startPageGroup}" end="${repNaviSix.endPageGroup}" step="1">
						
						<c:choose>					
							<c:when test="${i eq repNaviSix.currentPage}">
								<span class="now">${i}</span>
							</c:when>
							<c:otherwise>
								<button ng-click="changePageLoadListSix(${i})">${i}</button>
							</c:otherwise>
						</c:choose>							
			</c:forEach>
		<button ng-click="changePageLoadListSix(${repNaviSix.currentPage + 1})">▶</button>
		<button ng-click="changePageLoadListSix(${repNaviSix.currentPage + repNaviSix.pagePerGroup})">▷▷</button>
		</div>

	<button onclick="company_user_connect('agency')">연결</button>
	</div>
	
<!-- ----------------------------------------분기--------------------------------------------- -->

	<div id="uncertain_company" style="display: none;">
		<h3>회원</h3>
		<table>
			<tr>
				<td></td>
				<td>No.</td>
				<td>회원 아이디</td>
				<td>회원 이름</td>
				<td>회원 이메일</td>
				<td>회원 구분</td>
			</tr>
			<tbody class="company-sub-table-tbd">
			<c:forEach var="data" items="${company_user}" varStatus="status">
				<tr>
					<td><input type="checkbox" name="unconnect_user_list" value="${data.user_id}"></td>
					<td>${companyUserLoadNum - (status.count-1)}</td>
					<td>${data.user_id}</td>
					<td>${data.user_nm}</td>
					<td>${data.user_email}</td>
					<td><code value="${data.user_flag}"></code></td>
				</tr>
			</c:forEach>
			</tbody>
		</table>
		
		<div class="before-pageseven">
					
		<button ng-click="changePageLoadListSeven(${repNaviThree.currentPage - repNaviThree.pagePerGroup})">◁◁</button>
		<button ng-click="changePageLoadListSeven(${repNaviThree.currentPage - 1})">◀</button>
			<c:forEach var="i" begin="${repNaviThree.startPageGroup}" end="${repNaviThree.endPageGroup}" step="1">
						
						<c:choose>					
							<c:when test="${i eq repNaviThree.currentPage}">
								<span class="now">${i}</span>
							</c:when>
							<c:otherwise>
								<button ng-click="changePageLoadListSeven(${i})">${i}</button>
							</c:otherwise>
						</c:choose>							
			</c:forEach>
		<button ng-click="changePageLoadListSeven(${repNaviThree.currentPage + 1})">▶</button>
		<button ng-click="changePageLoadListSeven(${repNaviThree.currentPage + repNaviThree.pagePerGroup})">▷▷</button>
		</div>
		
		<table>
			<tbody class="agency-sub-table-tbd">
			<c:forEach var="data" items="${agency_user}" varStatus="status">
				<tr>
					<td><input type="checkbox" name="unconnect_user_list" value="${data.user_id}"></td>
					<td>${agencyUserLoadNum - (status.count-1)}</td>
					<td>${data.user_id}</td>
					<td>${data.user_nm}</td>
					<td>${data.user_email}</td>
					<td><code value="${data.user_flag}"></code></td>
				</tr>
			</c:forEach>
			</tbody>
		</table>
	
		<div class="before-pageeight">
					
		<button ng-click="changePageLoadListEight(${repNaviFour.currentPage - repNaviFour.pagePerGroup})">◁◁</button>
		<button ng-click="changePageLoadListEight(${repNaviFour.currentPage - 1})">◀</button>
			<c:forEach var="i" begin="${repNaviFour.startPageGroup}" end="${repNaviFour.endPageGroup}" step="1">
						
						<c:choose>					
							<c:when test="${i eq repNaviFour.currentPage}">
								<span class="now">${i}</span>
							</c:when>
							<c:otherwise>
								<button ng-click="changePageLoadListEight(${i})">${i}</button>
							</c:otherwise>
						</c:choose>							
			</c:forEach>
		<button ng-click="changePageLoadListEight(${repNaviFour.currentPage + 1})">▶</button>
		<button ng-click="changePageLoadListEight(${repNaviFour.currentPage + repNaviFour.pagePerGroup})">▷▷</button>
		</div>
	
-------------------------------------------------------------------------------------------------------
	
		<h3>회사</h3>
		<table>
			<tr>
				<td></td>
				<td>No.</td>
				<td>회사 아이디</td>
				<td>회사 일어명</td>
				<td>회사 영문명</td>
			</tr>
			<tbody class="before-uncertain-table-tbd">
			<c:forEach var="data" items="${select_uncertain_company}" varStatus="status">
				<tr>
					<td><input type="radio" name="uncertain_company_id" value="${data.fap_comp_id}"></td>
					<td>${uncertainLoadNum - (status.count-1)}</td>
					<td>${data.fap_comp_id}</td>
					<td>${data.fap_comp_ja_nm}</td>
					<td>${data.fap_comp_en_nm}</td>
				</tr>
			</c:forEach>
			</tbody>
		</table>

		<div class="before-pagetwo">
					
		<a href="javascript:changePageLoadListTwo(${repNaviTwo.currentPage - repNaviTwo.pagePerGroup})">◁◁</a>
		<a href="javascript:changePageLoadListTwo(${repNaviTwo.currentPage - 1})">◀</a>
			<c:forEach var="i" begin="${repNaviTwo.startPageGroup}" end="${repNaviTwo.endPageGroup}" step="1">
						
						<c:choose>					
							<c:when test="${i eq repNaviTwo.currentPage}">
								<span class="now">${i}</span>
							</c:when>
							<c:otherwise>
								<a href="javascript:changePageLoadListTwo(${i})">${i}</a>
							</c:otherwise>
						</c:choose>							
			</c:forEach>
		<a href="javascript:changePageLoadListTwo(${repNaviTwo.currentPage + 1})">▶</a>
		<a href="javascript:changePageLoadListTwo(${repNaviTwo.currentPage + repNaviTwo.pagePerGroup})">▷▷</a>
		</div>

	<button onclick="company_user_connect('uncertain_company')">연결</button>
	</div>

</body>
</html>
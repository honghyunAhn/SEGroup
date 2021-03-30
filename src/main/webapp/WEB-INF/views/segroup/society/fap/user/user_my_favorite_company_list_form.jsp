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

	<link rel="stylesheet" type="text/css" href="<c:url value="/resources/segroup/society/fap/css/userDefault.css" />" />
	<link rel="stylesheet" type="text/css" href="<c:url value="/resources/segroup/society/fap/css/popModal.css" />" />
	
	<script type="text/javascript">
		var myApp = angular.module('myapp', []);
		
		myApp.controller('MyFavoriteCompanyController', ['$scope', '$compile', '$http', function($scope, $compile, $http) {
			//[start] 내가담은리스트  삭제 시작
			$scope.deleteFavoriteCompanyAnchor = function(e) {
				var fap_fav_comp_seq = $(e.currentTarget).attr('data-id');
				var fap_jobfair_divide_seq = $('#deleteFavoriteCompanyAnchorForm'+fap_fav_comp_seq).find('#fap_jobfair_divide_seq').val();
				var fap_jobfair_seq = $('#deleteFavoriteCompanyAnchorForm'+fap_fav_comp_seq).find('#fap_jobfair_seq').val();
				var deleteMyFavoriteCompany = {
						"fap_fav_comp_seq" : fap_fav_comp_seq
						,"fap_jobfair_divide_seq" : fap_jobfair_divide_seq
						,"fap_jobfair_seq" : fap_jobfair_seq
				}
				//모두삭제 유저확인 받는부분
				if(fap_fav_comp_seq == 0){
					var realDelete = confirm('정말 전체 삭제하시겠습니까?');
					if(realDelete == false){
						return false;
					}
				}
				$http({
					url: 'delete_my_favorite_company_list',
					method: 'post',
					data : JSON.stringify(deleteMyFavoriteCompany),
					responseType : 'text',
					headers : {
						"AJAX" : true
					}
				}).then(function successCallback(response) {
					if(response.data == 'deleteOne'){
						alert('해당 기업이 내가담은기업 목록에서 삭제되었습니다.');
					}else if(response.data == 'deleteAll'){
						alert('내가담은기업 목록이 전체 삭제되었습니다.');
					} else{
						alert('삭제할 목록이 없습니다.');
					}
					location.href = '<c:url value="/fap/user/user_my_favorite_company_list_form" />';
				}, function errorCallback(response) {
					console.log(response);
					if(response.status == 403){
						alert('<spring:message code="com.login.ajaxSesstion" javaScriptEscape="true" />');
						location.href = "/fap/user/user_login";
					}
				});
			}
			//[end] 내가담은리스트  삭제 종료
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
<body ng-app="myapp" ng-controller="MyFavoriteCompanyController">
	<%@include file="user_menu.jsp"%><%@include file="user_quick_menu.jsp"%>
	
	<div id="subcontents">
		<div id="sub1Box">
			<br>
			<h1>내가담은기업</h1>
			<h6><span class="red">다양한 준비로 더 많은 취업성공을 이끕니다!</span></h6>
			
			<div class="sub1_search">
			</div>
			
			<div id="sub1_tab"><br><br></div>
			
			<div id="sub1_bbs">
				<ul class="tit1">
					<li class="wid1">No</li>
					<li class="wid2">채용공고</li>
					<li class="wid3">기업명</li>
					<li class="wid4">잡페어 기간</li>
					<li class="wid5">삭제</li>
				</ul>
					
				<c:forEach var="favoriteCompany" items="${favoriteCompanyList}" varStatus="status">
					<ul class="tit2">
						<li class="wid1">${status.count}</li>
						<li class="wid2">
							<div class="jobname">
								<a href="<c:url value="/fap/user/user_job_advertisement_read_form?fap_job_ad_seq=${favoriteCompany.fap_job_ad_seq}" />">
									${favoriteCompany.fap_job_ad_title}
								</a>
							</div>
							 <div class="jobgwork">
								모집직종:
								<c:forEach var="category" items="${favoriteCompany.categoryList}" varStatus="status">
									<c:if test="${status.count % 2 eq 0}">/&nbsp;</c:if>
									<code value="${category.fap_job_category_gb}"></code>
								</c:forEach>
							</div>
							<div class="jobgpack">
								근무지:
								<c:forEach var="workPlace" items="${favoriteCompany.workPlaceList}" varStatus="status">
									<c:if test="${status.count % 2 eq 0}">/&nbsp;</c:if>
									<code value="${workPlace.fap_job_workplace_gb}"></code>
								</c:forEach>
							</div>
						    <div class="jobgroup">
						    	그룹 : 
								<c:choose>
									<c:when test="${favoriteCompany.fap_job_ad_groupcode eq 'D0500'}">
										<code value="${favoriteCompany.fap_job_ad_groupcode}"></code>
									</c:when>
									<c:otherwise>
										${favoriteCompany.fap_job_ad_groupcode}
									</c:otherwise>
								</c:choose>
						    </div>
						</li>
						<li class="wid3">
							${favoriteCompany.fap_comp_ja_nm}	
						</li>
						<li class="wid4">
							${favoriteCompany.fap_jobfair_divide_st} ~ <br>
				      		${favoriteCompany.fap_jobfair_divide_et}
				      	</li>
						<li class="wid5">
							<form id="deleteFavoriteCompanyAnchorForm${favoriteCompany.fap_fav_comp_seq}">
				  				<input type="hidden" id="fap_jobfair_divide_seq" name="fap_jobfair_divide_seq" value="${favoriteCompany.fap_jobfair_divide_seq}">
				  				<input type="hidden" id="fap_jobfair_seq" name="fap_jobfair_seq" value="${favoriteCompany.fap_jobfair_seq}">
					  			<button type="button" class="btn4 btn-primary" id="searchCompanyButton" data-id="${favoriteCompany.fap_fav_comp_seq}"
		            		 		ng-click="deleteFavoriteCompanyAnchor($event)" style="height: 50px;">
		            				삭제
	            				</button>
			  				</form>
						</li>
					</ul>
				</c:forEach>	
			</div>
		
		</div>
	</div>
	
	<%@include file="../common_footer_fap.jsp"%>
</body>
</html>
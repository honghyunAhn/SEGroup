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
		
		function changePageAdList(clickedPage) {
			window.location.href='<c:url value="/fap/user/user_job_advertisement_list_form?clickedPage=" />'+clickedPage;
		}
	</script>
	
</head>
<body ng-app="myapp">
	<%@include file="user_menu.jsp"%><%@include file="user_quick_menu.jsp"%>
	
	<div id="subcontents">
		<div id="sub1Box">
			<br>
			<h1>채용공고 목록</h1>
			<h6><span class="red">다양한 준비로 더 많은 취업성공을 이끕니다!</span></h6>
			
			<div id="sub1_bbs">
				<ul class="tit1">
					<li class="wid1">No</li>
					<li class="wid2 tx_ct">채용공고</li>
					<li class="wid3">기업명</li>
					<li class="wid4">타입</li>
					<li class="wid3">잡페어 기간</li>
				</ul>
					
				<c:forEach var="jobAdvertisement" items="${jobAdvertisementList}" varStatus="status">
					<ul class="tit2">
						<%-- <li class="wid1">${theNumberOfJobAd - (status.count-1)}</li> --%>
						<li class="wid1 lh65">${status.count}</li>
						<li class="wid2">
							<div class="jobname ellipsis">
								<a href="<c:url value="/fap/user/user_job_advertisement_read_form?fap_job_ad_seq=${jobAdvertisement.fap_job_ad_seq}" />" title="${jobAdvertisement.fap_job_ad_title}">
									${jobAdvertisement.fap_job_ad_title}
								</a>
							</div>
							<div class="jobgwork ellipsis">
								모집직종:
								<c:forEach var="category" items="${jobAdvertisement.categoryList}" varStatus="status">
									<c:if test="${status.count % 2 eq 0}">/&nbsp;</c:if>
									<code value="${category}"></code>
								</c:forEach>
							</div>
							<div class="jobgpack ellipsis">
								근무지:
								<c:forEach var="workPlace" items="${jobAdvertisement.workPlaceList}" varStatus="status">
									<c:if test="${status.count % 2 eq 0}">/&nbsp;</c:if>
									<code value="${workPlace}"></code>
								</c:forEach>
							</div>
						    <%-- <div class="jobgroup">
						    	그룹 : 
								<c:choose>
									<c:when test="${jobAdvertisement.fap_job_ad_groupcode eq 'D0500'}">
										<code value="${jobAdvertisement.fap_job_ad_groupcode}"></code>
									</c:when>
									<c:otherwise>
										${jobAdvertisement.fap_job_ad_groupcode}
									</c:otherwise>
								</c:choose>
						    </div> --%>
						</li>
						<li class="wid3 ellipsis lh65" title="${jobAdvertisement.fap_comp_ja_nm}">
							${jobAdvertisement.fap_comp_ja_nm}	
						</li>
						<li class="wid4 lh65">
							<code value="${jobAdvertisement.fap_job_ad_rule_type}"></code>
						</li>
						<li class="wid3 lh65">
							${jobAdvertisement.fap_jobfair_divide_st} ~ ${jobAdvertisement.fap_jobfair_divide_et}
				      	</li>
					</ul>
				</c:forEach>
				<!-- 페이징 -->
				<div class="before-page">
					<ul class="before-page-ul">
						<li>
							<a href="javascript:changePageAdList(${repNavi.currentPage - repNavi.pagePerGroup})">◁◁</a>
						</li>
						<li>
							<a href="javascript:changePageAdList(${repNavi.currentPage - 1})">◀</a>
						</li>
						<c:forEach var="i" begin="${repNavi.startPageGroup}" end="${repNavi.endPageGroup}" step="1">
							<li>
							<c:choose>					
								<c:when test="${i eq repNavi.currentPage}">
									<span class="now">${i}</span>
								</c:when>
								<c:otherwise>
									<a href="javascript:changePageAdList(${i})">${i}</a>
								</c:otherwise>
							</c:choose>									
							</li>
						</c:forEach>
						<li>
							<a href="javascript:changePageAdList(${repNavi.currentPage + 1})">▶</a>
						</li>
						<li>
							<a href="javascript:changePageAdList(${repNavi.currentPage + repNavi.pagePerGroup})">▷▷</a>
						</li>
					</ul>
				</div>
				<!-- 페이징 -->
				<br>
			</div>
		</div>
	</div>
	
	<%@include file="../common_footer_fap.jsp"%>	
</body>
</html>
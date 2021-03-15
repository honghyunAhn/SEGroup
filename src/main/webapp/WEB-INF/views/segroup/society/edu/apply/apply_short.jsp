<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" Content="text/html; charset=utf-8" /><!-- 
<meta name="viewport" content="width=device-width, target-densitydpi=medium-dpi " /> -->
<meta name="format-detection" content="telephone=no">
<script src="<c:url value="/resources/segroup/js/angular.min.js" />"></script>
<script src="<c:url value="/resources/segroup/js/jquery-3.1.1.js" />"></script>
<script src="<c:url value="/resources/segroup/society/edu/js/slidebanner.js" />"></script>
<head>
	<title></title>
<script src="<c:url value="/resources/segroup/society/edu/js/jquery.bxslider.min.js" />"></script>
<!-- bxSlider CSS file -->
<link href="<c:url value="/resources/segroup/society/edu/css/jquery.bxslider.css" />" rel="stylesheet" />
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/segroup/society/edu/css/common.css" />">
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/segroup/society/edu/css/sub.css" />">
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/segroup/society/edu/css/main.css" />">
<script type="text/javascript">
	var myApp = angular.module('myapp', []);
	
	myApp.directive('code', ['$http',function($http){
		return {
			restrict: "E",
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
			,template: "<span>{{filterParams}}</span>"
		}
	}]);

</script>
<style>
.sub_top_img{ width: 984px; height: 300px; }
</style>

</head>
<body ng-app="myapp">
<%@include file="../menu.jsp"%>
<div class="sub_m_contents">
	<div class="main_top_slidewrap">
		<div class="sub_top_img"  style="margin:auto;">
			<img src="<c:url value="/resources/segroup/society/edu/image/sub/images/sub_top_img.png" />" alt="sub_top_img" />
		</div>
		<div class="master_bottom_menu">
			<ul>
				<li class="choice_menu mbm1"><a href="#app_01">지원자격</a></li>
				<li class="mbm2"><a href="#app_02">전형방법</a></li>
				<li class="mbm3"><a href="#app_03">면접일정 & 장소</a></li>
				<li class="mbm4"><a href="#app_04">강사진</a></li>
				<li class="mbm5"><a href="#app_05">지원서작성</a></li>
				<li class="mbm6"><a href="#app_06">수강문의</a></li>
			</ul>
		</div>
		<div class="master_bottom_contents">
			<div class="info1" id="app_01">지원자격</div>
			<div class="info2" id="app_02">전형방법</div>
			<div class="info3" id="app_03">면접일정 & 장소</div>
			<div class="info1" id="app_04">강사진</div>
			<!-- <div class="info1" id="app_05">과정신청</div> -->
			<div class="info1" id="app_05" style="font-size:15px;    text-align: center;">
			<span style="vertical-align: middle;  line-height: 35px; display: inline-block;">
			 <c:forEach var="data" items="${shortTermList }" varStatus="status">
 				<span style="    display: inline-flex;">
	 			${status.count } | ${data.gisu_crc_nm } | ${data.gisu_num } | ${data.gisu_crc_st } ~ ${data.gisu_crc_et } | ${data.gisu_app_st } ~ ${data.gisu_app_et } | ${data.gisu_crc_days }일 |
	 			<c:choose>
	 				<c:when test="${data.gisu_result == 'B1600'}">
					 	 &nbsp;<a href="/edu/apply/apply_form?gisu_seq=${data.gisu_seq }" class="gisu_insert" style="color:red;"><code value="${data.gisu_result }"></code></a> <br />
	 				</span>
	 				</c:when>
	 				<c:when test="${data.gisu_result == 'B1601'}">
	 					 &nbsp;<a href="/edu/apply/apply_update_form?gisu_seq=${data.gisu_seq }" class="gisu_update" style="color:blue;"><code value="${data.gisu_result }"></code></a> <br />
	 				</span>
	 				</c:when>
	 				<c:otherwise>
	 					 &nbsp;<code value="${data.gisu_result }"></code><br />
	 				</span>
	 				</c:otherwise>
	 			</c:choose>
 			</c:forEach>
 			</span>
			 </div> 
			<div class="info1" id="app_06">수강문의</div>
		</div>
	</div>
</div>
<%@include file="../footer.jsp"%>
</body>
</html>
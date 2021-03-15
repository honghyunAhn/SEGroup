<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<script src="<c:url value="/resources/segroup/js/jquery-3.1.1.js" />"></script>
<script src="<c:url value="/resources/segroup/js/angular.min.js" />"></script>
<script src="<c:url value="/resources/segroup/society/edu/js/admin_menu.js" />"></script>
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/segroup/society/edu/css/admin_menu.css" />">
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/segroup/society/edu/css/bootstrap.min.css" />">
<!-- 페이징관련 css 시작 -->
<script src="<c:url value="/resources/segroup/society/edu/js/slidebanner.js" />"></script>
<script src="<c:url value="/resources/segroup/society/edu/js/jquery.bxslider.min.js" />"></script>
<!-- bxSlider CSS file -->
<link href="<c:url value="/resources/segroup/society/edu/css/jquery.bxslider.css" />" rel="stylesheet" />
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/segroup/society/edu/css/common.css" />">
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/segroup/society/edu/css/sub.css" />">
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/segroup/society/edu/css/main.css" />">
<!-- 페이징 관련 css 끝 -->

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>글로벌 엔지니어 양성</title>
<script type="text/javascript">
	$(function() {
		initialize();
		
		$("#pageSelect").change(function(){
			var pageCount = $(this).val();
			location.href="${path}/edu/admin/payment_manager_form?pageCount="+pageCount+"&curPage=${map.adminPager.curPage}&orderType=${map.orderType}&orderValue=${map.orderValue}";
		});
	});
	
	function initialize(){
		var orderType = $("#orderType").val();
		var orderValue = $("#orderValue").val();
		
		$.each($(".arrow"),function(index, item){
			if($(this).hasClass(orderType) && orderValue == 'asc'){
				$(this).removeClass('desc').addClass(orderValue);
				$(this).attr('src','/resources/segroup/society/edu/image/main/triangle_up.png');
			}else{
				$(this).removeClass('asc').addClass(orderValue);
				$(this).attr('src','/resources/segroup/society/edu/image/main/triangle_down.png');
			}
		});
	}
	
	var myApp = angular.module('myapp', []);
	
	myApp.controller('AdminController', ['$scope','$compile','$http', function($scope,$compile,$http){
		$scope.permission = function($event){
			var gisu_per = angular.element($event.currentTarget).find("span").attr("value");
			var gisu_seq = angular.element($event.currentTarget).next(".gisu_seq").val();
			
			$http({
				method: 'POST',
				url: '/edu/admin/curriculum_gisu_permission_update',
				params : {
					gisu_seq : gisu_seq,
					gisu_per : gisu_per
				}
			}).then(function successCallback(response) {
	    		if(response.data.gisu_per_flag){
	    			var code = '<code value="'+response.data.gisu_per+'"></code>'
	    			angular.element($event.currentTarget).html($compile(code)($scope));
	    			alert(response.data.message);
	    		}else{
	    			alert(response.data.message);
	    		}
			}, function errorCallback(response) {
				console.log(response);
			});
			
		}
	}]);
	
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
	
	
	function pay_decision(seq){
		document.getElementById("payment"+seq).submit();
	}
	
	function ilist(page){
	    location.href="${path}/edu/admin/payment_manager_form?pageCount=${map.pageCount}&curPage="+page;
	}
	
	function order_change(orderType, target){
		var orderValue = '';
		
		if($(target).hasClass('desc')){
			$(target).removeClass('desc').addClass('asc');
			orderValue = 'asc';
		}else{
			$(target).removeClass('asc').addClass('desc');
			orderValue = 'desc';
		}
	
		location.href="${path}/edu/admin/payment_manager_form?pageCount=${map.pageCount}&curPage="+${map.adminPager.curPage}+"&orderType="+orderType+"&orderValue="+orderValue;
	}
</script>
</head>
<body ng-app="myapp" ng-controller="AdminController">
<%@include file="admin_menu.jsp"%>
<div class="page_title">
	<h2>기수 결제 관리</h2>
	<h5>결제 관리 페이지&nbsp;&nbsp;&gt;&nbsp;&nbsp;<a href="payment_manager_form">기수 결제 관리</a></h5>
</div>
<div class="custom_div">
	<select id="pageSelect">
		<option value="10">10개씩</option>
		<c:forEach var="data" items="${map.adminPager.pageCountList}">
			<c:if test="${data == map.pageCount}">
				<option value="${data}" selected>${data}개씩</option>
			</c:if>
			<c:if test="${data != map.pageCount}">
				<option value="${data}">${data}개씩</option>
			</c:if>
		</c:forEach>
	</select>
	<table class="table">
		<thead>
			<tr>
				<th>번호</th>
				<th>기수</th>
				<th>커리큘럼</th>
				<th>교육일수</th>
				<th>교육비용</th>
				<th>모집기간</th>
				<th>교육기간</th>
				<th>비 고</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="data" items="${seaCurGisu }" varStatus="status">
				<tr>
					<td>${map.count - ((map.adminPager.curPage - 1) * (map.adminPager.pageBegin-1) + status.index)}</td>
					<td>${data.gisu_num }</td>
					<td>${data.gisu_crc_nm }</td>
					<td>${data.gisu_crc_month }개월 ${data.gisu_crc_days }일 (${data.gisu_crc_times }시간)</td>
					<td><fmt:formatNumber value="${data.gisu_crc_pay }" pattern="#,###" />원</td>
					<td>${data.gisu_app_st } ~ ${data.gisu_app_et }</td>
					<td>${data.gisu_crc_st } ~ ${data.gisu_crc_et }</td>
					<td>
						<a href="" onclick="pay_decision('${data.gisu_seq }')">결제정보 정하기</a>
					</td>
				</tr>
				<form  action="/edu/admin/payment_form" id="payment${data.gisu_seq }" method="post">
					<input name="gisu_name" type="hidden" value="${data.gisu_crc_nm }"/>
					<input name="gisu_seq" type="hidden" value="${data.gisu_seq }"/>
				</form>
			</c:forEach>
		</tbody>
	</table>
	<input type="hidden" id="orderType" value="${map.orderType}">
	<input type="hidden" id="orderValue" value="${map.orderValue}">
</div>

<div class="pagination_wrap">
	<div class="pagination_con">
	<span id="page"style="display: inline; margin:auto; display:table; ">
	<h4>
	<ul>
	<li>
	<ol>
	
	<!-- **처음페이지로 이동 : 현재 페이지가 1보다 크면  [처음]하이퍼링크를 화면에 출력-->
	<c:if test="${map.adminPager.curBlock > 1}">
		<li><input type="button" onclick="javascript:ilist('1')" name="" value="<<"></li>
	</c:if>
	
	<!-- **이전페이지 블록으로 이동 : 현재 페이지 블럭이 1보다 크면 [이전]하이퍼링크를 화면에 출력 -->
	<c:if test="${map.adminPager.curBlock > 1}">
		<li><input type="button" onclick="javascript:ilist('${map.adminPager.prevPage}')" name="" value="<"></li>
	</c:if>
	
	<!-- **하나의 블럭에서 반복문 수행 시작페이지부터 끝페이지까지 -->
	<c:forEach var="num" begin="${map.adminPager.blockBegin}" end="${map.adminPager.blockEnd}">
		<!-- **현재페이지이면 하이퍼링크 제거 -->
		<c:choose>
			<c:when test="${num == map.adminPager.curPage}">
				<li><input type="button" style="color: red"name="" value="${num}"></li>
			</c:when>
			<c:otherwise>
				<li><input type="button" onclick="javascript:ilist('${num}')" name="" value="${num}"></li>
			</c:otherwise>
		</c:choose>
	</c:forEach>
	
	<!-- **다음페이지 블록으로 이동 : 현재 페이지 블럭이 전체 페이지 블럭보다 작거나 같으면 [다음]하이퍼링크를 화면에 출력 -->
	<c:if test="${map.adminPager.curBlock <= map.adminPager.totBlock}">
		<li><input type="button" onclick="javascript:ilist('${map.adminPager.nextPage}')" name="" value=">"></li>
	</c:if>
	
	<!-- **끝페이지로 이동 : 현재 페이지가 전체 페이지보다 작거나 같으면 [끝]하이퍼링크를 화면에 출력 -->
	<c:if test="${map.adminPager.curPage <= map.adminPager.totPage}">
		<li><input type="button" onclick="javascript:ilist('${map.adminPager.totPage}')" name="" value=">>"></li>
	</c:if>
	</ol>
	</h4>
	</li>
	</ul>
	</span>
	</div>
</div>

</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html" charset="UTF-8">
	<title>Bridge Job Fair</title>
	<script src="<c:url value="/resources/segroup/js/jquery-3.1.1.js" />"></script>
	<script src="<c:url value="/resources/segroup/js/angular.min.js" />"></script>
	<link rel="stylesheet" type="text/css" href="<c:url value="/resources/segroup/society/edu/css/bootstrap.min.css" />">
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
	</script>
	<script type="text/javascript">
		$(function() {
			initialize();
			$("#pageSelect").change(function() {
				var pageCount = $(this).val();
				location.href = "${path}/fap/admin/user_management?pageCount=" + pageCount + "&orderType=${map.orderType}&orderValue=${map.orderValue}";
			});
		});
		
		function initialize() {
			var orderType = $("#orderType").val();
			var orderValue = $("#orderValue").val();
			
			$.each($(".arrow"),function(index, item) {
				if ($(this).hasClass(orderType) && orderValue == 'asc') {
					$(this).removeClass('desc').addClass(orderValue);
					$(this).attr('src','/resources/segroup/society/edu/image/main/triangle_up.png');
				} else {
					$(this).removeClass('asc').addClass(orderValue);
					$(this).attr('src','/resources/segroup/society/edu/image/main/triangle_down.png');
				}
			});
		}
		
		function ilist(page) {
			var key = document.getElementById("searchKey");
			var searchKey = key.options[key.selectedIndex].value;			
			var val = document.getElementById("searchValue");
			var searchValue= val.value;
				 
			location.href = "${path}/fap/admin/user_management?searchKey=" + searchKey + "&searchValue=" + searchValue + "&pageCount=${map.pageCount}&curPage=" + page + "&orderType=${map.orderType}&orderValue=${map.orderValue}";
		}
		
		function order_change(orderType, target) {
			var orderValue = '';
			if ($(target).hasClass('desc')) {
				$(target).removeClass('desc').addClass('asc');
				orderValue = 'asc';
			} else {
				$(target).removeClass('asc').addClass('desc');
				orderValue = 'desc';
			}
			var key = document.getElementById("searchKey");
			var searchKey = key.options[key.selectedIndex].value;			
			var val = document.getElementById("searchValue");
			var searchValue= val.value;
			location.href = "${path}/fap/admin/user_management?searchKey=" + searchKey + "&searchValue=" + searchValue + "&pageCount=${map.pageCount}&curPage=" + ${map.adminPager.curPage} + "&orderType=" + orderType + "&orderValue=" + orderValue;
		}
		
		//검색
		function search() {
			var key = document.getElementById("searchKey");
			var searchKey = key.options[key.selectedIndex].value;			
			var val = document.getElementById("searchValue");
			var searchValue= val.value;
				 
			location.href = "${path}/fap/admin/user_management?searchKey=" + searchKey + "&searchValue=" + searchValue;
		}
	</script>
	<style type="text/css">
		button{color:white;font-weight:bold;background-color:#3af;border-radius:10px;border:none;padding:5px;width:15%;}
		input[type="submit"]{background-color:#3af;color:white;border:none;border-radius:4px;width:65%;height:30px;font-weight:bold;}
		.pagination_con{display:inline-block;}
		.pagination_wrap{overflow:hidden;text-align:center;margin:45px 0 35px;}
		.pagination_wrap input{background-color:#fff;border:1px solid #ccc;height:30px;width:30px;margin:2px;font-weight:bold;font-style:16px;}
	</style>
</head>
<body ng-app="myapp">
	<%@include file="admin_menu.jsp"%>
	<br>
	<div class="page_title">
		<h2>JobFair 회원 관리</h2>
	</div>
	<br>
	<div style="text-align:center;">
		<button onclick="location.href='/fap/admin/company_user_connect'" style="color:white;font-weight:bold;background-color:#3af;border-radius:10px;border:none;padding:5px;width:15%;">기업 - 담당자 연결</button>
		<button onclick="location.href='/fap/admin/company_user_connect_management'" style="color:white;font-weight:bold;background-color:#3af;border-radius:10px;border:none;padding:5px;width:15%;">기업 - 담당자 연결 관리</button>
	</div>
	<br>
	<div class="custom_div">
		<!-- 검색 -->
		<table class="search_box">
			 <tr>
				  <th style="width:20%;">
				  		<select id="searchKey"  name="searchKey" style="margin-bottom:0;">
							<option value="searchId" >아이디로 검색</option>
							<option value="searchNm" >이름으로 검색</option>
						</select>	
				   </th>				  
				   <td style="width:40%;">
				   		<input type="text" id="searchValue" name="searchValue">	
				   	</td>
				   	<td class="td_search">
						<button class="btn_search" onclick="search()" style="width: 100px">검색</button>
				   </td>
				  </tr>					 
		</table>
		<!-- 페이지 조회글수 선택 -->
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
					<th>No.</th>
					<th>회원구분</th>
					<th>아이디&nbsp;<img class="arrow desc user_id" src="/resources/segroup/society/edu/image/main/triangle_down.png;" onclick="order_change('user_id', this)"></th>
					<th>이름&nbsp;<img class="arrow desc user_nm" src="/resources/segroup/society/edu/image/main/triangle_down.png;" onclick="order_change('user_nm', this)"></th>
					<th>성별&nbsp;<img class="arrow desc user_sex" src="/resources/segroup/society/edu/image/main/triangle_down.png;" onclick="order_change('user_sex', this)"></th>
					<th>이메일</th>
					<th>생년월일&nbsp;<img class="arrow desc user_birth" src="/resources/segroup/society/edu/image/main/triangle_down.png;" onclick="order_change('user_birth', this)"></th>
					<th>전화번호</th>
					<th>회원 정보 수정</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="data" items="${user_list}" varStatus="status">
					<tr>
						<td>${map.count - map.adminPager.pageBegin - status.index + 1}</td>
						<td><code value="${data.user_flag}"></code></td>
						<td>${data.user_id}</td>
						<td>${data.user_nm}</td>
						<td><code value="${data.user_sex}"></code></td>
						<td>${data.user_email}</td>
						<td>${data.user_birth}</td>
						<td>${data.user_phone}</td>
						<td>
							<form action="/fap/admin/user_update_form" method="post">
								<input type="hidden" name="user_flag" value="${data.user_flag}">
								<input type="hidden" name="user_id" value="${data.user_id}">
								<input type="hidden" name="curPage" value="${curPage}">
								<input type="hidden" name="pageCount" value="${pageCount}">
								<input type="hidden" name="orderValue" value="${orderValue}">
								<input type="hidden" name="orderType" value="${orderType}">
								<input type="hidden" name="searchKey" value="${searchKey}">
								<input type="hidden" name="searchValue" value="${searchValue}">
								<input type="submit" value="수정" style="background-color:#3af;color:white;border:none;border-radius:4px;width:65%;height:30px;font-weight:bold;">
							</form>
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		<input type="hidden" id="orderType" value="${map.orderType}">
		<input type="hidden" id="orderValue" value="${map.orderValue}">
	</div>
	
	<div class="pagination_wrap" style="overflow:hidden;text-align:center;margin:45px 0 35px;">
		<div class="pagination_con" style="display:inline-block;">
			<span id="page"style="display: inline; margin:auto; display:table; ">
				<!-- **처음페이지로 이동 : 현재 페이지가 1보다 크면  [처음]하이퍼링크를 화면에 출력-->
				<c:if test="${map.adminPager.curBlock > 1}">
					<input type="button" onclick="javascript:ilist('1','')" name="" value="<<">
				</c:if>
				
				<!-- **이전페이지 블록으로 이동 : 현재 페이지 블럭이 1보다 크면 [이전]하이퍼링크를 화면에 출력 -->
				<c:if test="${map.adminPager.curBlock > 1}">
					<input type="button" onclick="javascript:ilist('${map.adminPager.prevPage}','')" name="" value="<">
				</c:if>
				
				<!-- **하나의 블럭에서 반복문 수행 시작페이지부터 끝페이지까지 -->
				<c:forEach var="num" begin="${map.adminPager.blockBegin}" end="${map.adminPager.blockEnd}">
					<!-- **현재페이지이면 하이퍼링크 제거 -->
					<c:choose>
						<c:when test="${num == map.adminPager.curPage}">
							<input type="button" style="color: red"name="" value="${num}">
						</c:when>
						<c:otherwise>
							<input type="button" onclick="javascript:ilist('${num}','')" name="" value="${num}">
						</c:otherwise>
					</c:choose>
				</c:forEach>
				
				<!-- **다음페이지 블록으로 이동 : 현재 페이지 블럭이 전체 페이지 블럭보다 작거나 같으면 [다음]하이퍼링크를 화면에 출력 -->
				<c:if test="${map.adminPager.curBlock <= map.adminPager.totBlock}">
					<input type="button" onclick="javascript:ilist('${map.adminPager.nextPage}','')" name="" value=">">
				</c:if>
				
				<!-- **끝페이지로 이동 : 현재 페이지가 전체 페이지보다 작거나 같으면 [끝]하이퍼링크를 화면에 출력 -->
				<c:if test="${map.adminPager.curPage < map.adminPager.totPage}">
					<input type="button" onclick="javascript:ilist('${map.adminPager.totPage}','')" name="" value=">>">
				</c:if>
			</span>
		</div>
	</div>
</body>
</html>
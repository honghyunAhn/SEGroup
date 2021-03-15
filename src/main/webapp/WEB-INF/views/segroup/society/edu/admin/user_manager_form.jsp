<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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

$(function() {
	initialize();
	$("#pageSelect").change(function(){
		var pageCount = $(this).val();
		
		location.href="${path}/edu/admin/user_manager_form?pageCount="+pageCount+"&curPage=${map.adminPager.curPage}&orderType=${map.orderType}&orderValue=${map.orderValue}";
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

function ilist(page){
	var sel = document.getElementById("select");
	var val = sel.options[sel.selectedIndex].value;
	if(val=="selectId"){
		var searchId = $("#searchIdName").val();
		var searchName = "";
	}else if(val="selectName"){
		var searchId = "";
		var searchName = $("#searchIdName").val();
	}
    location.href="${path}/edu/admin/user_manager_form?searchId="+searchId+"&searchName="+searchName+"&pageCount=${map.pageCount}&curPage="+page+"&orderType=${map.orderType}&orderValue=${map.orderValue}";
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

	var sel = document.getElementById("select");
	var val = sel.options[sel.selectedIndex].value;
	if(val=="selectId"){
		var searchId = $("#searchIdName").val();
		var searchName = "";
	}else if(val="selectName"){
		var searchId = "";
		var searchName = $("#searchIdName").val();
	}
	location.href="${path}/edu/admin/user_manager_form?searchId="+searchId+"&searchName="+searchName+"&pageCount=${map.pageCount}&curPage="+${map.adminPager.curPage}+"&orderType="+orderType+"&orderValue="+orderValue;
}

function search(){
	var sel = document.getElementById("select");
	var val = sel.options[sel.selectedIndex].value;
	if(val=="selectId"){
		var searchId = $("#searchIdName").val();
		var searchName = "";
	}else if(val="selectName"){
		var searchId = "";
		var searchName = $("#searchIdName").val();
	}
	//location.href="${path}/edu/admin/user_manager_form?searchId="+searchId+"&searchName="+searchName+"&pageCount=${map.pageCount}&curPage=${map.adminPager.curPage}&orderType=${map.orderType}&orderValue=${map.orderValue}";
	location.href="${path}/edu/admin/user_manager_form?searchId="+searchId+"&searchName="+searchName;
}

function toUpdateForm(user_id){
	$("#id").val(user_id);
	$("#update_form").submit();
}

function deleteUser(user_id){
	if(confirm("회원탈퇴를 하시겠습니까?")){
		$("#delete_id").val(user_id);
		$("#delete_form").submit();
	}
}
</script>
</head>
<body ng-app="myapp" >
<%@include file="admin_menu.jsp"%>
<div class="page_title"><h2>SMART Cloud IT 마스터 회원 관리</h2></div>
<div class="custom_div">
	<!--
	 **
	 * @Method Name : 마스터 회원 관리 검색
	 * @Date : 2018. 09. 12.
	 * @User : 김홍일
	 * @Param : 회원 아이디, 회원 이름
	 * @Return : basic_user_select_all
	 * @Method 설명 : 따로 있던 아이디로 검색과 이름으로 검색을 하나로 통합했음.
	 *
	-->
	<table class="search_box">
		<tr>
			<th style="width: 8%;">
			<select id="select">
				<option value="selectId" <c:if test="${searchId != ''}">selected="selected"</c:if>>아이디로 검색</option>
				<option value="selectName" <c:if test="${searchName != ''}">selected="selected"</c:if>>이름으로 검색</option>
			</select>
			</th>
			<td style="width:15%;"><input type="text" id="searchIdName" <c:choose>
			<c:when test="${searchId != '' }">value="${searchId }"</c:when>
			<c:when test="${searchName != '' }">value="${searchName }"</c:when>
	</c:choose>></td>
			<td class="td_search" colspan="2"><button class="btn_search" onclick="search()">검색</button>
		</tr>
		<!-- <tr>
			<th style="width:6%;">이름으로 검색</th>
			<td style="width:15%;"><input type="text" id="searchName"></td>
			<td class="td_search" colspan="2"><button class="btn_search" onclick="search()">검색</button>
		</tr> -->
	</table>
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
				<th>아이디&nbsp;<img class="arrow desc user_id" src="/resources/segroup/society/edu/image/main/triangle_down.png;" onclick="order_change('user_id', this)"></th>
				<th>가입일</th>
				<th>이름&nbsp;<img class="arrow desc user_nm" src="/resources/segroup/society/edu/image/main/triangle_down.png;" onclick="order_change('user_nm', this)"></th>
				<th>전화번호</th>
				<th>이메일</th>
				<th>생년월일&nbsp;<img class="arrow desc user_birth" src="/resources/segroup/society/edu/image/main/triangle_down.png;" onclick="order_change('user_birth', this)"></th>
				<th>성별&nbsp;<img class="arrow desc user_sex" src="/resources/segroup/society/edu/image/main/triangle_down.png;" onclick="order_change('user_sex', this)"></th>
				<th>회원 종류</th>
				<th>회원 상태</th>
				<th>비고</th>
				<th>탈퇴</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="data" items="${userList }" varStatus="stat">
				<c:set var="phone" value="${data.user_phone }"/>
				<input type="hidden" class="hiddenClass" value="${data.user_id }" />
				<tr>
					<td>${map.count - ((map.adminPager.curPage - 1) * (map.adminPager.pageBegin-1) + stat.index)}</td>
					<td>${data.user_id }</td>
					<td>${fn:substring(data.user_ins_dt,0,11)}</td>
					<td>${data.user_nm }</td>
					<td>${fn:substring(phone,0,3) }-${fn:substring(phone,3,7) }-${fn:substring(phone,7,11) }</td>
					<td>${data.user_email }</td> 
					<td>${data.user_birth }</td>
					<td><code value="${data.user_sex }"></code></td>
					<td><code value="${data.user_flag }"></code></td>
					<td><code value="${data.user_state }"></code></td>
					<td><a href="javascript:toUpdateForm('${data.user_id}')" class="updateClass">수정하기</a></td>
					<td><a href="javascript:deleteUser('${data.user_id}')">회원탈퇴</a></td>
				</tr>
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
		<li><input type="button" onclick="javascript:ilist('1','')" name="" value="<<"></li>
	</c:if>
	
	<!-- **이전페이지 블록으로 이동 : 현재 페이지 블럭이 1보다 크면 [이전]하이퍼링크를 화면에 출력 -->
	<c:if test="${map.adminPager.curBlock > 1}">
		<li><input type="button" onclick="javascript:ilist('${map.adminPager.prevPage}','')" name="" value="<"></li>
	</c:if>
	
	<!-- **하나의 블럭에서 반복문 수행 시작페이지부터 끝페이지까지 -->
	<c:forEach var="num" begin="${map.adminPager.blockBegin}" end="${map.adminPager.blockEnd}">
		<!-- **현재페이지이면 하이퍼링크 제거 -->
		<c:choose>
			<c:when test="${num == map.adminPager.curPage}">
				<li><input type="button" style="color: red"name="" value="${num}"></li>
			</c:when>
			<c:otherwise>
				<li><input type="button" onclick="javascript:ilist('${num}','')" name="" value="${num}"></li>
			</c:otherwise>
		</c:choose>
	</c:forEach>
	
	<!-- **다음페이지 블록으로 이동 : 현재 페이지 블럭이 전체 페이지 블럭보다 작거나 같으면 [다음]하이퍼링크를 화면에 출력 -->
	<c:if test="${map.adminPager.curBlock <= map.adminPager.totBlock}">
		<li><input type="button" onclick="javascript:ilist('${map.adminPager.nextPage}','')" name="" value=">"></li>
	</c:if>
	
	<!-- **끝페이지로 이동 : 현재 페이지가 전체 페이지보다 작거나 같으면 [끝]하이퍼링크를 화면에 출력 -->
	<c:if test="${map.adminPager.curPage <= map.adminPager.totPage}">
		<li><input type="button" onclick="javascript:ilist('${map.adminPager.totPage}','')" name="" value=">>"></li>
	</c:if>
	</ol>
	</h4>
	</li>
	</ul>
	</span>
	</div>
</div>

<form action="/edu/admin/user_info_update_form" method="post" id="update_form">
	<input type="hidden" name="user_id" id="id" />
	<input type="hidden" name="curPage" value="${curPage}">
	<input type="hidden" name="pageCount" value="${pageCount}">
	<input type="hidden" name="orderValue" value="${orderValue}">
	<input type="hidden" name="orderType" value="${orderType}">
	<input type="hidden" name="searchName" value="${searchName}">
	<input type="hidden" name="searchId" value="${searchId}">
</form>

<form action="/edu/admin/user_info_delete" method="post" id="delete_form">
	<input type="hidden" name="user_id" id="delete_id">
</form>
</body>
</html>
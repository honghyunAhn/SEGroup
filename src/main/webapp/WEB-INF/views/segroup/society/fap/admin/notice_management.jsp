<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>    
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
<title>Bridge Job Fair</title>
<style>
.table{margin:auto; width:100%;}

.board_list_table{margin-left:auto; margin-right:auto; margin-top:30px;}
.custom_tbody{font-size:20px; padding:5px;}
</style>

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
	
$(function() {
	$("#pageSelect").change(function(){
		var pageCount = $(this).val();
		location.href="/fap/admin/notice_management?pageCount="+pageCount+"&curPage=${map.adminPager.curPage}&search_division=${map.search_division}&search_type=${map.search_type}";
	});
})

function ilist(page){
	var gubun_sel = document.getElementById("boardGubunSelect");
	var type_sel = document.getElementById("boardTypeSelect");
	var search_division = $("#boardGubunSelect option:selected").val();
	var search_type = $("#boardTypeSelect option:selected").val();
    location.href="/fap/admin/notice_management?&pageCount=${map.pageCount}&curPage="+page+"&search_division=${map.search_division}&search_type=${map.search_type}";
}

function board_content_commit(board_seq, board_nm, board_detail_gb){
	var boardForm = $("#boardForm");
	
	boardForm.attr("method", "post");
	$("input[name=board_seq]").attr("value", board_seq);
	$("input[name=board_nm]").attr("value", board_nm);
	$("input[name=board_detail_gb]").attr("value", board_detail_gb);
	boardForm.attr("action", "/fap/admin/open_job_info_list");	
	
	boardForm.submit();
}

</script>
</head>
<body ng-app="myapp">
<%@include file="admin_menu.jsp"%>
	<br>
	<div class="page_title">
		<h2>게시판 관리 페이지</h2>
	</div>
	<br>
 
	
<div class="custom_div">
	<table class="search_box">
		<tr>
			<%-- <th style="width:8%;">게시판 구분</th>
			<td>
				<select id="boardGubunSelect">
					<option value="">선택</option>
					<option id="A0300" selectcode value="A0300" <c:if test="${search_division == 'A0300'}">selected="selected"</c:if>></option>
					<option id="A0301" selectcode value="A0301" <c:if test="${search_division == 'A0301'}">selected="selected"</c:if>></option>
					<option id="A0302" selectcode value="A0302" <c:if test="${search_division == 'A0302'}">selected="selected"</c:if>></option>
					<option id="A0303" selectcode value="A0303" <c:if test="${search_division == 'A0303'}">selected="selected"</c:if>></option>
					<option id="A0304" selectcode value="A0304" <c:if test="${search_division == 'A0304'}">selected="selected"</c:if>></option>
					<option id="A0305" selectcode value="A0305" <c:if test="${search_division == 'A0305'}">selected="selected"</c:if>></option>
				</select>
			</td> --%>
			<th style="width:15%;">게시판 타입</th>
			<td>
				<select id="boardTypeSelect">
					<option value="">선택</option>
					<option id="A0400" selectcode value="A0400" <c:if test="${search_type == 'A0400'}">selected="selected"</c:if>></option>
					<option id="A0401" selectcode value="A0401" <c:if test="${search_type == 'A0401'}">selected="selected"</c:if>></option>
					<option id="A0402" selectcode value="A0402" <c:if test="${search_type == 'A0402'}">selected="selected"</c:if>></option>
					<option id="A0403" selectcode value="A0403" <c:if test="${search_type == 'A0403'}">selected="selected"</c:if>></option>
				</select>
			</td>
			<td class="td_search" style="text-align:center;"><button id="boardSearchBtn" class="btn_search" onclick="search()" style="width:50%;">검색</button></td>
		</tr>
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
				<th><h4>번호</h4> </th>
				<th><h4>내 &nbsp;&nbsp;&nbsp;용</h4></th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="data" items="${resultList}" varStatus="status">
			<input type="hidden" class="boardSeq" value="${borad_seq}" />
				<tr>
					<td>${map.count - ((map.adminPager.curPage - 1) * (map.adminPager.pageBegin-1) + status.index)}</td>
					<td><a onclick="board_content_commit('${data.board_seq}', '${data.board_nm}','${data.board_detail_gb}')">${data.board_nm}</a></td>
				</tr>
			</c:forEach>		
		</tbody>
	</table>
</div>
<br>
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

		
 
 	   <form  id="boardForm">	    
			<input type="hidden" name="search_division" id="${map.search_division}" />
			<input type="hidden" name="search_type" id="${map.search_type}" />
			<input type="hidden" name="curPage" value="${curPage}">
			<input type="hidden" name="pageCount" value="${pageCount}">
			<input type="hidden" name="board_nm" id="board_nm" />
			<input type="hidden" name="board_seq" id="board_seq" />
			<input type="hidden" name="board_gb" id="board_gb" />
			<input type="hidden" name="board_tp" id="board_tp" />
			<input type="hidden" name="board_detail_gb" id="board_detail_gb" />
   		</form>
   		
   		
		 
</body>
</html>
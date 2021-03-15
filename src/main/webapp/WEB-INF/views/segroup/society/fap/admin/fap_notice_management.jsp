<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="<c:url value="/resources/segroup/js/jquery-3.1.1.js" />"></script>
<script src="<c:url value="/resources/segroup/js/jquery-ui.js" />"></script>
<script src="<c:url value="/resources/segroup/js/angular.min.js" />"></script>
<!-- 페이징관련 css 시작 -->
<script src="<c:url value="/resources/segroup/society/edu/js/slidebanner.js" />"></script>
<script src="<c:url value="/resources/segroup/society/edu/js/jquery.bxslider.min.js" />"></script>
<!-- bxSlider CSS file -->
<link href="<c:url value="/resources/segroup/society/edu/css/jquery.bxslider.css" />" rel="stylesheet" />
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/segroup/society/edu/css/common.css" />">
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/segroup/society/edu/css/sub.css" />">
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/segroup/society/edu/css/main.css" />">
<!-- modal을 위한 bootstrap -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
<!-- 페이징 관련 css 끝 -->
<title>Bridge Job Fair</title>
<style>
.boardInsertDiv {
	margin-top: 20px;
	width: 9%;
	float: right;
}

#boardInsertBtn {
	width: 100%;
	height: 40px;
	font-size: 18.67px;
	color: #fff;
	border: 0;
	background: #212121;
	border-radius: 7px;
	outline: none;
	cursor: pointer;
}
</style>
</head>

<script type="text/javascript">
	
$(function() {
    $(".title").on("click", function() {
       //var board_content_seq = $(this).next(".content_seq_class").val();
       var board_content_seq = $(this).attr("id");
       $("#board_content_seq").val(board_content_seq);
       var in_id = "#board_content_in_dt_" + board_content_seq;
       var board_content_in_dt = $(in_id).text();
       $("#board_content_in_dt").val(board_content_in_dt);
       var ud_id = "#board_content_ud_dt_" + board_content_seq;
       var board_content_ud_dt = $(ud_id).text();
       $("#board_content_ud_dt").val(board_content_ud_dt);
       $("#boardForm").submit();
    });

    $("#boardInsertBtn").on("click", function() {
       $("#boardInsertForm").submit();
    });
 })


/* 페이징 처리 함수 */
function ilist(page){
		
	var f = document.createElement("form"); 
	f.setAttribute("method","post"); 
	f.setAttribute("action","/fap/admin/fap_notice_management"); 
	document.body.appendChild(f); 

	var i = document.createElement("input"); 
	i.setAttribute("type","hidden"); 
	i.setAttribute("name","page"); 
	i.setAttribute("value", page); 
	f.appendChild(i); 

	var i2 = document.createElement("input");
	i2.setAttribute("type","hidden"); 
	i2.setAttribute("name","board_seq"); 
	i2.setAttribute("value", "${board_seq}"); 
	f.appendChild(i2); 
	
	f.submit(); // form 태그 서브밋 실행

}
	
$(function() {
	$("#pageSelect").change(function(){
		var pageCount = $(this).val();
		//location.href="${path}/edu/admin/board_contents_search?pageCount="+pageCount+"&curPage=${map.adminPager.curPage}&search_division=${map.search_division}&search_type=${map.search_type}";
		
		var f = document.createElement("form"); 
		f.setAttribute("method","post"); 
		f.setAttribute("action","/fap/admin/fap_notice_management"); 
		document.body.appendChild(f); 

		var i = document.createElement("input"); 
		i.setAttribute("type","hidden"); 
		i.setAttribute("name","page"); 
		i.setAttribute("value", "${map.adminPager.curPage}"); 
		f.appendChild(i); 

		var i2 = document.createElement("input");
		i2.setAttribute("type","hidden"); 
		i2.setAttribute("name","board_seq"); 
		i2.setAttribute("value", "${board_seq}"); 
		f.appendChild(i2);
		
		var i3 = document.createElement("input");
		i3.setAttribute("type","hidden"); 
		i3.setAttribute("name","pageCount"); 
		i3.setAttribute("value", pageCount); 
		f.appendChild(i3); 
		
		f.submit(); // form 태그 서브밋 실행
		
		});
	});
	
	var myApp = angular.module('myapp', []);
	
	myApp.controller('MainController', ['$scope','$compile', '$http', function($scope, $compile, $http) {
		
		var notice_list = '${notice_list}';
		console.log(notice_list);
		$scope.notice_list = notice_list;

		// 삭제 버튼
		$scope.delete_notice = function(seq){
			var delete_check = confirm("정말 삭제하시겠습니까?");
			if(delete_check){
				alert("삭제");
				// $http로 삭제 처리
			}else{
				alert("취소");
			}
		};
		
		// 공지사항 읽기
		$scope.read_notice = function (seq) {
			alert(seq);
		}
		
	}]);
	
	function read_notice(seq) {
		alert(seq);
	}
	
	function icon_pd_update() {
		alert("Hi");
	}
	
	

</script>
<body ng-app="myapp" ng-controller="MainController">
<%@include file="admin_menu.jsp"%>
	<button  class="btn btn-primary" data-toggle="modal" data-target="#myModal">갱신 표시 기간 설정</button>
	
	<!-- The Modal -->
	<div class="modal" id="myModal">
		<div class="modal-dialog">
			<div class="modal-content">
    
      			<!-- Modal Header -->
				<div class="modal-header">
					<h4 class="modal-title">갱신 표시 기간 설정</h4>
					<button type="button" class="close" data-dismiss="modal">&times;</button>
				</div>

				<!-- Modal body -->
				<div id="board_icon_pd" class="modal-body">
           			 등록, 수정일 기준으로 표시 기간을 정하실 수 있습니다. <br><br>
					<!-- <input class="test" type="radio" name="icon_pd" value="1"> 등록, 수정일 기준 1일 <input class="test" type="radio" name="icon_pd" value="2"> 등록, 수정일 기준 2일 <br>
					<input class="test" type="radio" name="icon_pd" value="3" checked="checked"> 등록, 수정일 기준 3일 <input class="test" type="radio" name="icon_pd" value="4"> 등록, 수정일 기준 4일 <br>
					<input class="test" type="radio" name="icon_pd" value="5"> 등록, 수정일 기준 5일 <input class="test" type="radio" name="icon_pd" value="7"> 등록, 수정일 기준 7일 <br>
					<input class="test" type="radio" name="icon_pd" value="10"> 등록, 수정일 기준 10일 <input class="test" type="radio" name="icon_pd" value="15"> 등록, 수정일 기준 15일 <br> -->
					<input type="radio" ng-model="icon_pd" value="1" id="board_icon_pd_1">
					<label for="board_icon_pd_1">등록, 수정일 기준 1일</label>
					<input type="radio" ng-model="icon_pd" value="2" id="board_icon_pd_2">
					<label for="board_icon_pd_2">등록, 수정일 기준 2일</label> <br>
					<input type="radio" ng-model="icon_pd" value="3" id="board_icon_pd_3">
					<label for="board_icon_pd_3">등록, 수정일 기준 3일</label>
					<input type="radio" ng-model="icon_pd" value="4" id="board_icon_pd_4">
					<label for="board_icon_pd_4">등록, 수정일 기준 4일</label> <br>
					<input type="radio" ng-model="icon_pd" value="5" id="board_icon_pd_5">
					<label for="board_icon_pd_5">등록, 수정일 기준 5일</label>
					<input type="radio" ng-model="icon_pd" value="7" id="board_icon_pd_7">
					<label for="board_icon_pd_7">등록, 수정일 기준 7일</label> <br>
					<input type="radio" ng-model="icon_pd" value="10" id="board_icon_pd_10">
					<label for="board_icon_pd_10">등록, 수정일 기준 10일</label>
					<input type="radio" ng-model="icon_pd" value="15" id="board_icon_pd_15">
					<label for="board_icon_pd_15">등록, 수정일 기준 15일</label> <br>
				</div>

				<!-- Modal footer -->
				<div class="modal-footer">
					<button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
					<button type="button" class="btn btn-success" data-dismiss="modal" onclick="icon_pd_update()">OK</button>
				</div>
  
			</div>
		</div>
	</div>
	  
	<div class="page_title">
		<h2>게시판 관리 페이지</h2>
		<h5>
            <a href="/fap/admin/notice_management#${search_division},${search_type}">게시판 관리 페이지</a>
			&nbsp;&nbsp;&gt;&nbsp;&nbsp;
			<a href="#" onclick="history.go(0)">${boardGroup.board_nm}</a>
		</h5>
	</div>
	<div id="custom_div" style="width: 80%; margin-left: 120px; margin-top: 20px;">
	
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
	
		<table class="table" style="text-align: center;">
			<colgroup>
				<col width="5%" />
				<col width="35%" />
				<col width="15%" />
				<col width="5%" />
				<col width="20%" />
				<col width="20%" />
			</colgroup>
			<thead>
				<tr>
					<th style="text-align: center;" scope="col">번호</th>
					<th style="text-align: center;" scope="col">제 목</th>
					<th style="text-align: center;" scope="col">작성자</th>
					<th style="text-align: center;" scope="col">조회수</th>
					<th style="text-align: center;" scope="col">작성일</th>
					<th style="text-align: center;" scope="col">수정일</th>
				</tr>
			</thead>
			<tbody class="custom_tbody">
				<c:forEach var="data" items="${contentList }" varStatus="status">
					<tr>
						<td style="text-align: center;">${map.count - ((map.adminPager.curPage - 1) * (map.adminPager.pageBegin-1) + status.index)}</td>
						<td>
							<a class="title" id="${data.board_content_seq}">${data.board_content_title}</a>
						</td>
						<td style="text-align: center;">${data.board_content_nm }</td>
						<td style="text-align: center;">${data.board_content_hit }</td>
						<td style="text-align: center;" id='board_content_in_dt_${data.board_content_seq}'>${data.board_content_ins_dt}</td>
						<td style="text-align: center;" id='board_content_ud_dt_${data.board_content_seq}'>${data.board_content_udt_dt}</td>
					</tr>
					<input type="hidden" class="content_seq_class" value="${data.board_content_seq }" />
				</c:forEach>
			</tbody>
		</table>
		<div class="boardInsertDiv">
			<input type="button" id="boardInsertBtn" value="등록하기">
		</div>
	</div>
	<form action="/fap/admin/notice_contents_detail" method="get" id="boardForm">
		<input type="hidden" name="search_division" id="search_division" value="${search_division}" />
		<input type="hidden" name="search_type" id="search_type" value="${search_type}" />
		<input type="hidden" name="board_content_seq" id="board_content_seq" />
		<input type="hidden" name="board_nm" id="board_nm" value="${boardGroup.board_nm}" />
        <input type="hidden" name="board_seq" id="board_seq" value="${boardGroup.board_seq }" />
        <input type="hidden" name="board_gb" id="board_gb" value="${boardGroup.board_gb}"/>
        <input type="hidden" name="board_tp" id="board_tp" value="${boardGroup.board_tp}"/>
		<input type="hidden" name="board_ud_dt" id="board_content_ud_dt" />
	</form>
	<form action="/fap/admin/notice_insert_form" method="get" id="boardInsertForm">
		<input type="hidden" name="search_division" id="search_division" value="${search_division}" />
		<input type="hidden" name="search_type" id="search_type" value="${search_type}" />
		<input type="hidden" name="board_nm" id="board_nm" value="${boardGroup.board_nm}" />
        <input type="hidden" name="board_seq" id="board_seq" value="${boardGroup.board_seq }" />
        <input type="hidden" name="board_gb" id="board_gb" value="${boardGroup.board_gb}"/>
        <input type="hidden" name="board_tp" id="board_tp" value="${boardGroup.board_tp}"/>
	</form>
	
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
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
</body>
</html>
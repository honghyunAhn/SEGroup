<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="<c:url value="/resources/segroup/js/jquery-3.1.1.js" />"></script>
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
<title>글로벌 엔지니어 양성</title>
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
		f.setAttribute("action","/edu/admin/board_contents_search"); 
		document.body.appendChild(f); 

		var i = document.createElement("input"); 
		i.setAttribute("type","hidden"); 
		i.setAttribute("name","page"); 
		i.setAttribute("value", page); 
		f.appendChild(i); 

		var i2 = document.createElement("input");
		i2.setAttribute("type","hidden"); 
		i2.setAttribute("name","board_seq"); 
		i2.setAttribute("value", ${board_seq}); 
		f.appendChild(i2); 
		
		f.submit(); // form 태그 서브밋 실행

	}
		
	$(function() {
		$("#pageSelect").change(function(){
			var pageCount = $(this).val();
			//location.href="${path}/edu/admin/board_contents_search?pageCount="+pageCount+"&curPage=${map.adminPager.curPage}&search_division=${map.search_division}&search_type=${map.search_type}";
			
			var f = document.createElement("form"); 
			f.setAttribute("method","post"); 
			f.setAttribute("action","/edu/admin/board_contents_search"); 
			document.body.appendChild(f); 

			var i = document.createElement("input"); 
			i.setAttribute("type","hidden"); 
			i.setAttribute("name","page"); 
			i.setAttribute("value", ${map.adminPager.curPage}); 
			f.appendChild(i); 

			var i2 = document.createElement("input");
			i2.setAttribute("type","hidden"); 
			i2.setAttribute("name","board_seq"); 
			i2.setAttribute("value", ${board_seq}); 
			f.appendChild(i2);
			
			var i3 = document.createElement("input");
			i3.setAttribute("type","hidden"); 
			i3.setAttribute("name","pageCount"); 
			i3.setAttribute("value", pageCount); 
			f.appendChild(i3); 
			
			f.submit(); // form 태그 서브밋 실행
			
		
		
		});
	})
	
	
	
</script>
</head>
<body>
	<%@include file="admin_menu.jsp"%>
	<div class="page_title">
		<h2>게시판 관리 페이지</h2>
		<h5>
            <a href="/edu/admin/board_manager_form#${search_division},${search_type}">게시판 관리 페이지</a>
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
	<form action="/edu/admin/board_contents_detail" method="post" id="boardForm">
		<input type="hidden" name="search_division" id="search_division" value="${search_division}" />
		<input type="hidden" name="search_type" id="search_type" value="${search_type}" />
		<input type="hidden" name="board_content_seq" id="board_content_seq" />
		<input type="hidden" name="board_nm" id="board_nm" value="${boardGroup.board_nm}" />
        <input type="hidden" name="board_seq" id="board_seq" value="${boardGroup.board_seq }" />
        <input type="hidden" name="board_gb" id="board_gb" value="${boardGroup.board_gb}"/>
        <input type="hidden" name="board_tp" id="board_tp" value="${boardGroup.board_tp}"/>
		<input type="hidden" name="board_ud_dt" id="board_content_ud_dt" />
	</form>
	<form action="/edu/admin/board_contents_insert_form" method="post" id="boardInsertForm">
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
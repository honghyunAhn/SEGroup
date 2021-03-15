<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="<c:url value="/resources/segroup/js/jquery-3.1.1.js" />"></script>
<script src="<c:url value="/resources/segroup/society/edu/js/admin_menu.js" />"></script>
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/segroup/society/edu/css/admin_menu.css" />">
<title>글로벌 엔지니어 양성</title>
<style>
a:link, a:visited {
	text-decoration: none;
}

.board_list {
	width: 100%;
	border-top: 2px solid #252525;
	border-bottom: 1px solid #ccc
}

.board_list thead th:first-child {
	background-image: none
}

.board_list thead th {
	border-bottom: 1px solid #ccc;
	padding: 12px 0 13px 0;
	color: #3b3a3a;
	vertical-align: middle
}

.board_list tbody td {
	border-top: 1px solid #ccc;
	padding: 10px 0;
	text-align: center;
	vertical-align: middle
}

.board_list tbody tr:first-child td {
	border: none
}

.board_list tbody td.title {
	text-align: left;
	padding-left: 20px
}

.board_list tbody td a {
	display: inline-block
}

.board_view {
	width: 80%;
	margin: auto;
	border-top: 2px solid #252525;
	border-bottom: 1px solid #ccc
}

.board_view tbody th {
	text-align: left;
	background: #D8D8D8;
	color: #3b3a3a
}

.board_view tbody th.list_tit {
	font-size: 13px;
	color: #000;
	letter-spacing: 0.1px
}

.board_view tbody .no_line_b th, .board_view tbody .no_line_b td {
	border-bottom: none
}

.board_view tbody th, .board_view tbody td {
	padding: 15px 0 16px 16px;
	border-bottom: 1px solid #ccc
}

.board_view tbody td.view_text {
	border-top: 1px solid #ccc;
	border-bottom: 1px solid #ccc;
	padding-top: 10px;
	padding-bottom: 10px;
	padding-left: 0px;
}

.board_view tbody th.th_file {
	padding: 0 0 0 15px;
	vertical-align: middle
}

.wdp_90 {
	width: 90%
}

.boardManagerDiv {
	margin-top: 20px;
	margin-right: 8%;
	margin-bottom: 6%;
	width: 30%;
	float: right;
}

#boardDeleteBtn, #boardUpdateBtn, #boardManagerBtn {
	display: inline-block;
	width: 30%;
	height: 40px;
	font-size: 18.67px;
	color: #fff;
	border: 0;
	background: #212121;
	border-radius: 7px;
	outline: none;
	cursor: pointer;
}

.page_title, .page_sub_title {
	margin-left: 10%;
	margin-top: 20px;
}

#view_text_div {
	width: 100%;
}
</style>
<script type="text/javascript">
	$(function() {
		// 삭제하기
		$("#boardDeleteBtn").on("click", function() {
			if (confirm("삭제하시겠습니까?")) {
				$("#boardHiddenForm_delete").submit();
			}
			return false;
		});
		//수정하기
		$("#boardUpdateBtn").on("click", function() {
			$("#boardHiddenForm_update").submit();
		});
		//목록으로
		$("#boardManagerBtn").on("click", function() {
			$("#boardHiddenManagerForm").submit();
		});
	})
	function gotolist() {
		$("#boardHiddenManagerForm").submit();
	}
</script>
<style type="text/css">
.boardImage{
	width: 300px;
}
</style>
</head>
<body>

	<%@include file="admin_menu.jsp"%>
	<div class="page_title">
		<h2>게시판 관리 페이지</h2>
		<h5>
            <a href="/edu/admin/board_manager_form#${search_division},${search_type}">게시판 관리 페이지</a>
			&nbsp;&nbsp;&gt;&nbsp;&nbsp;<a href="#none" onclick="gotolist()">${boardGroup.board_nm}</a>
			&nbsp;&nbsp;&gt;&nbsp;&nbsp;<a href="#" onclick="history.go(0)">게시글 상세</a>
		</h5>
	</div>
	<table class="board_view">
		<colgroup>
		<col width="15%"/>
		<col width="35%"/>
		<col width="15%"/>
		<col width="35%"/>
		</colgroup>
		<tbody>
		    <tr>
		        <th scope="row">글 번호</th>
		        <td>
		            ${contentDetail.board_content_seq}
				</td>
			<th scope="row">조회수</th>
			<td>${contentDetail.board_content_hit }</td>
		</tr>
		<tr>
		    <th scope="row">작성자</th>
		    <td>${contentDetail.board_content_nm }</td>
			<th scope="row">수정일</th>
			<td>${boardGroup.board_ud_dt}</td>
		</tr>
		<tr>
		    <th scope="row">첨부파일</th>
		    <td colspan="3">
		    <c:forEach var="data" items="${contentDetail.fileList }" varStatus="status">
				원본 : ${data.board_file_origin }
				<%-- <img class="boardImage" alt="" src="/file_download?origin=${data.board_file_origin }&saved=${data.board_file_saved }&path=${path }"> <br/> --%>
				<img class="boardImage" alt="" src="${path }/${data.board_file_saved }"> <br/>
			</c:forEach>
		    </td>
		</tr>
		<tr>
		    <th scope="row">제목</th>
		    <td colspan="3">
		        ${contentDetail.board_content_title }
		    </td>
		</tr>
		<tr>
		    <td colspan="4" class="view_text">
				<div id="view_text_div">
					${contentDetail.board_content_ct }
				</div>
		    </td>
		</tr>
		</tbody>
	</table>
		
	<div class="boardManagerDiv">
        <input type="button" id="boardDeleteBtn" value="삭제하기" />
		<input type="button" id="boardUpdateBtn" value="수정하기" />
		<input type="button" id="boardManagerBtn" value="목록으로" />
	</div>
	<form action="/edu/admin/board_contents_search" id="boardHiddenManagerForm" method="post">
		<input type="hidden" name="search_division" id="search_division" value="${search_division}" />
		<input type="hidden" name="search_type" id="search_type" value="${search_type}" />
		<input type="hidden" name="board_seq" id="board_seq" value="${contentDetail.board_seq}"/>
		<input type="hidden" name="board_nm" id="board_nm" value="${boardGroup.board_nm}"/>
        <input type="hidden" name="board_seq" id="board_seq" value="${boardGroup.board_seq }" />
        <input type="hidden" name="board_gb" id="board_gb" value="${boardGroup.board_gb}"/>
        <input type="hidden" name="board_tp" id="board_tp" value="${boardGroup.board_tp}"/>
	</form>
    <form action="/edu/admin/board_contents_update_form" id="boardHiddenForm_update" method="post">
        <input type="hidden" name="search_division" id="search_division" value="${search_division}" />
        <input type="hidden" name="search_type" id="search_type" value="${search_type}" />
        <input type="hidden" name="board_nm" id="board_nm" value="${boardGroup.board_nm}"/>
        <input type="hidden" name="board_seq" id="board_seq" value="${boardGroup.board_seq }" />
        <input type="hidden" name="board_gb" id="board_gb" value="${boardGroup.board_gb}"/>
        <input type="hidden" name="board_tp" id="board_tp" value="${boardGroup.board_tp}"/>
        <input type="hidden" name="board_content_seq" value="${contentDetail.board_content_seq }" />
    </form>
    <form action="/edu/admin/board_contents_delete" id="boardHiddenForm_delete" method="post">
        <input type="hidden" name="search_division" id="search_division" value="${search_division}" />
        <input type="hidden" name="search_type" id="search_type" value="${search_type}" />
        <input type="hidden" name="board_nm" id="board_nm" value="${boardGroup.board_nm}"/>
        <input type="hidden" name="board_seq" id="board_seq" value="${boardGroup.board_seq }" />
        <input type="hidden" name="board_gb" id="board_gb" value="${boardGroup.board_gb}"/>
        <input type="hidden" name="board_tp" id="board_tp" value="${boardGroup.board_tp}"/>
        <input type="hidden" name="board_content_seq" value="${contentDetail.board_content_seq }" />
    </form>
</body>
</html>
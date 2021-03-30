<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="<c:url value="/resources/segroup/js/jquery-3.1.1.js" />"></script>
<script src="<c:url value="/resources/segroup/society/edu/js/admin_menu.js" />"></script>
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/segroup/society/edu/css/admin_menu.css" />">

<link rel="stylesheet" type="text/css" href="<c:url value="/resources/segroup/society/fap/css/default.css" />" />
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/segroup/society/fap/css/backgroundTransition.css" />" />
<link type="text/css" rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto:400,500">
<link type="text/css" rel="stylesheet" href="<c:url value="/resources/segroup/society/fap/css/popModal.css" />">
<link type="text/css" rel="stylesheet" href="<c:url value="/resources/segroup/society/fap/css/lightslider.css" />" />
<title>Bridge Job Fair</title>

<script type="text/javascript">
	$(function() {
		//메인으로
		$("#boardMainBtn").on("click", function() {
			location.href="/fap/user/user_main"
		});
		//목록으로
		$("#boardListBtn").on("click", function() {
			location.href="/fap/user/user_board_content_list?board=same_board&board_detail_gb=${contentDetail.board_detail_gb}"
		});
	})
</script>
</head>
<body>
	<%@include file="user_menu.jsp"%><%@include file="user_quick_menu.jsp"%>
<div class="join-wrap">
	<div id="subcontents">	    
		 <h1>
			<c:if test = "${contentDetail.board_detail_gb =='A1700'}"><spring:message code="fap.main_menu.notice" /></c:if>
			<c:if test = "${contentDetail.board_detail_gb =='A1701'}"><spring:message code="fap.main_menu.jobinfo" /></c:if> 
		</h1>
	  
		<div class="joinBox">
		<table class="board_view">
		<colgroup>
		<col width="15%"/>
		<col width="35%"/>
		<col width="15%"/>
		<col width="35%"/>
		</colgroup>
		<tbody>
		    <tr>
		        <th scope="row"><spring:message code="fap.jobfair.main.board.no" /></th>
		        <td>
		            ${contentDetail.board_content_seq}
				</td>
			<%-- <th scope="row"><spring:message code="fap.jobfair.main.board.id" /></th>
			<td>${contentDetail.board_content_nm }</td> --%>
			  <th scope="row"><spring:message code="fap.jobfair.main.board.indate" /></th>
		    <td>${contentDetail.board_content_udt_dt}</td>
		</tr>
		<tr>
		    <th scope="row"><spring:message code="fap.jobfair.main.board.title" /></th>
		    <td colspan="3">
		        ${contentDetail.board_content_title }
		    </td>
		</tr>
		<tr>
		    <td colspan="4" class="view_text">
				<div id="view_text_div" style="min-height:400px;">
					${contentDetail.board_content_ct }
				</div>
		    </td>
		</tr>
		<tr>
			<th scope="row"><spring:message code="fap.jobfair.main.board.file" /></th>
			<td colspan="3">
				 <c:forEach var="data" items="${contentDetail.fileList }" varStatus="status">
					<a href="/file_download?origin=${data.board_file_origin }&saved=${data.board_file_saved }&path=/fap/admin/notice_file/">${data.board_file_origin }</a><br>
				</c:forEach>
			</td>
		</tr>
		</tbody>
		
	</table>
		
	<div class="boardManagerDiv">
		<button id="boardListBtn"><spring:message code="fap.jobfair.main.board.list" /></button>
		<button id="boardMainBtn"><spring:message code="fap.jobfair.main.board.main" /></button>
	</div>
	<br><br><br><br>
</div>
</div>
</div>
	
	<%@include file="../common_footer_fap.jsp"%>
</body>
</html>
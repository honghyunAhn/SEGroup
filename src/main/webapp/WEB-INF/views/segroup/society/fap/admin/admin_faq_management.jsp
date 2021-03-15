<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<script src="<c:url value="/resources/segroup/js/jquery-3.1.1.js" />"></script>
<script src="<c:url value="/resources/segroup/js/jquery-ui.js" />"></script>
<script src="<c:url value="/resources/segroup/js/angular.min.js" />"></script>
<script src="<c:url value="/resources/segroup/js/datepicker.js" />"></script>

<!-- 추가한 css -->
<link rel="stylesheet" type="text/css" href="/resources/segroup/society/fap/css/default.css" />
<link type="text/css" rel="stylesheet" href="/resources/segroup/society/fap/css/popModal.css">
<title>Bridge Job Fair</title>

</head>
<body>
	<%@include file="admin_menu.jsp"%> 
	<br>
	<div class="page_title">
		<h2>FAQ 관리 페이지</h2>
	</div>
	<br>		 
		<div>
			<table>
				<thead>
					<tr>
						<th>
							번호
						</th>
						<th>
							제목
						</th>
						<th>
						</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="item" items="${faqList }" varStatus="status">
						<tr>
							<td>${status.index + 1 }</td>
							<td>
								<a href="/fap/admin/admin_faq_update_form?consulting_seq=${item.consulting_seq }">${item.consulting_title }</a>
							</td>
							<td>
								<a href="/fap/admin/admin_faq_delete?consulting_seq=${item.consulting_seq }">삭제</a>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		
		</div>
		
		<a href="/fap/admin/admin_faq_insert_form">faq등록</a>
		
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="<c:url value="/resources/segroup/js/jquery-3.1.1.js" />"></script>
<title>Bridge Job Fair</title>
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/segroup/society/fap/css/default.css" />" />
</head>

<body>
<%@include file="company_menu.jsp"%>
<div class="join-wrap">
	<div id="subcontents">
		<img src="<c:url value="/resources/segroup/society/fap/images/roadmap.png" />">
	</div>

</div>

<%@include file="../common_footer_fap.jsp"%>
</body>
</html>
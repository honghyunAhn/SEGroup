<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Bridge Job Fair</title>
</head>
<body>
	<div id="wrapper">
		<%@include file="company_menu.jsp"%>
		<h1><spring:message code="com.login.locked" /></h1>
	</div>
	<%@include file="../common_footer_fap.jsp"%>
</body>
</html>
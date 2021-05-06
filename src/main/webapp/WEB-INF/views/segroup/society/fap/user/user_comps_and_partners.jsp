<%@ page language="java" contentType="text/html; charset=UTF-8"    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="https://kit.fontawesome.com/f4ead7948d.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">	
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<meta property="og:type" content="website">
<meta property="og:title" content="Soft Engineer Society">
<meta property="og:image" content="http://www.softsociety.net/edu/apply/ckeditor/ses_main_image.png">
<script src="<c:url value="/resources/segroup/js/jquery-3.1.1.js" />"></script>
<script src="<c:url value="/resources/segroup/js/angular.min.js" />"></script> 
<script src="<c:url value="/resources/segroup/society/fap/js/swiper.js" />" charset="utf-8"></script>
<script src="<c:url value="/resources/segroup/society/fap/js/index.js" />"  charset="utf-8"></script>
<title>Bridge Job Fair</title>
    <link rel="stylesheet" href="<c:url value="/resources/segroup/society/fap/css/main.header.css" />">
	<link rel="stylesheet" href="<c:url value="/resources/segroup/society/fap/css/all.css" />">
	<link rel="stylesheet" href="<c:url value="/resources/segroup/society/fap/css/reset.css" />">
	<link rel="stylesheet" href="<c:url value="/resources/segroup/society/fap/css/swiper.min.css" />">
</head>
<body>
<%@include file="user_menu.jsp"%><%@include file="user_quick_menu.jsp"%>
	<div align="center">
		<spring:message code="fap.comp_partner" />
	</div>
 <%@include file="../common_footer_fap.jsp"%>
</body>
</html>
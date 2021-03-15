<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Bridge JOB Fair 지원 방법</title>
<script src="<c:url value="/resources/segroup/js/jquery-3.1.1.js" />"></script>
	<script src="<c:url value="/resources/segroup/js/angular.min.js" />"></script> 
	<script src="<c:url value="/resources/segroup/society/fap/js/swiper.js" />" charset="utf-8"></script>
    <script src="<c:url value="/resources/segroup/society/fap/js/index.js" />"  charset="utf-8"></script>
	<script type="text/javascript" src="<c:url value="/resources/segroup/society/fap/js/lightslider.js" />"></script>
	<link type="text/css" rel="stylesheet" href="<c:url value="/resources/segroup/society/fap/css/lightslider.css" />" />
	<link type="text/css" rel="stylesheet" href="<c:url value="/resources/segroup/society/fap/css/popModal.css" />">
    <link rel="stylesheet" href="<c:url value="/resources/segroup/society/fap/css/main.header.css" />">
	<link rel="stylesheet" href="<c:url value="/resources/segroup/society/fap/css/all.css" />">
	<link rel="stylesheet" href="<c:url value="/resources/segroup/society/fap/css/reset.css" />">
	<link rel="stylesheet" href="<c:url value="/resources/segroup/society/fap/css/swiper.min.css" />">
	<link rel="stylesheet" href="<c:url value="/resources/segroup/society/fap/css/index.css" />">
    <link rel="stylesheet" href="<c:url value="/resources/segroup/society/fap/css/common.css" />">
    <style>
        .img {
            width: 1200px;
            margin: 0 auto;
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
        }
        /* 참가프로세스 */
        .img01{
            height:1220px;
            background-image: url('http://www.softsociety.net/edu/apply/ckeditor/2019090602.jpg');
        }
        /* 온라인지원방법 */
        .img02{
            margin-top: 200px;
            height:5256px;
            background-image: url('http://www.softsociety.net/edu/apply/ckeditor/2019090601.jpg');
        }
    </style>
</head>
<body>
	<%@include file="user_menu.jsp"%>
    <div class="img img01"></div>
    <div class="img img02"></div>
	<%@include file="../common_footer_fap.jsp"%> 
</body>
</html>
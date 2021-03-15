<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko" class="mv-html">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport"
	content="width=device-width, target-densitydpi=medium-dpi" />
<meta name="format-detection" content="telephone=no">
<title>글로벌 엔지니어 양성</title>
<script src="<c:url value="/resources/segroup/js/jquery-3.1.1.js" />"></script>
<link rel="stylesheet" type="text/css"
	href="<c:url value="/resources/segroup/society/edu/css/common.css" />">
<link rel="stylesheet" type="text/css"
	href="<c:url value="/resources/segroup/society/edu/css/sub.css" />">
<link rel="stylesheet" type="text/css"
	href="<c:url value="/resources/segroup/society/edu/css/main.css" />">
<link rel="stylesheet" type="text/css"
	href="<c:url value="/resources/segroup/society/edu/css/join.css" />">
<script
	src="<c:url value="/resources/segroup/society/edu/js/slidebanner.js" />"></script>
<script type="text/javascript">
function closeThis(){
	 window.close();
}
</script>
</head>
<body onload="readyMain()">
	<div class="mv-wrap">
       <div class="mv-logo"></div>
       <div class="mv-text"><p>본인인증에 실패하였습니다. <br />다시 진행하여 주세요.</p></div>
       <p class="mv-button" onclick="closeThis()">닫기</p>
    </div>
</body>
</html>
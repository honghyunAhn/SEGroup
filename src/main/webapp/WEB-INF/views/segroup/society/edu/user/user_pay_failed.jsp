<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, target-densitydpi=medium-dpi" />
<meta name="format-detection" content="telephone=no">
<title>글로벌 엔지니어 양성</title>
<script src="<c:url value="/resources/segroup/js/jquery-3.1.1.js" />"></script>
<script language="javascript" type="text/javascript" src="https://stgstdpay.inicis.com/stdjs/INIStdPay.js" charset="UTF-8"></script>
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/segroup/society/edu/css/common.css" />">
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/segroup/society/edu/css/sub.css" />">
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/segroup/society/edu/css/main.css" />">
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/segroup/society/edu/css/join.css" />">
<script src="<c:url value="/resources/segroup/society/edu/js/slidebanner.js" />"></script>
<script type="text/javascript">
</script>
<style>
/* reset */
*{margin: 0; padding: 0}

html, body {
    height: 100%;
    width: 100%;
    margin: 0;
    display: table;
}
.footer {
    display: table-row;
    height: 0;
}
</style>
</head>
<body>
	<%@include file="../menu.jsp"%>
	<!-- section -->
	<section class="join_section">
		<article>
		<br><br>
			<h2>결제가 실패하였습니다.</h2><br>
			<h2>관리자에게 연락 해주세요.</h2><br>
		    <h2>02-6000-5376</h2><br>
			<h4>${errorMsg}</h4><br>
            <br><br>
            <div style="display: flex; align-items: center; justify-content: center;">
                <button class="confirms_btn" onclick="location.href='/edu/user/user_update_form'">돌아가기</button>
            </div>
		</article>
	</section>
	<!-- footer -->
	<%@include file="../footer.jsp"%>
</body>
</html>
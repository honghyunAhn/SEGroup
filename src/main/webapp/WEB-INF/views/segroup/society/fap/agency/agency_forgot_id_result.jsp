<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="<c:url value="/resources/segroup/js/jquery-3.1.1.js" />"></script>
<link type="text/css" rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto:400,500">
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/segroup/society/fap/css/default.css" />" />
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/segroup/society/fap/css/popModal.css" />" />

<link rel="stylesheet" type="text/css" href="<c:url value="/resources/segroup/society/edu/css/login.css" />">
<title>Bridge Job Fair</title>
</head>
<body>

	<%@include file="agency_menu.jsp"%>
	
	<!------------------------서브비주얼영역-------------------------->
	<div id="subvisual"><img src="<c:url value="/resources/segroup/society/fap/images/subtitlt_img5.png" />" />
		<div id="navigation"><img src="<c:url value="/resources/segroup/society/fap/images/icon_red.gif" />" /> Home > <spring:message code="fap.common.find_id" /></div>
	</div>
	<!-----------------------/서브비주얼 영역-------------------------->

	<section class="result_section">
		<div style="height:76px; "></div> <!-- 제목높이 보정용 -->
		
		<div class="login_wrap">
			<!-- 아이디 찾기 결과 -->
			<h2><spring:message code="fap.comp.pw_find_result" /></h2>
	
			<c:choose>
				<c:when test="${found == null}">
					<spring:message code="fap.comp.id_change_fail_alert" />
				</c:when>
				<c:otherwise>

					<div style="width: 100%; height: 200px; border: 1px 1px 1px 1px;">
						<!-- 찾으시는 아이디는 ** 입니다. -->
						<p><spring:message code="fap.comp.find_id_next" /> <span style="color: blue;">${found}</span><spring:message code="fap.common.basic_verb" /></p>
						
						<br><br><br>
						
						<div style="border: 1px 1px 1px 1px;">
							<!-- 로그인화면으로 -->
							<a href="/fap/agency/agency_login"><h3><spring:message code="fap.common.move_login" /></h3></a>
							<br>
						</div>	
						<div style="border: 1px 1px 1px 1px;">
							<a href="/fap/agency/agency_forgot_password"><h3><spring:message code="fap.common.find_pw" /></h3></a>
							<br><br>
						</div>	
					</div>
				</c:otherwise>
			</c:choose>
		</div>
	</section>

	<!-----------------------/서브컨텐츠 영역-------------------------->
	<%@include file="agency_footer.jsp"%>
	
</body>
</html>
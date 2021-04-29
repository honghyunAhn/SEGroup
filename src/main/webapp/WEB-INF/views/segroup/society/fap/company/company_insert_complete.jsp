<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Bridge Job Fair</title>
<script src="<c:url value="/resources/segroup/js/jquery-3.1.1.js" />"></script>
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/segroup/society/fap/css/default.css" />" />
<script type="text/javascript">
	function goMain(){
		location.href = "/fap/company/company_main";
	}

</script>
</head>
<body>
<%@include file="company_menu.jsp"%>
<div class="join-wrap">
	<div id="subcontents">
		<div id="company_insert">
			<div class="joinBox">
				<div class="jointt">
					<p class="jointxt1">
				        <spring:message code="fap.comp.insert.complete.title" />
					</p>
				</div>
				<div class="join-contents">
					<div class="joinBBS">
						<div class="join-complete-content-top">
							<spring:message code="fap.comp.insert.complete.context.top" />
						</div>
						<div class="join-complete-content-middle">
							<spring:message code="fap.comp.insert.complete.context.middle" />
						</div>
					</div>
				</div>
			</div>
			<div class="joinBox">	
				<div id="joinBtn">
					<button type="button" class="join-btn icon submitBtn" onclick="goMain()"><spring:message code="fap.comp.insert.complete.main" /></button>
				</div>
			</div>
		</div>
	</div>
</div>

<%@include file="../common_footer_fap.jsp"%>
</body>
</html>
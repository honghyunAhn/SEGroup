<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Bridge Job Fair</title>
</head>
<script src="<c:url value="/resources/segroup/js/jquery-3.1.1.js" />"></script>
<script src="<c:url value="/resources/segroup/js/angular.min.js" />"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
<script src="<c:url value="/resources/segroup/js/jquery-ui.js" />"></script>
<script src="<c:url value="/resources/segroup/js/angular.min.js" />"></script>

<link type="text/css" rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto:400,500">
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/segroup/society/fap/css/default.css" />" />
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/segroup/society/fap/css/popModal.css" />" />
<script type="text/javascript">

	function terms_agree() {
		var user_id = $('#user_id').val(); 
		$.ajax({
			beforeSend: function(xhr) {
			     xhr.setRequestHeader("AJAX", true);
			}
			, url : '/fap/agency/agency_terms_update'
			, type : 'post'
			, data : {
				user_id : user_id
			}
			, success : function(data) {
				if(data == 1){
					alert('<spring:message code="fap.err.common.privacy.policy.agree" />');
					window.location.href = '/fap/agency/agency_security_invalidate';
				}
				
			}
			, error : function(e){
				if(e.status == 403){
					alert('<spring:message code="com.login.ajaxSesstion" javaScriptEscape="true" />');
					location.href = "/fap/agency/agency_login";
				}
			}
		});
		
	}


</script>
<body>
<%@include file="agency_menu.jsp"%>

<div id="contents2">
	<div class="joinBox">
		<div class="join-policy">
			<div id="privacy-policy-check">
				<div class="privacy-policy-context">
					<spring:message code="fap.personal.security.agreement" />
				</div>
			</div>
		</div>
		<div id="joinBtn">
			<button class="join-btn icon" onclick="terms_agree()"><spring:message code="fap.common.privacy.policy_agree" /></button>
		</div>
	</div>
</div>

<input type="hidden" id="user_id" value="${user_id}">


<%@include file="agency_footer.jsp"%>
</body>
</html>
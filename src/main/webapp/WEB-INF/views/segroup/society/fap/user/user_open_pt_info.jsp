<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	 <title>Bridge Job Fair</title>
	<script src="<c:url value="/resources/segroup/js/jquery-3.1.1.js" />"></script>
	
	<link rel="stylesheet" type="text/css" href="<c:url value="/resources/segroup/society/fap/css/userDefault.css" />" />
	<link type="text/css" rel="stylesheet" href="<c:url value="/resources/segroup/society/fap/css/popModal.css" />">
	<script type="text/javascript">
		function apply_check(){
			var fap_open_pt_seq = $("#fap_open_pt_seq").val();
			var user_flag = $("#user_flag").val();
			if(user_flag == 'A0103'){
				alert('<spring:message code="fap.open_pt.join_comment" />\n<spring:message code="fap.open_com.main" />');
				location.href="/fap/company/company_main";
			}else if(user_flag == 'A0104'){
				alert('<spring:message code="fap.open_pt.join_comment" />\n<spring:message code="fap.open_com.main" />');
				location.href="/fap/agency/agency_main";
			}else{
				$.ajax({
					beforeSend: function(xhr) {
					     xhr.setRequestHeader("AJAX", true);
					},
					url : '/fap/user/user_open_pt_apply',
					type : 'post',
					data : {
						fap_open_pt_seq : fap_open_pt_seq
					},
					success : function(response){
						
						if(response == 0){
							alert('<spring:message code="fap.open_com.join_complete" />\n<spring:message code="fap.open_com.join_check" />');
						}else{
							alert('<spring:message code="fap.open_com.join_already" />\n<spring:message code="fap.open_com.join_check" />');
						}
						location.href="/fap/user/user_main";
					},
					error : function(e){
						console.log(e);
						if(e.status == 403){
							alert('<spring:message code="com.login.ajaxSesstion" javaScriptEscape="true" />');
							location.href = "/fap/user/user_login";
						}
					}
				})
			}
			
		}
		function login_check(){
			alert('<spring:message code="fap.open_com.join_login_check" />\n<spring:message code="fap.open_com.login" />');
			location.href="/fap/user/user_open_pt_info_login";
		}
		function back_main(){
			location.href="/fap/user/user_main";
		}
	</script>
	
</head>
<body>
<sec:authorize access="hasAnyRole('ROLE_A0100,ROLE_A0101,ROLE_A0102,ROLE_A0103,ROLE_A0104,ROLE_A0106')">
	<sec:authentication property="details" var="check" />
	<sec:authentication property="details.user" var="user" />
	<input type="hidden" id="user_flag" value="${user.user_flag}">
</sec:authorize>
<%@include file="user_menu.jsp"%><%@include file="user_quick_menu.jsp"%>
<div class="join-wrap">
	<div id="subcontents">
		<c:choose>
			<c:when test="${empty result }">
				<div class="open_pt_wrap">
					<div class="open_pt_empty">
						<spring:message code="fap.open_pt.empty" />
						<div class="empty_btn">
							<button class="open_pt_empty_btn" onclick="back_main()"><spring:message code="fap.open_com.main" /></button>
						</div>
					</div>
				</div>
			</c:when>
			<c:otherwise>
				<div class="open_pt_wrap">
					${result.fap_open_pt_ct }
				</div>
				<div class="open_pt_apply">
					<c:choose>
						<c:when test="${result.fap_open_pt_close_gb == 'D1202' }">
							<spring:message code="fap.open_pt.join_end" />
						</c:when>
						<c:otherwise>
							<c:choose>
								<c:when test="${empty check}">
									<c:if test="${user.user_flag != 'A0103' and user.user_flag != 'A0104'}">
										<input type="button" class="open_pt_apply_btn" value="<spring:message code="fap.open_com.join" />" onclick="login_check()">
									</c:if>
								</c:when>
								<c:otherwise>
									<c:if test="${user.user_flag != 'A0103' and user.user_flag != 'A0104'}">
										<input type="button" class="open_pt_apply_btn" value="<spring:message code="fap.open_com.join" />" onclick="apply_check()">
									</c:if>
								</c:otherwise>
							</c:choose>
							<input type="hidden" id="fap_open_pt_seq" value="${result.fap_open_pt_seq }">
						</c:otherwise>
					</c:choose>
				</div>
			</c:otherwise>
		</c:choose>
	</div>
</div>

<%@include file="../common_footer_fap.jsp"%>
<script type="text/javascript">
	$(function(){
		var user_flag = $("#user_flag").val();
		if(user_flag == 'A0103'){
			alert('<spring:message code="fap.open_pt.join_comment" />\n<spring:message code="fap.open_com.main" />');
			location.href="/fap/company/company_main";
		}else if(user_flag == 'A0104'){
			alert('<spring:message code="fap.open_pt.join_comment" />\n<spring:message code="fap.open_com.main" />');
			location.href="/fap/agency/agency_main";
		}
	})
</script>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Bridge Job Fair</title>
<script src="<c:url value="/resources/segroup/js/jquery-3.1.1.js" />"></script>
<script src="<c:url value="/resources/segroup/js/jquery-ui.js" />"></script>
<script src="<c:url value="/resources/segroup/js/angular.min.js" />"></script>
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/segroup/society/fap/css/default.css" />" />
<script type="text/javascript">

	function request_handling(fap_comp_id, handling_ck) {
		console.log(fap_comp_id);
		console.log(handling_ck);
		$.ajax({
			beforeSend: function(xhr) {
			     xhr.setRequestHeader("AJAX", true);
			}
			, url : "/fap/company/request_handling"
			, type : "post"
			, data : {
				fap_comp_id : fap_comp_id
				, handling_ck : handling_ck
			} 
			, dataType : "text"
			, success : function(data) {
				alert('<spring:message code="fap.comp.agency_connect_success_alert" />');
				location.reload();
			}
			, error : function (e) {
				if(e.status == 403){
					alert('<spring:message code="com.login.ajaxSesstion" javaScriptEscape="true" />');
					location.href = "/fap/company/company_login";
				}
			}
		}); // ajax end
		
	} // function(request_handling) end

</script>
</head>
<body>
<%@include file="company_menu.jsp"%>
<div class="join-wrap">
	<div id="subcontents">
			<h1><spring:message code="fap.comp.agency_connect_request" /></h1>
			<br>
			<h4><spring:message code="fap.comp.agency_connect_request_header" /></h4>
			<br><br>
		<div id="nuguBB5">
	       <ul class="tit5">
	       		<li class="wi1"><spring:message code="fap.comp.agency_ja_nm" /></li>
	            <li class="wi2"><spring:message code="fap.comp.agency_en_nm" /></li>
	            <li class="wi3"><spring:message code="fap.comp.agency_connect_accept" /></li>
	            <li class="wi4"><spring:message code="fap.comp.agency_connect_refusal" /></li>
	       </ul>
	   </div>
	   <div id="nuguBB6">
	   		<c:forEach var="data" items="${agency_list}">
		   		<ul class="tit6" >
		     	   <li class="wi5">${data.fap_comp_ja_nm}</li>
		           <li class="wi6">${data.fap_comp_en_nm}</li>
		           <li class="wi7"><button class="acceptBtn" onclick="request_handling('${data.fap_comp_id}', 'approval')"><spring:message code="fap.comp.agency_connect_accept" /></button></li>
		           <li class="wi8"><button class="deleteBtn" onclick="request_handling('${data.fap_comp_id}', 'refusal')"><spring:message code="fap.comp.agency_connect_refusal" /></button></li>
		       </ul>
	       </c:forEach>        
	    </div>	
	</div>
</div>
	<br><br><br>
	<%@include file="company_footer.jsp"%>
</body>
</html>
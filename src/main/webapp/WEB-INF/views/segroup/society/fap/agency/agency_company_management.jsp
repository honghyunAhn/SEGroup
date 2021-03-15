<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Bridge Job Fair</title>
</head>
<script src="<c:url value="/resources/segroup/js/jquery-3.1.1.js" />"></script>
<script src="<c:url value="/resources/segroup/js/angular.min.js" />"></script>
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/segroup/society/fap/css/default.css" />" />
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
<script type="text/javascript">

	function comp_list_ck(ck) {
		if(ck == 'approval'){
			$('#approval_list').show();
			$('#standBy_list').hide();
			$('#refusal_list').hide();
		} else if(ck == 'standBy'){
			$('#standBy_list').show();
			$('#approval_list').hide();
			$('#refusal_list').hide();
		} else if(ck == 'refusal'){
			$('#refusal_list').show();
			$('#standBy_list').hide();
			$('#approval_list').hide();
		}
	}

</script>
<style type="text/css">
	.top_div {
		width : 1182px;
		background : #eee;
		border-bottom : 1px solid #ddd;
		padding : 0 10px;
		line-height : 40px;
		font-size : 12px;
	}
</style>
<body>
<%@include file="agency_menu.jsp"%>

	<div id="subcontents">

	<h1><spring:message code="fap.agency.manage_comp" /></h1>
	<br><br>
	
	<div class="top_div">
		<input type="radio" name="option_ck" id="option_ck_approval" onclick="comp_list_ck('approval')" checked="checked">
		<label for="option_ck_approval">
			<span class="radio-span"></span><b><spring:message code="fap.agency.comp_under_control" /></b>
		</label> &nbsp;		
		<input type="radio" name="option_ck" id="option_ck_standBy" onclick="comp_list_ck('standBy')">
		<label for="option_ck_standBy">
			<span class="radio-span"></span><b><spring:message code="fap.agency.managed_comp" /></b>
		</label> &nbsp;		
		<input type="radio" name="option_ck" id="option_ck_refusal" onclick="comp_list_ck('refusal')">
		<label for="option_ck_refusal">
			<span class="radio-span"></span><b><spring:message code="fap.agency.rejected_comp" /></b>
		</label> &nbsp;
	</div>
		<br><br>
		
			<!-- 승인된 -->
			<div id="approval_list">
		    	<div id="approval_list_1">
		    		<ul class="title1">
			       		<li class="wi1"><spring:message code="fap.comp.required_no"/></li>
			            <li class="wi2"><spring:message code="fap.comp.ja_name"/></li>
			            <li class="wi3"><spring:message code="fap.comp.en_name"/></li>
			            <li class="wi4"><spring:message code="fap.agency.change_comp_info"/></li>
			            <li class="wi5"><spring:message code="fap.agency.comp_disconnect"/></li>	            
			       </ul>
		    	</div>	    	 	
		    	<div id="approval_list_2">
		    		<c:forEach var="data" items="${select_approval_comp}" varStatus="status">
			    		<ul class="title2">
				       		<li class="wi7">${status.count}</li>
				            <li class="wi8">${data.fap_comp_ja_nm}</li>
				            <li class="wi9">${data.fap_comp_en_nm}</li>
				            <li class="wi10">
				            	<form action="/fap/agency/agency_company_update_form" method="post">
									<input type="hidden" name="fap_comp_id" value="${data.fap_comp_id}">
									<input type="submit" class="compInfoUpdateBtn" value="<spring:message code="fap.agency.change_comp_info"/>">
								</form>
							</li>
				            <li class="wi11">
				            	<form action="/fap/agency/agency_company_disconnect" method="post">
									<input type="hidden" name="fap_ag_comp_connect_seq" value="${data.fap_ag_comp_connect_seq}">
									<input type="submit" class="compDisconnectBtn" value="<spring:message code="fap.agency.comp_disconnect"/>">
								</form>
							</li>
				       </ul>
				   </c:forEach>
		    	</div>	    	
	    	</div>	        	
	        	
		     <!-- 대기중인 -->
		     <div id="standBy_list" style="display: none;">
		       	<div id="standby_list_1">
		    		<ul class="title1">
			       		<li class="wi1"><spring:message code="fap.comp.required_no"/></li>
			            <li class="wi2"><spring:message code="fap.comp.ja_name"/></li>
			            <li class="wi3"><spring:message code="fap.comp.en_name"/></li>
			            <li class="wi4"><spring:message code="fap.comp.required_doc_delete"/></li>
			       </ul>
		    	</div>	
		    	<div id="standby_list_2">
		    		<c:forEach var="data" items="${select_standBy_comp}" varStatus="status">
			    		<ul class="title2">
				       		<li class="wi5">${status.count}</li>
				            <li class="wi6">${data.fap_comp_ja_nm}</li>
				            <li class="wi7">${data.fap_comp_en_nm}</li>
				            <li class="wi8">
				            	<form action="/fap/agency/agency_company_disconnect" method="post">
									<input type="hidden" name="fap_ag_comp_connect_seq" value="${data.fap_ag_comp_connect_seq}">
									<input type="submit" class="deleteBtn" value="<spring:message code="fap.comp.required_doc_delete"/>">
								</form>
							</li>
				       </ul>
				   </c:forEach>
		    	</div>
		    	<br><br><br>
	       </div>	        
	        	
	      	<!-- 거절된 -->  	
	        <div id="refusal_list" style="display: none;">       	
		       	<div id="refusal_list_1">
		    		<ul class="title1">
			       		<li class="wi1"><spring:message code="fap.comp.required_no"/></li>
			            <li class="wi2"><spring:message code="fap.comp.ja_name"/></li>
			            <li class="wi3"><spring:message code="fap.comp.en_name"/></li>
			            <li class="wi4"><spring:message code="fap.comp.required_doc_delete"/></li>
			       </ul>
		    	</div>	
		    	<div id="refusal_list_2">
		    		<c:forEach var="data" items="${select_refusal_comp}" varStatus="status">
			    		<ul class="title2">
				       		<li class="wi5">${status.count}</li>
				            <li class="wi6">${data.fap_comp_ja_nm}</li>
				            <li class="wi7">${data.fap_comp_en_nm}</li>
				            <li class="wi8">
				            	<form action="/fap/agency/agency_company_disconnect" method="post">
									<input type="hidden" name="fap_ag_comp_connect_seq" value="${data.fap_ag_comp_connect_seq}">
									<input type="submit" class="deleteBtn" value="<spring:message code="fap.comp.required_doc_delete"/>">
								</form>
							</li>
				       </ul>
				   </c:forEach>
		    	</div>
		    	<br><br><br>
	       </div>	        
	    
	 </div>   
	<br><br><br>
	<%@include file="agency_footer.jsp"%>  
</body>
</html>
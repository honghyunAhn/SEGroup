<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags"	prefix="sec"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Bridge Job Fair</title>
<script>
	$(function() {

		$('#logout').off("click").on("click", function() {
			$('#logoutForm').submit();
			return false;
		});

		$(".fap_nav li").mouseenter(function() {

			$.each($(".fap_nav li"), function(index, item) {
				var width = $(this).width();
				$(".nav-column").eq(index).width(width);
				$(".nav-column").eq(index).css("padding", "1px");
			});
			var contents = $("#menu-contents").clone().css("display", "block");

			$(this).find(".menu-area").html(contents);
		}).mouseleave(function() {
			$(this).find(".menu-area").html('');
		});

		$("#langSelect").on("change", function() {
			var lang = $(this).val();

			if (lang != "0") {
				location.href = "/fap/agency/language_change?lo=" + lang;
			}

		});
		
		var user_id = $('#user_id_ck').val();
		
		if (typeof user_id != "undefined" && user_id != "") {
			$.ajax({
				url : '/fap/agency/agency_menu_check'
				, type : 'post'
				, async : false
				, data : {
					user_id : user_id
				}
				, success : function(menu_check) {
					
					if(menu_check == "default"){
						
					} else if(menu_check == 'disconnected'){
						$('#my_page').show();
						
						$('#insert_comp_info').show();
						$('#responsible_person_info_update').show();
						$('#user_company_connect').show();
					} else if(menu_check == 'connected'){
						$('#manage_comp').show();
						$('#my_page').show();
						$('#connect_manage').show();
						
						$('#required_doc_management').show();
						$('#doc_management').show();
						$('#pay_for_cost').show();
						
						$('#comp_join').show();
						$('#comp_manage_regist').show();
						$('#manage_comp_sub').show();
						
						$('#comp_info_update').show();
						$('#responsible_person_info_update').show();
						
						$('#schedule_calendar').show();
						$('#process_schedule_calendar').show();
					}
				}
				, error : function () {
					
				}
				
			});
			
		}
	});
</script>

<script type="text/javascript">
//언어팩 컨펌
function language_chage(language){
	var flag = confirm('<spring:message code="fap.err.language_change_confirm" />');
	if(flag){
		if(language == 'ko') location.href="/fap/agency/language_change?lo=ko";
		if(language == 'ja') location.href="/fap/agency/language_change?lo=ja";
	}else{
		return;
	}
}
</script>

</head>
<body>
	<sec:authorize access="hasAnyRole('ROLE_A0104')">
		<sec:authentication property="details" var="check" />
		<sec:authentication property="details.user" var="user" />
		<input type="hidden" id="user_id_ck" value="${user.user_id}">
	</sec:authorize>
	<form id="logoutForm" action="/fap/agency/logout" method="post"
		style="display: none">
		<input type="hidden" name="${_csrf.parameterName}"
			value="${_csrf.token}" />
	</form>
	<div id="header">
	 <!-- 20-05-21 header 자식 div에 클래스"headerBackground" 부여 -->
		<div class="headerBackground">
			<ul id="infoMenu">
				<li id="chosenCompNm"><!-- 여기 아이디 바꾸지마세요. --></li>

				<c:choose>
					<c:when test="${empty check }">
						<li><a href="/fap/agency/agency_login">Login</a></li>
						<li><a href="/fap/agency/agency_insert_form">Join</a></li>
					</c:when>
					<c:otherwise>
						<li><a href="#none" id="logout">Logout</a></li>
					</c:otherwise>
				</c:choose>
				<!-- <li><a href="/fap/agency/agency_faq">FAQ</a></li> -->
				<li class="">
				<div class="dropdown">
				  <button class="langSelect">Language</button>
				  <div class="dropdown-content">
				    <a onclick="language_chage('ko');" style="color:black;">한국어(KR)</a>
				    <a onclick="language_chage('ja');" style="color:black;">日本語(JP)</a>
				  </div>
				</div>
				</li>
			</ul>
		</div>
		<div id="infoTop">
			<div id="logo">
				<a href="/fap/agency/agency_main"><img
					src="<c:url value="/resources/segroup/society/fap/images/userOpenMain/society_logo.svg" />"></a>
			</div>
			<c:choose>
				<c:when test="${not empty check}">
					<div class="wrap">
						<ul class="fap_nav">
							<li>
								<a href="/fap/agency/agency_jobfair_apply_to_attend_form"><spring:message code="fap.common.attend_jobfair" /></a>
								<div class="menu-area"></div>
							</li>
							<li>
								<a href="/fap/agency/agency_job_ad_management"><spring:message code="fap.common.manage_jobad" /></a>
								<div class="menu-area"></div>
							</li>
							<li id="schedule_calendar" style="display: none;">
								<a href="/fap/agency/agency_process_schedule_calendar"><spring:message code="fap.common.manage_job_recruit_pcs_schedule" /></a>
								<div class="menu-area"></div>
							</li>
							<li id="required_doc_management" style="display: none;">
								<a href="/fap/agency/agency_required_doc_management"><spring:message code="fap.common.manage_accepted_applicant" /></a>
								<div class="menu-area"></div>
							</li>
							<li id="manage_comp" style="display: none;">
								<a href="/fap/agency/agency_company_management"><spring:message code="fap.agency.manage_comp" /></a>
								<div class="menu-area"></div>
							</li>
							<li id="my_page" style="display: none;">
								<a href="/fap/agency/agency_user_update_form"><spring:message code="fap.common.my_page" /></a>
								<div class="menu-area"></div>
							</li>
							<!-- <li>
								<a href="sub/sub4.html"><spring:message code="fap.common.agency" /></a>
								<div class="menu-area"></div>
							</li> -->
						</ul>
					</div>
				</c:when>
			</c:choose>
		</div>
	</div>

	<div id="menu-contents">
		<div class="nav-column">
			<ul>
			</ul>
		</div>
		<div class="nav-column">
			<ul>
			</ul>
		</div>
		<div class="nav-column">
			<ul>
				<li id="process_schedule_calendar" style="display: none;">
					<a href="/fap/agency/agency_process_schedule_calendar">
						<spring:message  code="fap.common.confirm_job_recruit_pcs_schedule" />
					</a>
				</li>
				<!-- <li>
					<a href="#">
						<spring:message code="fap.common.job_recruit_pcs_schedule(japan)" />
					</a>
				</li> -->
			</ul>
		</div>
		<div class="nav-column">
			<ul>
				<li id="pay_for_cost" style="display: none;">
					<%-- <a href="#">
						<spring:message code="fap.common.pay_for_cost" />
					</a> --%>
				</li>
				<li id="doc_management" style="display: none;">
					<a href="/fap/agency/agency_required_doc_management">
						<spring:message code="fap.common.manage_accepted_doc" />
					</a>
				</li>
			</ul>
		</div>
		<div id="connect_manage" class="nav-column" style="display: none;">
			<ul>				
				<li id="comp_join" style="display:none;">
					<a href="/fap/agency/agency_company_insert">
						<spring:message code="fap.agency.comp_join" /> 
					</a>
				</li>
				<li id="comp_manage_regist" style="display:none;">
					<a href="/fap/agency/agency_company_registration">
						<spring:message code="fap.agency.comp_manage_regist" /> 
					</a>
				</li>
				<li id="manage_comp_sub" style="display:none;">
					<a href="/fap/agency/agency_company_management">
						<spring:message code="fap.agency.manage_comp" />
					</a>
				</li>				
			</ul>
		</div>
		<div class="nav-column">
			<ul>
				<li id="insert_comp_info" style="display: none;">
					<a href="/fap/agency/agency_info_insert">
					 	<spring:message code="fap.common.insert_comp_info" /> 
					</a>
				</li>
				<li id="comp_info_update" style="display: none;">
					<a href="/fap/agency/agency_update_form">
						<spring:message code="fap.common.head.title.comp_info_update" /> 
					</a>
				</li>
				<li id="responsible_person_info_update" style="display: none;">
					<a href="/fap/agency/agency_user_update_form">
						<spring:message code="fap.common.head.title.responsible_person_info_update" />
					</a>
				</li>
				<li id="user_company_connect" style="display: none;">
					<a href="/fap/agency/agency_connect_request_management">
						<spring:message code="fap.comp.responsible_person_connect" />
					</a>
				</li>			
			</ul>
		</div>
	</div>
</body>
</html>
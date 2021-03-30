<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%-- <%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%> --%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Bridge Job Fair</title>
	<%-- <script src="<c:url value="/resources/segroup/society/fap/js/lodash.js" />"></script> --%>
	<script src="<c:url value="/resources/segroup/society/edu/js/admin_menu.js" />"></script>
	<link rel="stylesheet" type="text/css" href="<c:url value="/resources/segroup/society/edu/css/admin_menu.css" />" />
	<script>
		$(function() {
			/* _logout = _.debounce(function(){
				$('#logoutForm').submit();
			},500,true); */
			
			$('#logout').off("click").on("click", function() {
				/* _logout(); */
				$('#logoutForm').submit();
				return false;
			});
	
			/* $(".fap_nav li").mouseenter(function() {
				$.each($(".fap_nav li"), function(index, item) {
					var width = $(this).width();
					$(".nav-column").eq(index).width(width);
					$(".nav-column").eq(index).css("padding", "1px");
				});
				var contents = $("#menu-contents").clone().css("display", "block");
	
				$(this).find(".menu-area").html(contents);
			}).mouseleave(function() {
				$(this).find(".menu-area").html('');
			}); */
	
			/* $("#langSelect").on("change", function() {
				var lang = $(this).val();
	
				if (lang != "0") {
					location.href = "/fap/company/language_change?lo=" + lang;
				}
			}); */
			
			<%-- var user_id = '<%=session.getAttribute("user_id") %>'; --%>
			/* var user_id = $('#user_id_ck').val();
			
			if (typeof user_id != "undefined" && user_id != "") {
				$.ajax({
					url : '/fap/company/company_menu_check'
					, type : 'post'
					, async : false
					, data : {
						user_id : user_id
					}
					, success : function(menu_check) {
						
						if(menu_check == "default"){
							
						} else if(menu_check == 'disconnected'){
							$('#my_page').show();
							$('#user_info').show();
							$('#user_company_connect').show();
							$('#user_company_insert').show();
						} else if(menu_check == 'connected'){
							$('#my_page').show();
							$('#user_info').show();
							$('#comp_info').show();
							$('#connect_request').show();
							
							$('#doc_management').show();
							$('#required_doc_management').show();
							$('#pay_for_cost').show();
							
							$('#schedule_calendar').show();
							$('#process_schedule_calendar').show();
						}
						
					}
					, error : function () {
						
					}
				});
			} */
		});
		
		//메뉴 - 채용공고 관리 이동하는 함수(post방식)
		/* function go_by_post(url) {
			var form = document.createElement("form");
		    
	        form.action = url;
	        form.method = "post";
	
			document.body.appendChild(form);
			form.submit();
		} */
		
		$.ajax({
			url : '/fap/admin/select_admin_notice_list_not_handled'
			, type : 'post'		 
			, data : {				 
			}
			, success : function(response) {	
				if(response>0){		
				$("#pushCount").show();
				$("#pushCount").append(response);		
				}
			}
			, error : function () {
				
			}
		});
	</script>
	
	<style type="text/css">
	
	</style>
</head>
<body>
	<sec:authorize access="isAuthenticated()">
		<sec:authentication property="details" var="check" />
	</sec:authorize>
	<%-- <sec:authorize access="hasAnyRole('ROLE_A0103')">
		<sec:authentication property="details" var="check" />
		<sec:authentication property="details.user" var="user" />
		<input type="hidden" id="user_id_ck" value="${user.user_id}">
	</sec:authorize> --%>
	<form id="logoutForm" action="/fap/admin/logout" method="post" style="display: none">
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
	</form>
	<%-- <div id="header">
		<div>
			<ul id="infoMenu">
				<c:choose>
					<c:when test="${empty check}">
						<li><a href="/fap/company/company_login">Login</a></li>
						<li><a href="/fap/company/company_insert_form">Join</a></li>
					</c:when>
					<c:otherwise>
						<li><a href="#none" id="logout">Logout</a></li>
					</c:otherwise>
				</c:choose>
				<!-- <li><a href="#" onclick="javascript:company_faq()">FAQ</a></li> -->
				<li class="">
				<div class="dropdown">
				  <button class="langSelect">Language</button>
				  <div class="dropdown-content">
				    <a onclick="language_chage('ko');" style="color:black;">한국어(KR)</a>
				    <a onclick="language_chage('ja');" style="color:black;">日本語(JP)</a>
				  </div>
				</div>
				</li>
				<li><a href="http://ict.sesoc.global:8888">旧サイト</a></li>
			</ul>
		</div>
		<div id="infoTop">
			<div id="logo">
				<a href="/fap/company/company_main"><img src="<c:url value="/resources/segroup/society/fap/images/userOpenMain/society_logo.svg" />"></a>
			</div>
			<c:choose>
				<c:when test="${not empty check}">
					<div class="wrap">
						<ul class="fap_nav">
							<li>
								<a href="/fap/company/company_jobfair_apply_to_attend_form"><spring:message code="fap.common.attend_jobfair" /></a>
								<div class="menu-area"></div>
							</li>
							<li>
								<a href="/fap/company/company_job_ad_management"><spring:message code="fap.common.manage_jobad" /></a>
								<div class="menu-area"></div>
							</li>
							<li id="schedule_calendar" style="display: none;">
								<a href="/fap/company/company_process_schedule_calendar"><spring:message code="fap.common.manage_job_recruit_pcs_schedule" /></a>
								<div class="menu-area"></div>
							</li>
							<li id="required_doc_management" style="display: none;">
								<a href="/fap/company/company_required_doc_management"><spring:message code="fap.common.manage_accepted_applicant" /></a>
								<div class="menu-area"></div>
							</li>
							<li id="my_page" style="display: none;">
								<a href="/fap/company/company_user_update_form"><spring:message code="fap.common.my_page" /></a>
								<div class="menu-area"></div>
							</li>
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
				<li id="process_schedule_calendar">
					<a href="/fap/company/company_process_schedule_calendar" style="display: none;">
						<spring:message  code="fap.common.confirm_job_recruit_pcs_schedule" />
					</a>
				</li>
			</ul>
		</div>
		<div class="nav-column">
			<ul>
				<li id="pay_for_cost" style="display: none;">
					<a href="/fap/company/company_pay_for_cost">
						<spring:message code="fap.common.pay_for_cost" />
					</a>
				</li>
				<li id="doc_management" style="display: none;">
					<a href="/fap/company/company_required_doc_management">
						<spring:message code="fap.common.manage_accepted_doc" />
					</a>
				</li>
			</ul>
		</div>
		<div class="nav-column">
			<ul>
				<li id="user_info" style="display: none;">
					<a href="/fap/company/company_user_update_form">
						<spring:message code="fap.common.manage_user_info" />
					</a>
				</li>
				<li id="comp_info" style="display: none;">
					<a href="/fap/company/company_update_form">
						<spring:message code="fap.common.manage_comp_info" />
					</a>
				</li>
				<li id="connect_request" style="display: none;">
					<a href="/fap/company/management_connect_request">
						<spring:message code="fap.comp.agency_connect" />
					</a>
				</li>
				<li id="user_company_connect" style="display: none;">
					<a href="/fap/company/company_connect_request_management">
						<spring:message code="fap.comp.responsible_person_connect" />
					</a>
				</li>
				<li>
					<li id="user_company_insert" style="display: none;">
					<a href="/fap/company/company_info_insert">
						<spring:message code="fap.common.insert_comp_info" />
					</a>
				</li>
			</ul>
		</div>
	</div> --%>

		<div id='cssmenu'>
		<ul>
			<li><a href='/fap/admin/admin_main'>Home</a></li>
			<li><a>잡페어</a>
				<ul>
					<li><a href='/fap/admin/jobfair_management'>잡페어 관리</a></li>
					<li><a href='/fap/admin/jobfair_permission'>잡페어 지원자 승인</a></li>
					<li><a href="/fap/admin/jobfair_attended_comp_list">잡페어 참가 기업 리스트</a></li>
					<li><a href="/fap/admin/user_apply_numbers_management">잡페어 지원자 지망가능 개수 설정</a></li>
				    <li><a href="/fap/admin/final_decision_time_form">최종확정 기간 설정</a></li>
				    <li><a href="/fap/admin/admin_company_group_code_management_per_job_fair">잡페어별 기업 그룹코드 관리</a>
				</ul>
			</li>
			<li><a>채용</a>
				<ul>
					<li><a href='/fap/admin/job_ad_management'>채용공고 관리</a></li>
					<li><a href='/fap/admin/process_schedule_management'>채용전형 일정관리</a></li>
					<li><a href='/fap/admin/process_schedule_calendar'>채용전형 캘린더</a></li>
					<li><a href='/fap/admin/applicant_status_per_comp'>기업별 지원자 현황</a></li>
		            <li><a href='/fap/admin/applicant_status_per_applier'>지원자별 지원 현황</a></li>
		            <li><a href="/fap/admin/jobfair_qna_permission">잡페어 지원자 채용공고 질문 승인</a></li>
		            <li><a href='/fap/admin/required_doc_management'>내정서류 관리</a></li>
	            	<li><a href="/fap/admin/jobfair_divide_final_select">잡페어 세부별 최종합격자 <br><br>결정 기한 알림 설정</a></li>
	            	<li><a href="/fap/admin/admin_job_advertisement_search_form" >채용공고 상세검색</a></li> 
				</ul>
			</li>
		    <li><a>결제</a>
		    	<ul>
		    		<li><a href='/fap/admin/per_jobfair_temp_group_management'>잡페어별 임시 결제 그룹 관리</a></li>
					<li><a href='/fap/admin/per_comp_temp_payment_management'>회사별 임시 결제 그룹 관리</a></li>
		    	</ul>
		    </li>
		    <li><a>공지</a>
		    	<ul>
	    			<li><a href="/fap/admin/notice_management">공지사항 관리</a></li>
	    			<li><a href="/fap/admin/admin_faq_management">FAQ 관리</a></li>
	    			<li><a href="/fap/admin/popup_management">팝업관리</a>
		    	</ul>
		    </li>		    
		    <li><a>회원</a>
		    	<ul>
		    		<li><a href='/fap/admin/user_management'>회원 관리</a></li>
					<li><a href='/fap/admin/company_management'>기업 관리</a></li>
					<li><a href="/fap/admin/resume_update_management">이력서 수정여부 관리(임시)</a>
		    	</ul>
		    </li>
		    <li><a>오픈잡페어</a>
		    	<ul>
		    		<li><a href="/fap/admin/open_pt_management">오픈잡페어 설명회 관리</a></li>
		    		<li><a href="/fap/admin/open_pt_applier_management">설명회 지원자</a></li>
					<li><a href="/fap/admin/open_pt_edu_applier_management">구직자 교육 지원자</a></li>
		    	</ul>
		    </li>
		    <li>
		    	<a>일정 관리</a>
		    	<ul>
		    		<li><a href="/fap/admin/tokyofair_schedule_management">도쿄페어 일정 관리</a></li>
		    	</ul>
		    </li>
		    <li><a>기타</a>
		   		<ul>
<!-- 					<li><a href='/fap/admin/email_management'>기업 메일 관리</a></li>			  -->
					<li><a href='/fap/admin/mainpage_ct_management'>메인 페이지 관리</a></li>
				</ul>
		    </li>		     
		    <li><a href='/fap/admin/admin_notice_alim'>알림<span class="alimBadge" id="pushCount" style="display:none;"></span></a></li> 		 

			<c:if test="${not empty check}">
				<li><a href="#none" id="logout">로그아웃</a></li>
			</c:if>
		</ul>
	</div>
</body>
</html>
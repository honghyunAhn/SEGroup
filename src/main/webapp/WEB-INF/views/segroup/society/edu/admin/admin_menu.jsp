<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>	
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<script src="https://cdn.jsdelivr.net/npm/gasparesganga-jquery-loading-overlay@2.1.5/dist/loadingoverlay.min.js"></script>
<script type="text/javascript">
	$(function() {
		$('#logout').off("click").on("click", function() {
			$('#logoutForm').submit();
			return false;
		});
	});
</script>
<sec:authorize access="isAuthenticated()">
	<sec:authentication property="details" var="check" />
</sec:authorize>
<form id="logoutForm" action="/edu/admin/logout" method="post" style="display: none">
	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
</form>
<div id='cssmenu'>
	<ul>
		<li><a href='/edu/admin/admin_form'>Home</a></li>
		<li><a href='/edu/admin/curriculum_manager_form'>과정 관리</a>
		</li>
		<li><a href='/edu/admin/curriculum_gisu_manager_form'>기수 관리
				페이지</a></li>
		<li><a href='/edu/admin/apply_manager_form'>지원자 관리</a></li>
		<li><a href='/edu/admin/user_manager_form'>회원 관리</a></li>
		<li><a href='/edu/admin/board_manager_form'>게시판 관리</a></li>
        <li><a href='/edu/admin/payment_manager_form'>결제 관리</a>
            <ul>
                <li><a href='/edu/admin/payment_manager_form'>기수 결제 관리</a></li>
                <li><a href='/edu/admin/payment_manager_user'>유저 결제 관리</a></li>
                <li><a href='/edu/admin/payment_manager_refund'>유저 환불 관리</a></li>
            </ul></li>
        <li><a href='/edu/admin/faq_manager_form'>상담 관리</a>
            <ul>
                <li><a href='/edu/admin/faq_manager_form'>FAQ 관리</a></li>
                <li><a href='/edu/admin/online_manager_form'>온라인 상담 관리</a></li>
                <li><a href='/edu/admin/offline_manager_form'>오프라인 상담 관리</a></li>
            </ul>
		</li>
		<li><a href='#'>메인 화면 관리</a>
            <ul>
                <li><a href='banner_manager_form'>배너 관리</a></li>
                <li><a href='subbanner_manager_form'>서브 배너 관리</a></li>
            </ul>
		</li>
		<sec:authorize access="hasRole('ROLE_A0600')">
			<li>
				<a href="/edu/admin/admin_info_setting_form">관리자 설정</a>
			</li>
		</sec:authorize>
		<c:choose>
				<c:when test="${not empty check }">
					<li>
						<a href="#none" id="logout">로그아웃</a>
					</li>
				</c:when>
		</c:choose>
	</ul>
</div>
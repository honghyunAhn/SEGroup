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
<form id="logoutForm" action="/smp/admin/logout" method="post" style="display: none">
	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
</form>
<div id='cssmenu'>
	<ul>
		<li><a href='/smp/admin/board'>공지</a></li>
		<li><a href='/smp/admin/student_final_pass'>학생</a></li>
		<li>
			<a href='/smp/admin/student_grade'>성적관리</a>
			<ul>
                <li><a href='#'>상세 성적 관리</a></li>
                <li><a href='#'>종합 성적 관리</a></li>
            </ul>
		</li>
		<li>
			<a href='/smp/admin/aps_total'>평가항목</a>
			<ul>
                <li><a href='/smp/admin/aps_total'>종합평가</a></li>
                <li><a href='/smp/admin/aps_group'>그룹평가</a></li>
                <li><a href='/smp/admin/aps_detail'>상세평가</a></li>
                <li><a href='/smp/admin/aps_setlist'>평가등록 및 현황</a></li>
                <li><a href='#'>자주쓰는 평가설정</a></li>
            </ul>
		</li>
		<li><a href='/smp/scheduleStart'>일정</a></li>
		<li><a href='/smp/user/confirmCourse'>증명서</a></li>
		<c:choose>
				<c:when test="${not empty check }">
					<li>
						<a href="#none" id="logout">로그아웃</a>
					</li>
				</c:when>
		</c:choose>
	</ul>
</div>
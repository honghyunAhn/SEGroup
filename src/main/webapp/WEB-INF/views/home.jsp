<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="global.segroup.util.*" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<html>
<head>
<script src="<c:url value="/resources/segroup/js/jquery-3.1.1.js" />"></script>
<script type="text/javascript">
$(document).ready(function(){
	$('#logout').click(function() {
        $('#logoutForm').submit();
        return false;
    });
});
</script>
	<title>Home</title>
</head>
<body>
<sec:authorize access="isAuthenticated()">
	<sec:authentication property="details" var="check"/>
</sec:authorize>
<c:choose>
	<c:when test="${empty check }">
		<input type="button" value="로그인" onclick="location.href='edu/user/user_login_form'" />
		<input type="button" value="관리자페이지 이동" onclick="location.href='edu/admin/admin_form'" />
	</c:when>
	<c:otherwise>
		<%-- ${check.user.user_nm }님 환영합니다. <br /> --%>
		<input type="button" value="로그아웃" id="logout" />
	</c:otherwise>
</c:choose>
<form id="logoutForm" action="/logout" method="post" style="display:none">
    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
</form>

	<h3>종호쌤</h3>
	<ul>
		<!-- <li><a href="/edu/apply/apply_form?gisu_seq=27">모집홍보 지원신청서 테스트 페이지</a></li> -->
		<li><a href="/edu/apply/long_term_list">모집홍보 장기 기수 리스트 테스트 페이지</a></li>
	</ul>
	
	<h3>한진규</h3>
	<ul>
		<li><a href="edu/user/user_join_form">유저 가입</a></li>
	</ul>
	
	<h3>상철</h3>
	<ul>
		<li><a href="password_encrypt_test">비밀번호 암호화 테스트</a></li>
		<li><a href="<%= PathConstants.SCHOOL_BOOK_USER_MAIN %>">클라이언트 랜딩페이지</a></li>
	</ul>
	
	<h3>희경</h3>
	<ul>
		<li><a href="book/admin/admin_main">관리자 랜딩페이지</a></li>
	</ul>
	
	<h3>서민수 - 관리자 테스트 페이지</h3>
	<ul>
		<li><a href="<%= PathConstants.SCHOOL_BOOK_ADMIN_REGIST_BOOKINFO %>">도서 정보 등록</a></li>
		<li><a href="book/admin/regist_book">도서 등록</a></li>
	</ul>
	<h3>정식</h3>
	<ul>
		<li><a href="book/user/user_status">대여 현황</a></li>
		<li><a href="book/user/user_bookmark">관심 도서</a></li>
		<li><a href="book/user/user_request">도서 신청</a></li>
		<li><a href="book/user/user_rent_record">대여 기록</a></li>
		<li><a href="book/user/user_review">내글보기</a></li>
		<li><a href="book/utility/searchIsbn">ISBN검색~</a></li>
	</ul>
	
	
</body>
</html>

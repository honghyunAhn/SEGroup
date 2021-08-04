<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<div class="headerWrap">
	<%@include file="rainbow_header_basic.jsp" %>
    <div class="header-menuWrap">
        <ul class="header-menu d-flex justify_end fc_fff">
        	<sec:authorize access="isAuthenticated()">
				<sec:authentication property="details" var="check" />
			</sec:authorize>
			<c:choose>
				<c:when test="${empty check }">
		            <li class="hdrMenu login"><a href="/smtp/user/sub01-01">로그인</a></li>
		            <li class="hdrMenu join"><a href="/smtp/user/sub01-02">회원가입</a></li>
		            <li class="hdrMenu"><a href="/smtp/user/sub01-03">아이디찾기</a></li>
		            <li class="hdrMenu"><a href="/smtp/user/sub01-04">비밀번호찾기</a></li>
				</c:when>
				<c:otherwise>
            		<li class="hdrMenu logout fc_fff">로그아웃</li>
	            	<li class="hdrMenu join margin-left20 fc_eg"><a href="/smtp/user/sub05-01">나의강의실</a></li>
				</c:otherwise>
			</c:choose>
        </ul>
    </div>
</div>
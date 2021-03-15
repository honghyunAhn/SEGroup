<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="t"%>

<t:insertDefinition name="centerleftmenu"/>

<c:set var="detailUrl" value="/serviceCenter/bbs/noticeDetail"/>
<c:set var="listUrl" value="/serviceCenter/bbs/notice"/>
<!-- 1.3. 본문 -->
<div class="body">
	<div class="sub-header">
		<p class="sub-nav">
			<a class="nth-1st" href="/"><span class="sr-only">HOME</span></a>
			<a href="#">고객 센터</a>
			<a class="nth-last" href="${contextPath}">공지 사항</a>
		</p>
		<h2 class="sub-title">공지 사항</h2>
	</div>
<%@ include file="/WEB-INF/views/common/board/detail.jsp"%>
	<!--본문 내용 출력 공간-->
</div>
<!--// 1.3. 본문 -->


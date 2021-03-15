<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="contextPathsub" value='${fn:split(requestScope["javax.servlet.forward.request_uri"],"/")}'/>


<!--// 1.2. 사이드 LEFT  -->
<div class="sideL">
	<div id="sub-menu" class="sub-menu">
		<h4 class="sub-menu-title">연수원 소개</h4>
		<ul class="menu-d2">
			<li>
				<a class='<c:if test="${fn:contains(contextPathsub[fn:length(contextPathsub)-1],'intro')}">on</c:if>' href="/footer/intro" title="키보드 운영시 v: 하위메뉴 보기, c: 하위메뉴 닫기, Enter: 페이지 이동">연수원 소개</a>
			</li>
			<li>
				<a class='<c:if test="${fn:contains(contextPathsub[fn:length(contextPathsub)-1],'organization')}">on</c:if>' href="/footer/organization" title="키보드 운영시 v: 하위메뉴 보기, c: 하위메뉴 닫기, Enter: 페이지 이동">조직도<sup class="sr-only">ON</sup></a>
			</li>
			<li>
				<a class='<c:if test="${fn:contains(contextPathsub[fn:length(contextPathsub)-1],'location')}">on</c:if>' href="/footer/location" title="키보드 운영시 v: 하위메뉴 보기, c: 하위메뉴 닫기, Enter: 페이지 이동">찾아오시는 길</a>
			</li>
			<li>
				<a class='<c:if test="${fn:contains(contextPathsub[fn:length(contextPathsub)-1],'provision')}">on</c:if>' href="/footer/provision" title="키보드 운영시 v: 하위메뉴 보기, c: 하위메뉴 닫기, Enter: 페이지 이동">연수원 규정</a>
			</li>
			<li>
				<a class='<c:if test="${fn:contains(contextPathsub[fn:length(contextPathsub)-1],'terms')}">on</c:if>' href="/footer/terms" title="키보드 운영시 v: 하위메뉴 보기, c: 하위메뉴 닫기, Enter: 페이지 이동">이용약관</a>
			</li>
			<li>
				<a class='<c:if test="${fn:contains(contextPathsub[fn:length(contextPathsub)-1],'privacy')}">on</c:if>' href="/footer/privacy" title="키보드 운영시 v: 하위메뉴 보기, c: 하위메뉴 닫기, Enter: 페이지 이동">개인 정보처리방침</a>
			</li>
		</ul>
	</div><!--//.sub-menu-->
</div>
<!--// 1.2. 사이드 LEFT  -->


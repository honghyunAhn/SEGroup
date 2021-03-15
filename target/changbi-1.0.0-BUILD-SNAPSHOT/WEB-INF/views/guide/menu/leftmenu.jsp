<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="contextPathsub" value='${fn:split(requestScope["javax.servlet.forward.request_uri"],"/")}'/>

<!--// 1.2. 사이드 LEFT  -->
<div class="sideL">
	<div id="sub-menu" class="sub-menu">
		<h4 class="sub-menu-title">연수 안내</h4>
		<ul class="menu-d2">
			<li>
				<a class="<c:if test="${fn:contains(contextPathsub[fn:length(contextPathsub)-1],'guide')}">on</c:if>" href="#" title="키보드 운영시 v: 하위메뉴 보기, c: 하위메뉴 닫기, Enter: 페이지 이동">원격 연수</a>
				<ul class="menu-d3" style="display: block;">
					<li><a class="<c:if test="${fn:contains(contextPathsub[fn:length(contextPathsub)-1],'guide')}">on</c:if>" href="/guide/training/guide">원격 연수 안내<sup class="sr-only">ON</sup><sup class="sr-only">ON</sup></a></li>
					<li><a class="<c:if test="${fn:contains(contextPathsub[fn:length(contextPathsub)-1],'class')}">on</c:if>" href="/guide/training/class">수강 방법</a></li>
					<li><a class="<c:if test="${fn:contains(contextPathsub[fn:length(contextPathsub)-1],'evaluation')}">on</c:if>" href="/guide/training/evaluation">평가 이수 방법</a></li>
					<li><a class="<c:if test="${fn:contains(contextPathsub[fn:length(contextPathsub)-1],'attendance')}">on</c:if>" href="/guide/training/attendance">출석 고사</a></li>
					<li><a class="<c:if test="${fn:contains(contextPathsub[fn:length(contextPathsub)-1],'change')}">on</c:if>" href="/guide/training/change">연수 연기/취소</a></li>
					<li><a class="<c:if test="${fn:contains(contextPathsub[fn:length(contextPathsub)-1],'number')}">on</c:if>" href="/guide/training/number">연수 지명 번호 안내</a></li>
					<li><a class="<c:if test="${fn:contains(contextPathsub[fn:length(contextPathsub)-1],'schedule')}">on</c:if>" href="/guide/training/schedule">연간 연수 일정</a></li>
					<li><a class="<c:if test="${fn:contains(contextPathsub[fn:length(contextPathsub)-2],'offidoc')}">on</c:if>" href="/guide/training/offidoc/list">연수 공문</a></li>
				</ul>
			</li>
			<li>
				<a class="<c:if test="${fn:contains(contextPathsub[fn:length(contextPathsub)-1],'group')}">on</c:if>" href="/guide/training/group" title="키보드 운영시 v: 하위메뉴 보기, c: 하위메뉴 닫기, Enter: 페이지 이동">교육청(기관) 연수</a>
			</li>
			<li>
				<a class="<c:if test="${fn:contains(contextPathsub[fn:length(contextPathsub)-1],'autonomy')}">on</c:if>" href="/guide/training/autonomy" title="키보드 운영시 v: 하위메뉴 보기, c: 하위메뉴 닫기, Enter: 페이지 이동">자율 연수</a>
			</li>
			<li>
				<a class="<c:if test="${fn:contains(contextPathsub[fn:length(contextPathsub)-1],'set')}">on</c:if>" href="/guide/training/set" title="키보드 운영시 v: 하위메뉴 보기, c: 하위메뉴 닫기, Enter: 페이지 이동">집합 연수</a>
			</li>
		</ul>
	</div><!--//.sub-menu-->
</div>
<!--// 1.2. 사이드 LEFT  -->


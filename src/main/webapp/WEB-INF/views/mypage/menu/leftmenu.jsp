<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="contextPathsub" value='${fn:split(requestScope["javax.servlet.forward.request_uri"],"/")}'/>

<!--// 1.2. 사이드 LEFT  -->
<div class="sideL">
	<div id="sub-menu" class="sub-menu">
		<h4 class="sub-menu-title">나의 강의실</h4>
		<ul class="menu-d2">
			<li>
				<a href="#" title="키보드 운영시 v: 하위메뉴 보기, c: 하위메뉴 닫기, Enter: 페이지 이동">강의실</a>
				<ul class="menu-d3">
					<li><a class='<c:if test="${fn:contains(contextPathsub[fn:length(contextPathsub)-2],'lecture')}">on</c:if>' href="/mypage/lecture/lecture1">연수 과정</a></li>
					<li><a class='<c:if test="${fn:contains(contextPathsub[fn:length(contextPathsub)-2],'change')}">on</c:if>' href="/mypage/change/change">연수 연기/취소</a></li>
				</ul>
			</li>
			<li>
				<a class='<c:if test="${fn:contains(contextPathsub[fn:length(contextPathsub)-1],'receipt')}">on</c:if>' href="/mypage/receipt/receipt" title="키보드 운영시 v: 하위메뉴 보기, c: 하위메뉴 닫기, Enter: 페이지 이동">영수증/이수증 정보</a>
			</li>
			<li>
				<a class='<c:if test="${fn:contains(contextPathsub[fn:length(contextPathsub)-1],'delivery')}">on</c:if>' href="/mypage/delivery/delivery" title="키보드 운영시 v: 하위메뉴 보기, c: 하위메뉴 닫기, Enter: 페이지 이동">배송 정보</a>
			</li>
			<li>
				<a class='<c:if test="${fn:contains(contextPathsub[fn:length(contextPathsub)-1],'point')}">on</c:if>' href="/mypage/point/point" title="키보드 운영시 v: 하위메뉴 보기, c: 하위메뉴 닫기, Enter: 페이지 이동">포인트/쿠폰 정보</a>
			</li>
			<li>
				<a class='<c:if test="${fn:contains(contextPathsub[fn:length(contextPathsub)-2],'note')}">on</c:if>' href="/mypage/note/received" title="키보드 운영시 v: 하위메뉴 보기, c: 하위메뉴 닫기, Enter: 페이지 이동">쪽지함</a>
			</li>
			<li>
				<a href="#" title="키보드 운영시 v: 하위메뉴 보기, c: 하위메뉴 닫기, Enter: 페이지 이동">개인 정보</a>
				<ul class="menu-d3" style="display: block;">
					<li><a class='<c:if test="${fn:contains(contextPathsub[fn:length(contextPathsub)-1],'privateedit')}">on</c:if>' href="/mypage/private/privateedit">개인 정보 수정</a></li>
					<li><a class='<c:if test="${fn:contains(contextPathsub[fn:length(contextPathsub)-1],'secessioncertification')}">on</c:if>' class="on" href="/mypage/private/secessioncertification">회원 탈퇴<sup class="sr-only">ON</sup></a></li>
				</ul>
			</li>
			<li>
				<a class='<c:if test="${fn:contains(contextPathsub[fn:length(contextPathsub)-1],'certificate')}">on</c:if>' href="/mypage/certificate/certificate" title="키보드 운영시 v: 하위메뉴 보기, c: 하위메뉴 닫기, Enter: 페이지 이동">공인 인증서 정보</a>
			</li>			
			<li>
				<a class='<c:if test="${fn:endsWith(contextPathsub[fn:length(contextPathsub)-1],'ip')}">on</c:if>' href="/mypage/ip/ip" title="키보드 운영시 v: 하위메뉴 보기, c: 하위메뉴 닫기, Enter: 페이지 이동">접속 IP 등록/변경/삭제</a>
			</li>
		</ul>
	</div><!--//.sub-menu-->
</div>
<!--// 1.2. 사이드 LEFT  -->


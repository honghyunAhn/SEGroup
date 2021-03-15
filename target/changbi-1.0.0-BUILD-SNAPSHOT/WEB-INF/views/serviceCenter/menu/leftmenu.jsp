<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<sec:authentication property="principal" var="principal" />

<c:set var="contextPathsub" value='${fn:split(requestScope["javax.servlet.forward.request_uri"],"/")}'/>
<!--// 1.2. 사이드 LEFT  -->
		<div class="sideL">
			<div id="sub-menu" class="sub-menu">
				<h4 class="sub-menu-title">고객 센터</h4>
				<ul class="menu-d2">
					<li>
						<a class='<c:if test="${fn:contains(contextPathsub[fn:length(contextPathsub)-1],'notice')}">on</c:if>' href="/serviceCenter/bbs/notice?board_type=1">공지 사항</a>
					</li>
					<li>
						<a class='<c:if test="${fn:contains(contextPathsub[fn:length(contextPathsub)-1],'faq')}">on</c:if>' href="/serviceCenter/bbs/faq?board_type=3&faq_code=0">자주 묻는 질문</a>
					</li>
					<li>
						<a class='<c:if test="${fn:contains(contextPathsub[fn:length(contextPathsub)-1],'qna')}">on</c:if>' href="javascript:authAlertMove('/serviceCenter/bbs/qna?board_type=4&faq_code=0')">1:1 상담</a>
					</li>
					<li>
<%-- 						<a class='<c:if test="${fn:contains(contextPathsub[fn:length(contextPathsub)-1],'remote')}">on</c:if>' href="/serviceCenter/bbs/remote?board_type=0">PC 원격 지원</a> --%>
						<a class='<c:if test="${fn:contains(contextPathsub[fn:length(contextPathsub)-1],'remote')}">on</c:if>' href="/serviceCenter/remote/remote">PC 원격 지원</a>
					</li>
					<li>
						<a class='<c:if test="${fn:contains(contextPathsub[fn:length(contextPathsub)-1],'program')}">on</c:if>' href="/serviceCenter/bbs/program?board_type=2">학습 프로그램</a>
					</li>
					<li>
						<a class='<c:if test="${fn:contains(contextPathsub[fn:length(contextPathsub)-1],'event')}">on</c:if>' href="/serviceCenter/event/eventList">이벤트</a>
					</li>
					<li>
						<a class='<c:if test="${fn:contains(contextPathsub[fn:length(contextPathsub)-1],'teacher')}">on</c:if>' href="/serviceCenter/teacher/teacher">강사 지원</a>
					</li>
					<li>
						<a class='<c:if test="${fn:contains(contextPathsub[fn:length(contextPathsub)-1],'alliance')}">on</c:if>' href="/serviceCenter/alliance/alliance">제휴 문의</a>
					</li>
				</ul>
			</div><!--//.sub-menu-->
		</div><!--//.sideL-->
<!--// 1.2. 사이드 LEFT  -->


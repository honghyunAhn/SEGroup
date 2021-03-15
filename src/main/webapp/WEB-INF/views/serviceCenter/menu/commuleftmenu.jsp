<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<sec:authentication property="principal" var="principal" />

<c:set var="contextPathsub" value='${fn:split(requestScope["javax.servlet.forward.request_uri"],"/")}'/>


<!--// 1.2. 사이드 LEFT  -->
	<!-- 기존 창비 start 
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
				
			</div> //.sub-menu
					</div>//sideL 기존창비 end -->
			
			<div class="sub-nav">
				<ul class="sub-navGroup">
					<li class="gnb sub05 fz18"><a href="sub05-01-01.html">커뮤니티</a></li>
					<li class="lnb fz14"><a href="sub05-01-01.html">자료실
							<div class="img-icon angle-right angle-down"></div>
					</a>
						<ul class="menu-sub">
							<li><a href="sub05-01-01.html">
									<div class="img-icon caret-right"></div>자료실
							</a></li>
							<li><a href="sub05-01-02.html">
									<div class="img-icon caret-right"></div>학습지원프로그램
							</a></li>
							<li><a href="sub05-01-03.html">
									<div class="img-icon caret-right"></div>동영상지원프로그램
							</a></li>
							<li><a href="sub05-01-04.html">
									<div class="img-icon caret-right"></div>파일뷰어프로그램
							</a></li>
						</ul></li>
					<li class="lnb fz14"><a href="/serviceCenter/bbs/notice?board_type=1&notice_type=1">공지사항/이벤트
							<div class="img-icon angle-right angle-down"></div>
					</a>
						<ul class="menu-sub">
							<li><a href="/serviceCenter/bbs/notice?board_type=1&notice_type=1">
									<div class="img-icon caret-right"></div>공지사항
							</a></li>
							<li><a href="/serviceCenter/bbs/notice?board_type=1&notice_type=2">
									<div class="img-icon caret-right"></div>이벤트
							</a></li>
						</ul></li>
					<li class="lnb fz14"><a href="sub05-03.html">수강후기/인터뷰</a></li>
					<li class="lnb fz14"><a href="sub05-04.html">특강/설명회</a></li>
					<li class="lnb fz14"><a href="sub05-05.html">자유게시판</a></li>
				</ul>
			</div>
			
<script type="text/javascript">
	$(function() {
		//서브 페이지 네비
		var path = window.location.href;
		console.log('path :', path);
		// because the 'href' property of the DOM element is the absolute path
		$('.sub-nav .lnb>a').each(function() {
			if (this.href === path) {
				console.log('lnb일치');
				$(this).addClass('active');
				$(this).next().css({
					"display" : "block"
				});
			}
		});

		$('.sub-nav .menu-sub a').each(function() {
			if (this.href === path) {
				console.log('menu-sub일치');
				$(this).addClass('active').find('div').addClass('active');
				$(this).parent().parent().prev().addClass('active');
				$(this).parent().parent().css({
					"display" : "block"
				});
			}
		});
	});
</script>
<!--// 1.2. 사이드 LEFT  -->


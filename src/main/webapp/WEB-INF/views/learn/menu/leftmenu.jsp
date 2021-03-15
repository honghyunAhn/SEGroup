<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="contextPathsub" value='${fn:split(requestScope["javax.servlet.forward.request_uri"],"/")}'/>
<!--// 1.2. 사이드 LEFT  -->
		<div class="sideL">
			<div id="sub-menu" class="sub-menu">
				<h4 class="sub-menu-title">연수 신청</h4>
				<ul class="menu-d2">
					<li>
						<a href="#">영역별 연수</a>
						<ul class='menu-d3 <c:if test="${fn:contains(contextPathsub[fn:length(contextPathsub)-1],'course')}">on</c:if>'>
							<li><a class='<c:if test="${'0' eq paramp.get('course_code') && 'J' eq paramp.get('learn_types')}">on</c:if>' href="course?course_code=0">전체 보기</a></li>
							<c:forEach var="code" items="${courseCategoryList}" varStatus="status">
							<li><a class='<c:if test="${(code.CODE) eq paramp.get('course_code') && 'J' eq paramp.get('learn_types')}">on</c:if>' href="course?course_code=${code.CODE}">${code.NAME}</a></li>
							</c:forEach>
						</ul>
					</li>
					<li>
						<a href="#">학점별  연수</a>
						<ul class='menu-d3 <c:if test="${fn:contains(contextPathsub[fn:length(contextPathsub)-1],'grades')}">on</c:if>'>
							<li><a class='<c:if test="${'0' eq paramp.get('credit')}">on</c:if>' href="grades?credit=0">전체 보기</a></li>
							<li><a class='<c:if test="${'4' eq paramp.get('credit')}">on</c:if>' href="grades?credit=4">4학점(60시간)</a></li>
							<li><a class='<c:if test="${'3' eq paramp.get('credit')}">on</c:if>' href="grades?credit=3">3학점(45시간)</a></li>
							<li><a class='<c:if test="${'2' eq paramp.get('credit')}">on</c:if>' href="grades?credit=2">2학점(30시간)</a></li>
							<li><a class='<c:if test="${'1' eq paramp.get('credit')}">on</c:if>' href="grades?credit=1">1학점(15시간)</a></li>
						</ul>
					</li>
					<li>
						<a href="#">대상별 연수</a>
						<ul class='menu-d3 <c:if test="${fn:contains(contextPathsub[fn:length(contextPathsub)-1],'object')}">on</c:if>'>
							<li><a class='<c:if test="${'0' eq paramp.get('target_types')}">on</c:if>' href="object?target_types=0">전체 보기</a></li>
							<li><a class='<c:if test="${'1' eq paramp.get('target_types')}">on</c:if>' href="object?target_types=1">유아</a></li>
							<li><a class='<c:if test="${'2' eq paramp.get('target_types')}">on</c:if>' href="object?target_types=2">초등</a></li>
							<li><a class='<c:if test="${'3' eq paramp.get('target_types')}">on</c:if>' href="object?target_types=3">중등</a></li>
							<li><a class='<c:if test="${'4' eq paramp.get('target_types')}">on</c:if>' href="object?target_types=4">전문직</a></li>
						</ul>
					</li>
					<%--
					<li>
						<a href="#">교육청(기관) 연수</a>
						<ul class='menu-d3 <c:if test="${fn:contains(contextPathsub[fn:length(contextPathsub)-1],'group')}">on</c:if>'>
							<li><a class='<c:if test="${'N' eq paramp.get('closed')}">on</c:if>' href="group">모집 연수</a></li>
							<li><a class='<c:if test="${'Y' eq paramp.get('closed')}">on</c:if>' href="group?closed=Y">마감 연수</a></li>
						</ul>
					</li>
					<li>
						<a href="#">자율 연수</a>
						<ul class='menu-d3 <c:if test="${fn:contains(contextPathsub[fn:length(contextPathsub)-1],'autonomy')}">on</c:if>'>
							<li><a class='<c:if test="${'0' eq paramp.get('course_code') && 'S' eq paramp.get('learn_types')}">on</c:if>' href="autonomy?course_code=0">전체 보기</a></li>
							<c:forEach var="code" items="${courseCategoryList}" varStatus="status">
							<li><a class='<c:if test="${(code.CODE) eq paramp.get('course_code') && 'S' eq paramp.get('learn_types')}">on</c:if>' href="autonomy?course_code=${code.CODE}">${code.NAME}</a></li>
							</c:forEach>
						</ul>
					</li>
					<li>
						<a href="#">집합 연수</a>
						<ul class='menu-d3 <c:if test="${fn:contains(contextPathsub[fn:length(contextPathsub)-1],'set')}">on</c:if>'>
							<li><a class='<c:if test="${'0' eq paramp.get('course_code') && 'M' eq paramp.get('learn_types')}">on</c:if>' href="set?course_code=0">전체 보기</a></li>
							<c:forEach var="code" items="${courseCategoryList}" varStatus="status">
							<li><a class='<c:if test="${(code.CODE) eq paramp.get('course_code') && 'M' eq paramp.get('learn_types')}">on</c:if>' href="set?course_code=${code.CODE}">${code.NAME}</a></li>
							</c:forEach>
						</ul>
					</li>
					 --%>
				</ul>
			</div><!--//.sub-menu-->
		</div><!--//.sideL-->
<!--// 1.2. 사이드 LEFT  -->

<script type="text/javascript">
$(document).ready(function(){
	// 추천 연수 슬라이드
	$('#recommend-learn').slick({
		dots: true,
		slidesToShow: 4,
		slidesToScroll: 1,
		autoplay: true,
		autoplaySpeed: 2000,
		prevArrow : '<a class="ctrl-btn btn-prev" href="#recommend-learn">이전</a>',
		nextArrow : '<a class="ctrl-btn btn-next" href="#recommend-learn">다음</a>',
	});

});
</script>

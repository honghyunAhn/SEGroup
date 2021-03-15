<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<spring:eval expression="@config.getProperty('popupPages')" var="visiblePages" scope="request"/>

<div class="group box strongOut">
	<div class="group-header">
		<h4 class="strong">창비 추천 연수</h4>
	</div>
	<div class="group-body">
		 <div id="recommend-learn" class="gallery">
		 		<c:if test="${!empty slide}">
		 		<c:forEach var="slide" items="${slide}" varStatus="status">
					<div class="item">
						<div class="item-img"><img src="${slide.url_path}"></div>
						<div class="item-summary">
							<em class="item-type v2">
							${slide.credit}학점
							</em>
							<strong><a class="item-title" href="<c:url value="/learn/course/detail"/>?course_id=${slide.course_id}">${slide.name}</a></strong>
							<ul class="item-info">
								<li class="learn-course"><em class=sr-only>연수 영역: </em>
									${slide.coures_code_name }
								</li>
								<li class="learn-time"><em class=sr-only>수강 기간: </em>${slide.complete_time}시간</li>
								<c:if test="${'Y' eq slide.mobile_yn }">
								<li class="learn-mobile"><em class=sr-only>모바일 연수 가능</em></li>
								</c:if>
							</ul>
							<p class="item-function">
							<c:if test="${not empty slide.tasting_url }"><a class="btn line blit btnWatch" href="${slide.tasting_url }" target="_blank">미리 보기</a></c:if>
										<c:if test="${empty slide.tasting_url }"><a class="btn blit icon btnWatch" href="javascript:alertNoPreview()">미리 보기</a></c:if>
								<a class="btn blit btnCheck primary notation" href="#" data-course="${slide.course_id}">연수 신청</a>
							</p>
						</div>
					</div><!--//.item-->
				</c:forEach>
		 		</c:if>
			</div>
	</div><!--.//.group-body-->
</div><!--//.group-->

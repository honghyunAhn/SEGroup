<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="contextPathsub" value='${fn:split(requestScope["javax.servlet.forward.request_uri"],"/")}'/>
<!--// 1.2. 사이드 LEFT  -->
		<div class="sideL">
			<div id="sub-menu" class="sub-menu">
				<h4 class="sub-menu-title">강사 소개</h4>
				<ul class="menu-d2">
					<li>
						<a href="list">이달의 창비 강사</a>
					</li>
					<li>
						<a href="list">영역별 강사</a>
						<ul class='menu-d3 <c:if test="${fn:contains(contextPathsub[fn:length(contextPathsub)-1],'list')}">on</c:if>'>
							<c:forEach var="code" items="${courseCategoryList}" varStatus="status">
							<li><a class='<c:if test="${(code.CODE) eq param.course}">on</c:if>' href="list?course=${code.CODE}">${code.NAME}</a></li>
							</c:forEach>
						</ul>
					</li>
				</ul>
			</div><!--//.sub-menu-->
		</div><!--//.sideL-->
<!--// 1.2. 사이드 LEFT  -->

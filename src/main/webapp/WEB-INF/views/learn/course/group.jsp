<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="t"%>

<t:insertDefinition name="leftmenu"/>

<!-- 1.3. 본문 -->
	<div class="body">
			<div class="sub-header">
				<p class="sub-nav">
					<a class="nth-1st" href="<c:url value="/"/>"><span class="sr-only">HOME</span></a>
					<a href="#">연수 신청</a>
					<a class="nth-last" href="${contextPath}">교육청(기관) 연수</a>
				</p>
				<h2 class="sub-title">교육청(기관) 연수 </h2>
				<!--p class="sub-title-copy">제목을 보조해주는 문구 삽입</p-->
			</div><!--//.sub-header-->
			<div class="sub-body">
				<div class="tab-group">
					<ul class="tab-header sub x2">
						<li><a class="nth-1st <c:if test="${paramp.closed == 'N'}">on</c:if>" href="group?closed=N">모집 연수</a></li>
						<li><a class="nth-1st <c:if test="${paramp.closed == 'Y'}">on</c:if>" href="group?closed=Y">마감 연수</a></li>
					</ul>
					<div class="tab-body">
						<table id="list-learnGroup" class="list">
							<colgroup>
								<col width="50">
								<col width="90">
								<col width="70">
								<col width="65">
								<col width="">
								<col width="110">
								<col width="110">
								<col width="125">
								<col width="75">
								<col width="80">
							</colgroup>
							<thead>
								<tr>
									<th>&nbsp;</th>
									<th scope="col" class="item-group1">시*도 교육청</th>
									<th scope="col" class="item-group3">교육 지원청</th>
									<th scope="col" class="item-notation">기수</th>
									<th scope="col" class="item-title">연수 과정명</th>
									<th scope="col" class="item-date">신청 기간</th>
									<th scope="col" class="item-date">연수 기간</th>
									<th scope="col" class="item-target">연수 대상</th>
									<th scope="col" class="item-max">모집 인원</th>
									<th scope="col" class="item-function">연수 신청</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="list" items="${list}" varStatus="status">
								<tr class="nth-1st"><!-- ie8에서는 nth-first 선택자를 이용할 수 없으므로 첫번째 아이템에만 class 명으로 부여 -->
									<td class="item-banner"><img src="<c:url value="${list.BANNER_URL }"/>"></td>
									<td class="item-group1">${list.REGION_NAME}</td>
									<td class="item-group2">${list.JURISDICTION}</td>
									<td class="item-notation">${list.CARDINAL_NAME}</td>
									<td class="item-title"><a href="<c:url value="/learn/course/groupDetail"/>?closed=${paramp.closed }&group_id=${list.ID}&course_id=${list.COURSE_ID}&cardinal_seq=${list.CARDINAL_SEQ}">${list.COURSE_NAME}</a>
										<span class="iconSet">
											<c:if test="${fn:contains(list.ICON_DISPLAYS, '1')}"><em class="icon-new">NEW</em></c:if>
											<c:if test="${fn:contains(list.ICON_DISPLAYS, '2')}"><em class="icon-best">BEST</em></c:if>
											<c:if test="${fn:contains(list.ICON_DISPLAYS, '3')}"><em class="icon-pop">인기</em></c:if>
											<c:if test="${fn:contains(list.ICON_DISPLAYS, '4')}"><em class="icon-upgrade">업그레이드</em></c:if>
											<c:if test="${fn:contains(list.ICON_DISPLAYS, '5')}"><em class="icon-great">우수</em></c:if>
										</span>
									</td>
									<td class="item-date">${list.LEARN_START_DATE}. ~ ${list.LEARN_END_DATE}.</td>
									<td class="item-target">${list.TARGETS}</td>
									<td class="item-max">${list.LIMIT_NUM}명</td>
									<td class="item-function">
										<c:choose>
										<c:when test="${list.STATUS == 'P'}"><a class="btn blit btnCheck primary" href="javascript:authAlertApply('${list.COURSE_ID }','${list.CARDINAL_ID }','${list.ID }')">연수 신청</a></c:when>
										<c:when test="${list.STATUS != 'P'}"><a class="btn" href="<c:url value="/learn/course/groupDetail"/>?closed=${paramp.closed }&group_id=${list.ID}&course_id=${list.COURSE_ID}&cardinal_seq=${list.CARDINAL_SEQ}">상세보기</a></c:when>
										</c:choose>
									</td>
								</tr>
								</c:forEach>
								<c:if test="${empty list}">
								<tr>
									<td colspan="10">조회된 내용이 없습니다.</td>
								</tr>
								</c:if>
							</tbody>
						</table>
					</div><!--//.tab-body-->
				</div><!--.tab-groyp-->
			</div><!--//.sub-body-->
			<!--본문 내용 출력 공간-->
		</div>
<!--// 1.3. 본문 -->
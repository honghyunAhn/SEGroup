<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="t"%>

<script type="text/javascript">
$(document).ready(function(){

});
</script>

<t:insertDefinition name="guideleftmenu"/>

<!-- 1.3. 본문 -->
<div class="body">
	<div class="sub-header">
		<p class="sub-nav">
			<a class="nth-1st" href="<c:url value="/"/>"><span class="sr-only">HOME</span></a>
			<a href="#">연수 안내</a>
			<a href="#">원격 연수</a>
			<a href="#">연간 연수 일정</a>
		</p>
		<h2 class="sub-title">연간 연수 일정</h2>
		<!--p class="sub-title-copy">제목을 보조해주는 문구 삽입</p-->
	</div><!--//.sub-header-->
	<div class="sub-body">
		<ul class="notice-list group">
			<li>모든 연수는 기수 종료 후, 15일 이내 해당 교육청에 일괄 보고됩니다.</li>
			<li>연수 일정은 연수 사정이나 방학 기간 일정에 따라 다소 조정될 수 있습니다.</li>
		</ul>
		<div class="group">
			<div class="group-header">
				<h3>1학점(15시간) 연수 일정</h3>
				<p class="ctrl-btnSet">※ 출석 고사 없음.</p>
			</div>
			<table class="list">
				<colgroup>
					<col width="">
					<col width="220">
					<col width="220">
					<col width="220">
					<col width="100">
				</colgroup>
				<thead>
					<tr>
						<th scope="col">연수 기수</th>
						<th scope="col">신청 기간</th>
						<th scope="col">연수 기간</th>
						<th scope="col">이수증 발급</th>
						<th scope="col" class="item-function">비고</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="list" items="${credit1List}">
					<tr>
						<td><strong><c:out value="${list.NAME }"/></strong></td>
						<td><c:out value="${list.APP_START_DATE }"/> ~ <c:out value="${list.APP_END_DATE }"/></td>
						<td><c:out value="${list.LEARN_START_DATE }"/> ~ <c:out value="${list.LEARN_END_DATE }"/></td>
						<td><c:out value="${list.ISSUE_DATE }"/></td>
						<td class="item-function">
							<c:set var="credit" value="1"/>
							<c:if test="${fn:contains(list.APP_POSSIBLES, '2')}"><c:set var="credit" value="2"/></c:if>
							<c:if test="${list.STATUS != 'Y' }"><c:out value="${list.STATUS_NAME }"/></c:if>
							<c:if test="${list.STATUS == 'Y' }"><a class="btn blit btnCheck primary" href="<c:url value="/learn/course/grades?credit=${credit }"/>">연수 신청</a></c:if>
						</td>
					</tr>
					</c:forEach>
					<c:if test="${empty credit1List }">
					<tr>
						<td class="alignC" colspan="5">진행 중인 연수 기수가 없습니다.</td>
					</tr>
					</c:if>
				</tbody>
			</table>
		</div><!--//.group-->
		<div class="group">
			<div class="group-header">
				<h3>2학점(30시간) 연수 일정</h3>
				<p class="ctrl-btnSet">※ 출석 고사 없음.</p>
			</div>
			<table class="list">
				<colgroup>
					<col width="">
					<col width="220">
					<col width="220">
					<col width="220">
					<col width="100">
				</colgroup>
				<thead>
					<tr>
						<th scope="col">연수 기수</th>
						<th scope="col">신청 기간</th>
						<th scope="col">연수 기간</th>
						<th scope="col">이수증 발급</th>
						<th scope="col" class="item-function">비고</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="list" items="${credit2List}">
					<tr>
						<td><strong><c:out value="${list.NAME }"/></strong></td>
						<td><c:out value="${list.APP_START_DATE }"/> ~ <c:out value="${list.APP_END_DATE }"/></td>
						<td><c:out value="${list.LEARN_START_DATE }"/> ~ <c:out value="${list.LEARN_END_DATE }"/></td>
						<td><c:out value="${list.ISSUE_DATE }"/></td>
						<td class="item-function">
							<c:set var="credit" value="1"/>
							<c:if test="${fn:contains(list.APP_POSSIBLES, '2')}"><c:set var="credit" value="2"/></c:if>
							<c:if test="${list.STATUS != 'Y' }"><c:out value="${list.STATUS_NAME }"/></c:if>
							<c:if test="${list.STATUS == 'Y' }"><a class="btn blit btnCheck primary" href="<c:url value="/learn/course/grades?credit=${credit }"/>">연수 신청</a></c:if>
						</td>
					</tr>
					</c:forEach>
					<c:if test="${empty credit2List }">
					<tr>
						<td class="alignC" colspan="5">진행 중인 연수 기수가 없습니다.</td>
					</tr>
					</c:if>
				</tbody>
			</table>
		</div><!--//.group-->
		<div class="group">
			<div class="group-header">
				<h3>3학점(45시간) 연수 일정</h3>
				<p class="ctrl-btnSet">※ 출석 고사 없음.</p>
			</div>
			<table class="list">
				<colgroup>
					<col width="">
					<col width="220">
					<col width="220">
					<col width="220">
					<col width="100">
				</colgroup>
				<thead>
					<tr>
						<th scope="col">연수 기수</th>
						<th scope="col">신청 기간</th>
						<th scope="col">연수 기간</th>
						<th scope="col">이수증 발급</th>
						<th scope="col" class="item-function">비고</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="list" items="${credit3List}">
					<tr>
						<td><strong><c:out value="${list.NAME }"/></strong></td>
						<td><c:out value="${list.APP_START_DATE }"/> ~ <c:out value="${list.APP_END_DATE }"/></td>
						<td><c:out value="${list.LEARN_START_DATE }"/> ~ <c:out value="${list.LEARN_END_DATE }"/></td>
						<td><c:out value="${list.ISSUE_DATE }"/></td>
						<td class="item-function">
							<c:if test="${list.STATUS != 'Y' }"><c:out value="${list.STATUS_NAME }"/></c:if>
							<c:if test="${list.STATUS == 'Y' }"><a class="btn blit btnCheck primary" href="<c:url value="/learn/course/grades?credit="/>${list.APP_POSSIBLES}">연수 신청</a></c:if>
						</td>
					</tr>
					</c:forEach>
					<c:if test="${empty credit3List }">
					<tr>
						<td class="alignC" colspan="5">진행 중인 연수 기수가 없습니다.</td>
					</tr>
					</c:if>
				</tbody>
			</table>
		</div><!--//.group-->
		<div class="group">
			<div class="group-header">
				<h3>4학점(60시간) 연수 일정</h3>
				<p class="ctrl-btnSet">※ 출석 고사 있음.</p>
			</div>
			<table class="list">
				<colgroup>
					<col width="">
					<col width="220">
					<col width="220">
					<col width="110">
					<col width="110">
					<col width="100">
				</colgroup>
				<thead>
					<tr>
						<th scope="col">연수 기수</th>
						<th scope="col">신청 기간</th>
						<th scope="col">연수 기간</th>
						<th scope="col">출석 고사</th>
						<th scope="col">이수증 발급</th>
						<th scope="col" class="item-function">비고</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="list" items="${credit4List}">
					<tr>
						<td><strong><c:out value="${list.NAME }"/></strong></td>
						<td><c:out value="${list.APP_START_DATE }"/> ~ <c:out value="${list.APP_END_DATE }"/></td>
						<td><c:out value="${list.LEARN_START_DATE }"/> ~ <c:out value="${list.LEARN_END_DATE }"/></td>
						<td><c:out value="${list.ATT_EVAL_DATE }"/>. <c:out value="${list.ATT_EVAL_TIME }"/> </td>
						<td><c:out value="${list.ISSUE_DATE }"/></td>
						<td class="item-function">
							<c:if test="${list.STATUS != 'Y' }"><c:out value="${list.STATUS_NAME }"/></c:if>
							<c:if test="${list.STATUS == 'Y' }"><a class="btn blit btnCheck primary" href="<c:url value="/learn/course/grades?credit="/>${list.APP_POSSIBLES}">연수 신청</a></c:if>
						</td>
					</tr>
					</c:forEach>
					<c:if test="${empty credit4List }">
					<tr>
						<td class="alignC" colspan="6">진행 중인 연수 기수가 없습니다.</td>
					</tr>
					</c:if>
				</tbody>
			</table>
		</div><!--//.group-->
	</div><!--//.sub-body-->
</div><!--//.body-->
<!--// 1.3. 본문 -->

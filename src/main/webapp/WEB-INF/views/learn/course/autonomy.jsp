<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="t"%>

<script type="text/javascript">
$(document).ready(function () {
	$('#courseSort button').click(function() {
		$('#courseSort button.on').removeClass('on');
		$(this).addClass('on');
		searchList();
	});

	// 탭 갯수 자동 판별
	if($.fn.tabLength != null ) $('.tab-group > .tab-header.sub').tabLength();

	$('.tooltip').tooltip();
});

function searchList(course_code) {
	if(typeof(course_code) == 'undefined') {
		course_code = $('#moveForm input[name="course_code"]').val();
	}
	var sort = $('#courseSort button.on').data('sort') || '';
	location.href = '<c:url value="/learn/course/autonomy"/>?course_code='+course_code+'&sort='+sort;
}
</script>
<t:insertDefinition name="leftmenu"/>

<!-- 1.3. 본문 -->
		<div class="body">
			<div class="sub-header">
				<p class="sub-nav">
					<a class="nth-1st" href="/"><span class="sr-only">HOME</span></a>
					<a href="#">연수 신청</a>
					<a class="nth-last" href='${contextPath}'>자율 연수</a>
				</p>
				<h2 class="sub-title">자율 연수 </h2>
				<!--p class="sub-title-copy">제목을 보조해주는 문구 삽입</p-->
			</div><!--//.sub-header-->
			<div class="sub-body">
				<c:if test="${not currentDevice.mobile }"><t:insertDefinition name="commonslide"/></c:if>
				<div class="tab-group">
					<ul class="tab-header sub">
						<li><a class='nth-1st <c:if test="${'0' eq param.get('course_code')}">on</c:if>' href="javascript:searchList('0')">전체 보기</a></li>
						<c:forEach var="code" items="${courseCategoryList}" varStatus="status">
						<li><a class='<c:if test="${(code.CODE) eq param.get('course_code')}">on</c:if>' href="javascript:searchList('${code.CODE}')">${code.NAME}</a></li>
						</c:forEach>
					</ul>
					<div class="tab-body">
						<div class="list-top">
							<p>총 <strong>${listCnt}</strong>개의 과정이 검색되었습니다.</p>
							<p class="ctrl-btnSet" id="courseSort">
								<strong class="icon ci-align"><span class="sr-only">정렬 :</span></strong>
								<button class="<c:if test="${empty param.sort or param.sort eq 'H'}">on</c:if> nth-1st" type="button" data-sort="H"><span>인기순</span></button>
								<button type="button" class="<c:if test="${param.sort eq 'S'}">on</c:if>" data-sort="S"><span>판매순</span></button>
								<button type="button" class="<c:if test="${param.sort eq 'D'}">on</c:if>" data-sort="D"><span>최신순</span></button>
							</p>
						</div>
						<table id="list-learn" class="list">
							<colgroup>
							<col width="">
							<col width="100">
							<col width="100">
							<col width="80">
							<col width="80">
							<col width="50">
							<col width="120">
							</colgroup>
							<thead>
								<tr>
									<th scope="col" class="item-title">연수 과정명</th>
									<th scope="col" class="item-teacher">강사명</th>
									<th scope="col" class="item-score">학점</th>
									<th scope="col" class="item-price">연수비</th>
									<th scope="col" class="item-book">교재</th>
									<th scope="col" class="item-function">미리 보기</th>
									<th scope="col" class="item-function">연수 신청</th>
								</tr>
							</thead>
							<tbody>
							<c:if test="${!empty list}">
							<c:forEach var="list" items="${list}" varStatus="status">
								<tr class="nth-1st"><!-- ie8에서는 nth-first 선택자를 이용할 수 없으므로 첫번째 아이템에만 class 명으로 부여 -->
									<td class="item-title"><a href="detail?course_id=${list.course_id}"><strong>${list.name}</strong></a>
										<span class="iconSet">
											<c:if test="${fn:contains(list.icon_displays, '1')}"><em class="icon-new">NEW</em></c:if>
											<c:if test="${fn:contains(list.icon_displays, '2')}"><em class="icon-best">BEST</em></c:if>
											<c:if test="${fn:contains(list.icon_displays, '3')}"><em class="icon-pop">인기</em></c:if>
											<c:if test="${fn:contains(list.icon_displays, '4')}"><em class="icon-upgrade">업그레이드</em></c:if>
											<c:if test="${fn:contains(list.icon_displays, '5')}"><em class="icon-great">우수</em></c:if>
										</span>
									</td>
									<td class="item-teacher">${list.teacher_name}</td>
									<td class="item-score">${list.credit}학점(${list.credit_time}시간)</td>
									<td class="item-price"><fmt:formatNumber value="${list.price}" groupingUsed="true"/>원</td>
									<td class="item-book">
										<c:if test="${not empty list.main_tb_name }"><a href="#" class="tooltip" title="${list.main_tb_name }">교재</a></c:if>
										<c:if test="${empty list.main_tb_name}">없음</c:if>
									</td>
									<td class="item-function">
										<c:if test="${not empty list.tasting_url }"><a class="btn line icon btnWatch" href="${list.tasting_url }" target="_blank"><span class="sr-only">미리 보기</span></a></c:if>
										<c:if test="${empty list.tasting_url }"><a class="btn line icon btnWatch" href="javascript:alertNoPreview()"><span class="sr-only">미리 보기</span></a></c:if>
									</td>
									<td class="item-function">
										<a class="btn blit btnCheck primary notation" href="#" data-course="${list.course_id}">연수 신청</a>
									</td>
								</tr>
							</c:forEach>
							</c:if>
							<c:if test="${empty list}">
								<tr class="nth-1st">
									<td colspan="7">조회된 내용이 없습니다.</td>
								</tr>
							</c:if>
							</tbody>
						</table>
					</div><!--//.tab-body-->
				</div><!--.tab-groyp-->
			</div><!--//.sub-body-->
			<!--본문 내용 출력 공간-->
		</div><!--//.body-->
<!--// 1.3. 본문 -->
<form id="moveForm">
<input type="hidden" name="course_code" value="${param.course_code }"/>
</form>
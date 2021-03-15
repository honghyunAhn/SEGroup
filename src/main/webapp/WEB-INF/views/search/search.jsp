<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="http://www.aracomm.com/customtag/util" %>

<script type="text/javascript">
// 리뷰보기(팝업)
function popupReview(id) {
	var layerId  = 'layerReviewDetail';
	if($('#'+layerId).length > 0) $('#'+layerId).remove();
	$.ajax({
		type: "POST",
		url: "<c:url value='/learn/course/layer/reviewdetail' />",
		dataType: "text",
		data: {'id': id},
		success: function(txt) {
			$(document.body).append(txt);
			popupOpen(layerId);
		}
	});
}

</script>

<div class="body">
	<div class="sub-header">
		<h2 class="sub-title">검색결과</h2>
		<p class="sub-title-copy"><strong class="primary">'${param.keyword }'</strong>로 검색한 결과입니다.</p>
	</div><!--//.sub-header-->
	<div id="searchResult" class="sub-body">
       <div class="group">
			<div class="section-header">
				<h4>연수 신청</h4>
			</div>
			<div class="section-body borderT gallery">
				<c:forEach var="item" items="${courseList}" varStatus="status">
	           	<div class="item">
					<div class="item-img"><img src="<c:url value="${item.photo_url }"/>"></div>
					<div class="item-summary">
						<em class="item-type v<c:out value="${item.credit }"/>"><c:out value="${item.credit }"/>학점</em>
						<strong><a class="item-title" href="<c:url value="/learn/course/detail"/>?course_id=${item.course_id }"><c:out value="${item.name }"/></a></strong>
						<ul class="item-info">
							<li class="learn-course"><em class="sr-only">연수 영역: </em><c:out value="${item.course_code_name }"/></li>
							<li class="learn-time"><em class="sr-only">수강 기간: </em><c:out value="${item.credit_time }"/>시간</li>
						</ul>
						<p class="item-function">
							<c:if test="${not empty item.tasting_url }"><a class="btn line blit btnWatch" href="${item.tasting_url }" target="_blank">미리 보기</a></c:if>
							<c:if test="${empty item.tasting_url }"><a class="btn line blit btnWatch" href="javascript:alertNoPreview()" target="_blank">미리 보기</a></c:if>
							<a class="btn blit btnCheck primary" href="javascript:popCourseCardinalSelect('${item.course_id }')">연수 신청</a>
						</p>
					</div>
				</div>
				</c:forEach>
				<c:if test="${empty courseList}">
				<div class="alignC" style="text-align-last:center;padding:30px">검색된 내용이 없습니다.</div>
				</c:if>
			</div><!--.section-body.gallery-->
		</div><!--//.section(연수신청검색결과)-->
       <div class="section">
			<div class="section-header">
				<h4>강사 소개</h4>
			</div>
			<div class="section-body borderT teacher-list">
				<c:forEach var="item" items="${teacherList }">
				<a class="item" href="<c:url value="/teacher/detail?id=${item.ID }"/>">
					<div class="item-img"><img src="<c:url value="${item.PHOTO_URL }"/>"></div>
					<div class="item-summary">
						<em class="item-category"><c:out value="${item.MAIN_COURSE_NAME }"/></em>
						<strong class="item-title"><c:out value="${item.NAME }"/></strong>
					</div>
				</a>
				</c:forEach>
				<c:if test="${empty teacherList }">
				<div class="alignC" style="text-align-last:center;padding:30px">검색된 내용이 없습니다.</div>
				</c:if>
			</div>
		</div><!--//.section(강사소개검색결과)-->
       	<div class="section">
			<div class="section-header">
				<h4>연수 후기</h4>
         	</div>
         	<table class="list">
				<thead>
					<tr>
					  <th scope="col" class="item-number">번호</th>
					  <th scope="col" class="item-title">제목</th>
					  <th scope="col" class="item-name">작성자</th>
					  <th scope="col" class="item-date">등록일</th>
					  <th scope="col" class="item-view_count">조회수</th>
					</tr>
				</thead>
           		<tbody>
				<c:forEach var="item" items="${bbsList }" varStatus="status">
               	<tr>
					<td class="item-number">${status.index + 1 }</td>
					<td class="item-title"><a href="javascript:popupReview('${item.id }')"><strong>${item.title }</strong></a></td>
					<td class="item-name">
						<c:choose>
						<c:when test="${empty item.user_name }">${item.reg_name }</c:when>
						<c:otherwise>${item.user_name }</c:otherwise>
						</c:choose>
					</td>
					<td class="item-date">${item.reg_date_format2 }</td>
					<td scope="col" class="item-view_count">${item.hits }</td>
               	</tr>
				</c:forEach>
				<c:if test="${empty bbsList}">
			 		<tr><td colspan="5">검색된 내용이 없습니다.</td></tr>
			 	</c:if>
				</tbody>
        	</table>
		</div><!--//.section(연수후기검색결과)-->
	</div><!--//.sub-body-->
	<!--본문 내용 출력 공간-->
</div><!--//.body-->
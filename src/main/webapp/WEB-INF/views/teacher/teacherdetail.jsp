<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %>
<%@ taglib prefix="util" uri="http://www.aracomm.com/customtag/util" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="t"%>

<script type="text/javascript">
$(function () {
	// TCC 영상 롤링
	$('#tcc-rolling').slick({
		dots: true,
			slidesToShow: 5,
			slidesToScroll: 1,
		autoplay: true,
			autoplaySpeed: 8000000,
			prevArrow : '<a class="ctrl-btn btn-prev" href="#recommend-learn">이전</a>',
			nextArrow : '<a class="ctrl-btn btn-next" href="#recommend-learn">다음</a>',
			customPaging: function(slider, i) {
					return $('<button type="button" />').text(i + 1);
			},
	});
})

function goList() {
	$('#searchForm').submit();
}

// 게시물보기
function popupBoardeDetail(board_type, id) {
	var layerId  = 'layerBoardDetail';
	if($('#'+layerId).length > 0) $('#'+layerId).remove();
	$.ajax({
		type: "POST",
		url: "<c:url value='/teacher/board/layerdetail' />",
		dataType: "text",
		data: {'board_type': board_type, 'id': id},
		success: function(txt) {
			$(document.body).append(txt);
			popupOpen(layerId);
		}
	});
}
</script>

<t:insertDefinition name="teacherleftmenu"/>

<!-- 1.3. 본문 -->
<div class="body">
	<div class="sub-header">
		<p class="sub-nav">
			<a class="nth-1st" href="<c:url value="/"/>"><span class="sr-only">HOME</span></a>
			<a class="nth-last" href="#">강사 소개</a>
		</p>
		<h2 class="sub-title">강사 소개</h2>
	</div>
	<div class="sub-body">
		<div class="teacher-detail">
			<div class="teacher-header">
				<img src="${teacher.PHOTO_URL }" alt="강사사진">
				<a class="blit bi-arrowBack" href="javascript:goList()"> 목록으로 돌아가기</a>
			</div><!--//.teacher-header-->
			<div class="teacher-body">
				<div class="section">
					<div class="section-header">
						<h4>TCC 영상</h4>
					</div>
					<div class="section-body borderT" style="height:220px">
						<c:if test="${empty tccList }">
						<div class="alignC" style="padding-top:50px">등록된 TCC가 없습니다.</div>
						</c:if>
						<c:if test="${not empty tccList }">
						<div class="tcc-list">
						<%--
						<!-- 고정 되는 영상 Start -->
							<div class="item">
								<div class="item-img"><iframe width="100%" height="100%" src="https://www.youtube.com/embed/QIN5_tJRiyY" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe></div>
								<a class="item-title" href="#" target="_blank">영상 제목 출력 영상 제목 출력 영상 제목 출력</a>
								<span class="item-playtime"><em class="sr-only">재생횟수: </em>306</span>
							</div>
							<div class="item">
								<div class="item-img"><img src="/resources/images/imsi/teacher_photo.jpg" alt="영상섬네일"></div>
								<a class="item-title" href="#" target="_blank">영상 제목 출력</a>
								<span class="item-playtime"><em class="sr-only">재생횟수: </em>306</span>
							</div>
						<!--// 고정 되는 영상 END -->
						 --%>
							<!--// 롤링 영상 Start -->
							<div id="tcc-rolling" class="rolling-zone" style="width:100%;position: relative;">
								<c:forEach var="item" items="${tccList }">
								<div class="item">
									<div class="item-img">
										<iframe width="100%" height="100%" src="${item.URL }" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>
									</div>
									<a class="item-title" href="#" target="_blank"><c:out value="${item.TITLE }"/></a>
									<!-- <span class="item-playtime"><em class="sr-only">재생횟수: </em>306</span> -->
								</div>
								</c:forEach>
							</div>
							<!--// 롤링 영상 END -->
						</div><!--//.tcc-list-->
						</c:if>
					</div><!--//.section-body-->
				</div><!--//.section-->
				<div class="section clearL">
					<div class="section-header">
						<h4>개설 연수 과정</h4>
					</div>
					<div class="section-body borderT">
						<table id="list-learn" class="list">
							<thead>
								<tr>
									<th scope="col" class="item-course">연수 영역</th>
									<th scope="col" class="item-title">연수 과정명</th>
									<th scope="col" class="item-score">학점</th>
									<th scope="col" class="item-price">연수비</th>
									<th scope="col" class="item-book">교재</th>
									<th scope="col" class="item-function">미리 보기</th>
									<th scope="col" class="item-function">연수 신청</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="item" items="${courseList }">
								<tr>
									<td class="item-course"><c:out value="${item.COURSE_CODE_NAME }"/></td>
									<td class="item-title">
										<%-- <strong <c:if test="${item.MOBILE_YN == 'Y' }">class="learn-mobile"</c:if>><span class=sr-only>모바일 연수 가능</span></strong> --%>
										<a href="<c:url value="/learn/course/detail"/>?course_id=${item.ID }"><strong><c:out value="${item.NAME }"/></strong></a>
									</td>
									<td class="item-score"><c:out value="${item.CREDIT }"/>학점</td>
									<td class="item-price"><fmt:formatNumber value="${item.PRICE }"/></td>
									<td class="item-book">
										<c:if test="${not empty item.MAIN_TB_NAME }">${item.MAIN_TB_NAME }</c:if>
										<c:if test="${empty item.MAIN_TB_NAME}">없음</c:if>
									</td>
									<td class="item-function">
									<c:if test="${not empty item.TASTING_URL }">
										<a class="btn line icon btnWatch" href="${item.TASTING_URL }" target="_blank"><span class="sr-only">미리 보기</span></a>
									</c:if>
									<c:if test="${empty item.TASTING_URL }">
										<a class="btn line icon btnWatch" href="javascript:alertNoPreview()"><span class="sr-only">미리 보기</span></a>
									</c:if>
									</td>
									<td class="item-function"><a class="btn blit btnCheck primary" href="javascript:popCourseCardinalSelect('${item.ID }')">연수 신청</a></td>
								</tr>
								</c:forEach>
								<c:if test="${empty courseList }"><tr><td colspan="7" class="alignC">개설된 과정이 없습니다.</td></tr></c:if>
							</tbody>
						</table>
					</div><!--//.section-body-->
				</div><!--//.section-->
				<div class="group">
					<div class="section">
						<div class="section-header">
							<h4>공지 사항</h4>
						</div>
						<div class="section-body borderT">
							<ul class="latest-list">
								<c:forEach var="item" items="${noticeList }">
								<li><a href="javascript:popupBoardeDetail('${item.BOARD_TYPE }',${item.ID })"><util:strcut len="50" value="${item.TITLE }"/></a></li>
								</c:forEach>
								<c:if test="${empty noticeList }"><li class="alignC">등록된 공지 사항이 없습니다.</li></c:if>
							</ul>
						</div>
					</div><!--//.section-->
					<div class="section">
						<div class="section-header">
							<h4>질의 응답</h4>
						</div>
						<div class="section-body borderT">
							<ul class="latest-list">
								<c:forEach var="item" items="${qnaList }">
								<li><a href="javascript:popupBoardeDetail('${item.BOARD_TYPE }',${item.ID })"><util:strcut len="50" value="${item.TITLE }"/></a></li>
								</c:forEach>
								<c:if test="${empty qnaList }"><li class="alignC">등록된 질의응답이 없습니다.</li></c:if>
							</ul>
						</div>
					</div><!--//.section-->
					<div class="section">
						<div class="section-header">
							<h4>연수 후기</h4>
						</div>
						<div class="section-body borderT">
							<ul class="latest-list">
								<c:forEach var="item" items="${reviewList }">
								<li><a href="javascript:popupBoardeDetail('${item.BOARD_TYPE }',${item.ID })"><c:out value="${item.TITLE }"/></a></li>
								</c:forEach>
								<c:if test="${empty reviewList }"><li class="alignC">등록된 후기가 없습니다.</li></c:if>
							</ul>
						</div>
					</div><!--//.section-->
				</div><!--//.group-->
			</div><!--//.teacher-body-->
		</div><!--//.teacher-detail-->
		<p class="alignC">
			<a class="blit bi-arrowBack" href="javascript:goList()"> 목록으로 돌아가기</a>
		</p>
	</div><!--//.sub-body-->
	<!--본문 내용 출력 공간-->
</div><!--//.body-->
<!--// 1.3. 본문 -->

<form id="searchForm" name="searchForm" method="post" action="<c:url value="/teacher/list"/>">
<input type="hidden" name="startPage" value="${searchVo.startPage}">
<input type="hidden" name="course" value="${searchVo.course}">
</form>

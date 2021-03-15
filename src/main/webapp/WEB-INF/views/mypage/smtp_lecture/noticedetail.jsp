<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="t"%>

<script type="text/javascript">
$(document).ready(function(){
});
</script>
<script type="text/javascript">
function goList() {
	$('#moveForm').attr('action', 'notice');
	$('#moveForm').submit();
}

function goDetail(id) {
	$('#moveForm input[name="id"]').val(id);
	$('#moveForm').attr('action', '<c:url value="${detailUrl}"/>');
	$('#moveForm').submit();
}

function goWrite() {
	$('#moveForm').attr('action', '<c:url value="${writeUrl}"/>');
	$('#moveForm').submit();
}

function doDelete() {
	if (confirm('정말 삭제하시겠습니까?')) {
		$('#moveForm').attr('action', '<c:url value="${deleteUrl}"/>');
		$('#moveForm').submit();
	}
}
</script>

<t:insertDefinition name="mypageleftmenu"/>
<!-- 1.3. 본문 -->
	<div class="body">
			<div class="sub-header">
				<p class="sub-nav">
					<a class="nth-1st" href="/"><span class="sr-only">HOME</span></a>
					<a href="#">나의 강의실</a>
					<a class="nth-last" href="${contextPath}">강의실</a>
				</p>
				<h2 class="sub-title">${classInfo.NAME }</h2>
				<!--p class="sub-title-copy">제목을 보조해주는 문구 삽입</p-->
			</div><!--//.sub-header-->
			<div class="sub-body">
				<div class="tab-group">
					<ul class="tab-header sub x7">
							<li><a href="classroom?id=${classParam.id }&cardinal=${classParam.cardinal }&course=${classParam.course }">홈</a></li>
							<li><a href="lesson?id=${classParam.id }&cardinal=${classParam.cardinal }&course=${classParam.course }">강의 보기</a></li>
							<li><a href="report?id=${classParam.id }&cardinal=${classParam.cardinal }&course=${classParam.course }">온라인 과제</a></li>
							<li><a href="exam?id=${classParam.id }&cardinal=${classParam.cardinal }&course=${classParam.course }">온라인 시험</a></li>
							<li><a class="nth-1st on" href="notice?id=${classParam.id }&cardinal=${classParam.cardinal }&course=${classParam.course }">공지 사항</a></li>
							<li><a href="dataroom?id=${classParam.id }&cardinal=${classParam.cardinal }&course=${classParam.course }">자료실</a></li>
							<li><a href="qna?id=${classParam.id }&cardinal=${classParam.cardinal }&course=${classParam.course }">질의 답변</a></li>
						</ul>
					<div class="tab-body">
				<!-- 탭별 로드되는 부분 Start -->
							<div class="group">
								<div class="group-header">
									<h3>공지 사항</h3>
								</div>
								<div class="board-view">
									<div class="view-header">
										<h3 class="view-title">${detail.title} ${icon }</h3>
										<div class="view-info">
											<span class="writer">작성자<strong>
												<c:choose>
													<c:when test="${empty detail.user_id}">관리자</c:when>
													<c:otherwise>${detail.user_name}</c:otherwise>
												</c:choose>
											</strong></span>
											<span class="date">작성일<strong>${detail.reg_date_format2}</strong></span>
											<span class="hit">조회<strong>${detail.hits}</strong></span>
											<span class="Attachments">첨부 파일
												<c:forEach var="list" items="${fileList }">
												<strong><a href="<c:url value="${list.url_path}"/>" target="_blank">${list.origin_file_name}</a> </strong>
												</c:forEach>
											</span>
										</div>
									</div>
									<div class="view-body">
										<div>${detail.comment}</div>
									</div>
									<div class="view-bottom">
										<div class="Attachments">첨부 파일
											<c:forEach var="list" items="${fileList }">
											<strong><a href="<c:url value="${list.url_path}"/>" target="_blank">${list.origin_file_name}</a> </strong>
											</c:forEach>
										</div>
										<div class="view-util">
											<div class="btnSet">
												<c:forEach var="item" items="${preNext }" varStatus="status">
												<c:choose>
													<c:when test="${item.gubun == 'PREV' }"><a href="javascript:goDetail('<c:out value="${item.id }"/>')" class="btn float_left primary">이전</a></c:when>
													<c:otherwise><a href="javascript:goDetail('<c:out value="${item.id }"/>')" class="btn float_left danger">다음</a></c:otherwise>
												</c:choose>
												</c:forEach>
												<c:if test="${not empty bbsAuth }">
													<c:if test="${bbsAuth.modifyable}"><a href="javascript:goWrite()" class="btn float_right primary">수정</a></c:if>
													<c:if test="${bbsAuth.deletable}"><a href="javascript:doDelete()" class="btn float_right danger delete">삭제</a></c:if>
												</c:if>
												<a href="javascript:goList()" class="btn float_right primary">목록</a>
											</div>
										</div>
									</div>
								</div>
								</div><!--//.group-body-->
							</div><!--//.group-->
				<!--// 탭별 로드되는 부분 END -->
						</div>
				</div><!--.tab-group-->
			</div><!--//.sub-body-->
<!-- 1.3. 본문 -->

		<form id="moveForm" name="moveForm" action="post">
		<input type="hidden" name="startPage" value="<c:out value="${bbsParam.startPage }"/>"/>
		<input type="hidden" name="searchbox" value="<c:out value="${bbsParam.searchbox }"/>"/>
		<input type="hidden" name="search" value="<c:out value="${bbsParam.search }"/>"/>
		<input type="hidden" name="bbsid" value="<c:out value="${detail.id }"/>"/>
		<input type="hidden" name="cardinal" value="${classParam.cardinal }" />
		<input type="hidden" name="course" value="${classParam.course }"  />
		<input type="hidden" name="id" value="${classParam.id }"  />
		</form>
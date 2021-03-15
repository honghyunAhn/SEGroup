<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="t"%>

<script type="text/javascript">
function goList() {
	$('#moveForm').attr('action', '<c:url value="${listUrl}"/>');
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

<c:set var="icon" value=""/>
<c:choose>
	<c:when test="${detail.icon == '1' }">
	<c:set var="icon" value="New"/>
	</c:when>
	<c:when test="${detail.icon == '2' }">
	<c:set var="icon" value="Hot"/>
	</c:when>
</c:choose>

		<div class="sub-body">
			<div class="tab-group">
				<div class="tab-body">
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
								<span class="date">작성일<strong>${detail.reg_date_format2}.</strong></span>
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
				</div><!--//.tab-body-->
			</div><!--.tab-groyp-->
		</div><!--//.sub-body-->

		<form id="moveForm" name="moveForm" action="post">
		<input type="hidden" name="startPage" value="<c:out value="${param.startPage }"/>"/>
		<input type="hidden" name="board_type" value="<c:out value="${param.board_type }"/>"/>
		<input type="hidden" name="notice_type"value="<c:out value="${param.notice_type }"/>"/>
		<input type="hidden" name="searchbox" value="<c:out value="${param.searchbox }"/>"/>
		<input type="hidden" name="search" value="<c:out value="${param.search }"/>"/>
		<input type="hidden" name="listQuery" value="<c:out value="${param.listQuery }"/>"/>  <!-- 리스트페이지 검색조건 파라메터 유지 -->
		<input type="hidden" name="id" value="<c:out value="${detail.id }"/>"/>
		</form>
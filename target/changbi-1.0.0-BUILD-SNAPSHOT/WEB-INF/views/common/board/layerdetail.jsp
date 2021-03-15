<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script type="text/javascript">
$(document).ready(function() {
	$('#layerBoardDetail .cl-popup-closer, #layerBoardDetail .close').off('click');
	$('#layerBoardDetail .cl-popup-closer, #layerBoardDetail .close').click(function() {
		$(".cl-popup-overlay").removeClass("on");
	});
});
</script>

<!--// 리뷰보기 팝업 -->
<div class="cl-popup-overlay" id="layerBoardDetail">
	<div class="cl-popup-wrap">
		<c:choose>
			<c:when test="${currentDevice.mobile }">
		<div class="cl-popup-box full">
			</c:when>
			<c:otherwise>
		<div class="cl-popup-box mid" style="width:700px; margin-left:-350px;">
			</c:otherwise>
		</c:choose>
			<div class="popup-header">
				<h3 class="popup-title">
					<c:choose>
					<c:when test="${detail.board_type == '1' }">공지 사항</c:when>
					<c:when test="${detail.board_type == '2' }">자료실</c:when>
					<c:when test="${detail.board_type == '3' }">FAQ</c:when>
					<c:when test="${detail.board_type == '4' }">1:1 상담</c:when>
					<c:when test="${detail.board_type == '5' }">연수 후기</c:when>
					<c:when test="${detail.board_type == '6' }">질의 응답</c:when>
					</c:choose>
				</h3>
			</div>
			<div class="popup-body">
				<div class="board-view">
					<div class="view-header">
						<h3 class="view-title">${detail.title} ${icon }</h3>
						<div class="view-info">
							<span class="writer">작성자<strong>
								<c:choose>
									<c:when test="${empty detail.user_id}">${detail.reg_name}</c:when>
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
							<div class="btnSet alignC">
								<a href="#" class="btn primary close">닫기</a>
							</div>
						</div>
					</div>
				</div>
			</div><!--//.popup-body-->
		</div><!--//.cl-popup-box-->
	</div><!--//.cl-popup-wrap-->
	<button class="cl-popup-closer">
		<span class="sr-only">닫기</span>
	</button>
</div><!--//.cl-popup-overlay-->
<!--// 리뷰보기 팝업 -->

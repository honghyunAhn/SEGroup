<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script type="text/javascript">
$(document).ready(function() {
	$('#layerBookInfo .cl-popup-closer, #layerBookInfo .close').off('click');
	$('#layerBookInfo .cl-popup-closer, #layerBookInfo .close').click(function() {
		$(".cl-popup-overlay").removeClass("on");
	});
});
</script>

<!--// 교재보기 팝업 -->
<div class="cl-popup-overlay" id="layerBookInfo">
	<div class="cl-popup-wrap">
		<c:choose>
			<c:when test="${currentDevice.mobile }">
		<div class="cl-popup-box full">
			</c:when>
			<c:otherwise>
		<div class="cl-popup-box mid" style="width:600px; margin-left:-300px;">
			</c:otherwise>
		</c:choose>
			<div class="popup-header">
				<h3 class="popup-title">연수 교재 안내</h3>
				<p>${book.COURSE_NAME} 교재 </p>
			</div>
			<div class="popup-body">
				<div class="detailView">
					<c:if test="${not empty book.IMG1_URL }"><div class="item-img"><img src="${book.IMG1_URL }"></div></c:if>
					<h4 class="item-title">${book.NAME}</h4>
					<ul class="info-list">
						<li class="item-author"><em class="label">저자</em> ${book.AUTHOR} 저</li>
						<li class="item-publisher"><em class="label">출판사</em> ${book.SUPPLIER} </li>
						<li class="item-price"><em class="label">가격</em> <fmt:formatNumber value="${book.COURSE_PRICE}"/>원</li>
					</ul>
					<div class="item-detail html-view">
						${book.MEMO}
					</div>
				</div>
			</div><!--//.popup-body-->
		</div><!--//.cl-popup-box-->
	</div><!--//.cl-popup-wrap-->
	<button class="cl-popup-closer">
		<span class="sr-only">닫기</span>
	</button>
</div><!--//.cl-popup-overlay-->
<!--// 교재보기 팝업 -->
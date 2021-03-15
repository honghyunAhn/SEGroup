<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script type="text/javascript" src="/resources/js/jsrender.js"></script><!-- template lib  -->
<script type="text/javascript">
$(document).ready(function() {
	$('#layerMyCoupon .cl-popup-closer').off('click');
	$('#layerMyCoupon .cl-popup-closer').click(function() {
		$(".cl-popup-overlay").removeClass("on");
	});

	searchCoupon(1);
});

function searchCoupon(page) {
	page = page?page:1;

	$('#layerMyCoupon input[name="startPage"]').val(page);
	$.getJSON('<c:url value="/learn/apply/ajaxMyCourseCouponList"/>', $('#couponSearchForm').serialize(), function(data) {
		if (typeof(data.searchVo) == 'undefined' || typeof(data.couponList) == 'undefined') {
			$('#layerMyCoupon .pagination').twbsPagination('destroy');
			return;
		}
		// list display
		if (data.couponList.length > 0) {
			$("#layerMyCoupon .listbody").html($("#couponListTmpl").render(data.couponList));

			// paging
			var searchVo = data.searchVo;;
			var totalPages = searchVo.totalPages;

			$('#availableCouponNum').text(searchVo.totalCnt);
			var currentPage = $('#layerMyCoupon .pagination').twbsPagination('getCurrentPage');
			$('#layerMyCoupon .pagination').twbsPagination('destroy');
			$('#layerMyCoupon .pagination').twbsPagination($.extend({}, {
		        totalPages: 1,
		        visiblePages: 5,
		        startPage: 1,
		        first : "",
		        prev : "«",
		        next : "»",
		        last : "",
		        initiateStartPageClick : false,
		        onPageClick: function (event, page) {
		        	searchCoupon(page);
		        }
		   	}, {
				startPage: currentPage > totalPages ? totalPages : currentPage,
				totalPages: totalPages
			}));
		} else {
			$("#layerMyCoupon .listbody").html('<tr><td colspan="4">선택할 수 있는 쿠폰이 없습니다.</td></tr>');
		}

	});
}

// 쿠폰선택
function selectCoupon(couponId) {
	var $tr = $('#coupon'+couponId);
	onSelectCoupon({
		'id': couponId,
		'name': $tr.data('name'),
		'coupon_num': $tr.data('couponnum'),
		'cond': $tr.data('cond'),
		'coupon': $tr.data('coupon'),
		'coupon_type': $tr.data('coupontype'),
		'course_id': $tr.data('courseid')
	});
	$(".cl-popup-overlay").removeClass("on");
}
</script>
<!-- 기수리스트 템플릿 -->
<script id="couponListTmpl" type="text/x-jsrender">
<tr id="coupon{{:ID}}" data-couponnum="{{:COUPON_NUM}}" data-name="{{:NAME}}" data-cond="{{:COND}}" data-coupon="{{:COUPON}}" data-coupontype="{{:COUPON_TYPE}}" data-courseid="{{:COURSE_ID}}" >
	<td> ~ {{:EXP_DATE}}</td>
	<td><strong>{{:COUPON_NUM}}</strong></td>
	<td>{{:NAME}}</td>
	<td>
		<button class="btn primary" onclick="selectCoupon('{{:ID}}')">선택</button>
	</td>
</tr>
</script>

<!--// 2.팝업 -->
<div class="cl-popup-overlay" id="layerMyCoupon">
	<div class="cl-popup-wrap">
		<c:choose>
			<c:when test="${currentDevice.mobile }">
		<div class="cl-popup-box full">
			</c:when>
			<c:otherwise>
		<div class="cl-popup-box mini" style="width:580px; margin-left:-290px; margin-top:-245px">
			</c:otherwise>
		</c:choose>
			<div class="popup-header">
				<h3 class="popup-title">나의 쿠폰함</h3>
			</div>
			<div class="popup-body">
				<form id="couponSearchForm" name="couponSearchForm">
				<input type="hidden" name="startPage" value="1">
				<input type="hidden" name="course_id" value="${param.course_id }">
				</form>
				<ul class="summary-list">
					<li><span class="label">사용 가능 쿠폰</span><strong class="num danger" id="availableCouponNum"> </strong>장</li>
				</ul>
				<table class="list" id="list-deliver">
					<colgroup>
						<col width="120">
						<col width="100">
						<col width="">
						<col width="70">
					</colgroup>
					<thead>
						<tr>
							<th scope="col" class="item-date">사용 가능 기간</th>
							<th scope="col" class="item-code">쿠폰 번호</th>
							<th scope="col">쿠폰 설명</th>
							<th scope="col">선택</th>
						</tr>
					</thead>
					<tbody class="listbody">
					</tbody>
				</table>
				<div class="list-bottom">
					<div class="pagination"></div>
				</div>
			</div><!--//.popup-body-->
		</div><!--//.cl-popup-box-->
	</div><!--//.cl-popup-wrap-->
	<button class="cl-popup-closer">
		<span class="sr-only">닫기</span>
	</button>

</div><!--//.cl-popup-overlay-->
<!--// 2.팝업 END -->
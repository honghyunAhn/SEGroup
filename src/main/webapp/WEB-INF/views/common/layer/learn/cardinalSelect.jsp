<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script type="text/javascript" src="/resources/js/jsrender.js"></script><!-- template lib  -->
<script type="text/javascript">
$(document).ready(function() {
	$('#layerNotationSelect .cl-popup-closer').off('click');
	$('#layerNotationSelect .cl-popup-closer').click(function() {
		$(".cl-popup-overlay").removeClass("on");
	});
	searchCourseCardinal(1);
});

function changeCardinalCourse(course_id) {
	$('#cardinalSearchForm input[name="course_id"]').val(course_id);
	$("#layerNotationSelect .listbody").empty();
	searchCourseCardinal(1);
}
function searchCourseCardinal(page) {
	page = page?page:1;
	$('#cardinalSearchForm input[name="startPage"]').val(page);
	$.getJSON('<c:url value="/learn/course/ajaxCourseNotationList"/>', $('#cardinalSearchForm').serialize(), function(data) {
		if (typeof(data.searchVo) == 'undefined' || typeof(data.cardinalList) == 'undefined') {
			$('#notationPagination').twbsPagination('destroy');
			return;
		}
		// list display
		if (data.cardinalList.length > 0) {
			$("#layerNotationSelect .listbody").html($("#notationListTmpl").render(data.cardinalList));

			// paging
			var searchVo = data.searchVo;;
			var totalPages = searchVo.totalPages;
			var currentPage = $('#notationPagination').twbsPagination('getCurrentPage');
			$('#notationPagination').twbsPagination('destroy');
			$('#notationPagination').twbsPagination($.extend({}, {
		        totalPages: 1,
		        visiblePages: 5,
		        startPage: 1,
		        first : "",
		        prev : "«",
		        next : "»",
		        last : "",
		        initiateStartPageClick : false,
		        onPageClick: function (event, page) {
		        	searchCardinal(page);
		        }
		   	}, {
				startPage: currentPage > totalPages ? totalPages : currentPage,
				totalPages: totalPages
			}));
		} else {
			$("#layerNotationSelect .listbody").html('<tr><td colspan="5">신청할 수 있는 기수가 없습니다.</td></tr>');
		}
	});
}
</script>
<!-- 기수리스트 템플릿 -->
<script id="notationListTmpl" type="text/x-jsrender">
<tr class="nth-1st">
	<td>{{:LEARN_TYPE_NAME}}</td>
	<td>{{:NAME}}</td>
	<td>{{:APP_START_DATE}} ~ {{:APP_END_DATE}}</td>
	<td>{{:LEARN_START_DATE}} ~ {{:LEARN_END_DATE}}</td>
	<td class="item-function"><a class="btn blit btnCheck primary" href="javascript:authAlertApply('{{:COURSE_ID}}','{{:CARDINAL_ID}}')">연수 신청</a></td>
</tr>
</script>
<input type="hidden" id="message" value="${param}"/>
<!--// 2.팝업 -->
<div class="cl-popup-overlay" id="layerNotationSelect">
	<div class="cl-popup-wrap">
		<c:choose>
				<c:when test="${currentDevice.mobile }">
			<div class="cl-popup-box full">
				</c:when>
				<c:otherwise>
			<div class="cl-popup-box mid" style="width:800px; margin-left:-400px;">
				</c:otherwise>
		</c:choose>
			<!--
				팝업타입 별 클래스 & 스타일 제어
					1.폭 800px 이하, 높이 500px 이하 팝업 정가운데 위치)
						- class="cl-popup-box"
						- style="width:폭; height:높이; margin-left:-폭/2; margin-right: -높이/2;"
					2.폭 800px 이하, 높이 500px 이상 가로 가운데 위치
						- class="cl-popup-box mid"
						- style="width:폭; margin-left:-폭/2;"
					3.풀화면 팝업
						- class="cl-popup-box full"
			-->
			<div class="popup-header">
				<h3 class="popup-title">수강하실 연수 기수를 선택해 주세요</h3>
			</div>
			<div class="popup-body">
				<form id="cardinalSearchForm" name="cardinalSearchForm">
					<input type="hidden" name="startPage" value="1">
					<input type="hidden" name="course_id" value="${param.course_id }">
				</form>
				<ul class="check-list">
					<li>
					<strong class="label">신청 과정 </strong>
					<span><c:out value="${param.course_name }"/></span>
					</li>
				</ul>
				<table class="list">
					<thead>
						<tr>
							<th scope="col">연수 구분</th>
							<th scope="col">연수 기수</th>
							<th scope="col">신청 기간</th>
							<th scope="col">연수 기간</th>
							<th scope="col"  class="item-function">신청</th>
						</tr>
					</thead>
					<tbody class="listbody"></tbody>
				</table>
				<div class="list-bottom">
					<div class="pagination" id="notationPagination"></div>
				</div>
			</div><!--//.popup-body-->
		</div><!--//.cl-popup-box-->
	</div><!--//.cl-popup-wrap-->
	<button class="cl-popup-closer">
		<span class="sr-only">닫기</span>
	</button>
</div><!--//.cl-popup-overlay-->
<!--// 2.팝업 END -->
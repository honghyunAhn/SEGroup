<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="t"%>

<script type="text/javascript">
$(document).ready(function(){
	var totalPages = ${searchVo.totalPages};//전체 페이지
    var visiblePages = ${searchVo.visiblePages};//리스트 보여줄 페이지
    var startPage = ${searchVo.startPage};//현재 페이지

    if('${searchVo.totalPages}' != 0){
    	$('#pagination').twbsPagination({
	        totalPages: totalPages,
	        visiblePages: visiblePages,
	        startPage: startPage,
	        first : "",
	        prev : "«",
	        next : "»",
	        last : "",
	        initiateStartPageClick : false,
	        onPageClick: function (event, page) {
	            $('#startPage').val(page);
	            $("#searchForm").submit();
	        }
    	});
 	};

 	$("#tabList li a").click(function(){
 		$('#startPage').val(1);
 		$('#ingYn').val($(this).data('ing'));
 		$("#searchForm").attr('action', '<c:url value="/serviceCenter/event/eventList"/>');
 		$("#searchForm").submit();
 	});

	// 탭 갯수 자동 판별
	if($.fn.tabLength != null ) $('.tab-group > .tab-header.sub').tabLength();
});

function goDetail(id) {
	$('#id').val(id);
	$("#searchForm").attr('action', '<c:url value="/teacher/detail"/>');
	$("#searchForm").submit();
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
		<div class="group">
			<div class="group-header">
				<h4 class="strong">이달의 창비 강사</h4>
			</div>
			<div class="group-body">
				<div id="monthly-teacher" class="sub-banner_hd strongOut">
					<div class="item">
						<img src="/resources/images/imsi/monthly-teacher_02.jpg" alt="교직 기본 소양 이강룡 선생님">
					</div>
					<!--div class="item">
						<video controls>
							<source src="../video/sample.mp4" type="video/mp4">
							<source src="../video/sample.wmv" type="video/wmv">
							<img src="../images/imsi/monthly-teacher_01.jpg" alt="대체 택스트 출력">
						</video>
					</div-->
				</div>
			</div><!--.//.group-body-->
		</div><!--//.group-->
		<div class="tab-group">
			<ul class="tab-header sub">
				<li><a class='nth-1st <c:if test="${empty searchVo.course}">on</c:if>' href="list">전체 보기</a></li>
				<c:if test="${!empty courseList}">
				<c:forEach var="code" items="${courseList}" varStatus="status">
				<li><a class='nth-1st <c:if test="${(code.CODE) eq searchVo.course}">on</c:if>' href="list?course=${code.CODE}">${code.NAME}</a></li>
				</c:forEach>
				</c:if>
			</ul>
			<div class="section tab-body">
				<form id="searchForm" name="searchForm" method="post">
				<input type="hidden" id="startPage" name="startPage" value="${searchVo.startPage}">
				<input type="hidden" id="course" name="course" value="${searchVo.course}">
				<input type="hidden" id="id" name="id">
				</form>
				<div class="teacher-list">
					<c:forEach var="item" items="${teacherList }">
					<a class="item" href="javascript:goDetail('<c:out value="${item.ID }"/>')">
						<div class="item-img"><img src="<c:url value="${item.PHOTO_URL }"/>"></div>
						<div class="item-summary">
							<em class="item-category"><c:out value="${item.MAIN_COURSE_NAME }"/></em>
							<strong class="item-title"><c:out value="${item.NAME }"/></strong>
						</div>
					</a>
					</c:forEach>
					<c:if test="${empty teacherList }">
					<div class="alignC" style="text-align-last:center;padding:30px">조회된 강사가 없습니다.</div>
					</c:if>
				</div>
			</div><!--//.tab-body-->
			<div class="list-bottom">
				<ul id="pagination"></ul>
			</div>
		</div><!--//.tab-group-->
	</div><!--//.sub-body-->
	<!--본문 내용 출력 공간-->
</div><!--//.body-->
<!--// 1.3. 본문 -->

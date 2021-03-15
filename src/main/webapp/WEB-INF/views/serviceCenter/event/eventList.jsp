<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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

});

function goDetail(id) {
	$('#id').val(id);
	$("#searchForm").attr('action', '<c:url value="/serviceCenter/event/eventDetail"/>');
	$("#searchForm").submit();
}
</script>

<t:insertDefinition name="centerleftmenu"/>

<!-- 1.3. 본문 -->
<div class="body">
	<div class="sub-header">
		<p class="sub-nav">
			<a class="nth-1st" href="/"><span class="sr-only">HOME</span></a>
			<a href="#">고객 센터</a>
			<a class="nth-last" href="${contextPath}">이벤트</a>
		</p>
		<h2 class="sub-title">이벤트 </h2>
		<!--p class="sub-title-copy">제목을 보조해주는 문구 삽입</p-->
	</div><!--//.sub-header-->
	<div class="sub-body">
		<div class="tab-group">
			<ul class="tab-header sub x2" id="tabList">
				<li><a class="nth-1st <c:if test="${searchVo.ingYn != 'N'}">on</c:if>" href="#" data-ing="Y">진행 이벤트</a></li>
				<li><a class="<c:if test="${searchVo.ingYn == 'N'}">on</c:if>" href="#" data-ing="N">종료 이벤트</a></li>
			</ul>
			<div class="tab-body">
				<form id="searchForm" name="searchForm" method="post">
				<input type="hidden" id="startPage" name="startPage" value="${searchVo.startPage}">
				<input type="hidden" id="ingYn" name="ingYn" value="${searchVo.ingYn}">
				<input type="hidden" id="id" name="id">
				</form>
				<ul class="event_list">
					<c:forEach var="list" items="${eventList}">
					<li><a href="javascript:goDetail(${list.ID })"><img src="<c:url value="${list.IMG_URL }"/>" alt="이벤트배너"><span><c:out value="${list.TITLE }"/></span></a></li>
					</c:forEach>
				</ul>
		 		<c:if test="${empty eventList}">
				<div class="alignC">조회된 이벤트가 없습니다.</div>
		 		</c:if>
				<div class="list-bottom">
					<ul id="pagination"></ul>
				</div>
			</div><!--//.tab-body-->
		</div><!--.tab-groyp-->
	</div><!--//.sub-body-->
	<!--본문 내용 출력 공간-->
</div><!--//.body-->
<!--// 1.3. 본문 -->

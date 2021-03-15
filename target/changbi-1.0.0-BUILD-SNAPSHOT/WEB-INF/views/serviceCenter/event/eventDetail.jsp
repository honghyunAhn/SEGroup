<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="t"%>


<script type="text/javascript">
function goList() {
	$('#searchForm').submit();
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
		<h2 class="sub-title">이벤트</h2>
	</div>
	<div class="sub-body">
		<div class="tab-group">
			<div class="tab-body">
				<div class="board-view">
					<div class="view-header">
						<h3 class="view-title"><c:out value="${event.TITLE}"/></h3>
					</div>
					<div class="view-body">
						<div>${event.COMMENT}</div>
					</div>
					<div class="view-bottom">
						<div class="view-util">
							<div class="btnSet">
								<a href="javascript:goList()" class="btn float_right primary">목록</a>
							</div>
						</div>
					</div>
				</div>
			</div><!--//.tab-body-->
		</div><!--.tab-groyp-->
	</div><!--//.sub-body-->
	<!--본문 내용 출력 공간-->
</div>
<!--// 1.3. 본문 -->

<form id="searchForm" name="searchForm" method="post" action="<c:url value="/serviceCenter/event/eventList"/>">
<input type="hidden" name="startPage" value="${searchVo.startPage}">
<input type="hidden" name="ingYn" value="${searchVo.ingYn}">
</form>


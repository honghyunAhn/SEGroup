<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="t"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="newline" value="<%= \"\n\" %>" /><%--cr to br --%>

<c:set var="listUrl"><c:url value="/mypage/note/received"/></c:set>
<c:if test="${searchVo.gubun == 'S'}">
<c:set var="listUrl"><c:url value="/mypage/note/sent"/></c:set>
</c:if>
<script type="text/javascript">
$(document).ready(function(){
	$("#searchBtn").click(function(event){
 		$("#listBtn").trigger('click');
 	});

	$(".listBtn").click(function(event){
 		$("#searchForm").submit();
 	});

	$(".replyBtn").click(function(event){
 		$("#searchForm").attr('action', '<c:url value="/mypage/note/form"/>');
 		$("#searchForm").submit();
 	});

	$(".deleteBtn").click(function(event){
 		if(!confirm('정말 삭제하시겠습니까?')) {
 			return;
 		}

 		$("#deleteForm").submit();
 	});
});

</script>

<t:insertDefinition name="mypageleftmenu"/>

<!-- 1.3. 본문 -->
<div class="body">
	<div class="sub-header">
		<p class="sub-nav">
			<a class="nth-1st" href="<c:url value="/"/>"><span class="sr-only">HOME</span></a>
			<a href="#">나의 강의실</a>
			<a class="nth-last" href="#">쪽지함</a>
		</p>
		<h2 class="sub-title">쪽지함 </h2>
		<!--p class="sub-title-copy">제목을 보조해주는 문구 삽입</p-->
	</div><!--//.sub-header-->
	<div class="sub-body">
		<div class="list-top">
			<form id="searchForm" class="body-search" method="post" action="${listUrl }">
				<select id="searchbox" name="searchCondition">
					<option value="TC" ${(empty searchVo.searchCondition or searchVo.searchCondition == 'TC') ? 'selected':''}>제목+내용</option>
					<option value="T" ${searchVo.searchCondition == 'T' ? 'selected':''}>제목</option>
					<option value="C" ${searchVo.searchCondition == 'C' ? 'selected':''}>내용</option>
				</select>
				<input type="text" name="searchKeyword" value="${searchVo.searchKeyword}" placeholder="검색어를 입력하세요.">
				<button type="button" id="searchBtn"><span class="sr-only">검색</span></button>
				<input type="hidden" id="startPage" name="startPage" value="${searchVo.startPage}">
				<input type="hidden" name="gubun" value="${searchVo.gubun}">
				<input type="hidden" name="id" value="${searchVo.id}">
			</form>
		</div>
		<div class="tab-group">
			<ul class="tab-header sub x3">
				<li><a class="nth-1st <c:if test="${searchVo.gubun == 'R'}">on</c:if>" href="<c:url value="/mypage/note/received"/>">받은 쪽지함</a></li>
				<li><a class="<c:if test="${searchVo.gubun == 'S'}">on</c:if>" href="<c:url value="/mypage/note/sent"/>">보낸 쪽지함</a></li>
				<li><a href="<c:url value="/mypage/note/form"/>">쪽지 쓰기</a></li>
			</ul>
			<div class="tab-body">
				<form id="deleteForm" method="post" action="<c:url value="/mypage/note/delete"/>">
				<input type="hidden" name="gubun" value="${searchVo.gubun}">
				<input type="hidden" name="ids" value="${searchVo.id}">
				<div class="board-view">
					<c:choose>
						<c:when test="${searchVo.gubun == 'R' }">
					<div class="view-header">
						<h3 class="view-title"><c:out value="${note.TITLE }"/></h3>
						<div class="view-info">
							<span class="writer">보낸 사람<strong><c:out value="${note.FROM_USER_NAME }"/></strong></span><span class="date">작성일<strong><c:out value="${note.SEND_DATE_FORMAT1 }"/></strong></span>
						</div>
					</div>
					<div class="view-body">
						<div>${fn:replace(note.NOTE, newline, '<br />')}</div>
					</div>
					<div class="view-bottom">
						<div class="view-util">
							<div class="btnSet">
								<a href="#" class="btn float_right danger deleteBtn">삭제</a>
								<a href="#" class="btn float_right primary replyBtn">답장</a>
								<a href="#" class="btn float_left line listBtn">목록</a>
							</div>
						</div>
					</div>
						</c:when>
						<c:otherwise>
					<div class="view-header">
						<h3 class="view-title"><c:out value="${note.TITLE }"/></h3>
						<div class="view-info">
							<span class="writer">받는 사람<strong><c:out value="${note.TO_USER_NAME }"/></strong></span><span class="date">작성일<strong><c:out value="${note.SEND_DATE_FORMAT1 }"/></strong></span>
						</div>
					</div>
					<div class="view-body">
						<div>${fn:replace(note.NOTE, newline, '<br />')}</div>
					</div>
					<div class="view-bottom">
						<div class="view-util">
							<div class="btnSet">
								<a href="#" class="btn float_right danger deleteBtn">삭제</a>
								<a href="#" class="btn float_left line listBtn">목록</a>
							</div>
						</div>
					</div>
						</c:otherwise>
					</c:choose>
				</div>
				</form>
			</div><!--//.tab-body-->
		</div><!--.tab-groyp-->
	</div><!--//.sub-body-->
	<!--본문 내용 출력 공간-->
</div><!--//.body-->
<!--// 1.3. 본문 -->

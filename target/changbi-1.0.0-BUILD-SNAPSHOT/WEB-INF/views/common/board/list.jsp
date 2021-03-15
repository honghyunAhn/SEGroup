<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="t"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<script type="text/javascript">
$(document).ready(function(){
	var totalPages = ${totalPages};//전체 페이지
    var visiblePages = ${visiblePages};//리스트 보여줄 페이지
    var startPage = ${startPage};//현재 페이지

    if('${totalPages}' != 0){
    	$('#bbsnotice #pagination').twbsPagination({
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

 	$("#searchBtn").click(function(event){
 		$('#startPage').val(1);
 		$("#searchForm").submit();
 	});

});

function goDetail(id) {
	$('#moveForm input[name="id"]').val(id);
	$('#moveForm').attr('action', '<c:url value="${detailUrl}"/>');
	$('#moveForm').submit();
}
</script>


	<div class="sub-body">
		<div class="tab-group">
			<div class="tab-body" id="bbsnotice">
				<div class="list-top">
					<form id="searchForm" class="body-search">
						<select id="searchbox" name="searchbox">
							<option value="tc" ${param.searchbox eq 'tc'? 'selected':''}>제목+내용</option>
							<option value="t" ${param.searchbox eq 't'? 'selected':''}>제목</option>
							<option value="c" ${param.searchbox eq 'c'? 'selected':''}>내용</option>
						</select>
						<input type="text" name="search" value="${param.search}" placeholder="검색어를 입력하세요.">
						<button type="button" id="searchBtn"><span class="sr-only">검색</span></button>
						<input type="hidden" id="startPage" name="startPage" value="${startPage}">
						<input type="hidden" id="board_type" name="board_type" value="${board_type }">
						<input type="hidden" id="notice_type" name="notice_type" value="${notice_type }">
					</form>
				</div>
				<table id="bbs" class="list">
					<thead>
						<tr>
							<th scope="col" class="item-number">번호</th>
							<th scope="col" class="item-title">제목</th>
							<th scope="col" class="item-name">작성자</th>
							<th scope="col" class="item-date">등록일</th>
							<th scope="col" class="item-view_count">조회수</th>
						</tr>
					</thead>
					<c:if test="${!empty fixedNoticeList}">
					<tbody class="notice-group">
						<c:forEach var="bbslist" items="${fixedNoticeList}" varStatus="status">
						<tr>
							<td class="item-number"><em class="icon ci-notice"><span class="sr-only">[공지]</span></em></td>
							<td class="item-title">
								<a href="javascript:goDetail('<c:out value="${bbslist.id }"/>')"><strong>${bbslist.title}</strong></a>
								<span class="iconSet">
								<c:choose>
									<c:when test="${bbslist.icon == '1' }">
									<em class="icon-new">NEW</em>
									</c:when>
									<c:when test="${bbslist.icon == '2' }">
									<em class="icon-pop">인기</em>
									</c:when>
								</c:choose>
								</span>
							</td>
							<td class="item-name">
								<c:choose>
									<c:when test="${empty bbslist.user_id}">관리자</c:when>
									<c:otherwise>${bbslist.user_name}</c:otherwise>
								</c:choose>
							</td>
							<td class="item-date">${bbslist.reg_date_format2}.</td>
							<td class="item-view_count">${bbslist.hits }</td>
						</tr>
						</c:forEach>
					</tbody>
					</c:if>
					<tbody>
					<c:if test="${!empty bbslist}">
						<c:forEach var="bbslist" items="${bbslist}" varStatus="status">
						<tr>
							<td class="item-number"><fmt:formatNumber value="${totalCnt - (startPage-1)*visiblePages - status.index}"/></td>
							<td class="item-title">
								<a href="javascript:goDetail('<c:out value="${bbslist.id }"/>')"><strong>${bbslist.title}</strong></a>
								<span class="iconSet">
								<c:choose>
									<c:when test="${bbslist.icon == '1' }">
									<em class="icon-new">NEW</em>
									</c:when>
									<c:when test="${bbslist.icon == '2' }">
									<em class="icon-pop">인기</em>
									</c:when>
								</c:choose>
								</span>
							</td>
							<td class="item-name">
								<c:choose>
									<c:when test="${empty bbslist.user_id}">관리자</c:when>
									<c:otherwise>${bbslist.user_name}</c:otherwise>
								</c:choose>
							</td>
							<td class="item-date">${bbslist.reg_date_format2}.</td>
							<td class="item-view_count">${bbslist.hits }</td>
						</tr>
						</c:forEach>
					</c:if>
				 	<c:if test="${empty bbslist}">
				 		<tr><td colspan="5">조회된 내용이 없습니다.</td></tr>
				 	</c:if>
					</tbody>
				</table>
				<div class="list-bottom">
					<ul id="pagination"></ul>
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
	<input type="hidden" name="id"/>
	</form>

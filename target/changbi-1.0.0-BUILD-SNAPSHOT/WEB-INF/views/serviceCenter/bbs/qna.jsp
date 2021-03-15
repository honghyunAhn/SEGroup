<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="t"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %>

<script type="text/javascript">
$(document).ready(function(){

	var totalPages = ${totalPages};//전체 페이지
    var visiblePages = ${visiblePages};//리스트 보여줄 페이지
    var startPage = ${startPage};//현재 페이지

    if('${totalPages}' != 0){
    	$('#bbsqna #pagination').twbsPagination({
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
 		$("#searchForm").submit();
 	});
});

function goDetail(id, rid) {
	rid = rid || '';
	if (rid == '') {	// 질문글보기
		$('#moveForm input[name="id"]').val(id);
		$('#moveForm input[name="listQuery"]').val(getListQuery(document.getElementById('searchForm'), ['board_type','startPage','searchbox','search']));
		$('#moveForm').attr('action', '<c:url value="/serviceCenter/bbs/writeDetail"/>');
	} else {	// 답변글보기
		$('#moveForm input[name="id"]').val(rid);
		$('#moveForm').attr('action', '<c:url value="/serviceCenter/bbs/replyDetail"/>');
	}
	$('#moveForm').submit();
}

function goWrite() {
	$('#moveForm input[name="listQuery"]').val(getListQuery(document.getElementById('searchForm'), ['board_type','startPage','searchbox','search']));
	$('#moveForm').attr('action', '<c:url value="/serviceCenter/bbs/write"/>');
	$('#moveForm').submit();
}
</script>

<t:insertDefinition name="centerleftmenu"/>

<!-- 1.3. 본문 -->
<div class="body">
	<div class="sub-header">
		<p class="sub-nav">
			<a class="nth-1st" href="/"><span class="sr-only">HOME</span></a>
			<a href="#">고객 센터</a>
			<a class="nth-last" href="${contextPath}">1:1 상담</a>
		</p>
		<h2 class="sub-title">1:1 상담</h2>
		<!--p class="sub-title-copy">제목을 보조해주는 문구 삽입</p-->
	</div><!--//.sub-header-->
	<div class="sub-body">
		<div class="tab-group">
			<div class="tab-body" id="bbsqna">
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
						<input type="hidden" id="board_type" name="board_type" value="4">
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
					<tbody>
					<c:set var="questions" value="0"/>
					<c:if test="${!empty bbslist}">
					<c:forEach var="bbslist" items="${bbslist}" varStatus="status">
						<c:if test="${empty bbslist.rid }">
							<tr class="nth-1st"><!-- ie8에서는 nth-first 선택자를 이용할 수 없으므로 첫번째 아이템에만 class 명으로 부여 -->
								<td class="item-number"><fmt:formatNumber value="${totalCnt - (startPage-1)*visiblePages - questions}"/></td>
								<td class="item-title"><a href="javascript:goDetail('${bbslist.id}','${bbslist.rid}')"><strong>${bbslist.title}</strong></a></td>
								<td class="item-name">${bbslist.user_name}</td>
								<td class="item-date">${bbslist.reg_date_format2}</td>
								<td scope="col" class="item-view_count">${bbslist.hits}</td>
							</tr>
							<c:set var="questions" value="${questions + 1 }"/>
						</c:if>
						<c:if test="${not empty bbslist.rid }">
							<tr class="nth-1st"><!-- ie8에서는 nth-first 선택자를 이용할 수 없으므로 첫번째 아이템에만 class 명으로 부여 -->
								<td class="item-number">&nbsp;</td>
								<td class="item-title">ㄴ <a href="javascript:goDetail('${bbslist.id}','${bbslist.rid}')"><strong>${bbslist.title}</strong></a></td>
								<td class="item-name">관리자</td>
								<td class="item-date">${bbslist.reg_date_format2}</td>
								<td scope="col" class="item-view_count">${bbslist.hits}</td>
							</tr>
						</c:if>
					</c:forEach>
					</c:if>
					<c:if test="${empty bbslist}">
					<tr><td colspan="5">조회된 내용이 없습니다.</td></tr>
					</c:if>
					</tbody>
				</table>
				<div class="list-bottom">
					<ul id="pagination"></ul>
					<div class="btnSet">
						<a href="javascript:goWrite()" class="btn float_right primary">글쓰기</a>
					</div>
				</div>
			</div><!--//.tab-body-->
		</div><!--.tab-groyp-->
	</div><!--//.sub-body-->
	<!--본문 내용 출력 공간-->
</div>
<!--// 1.3. 본문 -->


<form id="moveForm" name="moveForm" action="post">
<input type="hidden" name="startPage" value="<c:out value="${param.startPage }"/>"/>
<input type="hidden" name="board_type" value="<c:out value="${param.board_type }"/>"/>
<input type="hidden" name="searchbox" value="<c:out value="${param.searchbox }"/>"/>
<input type="hidden" name="search" value="<c:out value="${param.search }"/>"/>
<input type="hidden" name="listQuery"/>
<input type="hidden" name="id"/>
</form>

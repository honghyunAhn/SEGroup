<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<div class="section section_sub04-01">
	<div class="searchWrapper">
		<form class="formStyle d-flex" id="searchForm" action="/smtp/community/sub04-01-01" method="POST">
			<div class="class-searchWrap d-flex justify_end">
				<select name="searchCondition" class="select">
				<option value="all" <c:if test="${search.searchCondition eq 'all'}">selected</c:if>>제목+내용</option>
				<option value="title" <c:if test="${search.searchCondition eq 'title'}">selected</c:if>>제목</option>
				<option value="content" <c:if test="${search.searchCondition eq 'content'}">selected</c:if>>내용</option>
				</select>
				<input type="text" class="cusPHIn input" name="searchKeyword" value="${search.searchKeyword}" placeholder="검색어를 입력해주세요.">
				<!-- 검색버튼 -->
				<button type="button" class="button img-icon search" id="searchBtn"></button>
				<c:choose>
					<c:when test="${search.startpage != '' && search.startpage != null}">
						<input type="hidden" id="startPage" name="startPage" value="${search.startPage}">
					</c:when>
					<c:otherwise>
						<input type="hidden" id="startPage" name="startPage" value="1">
					</c:otherwise>
				</c:choose>
				<input type="hidden" id="search_seq" name="board_content_seq" value="">
			</div>
		</form>
	</div>
	<div class="sub-segment table">
		<ul class="class-list-title thead d-flex">
			<li class="c-table-num">No.</li>
			<li class="c-table-name-wide">제목</li>
			<li class="c-table-02 c-table-date">등록일</li>
			<li class="c-table-02">구분</li>
			<li class="c-table-num">조회수</li>
		</ul>
		<ul class="class-list-wrap" id="dataListUl"></ul>
	</div>
	<!-- pagination -->
<!-- 	<div class="page"> -->
<!-- 		<ul class="pagination d-flex justify_between" id="pagination"></ul> -->
<!-- 	</div> -->
</div>
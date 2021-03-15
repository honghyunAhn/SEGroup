<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="t"%>
<c:set var="newline" value="<%= \"\n\" %>" /><%--cr to br --%>

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

	// 탭변경
	$('#faqTab a').click(function() {
 		$('#startPage').val(1);
 		$('#faq_code').val($(this).data('faqcode'));
 		$("#searchForm").submit();
	});

	// 탭 갯수 자동 판별
	if($.fn.tabLength != null ) $('.tab-group > .tab-header.sub').tabLength();

});
</script>

<t:insertDefinition name="centerleftmenu"/>

<!-- 1.3. 본문 -->
<div class="body">
	<div class="sub-header">
		<p class="sub-nav">
			<a class="nth-1st" href="/"><span class="sr-only">HOME</span></a>
			<a href="#">고객 센터</a>
			<a class="nth-last" href="#">자주 묻는 질문</a>
		</p>
		<h2 class="sub-title">자주 묻는 질문 </h2>
		<!--p class="sub-title-copy">제목을 보조해주는 문구 삽입</p-->
	</div><!--//.sub-header-->
	<div class="sub-body">
		<div class="list-top">
			<form id="searchForm" name="searchForm" class="body-search" action="<c:url value="/serviceCenter/bbs/faq"/>">
				<select id="searchbox" name="searchbox">
					<option value="tc" ${param.searchbox eq 'tc'? 'selected':''}>제목+내용</option>
					<option value="t" ${param.searchbox eq 't'? 'selected':''}>제목</option>
					<option value="c" ${param.searchbox eq 'c'? 'selected':''}>내용</option>
				</select>
				<input type="text" name="search" value="${param.search}" placeholder="검색어를 입력하세요.">
				<button type="button" id="searchBtn"><span class="sr-only">검색</span></button>
				<input type="hidden" id="startPage" name="startPage" value="${startPage}">
				<input type="hidden" id="faq_code" name="faq_code" value="${param.faq_code}">
				<input type="hidden" id="board_type" name="board_type" value="3">
			</form>
		</div>
		<div class="tab-group">
			<ul class="tab-header sub" id="faqTab">
				<li><a class="nth-1st ${param.faq_code eq '0' ? 'on':''}" href="#" data-faqcode="0">전체</a></li>
				<c:if test="${!empty bbscode}">
				<c:forEach var="bbscode" items="${bbscode}" varStatus="status">
				<li><a class="${param.faq_code eq bbscode.code ? 'on':''}" href="#" data-faqcode="${bbscode.code}">${bbscode.name}</a></li>
				</c:forEach>
				</c:if>
			</ul>
			<div class="tab-body" id="bbsnotice">
				<ul class="spread-list">
					<c:if test="${!empty bbslist}">
					<c:forEach var="bbslist" items="${bbslist}" varStatus="status">
					<li class="nth-1st">
						<a href="#none"><em>Q.<fmt:parseNumber var="seq" value="${bbslist.seq}" integerOnly="true"/>${seq}</em><strong>${bbslist.title}</strong></a>
						<div>${fn:replace(bbslist.acomment, newline, '<br />')}</div>
					</li>
					</c:forEach>
					</c:if>
					<c:if test="${empty bbslist}">
					<li class="alignC">등록된 내용이 없습니다.</li>
					</c:if>
				</ul>
				<div class="list-bottom">
					<ul id="pagination"></ul>
				</div>
			</div><!--//.tab-body-->
		</div><!--.tab-groyp-->
	</div><!--//.sub-body-->
	<!--본문 내용 출력 공간-->
</div><!--//.body-->
<!--// 1.3. 본문 -->


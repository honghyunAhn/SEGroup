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



<!-- 1.3. 본문 -->
<div class="container-sub" id="main">
<!-- <div class="skip-navigation">
        웹접근성/content
        <p><a href="#main">콘텐츠 바로가기</a></p>
</div> -->
<t:insertDefinition name="centerleftmenu"/>
	<div class="sub-content sub06-02">
			<div class="page-locationWrap">
	                <ul class="page-location">
	                    <li class="img-icon  home"><a href="index.html"></a></li>
	                    <li class="img-icon  chevron-right"></li>
	                    <li class="category-menu"><a href="sub06-01-01.html">고객센터</a></li>
	                    <li class="img-icon  chevron-right"></li>
	                    <li class="division-menu"><a href="sub06-02-01.html">FAQ</a></li>
	                </ul>
	                <div class="img-icon  chevron-right"></div>
	        </div>
	         <div class="header-box">
	                <!-- image로 구성 될 경우에 .header-box에 background 처리하기 -->
	                <div class="box-titleBar"></div>
	                <h3 class="h3">FAQ 자주하는 질문</h3>
	                <p class="c999">
	              	      궁금하신 사항은 먼저 자주하는 질문을 참고하시면<br>회원님의 궁금증을 빠르게 해결하실 수 있습니다.
	                </p>
	        </div>
<%-- 		<div class="list-top">
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
		</div> --%>
		
			<div class="section sub06-02-01">
			
			<!-- 과정명 검색 -->
				<div class="class-searchWrap">
					<form class="d-flex" id="searchForm" name="searchForm" action="<c:url value="/serviceCenter/bbs/faq"/>">
						<!-- <div class="search-filter-wrap"> -->
							<select name="searchbox" class="search-filter" id="searchbox">
								<option value="tc" ${param.searchbox eq 'tc'? 'selected':''}>제목+내용</option>
								<option value="t" ${param.searchbox eq 't'? 'selected':''}>제목</option>
								<option value="c" ${param.searchbox eq 'c'? 'selected':''}>내용</option>
							</select>
						<!-- </div> -->
						<div class="class-search-down d-flex">
							<input type="text" name="search" class="cusPHIn" value="${param.search}" placeholder="검색어를 입력해주세요.">
							<button type="button" id="searchBtn" class="button btn-wh img-icon search" ></button>
							<input type="hidden" id="startPage" name="startPage" value="${startPage}">
							<input type="hidden" id="faq_code" name="faq_code" value="${param.faq_code}">
							<input type="hidden" id="board_type" name="board_type" value="3">
						</div>
					</form>
				</div>
				<div class="class-tabMenu">
					<ul class="tabGroup plus-tabGroup d-flex" id="faqTab">
		                <li class="active"><a  href="#" data-faqcode="0">전체</a></li>
		                <c:if test="${!empty bbscode}">
						<c:forEach var="bbscode" items="${bbscode}" varStatus="status">
						<li><a href="#" data-faqcode="${bbscode.code}">${bbscode.name}</a></li>
						</c:forEach>
						</c:if>         
		            </ul>
				<%-- 	<div class="tab-body" id="bbsnotice">
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
					</div><!--//.tab-body--> --%>
					<div class="subGroup" id="bbsnotice">
						<div class="tab-sub sub01">
							<div class="sub-section">
								<div class="sub-segment">
									<ul class="spread-list">
										<!-- 과정명 추가시 list and(+) Wrap 추가  -->
										<c:if test="${!empty bbslist}">
										<c:forEach var="bbslist" items="${bbslist}" varStatus="status">
										<li class="listAndwrap">
											<div class="class-list board-list open-answer d-flex">
											<!-- 	<div class="c-table-num">1</div> -->
												<div class="c-table-name-wide">
													<div class="d-flex icon-align">
														<div class="Qmark">Q.<fmt:parseNumber var="seq" value="${bbslist.seq}" integerOnly="true"/>${seq}</div>
														<div class="">${bbslist.title}</div>
													</div>
												</div>
												<!-- <div class="c-table-02"></div> -->
											</div> <!-- open-class 클릭하면 open-ctt가 .slideToggle되고 hide-show-txt.text(닫기);로 바뀐다. -->
											<div class="open-asw open-ctt">
												<ul class="class-list-wrap">
													<li class="icon-align aswr-box d-flex">
														<div class="d-flex icon-align">
															<div class="Amark">A.</div>
															<div class="">${fn:replace(bbslist.acomment, newline, '<br />')}</div>
														</div>
													</li>
												</ul>
											</div>
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
								</div>
							</div>
						</div>
					</div>	<!--  jimin spread list end  -->
			</div><!--.tab-groyp-->
			</div><!--//.sub-body-->
	</div>
	<!--본문 내용 출력 공간-->
</div><!--//.body-->
<!--// 1.3. 본문 -->


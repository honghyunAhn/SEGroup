<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="t"%>

<script type="text/javascript">
$(document).ready(function(){
	$("#selectOption li").click(function(event){
		$("#searchbox").val($(this).attr("data"));
		$("#selectedOption").text($(this).text());

		$(this).parent().toggleClass('off');
	});

		var totalPages = ${bbsParam.totalPages};//전체 페이지
    var visiblePages = ${bbsParam.visiblePages};//리스트 보여줄 페이지
    var startPage = ${bbsParam.startPage};//현재 페이지

    if(totalPages != 0){
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
		            $('#searchForm input[name="startPage"]').val(page);
		            $("#searchForm").submit();
		        }
	    	});
	 	};

	 	$("#searchBtn").click(function(event){
	 		$("#searchForm").submit();
	 	});

});

function goDetail(id) {
	$('#moveForm input[name="bbsid"]').val(id);
	$('#moveForm').attr('action', 'noticedetail');
	$('#moveForm').submit();
}
</script>

<t:insertDefinition name="mypageleftmenu"/>
<!-- 1.3. 본문 -->
	<div class="body">
			<div class="sub-header">
				<p class="sub-nav">
					<a class="nth-1st" href="/"><span class="sr-only">HOME</span></a>
					<a href="#">나의 강의실</a>
					<a class="nth-last" href="${contextPath}">강의실</a>
				</p>
				<h2 class="sub-title">${classInfo.NAME }</h2>
				<!--p class="sub-title-copy">제목을 보조해주는 문구 삽입</p-->
			</div><!--//.sub-header-->
			<div class="sub-body">
				<div class="tab-group">
					<ul class="tab-header sub x7">
							<li><a href="classroom?id=${classParam.id }&cardinal=${classParam.cardinal }&course=${classParam.course }">홈</a></li>
							<li><a href="lesson?id=${classParam.id }&cardinal=${classParam.cardinal }&course=${classParam.course }">강의 보기</a></li>
							<li><a href="report?id=${classParam.id }&cardinal=${classParam.cardinal }&course=${classParam.course }">온라인 과제</a></li>
							<li><a href="exam?id=${classParam.id }&cardinal=${classParam.cardinal }&course=${classParam.course }">온라인 시험</a></li>
							<li><a class="nth-1st on"  href="notice?id=${classParam.id }&cardinal=${classParam.cardinal }&course=${classParam.course }">공지 사항</a></li>
							<li><a href="dataroom?id=${classParam.id }&cardinal=${classParam.cardinal }&course=${classParam.course }">자료실</a></li>
							<li><a href="qna?id=${classParam.id }&cardinal=${classParam.cardinal }&course=${classParam.course }">질의 답변</a></li>
						</ul>
					<div class="tab-body">
				<!-- 탭별 로드되는 부분 Start -->
							<div class="group">
								<div class="group-header">
									<h3>공지 사항</h3>
								</div>
								<div class="group-body">
									<div class="list-top">
										<form id="searchForm">
											<input type="hidden" name="startPage" value="${bbsParam.startPage }"/>
											<input type="hidden" name="cardinal" value="${classParam.cardinal }" />
											<input type="hidden" name="course" value="${classParam.course }"  />
											<input type="hidden" name="id" value="${classParam.id }"  />
											<input type="hidden" name="searchbox" value="${bbsParam.searchbox?bbsParam.searchbox:'tc' }"  />

											<div class="body-select">
												<a class="btn-toggle" href="#selectOption"><span id="selectedOption">제목+내용</span></a>
												<ul class="select-option off" id="selectOption">
													<li data="tc">제목+내용</li>
													<li data="t">제목</li>
													<li data="c">내용</li>
												</ul>
											</div>
											<div class="body-search">
												<input type="text" name="search" value="${param.search}" placeholder="검색어를 입력하세요.">
												<button type="button"  id="searchBtn"><span class="sr-only">검색</span></button>
											</div>
										</form>
										<p class="ctrl-btnSet">총 <strong>${bbsParam.totalCnt?bbsParam.totalCnt:0 }</strong>개의 게시물이 검색되었습니다.</p>
									</div>
									<table id="list-learn" class="list">
										<thead>
											<tr>
												<th scope="col" class="item-number">번호</th>
												<th scope="col" class="item-title">제목</th>
												<%-- <th scope="col" class="item-answer">답변여부</th> --%>
												<th scope="col" class="item-name">작성자</th>
												<th scope="col" class="item-date">등록일</th>
												<th scope="col" class="item-view_count">조회수</th>
											</tr>
										</thead>
										<tbody>
										<c:if test="${empty bbsList }">
												<tr class="nth-1st">
													<td colspan=5>등록된 게시물이 없습니다.</td>
												</tr>
											</c:if>

											<c:if test="${!empty bbsList }">
												<c:forEach var="bbs" items="${bbsList }" varStatus="status">
													<tr <c:if test="${status.index == 0 }">class="nth-1st"</c:if>>
														<td class="item-number"><fmt:formatNumber value="${bbsParam.totalCnt - (bbsParam.startPage-1)*bbsParam.visiblePages - status.index}"/></td>
														<td class="item-title"><a href="javascript:goDetail('${bbs.id }')"><strong>${bbs.title }</strong></a></td>
														<td class="item-name">
															<c:choose>
																<c:when test="${empty bbs.user_id}">관리자</c:when>
																<c:otherwise>${bbs.user_name}</c:otherwise>
															</c:choose>
														</td>
														<td class="item-date">${bbs.reg_date_format2 }</td>
														<td class="item-view_count">${bbs.hits }</td>
													</tr>
												</c:forEach>
											</c:if>
										</tbody>
									</table>
									<div class="list-bottom">
										<ul id="pagination"></ul>
									</div>
									<div class="btnSet">
										</div>
								</div><!--//.group-body-->
							</div><!--//.group-->
				<!--// 탭별 로드되는 부분 END -->
						</div>
				</div><!--.tab-group-->
			</div><!--//.sub-body-->
		</div>
<!-- 1.3. 본문 -->

	<form id="moveForm" name="moveForm" action="post">
	<input type="hidden" name="startPage" value="<c:out value="${bbsParam.startPage }"/>"/>
	<input type="hidden" name="board_type" value="<c:out value="${bbsParam.board_type }"/>"/>
	<input type="hidden" name="searchbox" value="<c:out value="${bbsParam.searchbox }"/>"/>
	<input type="hidden" name="search" value="<c:out value="${bbsParam.search }"/>"/>
	<input type="hidden" name="bbsid"/>
	<input type="hidden" name="cardinal" value="${classParam.cardinal }" />
	<input type="hidden" name="course" value="${classParam.course }"  />
	<input type="hidden" name="id" value="${classParam.id }"  />
	</form>
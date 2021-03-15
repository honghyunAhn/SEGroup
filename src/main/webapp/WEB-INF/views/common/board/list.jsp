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


	<div class="sub-body sub-content">
		<%-- <div class="tab-group">
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
		</div><!--.tab-groyp--> --%>
		<!-- jimin------------------------------------------------------>
		<div class="skip-navigation">
        <!--웹접근성/content-->
        <p><a href="#main">콘텐츠 바로가기</a></p>
        </div>
        <div class="container sub" id="main">
        <!-- sub05 커뮤니티-include -->
        <? include 'include/sub05.html' ?>

        <div class="sub-content sub05-02 sub05-02-01">
            <div class="page-locationWrap">
                <ul class="page-location">
                    <!--
                    home 메인 / category menu 대분류 / division menu 중분류 / section menu 소분류
                    -->
                    <li class="img-icon  home"><a href="index.html"></a></li>
                    <li class="img-icon  chevron-right"></li>
                    <li class="category-menu"><a href="sub05-01-01.html">커뮤니티</a></li>
                    <li class="img-icon  chevron-right"></li>
                    <li class="division-menu"><a href="/serviceCenter/bbs/notice?board_type=1&notice_type=1">공지사항/이벤트</a></li>
                    <li class="img-icon  chevron-right"></li>
                    <li class="section-menu"><a href="/serviceCenter/bbs/notice?board_type=1&notice_type=1">공지사항</a></li>
                </ul>
                <div class="img-icon  chevron-right"></div>
                <!-- <div class="sub-content sub00-01"></div> -->
            </div>
            <div class="header-box">
                <!-- image로 구성 될 경우에 .header-box에 background 처리하기 -->
                <div class="box-titleBar"></div>
                <h3 class="h3">공지사항/이벤트</h3>
                <p class="c999">
                    레인보우의 공지사항 및 이벤트를 알려드립니다.<br>유익하고 풍성한 소식 놓치지말고 확인하세요.
                </p>
            </div>
            <div class="section sub05-02">
                <!-- 학습현황 탭 -->
                <div class="class-tabMenu">
                	<c:if test="${notice_type==1}">
                      <ul class="tabGroup d-flex">
                          <li class="active"><a href="/serviceCenter/bbs/notice?board_type=1&notice_type=1">공지사항</a></li>
                          <li><a href="/serviceCenter/bbs/notice?board_type=1&notice_type=2">이벤트</a></li>
                      </ul>
                    </c:if>
                    <c:if test="${notice_type==2}">
                      <ul class="tabGroup d-flex">
                          <li><a href="/serviceCenter/bbs/notice?board_type=1&notice_type=1">공지사항</a></li>
                          <li class="active"><a href="/serviceCenter/bbs/notice?board_type=1&notice_type=2">이벤트</a></li>
                      </ul>
                    </c:if>
                    <div class="subGroup" id="bbsnotice">
                        <div class="tab-sub sub01">
                            <div class="sub-section">
                                <div class="class-searchWrap">
                                    <form id="searchForm" class="d-flex">
                                        <div class="search-filter-wrap">
                                            <select name="searchbox" id="searchbox">
                                                <option value="tc" ${param.searchbox eq 'tc'? 'selected':''}>제목+내용</option>
												<option value="t" ${param.searchbox eq 't'? 'selected':''}>제목</option>
												<option value="c" ${param.searchbox eq 'c'? 'selected':''}>내용</option>
                                            </select>
                                        </div>
                                        <div class="class-search-down d-flex">
                                            <input type="text" name="search" class="cusPHIn" value="${param.search}" placeholder="검색어를 입력해주세요.">
                                            <button type="button" class="button btn-wh img-icon search" id="searchBtn"></button>
                                            <input type="hidden" id="startPage" name="startPage" value="${startPage}">
											<input type="hidden" id="board_type" name="board_type" value="${board_type }">
											<input type="hidden" id="notice_type" name="notice_type" value="${notice_type }">
                                        </div>
                                    </form>
                                </div>
                                <table class="sub-segment" id="bbs">
                                    <thead class="class-list-title thead">
                                        <tr class="d-flex">
                                            <th class="c-table-num">No.</th>
                                            <th class="c-table-name-w">제목</th>
                                            <th class="c-table-02">등록일</th>
                                            <th class="c-table-02">구분</th>
                                            <th class="c-table-01">조회수</th>
                                        </tr>
                                    </thead>
                               <c:if test="${!empty fixedNoticeList}">
										<tbody class="class-list-wrap">
											<c:forEach var="bbslist" items="${fixedNoticeList}"
												varStatus="status">
												<!-- 목록 추가시 class-list 추가 -->
												<tr class="class-list d-flex">
													<td class="c-table-num">1</td>
													<td class="c-table-name-w">
													<a href="javascript:goDetail('<c:out value=" ${bbslist.id}" />')">
															<div class="d-flex icon-align">
																<c:choose>
																	<c:when test="${bbslist.icon == '1' }">
																		<em class="color-box bgc-red">NEW</em>
																	</c:when>
																	<c:when test="${bbslist.icon == '2' }">
																		<em class="icon-pop">인기</em>
																	</c:when>
																</c:choose>
																<p class="text-over">${bbslist.title}</p>
															</div>
															
													</a>
													</td>
													<td class="c-table-02">${bbslist.reg_date_format2}.</td>
													<td class="c-table-02">
														<div class="d-flex icon-align">
															<div class="img-icon bullhorn-s"></div>
															<p class="text-over">
																<c:choose>
																	<c:when test="${empty bbslist.n_type}">공지사항</c:when>
																	<c:otherwise>${bbslist.n_type}</c:otherwise>
																</c:choose>
															</p>
														</div>
													</td>
													<td class="c-table-01">${bbslist.hits }</td>
												</tr>
											</c:forEach>
										</tbody>
									</c:if>
                                    <tbody class="class-list-wrap">
                                    	<c:if test="${!empty bbslist}">
                                    		<c:forEach var="bbslist" items="${bbslist}" varStatus="status">
		                                        <!-- 목록 추가시 class-list 추가 -->
		                                        <tr class="class-list d-flex">
		                                            <td class="c-table-num"><fmt:formatNumber value="${totalCnt - (startPage-1)*visiblePages - status.index}"/></td>
		                                            <td class="c-table-name-w">
		                                                <a href="javascript:goDetail('<c:out value="${bbslist.id }"/>')"> 
		                                                	
		                                                	<div class="d-flex icon-align">
		                                                     	<c:choose>
											                        <c:when test="${bbslist.icon == '1' }">
											                        <div class="color-box bgc-red">NEW</div>
											                        </c:when>
											                        <c:when test="${bbslist.icon == '2' }">
											                        <em class="icon-pop">인기</em>
											                        </c:when>
											                        <c:when test="${bbslist.icon == '3' }">
											                        <em class="icon-pop">신규</em>
											                        </c:when>
											                    </c:choose>
											                    
                                                   			</div>
                                                   			${bbslist.title}
		                                                </a>
		                                                
		                                            </td>
		                                            <td class="c-table-02">${bbslist.reg_date_format2}.</td>
		                                            <td class="c-table-02">
		                                                <div class="d-flex icon-align">
		                                                    <div class="img-icon bullhorn-s"></div>
		                                                    <p class="text-over">
		                                                    	<c:choose>
		                                                    		<c:when test="${empty bbslist.n_type}">공지사항</c:when>
		                                                    		<c:otherwise>${bbslist.n_type}</c:otherwise>
		                                                    	</c:choose>
		                                                    
		                                                    </p>
		                                                </div>
		                                            </td>
		                                            <td class="c-table-01">${bbslist.hits }</td>
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
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            
        </div>
    </div>
        
        
    </div><!--//.sub-body-->

	<form id="moveForm" name="moveForm" action="post">
	<input type="hidden" name="startPage" value="<c:out value="${param.startPage }"/>"/>
	<input type="hidden" name="board_type" value="<c:out value="${param.board_type }"/>"/>
	<input type="hidden" name="notice_type"value="<c:out value="${param.notice_type }"/>"/>
	<input type="hidden" name="searchbox" value="<c:out value="${param.searchbox }"/>"/>
	<input type="hidden" name="search" value="<c:out value="${param.search }"/>"/>
	<input type="hidden" name="id"/>
	</form>

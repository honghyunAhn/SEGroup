<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <%@include file="../include/rainbow_head.jsp" %>
	
    <script type="text/javascript">
    $(document).ready(function () {
	   // community nav active
	   navLinks[3].parentElement.classList.add('current')
	   subNav[3].classList.add('active');
    });
	function ilist(page) {
		location.href = "/smtp/community/rainbow-community04-01.do?curPage="
				+ page
				+ "&searchOption=${map.searchOption}"
				+ "&keyword=${map.keyword}";
	}
	
	function goBoardDetail(seq) {
		location.href = "/smtp/community/rainbow-community04-02.do?seq="+ seq;
	}
	
	function searchList() {
	
		location.href = "/smtp/community/rainbow-community04-01.do?curPage="
				+ page
				+ "&searchOption=${map.searchOption}"
				+ "&keyword=${map.keyword}";
	}
	
	function mySelection() {
		$('input[id="searchOption"]').val(
				document.getElementById("mySelect").value);
	}
	
	function search() {
		var searchword = document.getElementById("searchword").value;
		var searchoption = document.getElementById("searchOption").value;
		if (searchoption == "") {
			searchoption = "contents";
		}
	
		location.href = "/smtp/community/rainbow-community04-01.do?searchOption="
				+ searchoption + "&keyword=" + searchword;
	}
    </script>
</head>

<body>
    <!-- community - 04. 졸업생 마당 -->
    <div class="container_rainbow">
    	<%@include file="../include/rainbow_header.jsp" %>
        <div class="content course-point04" id="main">
            <div class="sub-content community01-01">
                <div class="section_header">
                    <h3 class="h3">🌈 졸업생 마당</h3>
                    <p class="margin-top10 fc_999">
                        21년간 해외취업인재 취업률 97% 달성! 졸업생분들의 이야기를 살펴보세요.
                    </p>
                </div>
                <div class="section_search">
                    <form class="formStyle" id="searchForm" onsubmit="return false;">
                        <div class="d-flex justify_between">
                            <select name="searchCondition" id="mySelect" class="select w200" onchange="mySelection()">
                                <option value="contents">내용
                                <option value="title">제목
                            </select>
                            <input type="text" class="cusPHIn input margin-left10" id="searchword" name="searchKeyword"
                                value="${search.searchKeyword}" placeholder="검색어를 입력해주세요.">
                            <!-- 검색버튼 -->
                            <button type="submit" class="btn_normal img-icon search" id="searchBtn"
                                onclick="search()"></button>
                            <input type="hidden" id="searchOption" />
                        </div>
                    </form>
                </div>
                <div class="section_table">
                    <ul class="table-title thead d-flex fc_point">
                        <li class="w100">날짜</li>
                        <li class="w400">제목</li>
                        <li class="w100">조회수</li>
                    </ul>
                    <ul class="table-list tbody" id="dataListUl">
                    	<c:choose>
                        	<c:when test="${fn:length(boardList) gt 0}">
	                            <c:forEach var="data" items="${boardList}" varStatus="status">
	                                <li class="list d-flex" onclick="goBoardDetail('${data.board_content_seq}')">
	                                    <div class="w100">
	                                        ${data.board_content_ins_dt}
	                                    </div>
	                                    <div class="w400">
	                                        ${data.board_content_title}
	                                    </div>
	                                    <div class="w100">
	                                        ${data.board_content_hit}
	                                    </div>
	                                </li>
	                            </c:forEach>
                        	</c:when>
                        	<c:otherwise>
								<li class="list not fc_999">
		                            	검색 결과가 없습니다.
		                        </li>
    						</c:otherwise>
                        </c:choose>
                    </ul>
                </div>
                <div class="section_pagination">
                    <ol class="d-flex justify_center">
                        <!-- **처음페이지로 이동 : 현재 페이지가 1보다 크면  [처음]하이퍼링크를 화면에 출력-->
                        <c:if test="${map.boardPager.curBlock > 1}">
                            <li class="page-item">
                                <input class="btn_default" type="button" onclick="javascript:ilist('1')" name=""
                                    value="&lt&lt">
                            </li>
                        </c:if>

                        <!-- **이전페이지 블록으로 이동 : 현재 페이지 블럭이 1보다 크면 [이전]하이퍼링크를 화면에 출력 -->
                        <c:if test="${map.boardPager.curBlock > 1}">
                            <li class="page-item">
                                <input class="btn_default" type="button"
                                    onclick="javascript:ilist('${map.boardPager.prevPage}')" name="" value="&lt">
                            </li>
                        </c:if>
                        <!-- **하나의 블럭에서 반복문 수행 시작페이지부터 끝페이지까지 -->
                        <c:forEach var="num" begin="${map.boardPager.blockBegin}" end="${map.boardPager.blockEnd}">
                            <!-- **현재페이지이면 하이퍼링크 제거 -->
                            <c:choose>
                                <c:when test="${num == map.boardPager.curPage}">
                                    <li class="page-item">
                                        <input class="btn_default fc_point" type="button" name="" value="${num}">
                                    </li>
                                </c:when>
                                <c:otherwise>
                                    <li class="page-item">
                                        <input class="btn_default" type="button" onclick="ilist('${num}')" name=""
                                            value="${num}">
                                    </li>
                                </c:otherwise>
                            </c:choose>
                        </c:forEach>
                        <!-- **다음페이지 블록으로 이동 : 현재 페이지 블럭이 전체 페이지 블럭보다 작거나 같으면 [다음]하이퍼링크를 화면에 출력 -->
                        <c:if test="${map.boardPager.curBlock <= map.boardPager.totBlock}">
                            <li class="page-item">
                                <input class="btn_default" type="button"
                                    onclick="javascript:ilist('${map.boardPager.nextPage}')" name="" value="&gt">
                            </li>
                        </c:if>

                        <!-- **끝페이지로 이동 : 현재 페이지가 전체 페이지보다 작거나 같으면 [끝]하이퍼링크를 화면에 출력 -->
                        <c:if test="${map.boardPager.curPage <= map.boardPager.totPage}">
                            <li class="page-item">
                                <input class="btn_default" type="button"
                                    onclick="javascript:ilist('${map.boardPager.totPage}')" name="" value="&gt&gt">
                            </li>
                        </c:if>
                    </ol>
                </div>
            </div>
        </div>
        <%@include file="../include/rainbow_footer.jsp" %>
    </div>
</body>
</html>
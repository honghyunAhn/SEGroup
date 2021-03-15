<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="format-detection" content="telephone=no">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <meta name="description" content="다양한 전공과 ICT·AI를 융합하여 K-Digital 인재로 컬러링 해드립니다.">
    <meta name="keywords" content="해외취업, Soft Engineer Society, SES, 소프트엔지니어소사이어티, SCIT, SWDO, E러닝, e-learning">
    <title>Rainbow 레인보우</title>
    <link rel="stylesheet" href="/resources/segroup/society/smtp/css/reset.css">
    <link rel="stylesheet" href="/resources/segroup/society/smtp/css/common.css">
    <link rel="stylesheet" href="/resources/segroup/society/smtp/css/img-icon.css">
    <link rel="stylesheet" href="/resources/segroup/society/smtp/css/swiper.min.css">
    <link rel="stylesheet" href="/resources/segroup/society/smtp/css/rainbow_style.css">
    <link rel="stylesheet" href="/resources/segroup/society/smtp/css/rainbow_style_responsive.css">
    <link href="<c:url value="/resources/segroup/society/edu/css/jquery.bxslider.css" />" rel="stylesheet" />
    <style type="text/css">
    	li.page-item input {
        background-color: transparent;
        background-image: none;
        border-color: transparent;
        cursor: pointer;
    	}
    	div.pagination {
    	margin-top: 20px !important;
    	margin-bottom: 0 !important;
    	}
    	div.button-wrap {
    	text-align: right;
    	}
    </style>
    <script src="/resources/segroup/society/smtp/js/jquery-3.3.1.min.js"></script>
    <script src="/resources/segroup/society/smtp/js/swiper.js"></script>
    <script src="/resources/segroup/society/smtp/js/rainbow_script.js"></script>
    <script src="/resources/segroup/society/smtp/js/rainbow_script_responsive.js"></script>
    <script
	src="<c:url value="/resources/segroup/society/edu/js/jquery.bxslider.min.js" />"></script>
    <script type="text/javascript">
	    function ilist(page) {
			location.href = "/smtp/community/sub04-05.do?curPage="
					+ page
					+ "&searchOption=${map.searchOption}"
					+ "&keyword=${map.keyword}";
		}
	
		function goBoardDetail(seq) {
			location.href = "/smtp/community/sub04-05-01.do?seq="+ seq;
		}
	
		function searchList() {
	
			location.href = "/smtp/community/sub04-05.do?curPage="
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
	
			location.href = "/smtp/community/sub04-05.do?searchOption="
					+ searchoption + "&keyword=" + searchword;
		}
    </script>
</head>
<body>
<div class="container_rainbow">
        <!-- Header-include -->
        <%@include file="../include/rainbow_header_basic.jsp" %>

        <div class="content sub-content sub04_content" id="main">
            <div class="header_textWrap">
                <h3 class="h3">졸업생 마당</h3>
                <p class="fc_999">
                	KITA-SES 컨소시움과정(SC IT마스터) 이야기
                </p>
            </div>
            <div class="section section_sub04-01">
                <div class="searchWrapper">
					<form class="formStyle d-flex" id="searchForm" onsubmit="return false;" style="margin-left: 0;">
						<div class="class-searchWrap d-flex justify_end">
							<select name="searchCondition" id="mySelect" class="select" onchange="mySelection()">
								<option value="contents">내용
	  							<option value="title">제목
							</select>
							<input type="text" class="cusPHIn input" id="searchword" name="searchKeyword" value="${search.searchKeyword}" placeholder="검색어를 입력해주세요.">
							<!-- 검색버튼 -->
							<button type="button" class="button img-icon search" id="searchBtn" onclick="search()"></button>
							<input type="hidden" id="searchOption"/>
						</div>
					</form>
				</div>
	            <div class="sub-segment table">
	                <ul class="class-list-title thead d-flex">
	                    <li class="c-table-02">날짜</li>
	                    <li class="c-table-name-wide">제목</li>
	                    <li class="c-table-02">글쓴이</li>
	                    <li class="c-table-01">조회수</li>
	                </ul>
	                <ul class="class-list-wrap" id="dataListUl">
	                	<c:if test="${fn:length(boardList) gt 0}">
	                		<c:forEach var="data" items="${boardList}" varStatus="status">
	                			<li class="class-list d-flex">
	                				<div class="c-table-02">
	                					<div class="d-flex icon-align">
	                						<div class="img-icon bullhorn-s"></div>
	                						${data.board_content_ins_dt}
	                					</div>
									</div>
									<div class="c-table-name-wide">
										<a href="javascript:goBoardDetail('${data.board_content_seq}')">
											<c:out value="${data.board_content_title}" />
										</a>
									</div>
									<div class="c-table-02">
										<c:out value="${data.board_content_nm}" />
									</div>
									<div class="c-table-01">
										<c:out value="${data.board_content_hit}" />
									</div>
								</li>
							</c:forEach>
						</c:if>
	                </ul>
	                <div class="page">
						<div class="pagination d-flex justify_between">
							<ul>
								<li>
									<ol class="d-flex">
										<!-- **처음페이지로 이동 : 현재 페이지가 1보다 크면  [처음]하이퍼링크를 화면에 출력-->
										<c:if test="${map.boardPager.curBlock > 1}">
											<li class="page-item">
												<input type="button" onclick="javascript:ilist('1')" name="" value="&lt&lt">
											</li>
										</c:if>
	
										<!-- **이전페이지 블록으로 이동 : 현재 페이지 블럭이 1보다 크면 [이전]하이퍼링크를 화면에 출력 -->
										<c:if test="${map.boardPager.curBlock > 1}">
											<li class="page-item">
												<input type="button" onclick="javascript:ilist('${map.boardPager.prevPage}')" name="" value="&lt">
											</li>
										</c:if>
										<!-- **하나의 블럭에서 반복문 수행 시작페이지부터 끝페이지까지 -->
										<c:forEach var="num" begin="${map.boardPager.blockBegin}" end="${map.boardPager.blockEnd}">
											<!-- **현재페이지이면 하이퍼링크 제거 -->
											<c:choose>
												<c:when test="${num == map.boardPager.curPage}">
													<li class="page-item">
														<input type="button" style="color: red" name="" value="${num}">
													</li>
												</c:when>
												<c:otherwise>
													<li class="page-item">
														<input type="button" onclick="ilist('${num}')" name="" value="${num}">
													</li>
												</c:otherwise>
											</c:choose>
										</c:forEach>
										<!-- **다음페이지 블록으로 이동 : 현재 페이지 블럭이 전체 페이지 블럭보다 작거나 같으면 [다음]하이퍼링크를 화면에 출력 -->
										<c:if test="${map.boardPager.curBlock <= map.boardPager.totBlock}">
											<li class="page-item">
												<input type="button" onclick="javascript:ilist('${map.boardPager.nextPage}')" name="" value="&gt">
											</li>
										</c:if>
	
										<!-- **끝페이지로 이동 : 현재 페이지가 전체 페이지보다 작거나 같으면 [끝]하이퍼링크를 화면에 출력 -->
										<c:if test="${map.boardPager.curPage <= map.boardPager.totPage}">
											<li class="page-item">
												<input type="button" onclick="javascript:ilist('${map.boardPager.totPage}')" name="" value="&gt&gt">
											</li>
										</c:if>
									</ol>
								</li>
							</ul>
	            		</div>
        			</div>
    			</div>
			</div>
		</div>
	    <!-- footer-include -->
	    <%@include file="../include/common_footer_rainbow.jsp" %>
    </div>
</body>
</html>
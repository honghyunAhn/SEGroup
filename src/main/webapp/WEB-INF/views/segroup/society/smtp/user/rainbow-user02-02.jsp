<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!-- 나의강의실 >> 마일리지 -->
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <%@include file="../include/rainbow_head.jsp"%>
    <script type="text/javascript" src="/resources/js/jquery.twbsPagination.js"></script>
    <script type="text/javascript">
        $(document).ready(function(){
        	navLinks[4].parentElement.classList.add('current')
            subNav[4].classList.add('active');
	    	var pointTotalPages = ${searchVO.pointTotalPages};
	    	var pointVisiblePages = ${searchVO.pointVisiblePages};
	    	var pointStartPage = ${searchVO.pointStartPage};
	
	    	if (pointTotalPages != 0) {
	    		$('#pointPagination').twbsPagination({
	    	        totalPages: pointTotalPages,
	    	        visiblePages: pointVisiblePages,
	    	        startPage: pointStartPage,
	    	        first : "",
	    	        prev : '<div class="img-icon angle-left floatL"></div>PREV',
	    	        next : '<div class="img-icon angle-right floatR"></div>NEXT',
	    	        anchorClass: "prev",
	    	        last : "",
	    	        initiateStartPageClick : false,
	    	        onPageClick: function (event, page) {
	    	            $('#pointStartPage').val(page);
	    	            $("#searchForm").submit();
	    	        }
	        	});
	    	}
	
	    	var couponTotalPages = ${searchVO.couponTotalPages};//전체페이지
	    	var couponVisiblePages = ${searchVO.couponVisiblePages};//리스트보여줄페이지
	    	var couponStartPage = ${searchVO.couponStartPage};//현재페이지
			
	    });
	     </script>

</head>

<body>
    <div class="container_rainbow">
    <%@include file="../include/rainbow_header.jsp"%>
        <div class="content myClass course-point05" id="main">
            <div class="sub-content class01-01">
                <div class="section_header">
                    <h3 class="h3">💰 마일리지 현황</h3>
                    <p class="margin-top10 fc_999">
                        나의 마일리지 현황 및 마일리지 적립/사용 정책을 확인하실 수 있습니다.
                    </p>
                </div>
                <div class="section_table">
                    <div class="d-flex margin-top20 margin-bottom20">
                        <div class="fc_999">사용 가능 마일리지</div>
                        <div class="margin-left10">
                            <strong>
                                <fmt:formatNumber value="${pointSummary.BALANCE }" groupingUsed="true" />
                            </strong>
                        </div>
                    </div>
                    <ul class="table-title thead d-flex">
                        <li class="w50">No.</li>
                        <li class="w100">일시</li>
                        <li class="w350">내역</li>
                        <li class="w100">마일리지</li>
                    </ul>
                    <c:if test = "${!empty pointList }">
                           	<c:forEach var="item" items="${pointList }" varStatus="status">
	                            <ul class="class-list-wrap">
	                                <li class="class-list d-flex">
	                                    <div class="c-table-num">${status.count}</div>
	                                    <div class="c-table-02">${item.REG_DATE }</div>
	                                    <div class="c-table-name-w">${item.NOTE }</div>
	                                    	<c:if test="${item.WITHDRAW == 0}">
											<div class="c-table-02 mile-plus cMain">+ <fmt:formatNumber value="${item.GIVE }" groupingUsed="true"/></div>
											</c:if>
											<c:if test="${item.GIVE == 0}">
											<div class="c-table-02 mile-minus cDanger">- <fmt:formatNumber value="${item.WITHDRAW}" groupingUsed="true"/></div>
											</c:if>
					                      
	                                </li>
	                            </ul>
                           	</c:forEach>
                    </c:if>
                    <c:if test="${empty pointList }">
                    <ul class="class-list-wrap">
                     	<li class="listAndWrap">
                     	<div class="class-list justify_center">포인트 적립 내용이 없습니다.</div></li></ul>
                    </c:if>
                    <c:if test="${!empty pointList }">
                        <c:forEach var="item" items="${pointList }" varStatus="status">
                            #
                                    <div class="w50">No.</div>
                                    <div class="w100">일시</div>
                                    <div class="w350">수강신청 마일리지 사용</div>
                                    <div style="color: firebrick" class="w100">
                                        - 20000
                                    </div>
                                </li>
                                <li class="list d-flex">
                                    <div class="w50">No.</div>
                                    <div class="w100">일시</div>
                                    <div class="w350">수강신청 마일리지 적립</div>
                                    <div style="color: darkblue" class="w100">
                                        + 1000
                                    </div>
                                </li>
                                <!-- <li class="list d-flex">
                                    <div class="w50">${status.count}</div>
                                    <div class="w100">${item.REG_DATE }</div>
                                    <div class="w350">${item.NOTE }</div>
                                    <c:if test="${item.WITHDRAW == 0}">
                                        <div style="color: darkblue" class="w100">+
                                            <fmt:formatNumber value="${item.GIVE }" groupingUsed="true" />
                                        </div>
                                    </c:if>
                                    <c:if test="${item.GIVE == 0}">
                                        <div style="color: firebrick" class="w100">-
                                            <fmt:formatNumber value="${item.WITHDRAW}" groupingUsed="true" />
                                        </div>
                                    </c:if>
                                </li> -->
                            </ul>
                        </c:forEach>
                    </c:if>
                </div>
                <div class="page">
	                <ul class="pagination d-flex justify_between" id="pointPagination">
	                </ul>
                </div>
                <!-- 기존 레인보우사이트 pagination 복사 >> 확인 필요 -->
                <div class="section_pagination">
                    <ul class="d-flex justify_center" id="pagination">
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
                        </ul>
                </div>
                <div class="section_view">
                    <div class="view_content">
                        <h3 class="h3">마일리지 적립/사용 정책</h3>
                        <ul class="margin-top20">
                            <li>1. 신규회원가입 + 3,000 마일리지 적립</li>
                            <li>2. 교육과정 수강 결제 결제 금액의 2% 적립</li>
                            <li>3. 수강후기 작성 + 1,000 마일리지 적립</li>
                            <li class="h5 fc_999">적립된 마일리지는 최대 2년 까지 사용 가능합니다.</li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
        <%@include file="../include/rainbow_footer.jsp"%>
    </div>
</body>

</html>
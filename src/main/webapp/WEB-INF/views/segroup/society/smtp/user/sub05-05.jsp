<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
    
	<!-- 레인보우 기본 세팅 -->
    <link rel="stylesheet" href="/resources/segroup/society/smtp/css/reset.css">
    <link rel="stylesheet" href="/resources/segroup/society/smtp/css/common.css">
    <link rel="stylesheet" href="/resources/segroup/society/smtp/css/img-icon.css">
    <link rel="stylesheet" href="/resources/segroup/society/smtp/css/swiper.min.css">
    <link rel="stylesheet" href="/resources/segroup/society/smtp/css/rainbow_style.css">
    <link rel="stylesheet" href="/resources/segroup/society/smtp/css/rainbow_style_responsive.css">
    <script src="/resources/segroup/society/smtp/js/jquery-3.3.1.min.js"></script>
    <script src="/resources/segroup/society/smtp/js/swiper.js"></script>
    <script src="/resources/segroup/society/smtp/js/rainbow_script.js"></script>
    <script src="/resources/segroup/society/smtp/js/rainbow_script_responsive.js"></script>
    <!-- Pagination -->
	<script type="text/javascript" src="/resources/js/jquery.twbsPagination.js"></script>
	<script type="text/javascript">
		$(document).ready(function(){
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
		<!-- Header-include -->
        <%@include file="../include/rainbow_header_basic.jsp" %>
        <div class="content sub-content sub05_content" id="main">
            <div class="header_textWrap">
                <h3 class="h3">마일리지 현황</h3>
                <p class="fc_999">
					나의 마일리지 현황 및 마일리지 적립/사용 정책을 확인하실 수 있습니다.
                </p>
                <form id="searchForm" method="post">
					<input type="hidden" name="pointStartPage" id="pointStartPage" value="${searchVO.pointStartPage }" />
				</form>
            </div>
            <div class="section section_sub05-05">
                <div class="sub-section">
                    <div class="titleBar-hdr">나의 마일리지 현황</div>
                    
                    <div class="sub-segment">
                        <div class="my-mileageWrap d-flex">
                            <div class="img-icon mileageImg"></div>
                            <div class="my-mileage">
                                <h5 class="h5 c999">사용가능</h5>
                                <div class="h2 fc_pp"><fmt:formatNumber value="${pointSummary.BALANCE }" groupingUsed="true"/></div>
                            </div>
                        </div>
                        <div class="myMileage-list">
	                        <div id="mypage-point">
	                            <ul class="class-list-title thead d-flex">
	                                <li class="c-table-num">No.</li>
	                                <li class="c-table-02">일시</li>
	                                <li class="c-table-name-w">내역</li>
	                                <li class="c-table-02">마일리지</li>
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
	                        </div>
	                        <div class="page">
                                <ul class="pagination d-flex justify_between" id="pointPagination">
                                </ul>
                            </div>
                    	</div>
                    </div>
                </div>
                <div class="sub-section">
                    <div class="titleBar-hdr">마일리지 적립/사용 정책</div>
                    <div class="sub-segment c999">
                        <ul class="policy-list">
                            <li>1. 신규회원가입 <strong class="c333">+ 3,000 마일리지 적립</strong></li>
                            <li>2. 교육과정 수강 결제 <strong class="c333">결제 금액의 2% 적립</strong></li>
                            <!-- <li>3. 이벤트/온라인 설문참여 진행시 <strong class="c333">명시된 마일리지 적립</strong></li> -->
                            <li>3. 수강후기 작성 <strong class="c333">+ 1,000 마일리지 적립</strong></li>
                            <!-- <li>5. 로그인 <strong class="c333">+ 100 마일리지 적립</strong><span class="h5">(1일 1회 한정)</span></li> -->
                            <h5 class="h5">적립된 마일리지는 <strong>최대 2년</strong>까지 사용 가능합니다.</h5>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
        <!-- footer-include -->
        <%@include file="../include/common_footer_rainbow.jsp" %>
	</div>
</body>
</html>
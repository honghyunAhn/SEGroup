<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
	<meta name="description" content=디지털·AI, 외국어, 직무, 자격증까지! Let's Do it! Do it campus!">
    <meta name="keywords" content="디지털, AI, 빅데이터, 프로그래밍, 정보처리, 데이터베이스, 클라우드, 외국어, 영어, 일본어, 중국어, 직무, 경영, 사업전략, 리더십, 코칭, 마케팅, CS, 자기관리, 커뮤니케이션, 법정의무, 취업, 해외취업, Soft Engineer Society, SES, 소프트엔지니어소사이어티, SCIT, SWDO, E러닝, e-learning">
    <title>Let's Do it 두잇캠퍼스</title>
<link rel="stylesheet" href="/resources/lms/css/reset.css">
<link rel="stylesheet" href="/resources/lms/css/common.css">
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/lms/css/img-icon.css" />">
<link rel="stylesheet" href="/resources/lms/css/style.css">
<link rel="stylesheet" href="/resources/lms/css/style_responsive.css">
<link rel="stylesheet" href="/resources/lms/css/renewal_style.css">
    <script src="<c:url value="/resources/lms/js/jquery-3.3.1.min.js" />"></script>
	<%-- <script src="<c:url value="/resources/lms/js/common.js" />"></script> --%>
    <!-- Pagination을 위한 js -->
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
    	        prev : "«",
    	        next : "»",
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
    <style type="text/css">
    .page-align{text-align:center;}
    .page-item{ margin-top : 5px; margin-left : 20px; display:inline-block;}
    </style>
</head>

<body>
    <div class="skip-navigation">
        <!--웹접근성/content-->
        <p><a class="goToMain" href="#main">콘텐츠 바로가기</a></p>
    </div>

    <!-- header-include -->
    <%@include file="../sub_header.jsp"%>


    <div class="container subPage_container sub07 d-flex">
        <!-- sub07 나의강의실-include -->
        <%@include file="../user/menu/leftmenu07.jsp"%>

        <div class="subPage_content sub-content margin-left20 sub07 sub07-03" id="main">
            <!-- <div class="page-locationWrap">
                <ul class="page-location">
                    
                    home 메인 / category menu 대분류 / division menu 중분류 / section menu 소분류
                   
                    <li class="img-icon home"><a href="/"></a></li>
                    <li class="img-icon chevron-right"></li>
                    <li class="category-menu"><a href="/lms/user/sub07-01-01">나의강의실</a></li>
                    <li class="img-icon  chevron-right"></li>
                    <li class="division-menu"><a href="/lms/user/sub07-03">마일리지</a></li>
                    <li class="img-icon  chevron-right"></li>
                    <li class="section-menu"><a href="sub07-01-03.html">학습종료</a></li>
                </ul>
                <div class="img-icon  chevron-right"></div>
                <div class="sub-content sub00-01"></div>
            </div> -->
            <div class="header">
                <div class="titleBar h3">마일리지 정보</div>
                <!-- <h3 class="h3"></h3> -->
                <form id="searchForm" method="post">
					<input type="hidden" name="pointStartPage" id="pointStartPage" value="${searchVO.pointStartPage }" />
				</form>
            </div>
            <div class="section sub07-03">
                <div class="sub-section">
                    <div class="titleBar-hdr">나의 마일리지 현황</div>
                    <div class="sub-segment d-flex">
                        <div class="my-mileageWrap d-flex">
                            <div class="img-icon mileageImg"></div>
                            <div class="my-mileage">
                                <h5 class="h5 c999">사용가능</h5>
                                <div class="h2 fc_orD"><fmt:formatNumber value="${pointSummary.BALANCE }" groupingUsed="true"/></div>
                            </div>
                        </div>
                        <div class="mileage-list" id="mypage-point">
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
                                <!-- <li class="class-list d-flex">
                                    <div class="c-table-num">2</div>
                                    <div class="c-table-02">2019.08.05</div>
                                    <div class="c-table-name-w"><strong>과정신청</strong> 세상에서 가장 쉬운 영단어 Step 1</div>
                                    <div class="c-table-02 mile-minus cDanger">- 2,000</div>
                                </li> -->
                            </ul>
                            	</c:forEach>
                            </c:if>
                            <c:if test="${empty pointList }">
                             <ul class="class-list-wrap">
                             <li class="class-list d-flex">
                             <div class="c-table-name-w">포인트 적립 내용이 없습니다.</div></li></ul>
                            </c:if>
                            <div class="page-align">
                            <ul class="pagination" id="pointPagination"></ul>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="sub-section d-flex">
                    <div class="titleBar-hdr">마일리지 적립/사용 정책</div>
                    <div class="sub-segment c999">
                        <ul>
                            <li>1. 신규회원가입 <strong class="c333">+ 5,000 마일리지 적립</strong></li>
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
    </div>
    <!-- footer-include -->
    <%@include file="../common_footer_doitcam.jsp"%>
</body>

</html>

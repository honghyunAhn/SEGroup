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
    <style type="text/css">
    	.twPaging{
    		margin: 0 5px;
    		width: 20px;
    		text-align: center;
    		vertical-align: middle;
    		padding-top: 1px;
    	}
    </style>
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
	    	        first : '<input type="button" style="margin: 0 5px;" class="btn_default fc_point" value="&lt&lt" />',
	    	        prev : '<input type="button" style="margin: 0 5px;" class="btn_default fc_point" value="&lt" />',
	    	        next : '<input type="button" style="margin: 0 5px;" class="btn_default fc_point" value="&gt" />',
	    	        pageClass: 'btn_default twPaging',
	    	        activeClass : 'btn_default fc_point',
	    	        last : '<input type="button" style="margin: 0 5px;" class="btn_default fc_point" value="&gt&gt" />',
	    	        initiateStartPageClick : false,
	    	        onPageClick: function (event, page) {
	    	            $('#pointStartPage').val(page);
	    	            $("#searchForm").submit();
	    	        }
	        	});
	    	}
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
                    <form id="searchForm" method="post">
						<input type="hidden" name="pointStartPage" id="pointStartPage" value="${searchVO.pointStartPage }" />
					</form>
                </div>
                <div class="section_table">
                    <div class="d-flex margin-top20 margin-bottom20">
                        <div class="fc_999">사용 가능 마일리지</div>
                        <div class="margin-left10">
                            <strong>
                                <fmt:formatNumber value="${pointSummary.BALANCE }" groupingUsed="true"/>
                            </strong>
                        </div>
                    </div>
                    <div id="mypage-point">
	                    <ul class="table-title thead d-flex">
	                        <li class="w50">No.</li>
	                        <li class="w100">일시</li>
	                        <li class="w350">내역</li>
	                        <li class="w100">마일리지</li>
	                    </ul>
	                    <c:if test = "${!empty pointList }">
	                           	<c:forEach var="item" items="${pointList }" varStatus="status">
		                            <ul class="table-list tbody">
		                                <li class="list d-flex">
		                                    <div class="w50">${status.count}</div>
		                                    <div class="w100">${item.REG_DATE }</div>
		                                    <div class="w350">${item.NOTE }</div>
		                                    	<c:if test="${item.WITHDRAW == 0}">
												<div style="color: darkblue" class="w100">+ <fmt:formatNumber value="${item.GIVE }" groupingUsed="true"/></div>
												</c:if>
												<c:if test="${item.GIVE == 0}">
												<div style="color: firebrick" class="w100">- <fmt:formatNumber value="${item.WITHDRAW}" groupingUsed="true"/></div>
												</c:if>
						                      
		                                </li>
		                            </ul>
	                           	</c:forEach>
	                    </c:if>
	                    <c:if test="${empty pointList }">
	                    <ul class="table-list tbody">
	                     	<li class="list not fc_999">포인트 적립 내용이 없습니다.</li>
	                    </ul>
	                    </c:if>
	                </div>
                </div>
                <div class="section_pagination page">
	                <ul class="d-flex justify_center" id="pointPagination">
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
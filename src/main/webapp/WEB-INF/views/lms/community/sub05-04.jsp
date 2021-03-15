<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Soft Engineer Society</title>
    <link rel="stylesheet" type="text/css" href="<c:url value="/resources/lms/css/img-icon.css" />">
    <link rel="stylesheet" type="text/css" href="<c:url value="/resources/lms/css/style.css" />">
    <link rel="stylesheet" type="text/css" href="<c:url value="/resources/lms/css/style_responsive.css" />">
    <script src="<c:url value="/resources/lms/js/jquery-3.3.1.min.js" />"></script>
<%--     <script src="<c:url value="/resources/lms/js/common.js" />"></script> --%>
    <!-- Pagination을 위한 js -->
	<script type="text/javascript" src="/resources/js/jquery.twbsPagination.js"></script>
</head>

<script type="text/javascript">
$(document).ready(function(){
	var totalPages = ${totalPages};//전체 페이지
    var visiblePages = ${visiblePages};//리스트 보여줄 페이지
    var startPage = ${startPage};//현재 페이지
    
    if('${totalPages}' != 0){
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
	            $('#startPage').val(page);
	            $("#searchForm").submit();
	        }
    	});
 	};

 	//pagination css 포맷에 맞게 설정하는 작업
 	$('.page-item').children().addClass('num');
 	$('.page-item.prev').children().removeClass('num').addClass('prev');
 	$('.page-item.prev').children().html('<div class="img-icon angle-left floatL"></div>PREV');
 	$('.page-item.next').children().removeClass('num').addClass('next');
 	$('.page-item.next').children().html('<div class="img-icon angle-right floatR"></div>NEXT');
	$('.page-item.active').children().addClass('active');
	
	$('#visiblePages').change(function(){
		$('#searchForm').submit();
	})
	
});

function goDetail(id) {	
	$('#moveForm input[name="id"]').val(id);
	$('#moveForm').submit();	
}
</script>

<body>
    <div class="skip-navigation">
        <!--웹접근성/content-->
        <p><a class="goToMain" href="#main">콘텐츠 바로가기</a></p>
    </div>

    <!-- header-include -->
    <%@include file="../header.jsp"%>


    <div class="container sub05" id="main">
        <!-- sub05 커뮤니티-include -->
        <%@include file="../community/menu/leftmenu.jsp"%>

        <div class="sub-content sub05-04">
            <div class="page-locationWrap">
                <ul class="page-location">
                    <!--
                    home 메인 / category menu 대분류 / division menu 중분류 / section menu 소분류
                    -->
                    <li class="img-icon  home"><a href="index.html"></a></li>
                    <li class="img-icon  chevron-right"></li>
                    <li class="category-menu"><a href="/lms/community/sub05-01-01">커뮤니티</a></li>
                    <li class="img-icon  chevron-right"></li>
                    <li class="division-menu"><a href="/lms/community/sub05-04">자유게시판</a></li>
                    <!-- <li class="img-icon  chevron-right"></li>
                    <li class="section-menu"><a href="sub05-03-02.html">1:1상담</a></li> -->
                </ul>
                <div class="img-icon  chevron-right"></div>
                <!-- <div class="sub-content sub00-01"></div> -->
            </div>
            <div class="header-box">
                <!-- image로 구성 될 경우에 .header-box에 background 처리하기 -->
                <!-- <div class="box-titleBar"></div>
                <h3 class="h3">자유게시판</h3>
                <p class="c999">
                    레인보우 회원들과 자유롭게 나눌 수 있는 공간<br>함께 나누고 싶은 이야기라면 무엇이든 좋아요!
                </p> -->
            </div>
            <div class="section sub05-04">
                <div class="sub-section">
                    <div class="searchWrapper">
                        <div class="class-searchWrap floatR">
                            <form id="searchForm" class="d-flex">
                                <div class="viewWrap">
                                    <select id="visiblePages" name="visiblePages" class="view-class">
                                        <option value="10" selected>10개씩보기</option>
                                        <option value="20" <c:if test="${visiblePages eq '20'}">selected = "selected"</c:if>>20개씩 보기</option>
                                        <option value="30" <c:if test="${visiblePages eq '30'}">selected = "selected"</c:if>>30개씩 보기</option>
                                        <option value="40" <c:if test="${visiblePages eq '40'}">selected = "selected"</c:if>>40개씩 보기</option>
                                        <option value="50" <c:if test="${visiblePages eq '50'}">selected = "selected"</c:if>>50개씩 보기</option>
                                    </select>
                                    <input type="hidden" id="startPage" name="startPage" value="${startPage}">
									<input type="hidden" id="board_type" name="board_type" value="8">
                                </div>
                            </form>
                        </div>
                    </div>
                    <div class="sub-segment table">
                        <ul class="class-list-title thead d-flex">
                            <li class="c-table-num">No.</li>
                            <li class="c-table-name">제목</li>
                            <li class="c-table-01">등록일</li>
                            <li class="c-table-01">작성자</li>
                            <li class="c-table-01">조회수</li>
                        </ul>
						<ul class="class-list-wrap">
							<c:if test="${!empty bbslist}">
								<c:forEach var="bbslist" items="${bbslist}" varStatus="status">
									<li class="class-list d-flex">
										<div class="c-table-num"><fmt:formatNumber value="${totalCnt - (startPage-1)*visiblePages - status.index}" /></div>
										<div class="c-table-name ">
											<input type="hidden" name="checkId" value="${bbslist.id}">
											<a href="javascript:goDetail('${bbslist.id}')">
												<p class="text-over-lh20">${bbslist.title}</p>
											</a>
										</div>
										<div class="c-table-01 c-table-date">${bbslist.reg_date_format2}</div>
										<c:choose>
											<c:when test="${!empty bbslist.user_name}">
												<div class="c-table-01">${bbslist.user_name}</div>
											</c:when>
											<c:otherwise>
												<div class="c-table-01">${bbslist.reg_name}</div>
											</c:otherwise>
										</c:choose>
										
										<div class="c-table-01">${bbslist.hits}</div>
									</li>
								</c:forEach>
							</c:if>
							<c:if test="${empty bbslist}">
								<tr>
									<td colspan="5">조회된 내용이 없습니다.</td>
								</tr>
							</c:if>


						</ul>
					</div>
                </div>
                <div class="page">
                    <ul class="pagination d-flex" id="pagination">
                        <!-- <li><a href="#" class="prev-pageWrap">&lt;&lt;</a></li> -->
                        <!-- <li><a href="#" class="prev">
                                <div class="img-icon angle-left floatL"></div>PREV
                            </a></li>
                        <li><a href="#" class="active num">1</a></li>
                        <li><a href="#" class="num">2</a></li>
                        <li><a href="#" class="num">3</a></li>
                        <li><a href="#" class="num">4</a></li>
                        <li><a href="#" class="num">5</a></li>
                        <li><a href="#" class="next">
                                <div class="img-icon angle-right floatR"></div>NEXT
                            </a></li> -->
                        <!-- <li><a href="#" class="next-pageWrap">&gt;&gt;</a></li> -->
                    </ul>
                </div>
                <div class="button btn-pColor btn-write section-out-btn"><a href="/lms/community/sub05-04-write">글쓰기</a></div>
            </div>

        </div>
    </div>
    
    <form action="/lms/community/sub05-04-view" id="moveForm" name="moveForm" action="post">
		<input type="hidden" name="startPage" value="<c:out value="${startPage}"/>"/>
		<input type="hidden" name="visiblePages" value="<c:out value="${visiblePages}"/>">
		<input type="hidden" name="board_type" value="8"/>
		<input type="hidden" name="id"/>
	</form>
    
    <!-- footer-include -->
    <%@include file="../common_footer_doitcam.jsp"%>
</body>

</html>
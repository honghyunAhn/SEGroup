<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
	<!-- 홈페이지의 대략적인 설명 >> 검색 결과 제목 하단에 설명으로 노출 -->
    <meta name="description" content=디지털·AI, 외국어, 직무, 자격증까지! Let's Do it! Do it campus!">
    <!-- 홈페이지 키워드 >> 키워드 검색했을 때 검색결과로 노출 -->
    <meta name="keywords" content="디지털, AI, 빅데이터, 프로그래밍, 정보처리, 데이터베이스, 클라우드, 외국어, 영어, 일본어, 중국어, 직무, 경영, 사업전략, 리더십, 코칭, 마케팅, CS, 자기관리, 커뮤니케이션, 법정의무, 취업, 해외취업, Soft Engineer Society, SES, 소프트엔지니어소사이어티, SCIT, SWDO, E러닝, e-learning">
    <title>Let's Do it 두잇캠퍼스</title>
	<link rel="stylesheet" href="/resources/lms/css/swiper.min.css">
	<link rel="stylesheet" href="/resources/lms/css/reset.css">
	<link rel="stylesheet" href="/resources/lms/css/common.css">
	<link rel="stylesheet" href="/resources/lms/css/img-icon.css">
	<link rel="stylesheet" href="/resources/lms/css/style.css">
	<link rel="stylesheet" href="/resources/lms/css/style_responsive.css">
	<link rel="stylesheet" href="/resources/lms/css/renewal_style.css">
    <script src="/resources/lms/js/jquery-3.3.1.min.js"></script>
    <script src="/resources/lms/js/swiper.js"></script>
    <script src="/resources/lms/js/renewal_script.js"></script>
	<!-- Pagination을 위한 js -->
	<script type="text/javascript" src="/resources/js/jquery.twbsPagination.js"></script>
	<script type="text/javascript" src="/resources/lms/js/lms_community_script.js"></script>
    
</head>


<script type="text/javascript">

$(document).ready(function(){

	$('.home').on('click', function(){
		document.location.href = '/lms/main';
	}); 	
 	
 	
 	$("#searchBtn").click(function(event){
 		$('#startPage').val(1);
 		setContent();
 	});

 	$("#movePage").on('click', function(){
 		document.location.href = "/lms/community/sub05-01-02";
 	});

 	
 	/* 타이틀 클릭시 해당 글 내용 보여주기 */
 	$('.board-list').on('click', function(){
		var id = $(this).attr('data-value');
		document.location.href = "/lms/community/sub05-01-view?board_content_seq=" + id;
 	});
 	
 	
 	//pagination css 포맷에 맞게 설정하는 작업
 	$('.page-item').children().addClass('num');
 	$('.page-item.prev').children().removeClass('num').addClass('prev');
 	$('.page-item.prev').children().html('<div class="img-icon angle-left floatL"></div>PREV');
 	$('.page-item.next').children().removeClass('num').addClass('next');
 	$('.page-item.next').children().html('<div class="img-icon angle-right floatR"></div>NEXT');
	$('.page-item.active').children().addClass('active');
	
	setContent();
	setEvent();
	
});

</script>



<body>
    <div class="skip-navigation">
        <!--웹접근성/content-->
        <p><a class="goToMain" href="#main">콘텐츠 바로가기</a></p>
    </div>

    <!-- header-include -->
    <%@include file="../sub_header.jsp"%>


    <div class="container subPage_container sub05 d-flex">
        <!-- sub05 커뮤니티-include -->
        <%@include file="../community/menu/leftmenu.jsp"%>

        <div class="subPage_content margin-left20" id="main">
			<div class="sp_header">
                <div class="header_textWrap">
                    <h3 class="h3">공지사항/이벤트</h3>
                    <p class="fc_999">공지사항 및 이벤트를 알려드립니다. 유익하고 풍성한 소식 놓치지 말고 확인하세요</p>
                </div>
            </div>
            
            <div class="section sub05-01-01">
                <!-- 공지사항 탭 -->
                <div class="class-tabMenu">
                    <ul class="tabGroup d-flex">
                        <li class="active">공지사항</li>
                        <li id="movePage">이벤트</li>
                    </ul>
                    <div class="subGroup">
                        <div class="tab-sub sub01">
                            <div class="sub-section">
                                <div class="searchWrapper">
                                    <div class="class-searchWrap floatR">
                                        <form class="d-flex" id="searchForm">
                                            <div class="search-filter-wrap">
                                                <select name="searchCondition" class="search-filter">
													<option value="all" ${param.searchCondition eq 'all'? 'selected':''}>제목+내용</option>
													<option value="title" ${param.searchCondition eq 'title'? 'selected':''}>제목</option>
													<option value="content" ${param.searchCondition eq 'content'? 'selected':''}>내용</option>
                                                </select>
                                            </div>
                                            <div class="class-search-down d-flex">
                                                <input type="text" name="searchKeyword" class="cusPHIn input" value="${param.searchKeyword}" placeholder="검색어를 입력해주세요.">
                                                <!-- 검색버튼 -->
                                                <button type="button" class="button img-icon search" id="searchBtn"></button>
	                                            <input type="hidden" id="startPage" name="startPage" value="${startPage}">
                                            </div>
                                        </form>
                                    </div>
                                </div>
                                <div class="sub-segment table">
                                    <ul class="class-list-title thead d-flex">
                                        <li class="c-table-num">No.</li>
                                        <li class="c-table-name-w">제목</li>
                                        <li class="c-table-02">등록일</li>
                                        <li class="c-table-02">구분</li>
                                        <li class="c-table-01">조회수</li>
                                    </ul>
                                    <ul class="class-list-wrap" id="dataListUl">
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
<!--             <div class="page"> -->
<!--                 <ul class="pagination d-flex" id="pagination"></ul> -->
<!--             </div> -->
        </div>
    </div>

    <!-- footer-include -->
    <%@include file="../common_footer_doitcam.jsp"%>
</body>

</html>
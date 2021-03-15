<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
</head>

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

        <div class="sub-content sub05-02">
            <div class="page-locationWrap">
                <ul class="page-location">
                    <!--
                    home 메인 / category menu 대분류 / division menu 중분류 / section menu 소분류
                    -->
                    <li class="img-icon  home"><a href="/lms/main"></a></li>
                    <li class="img-icon  chevron-right"></li>
                    <li class="category-menu"><a href="/lms/community/sub05-01-01">커뮤니티</a></li>
                    <li class="img-icon  chevron-right"></li>
                    <li class="division-menu"><a href="/lms/community/sub05-02">수강후기/인터뷰</a></li>
                    <!-- <li class="img-icon  chevron-right"></li>
                    <li class="section-menu"><a href="sub05-03-02.html">1:1상담</a></li> -->
                </ul>
                <div class="img-icon  chevron-right"></div>
                <!-- <div class="sub-content sub00-01"></div> -->
            </div>
            <div class="header-box">
                <!-- image로 구성 될 경우에 .header-box에 background 처리하기 -->
                <!-- <div class="box-titleBar"></div>
                <h3 class="h3">수강후기 & 인터뷰</h3>
                <p class="c999">
                    완벽한 커리큘럼과 세심한 학습관리로 높은 합격률과 자격증 취득률!
                    <br>취업인터뷰와 수강생이 말하는 레인보우 후기를 확인하세요.
                </p> -->
            </div>
            <div class="section sub05-02">
                <div class="sub-section">
                    <div class="searchWrapper">
                        <div class="class-searchWrap floatR">
                            <form class="d-flex">
                                <div class="search-filter-wrap">
                                    <select name="search-filter" class="search-filter">
                                        <option value="ttl" selected>제목+내용</option>
                                        <option value="ttl">제목</option>
                                        <option value="ctt">내용</option>
                                    </select>
                                </div>
                                <div class="class-search-down d-flex">
                                    <input type="text" class="cusPHIn input" value placeholder="검색어를 입력해주세요.">
                                    <!-- 검색버튼 -->
                                    <button type="button" class="button img-icon search" id="searchBtn">

                                    </button>
                                </div>
                                <!--<div class="viewWrap">
                                <select name="view-class" id="view-class">
                                <option value="10v" selected>10개씩 보기</option>
                                <option value="20v">20개씩 보기</option>
                                <option value="30v">30개씩 보기</option>
                                <option value="40v">40개씩 보기</option>
                                <option value="50v">50개씩 보기</option>
                                </select>
                            </div> -->
                            </form>
                        </div>
                    </div>
                    <div class="sub-segment table">
                        <ul class="class-list-title thead d-flex">
                            <li class="c-table-num">No.</li>
                            <li class="c-table-name-w">제목</li>
                            <li class="c-table-01">등록일</li>
                            <li class="c-table-01">조회수</li>
                        </ul>
                        <ul class="class-list-wrap">
                            <!-- 목록 추가시 class-list 추가 -->
                            <li class="class-list d-flex">
                                <div class="c-table-num">1</div>
                                <div class="c-table-name-w ">
                                    <a href="#">
                                        <p class="text-over-lh20">
                                            새가 인간은 사랑의 않는 뿐이다. 얼음이 밝은 웅대한 뿐이다.
                                        </p>
                                    </a>
                                </div>
                                <div class="c-table-01 c-table-date">2019.08.05</div>
                                <div class="c-table-01">6</div>
                            </li>
                            <li class="class-list d-flex">
                                <div class="c-table-num">2</div>
                                <div class="c-table-name-w ">
                                    <a href="#">
                                        <p class="text-over-lh20">
                                            새가 인간은 사랑의 않는 뿐이다.
                                        </p>
                                    </a>
                                </div>
                                <div class="c-table-01 c-table-date">2019.08.05</div>
                                <div class="c-table-01">11</div>
                            </li>
                            <li class="class-list d-flex">
                                <div class="c-table-num">3</div>
                                <div class="c-table-name-w ">
                                    <a href="#">
                                        <p class="text-over-lh20">
                                            새가 인간은 사랑의 않는 뿐이다. 얼음이 밝은 웅대한 뿐이다.
                                        </p>
                                    </a>
                                </div>
                                <div class="c-table-01 c-table-date">2019.08.05</div>
                                <div class="c-table-01">16</div>
                            </li>
                        </ul>
                    </div>
                </div>
                <div class="page">
                    <ul class="pagination d-flex">
                        <!-- <li><a href="#" class="prev-pageWrap">&lt;&lt;</a></li> -->
                        <li><a href="#" class="prev">
                                <div class="img-icon angle-left floatL"></div>PREV
                            </a></li>
                        <li><a href="#" class="active num">1</a></li>
                        <li><a href="#" class="num">2</a></li>
                        <li><a href="#" class="num">3</a></li>
                        <li><a href="#" class="num">4</a></li>
                        <li><a href="#" class="num">5</a></li>
                        <li><a href="#" class="next">
                                <div class="img-icon angle-right floatR"></div>NEXT
                            </a></li>
                        <!-- <li><a href="#" class="next-pageWrap">&gt;&gt;</a></li> -->
                    </ul>
                </div>
            </div>
        </div>
    </div>
    <!-- footer-include -->
    <%@include file="../common_footer_doitcam.jsp"%>
</body>

</html>

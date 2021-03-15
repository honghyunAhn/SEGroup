<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
    <!-- <link rel="stylesheet" href="css/renewal_responsive.css"> -->
    <script src="/resources/lms/js/jquery-3.3.1.min.js"></script>
    <!-- <script src="/resources/lms/js/swiper.js"></script>
    <script src="/resources/lms/js/renewal_script.js"></script> -->
    <script src="<c:url value="/resources/lms/js/common.js" />"></script>
</head>

<body>
    <div class="skip-navigation">
        <!--웹접근성/content-->
        <p><a class="goToMain" href="#main">콘텐츠 바로가기</a></p>
    </div>

    <!-- header-include -->
   <%@include file="../sub_header.jsp"%>


    <div class="container subPage_container sub06 d-flex">
        <!-- sub06 고객센터-include -->
 <%@include file="../support/menu/leftmenu.jsp"%>

        <div class="sub-content sub06-03 subPage_content margin-left20" id="main">
            <!-- <div class="page-locationWrap">
                <ul class="page-location">
                    
                home 메인 / category menu 대분류 / division menu 중분류 / section menu 소분류
               
                    <li class="img-icon home"><a href="index.html"></a></li>
                    <li class="img-icon chevron-right"></li>
                    <li class="category-menu"><a href="sub06-01-01.html">고객센터</a></li>
                    <li class="img-icon chevron-right"></li>
                    <li class="division-menu"><a href="sub06-03.html">단체/제휴문의</a></li>
                    <li class="img-icon chevron-right"></li>
                    <li class="section-menu"><a href="sub06-03-01.html">단체문의</a></li>
                </ul>
                <div class="img-icon chevron-right"></div>
                <div class="sub-content sub00-01"></div>
            </div> -->
            <img src="/resources/lms/img/infoImg-grp.jpg" alt="단체문의안내이미지" width="100%">
        </div>
    </div>

    <!-- footer-include -->
     <%@include file="../common_footer_doitcam.jsp"%>
</body>

</html>

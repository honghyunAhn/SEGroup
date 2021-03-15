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
    <script src="/resources/lms/js/swiper.js"></script>
    <script src="/resources/lms/js/renewal_script.js"></script>
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
		<div class="subPage_content margin-left20" id="main">
			<div class="sp_header">
                <div class="header_textWrap">
                    <h3 class="h3">학습자 PC 환경설정</h3>
                    <p class="fc_999">원활한 학습환경을 위한 학습자 PC 환경설정 방법입니다.</p>
                </div>
            </div>
            <div class="section sub06-01-01"></div>
        </div>
    </div>
    <!-- footer-include -->
     <%@include file="../common_footer_doitcam.jsp"%>
</body>

</html>

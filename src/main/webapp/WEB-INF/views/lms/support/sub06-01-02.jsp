<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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


    <div class="container sub06" id="main">
        <!-- sub06 고객센터-include -->
        <%@include file="../support/menu/leftmenu.jsp"%>

        <div class="sub-content sub06-01">
            <div class="page-locationWrap">
                <ul class="page-location">
                    <!--
                    home 메인 / category menu 대분류 / division menu 중분류 / section menu 소분류
                    -->
                    <li class="img-icon  home"><a href="index.html"></a></li>
                    <li class="img-icon  chevron-right"></li>
                    <li class="category-menu"><a href="sub06-01-01.html">고객센터</a></li>
                    <li class="img-icon  chevron-right"></li>
                    <li class="division-menu"><a href="sub06-01-01.html">1:1상담/원격지원</a></li>
                    <li class="img-icon  chevron-right"></li>
                    <li class="section-menu"><a href="sub06-01-02.html">PC원격지원</a></li>
                </ul>
                <div class="img-icon  chevron-right"></div>
                <!-- <div class="sub-content sub00-01"></div> -->
            </div>
            <div class="header-box sub06-01-02">
                <!-- image로 구성 될 경우에 .header-box에 background 처리하기 -->
                <!-- <div class="box-titleBar"></div>
                <h3 class="h3">PC원격지원</h3>
                <p class="c999">
                    PC 또는 동영상 오류가 발생했을 때 온라인 문의와 전화 상담만으로 해결이 어려운 경우 원격 지원 서비스를 이용하세요.<br>전문 상담원이 회원님의 PC화면 제어를 통해 오류를 확인하고 장애를 즉시 해결해드립니다.
                </p> -->
            </div>
            <div class="section sub06-01-02">
                <button class="button btn-pColor section-out-btn">원격지원서비스 시작</button>
            </div>

        </div>
    </div>
    <!-- footer-include -->
     <%@include file="../common_footer_doitcam.jsp"%>
</body>

</html>

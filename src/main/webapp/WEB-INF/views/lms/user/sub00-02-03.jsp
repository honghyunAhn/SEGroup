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
<link rel="stylesheet" href="/resources/lms/css/reset.css">
<link rel="stylesheet" href="/resources/lms/css/common.css">
<link rel="stylesheet" href="/resources/lms/css/img-icon.css">
<link rel="stylesheet" href="/resources/lms/css/style.css">
<link rel="stylesheet" href="/resources/lms/css/style_responsive.css">
<link rel="stylesheet" href="/resources/lms/css/renewal_style.css">
    <script src="<c:url value="/resources/lms/js/jquery-3.3.1.min.js" />"></script>
<%--     <script src="<c:url value="/resources/lms/js/common.js" />"></script> --%>
</head>

<body>
    <div class="skip-navigation">
        <!--웹접근성/content-->
        <p><a class="goToMain" href="#main">콘텐츠 바로가기</a></p>
    </div>

    <!-- header-include -->
   <%@include file="../sub_header.jsp"%>

    <div class="container subPage_container sub00 d-flex" id="main">
        <!-- sub00로그인/회원가입-include -->
        <%@include file="../user/menu/leftmenu00.jsp"%>
        <div class="subPage_content sub-content sub00-02 margin-left20">
            <!-- 현재 페이지 위치 표시 -->
            <!-- <div class="page-locationWrap">
                <ul class="page-location">
                home 메인 / category menu 대분류 / division menu 중분류 / section menu 소분류
                    <li class="img-icon home"><a href="index.html"></a></li>
                    <li class="img-icon chevron-right"></li>
                    <li class="category-menu"><a href="/lms/user/sub00-01">로그인/회원가입</a></li>
                    <li class="img-icon chevron-right"></li>
                    <li class="division-menu"><a href="/lms/user/sub00-02">회원가입</a></li>
                    <li class="img-icon chevron-right"></li>
                    <li class="section-menu"><a href="#">로그인</a></li>
                </ul>
                <div class="img-icon chevron-right"></div>
            </div>-->
			<!-- <div class="sub-content sub00-01"></div> -->
            <!-- <div class="header">
                <div class="titleBar h3">회원가입</div>
                <h3 class="h3"></h3>
            </div> -->
            <!-- processWrap : 다음단계로 넘어갈 때 .addClass('.active')됩니다. -->
            <ul class="processWrap d-flex">
                <li class="process"><span class="margin-right10 h5 fc_orD">01</span>약관확인</li>
                <li class="process"><span class="margin-right10 h5 fc_orD">02</span>정보입력</li>
                <li class="process active"><span class="margin-right10 h5 fc_orD">03</span>가입완료</li>
            </ul>
            <div class="section userInfo sub00-02-03">

                <div class="header">
                    <strong class="h4">두잇캠퍼스 가입을 환영합니다.</strong>
                    <h5 class="fz14">
                        	회원에게 주어지는 각종 서비스 혜택을 받으실 수 있습니다.
                        <br>두잇캠퍼스만의 프리미엄 교육 서비스 특권을 누려보세요.
                    </h5>
                </div>
                <!-- 버튼 클릭 시 로그인 된 상태로 전환, 메인으로 이동됩니다. -->
                <button class="btn_normal btn_orangeD btn_xlarge" type="button" onclick="location.href='/lms/main'">
                    메인으로
                </button>
            </div>
        </div>

    </div>

    <!-- footer-include -->
    <%@include file="../common_footer_doitcam.jsp"%>
</body>

</html>

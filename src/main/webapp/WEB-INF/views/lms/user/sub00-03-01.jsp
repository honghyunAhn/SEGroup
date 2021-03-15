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
	<%-- <script src="<c:url value="/resources/lms/js/common.js" />"></script> --%>
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
        
        <div class="subPage_content sub-content margin-left20 sub00-03-01">
            <!-- 현재 페이지 위치 표시 -->
            <!-- <div class="page-locationWrap">
                <ul class="page-location">
                    
                home 메인 / category menu 대분류 / division menu 중분류 / section menu 소분류
               
                    <li class="img-icon home"><a href="index.html"></a></li>
                    <li class="img-icon chevron-right"></li>
                    <li class="category-menu"><a href="/lms/user/sub00-01">로그인/회원가입</a></li>
                    <li class="img-icon chevron-right"></li>
                    <li class="division-menu"><a href="/lms/user/sub00-03">아이디찾기</a></li>
                    <li class="img-icon chevron-right"></li>
                    <li class="section-menu"><a href="#">로그인</a></li>
                </ul>
                <div class="img-icon chevron-right"></div>
                <div class="sub-content sub00-01"></div>
            </div> -->

			<!-- <div class="header">
                <div class="titleBar h3">아이디찾기</div>
                <h3 class="h3"></h3>
                <p class="c999"></p>
            </div> -->
            <div class="section userInfo sub00-03 sub00-03-01">
                        	<div class="header">
                    <strong class="h4">아이디 조회 결과</strong>
                    <h5 class="fz14 c999">입력하신 정보와 일치하는 아이디는 아래와 같습니다.</h5>
                </div>

                <div class="sub-segment">
                    <table border="1" class="table">
                        <tbody>
                            <tr>
                                <th class="th">아이디</th>
                                <td>${user_id}</td>
                                <!-- 아이디 전체공개할지? 일부공개할지? -->
                            </tr>
                            <tr>
                                <th class="th">이름</th>
                                <td>${user_nm }</td>
                            </tr>
                        </tbody>
                    </table>
                </div>

                <!-- 버튼 클릭 시 로그인 된 상태로 전환, 메인으로 이동됩니다. -->
                <div class="button-wrap d-flex margin-top40">
                    <button class="btn-normal btn_medium btn_default" type="button" onclick="location.href='/lms/user/sub00-04'">
                       	 비밀번호 찾기
                    </button>
                    <button class="btn-normal btn_medium btn_orangeD margin-right40" type="button" onclick="location.href='/lms/user/sub00-01'">
                       	 로그인
                    </button>
                </div>
            </div>
        </div>

    </div>

    <!-- footer-include -->
    <%@include file="../common_footer_doitcam.jsp"%>
</body>

</html>

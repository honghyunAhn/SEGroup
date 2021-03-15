<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="format-detection" content="telephone=no">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <meta name="description" content="다양한 전공과 ICT·AI를 융합하여 K-Digital 인재로 컬러링 해드립니다.">
    <meta name="keywords" content="해외취업, Soft Engineer Society, SES, 소프트엔지니어소사이어티, SCIT, SWDO, E러닝, e-learning">
    <title>Rainbow 레인보우</title>
    <link rel="stylesheet" href="/resources/segroup/society/smtp/css/reset.css">
    <link rel="stylesheet" href="/resources/segroup/society/smtp/css/common.css">
    <link rel="stylesheet" href="/resources/segroup/society/smtp/css/img-icon.css">
    <link rel="stylesheet" href="/resources/segroup/society/smtp/css/swiper.min.css">
    <link rel="stylesheet" href="/resources/segroup/society/smtp/css/rainbow_style.css">
    <link rel="stylesheet" href="/resources/segroup/society/smtp/css/rainbow_style_responsive.css">
    <script src="/resources/segroup/society/smtp/js/jquery-3.3.1.min.js"></script>
    <script src="/resources/segroup/society/smtp/js/swiper.js"></script>
    <script src="/resources/segroup/society/smtp/js/rainbow_script.js"></script>
    <script src="/resources/segroup/society/smtp/js/rainbow_script_responsive.js"></script>
</head>

<body>
    <div class="container_rainbow">
        <!-- Header-include -->
        <%@include file="../include/rainbow_header_basic.jsp"%>
        <div class="content sub-content sub01_content" id="main">
            <div class="section_header">
                <strong class="h4">아이디 조회 결과</strong>
                <h5 class="fz14 c999">
                    입력하신 정보와 일치하는 아이디는 아래와 같습니다.
                </h5>
            </div>
            <div class="loginWrap enterWrap">
                <form class="formStyle">
                 <ul class="class-list-title">
                 	<li><div>${user_id}</div></li>
                 </ul>
                 <div class="d-flex justify_center margin-top10">
                	<input type="button" class="btn_normal btn_large btn_pp btn-agree btn-wh" value="비밀번호 찾기" onclick="location.href='/smtp/user/sub01-04'">
                	<input type="button" class="margin-left10 btn_normal btn_large btn_pp_bg btn-cancel" value="로그인" onclick="location.href='/smtp/user/sub01-01'">
                </div>
                </form>
            </div>
        </div>
		<!-- footer-include -->
	    <%@include file="../include/common_footer_rainbow.jsp"%>
    </div>
</body>

</html>

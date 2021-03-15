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
    <script type="text/javascript">
    	$(document).ready(function(){
    		$('#mainBtn').on('click', function(){
    			location.href='/rainbow';
    		});
    	});
    </script>
</head>

<body>
    <div class="container_rainbow">
        <!-- Header-include -->
        <%@include file="../include/rainbow_header_basic.jsp"%>

        <div class="content sub-content sub01_content" id="main">
            <!-- 회원가입단계 표기 -->
            <ul class="processWrap d-flex">
                <li class="process"><span class="margin-right10">01</span>약관확인</li>
                <li class="process"><span class="margin-right10">02</span>정보입력</li>
                <li class="process active"><span class="margin-right10">03</span>가입완료</li>
            </ul>
            <div class="section section_sub01-02-02">
                <div class="section_header">
                    <strong class="h4">레인보우 가입을 환영합니다.</strong>
                    <h5 class="fz14">
                        회원에게 주어지는 각종 서비스 혜택을 받으실 수 있습니다.
                        <br>레인보우만의 프리미엄 교육 서비스 특권을 누려보세요.
                    </h5>
                </div>
                <input type="button" class="btn_normal btn_large btn_pp_bg" value="메인으로" id="mainBtn">
            </div>

        </div>

        <!-- footer-include -->
        <%@include file="../include/common_footer_rainbow.jsp"%>
    </div>
</body>

</html>

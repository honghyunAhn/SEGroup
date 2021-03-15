<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
    
    <link rel="stylesheet" href="/resources/lms/css/style.css">
    
    <script charset="UTF-8" class="daum_roughmap_loader_script" src="https://ssl.daumcdn.net/dmaps/map_js_init/roughmapLoader.js"></script>
</head>

<body>
    <div class="container_rainbow">
        <!-- Header-include -->
        <%@include file="../include/rainbow_header_basic.jsp" %>

        <div class="content sub-content sub04_content" id="main">
            <div class="header_textWrap">
                <h3 class="h3">오시는길</h3>
                <p class="fc_999">서울센터: 06164 서울특별시 강남구 영동대로 513(삼성동, 코엑스)4층 ICT센터</p>
                <p class="fc_999">광주센터: 62364 광주 광산구 무진대로 282 광주 무역회관</p>
            </div>
	        <div class="section section_sub04-01-01 d-flex">
	        	<div class="header_textWrap">
                	<h3 class="h3">서울센터</h3>
                </div>
	        	<div class="mapSeoul">
                    <!-- 카카오맵 자체 기능 id 사용 중이니 주의할 것 -->
                    <div id="daumRoughmapContainer1572313765901" class="root_daum_roughmap root_daum_roughmap_landing" style="width:100%"></div>
                </div>
                <div class="map-wayWrap">
                	<div class="map-way">
                        <div class="d-flex map-way-hdr">
                            <div class="img-icon bus"></div>
                            <strong class="cMain">버스 이용고객</strong>
                            <strong>코엑스 동문 앞(2398 정류장)</strong>
                        </div>
                        <ul class="way">
                            <li class="">간선버스<span class="c-blue">146, 301, 401, 342, 362, N61(심야)</span></li>
                            <li class="">간선버스<span class="c-dred">9407, 9414, 9607, 500-2</span></li>
                            <li>지선버스<span class="c-dgreen">2415, 3217, 3411, 3412, 3414, 4318</span></li>
                            <li>공항리무진<span class="c-orange">6006</span></li>
                            <li>마을버스<span class="c-green">강남08</span></li>
                        </ul>
                    </div>
                    <div class="map-way">
                        <div class="d-flex map-way-hdr">
                            <div class="img-icon subway"></div>
                            <strong class="cMain">지하철 이용고객</strong>
                        </div>
                        <ul class="way">
                            <li>지하철<span class="c-line2">2호선 삼성역 </span>EXIT 6</li>
                            <li>지하철<span class="c-line9">9호선 봉은사역 </span>EXIT 7</li>
                        </ul>
                    </div>
                    <div class="map-way">
                        <div class="d-flex map-way-hdr">
                            <div class="img-icon car"></div>
                            <strong class="cMain">자가용 이용고객</strong>
                        </div>
                        <ul class="way">
                            <li>코엑스 옥상 주차장 - 코엑스 서문(EAST GATE)</li>
                            <li>E20 엘리베이터 탑승 - 4F으로 이동</li>
                        </ul>
                    </div>
                </div>
	        </div>
	        <div class="section section_sub04-01-02 d-flex">
	        	<div class="header_textWrap">
                	<h3 class="h3">광주센터</h3>
                </div>
	        	<div class="mapGwangju">
                	<div id="daumRoughmapContainer1612240971805" class="root_daum_roughmap root_daum_roughmap_landing" style="width:100%"></div>
                </div>
                <div class="map-wayWrap">
                	<div class="map-way">
                        <div class="d-flex map-way-hdr">
                            <div class="img-icon bus"></div>
                            <strong class="cMain">버스 이용고객</strong>
                        </div>
                        <ul class="way">
                            <li class="">간선버스<span class="c-blue">문흥18, 첨단20, 송정29, 봉선37, 첨단40</span></li>
                            <li>지선버스<span class="c-dgreen">송정98</span></li>
                            <li>마을버스<span class="c-green">700, 720, 750</span></li>
                        </ul>
                    </div>
                    <div class="map-way">
                        <div class="d-flex map-way-hdr">
                            <div class="img-icon subway"></div>
                            <strong class="cMain">지하철 이용고객</strong>
                        </div>
                        <ul class="way">
                            <li>지하철<span class="c-line2">1호선 공항역 </span>EXIT 6</li>
                        </ul>
                    </div>
                    <div class="map-way">
                        <div class="d-flex map-way-hdr">
                            <div class="img-icon car"></div>
                            <strong class="cMain">자가용 이용고객</strong>
                        </div>
                        <ul class="way">
                            <li>터미널 방향 - 광주여대방향 80m 도로 끝 유턴 후 직진</li>
                            <li>광산 IC에서 흑석사거리 방향 직진 후,</li>
                            <li>지하도 진입하지말고 유턴 후 직진</li>
                        </ul>
                    </div>
                </div>
	        </div>
    	</div>

	    <!-- footer-include -->
	    <%@include file="../include/common_footer_rainbow.jsp" %>
    </div>
    <!-- 카카오맵 - 실행 스크립트 -->
    <script charset="UTF-8">
        new daum.roughmap.Lander({
            "timestamp": "1572313765901",
            "key": "vmfe",
            "mapWidth": "640",
            "mapHeight": "360"
        }).render();
        
       	new daum.roughmap.Lander({
       		"timestamp" : "1612240971805",
       		"key" : "248ja",
       		"mapWidth" : "640",
       		"mapHeight" : "360"
       	}).render();
    </script>
</body>

</html>

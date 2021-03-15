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
   
    <script src="<c:url value="/resources/lms/js/jquery-3.3.1.min.js" />"></script>
	<script src="<c:url value="/resources/lms/js/common.js" />"></script>
    <script charset="UTF-8" class="daum_roughmap_loader_script" src="https://ssl.daumcdn.net/dmaps/map_js_init/roughmapLoader.js"></script>
    <!-- 지도 script -->
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

        <div class="subPage_content margin-left20 sub-content sub06-04" id="main">
           <!--  <div class="page-locationWrap">
                <ul class="page-location">
                    
                home 메인 / category menu 대분류 / division menu 중분류 / section menu 소분류
               
                    <li class="img-icon home"><a href="index.html"></a></li>
                    <li class="img-icon chevron-right"></li>
                    <li class="category-menu"><a href="sub06-01-01.html">고객센터</a></li>
                    <li class="img-icon chevron-right"></li>
                    <li class="division-menu"><a href="sub06-04.html">오시는길</a></li>
                    <li class="img-icon chevron-right"></li>
                    <li class="section-menu"><a href="sub06-05-01.html">대중교통</a></li>
                </ul>
                <div class="img-icon chevron-right"></div>
                <div class="sub-content sub00-01"></div>
            </div>

            <div class="header-box">
                image로 구성 될 경우에 .header-box에 background 처리하기
                <div class="box-titleBar"></div>
                <h3 class="h3">오시는길</h3>
                <p class="c333">
                    <strong class="c999">주소</strong> 06164 서울특별시 강남구 영동대로513 (삼성동, 코엑스 4층)
                    <strong class="c999">연락처</strong> 02-6000-6251/5387
                </p>
            </div> -->
            <div class="sp_header">
                <div class="header_textWrap">
                    <h3 class="h3">오시는 길</h3>
                    <p class="fc_999">06164 서울특별시 강남구 영동대로 513(삼성동, 코엑스)4층 ICT센터</p>
                </div>
            </div>
            <div class="section sub06-04 d-flex">
                <div class="map">
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
                            <li>지하철<span class="c-line2">2호선 삼성역</span>EXIT 6</li>
                            <li>지하철<span class="c-line9">9호선 봉은사역</span>EXIT 7</li>
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
        </div>
    </div>

    <!-- footer-include -->
     <%@include file="../common_footer_doitcam.jsp"%>

    <!-- 카카오맵 - 실행 스크립트 -->
    <script charset="UTF-8">
        new daum.roughmap.Lander({
            "timestamp": "1572313765901",
            "key": "vmfe",
            "mapWidth": "100%",
            "mapHeight": "auto"
        }).render();
    </script>
</body>

</html>

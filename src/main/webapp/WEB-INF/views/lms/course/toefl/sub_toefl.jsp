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
    <meta name="description" content="디지털·AI, 외국어, 직무, 자격증까지! Let's Do it! Do it campus!">
    <!-- 홈페이지 키워드 >> 키워드 검색했을 때 검색결과로 노출 -->
    <meta name="keywords" content="디지털, AI, 빅데이터, 프로그래밍, 정보처리, 데이터베이스, 클라우드, 외국어, 영어, 일본어, 중국어, 직무, 경영, 사업전략, 리더십, 코칭, 마케팅, CS, 자기관리, 커뮤니케이션, 법정의무, 취업, 해외취업, Soft Engineer Society, SES, 소프트엔지니어소사이어티, SCIT, SWDO, E러닝, e-learning">
    <title>Let's Do it 두잇캠퍼스</title>
    <link rel="stylesheet" href="/resources/lms/css/swiper.min.css">
    <link rel="stylesheet" href="/resources/lms/css/reset.css">
    <link rel="stylesheet" href="/resources/lms/css/common.css">
    <link rel="stylesheet" href="/resources/lms/css/img-icon.css">
    <link rel="stylesheet" href="/resources/lms/css/style.css">
    <link rel="stylesheet" href="/resources/lms/css/renewal_style.css">
    <!-- <link rel="stylesheet" href="css/renewal_responsive.css"> -->
    <script src="/resources/lms/js/jquery-3.3.1.min.js"></script>
    <script src="/resources/lms/js/swiper.js"></script>
    <script src="/resources/lms/js/renewal_script.js"></script>
<script>
$(function(){
	$('.home').on('click', function(){
		document.location.href = '/lms/main';
	});
	
	$('#division_menu').on('click', function(){
		var menu_name = $(this).html();
		if(menu_name!='전체과정'){
			$('[data-value="' + menu_name + '"]').trigger('click');					
		}
	});
	
});
</script>
</head>
<body>
    <div class="skip-navigation">
        <!--웹접근성/content-->
        <p><a class="goToMain" href="#main">콘텐츠 바로가기</a></p>
    </div>

    <!-- header-include -->
   <%@include file="../../sub_header.jsp"%>


    <div class="container subPage_container sub04 d-flex">
        <!-- sub01it-include -->
        <%@include file="../../course/toefl/menu/leftmenu.jsp"%>

        <div class="subPage_content margin-left20" id="main">
            <div class="sp_header">
                <div class="header_textWrap">
                    <h3 class="h3">모의토플</h3>
                    <p class="fc_999">모의토플도 두잇캠퍼스와 함께!</p>
                </div>
            </div>

			<!-- 과정목록 -->
            <div class="section">  <!-- sub01-01클래스에 이미지 파일 설정되어 있으므로 클래스명 제외 -->
                <!-- section-sub01-01-include -->
				<%@include file="include/section-sub-toefl.jsp"%>                
            </div>
            
            <!-- pagenation  -->
            <div class="page">
                <ul class="pagination d-flex" id="pagination"></ul>
            </div>
        </div>
    </div>
    <!-- footer-include -->
     <%@include file="../../common_footer_doitcam.jsp"%>
</body>

</html>

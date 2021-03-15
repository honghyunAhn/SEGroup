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
    <script src="<c:url value="/resources/lms/js/jquery3.4.1.js" />"></script>
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
   <%@include file="../../header.jsp"%>


    <div class="container eLearning sub04" id="main">
        <!-- sub04t-include -->
        <%@include file="../../course/jobtraining/menu/leftmenu.jsp"%>

        <div class="sub-content sub04">
            <!-- 현재 페이지 위치 표시 -->
            <div class="page-locationWrap">
                <ul class="page-location">
                    <!--
                home 메인 / category menu 대분류 / division menu 중분류 / section menu 소분류
                -->
                    <li class="img-icon home"><a href="/lms/main"></a></li>
                    <li class="img-icon chevron-right"></li>
                    <li class="category-menu"><a href="/lms/course/jobtraining/sub04-01">취업연계</a></li>
                    <li class="img-icon chevron-right"></li>
                    <li class="division-menu"><a id="division_menu">전체과정</a></li>
                    <!-- <li class="img-icon chevron-right"></li>
                    <li class="section-menu"><a href="#">로그인</a></li> -->
                </ul>
                <div class="img-icon chevron-right"></div>
                <!-- <div class="sub-content sub00-01"></div> -->
            </div>

            <div class="header-box">
                <!-- image로 구성 될 경우에 .header-box에 background 처리하기 -->
                <!-- <div class="box-titleBar"></div>
                <h3 class="h3">외국어</h3>
                <p class="c999">
                    일본어, 영어, 중국어, 그리고 비즈니스 회화까지! 레인보우에서 모든 것을 배워보세요!
                    <br>완전 초보도 쉽고 빠르게 학습할 수 있도록 구성하였습니다.
                </p> -->
            </div>
            <div class="section">  <!-- sub04-01클래스에 이미지 파일 설정되어 있으므로 클래스명 제외 -->
                <!-- section-sub04-01-include -->
               <%@include file="include/section-sub04-01.jsp"%>                
            </div>
            <!-- pagenation  -->
            <div class="page">
                <ul class="pagination d-flex" id="pagination">
                    <!-- <li><a href="#" class="prev-pageWrap">&lt;&lt;</a></li> -->
                    <!-- <li><a href="#" class="prev"><div class="img-icon angle-left floatL"></div>PREV</a></li>
                    <li><a href="#" class="active num">1</a></li>
                    <li><a href="#" class="num">2</a></li>
                    <li><a href="#" class="num">3</a></li>
                    <li><a href="#" class="num">4</a></li>
                    <li><a href="#" class="num">5</a></li>
                    <li><a href="#" class="next"><div class="img-icon angle-right floatR"></div>NEXT</a></li> -->
                    <!-- <li><a href="#" class="next-pageWrap">&gt;&gt;</a></li> -->
                </ul>
            </div>
        </div>
    </div>
    <!-- footer-include -->
     <%@include file="../../common_footer_doitcam.jsp"%>
</body>

</html>

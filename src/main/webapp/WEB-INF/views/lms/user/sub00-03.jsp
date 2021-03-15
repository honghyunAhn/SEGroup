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
	<!-- 홈페이지의 대략적인 설명 >> 검색 결과 제목 하단에 설명으로 노출 -->
	<meta name="description" content=디지털·AI, 외국어, 직무, 자격증까지! Let's Do it! Doitcampus!">
	<!-- 홈페이지 키워드 >> 키워드 검색했을 때 검색결과로 노출 -->
	<meta name="keywords"
		content="디지털, AI, 빅데이터, 프로그래밍, 정보처리, 데이터베이스, 클라우드, 외국어, 영어, 일본어, 중국어, 직무, 경영, 사업전략, 리더십, 코칭, 마케팅, CS, 자기관리, 커뮤니케이션, 법정의무, 취업, 해외취업, Soft Engineer Society, SES, 소프트엔지니어소사이어티, SCIT, SWDO, E러닝, e-learning">
	<title>Let's Do it 두잇캠퍼스</title>
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
    <script type="text/javascript">

    	function formCheck() {
    		var email = $('#email').val();
    		var name = $('#name').val();
     		
    		if(name == "") {
    			alert("이름을 입력해주세요.");
    			return false;
    		} else if (email == "") {
    			alert("가입하신 이메일을 입력해주세요.");
    			return false;
    		} 
    		if (isPhoneNumCorrect() == false) { return false; }
    		return true;
    	}
    	
    	function isPhoneNumCorrect() {
    		var phone_num = $('#phone').val();
    		if(phone_num == "") {
    			alert("휴대폰 번호를 입력해주세요.");
    			return false;
    		}   		
     	    $("#phone").val(phone_num);
     	    return true;
    	}
    	
    	$(function() {
    	   	 var message = '${msg}';
    	   	    if(message != "") {
    	   	    	alert(message);
    	   	 	}
    	   	    
    	   	     $("input:text[numberOnly]").on("keyup", function() {
    	   	        $(this).val($(this).val().replace(/[^0-9]/g,""));
    	   	    }); 
    	   	});
    </script>
<!--     <style type="text/css">
	
	input {
	    margin-top: 10px;
	    margin-bottom: 10px;
	    padding-top: 10px;
	    padding-bottom:10px;
	    text-align : center;
	    width: 250px;
	}

    </style> -->
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

        <div class="subPage_content sub-content sub00-03 margin-left20">
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
            </div> -->
             <!-- <div class="sub-content sub00-01"></div> -->
<!--             <div class="header">
                <div class="titleBar h3">아이디 찾기</div>
                <h3 class="h3"></h3>
            </div> -->
            <div class="section userInfo sub00-03">
            	<div class="header">
                    <strong class="h4">아이디찾기</strong>
                    <h5 class="fz14 c999">회원정보를 입력해주세요.</h5>
                </div>
                
                <!-- <acrticle class="certification"> -->
                    <!-- <header class="article-title"></header> -->
                    <div class="loginWrap enterWrap">
                        <!-- <div class="certif-boxWrap d-flex"> -->
                            <!-- <div class="certif certif01">
                                <h3 class="h3">아이핀인증</h3>
                                <p class="c666">아이핀으로 본인확인을 합니다.<br>&nbsp;</p>
                                <button class="button enter-btn btn-bk" type="button" onclick="location.href='/lms/user/sub00-03-01'">인증하기</button>
                             </div> -->
                             <!-- <div class="certif certif02"> -->
                                 <!--<h3 class="h3">휴대폰인증</h3>
                                <p class="c666">본인 명의의 휴대폰 번호로 인증합니다. 타인 명의의 휴대폰은 인증이 불가합니다.</p>
                                <button class="button enter-btn btn-bk" type="button" onclick="location.href='/lms/user/sub00-03-01'">인증하기</button>-->
                        	<!-- <p class="c666">회원정보를 입력해주세요.</p><br> -->
	                        <form class="form formStyle" action="/lms/user/lostId" method="post" onsubmit="return formCheck();">
		                        <input class="input" id="name" name="name" type="text" placeholder="이름입력">
		                        <input class="input" id="email" name="email" type="text" placeholder="이메일입력">
		                        <input class="input" id="phone" name="phone" type="text" placeholder="핸드폰번호입력(숫자만)" numberOnly>
		                        <input type="submit" class="btn_normal btn_xlarge btn_orangeD" value="아이디찾기"/>
	                        </form>
                            <!-- </div> -->
                        <!-- </div> -->
                    </div>
                <!-- </acrticle> -->
            </div>
        </div>
    </div>

    <!-- footer-include -->
    <%@include file="../common_footer_doitcam.jsp"%>
</body>

</html>

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
    <script type="text/javascript">
    //정규표현식
    var passwdCheck = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?&])[A-Za-z\d$@$!%*#?&]{8,}$/;
    
    function formCheck() {
		if (isPasswordCorrect() == false) { return false; }
		return true;
	}
    
    function isPasswordCorrect() {
		var pw = $('#pw').val();
		var pw_confirm = $('#pw_confirm').val();
		if(pw=="") {
			alert("비밀번호를 입력해 주시기 바랍니다.");
			return false;
		} else if(pw.length<8) {
			alert("비밀번호는 최소 8자 이상입니다.");
			return false;
		} else if(pw_confirm=="") {
			alert("비밀번호 확인란에 입력해 주시기 바랍니다.");
			return false;
		} else if(pw!=pw_confirm) {
			alert("비밀번호가 일치하지 않습니다.");
			return false;
		} else if (passwdCheck.test(pw_confirm) == false) {
			alert("비밀번호의 형식이 잘못되었습니다.");
			return false;
		}
		return true;
    }
    </script>
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
        <div class="subPage_content sub-content sub00-04 sub00-04-01 margin-left20">
            <!-- 현재 페이지 위치 표시 -->
            <!-- <div class="page-locationWrap">
                <ul class="page-location">
                    
                home 메인 / category menu 대분류 / division menu 중분류 / section menu 소분류
               
                    <li class="img-icon home"><a href="index.html"></a></li>
                    <li class="img-icon chevron-right"></li>
                    <li class="category-menu"><a href="/lms/user/sub00-01">로그인/회원가입</a></li>
                    <li class="img-icon chevron-right"></li>
                    <li class="division-menu"><a href="/lms/user/sub00-04">비밀번호찾기</a></li>
                    <li class="img-icon chevron-right"></li>
                    <li class="section-menu"><a href="#">로그인</a></li>
                </ul>
                <div class="img-icon chevron-right"></div>
                <div class="sub-content sub00-01"></div>
            </div> -->

            <!-- <div class="header">
                <div class="titleBar h3">비밀번호찾기</div>
                <h3 class="h3"></h3>
                <p class="c999"></p>
            </div> -->
            <div class="section sub00-04 sub00-04-01 userInfo">
             
            	<div class="header">
                    <strong class="h4">비밀번호 재설정</strong>
                    <h5 class="fz14 c999">영문, 숫자, 특수문자를 모두 사용하여 최소 8자이상의 안전한 비밀번호로 변경해주세요.</h5>
                </div>
                
                <div class="loginWrap enterWrap">
                    <form class="form formStyle" action="/lms/user/resetPw" onsubmit="return formCheck();" method="post">
                        <div class="passwordWrap">
                        	<input type="hidden" name="user_id" value="${user_id }">
                            <input class="input" type="password" id="pw" placeholder="새 비밀번호" name="pw" maxlength="20" autocomplete="off">
                            <div class="userPwCheck">
                                <input class="input" type="password" id="pw_confirm" placeholder="새 비밀번호 확인"maxlength="20" autocomplete="off">
                            </div>
                        </div>

                        <input class="btn_normal btn_xlarge btn_orangeD" type="submit" value="확인">       
                        <!-- alert("비밀번호 변경이 완료되었습니다. 로그인창으로 이동합니다."); -->
                    </form>
                </div>

            </div>
        </div>

    </div>

    <!-- footer-include -->
    <%@include file="../common_footer_doitcam.jsp"%>
</body>

</html>

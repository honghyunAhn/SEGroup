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
	<div class="container_rainbow">
        <!-- Header-include -->
        <%@include file="../include/rainbow_header_basic.jsp"%>
        
        <div class="content sub-content sub01_content" id="main">
            <div class="section_header">
                <strong class="h4">비밀번호 재설정</strong>
                <h5 class="fz14 c999">
                	영문, 숫자, 특수문자를 모두 사용하여 최소 8자이상의 안전한 비밀번호로 변경해주세요.
                </h5>
            </div>
            <div class="loginWrap enterWrap">
                <form class="formStyle" action="/smtp/user/resetPw" onsubmit="return formCheck();" method="post">
					<input type="hidden" class="input" name="user_id" value="${user_id }">
                    <input class="input" type="password" id="pw" placeholder="새 비밀번호" name="pw" maxlength="20" autocomplete="off">
                    <div class="userPwCheck">
                        <input class="input" type="password" id="pw_confirm" placeholder="새 비밀번호 확인"maxlength="20" autocomplete="off">
                    </div>
					<input id="certi_btn" class="btn_normal btn_xlarge btn_pp_bg" type="submit" value="확인">
                </form>
			</div>
        </div>
        <!-- footer-include -->
        <%@include file="../include/common_footer_rainbow.jsp"%>
    </div>
</body>
</html>
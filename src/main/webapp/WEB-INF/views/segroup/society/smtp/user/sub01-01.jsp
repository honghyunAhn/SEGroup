<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
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
    
    	//securityMessage랑 따로 처리함
    	$(function() {
	   		var message = '${msg}';
	   	    if(message != "") {
	   	    	alert(message);
	   	 	}
	   	});
    	
	    $(document).ready(function(){
	    	var message = $("#message").val();
			if (message !== undefined  && message != "" && message.length != 0) {
				alert(message);
			}
	    	
	        // 저장된 쿠키값을 가져와서 ID 칸에 넣어준다. 없으면 공백으로 들어감.
	        var userInputId = getCookie("userInputId");
	        $("input[name='user_id']").val(userInputId); 
	         
	        if($("input[name='user_id']").val() != ""){ // 그 전에 ID를 저장해서 처음 페이지 로딩 시, 입력 칸에 저장된 ID가 표시된 상태라면,
	            $("#saveID").attr("checked", true); // ID 저장하기를 체크 상태로 두기.
	        }
	         
	        $("#saveID").change(function(){ // 체크박스에 변화가 있다면,
	            if($("#saveID").is(":checked")){ // ID 저장하기 체크했을 때,
	                var userInputId = $("input[name='user_id']").val();
	                setCookie("userInputId", userInputId, 7); // 7일 동안 쿠키 보관
	            }else { // ID 저장하기 체크 해제 시,
	                deleteCookie("userInputId");
	            }
	        });
	         
	        // ID 저장하기를 체크한 상태에서 ID를 입력하는 경우, 이럴 때도 쿠키 저장.
	        $("input[name='user_id']").keyup(function(){ // ID 입력 칸에 ID를 입력할 때,
	            if($("#saveID").is(":checked")){ // ID 저장하기를 체크한 상태라면,
	                var userInputId = $("input[name='user_id']").val();
	                setCookie("userInputId", userInputId, 7); // 7일 동안 쿠키 보관
	            }
	        });
	    });
    function setCookie(cookieName, value, exdays){
        var exdate = new Date();
        exdate.setDate(exdate.getDate() + exdays);
        var cookieValue = escape(value) + ((exdays==null) ? "" : "; expires=" + exdate.toGMTString());
        document.cookie = cookieName + "=" + cookieValue;
    }
     
    function deleteCookie(cookieName){
        var expireDate = new Date();
        expireDate.setDate(expireDate.getDate() - 1);
        document.cookie = cookieName + "= " + "; expires=" + expireDate.toGMTString();
    }
    
    function getCookie(cookieName) {
        cookieName = cookieName + '=';
        var cookieData = document.cookie;
        var start = cookieData.indexOf(cookieName);
        var cookieValue = '';
        if(start != -1){
            start += cookieName.length;
            var end = cookieData.indexOf(';', start);
            if(end == -1)end = cookieData.length;
            cookieValue = cookieData.substring(start, end);
        }
        return unescape(cookieValue);
    }
    </script>
</head>

<body>
    <div class="container_rainbow">
        <!-- Header-include -->
        <%@include file="../include/rainbow_header_basic.jsp"%>

        <div class="content sub-content sub01_content" id="main">
            <div class="section_header">
                <strong class="h4">레인보우에 오신 것을 환영합니다.</strong>
                <h5 class="fz14 c999">로그인을 위하여 아래 아이디와 비밀번호를 입력하여 주십시오.</h5>
            </div>
            <div class="loginWrap enterWrap">
                <form class="formStyle" action="/smtp/user/login" method="post" id="loginForm">
                	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                	<c:if test="${not empty SPRING_SECURITY_LAST_EXCEPTION }">
						<spring:message var="securityMessage" code="${SPRING_SECURITY_LAST_EXCEPTION.message}" />
						<input type="hidden" id="message" value="${securityMessage}" />
						<br>
						<c:remove scope="session" var="SPRING_SECURITY_LAST_EXCEPTION" />
					</c:if>
                    <input class="input" name="user_id" type="text" placeholder="아이디" maxlength="24">
                    <input class="input" name="user_pw" type="password" placeholder="비밀번호">
                    <div class="checkWrap d-flex justify_center">
                        <input class="input check" type="checkbox" name="saveID" id="saveID">
                        <label class="label" for="saveID">아이디 저장</label>
                        <input class="input check" type="checkbox" name="autoLogin" id="autoLogin">
                        <label class="label" for="autoLogin">자동로그인</label>
                    </div>
                    <input type="submit" class="btn_normal btn_xlarge btn_pp_bg" value="로그인">
                </form>
                <ul class="division-menuWrap d-flex justify_center">
                    <li><a href="/smtp/user/sub01-02">회원가입</a></li>
                    <li class="divBar">&nbsp;|&nbsp;</li>
                    <li><a href="/smtp/user/sub01-03">아이디 찾기</a></li>
                    <li class="divBar">&nbsp;|&nbsp;</li>
                    <li><a href="/smtp/user/sub01-04">비밀번호 찾기</a></li>
                </ul>
            </div>
        </div>

        <!-- footer-include -->
        <%@include file="../include/common_footer_rainbow.jsp"%>
    </div>
</body>

</html>

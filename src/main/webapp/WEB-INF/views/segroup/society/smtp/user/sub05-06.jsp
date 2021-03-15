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
	    function pwCheck() {
	    	if($('#userPw').val()=='') {
				alert('비밀번호를 입력해주세요.');
				return false;
			}
	    	return true;
	    	
	    }
	    
	    $(function() {
	   	 var message = '${msg}';
	   	    if(message != "") {
	   	    	alert(message);
	   	 	}
	   	});
    </script>
</head>
<body>
	<div class="container_rainbow">
		<!-- Header-include -->
        <%@include file="../include/rainbow_header_basic.jsp"%>
        <div class="content sub-content sub01_content" id="main">
        	<div class="section_header">
                <strong class="h4">개인정보 수정</strong>
                <h5 class="fz14 c999">
                    비밀번호 재확인이 필요합니다.
                </h5>
            </div>
            <div class="loginWrap enterWrap">
                <form class="form formStyle" id="" action="/smtp/user/checkPw" method="post" onsubmit="return pwCheck();">
                    <input class="input" name="userPw" type="password" id="userPw" placeholder="비밀번호">
                    <input type="submit" class="btn_normal btn_xlarge btn_pp_bg" value="확인">
                </form>
            </div>
        </div>
        <!-- footer-include -->
        <%@include file="../include/common_footer_rainbow.jsp"%>
	</div>
</body>
</html>
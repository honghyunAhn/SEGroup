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
			
			var message = '${msg}';
	   	    if(message != "") {
	   	    	alert(message);
	   	 	}
	   	    
	        $('.btn-delete').on('click', function() {
	        	var id = $('#id').val();
	        	var pw = $('#pw').val();
	        	if(id=="") {
	        		alert("아이디를 입력해주세요.");
	        		return false;
	        	} else if(pw=="") {
	        		alert("비밀번호를 입력해주세요.");
	        		return false;
	        	}
	             if (confirm("탈퇴 후에는 동일한 아이디로 다시 가입할 수 없으며, 아이디와 데이터는 복구할 수 없으니 신중하게 선택해주세요. 정말 탈퇴하시겠습니까?") == true) {
	        	$('#optoutForm').submit();
	            
	        } else {
	            return;
	        } 
	        });
			
		});
    </script>
</head>
<body>
	<div class="container_rainbow">
        <!-- Header-include -->
        <%@include file="../include/rainbow_header_basic.jsp"%>

        <div class="content sub-content sub01_content" id="main">
            <div class="section_header">
                <strong class="h4">안전한 회원 탈퇴를 위해, <br>아이디/비밀번호를 확인해주세요.</strong>
                <h5 class="fz14 c999">
                	비밀번호 확인 후 아이디는 즉시 탈퇴됩니다.
                	<br>
					탈퇴 후에는 동일한 아이디로 다시 가입할 수 없으며,
					<br>
					아이디와 데이터는 복구할 수 없으니 신중하게 선택해주세요.
                </h5>
            </div>
            <div class="loginWrap enterWrap">
                <form class="formStyle form" action="/smtp/user/optout" id="optoutForm" method="POST">
                    <div class="id-passwordWrap">
                        <input class="input" type="text" id="id" placeholder="아이디" name="id" maxlength="20" autocomplete="off">
                        <div class="userPwCheck">
                            <input class="input" type="password" id="pw" placeholder="비밀번호" name="pw" maxlength="20" autocomplete="off">
<!--                             <div class="d-none-msg"> -->
<!--                                 <p class="false-msg cDanger">입력하신 비밀번호가 아이디와 일치하지 않습니다.</p> -->
<!--                             </div> -->
                        </div>
                    </div>

                    <button class="btn_normal btn_xlarge btn_pp_bg btn-delete" type="button">
                        탈퇴하기
                    </button>
                </form>
            </div>
        </div>

        <!-- footer-include -->
        <%@include file="../include/common_footer_rainbow.jsp"%>
    </div>
</body>
</html>
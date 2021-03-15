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
<%--     <script src="<c:url value="/resources/lms/js/common.js" />"></script> --%>
	<script type="text/javascript">

    
   $(function() {
    	$('#certi_code_btn').on('click', request_certification_code);
    	$('#certi_btn').on('click', certification_code);
    	$('#certi_code_section').hide();
    	
    	$("input:text[numberOnly]").on("keyup", function() {
	        $(this).val($(this).val().replace(/[^0-9]/g,""));
	    });
    }); 
    
    //코드를 요청한다.
	function request_certification_code() {
    	
		var user_id = $('input[name=user_id]').val();
		var user_email = $('input[name=user_email]').val();
		var user_nm = $('input[name=user_nm]').val();
		var user_phone = $('input[name=user_phone]').val();
		if(user_id == "" || user_email == "" || user_nm == "" || user_phone == "") {
			alert("빈칸없이 입력해주세요.");
			return false;
		}
		
		var btn = $('#certi_code_btn');
		btn.off('click');
		
		$.ajax({
			url: '<c:url value="/lms/user/user_request_certification_code" />',
			data: {
				"user_id" : user_id,
				"user_nm" : user_nm,
				"user_email" : user_email,
				"user_phone" : user_phone
			},
			success: function(isRequested) {
				if (!isRequested) {
					$('#user_nm').attr('readonly', '');
					$('#user_email').attr('readonly', '');
					$('#user_id').attr('readonly', '');
					$('#user_phone').attr('readonly','');
					
					var element_auth = $('#certi_code_section');
					element_auth.show();
					
					var input_auth = $('#certi_code');
					input_auth.select();
					input_auth.focus();
				} else {
					alert('입력된 내용과 일치하는 정보가 없습니다');
					
					btn.on('click', request_certification_code);
					btn.css('background-color', '#212121');
				}
			},
			error: function(e) {
				alert('에러가 발생했습니다');
				
				btn.on('click', request_certification_code);
				btn.css('background-color', '#212121');
			}
		});
	}
    

	function certification_code() {
		var input_auth = $('#certi_code');
		
		if (input_auth.val().length != 4
				|| new RegExp("[0-9]{4}").test(input_auth.val()) == false) {
			alert('코드가 일치하지 않습니다');
			input_auth.focus();
			input_auth.select();
			return;
		}
		
		var btn = $('#certi_btn');
		btn.off('click');
		btn.css('background-color', 'lightgray');
		
		$.ajax({
			url: '<c:url value="/lms/user/user_check_certification_code" />',
			data: {
				certification_code: input_auth.val(),
			},
			success: function(isRequested) {
				if (isRequested) {
					input_auth.attr('readonly', '');
					alert('인증에 성공하였습니다');
					location.href = "<c:url value='/lms/user/sub00-04-01' />";
				} else {
					alert('인증에 실패하였습니다');

					btn.on('click', certification_code);
					btn.css('background-color', '#212121');
				}
			},
			error: function(e) {
				alert('에러가 발생했습니다');

				btn.on('click', certification_code);
				btn.css('background-color', '#212121');
			}
		});
	}
	
	$(function() {
	   	 var message = '${msg}';
	   	    if(message != "") {
	   	    	alert(message);
	   	 	}
	   	});
	</script>
<!-- 	<style type="text/css">
	
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

        <div class="subPage_content sub-content sub00-04 margin-left20">
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
            </div> -->
            <!-- <div class="sub-content sub00-01"></div> -->

            <!-- <div class="header">
                <div class="titleBar h3">비밀번호 찾기</div>
                <h3 class="h3"></h3>
            </div> -->
            <div class="section userInfo sub00-04">
            	<div class="header">
                    <strong class="h4">비밀번호 찾기</strong>
                    <h5 class="fz14 c999">회원정보를 입력해주세요. 가입하신 이메일로 인증이 진행됩니다.</h5>
                </div>
				<div class="loginWrap enterWrap">
					<form class="form formStyle" onsubmit="return false;">
						<input class="input" type="text" name="user_id" placeholder="아이디 입력">
						<input class="input" type="text" name="user_nm" placeholder="이름 입력">
						<input class="input" type="text" name="user_email" placeholder="이메일 입력">
						<input class="input" type="text" id="phoneNumber" name="user_phone" placeholder="휴대폰번호 입력(숫자만)" numberOnly>
						<input class="input btn_normal btn_xlarge btn_orangeD" type="button" id="certi_code_btn" value="인증하기">
					</form>
					<div id="certi_code_section">
						<div class="input_wrap">
							<input id="certi_code" type="text" maxlength="4"
								name="code_number" placeholder="인증 번호 입력" /> <br>
							<span>이메일로 코드가 발송되었습니다</span>
						</div>
						<input id="certi_btn" class="button  btn-bk" type="button" value="인증">
					</div>
				</div>
				<!-- <acrticle class="certification">
                    <header class="article-title">
                        <div class="titleBar-hdr h4">인증방법 선택</div>
                        <h4 class="h4"></h4>
                    </header>
                    <div class="certificationWrap">
                        <div class="certif-boxWrap d-flex">
                            <div class="certif certif01">
                                <h3 class="h3">아이핀인증</h3>
                                <p class="c666"> 아이핀으로 본인확인을 합니다.<br>&nbsp;</p>
                                <button class="button enter-btn btn-bk" type="button" onclick="location.href='/lms/user/sub00-04-01'">인증하기</button>
                            </div>
                            <div class="certif certif02">
                                <h3 class="h3">아이디와 이메일 정보 확인</h3>
                                <p class="c666">회원정보를 입력해주세요.<br>가입하신 이메일로 인증이 진행됩니다.</p>
                            </div>
                        </div>
                    </div>
                </acrticle> -->
            </div>
        </div>
    </div>

    <!-- footer-include -->
    <%@include file="../common_footer_doitcam.jsp"%>
</body>

</html>

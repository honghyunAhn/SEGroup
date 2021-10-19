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
    <link rel="stylesheet" href="/resources/segroup/society/smtp/css/img-icon.css">
    <link rel="stylesheet" href="/resources/segroup/society/smtp/css/swiper-bundle.css">
    <link rel="stylesheet" href="/resources/segroup/society/smtp/css/rainbowStyle_common.css">
    <link rel="stylesheet" href="/resources/segroup/society/smtp/css/rainbowStyle_basic.css">
    <link rel="stylesheet" href="/resources/segroup/society/smtp/css/rainbowStyle_responsive.css">
    <script src="/resources/segroup/society/smtp/js/jquery-3.3.1.min.js"></script>
    <!-- <script src="js/swiper-bundle.js"></script> -->
    <script src="/resources/segroup/society/smtp/js/rainbowScript_common.js"></script>
    
    <script type="text/javascript">
        $(function () {
            $('#next_btn').on('click', request_certification_code);
            $('#certi_btn').on('click', certification_code);
            $('#certi_code_section').hide();

            $("#phoneNumber").on("keyup", function() {
		        $(this).val($(this).val().replace(/[^0-9]/g,""));
		    });
            
            $('#prev_btn').on('click', function(){
            	$('#certi_code_section').hide();
                $('#certi-step01').show();
            });
        });
        //코드를 요청한다.
        
        function request_certification_code() {
        	var user_id = "anh288";
            var user_email = "anh2073@naver.com";
            var user_nm = "안홍현";
            var user_phone = "01067763120" ;
            /* var user_id = $('input[name=user_id]').val();
            var user_email = $('input[name=user_email]').val();
            var user_nm = $('input[name=user_nm]').val();
            var user_phone = $('input[name=user_phone]').val(); */
            if (user_id == "" || user_email == "" || user_nm == "" || user_phone == "") {
                alert("빈칸없이 입력해주세요.");
                return false;
            }
            var btn = $('#next_btn');
            btn.off('click');
            $.ajax({
                url: '<c:url value="/smtp/user/user_request_certification_code" />',
                data: {
                    "user_id": user_id,
                    "user_nm": user_nm,
                    "user_email": user_email,
                    "user_phone": user_phone
                },
                success: function (isRequested) {
                    if (!isRequested) {
                    	alert('인증번호가 전송되었습니다. 받은 메일함을 확인해주세요.');
                        $('#user_nm').attr('readonly', '');
                        $('#user_email').attr('readonly', '');
                        $('#user_id').attr('readonly', '');
                        $('#user_phone').attr('readonly', '');
						
                        $('#certi-step01').hide();
                        $('#certi_code_section').show();
                        
                        var input_auth = $('#certi_code');
                        input_auth.select();
                        input_auth.focus();
                    } else {
                        alert('입력된 내용과 일치하는 정보가 없습니다');

                        btn.on('click', request_certification_code);
                        btn.css('background-color', '#212121');
                    }
                },
                error: function (e) {
                    alert('에러가 발생했습니다');

                    btn.on('click', request_certification_code);
                    btn.css('background-color', '#212121');
                }
            });
        }


        function certification_code() {
            var input_auth = $('#certi_code');

            if (input_auth.val().length != 4 ||
                new RegExp("[0-9]{4}").test(input_auth.val()) == false) {
                alert('코드가 일치하지 않습니다');
                input_auth.focus();
                input_auth.select();
                return;
            }

            var btn = $('#certi_btn');
            btn.off('click');
            btn.css('background-color', 'lightgray');

            $.ajax({
                url: '<c:url value="/smtp/user/user_check_certification_code" />',
                data: {
                    certification_code: input_auth.val(),
                },
                success: function (isRequested) {
                    if (isRequested) {
                        input_auth.attr('readonly', '');
                        alert('인증에 성공하였습니다');
                        location.href = "<c:url value='/smtp/user/sub01-04-01' />";
                    } else {
                        alert('인증에 실패하였습니다');

                        btn.on('click', certification_code);
                        btn.css('background-color', '#212121');
                    }
                },
                error: function (e) {
                    alert('에러가 발생했습니다');

                    btn.on('click', certification_code);
                    btn.css('background-color', '#212121');
                }
            });
        }

        $(function () {
            var message = '${msg}';
            if (message != "") {
                alert(message);
            }
        });
    </script>
</head>

<body>
    <div class="container_rainbow">
    	<%@include file="../include/rainbow_header.jsp"%>
        <div class="content course-point04 sub01_content" id="main">
            <div class="sub-content">
                <div class="section_header">
                    <h3 class="h3">비밀번호찾기</h3>
                    <p class="margin-top10 fc_999">아래 회원정보를 입력해주세요. 가입하신 이메일로 인증이 진행됩니다.</p>
                </div>
                <div class="section_formStyle" id="certi-step01">
                    <form class="formStyle login" method="post" onsubmit="return false;">
                        <input class="input" type="text" name="user_id" autocomplete="off" placeholder="아이디 입력">
                        <input class="input" type="text" name="user_nm" autocomplete="off" placeholder="이름 입력">
                        <input class="input" type="text" name="user_email" autocomplete="off" placeholder="이메일 입력">
                        <input class="input" type="text" id="phoneNumber" name="user_phone" value="" autocomplete="off"
                            placeholder="휴대폰번호 입력(숫자만)">
                        <input type="button" class="btn_normal btn_xlarge bgc_point" id="next_btn"
                            value="인증 번호 받기">
                    </form>
                </div>

                <div class="section_formStyle" id="certi_code_section">
                    <form class="formStyle login">
                        <input id="certi_code" class="input" type="text" maxlength="4" name="code_number"
                            placeholder="전송된 인증 번호 입력" />
                        <div class="d-flex">
                            <input id="prev_btn" class="btn_normal two-buttons bgc_ccc" type="button" value="뒤로가기">
                            <input id="certi_btn" class="btn_normal two-buttons bgc_point" type="button" value="인증하기">
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <%@include file="../include/rainbow_footer.jsp"%>
    </div>
    
    <!-- <script type="text/javascript">
    const prevBtn = document.getElementById("prev_btn");
    const nextBtn = document.getElementById("certi_code_btn");
    prevBtn.closest(".section_formStyle").style.display = "none";

    function nextStep(){
        prevBtn.closest(".section_formStyle").style.display = "block";
        nextBtn.closest(".section_formStyle").style.display = "none";
    }
    function prevStep() {
        prevBtn.closest(".section_formStyle").style.display = "none";
        nextBtn.closest(".section_formStyle").style.display = "block";
    }
    // 인증코드 요청시 아래 클릭이벤트 추가할 것
    nextBtn.addEventListener('click', nextStep)
    prevBtn.addEventListener("click", prevStep)
    </script> -->
</body>

</html>
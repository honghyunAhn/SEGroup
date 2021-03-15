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
    var certificateInfo = ${certificateInfo}[0];
    var userInfo = ${userInfo};

    $(document).ready(function(){
    	
    	setContent ();
    })

    function setContent () {
    	
    	$('.ctf_name').html(userInfo.USER_NM);
    	
    	var birthArr = (userInfo.USER_BIRTH).split(' ');
    	$('.ctf_birth').html(birthArr[2] + '년 ' + birthArr[0] + ' ' + birthArr[1].replace(',', '') + '일');
    	$('.ctf_course').html(certificateInfo.CARDINAL_NAME);
    	$('.ctf_terms').html(certificateInfo.LEARN_START_DATE + ' ~ ' + certificateInfo.LEARN_END_DATE);
    	$('.ctf_time').html('8:30 - 20:00');
    	$('.cardinal_nm').html(certificateInfo.CARDINAL_NAME);
    	
    }
    
    function printWindow() {
		var initBody;
		
		window.print();
		
		return false;
	}
    </script>
    <style type="text/css">
		/* 	배경 img 프린트 */
		@media print
		{
			* {/*Chrome, Safari */
				-webkit-print-color-adjust: exact !important;
				/*Firefox*/
				color-adjust: exact !important;
			}
			.button-wrap{display: none;}
		}
	</style>
</head>

<body>
    <div class="container_rainbow">
        <div class="content sub-content sub05_content view-certificate view-certificate_completion" id="main">
            <ul class="ctf_textWrap">
                <li class="ctf_name"></li>
                <li class="ctf_birth"></li>
                <li class="ctf_course"></li>
                <li class="ctf_terms"></li>
                <li class="ctf_time"></li>
            </ul>
            <div class="ctf_endDate"></div>
        </div>
        <div class="button-wrap d-flex justify_center">
            <button type="button" class="btn_normal btn_pp_bg btn_medium" onclick="printWindow()">출력하기</button>
        </div>
    </div>
</body>

</html>

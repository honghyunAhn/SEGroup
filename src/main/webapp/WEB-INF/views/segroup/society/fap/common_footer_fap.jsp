<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<head>
    <link rel="stylesheet" href="/resources/css/common_footer_style.css">
    <link rel="stylesheet" href="<c:url value="/resources/segroup/society/fap/css/kakao.css" />">
	<!-- Global site tag (gtag.js) - Google Analytics -->
	<script async src="https://www.googletagmanager.com/gtag/js?id=G-YYRQ5XMKQN"></script>
	<script>
	  window.dataLayer = window.dataLayer || [];
	  function gtag(){dataLayer.push(arguments);}
	  gtag('js', new Date());
	
	  gtag('config', 'G-JQVKHYYB88');
	</script>
    <style>
        .footerWrap>.footer .footer_logoImg{
            background-image: url('/resources/css/img/SES_logo-wh.png');
        }
        /* Footer Custom Style */
        .footerWrap {
            background-color: #106c79;
            color: #fff;
        }
    </style>
    <script>
        $(function() {
            // Footer Scroll Top Button
            $('#scrollTop').click(function() {
                $('html, body').animate({
                    scrollTop: 0
                }, 300);
                return false;
            });
            $(window).scroll(function() {
                var scroll = $(this).scrollTop();

                if (scroll > 150) {
                    $('#scrollTop').fadeIn();
                } else {
                    $('#scrollTop').fadeOut();
                }
            });
        });
    </script>
</head>

<body>
    <!-- <div class="img-icon scrollTop" id="scrollTop"></div> -->
    <div class="footerWrap">
    	<a href="javascript:void plusFriendChat()">
		  <img class="kakaotalk-fixed" src="https://developers.kakao.com/assets/img/about/logos/plusfriend/consult_small_yellow_pc.png" alt="카카오톡 채팅상담" title="채팅상담" />
		</a>
        <div class="footer d-flex justify_between">
            <div class="footer_textWrap">
                <!-- logoImg -->
                <div class="footer_logoImg"></div>

                <ul class="lh30">
                    <li>(주) 소프트엔지니어소사이어티</li>
                    <li>서울시 강남구 영동대로513 코엑스4F ICT교육센터</li>
                    <li>광주시 광산구 무진대로282 광주무역회관7F 소프트엔지니어소사이어티아카데미</li>
                    <li>사업자등록번호 : 468-81-00409</li>
                    <li>통신판매업신고번호 : 제 강남-03736호</li>
                    <li><a href="/privacy_policy"><button><strong>개인정보처리방침</strong></button></a></li>
                </ul>
            </div>

<!--             <div class="footer_navWrap"> -->
<!--                 <ul class="navGroup d-flex"> -->
<!--                     <li class="gnb"> -->
<!--                         <div class="lnb"><a href="#">공지사항</a></div> -->
<!--                         <div class="lnb"><a href="#">FAQ</a></div> -->
<!--                     </li> -->
<!--                     <li class="gnb"> -->
<!--                         <div class="lnb"><a href="#">JOB Fair 일정</a></div> -->
<!--                         <div class="lnb"><a href="#">전형절차</a></div> -->
<!--                         <div class="lnb"><a href="#">취업정보 & 전략</a></div> -->
<!--                         <div class="lnb"><a href="#">채용기업파트너사</a></div> -->
<!--                     </li> -->
<!--                     <li class="gnb"> -->
<!--                         <div class="lnb"><a href="#">SES회원서비스</a></div> -->
<!--                         <div class="lnb"><a href="#">취업연계과정</a></div> -->
<!--                     </li> -->
<!--                 </ul> -->
<!--             </div> -->
        </div>

        <!-- copyright -->
        <div class="copyright h5 textAlign_center" style="text-align:center;">
            Copyrightⓒ2019 (주)소프트엔지니어소사이어티(Soft Engineer Society) All right reserved.
        </div>
    </div>
    <script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
	<script type='text/javascript'>
	  	//<![CDATA[
	    // 사용할 앱의 JavaScript 키를 설정해 주세요.
	    Kakao.init('0a2be72636126326e38e6e491518d271');
	    function plusFriendChat() {
	      Kakao.PlusFriend.chat({
	        plusFriendId: '_xawxkxbT' // 플러스친구 홈 URL에 명시된 id로 설정합니다.
	      });
	    }
	  //]]>
</script>
</body>

</html>

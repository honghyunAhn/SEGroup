<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<head>
	<!-- Global site tag (gtag.js) - Google Analytics -->
	<script async src="https://www.googletagmanager.com/gtag/js?id=G-YWHHBJ7CL1"></script>
	<script>
	  window.dataLayer = window.dataLayer || [];
	  function gtag(){dataLayer.push(arguments);}
	  gtag('js', new Date());
	
	  gtag('config', 'G-YWHHBJ7CL1');
	</script>
    <link rel="stylesheet" href="/resources/css/common_footer_style.css">
    <style>
        /* Footer Custom Style */
        .footerWrap {
            background-color: #fff;
            border-top: 1px solid #e7e7e7;
        }
        .img-icon.scrollTop {
            background-position: -880px -20px;
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
    <div class="img-icon scrollTop" id="scrollTop"></div>
    <div class="footerWrap">
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
                </ul>
            </div>

            <div class="footer_navWrap">
			<ul class="navGroup d-flex">
				<li class="gnb subMenu10"><a class="gnbMenu" href="https://softsociety.net/mainpage">회사정보</a>
					<ul class="lnb">
						<li><a href="https://softsociety.net/mainpage" target="_blank">회사소개</a></li>
						<li><a href="/usage_policy" target="_blank">이용약관</a></li>
						<li><a href="/privacy_policy" target="_blank">개인정보처리방침</a></li>
						<li><a href="#">사업제휴</a></li>
					</ul></li>
				<li class="gnb subMenu06"><a class="gnbMenu"
					href="sub06-01.html">커뮤니티</a>
					<ul class="lnb">
						<li><a href="/lms/community/sub05-01-01">공지사항</a></li>
						<li><a href="/lms/community/sub05-01-02">이벤트</a></li>
					</ul></li>
				<li class="gnb subMenu07"><a class="gnbMenu" href="/lms/support/sub06-01-01">고객센터</a>
					<ul class="lnb">
						<li><a href="/lms/support/sub06-01-01">고객지원</a></li>
						<li><a href="/lms/support/sub06-02">FAQ</a></li>
						<li><a href="/lms/support/sub06-03">단체/제휴문의</a></li>
						<li><a href="/lms/support/sub06-04">오시는길</a></li>
					</ul></li>
				<li class="gnb subMenu11">
					<div class="gnbMenu">관련사이트</div>
					<ul class="lnb">
						<li><a href="https://blog.naver.com/scitmaster" target="_blank">두잇 블로그</a></li>
						<li><a href="https://www.instagram.com/scitmaster" target="_blank">두잇 인스타그램</a></li>
						<li><a href="https://www.youtube.com/channel/UCCsiCEQ8g6PacQLuJEYEWpw" target="_blank">두잇 유튜브</a></li>
						<!-- <li><a href="#">두잇 카페</a></li> -->
					</ul>
				</li>
			</ul>
		</div>
        </div>

        <!-- copyright -->
        <div class="copyright h5 fc_aaa textAlign_center">
            Copyrightⓒ2020 (주)소프트엔지니어소사이어티(Soft Engineer Society) All right reserved.
        </div>
    </div>
</body>

</html>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<head>
    <link rel="stylesheet" href="/resources/css/common_footer_style.css">
    <style>
    	/* Footer Custom Style */
        /* .footerWrap>.footer .footer_logoImg{
            background-image: url('/resources/css/img/SES_logo-wh.png');
        }       
        .footerWrap {
            background-color: #0a1930;
            color: #fff;
        }
        .footer_navWrap{
            color: #14e2cb;
        }
        .footer_navWrap>.navGroup .gnb a{
            opacity : 1;
        }
        .footer_navWrap>.navGroup .gnb a:hover {
            text-decoration : underline;
        } */
        .footerWrap {
            background-color: #fff;
            border-top: 1px solid #e7e7e7;
        }
        .img-icon.scrollTop {
            background-position: -920px -20px;
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
    <!-- Global site tag (gtag.js) - Google Analytics -->
	<script async src="https://www.googletagmanager.com/gtag/js?id=G-G0EZNYRP2G"></script>
	<script>
	  window.dataLayer = window.dataLayer || [];
	  function gtag(){dataLayer.push(arguments);}
	  gtag('js', new Date());
	
	  gtag('config', 'G-2144BMVDQ5');
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
                    <li><a href="/privacy_policy"><button><strong>개인정보처리방침</strong></button></a></li>
                </ul>
            </div>

            <div class="footer_navWrap">
                <ul class="navGroup d-flex">
                    <!-- rainbow_nav -->
                    <li class="gnb">
                        <a href="javascript:page_move('/smtp/course/short-term/short-term-info','c000000535');" href="javascript:void(0);">국내 AI/빅데이터 취업</a>
                        <div class="lnb">
                            <a href="javascript:page_move('/smtp/course/scmaster/scmaster-info','c000000525');" href="javascript:void(0);">일본 ICT 취업</a>
                        </div>
                        <div class="lnb">
                            <a href="javascript:page_move('/smtp/course/short-term/short-term-info','c000000544');" href="javascript:void(0);">일본 비ICT 취업</a>
                        </div>
                        <div class="lnb">
                            <a href="javascript:page_move('/smtp/course/scmaster/scmaster-info','c000000527');" href="javascript:void(0);">미국 ICT 인턴십</a>
                        </div>
                        <div class="lnb">
                            <a href="/smtp/course/short-term/short-term-info?course_id=c000000541">외국어 자격증 과정</a>
                        </div>
                    </li>
                    <li class="gnb">
                        <div class="lnb"><a href="/smtp/community/sub04-01">공지사항</a></div>
                        <div class="lnb"><a href="/smtp/support/sub04-02">FAQ</a></div>
                        <div class="lnb"><a href="/smtp/support/sub04-03">오시는길</a></div>
                    </li>
                    <c:if test="${sessionScope.user_id ne null}">
	                    <li class="gnb">
	                        <!-- 나의강의실 부분 로그인 확인 필요 -->
	                        <a href="/smtp/user/sub05-01">나의강의실</a>
							<div class="lnb"><a href="/smtp/user/sub05-01">학습현황</a></div>
							<div class="lnb"><a href="/smtp/user/sub05-02">지원현황</a></div>
							<div class="lnb"><a href="/smtp/user/sub05-03">서류발급</a></div>
	                    </li>
	                    <li class="gnb">
	                    	<div class="lnb"><a href="/smtp/user/sub05-04">결제현황/환불</a></div>
		                	<div class="lnb"><a href="/smtp/user/sub05-05">마일리지</a></div>
		                    <div class="lnb"><a href="/smtp/user/sub05-06">개인정보수정</a></div>
	                    </li>
                    </c:if>
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

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" Content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width, target-densitydpi=medium-dpi " />
<meta name="format-detection" content="telephone=no">
<script src="<c:url value="/resources/segroup/js/jquery-3.1.1.js" />"></script>
<script src="<c:url value="/resources/segroup/society/edu/js/slidebanner.js" />"></script>
<head>
<!-- Global site tag (gtag.js) - Google Analytics -->
<script async src="https://www.googletagmanager.com/gtag/js?id=UA-90390154-1"></script>
<script>
	window.dataLayer = window.dataLayer || [];
	function gtag(){dataLayer.push(arguments);}
	gtag('js', new Date());
	gtag('config', 'UA-90390154-1');
</script>
<!-- 카카오광고 리타게팅 코드_삽입요청_180917 -->
<script type="text/javascript" charset="UTF-8" src="//t1.daumcdn.net/adfit/static/kp.js"></script>
<script type="text/javascript">
	kakaoPixel('4900075932325164644').pageView();
</script>

<title>글로벌 엔지니어 양성</title>
<script src="<c:url value="/resources/segroup/society/edu/js/jquery.bxslider.min.js" />"></script>
<!-- bxSlider CSS file -->
<link href="<c:url value="/resources/segroup/society/edu/css/jquery.bxslider.css" />" rel="stylesheet" />
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/segroup/society/edu/css/common.css" />">
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/segroup/society/edu/css/sub.css" />">
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/segroup/society/edu/css/main.css" />">
<!-- lightSlider CSS files and JS -->
<link rel="stylesheet"  href="/resources/segroup/society/edu/css/lightslider.css"/>
    <style>
    	ul{
			list-style: none outside none;
		    padding-left: 0;
            margin: 0;
		}
        .demo .item{
            margin-bottom: 60px;
        }
		.content-slider li{
		}
		.content-slider img {
		    margin: 0;
		    width: 350px;
		    height: 215px;
		}
		.demo{
			width: 1100px;
		}
		.clearfix{
			margin: auto;
		}
    </style>
    <script src="/resources/segroup/society/edu/js/lightslider.js"></script> 
    <script>
      
    	 $(document).ready(function() {
			$("#content-slider").lightSlider({
                loop:true,
              	auto:true,
                keyPress:true
            });
            $('#image-gallery').lightSlider({
                item:1,
                slideMargin: 0,
                speed:1000,
                auto:true,
                loop:true,
                onSliderLoad: function() {
                    $('#image-gallery').removeClass('cS-hidden');
                }  
            });
		});
    </script>
<style>
.info4 li:first-child {
	margin-left: 0px;
	)
}

* {
	margin: 0px;
	padding: 0px;
}

body, html {
	height: 100%;
}
.bx-wrapper .bx-viewport {
	border: none !important;
}

.text_overflow {
	height: 20px;
	width: 200px;
	text-overflow: ellipsis;
	-o-text-overflow: ellipsis;
	overflow: hidden;
	white-space: nowrap;
	word-wrap: normal !important;
	display: block;
}

.top_img {
	width: 1100px;
	margin-left: auto;
	margin-right: auto;
	display: block;
}
}
</style>
<script type="text/javascript">
	$(function() {
		$(window).scroll(function() {
			if ($(this).scrollTop() > 10) {
				$('#MOVE_TOP_BTN').fadeIn();
			} else {
				$('#MOVE_TOP_BTN').fadeOut();
			}
		});

		$("#MOVE_TOP_BTN").click(function() {
			$('html, body').animate({
				scrollTop : 0
			}, 400);
			return false;
		});
		
		var session = "${sessionExpire}";
		if(session == "sessionExpire") {
			alert("세션이 만료되었습니다. 계속하려면 다시 로그인 하세요.");
		}
	});

	function openWindow(aTag) {
		url = aTag.getAttribute("href");
		window.open(url, '_blank');
		window.focus();
	}

	function confirm_event() {
		if (confirm("SC IT마스터과정은 무역협회 무역아카데미와\n컨소시움으로 운영하는 과정입니다.\n\n해당 페이지로 이동하시겠습니까?") == true) { //확인
			window.open("https://newtradecampus.kita.net/page/user_job_CloudIT_home", '_blank');
			window.focus();
		} else { //취소
			return false;
		}
	}
</script>
</head>
<body>
	<%@include file="menu.jsp"%>
	<a id="MOVE_TOP_BTN" href="#none">
		<img src="/resources/segroup/society/edu/image/sub/top.png" style="width: 60px; height: 60px;" title="위로가기">
	</a>
	<div class="item">            
            <div class="clearfix" style="max-width:1100px;">
                <ul id="image-gallery" class="gallery list-unstyled cS-hidden">
                	<c:forEach var="data" items="${banner_list}">
                		<li>
                			<a href="${data.edu_ban_link}"><img class="top_img" src="${data.img_full_path}"></a>
                		</li>
                	</c:forEach>
                </ul>
            </div>
        </div>
	
	<div class="main_notice_wrap1">
		<div class="main_notice_title1">
			<h1>모집과정</h1>
		</div>
		<div class="item">
            <ul id="content-slider" class="content-slider">
                <c:forEach var="data" items="${subbanner_list}">
                	<li>
                		<a href="${data.edu_sub_ban_link}">
                			<img src="${data.img_full_path}">
                		</a>
                		<div class="sub_ban_nm">
                			${data.edu_sub_ban_nm}
                		</div>
                		<div class="sub_ban_dt">
                			<c:if test="${data.edu_sub_ban_st != null && data.edu_sub_ban_st != ''}">
                				신청기간 : ${data.edu_sub_ban_st} ~ ${data.edu_sub_ban_et}
                			</c:if>
                		</div>
                	</li>
                </c:forEach>
                
            </ul>
        </div>
	</div>
	<div class="main_news_wrap_cover">
		<div class="main_news_wrap">
			<div class="main_news_con">
				<a href="/edu/community/notice">
					<h1>공지사항</h1>
				</a>
				<div class="news_img">
					<img src="<c:url value="/resources/segroup/society/edu/image/main/thum_news3.jpg" />">
				</div>
				<div class="news_articles">
					<h2>새소식을 지금 확인하세요</h2>
					<ol>
						<c:forEach var="data" items="${noticeList}" varStatus="status">
							<li class="text_overflow"><a href="/edu/community/notice_detail.do?seq=${data.BOARD_CONTENT_SEQ}">
									<c:out value="${data.BOARD_CONTENT_TITLE}" />
								</a></li>
						</c:forEach>
					</ol>
				</div>
			</div>
			<div class="main_news_con">
				<a href="/edu/consulting/faq">
					<h1>FAQ</h1>
				</a>
				<div class="news_img">
					<img src="<c:url value="/resources/segroup/society/edu/image/main/thum_news4.jpg" />">
				</div>
				<div class="news_articles">
					<h2>궁금한 점을 해결하세요</h2>
					<ol>
						<c:forEach var="data" items="${faqList}" varStatus="status">
							<li class="text_overflow"><a href="/edu/consulting/faq">
									<c:out value="${data.CONSULTING_TITLE}" />
								</a></li>
						</c:forEach>
					</ol>
				</div>
			</div>
			<div class="main_news_con">
				<a href="/edu/community/media_in_it">
					<h1 style="margin: 20px 15px 15px 15px;">미디어속 K-Move 스쿨</h1>
				</a>
				<div class="news_img">
					<img src="<c:url value="/resources/segroup/society/edu/image/main/thum_news1.jpg" />">
				</div>
				<div class="news_articles">
					<h2>세상에 알려진 이야기</h2>
					<ol>
						<c:forEach var="data" items="${mediainitList}" varStatus="status">
							<li class="text_overflow"><a href="/edu/community/media_in_it_detail.do?seq=${data.BOARD_CONTENT_SEQ}">
									<c:out value="${data.BOARD_CONTENT_TITLE}" />
								</a></li>
						</c:forEach>
					</ol>
				</div>
			</div>
			<div class="main_news_con">
				<a href="/edu/community/graduate_community">
					<h1>졸업생마당</h1>
				</a>
				<div class="news_img">
					<img src="<c:url value="/resources/segroup/society/edu/image/main/thum_news2.jpg" />">
				</div>
				<div class="news_articles">
					<h2>우리도 해냈다!</h2>
					<ol>
						<c:forEach var="data" items="${graduateList}" varStatus="status">
							<li class="text_overflow"><a href="/edu/community/graduate_community_detail.do?seq=${data.BOARD_CONTENT_SEQ}">
									<c:out value="${data.BOARD_CONTENT_TITLE}" />
								</a></li>
						</c:forEach>
					</ol>
				</div>
			</div>
		</div>
	</div>
	<%@include file="footer.jsp"%>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<!DOCTYPE HTML>
<html lang="ko-KR">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="format-detection" content="telephone=no">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<meta name="description" content="글로벌 S/W인재 양성 교육과정 SC IT마스터">
<meta name="keywords" content="해외취업, 일본취업, 베트남취업, IT, 회화, 개발, 취업, Soft Engineer Society, SES, SCIT, E러닝, 두잇캠퍼스, Do it campus">
<title>Soft Engineer Society</title>
<link rel="stylesheet" href="/resources/lms/css/swiper.min.css">
<link rel="stylesheet" href="/resources/lms/css/reset.css">
<link rel="stylesheet" href="/resources/lms/css/common.css">
<link rel="stylesheet" href="/resources/lms/css/img-icon.css">
<link rel="stylesheet" href="/resources/lms/css/landing-style.css">
<link rel="stylesheet" href="/resources/lms/css/landing-style_responsive.css">
<script src="/resources/lms/js/jquery-3.3.1.min.js"></script>
<script src="/resources/lms/js/swiper.js"></script>
<script src="/resources/lms/js/landing-script.js"></script>
<!-- Global site tag (gtag.js) - Google Analytics -->
<script async src="https://www.googletagmanager.com/gtag/js?id=G-2ZSHPMZBSM"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());

  gtag('config', 'G-2ZSHPMZBSM');
</script>
<script type="text/javascript">
	$( document ).ready(function() {
	
		cookiedata = document.cookie; 
	
		if ( cookiedata.indexOf("ncookie=done") < 0 ){ 
			document.getElementById('popup').style.display = "block";    //  팝업창 아이디
	
		} else {
			document.getElementById('popup').style.display = "none";    // 팝업창 아이디
		}
	
	});
	
	function setCookie( name, value, expiredays ) { 
	
		var todayDate = new Date(); 
		todayDate.setDate( todayDate.getDate() + expiredays );
		document.cookie = name + "=" + escape( value ) + "; path=/; expires=" + todayDate.toGMTString() + ";"
	}
	function closeWin() { 
	
		document.getElementById('popup').style.display = "none";    // 팝업창 아이디
	
	}
	
	function todaycloseWin() { 
		setCookie( "ncookie", "done" , 1);     // 저장될 쿠키명 , 쿠키 value값 , 기간( ex. 1은 하루, 7은 일주일)
		document.getElementById('popup').style.display = "none";    // 팝업창 아이디
	
	}
	

</script>
</head>

<div id="popup" style="position:absolute; z-index:9999; visibility:done; margin: auto; left: 0; right: 0; bottom: 30vh; top: 0; width: 1100px; height: 350px;">
	<div style="background-color: white;">
		<a href="https:///www.softsociety.net/smtp/course/scmaster/scmaster-info?course_id=c000000526"><img src="/edu/admin/banner_save_image/202012301609334095525.png"/></a>
		<div style="padding: 10px; text-align: right;">
			<a href="#" onclick="todaycloseWin();" style="color: blue; margin-right: 20px;">오늘하루 열지 않기</a>
			<a href="#" onclick="closeWin();" style="color: blue;">닫기</a>
		</div>
	</div>
</div>
<body>
	<!-- 01. 콘텐츠 바로가기(웹 접근성) -->
	<div class="skip-navigation">
		<p>
			<a class="goToMain" href="#main">콘텐츠 바로가기</a>
		</p>
	</div>
	<!-- 02. 랜딩페이지(허브페이지) -->
	<div class="landing-container">
		<div class="bgWrap">
			<div class="fullWrapper">
				<div class="full-navGroup">
					<div class="img-icon close times" id="hideNav"></div>
					<div class="menuDivWrap">
						<ul class="menu-title-division">
							<li class="gnb">
								<a href="http://rainbow.ac">
									<div class="fz16">Off-line Program</div>
									<h2 class="h2">Rainbow</h2>
								</a>
							</li>
						</ul>
						<ul class="menu-title-division">
							<li class="gnb">
								<a href="/fap/user/user_main">
									<div class="fz16">Job Placement</div>
									<h2 class="h2">Bridge JOB Fair</h2>
								</a>
							</li>
						</ul>
						<ul class="menu-title-division">
							<li class="gnb">
								<a href="/lms/main">
									<div class="fz16">On-line Contents</div>
									<h2 class="h2">Do it Campus</h2>
								</a>
							</li>
						</ul>
					</div>
				</div>
			</div>
			<header class="headerWrap">
				<div class="hdr d-flex justify_between">
					<h1 class="header-logo">
						<a href="/" title="메인"> 
							<img class="logoImg" src="/resources/lms/img/society_logo_wh.png" alt="Soft Engineer Society">
						</a>
					</h1>
					<div class="img-icon bars-2line" id="showNav"></div>
				</div>
			</header>

			<div class="contentWrap">
				<div class="content background-opacity" id="main">
					<div class="section background-opacity">
						<h1 class="main-text h1">SOFT ENGINEER SOCIETY</h1>
						<div class="linkWrap d-flex justify_between fc_fff">
							<div class="linkBox link-RB">
								<a href="http://rainbow.ac">
									<div class="linkText">
										<h5 class="h5">Blended-rainbow Program</h5>
										<div class="fz24">디지털 융합 인재양성</div>
										<h5 class="h5">(rainbow.ac)</h5>
										<p>다양한 전공과 ICT·AI를 융합하여<br>K-Digital 인재로 컬러링 해드립니다.</p>
									</div>
									<div class="linkBtn">
										<p>바로가기</p>
										<div class="img-icon link-arrow"></div>
									</div>
								</a>
							</div>
							<div class="linkBox link-BJF">
								<a href="http://bridge.career">
									<div class="linkText">
										<h5 class="h5">Bridge JOB Fair</h5>
										<div class="fz24">글로벌 잡매칭(미국/한국/일본)</div>
										<h5 class="h5">(bridge.career)</h5>
										<p>연 2회 이상 글로벌 기업의 잡포스팅과<br>채용전형 절차를 제공합니다.</p>
									</div>
									<div class="linkBtn">
										<p>바로가기</p>
										<div class="img-icon link-arrow"></div>
									</div>
								</a>
							</div>
							<div class="linkBox link-DIC">
								<a href="http://doitcampus.com">
									<div class="linkText">
										<h5 class="h5">On-line Contents</h5>
										<div class="fz24">온라인 캠퍼스(Do it Campus)</div>
										<h5 class="h5">(doitcampus.com)</h5>
										<p>SW·AI·클라우드 입문자를 위한 기본정보 & 필수역량 등<br>다른 곳에서 만날 수 없는 SES만의 콘텐츠를 확인하세요.</p>
									</div>
									<div class="linkBtn">
										<p>바로가기</p>
										<div class="img-icon link-arrow"></div>
									</div>
								</a>
							</div>
						</div>
					</div>
					<div class="bannerWrap swiper-container">
						<div class="btnWrap d-flex justify_between">
							<div class="swiper-button-prev img-icon chevron-left999"></div>
							<div class="swiper-button-next img-icon chevron-rightt999"></div>
						</div>
						<div class="swiper-wrapper">
							<div class="swiper-slide banner1" href="https://smartstore.naver.com/softsociety/products/4957899809">
								<a href="https://smartstore.naver.com/softsociety/products/4957899809">
									<!-- <img src="/resources/lms/img/banner1.png" alt="Japan Career Market 일본취업 성공전략 자세히보기"> -->
								</a>
							</div>
							<div class="swiper-slide banner2">
								<a href="https:///www.softsociety.net/smtp/course/scmaster/scmaster-info?course_id=c000000526"> 
									<!-- <img src="/resources/lms/img/banner2.png" alt="SoftWare DevOps마스터 과정 자세히보기"> -->
								</a>
							</div>
						</div>
					</div>
				</div>
			</div>


			<footer class="footerWrap">
				<div class="d-flex justify_center">
					<ul class="companyInfo d-flex">
						<li><strong>(주)소프트엔지니어소사이어티</strong></li>
						<!-- <li>대표 : 김치중</li> -->
						<li>사업자등록번호 : 468-81-00409</li>
						<li>통신판매업신고번호 : 제 강남-03738호</li>
						<li>서울시 강남구 영동대로 513 코엑스 4층 017-1호</li>
					</ul>
					<div class="btnInfo btn_xsmall btn_normal">
						<a href="/mainpage">회사소개</a>
					</div>
				</div>
			</footer>
		</div>
	</div>
</body>
</html>

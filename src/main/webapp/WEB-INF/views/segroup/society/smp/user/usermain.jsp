<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>
<!DOCTYPE html>
<html lang="ko">
<meta http-equiv="Content-Type" Content="text/html; charset=utf-8" />
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>SCIT 마스터 학사관리</title>

<link href="https://fonts.googleapis.com/css?family=Roboto:300,400,700"
	rel="stylesheet">

<!-- Animate.css -->
<link rel="stylesheet" type="text/css"
	href="/resources/segroup/society/smp/css/animate.css">
<!-- Icomoon Icon Fonts-->
<link rel="stylesheet" type="text/css"
	href="/resources/segroup/society/smp/css/icomoon.css">
<!-- Themify Icons-->
<link rel="stylesheet" type="text/css"
	href="/resources/segroup/society/smp/css/themify-icons.css">
<!-- Bootstrap  -->
<link rel="stylesheet" type="text/css"
	href="/resources/segroup/society/smp/css/bootstrap.css">

<!-- Magnific Popup -->
<link rel="stylesheet" type="text/css"
	href="/resources/segroup/society/smp/css/magnific-popup.css">

<!-- Owl Carousel  -->
<link rel="stylesheet" type="text/css"
	href="/resources/segroup/society/smp/css/owl.carousel.min.css">
<link rel="stylesheet" type="text/css"
	href="/resources/segroup/society/smp/css/owl.theme.default.min.css">

<!-- Theme style  -->
<link rel="stylesheet" type="text/css"
	href="/resources/segroup/society/smp/css/style.css">
<!-- Calendar -->
<link href="/resources/segroup/society/smp/css/vanillaCalendar.css"
	type="text/css" rel="stylesheet">
<!-- Modernizr JS -->
<script src="/resources/segroup/society/smp/js/modernizr-2.6.2.min.js"></script>
<!-- FOR IE9 below -->
<!--[if lt IE 9]>
   <script src="/resources/js/respond.min.js"></script>
   <![endif]-->

<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>



<script>
	function printCourse(app_id) {
		var form = document.createElement("form");
		form.setAttribute("method", "post");
		form.setAttribute("action", "${path}/smp/user/printCourse");

		var hiddenField = document.createElement("input");
		hiddenField.setAttribute("type", "hidden");
		hiddenField.setAttribute("name", "app_id");
		hiddenField.setAttribute("value", app_id);
		form.appendChild(hiddenField);

		document.body.appendChild(form);
		form.submit();
	}
</script>
</head>
<body>

	<sec:authorize access="isAuthenticated()">
		<sec:authentication property="details" var="check" />
	</sec:authorize>

	<div class="gtco-loader"></div>

	<div id="page">
		<div class="page-inner">
			<nav class="gtco-nav" role="navigation">
				<div class="gtco-container">

					<div class="row">
						<div class="col-sm-4 col-xs-12">
							<div id="gtco-logo">
								<a href="/smp/user/usermain" target="_blank" title="새 창 열림"><img
									src="/resources/segroup/society/smp/images/SES.png" width="150"
									height="45" alt="SCIT과정"></a>
							</div>
						</div>
						<div class="col-xs-8 text-right menu-1">
							<ul>
								<li><a href="/smp/user/usermain">홈</a></li>
								<li class="has-dropdown"><a href="/smp/user/board">공지</a>
									<ul class="dropdown">
										<li><a href="/smp/user/board">기수공지</a></li>
									</ul></li>
								<li><a href="#">성적관리</a></li>
								<li><a href="/smp/scheduleStart">일정</a></li>
								<li class="has-dropdown"><a href="#"
									onclick="printCourse('${check.getUser().getUser_id()}');">증명서</a>
									<ul class="dropdown">
										<li><a href="#"
											onclick="printCourse('${check.getUser().getUser_id()}');">수강확인서</a></li>
										<li><a href="#">출결확인서</a></li>
									</ul></li>
								<li class="btn-cta"><a href="#"><span>문의사항</span></a></li>
							</ul>
						</div>
					</div>

				</div>
			</nav>

			<header id="gtco-header" class="gtco-cover" role="banner"
				style="background-image: url(/resources/segroup/society/smp/images/global.jpg)">
				<div class="overlay"></div>
				<div class="gtco-container">
					<div class="row">
						<div class="col-md-12 col-md-offset-0 text-left">
							<div class="row row-mt-15em">
								<div class="col-md-7 mt-text animate-box"
									data-animate-effect="fadeInUp">
									<h1 style="font-size: 65px; line-height: 1.2;" class="mainST">
										대한민국은 좁다.<br>나는 세계로 간다!
									</h1>
								</div>
							</div>
						</div>
					</div>
				</div>
			</header>

			<div class="gtco-section border-bottom">
				<div class="gtco-container">
					<div class="row">
						<div class=".col-lg-8 col-md-8 col-sm-12">
							<ul style="padding-left: 7.5px;">
								<li style="list-style: none;"><span style="font-size: 19px">공지</span>
									<p class="more_announcement" class="more">
										<a href="board" title="공지사항 전체보기"><img
											src="/resources/segroup/society/smp/images/lmi_more.gif"
											width="39" height="12" alt="MORE"></a>
									</p>
									<div id="board"></div>
							</ul>
						</div>


						<div class="col-lg-4 col-md-4 col-sm-6">
							<div class="p_11 profile">
								<!-- 기본형 프로필 영역 //-->

								<div class="greeting">
									<span style="font-size: 19px">Smart Cloud IT Master</span>
								</div>

								<!-- 기본형 프로필 영역 //-->
								<ul>
									<li><span class="title">이름</span><span class="pro_right">${check.getUsername() }</span>
									</li>
									<li><span class="title">기수</span><span id="gisu_num"
										class="pro_right"></span></li>
								</ul>
								<div class="btnArea">
									<a href="#none" class="blue_btn" id="logout">로그아웃</a>
								</div>
							</div>
						</div>


						<!-- 로그인 폼 종료 -->

						<!-- 로그아웃 폼 시작 -->
						<form id="logoutForm" action="/smp/user/logout" method="post"
							style="display: none">
							<input type="hidden" name="${_csrf.parameterName}"
								value="${_csrf.token}" />
						</form>
						<!-- 로그아웃 폼 종료 -->

						<div class="col-lg-4 col-md-4 col-sm-6" style="height: 375px;">
							<span style="font-size: 19px">캘린더</span>
							<div id="v-cal" style="height: 240px;">
								<div class="vcal-header">
									<button class="vcal-btn" data-calendar-toggle="previous">
										<svg height="24" version="1.1" viewbox="0 0 24 24" width="24"
											xmlns="http://www.w3.org/2000/svg">
                                 <path
												d="M20,11V13H8L13.5,18.5L12.08,19.92L4.16,12L12.08,4.08L13.5,5.5L8,11H20Z"></path>
                              </svg>
									</button>

									<div class="vcal-header__label" data-calendar-label="month">
										March 2017</div>
									<button class="vcal-btn" data-calendar-toggle="next">
										<svg height="24" version="1.1" viewbox="0 0 24 24" width="24"
											xmlns="http://www.w3.org/2000/svg">
                                 <path
												d="M4,11V13H16L10.5,18.5L11.92,19.92L19.84,12L11.92,4.08L10.5,5.5L16,11H4Z"></path>
                              </svg>
									</button>
								</div>
								<div class="vcal-week">
									<span>월</span> <span>화</span> <span>수</span> <span>목</span> <span>금</span>
									<span>토</span> <span>일</span>
								</div>
								<div class="vcal-body" data-calendar-area="month"></div>
							</div>
						</div>
						<div class="col-lg-4 col-md-4 col-sm-6" style="height: 375px;">
							<ul>
								<li class="m2 " style="list-style: none;"><span
									style="font-size: 19px">일정</span>
									<p class="more_announcement">
										<a href="/smp/scheduleStart" title="일정 전체보기"><img
											src="/resources/segroup/society/smp/images/lmi_more.gif"
											width="39" height="12" alt="MORE"></a>
									</p>
									<div class="normal_list">
										<div id="schedule"></div>
									</div></li>
							</ul>
						</div>
					</div>
				</div>
				<div class="gototop js-top">
					<a href="#" class="js-gotop"><i class="icon-arrow-up"></i></a>
				</div>
				<script src="/resources/segroup/society/smp/js/vanillaCalendar.js"
					type="text/javascript"></script>
				<script>
					window.addEventListener('load', function() {
						vanillaCalendar.init({
							disablePastDays : true
						});
					})

					$(function() {
						//메세지
						var message = $('#message').val();
						if (message != "" || message.length != 0) {
							/* alert(message); */
						}
						$('#message').val("");

						//로그인
						$("#smp_login_btn").on("click", function() {
							$("#loginForm").submit();
							return false;
						});

						//로그아웃
						$('#logout').off("click").on("click", function() {
							$('#logoutForm').submit();
							return false;
						});
					});
				</script>
				<!-- jQuery -->
				<script src="/resources/segroup/society/smp/js/jquery.min.js"></script>
				<!-- jQuery Easing -->
				<script src="/resources/segroup/society/smp/js/jquery.easing.1.3.js"></script>
				<!-- Bootstrap -->
				<script src="/resources/segroup/society/smp/js/bootstrap.min.js"></script>
				<!-- Waypoints -->
				<script
					src="/resources/segroup/society/smp/js/jquery.waypoints.min.js"></script>
				<!-- Carousel -->
				<script src="/resources/segroup/society/smp/js/owl.carousel.min.js"></script>
				<!-- countTo -->
				<script src="/resources/segroup/society/smp/js/jquery.countTo.js"></script>
				<!-- Magnific Popup -->
				<script
					src="/resources/segroup/society/smp/js/jquery.magnific-popup.min.js"></script>
				<script
					src="/resources/segroup/society/smp/js/magnific-popup-options.js"></script>
				<!-- Main -->
				<!-- <script src="/resources/segroup/society/smp/js/main.js"></script> -->
				<script src="/resources/segroup/society/smp/js/usermain.js"></script>

	
</body>
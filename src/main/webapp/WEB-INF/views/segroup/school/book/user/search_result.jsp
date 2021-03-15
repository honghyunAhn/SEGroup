<%@page import="global.segroup.util.PathConstants"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="global.segroup.util.*"%>
<!DOCTYPE html>
<!--[if lt IE 7]>      <html class="no-js lt-ie9 lt-ie8 lt-ie7"> <![endif]-->
<!--[if IE 7]>         <html class="no-js lt-ie9 lt-ie8"> <![endif]-->
<!--[if IE 8]>         <html class="no-js lt-ie9"> <![endif]-->
<!--[if gt IE 8]><!-->
<html class="no-js">
<!--<![endif]-->
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>SES Library</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="Search Result Page" />
<meta name="keywords" content="SES Library, user, landing page, main" />
<meta name="author" content="이상철" />

<!-- Place favicon.ico in the root directory -->
<link rel="shortcut icon" href="/favicon.ico">

<!-- jQuery -->
<script type="text/javascript"
	src="/resources/segroup/school/book/user/js/jquery-3.1.1.js"></script>
<!-- jQuery Easing -->
<script
	src="/resources/segroup/school/book/user/js/jquery.easing.1.3.js"></script>
<!-- Bootstrap -->
<script src="/resources/segroup/school/book/user/js/bootstrap.min.js"></script>
<!-- Waypoints -->
<script
	src="/resources/segroup/school/book/user/js/jquery.waypoints.min.js"></script>
<!-- Main JS -->
<script src="/resources/segroup/school/book/user/js/main.js"></script>
<!-- Jquery UI -->
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<!-- Datepicker -->
<script src="<c:url value="/resources/segroup/js/datepicker.js" />"></script>

<!-- Jquery UI  -->
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">

<link rel="stylesheet"
	href="<c:url value="/resources/segroup/css/jquery-ui.min.css" />">
<!-- Google Fonts -->
<!-- <link
	href='http://fonts.googleapis.com/css?family=Playfair+Display:400,700,400italic|Roboto:400,300,700'
	rel='stylesheet' type='text/css'> -->
<!-- Animate -->
<link rel="stylesheet"
	href="/resources/segroup/school/book/user/css/animate.css">
<!-- Icomoon -->
<link rel="stylesheet"
	href="/resources/segroup/school/book/user/css/icomoon.css">
<!-- Bootstrap  -->
<link rel="stylesheet"
	href="/resources/segroup/school/book/user/css/bootstrap.css">

<link rel="stylesheet"
	href="/resources/segroup/school/book/user/css/style.css">

<link rel="stylesheet"
	href="/resources/segroup/school/book/user/css/style2.css">

<link rel="stylesheet"
	href="/resources/segroup/school/book/user/css/normalize.css">

<link rel="stylesheet"
	href="/resources/segroup/school/book/user/css/responsive.css">

<!-- Modernizr JS -->
<script
	src="/resources/segroup/school/book/user/js/modernizr-2.6.2.min.js"></script>
<!-- FOR IE9 below -->
<!--[if lt IE 9]>
	<script src="/resources/segroup/school/book/user/js/respond.min.js"></script>
	<![endif]-->

</head>

<style>
a.advanced_search:hover {
	text-decoration: underline;
	cursor: pointer;
}
</style>

<script type="text/javascript">
	$(function() {
		//로그인 처리
		$("#login_submit").on("click", function() {

			var user_id = $("#user_id").val();
			var user_pw = $("#user_pw").val();

			if (user_id.length == 0) {
				alert('아이디를 입력해주세요');
				return;
			}
			if (user_pw.length == 0) {
				alert('비밀번호를 입력해주세요');
				return;
			}

			$.ajax({
				type : "post",
				url : "/book/user/login",
				data : {
					user_id : user_id,
					user_pw : user_pw
				},
				success : function(data) {
					$('#myModal').modal('hide');
					
				},
				error : function(e) {
					alert("회원 정보가 맞지 않습니다.");
				}
			});
		});

		//세부검색
		$("#advanced_search").on("click", function() {
			$("#advanced_box").css("display", "inline");
		});
		$("#advanced_submit").on("click", function() {
			$("#advanced_box").css("display", "none");
		});
		$("#advanced_cancel").on("click", function() {
			$("#advanced_box").css("display", "none");
		});

		//출판일 선택 datepicker
		minMax("advanced_start_date", "advanced_end_date");
		
		//책 정보 가져오기
		var bookInfos;
		var searchBooks = [];
		$.ajax({
			type : "post",
			url : "/book/user/book_info",
			async : false,
			success : function(data) {
				bookInfos = data;
				$.each(data, function(index, item){
					searchBooks.push(item.BOOKINFO_BOOK_NM + "|" + item.BOOKINFO_AUTHOR + "|" + item.BOOKINFO_PUBLISHER);
				});
			},
			error : function(e) {
				console.log(e);
			}
		});
		//검색 자동완성
		$('#searchTextField').autocomplete({
			source : searchBooks,
			select : function(event, selected) {
				/* $.each(sigungu, function(index, val) {
					if (val.name == selected.item.value)
						location.href = "sc_05?areacode='" + val.areaCode 
										+ "'&sigungucode='" + val.sigunguCode 
										+ "'&city_nm=" + val.name + "";
				}); */
			}
		});
	});

	//이미지 리사이즈
	function resizeImg(img, height, width) {
	    img.height = height;
	    img.width = width;
	}
</script>


<body>
	<div id="fh5co-offcanvas" style="float: right">
		<a href="#" class="fh5co-close-offcanvas js-fh5co-close-offcanvas"><span><i>X</i>
				<span> Close</span></span></a>
		<div class="fh5co-bio">
			<figure>
				<img src="/resources/segroup/school/book/user/images/person1.jpg"
					alt="No Image" class="img-responsive">
			</figure>
			<h5 class="heading">32기</h5>
			<h5>이상철</h5>
		</div>

		<div class="fh5co-menu">
			<div class="fh5co-box">
				<h5 class="heading">마이 페이지</h5>
				<ul>
					<li><a href="<%=PathConstants.SCHOOL_BOOK_USER_STATUS%>">대여
							현황</a></li>
					<li><a href="<%=PathConstants.SCHOOL_BOOK_USER_BOOKMARK%>">관심
							도서</a></li>
					<li><a href="<%=PathConstants.SCHOOL_BOOK_USER_RENT_RECORD%>">내
							대여 기록</a></li>
					<li><a href="<%=PathConstants.SCHOOL_BOOK_USER_REVIEW%>">내
							글 보기</a></li>
				</ul>
			</div>
		</div>
	</div>
	<!-- END #fh5co-offcanvas -->

	<nav class="navbar navbar-default">
		<div class="container">
			<!-- Brand and toggle get grouped for better mobile display -->
			<div class="navbar-header">

				<h1 id="fh5co-logo">
					<a href="<%=PathConstants.SCHOOL_BOOK_USER_MAIN%>">SES Library</a>
				</h1>

				<button type="button" class="navbar-toggle collapsed"
					data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
					<span class="sr-only">Toggle navigation</span> <span
						class="icon-bar"></span> <span class="icon-bar"></span> <span
						class="icon-bar"></span>
				</button>
				<!-- <a class="navbar-brand" href="#">
				</a> -->

			</div>
			<!-- 	<br> <br> -->
			<!-- Collect the nav links, forms, and other content for toggling -->
			<div class="collapse navbar-collapse"
				id="bs-example-navbar-collapse-1">
				<div class="button navbar-right">
					<c:choose>
						<c:when test="${sessionScope.user_id == null }">
							<button type="button" id="loginForm"
								class="navbar-btn nav-button wow bounceInRight login"
								data-toggle="modal" data-target="#myModal" id="loginForm"
								data-wow-delay="0.8s">Login</button>
						</c:when>
						<c:otherwise>
							<button type="button"
								class="navbar-btn nav-button wow fadeInRight" id="logout"
								data-wow-delay="0.6s" onclick="logout()">Logout</button>
						</c:otherwise>
					</c:choose>
					<button type="button"
						class="navbar-btn nav-button wow fadeInRight js-fh5co-nav-toggle"
						id="mypage" data-wow-delay="0.6s">My Page</button>

					<!--로그인 모달  -->
					<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
						aria-labelledby="myLargeModalLabel" aria-hidden="true">
						<div class="modal-dialog modal-lg loginModal">
							<div class="modal-content">
								<div class="modal-header">
									<button type="button" class="close" data-dismiss="modal"
										aria-hidden="true">×</button>

									<h5 class="modal-title" id="myModalLabel">SES Library</h5>
								</div>
								<div class="modal-body">
									<div class="row">
										<div class="col-md-12" style="padding-right: 30px;">
											<!--border-right: 1px dotted #C2C2C2;  -->
											<!-- Nav tabs -->
											<ul class="nav nav-tabs headertabs">
												<li class="active"><a href="#Login" id="loginAtag"
													data-toggle="tab">Login</a></li>
											</ul>
											<!-- Tab panes -->
											<div class="tab-content">
												<div class="tab-pane active" id="Login">
													<div class="form-group">
														<label for="InputId" class="col-sm-2 control-label">
															ID</label>
														<div class="col-sm-10">
															<input type="text" name="user_id" class="form-control"
																id="user_id" placeholder="ID" />
														</div>
													</div>
													<div class="form-group">
														<label for="InputPassword" class="col-sm-2 control-label">Password</label>
														<div class="col-sm-10">
															<input type="password" name="user_pw"
																class="form-control" id="user_pw" placeholder="Password" />
														</div>
													</div>
													<div class="row">
														<div class="col-sm-2"></div>
														<div class="col-sm-10">
															<button type="button" class="btn btn-primary btn-sm"
																value="submit" id="login_submit">Submit</button>
														</div>
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
					<!--로그인&조인 모달 끝 -->
				</div>
				<ul class="main-nav nav navbar-nav navbar-right">
					<li class="wow fadeInDown" data-wow-delay="0s"><a href="/book/user/search_result?advanced_category=B0100">IT</a></li>
					<li class="wow fadeInDown" data-wow-delay="0.1s"><a href="/book/user/search_result?advanced_category=B0101">일본어</a></li>
					<li class="wow fadeInDown" data-wow-delay="0s"><a href="/book/user/search_result?advanced_category=B0102">취업</a></li>
					<li class="wow fadeInDown" data-wow-delay="0.1s"><a href="#">도서신청</a></li>
				</ul>
			</div>
		</div>
	</nav>

	<div class="search-form wow pulse" data-wow-delay="0.8s"
		style="text-align: center; margin: 15px">
		<span>통합검색</span>
		<input type="text" class="" id="searchTextField" size="40"> <input
			type="submit" class="navbar-btn nav-button login" value="Search">
		<span><a id="advanced_search" class="advanced_search"
			style="color: black; font-size: 13px;">세부검색</a></span>
		<div id="advanced_box" style="display: none;">
			<form action="/book/user/search_result" method="get">
				<table style="width: 500px; margin: auto;">
					<tr>
						<td>제목</td>
						<td><input type="text" id="advanced_title" name="advanced_title" size="46"></td>
					</tr>
					<tr>
						<td>저자</td>
						<td><input type="text" id="advanced_author" name="advanced_author" size="46"></td>
					</tr>
					<tr>
						<td>출판사</td>
						<td><input type="text" id="advanced_publisher" name="advanced_publisher" size="46"></td>
					</tr>
					<tr>
						<td>출판일</td>
						<td><input type="text" id="advanced_start_date" name="advanced_start_date" size="20">
							~ <input type="text" id="advanced_end_date" name="advanced_end_date" size="20"></td>
					</tr>
					<tr>
						<td>ISBN</td>
						<td><input type="text" id="advanced_isbn" name="advanced_isbn" size="46"></td>
					</tr>
					<tr>
						<td>분류</td>
						<td><select id="advanced_category" name="advanced_category" style="width: 389px;">
							<option id="advanced_none" value="">선택</option>
							<option id="advanced_it" value="B0100">IT</option>
							<option id="advanced_jp" value="B0101">일본어</option>
							<option id="advanced_emp" value="B0102">취업</option>
						</select></td>
					</tr>
					<tr>
						<td></td>
						<td style="text-align: end;"><input type="submit"
							id="advanced_submit" value="검색"> <input type="button"
							id="advanced_cancel" value="취소"></td>
					</tr>
				</table>
			</form>
		</div>
	</div>
	
	<div style="padding-left:100px;padding-right:100px;">
		<div class="row fh5co-post-entry">
			<c:forEach var="result" items="${search_result}">
			    <article class="col-lg-2 col-md-2 col-sm-2 col-xs-6 col-xxs-12 animate-box">
					<figure>
						<a href="#"><img onload="resizeImg(this, 170, 130);" alt="" 
						src="/book/utility/download_bookinfo_image?origin=${result.BOARD_FILE_ORIGIN }&saved=${result.BOARD_FILE_SAVED }"></a>
					</figure>
					<span class="fh5co-meta">
						<a href="#">${result.BOOKINFO_CATEGORY }</a>
						, <a href="#">${result.BOOKINFO_DIVISION }</a>
					</span>
					<h5 class="fh5co-article-title" style="margin-top:5px;margin-bottom:5px;">
						<a href="#">${result.BOOKINFO_BOOK_NM }</a>
					</h5>
					<span class="fh5co-meta">${result.BOOKINFO_AUTHOR } | ${result.BOOKINFO_PUBLISHER }</span>
				</article>             
			</c:forEach>
			<c:forEach var="result" items="${search_result}">
			    <article class="col-lg-2 col-md-2 col-sm-2 col-xs-6 col-xxs-12 animate-box">
					<figure>
						<a href="#"><img onload="resizeImg(this, 170, 130);" alt="" 
						src="/book/utility/download_bookinfo_image?origin=${result.BOARD_FILE_ORIGIN }&saved=${result.BOARD_FILE_SAVED }"></a>
					</figure>
					<span class="fh5co-meta">
						<a href="#">${result.BOOKINFO_CATEGORY }</a>
						, <a href="#">${result.BOOKINFO_DIVISION }</a>
					</span>
					<h5 class="fh5co-article-title" style="margin-top:5px;margin-bottom:5px;">
						<a href="#">${result.BOOKINFO_BOOK_NM }</a>
					</h5>
					<span class="fh5co-meta">${result.BOOKINFO_AUTHOR } | ${result.BOOKINFO_PUBLISHER }</span>
				</article>             
			</c:forEach>
			<c:forEach var="result" items="${search_result}">
			    <article class="col-lg-2 col-md-2 col-sm-2 col-xs-6 col-xxs-12 animate-box">
					<figure>
						<a href="#"><img onload="resizeImg(this, 170, 130);" alt="" 
						src="/book/utility/download_bookinfo_image?origin=${result.BOARD_FILE_ORIGIN }&saved=${result.BOARD_FILE_SAVED }"></a>
					</figure>
					<span class="fh5co-meta">
						<a href="#">${result.BOOKINFO_CATEGORY }</a>
						, <a href="#">${result.BOOKINFO_DIVISION }</a>
					</span>
					<h5 class="fh5co-article-title" style="margin-top:5px;margin-bottom:5px;">
						<a href="#">${result.BOOKINFO_BOOK_NM }</a>
					</h5>
					<span class="fh5co-meta">${result.BOOKINFO_AUTHOR } | ${result.BOOKINFO_PUBLISHER }</span>
				</article>             
			</c:forEach>
			<c:forEach var="result" items="${search_result}">
			    <article class="col-lg-2 col-md-2 col-sm-2 col-xs-6 col-xxs-12 animate-box">
					<figure>
						<a href="#"><img onload="resizeImg(this, 170, 130);" alt="" 
						src="/book/utility/download_bookinfo_image?origin=${result.BOARD_FILE_ORIGIN }&saved=${result.BOARD_FILE_SAVED }"></a>
					</figure>
					<span class="fh5co-meta">
						<a href="#">${result.BOOKINFO_CATEGORY }</a>
						, <a href="#">${result.BOOKINFO_DIVISION }</a>
					</span>
					<h5 class="fh5co-article-title" style="margin-top:5px;margin-bottom:5px;">
						<a href="#">${result.BOOKINFO_BOOK_NM }</a>
					</h5>
					<span class="fh5co-meta">${result.BOOKINFO_AUTHOR } | ${result.BOOKINFO_PUBLISHER }</span>
				</article>             
			</c:forEach>
			<c:forEach var="result" items="${search_result}">
			    <article class="col-lg-2 col-md-2 col-sm-2 col-xs-6 col-xxs-12 animate-box">
					<figure>
						<a href="#"><img onload="resizeImg(this, 170, 130);" alt="" 
						src="/book/utility/download_bookinfo_image?origin=${result.BOARD_FILE_ORIGIN }&saved=${result.BOARD_FILE_SAVED }"></a>
					</figure>
					<span class="fh5co-meta">
						<a href="#">${result.BOOKINFO_CATEGORY }</a>
						, <a href="#">${result.BOOKINFO_DIVISION }</a>
					</span>
					<h5 class="fh5co-article-title" style="margin-top:5px;margin-bottom:5px;">
						<a href="#">${result.BOOKINFO_BOOK_NM }</a>
					</h5>
					<span class="fh5co-meta">${result.BOOKINFO_AUTHOR } | ${result.BOOKINFO_PUBLISHER }</span>
				</article>             
			</c:forEach>
			<c:forEach var="result" items="${search_result}">
			    <article class="col-lg-2 col-md-2 col-sm-2 col-xs-6 col-xxs-12 animate-box">
					<figure>
						<a href="#"><img onload="resizeImg(this, 170, 130);" alt="" 
						src="/book/utility/download_bookinfo_image?origin=${result.BOARD_FILE_ORIGIN }&saved=${result.BOARD_FILE_SAVED }"></a>
					</figure>
					<span class="fh5co-meta">
						<a href="#">${result.BOOKINFO_CATEGORY }</a>
						, <a href="#">${result.BOOKINFO_DIVISION }</a>
					</span>
					<h5 class="fh5co-article-title" style="margin-top:5px;margin-bottom:5px;">
						<a href="#">${result.BOOKINFO_BOOK_NM }</a>
					</h5>
					<span class="fh5co-meta">${result.BOOKINFO_AUTHOR } | ${result.BOOKINFO_PUBLISHER }</span>
				</article>             
			</c:forEach>
			<c:forEach var="result" items="${search_result}">
			    <article class="col-lg-2 col-md-2 col-sm-2 col-xs-6 col-xxs-12 animate-box">
					<figure>
						<a href="#"><img onload="resizeImg(this, 170, 130);" alt="" 
						src="/book/utility/download_bookinfo_image?origin=${result.BOARD_FILE_ORIGIN }&saved=${result.BOARD_FILE_SAVED }"></a>
					</figure>
					<span class="fh5co-meta">
						<a href="#">${result.BOOKINFO_CATEGORY }</a>
						, <a href="#">${result.BOOKINFO_DIVISION }</a>
					</span>
					<h5 class="fh5co-article-title" style="margin-top:5px;margin-bottom:5px;">
						<a href="#">${result.BOOKINFO_BOOK_NM }</a>
					</h5>
					<span class="fh5co-meta">${result.BOOKINFO_AUTHOR } | ${result.BOOKINFO_PUBLISHER }</span>
				</article>             
			</c:forEach>
			<c:forEach var="result" items="${search_result}">
			    <article class="col-lg-2 col-md-2 col-sm-2 col-xs-6 col-xxs-12 animate-box">
					<figure>
						<a href="#"><img onload="resizeImg(this, 170, 130);" alt="" 
						src="/book/utility/download_bookinfo_image?origin=${result.BOARD_FILE_ORIGIN }&saved=${result.BOARD_FILE_SAVED }"></a>
					</figure>
					<span class="fh5co-meta">
						<a href="#">${result.BOOKINFO_CATEGORY }</a>
						, <a href="#">${result.BOOKINFO_DIVISION }</a>
					</span>
					<h5 class="fh5co-article-title" style="margin-top:5px;margin-bottom:5px;">
						<a href="#">${result.BOOKINFO_BOOK_NM }</a>
					</h5>
					<span class="fh5co-meta">${result.BOOKINFO_AUTHOR } | ${result.BOOKINFO_PUBLISHER }</span>
				</article>             
			</c:forEach>
			<c:forEach var="result" items="${search_result}">
			    <article class="col-lg-2 col-md-2 col-sm-2 col-xs-6 col-xxs-12 animate-box">
					<figure>
						<a href="#"><img onload="resizeImg(this, 170, 130);" alt="" 
						src="/book/utility/download_bookinfo_image?origin=${result.BOARD_FILE_ORIGIN }&saved=${result.BOARD_FILE_SAVED }"></a>
					</figure>
					<span class="fh5co-meta">
						<a href="#">${result.BOOKINFO_CATEGORY }</a>
						, <a href="#">${result.BOOKINFO_DIVISION }</a>
					</span>
					<h5 class="fh5co-article-title" style="margin-top:5px;margin-bottom:5px;">
						<a href="#">${result.BOOKINFO_BOOK_NM }</a>
					</h5>
					<span class="fh5co-meta">${result.BOOKINFO_AUTHOR } | ${result.BOOKINFO_PUBLISHER }</span>
				</article>             
			</c:forEach>
			<c:forEach var="result" items="${search_result}">
			    <article class="col-lg-2 col-md-2 col-sm-2 col-xs-6 col-xxs-12 animate-box">
					<figure>
						<a href="#"><img onload="resizeImg(this, 170, 130);" alt="" 
						src="/book/utility/download_bookinfo_image?origin=${result.BOARD_FILE_ORIGIN }&saved=${result.BOARD_FILE_SAVED }"></a>
					</figure>
					<span class="fh5co-meta">
						<a href="#">${result.BOOKINFO_CATEGORY }</a>
						, <a href="#">${result.BOOKINFO_DIVISION }</a>
					</span>
					<h5 class="fh5co-article-title" style="margin-top:5px;margin-bottom:5px;">
						<a href="#">${result.BOOKINFO_BOOK_NM }</a>
					</h5>
					<span class="fh5co-meta">${result.BOOKINFO_AUTHOR } | ${result.BOOKINFO_PUBLISHER }</span>
				</article>             
			</c:forEach>
			<c:forEach var="result" items="${search_result}">
			    <article class="col-lg-2 col-md-2 col-sm-2 col-xs-6 col-xxs-12 animate-box">
					<figure>
						<a href="#"><img onload="resizeImg(this, 170, 130);" alt="" 
						src="/book/utility/download_bookinfo_image?origin=${result.BOARD_FILE_ORIGIN }&saved=${result.BOARD_FILE_SAVED }"></a>
					</figure>
					<span class="fh5co-meta">
						<a href="#">${result.BOOKINFO_CATEGORY }</a>
						, <a href="#">${result.BOOKINFO_DIVISION }</a>
					</span>
					<h5 class="fh5co-article-title" style="margin-top:5px;margin-bottom:5px;">
						<a href="#">${result.BOOKINFO_BOOK_NM }</a>
					</h5>
					<span class="fh5co-meta">${result.BOOKINFO_AUTHOR } | ${result.BOOKINFO_PUBLISHER }</span>
				</article>             
			</c:forEach>
			<c:forEach var="result" items="${search_result}">
			    <article class="col-lg-2 col-md-2 col-sm-2 col-xs-6 col-xxs-12 animate-box">
					<figure>
						<a href="#"><img onload="resizeImg(this, 170, 130);" alt="" 
						src="/book/utility/download_bookinfo_image?origin=${result.BOARD_FILE_ORIGIN }&saved=${result.BOARD_FILE_SAVED }"></a>
					</figure>
					<span class="fh5co-meta">
						<a href="#">${result.BOOKINFO_CATEGORY }</a>
						, <a href="#">${result.BOOKINFO_DIVISION }</a>
					</span>
					<h5 class="fh5co-article-title" style="margin-top:5px;margin-bottom:5px;">
						<a href="#">${result.BOOKINFO_BOOK_NM }</a>
					</h5>
					<span class="fh5co-meta">${result.BOOKINFO_AUTHOR } | ${result.BOOKINFO_PUBLISHER }</span>
				</article>             
			</c:forEach>
			<c:forEach var="result" items="${search_result}">
			    <article class="col-lg-2 col-md-2 col-sm-2 col-xs-6 col-xxs-12 animate-box">
					<figure>
						<a href="#"><img onload="resizeImg(this, 170, 130);" alt="" 
						src="/book/utility/download_bookinfo_image?origin=${result.BOARD_FILE_ORIGIN }&saved=${result.BOARD_FILE_SAVED }"></a>
					</figure>
					<span class="fh5co-meta">
						<a href="#">${result.BOOKINFO_CATEGORY }</a>
						, <a href="#">${result.BOOKINFO_DIVISION }</a>
					</span>
					<h5 class="fh5co-article-title" style="margin-top:5px;margin-bottom:5px;">
						<a href="#">${result.BOOKINFO_BOOK_NM }</a>
					</h5>
					<span class="fh5co-meta">${result.BOOKINFO_AUTHOR } | ${result.BOOKINFO_PUBLISHER }</span>
				</article>             
			</c:forEach>
			<c:forEach var="result" items="${search_result}">
			    <article class="col-lg-2 col-md-2 col-sm-2 col-xs-6 col-xxs-12 animate-box">
					<figure>
						<a href="#"><img onload="resizeImg(this, 170, 130);" alt="" 
						src="/book/utility/download_bookinfo_image?origin=${result.BOARD_FILE_ORIGIN }&saved=${result.BOARD_FILE_SAVED }"></a>
					</figure>
					<span class="fh5co-meta">
						<a href="#">${result.BOOKINFO_CATEGORY }</a>
						, <a href="#">${result.BOOKINFO_DIVISION }</a>
					</span>
					<h5 class="fh5co-article-title" style="margin-top:5px;margin-bottom:5px;">
						<a href="#">${result.BOOKINFO_BOOK_NM }</a>
					</h5>
					<span class="fh5co-meta">${result.BOOKINFO_AUTHOR } | ${result.BOOKINFO_PUBLISHER }</span>
				</article>             
			</c:forEach>
			<c:forEach var="result" items="${search_result}">
			    <article class="col-lg-2 col-md-2 col-sm-2 col-xs-6 col-xxs-12 animate-box">
					<figure>
						<a href="#"><img onload="resizeImg(this, 170, 130);" alt="" 
						src="/book/utility/download_bookinfo_image?origin=${result.BOARD_FILE_ORIGIN }&saved=${result.BOARD_FILE_SAVED }"></a>
					</figure>
					<span class="fh5co-meta">
						<a href="#">${result.BOOKINFO_CATEGORY }</a>
						, <a href="#">${result.BOOKINFO_DIVISION }</a>
					</span>
					<h5 class="fh5co-article-title" style="margin-top:5px;margin-bottom:5px;">
						<a href="#">${result.BOOKINFO_BOOK_NM }</a>
					</h5>
					<span class="fh5co-meta">${result.BOOKINFO_AUTHOR } | ${result.BOOKINFO_PUBLISHER }</span>
				</article>             
			</c:forEach>
			<c:forEach var="result" items="${search_result}">
			    <article class="col-lg-2 col-md-2 col-sm-2 col-xs-6 col-xxs-12 animate-box">
					<figure>
						<a href="#"><img onload="resizeImg(this, 170, 130);" alt="" 
						src="/book/utility/download_bookinfo_image?origin=${result.BOARD_FILE_ORIGIN }&saved=${result.BOARD_FILE_SAVED }"></a>
					</figure>
					<span class="fh5co-meta">
						<a href="#">${result.BOOKINFO_CATEGORY }</a>
						, <a href="#">${result.BOOKINFO_DIVISION }</a>
					</span>
					<h5 class="fh5co-article-title" style="margin-top:5px;margin-bottom:5px;">
						<a href="#">${result.BOOKINFO_BOOK_NM }</a>
					</h5>
					<span class="fh5co-meta">${result.BOOKINFO_AUTHOR } | ${result.BOOKINFO_PUBLISHER }</span>
				</article>             
			</c:forEach>
		</div>
	</div>
</body>
</html>


<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<title>USER_BOOKMARK</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="list of bookmark" />
<meta name="keywords" content="SES Library, user, bookmark" />
<meta name="author" content="이정식" />

<!-- Place favicon.ico and apple-touch-icon.png in the root directory -->
<link rel="shortcut icon" href="favicon.ico">
<!-- Google Fonts -->
<!-- <link href='http://fonts.googleapis.com/css?family=Playfair+Display:400,700,400italic|Roboto:400,300,700' rel='stylesheet' type='text/css'> -->
<!-- Animate -->
<link rel="stylesheet" href="<c:url value='/resources/segroup/school/book/user/css/animate.css'/>">
<!-- Icomoon -->
<link rel="stylesheet" href="<c:url value='/resources/segroup/school/book/user/css/icomoon.css'/>">
<!-- Bootstrap  -->
<link rel="stylesheet" href="<c:url value='/resources/segroup/school/book/user/css/bootstrap.css'/>">
<link rel="stylesheet" href="<c:url value='/resources/segroup/school/book/user/css/style.css'/>">
<!-- Modernizr JS -->
<script src="<c:url value='/resources/segroup/school/book/user/js/modernizr-2.6.2.min.js'/>"></script>
</head>

<body>
	<div id="fh5co-offcanvas">
		<a href="#" class="fh5co-close-offcanvas js-fh5co-close-offcanvas"><span><i class="icon-cross3"></i> <span>Close</span></span></a>
		<div class="fh5co-bio">
			<h3 class="heading">User heading</h3>
			<h2>User</h2>
		</div>
		<div class="fh5co-menu">
			<div class="fh5co-box">
				<h3 class="heading">마이 페이지</h3>
				<ul>
					<li><a href="#">대여 현황</a></li>
					<li><a href="#">관심 도서</a></li>
					<li><a href="#">내 대여 기록</a></li>
					<li><a href="#">내 글 찾기</a></li>
				</ul>
			</div>
		</div>
	</div>
	<!-- END #fh5co-offcanvas -->
	
	
	<header id="fh5co-header">
		<div class="container-fluid">
			<div class="row">
				<a href="#" class="js-fh5co-nav-toggle fh5co-nav-toggle"><i></i></a>
				<div class="col-lg-12 col-md-12 text-center">
					<h1 id="fh5co-logo">관심 도서</h1>
				</div>
			</div>
		</div>
	</header>
	<!-- END #fh5co-header -->
		
	<div class="container-fluid">
		<div class="row fh5co-post-entry">
		
		
		<c:forEach items="${bookmarkList}" var="bookmarkedBook">
		
			<article class="col-lg-3 col-md-3 col-sm-3 col-xs-6 col-xxs-12 animate-box">
				<figure>
					<a href="#"><img src="http://via.placeholder.com/700x974" alt="Image" class="img-responsive"></a>
				</figure>
				<span class="fh5co-meta"><a href="#">${bookmarkedBook.bookinfo_category }</a>, <a href="#">${bookmarkedBook.bookinfo_division }</a></span>
				<h2 class="fh5co-article-title"><a href="#">${bookmarkedBook.bookinfo_book_nm }</a></h2>
				<span class="fh5co-meta fh5co-date">${bookmarkedBook.bookinfo_author } | ${bookmarkedBook.bookinfo_publisher }</span>
				<input type="button" class="btn-info btn-outline" value="대여" />
				<input type="button" class="btn-success btn-outline" value="예약" />
				<input type="button" class="btn-danger btn-outline" value="삭제" />
			</article>
			
		</c:forEach>

		</div>
	</div>

	<footer id="fh5co-footer">
		<p><small>&copy; 2016. Magazine Free HTML5. All Rights Reserverd. <br> Designed by <a href="http://freehtml5.co" target="_blank">FREEHTML5.co</a>  Demo Images: <a href="http://unsplash.com/" target="_blank">Unsplash</a></small></p>
	</footer>

	<!-- jQuery -->
	<script src="<c:url value='/resources/segroup/school/book/user/js/jquery.min.js'/>" ></script>
	<!-- jQuery Easing -->
	<script src="<c:url value='/resources/segroup/school/book/user/js/jquery.easing.1.3.js'/>"></script>
	<!-- Bootstrap -->
	<script src="<c:url value='/resources/segroup/school/book/user/js/bootstrap.min.js'/>"></script>
	<!-- Waypoints -->
	<script src="<c:url value='/resources/segroup/school/book/user/js/jquery.waypoints.min.js'/>"></script>
	<!-- Main JS -->
	<script src="<c:url value='/resources/segroup/school/book/user/js/main.js'/>"></script>

	</body>
</html>
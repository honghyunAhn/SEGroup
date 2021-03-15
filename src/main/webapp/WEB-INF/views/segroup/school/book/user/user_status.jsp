<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<title>USER_STATUS</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="my book list now" />
<meta name="keywords" content="SES Library, user, book list, now" />

<!-- jQuery -->
<script src="<c:url value='/resources/segroup/school/book/user/js/jquery.min.js'/>"></script>
<!-- jQuery Easing -->
<script src="<c:url value='/resources/segroup/school/book/user/js/jquery.easing.1.3.js'/>"></script>
<!-- Bootstrap -->
<script src="<c:url value='/resources/segroup/school/book/user/js/bootstrap.min.js'/>"></script>
<!-- Waypoints -->
<script src="<c:url value='/resources/segroup/school/book/user/js/jquery.waypoints.min.js'/>"></script>
<!-- Main JS -->
<script src="<c:url value='/resources/segroup/school/book/user/js/main.js'/>"></script>
<!-- Angular JS -->
<script src="<c:url value="/resources/segroup/js/angular.min.js" />"></script>

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
<link rel="stylesheet" href="/resources/segroup/school/book/user/css/style2.css">
<link rel="stylesheet" href="/resources/segroup/school/book/user/css/normalize.css">
<link rel="stylesheet" href="/resources/segroup/school/book/user/css/responsive.css">
<!-- Modernizr JS -->
<script src="<c:url value='/resources/segroup/school/book/user/js/modernizr-2.6.2.min.js'/>"></script>
<script type="text/javascript">
$(function() {
	//로그아웃 처리
	$('#logout').click(function() {
        $('#logoutForm').submit();
        return false;
    });
});
</script>
</head>

<body>
	<!-- 메뉴부분 -->
	<%@include file="user_menu.jsp"%>
	<!-- END #fh5co-offcanvas -->
	
	<header id="fh5co-header">
		<div class="container-fluid">
			<div class="row">
				<div class="col-lg-12 col-md-12 text-center">
					<h1 id="fh5co-logo">대여 현황</h1>
				</div>
			</div>
		</div>
	</header>
	<!-- END #fh5co-header -->
	
	<!-- 연체 -->
	<div class="container-fluid">
		<div class="col-lg-12 col-md-12">
			<h1>연체</h1>
		</div>
	</div>
	
	<div class="container-fluid">
		<div class="row fh5co-post-entry">	
		
	<c:forEach items="${delayList}" var="delayedBook">
			<article class="col-lg-3 col-md-3 col-sm-3 col-xs-6 col-xxs-12 animate-box">
				<figure>
					<a href="#"><img src="http://via.placeholder.com/700x974" alt="Image" class="img-responsive"></a>
				</figure>
				<span class="fh5co-meta"><a href="#">${delayedBook.bookinfo_category}</a>, <a href="#">${delayedBook.bookinfo_division }</a></span>
				<h2 class="fh5co-article-title"><a href="#">${delayedBook.bookinfo_book_nm}</a></h2>
				<span class="fh5co-meta fh5co-date">${delayedBook.bookinfo_author} |${delayedBook.bookinfo_publisher} </span>
			</article>
    </c:forEach>

<!-- 			<div class="clearfix visible-lg-block visible-md-block visible-sm-block visible-xs-block"></div> -->
		</div>
	</div>
	
	<!-- 대여 -->
	<div class="container-fluid">
		<div class="col-lg-12 col-md-12">
			<h1>대여</h1>
		</div>
	</div>
	
	<div class="container-fluid">
		<div class="row fh5co-post-entry">
		
	<c:forEach items="${rentList}" var="rentedBook">
		<article class="col-lg-3 col-md-3 col-sm-3 col-xs-6 col-xxs-12 animate-box">
			<figure>
				<a href="#"><img src="http://via.placeholder.com/700x974" alt="Image" class="img-responsive"></a>
			</figure>
			<span class="fh5co-meta"><a href="#">${rentedBook.bookinfo_category}</a>, <a href="#">${rentedBook.bookinfo_division }</a></span>
			<h2 class="fh5co-article-title"><a href="#">${rentedBook.bookinfo_book_nm}</a></h2>
			<span class="fh5co-meta fh5co-date">${rentedBook.bookinfo_author} |${rentedBook.bookinfo_publisher} </span>
		</article>
    </c:forEach>

		</div>
	</div>

	<!-- 예약 -->
	<div class="container-fluid">
		<div class="col-lg-12 col-md-12">
			<h1>예약</h1>
		</div>
	</div>
	
	<div class="container-fluid">
		<div class="row fh5co-post-entry">			
		
	<c:forEach items="${reserveList}" var="reservedBook">
		<article class="col-lg-3 col-md-3 col-sm-3 col-xs-6 col-xxs-12 animate-box">
			<figure>
				<a href="#"><img src="http://via.placeholder.com/700x974" alt="Image" class="img-responsive"></a>
			</figure>
			<span class="fh5co-meta"><a href="#">${reservedBook.bookinfo_category}</a>, <a href="#">${reservedBook.bookinfo_division }</a></span>
			<h2 class="fh5co-article-title"><a href="#">${reservedBook.bookinfo_book_nm}</a></h2>
			<span class="fh5co-meta fh5co-date">${reservedBook.bookinfo_author} |${reservedBook.bookinfo_publisher} </span>
		</article>
    </c:forEach>
    
		</div>
	</div>

	<form id="logoutForm" action="/book/user/logout" method="post" style="display:none">
	    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
	</form>
	</body>
</html>
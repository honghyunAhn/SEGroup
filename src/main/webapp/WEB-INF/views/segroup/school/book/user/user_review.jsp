<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<title>USER_REVIEW</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="review" />
<meta name="keywords" content="SES Library, user, review" />
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

<script>
function deleteReview() {
	
}
</script>
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
					<h1 id="fh5co-logo">내 글 보기</h1>
				</div>
			</div>
		</div>
	</header>
	<!-- END #fh5co-header -->
		
	<div class="container">
		<table class="table table-hover text-center">	
			<tr>
				<th><div class="text-center">board_content_seq</div></th>
				<th><div class="text-center">review_id</div></th>
				<th><div class="text-center">bookinfo_isbn</div></th>
				<th><div class="text-center">review_contents</div></th>
				<th><div class="text-center">review_score</div></th>
				<!-- <th><div class="text-center">review_isdeleted</div></th> -->
				<th><div class="text-center">review_ins_dt</div></th>
				<th><div class="text-center">review_udt_dt</div></th>
				<th><div class="text-center">delete</th>
			</tr>
			<c:if test="${reviewList eq null }">
			<tr>
				<td colspan="9">Nothing!</td>
			</tr>
			</c:if>
		
			<c:forEach items="${reviewList}" var="review">
			<tr>
				<td>${review.board_content_seq }</td>
				<td>${review.review_id }</td>
				<td>${review.bookinfo_isbn }</td>
				<td>${review.review_contents }</td>
				<td>${review.review_score }</td>
				<%-- <td>${review.review_isdeleted }</td> --%>
				<td>${review.review_ins_dt }</td>
				<td>${review.review_udt_dt }</td>
				<td>
					<input type="button" class="btn btn-default" onClick="return deleteReview('');" value="delete" />
				</td>
			</tr>
			</c:forEach>
		</table>
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
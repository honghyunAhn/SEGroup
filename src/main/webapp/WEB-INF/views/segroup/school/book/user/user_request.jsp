<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>USER_REQUEST</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="book request" />
<meta name="keywords" content="SES Library, user, book request" />
<meta name="author" content="이정식" />

<!-- Place favicon.ico and apple-touch-icon.png in the root directory -->
<link rel="shortcut icon" href="favicon.ico">
<!-- Google Fonts -->
<!-- <link
	href='http://fonts.googleapis.com/css?family=Playfair+Display:400,700,400italic|Roboto:400,300,700'
	rel='stylesheet' type='text/css'> -->
<!-- Animate -->
<link rel="stylesheet"
	href="<c:url value='/resources/segroup/school/book/user/css/animate.css'/>">
<!-- Icomoon -->
<link rel="stylesheet"
	href="<c:url value='/resources/segroup/school/book/user/css/icomoon.css'/>">
<!-- Bootstrap  -->
<link rel="stylesheet"
	href="<c:url value='/resources/segroup/school/book/user/css/bootstrap.css'/>">
<link rel="stylesheet"
	href="<c:url value='/resources/segroup/school/book/user/css/style.css'/>">
<!-- Modernizr JS -->
<script
	src="<c:url value='/resources/segroup/school/book/user/js/modernizr-2.6.2.min.js'/>"></script>

<script>
function searchISBNOpen() {
	window.open("/book/utility/searchIsbn","searchISBN", "top=100, left=100, width=800, height=500");
}

function formCheck() {
	var nm = document.getElementById('purchase_req_book_nm').value;
	var author = document.getElementById('purchase_req_author').value;
	var publisher = document.getElementById('purchase_req_publisher').value;
	var isbn = document.getElementById('purchase_req_isbn').value;
	var reason = document.getElementById('purchase_req_reason').value;
		
	if (nm.length < 1 || author.length<1 || publisher.length<1 || isbn.length<1) {
		alert('ISBN 검색하세요');
		return false;
	}
	if (reason.length<1) {
		alert('이유를 입력하세요');
		return false;
	}
	return true;
}
</script>
</head>

<body>
	<div id="fh5co-offcanvas">
		<a href="#" class="fh5co-close-offcanvas js-fh5co-close-offcanvas"><span><i
				class="icon-cross3"></i> <span>Close</span></span></a>
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
					<h1 id="fh5co-logo">도서 신청</h1>
				</div>
			</div>
		</div>
	</header>
	<!-- END #fh5co-header -->

	<div class="container-fluid">
		<div class="row fh5co-post-entry">
			<article class="col-lg-3 col-md-3 col-sm-3 col-xs-6 col-xxs-12 text-center">

				<div class="container">
					<h2>USER_REQUEST</h2>
					<form class="form-horizontal" action="/book/user/user_request" method="post">

						<%-- <div class="form-group">
							<label class="control-label col-sm-2" for="user_id">User id</label>
							<div class="col-sm-10">
						        <p class="form-control-static" name="purchase_req_id">${user_id }</p>
      						</div>
						</div> --%>
						
						<input type="hidden" name="purchase_req_id" value="${user_id }" />

						<div class="form-group">
							<label class="control-label col-sm-2" for="title">Title</label>
							<div class="col-sm-8">
								<input type="text" class="form-control" id="purchase_req_book_nm"
									placeholder="isbn 검색 버튼 눌르세용~" name="purchase_req_book_nm" readonly />
							</div>
							<div class="col-sm-2">
								<button class="btn btn-default form-control" onClick="searchISBNOpen(); return false;">ISBN 검색</button>
							</div>
						</div>
 	
						<div class="form-group">
							<label class="control-label col-sm-2" for="author">Author</label>
							<div class="col-sm-8">
								<input type="text" class="form-control" id="purchase_req_author"
									name="purchase_req_author" readonly />
							</div>
						</div>
						
						<div class="form-group">
							<label class="control-label col-sm-2" for="publisher">Publisher</label>
							<div class="col-sm-8">
								<input type="text" class="form-control" id="purchase_req_publisher"
									name="purchase_req_publisher" readonly />
							</div>
						</div>
						
						<div class="form-group">
							<label class="control-label col-sm-2" for="isbn">ISBN</label>
							<div class="col-sm-8">
								<input type="text" class="form-control" id="purchase_req_isbn"
									name="purchase_req_isbn" readonly />
							</div>
						</div>

						<div class="form-group">
							<label class="control-label col-sm-2" for="reason">Reason</label>
							<div class="col-sm-8">
								<textarea class="form-control" name="purchase_req_reason" rows="4" id="purchase_req_reason"></textarea>
							</div>
						</div>

						<div class="form-group">
 							<div class="col-sm-offset-5 col-sm-2">
								<input type="submit" class="btn btn-default form-control" onClick="return formCheck();" />
							</div>
						</div>
						
					</form>
				</div>

			</article>
		</div>
	</div>

	<footer id="fh5co-footer">
		<p>
			<small>&copy; 2016. Magazine Free HTML5. All Rights
				Reserverd. <br> Designed by <a href="http://freehtml5.co"
				target="_blank">FREEHTML5.co</a> Demo Images: <a
				href="http://unsplash.com/" target="_blank">Unsplash</a>
			</small>
		</p>
	</footer>

	<!-- jQuery -->
	<script
		src="<c:url value='/resources/segroup/school/book/user/js/jquery.min.js'/>"></script>
	<!-- jQuery Easing -->
	<script
		src="<c:url value='/resources/segroup/school/book/user/js/jquery.easing.1.3.js'/>"></script>
	<!-- Bootstrap -->
	<script
		src="<c:url value='/resources/segroup/school/book/user/js/bootstrap.min.js'/>"></script>
	<!-- Waypoints -->
	<script
		src="<c:url value='/resources/segroup/school/book/user/js/jquery.waypoints.min.js'/>"></script>
	<!-- Main JS -->
	<script
		src="<c:url value='/resources/segroup/school/book/user/js/main.js'/>"></script>

</body>
</html>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />

<title>SES Library</title>

<meta
	content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0'
	name='viewport' />
<meta name="viewport" content="width=device-width" />


<!-- Bootstrap core CSS     -->
<link
	href="<c:url value='/resources/segroup/school/book/admin/css/bootstrap.min.css'/>"
	rel="stylesheet" />

<!-- Animation library for notifications   -->
<link
	href="<c:url value='/resources/segroup/school/book/admin/css/animate.min.css'/>"
	rel="stylesheet" />

<!--  Paper Dashboard core CSS    -->
<link
	href="<c:url value='/resources/segroup/school/book/admin/css/paper-dashboard.css'/>"
	rel="stylesheet" />


<!--  CSS for Demo Purpose, don't include it in your project     -->
<link
	href="<c:url value='/resources/segroup/school/book/admin/css/demo.css'/>"
	rel="stylesheet" />


<!--  Fonts and icons     -->
<link
	href="http://maxcdn.bootstrapcdn.com/font-awesome/latest/css/font-awesome.min.css"
	rel="stylesheet">
<link href='https://fonts.googleapis.com/css?family=Muli:400,300'
	rel='stylesheet' type='text/css'>
<link
	href="<c:url value='/resources/segroup/school/book/admin/css/themify-icons.css'/>"
	rel="stylesheet">


<!--  modal     -->
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<style>
#id01 input[type=text] {
	background-color: #fffcf5;
	color: #66615b;
	cursor: auto;
}
</style>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script>
	$(function() {

		$(".apply_btn").on('click', function() {
			var isbn = $(this).attr('isbn');
			
			$.ajax({
				type : "GET",
				url : "/getApplyInfo",
				data : {
					'isbn' : isbn
				},
				dataType : "json",
				error : function() {
					alert('통신실패!!');
				},
				success : function(data) {
					var output = '';
					book = '';
					
					$.each(data, function(index, val) {
						output += '<tr>'
						output += "<td>" + (index + 1) + "</td>";
						output += "<td>" + val.user_nm + "</td>";
						output += "<td>" + val.purchase_req_reason + "</td>";
						output += "<td>" + val.purchase_req_dt + "</td>";
						output += '</tr>'
						
						book = "<tr><td>" + val.purchase_req_book_nm + "</td>";
						book += "<td>" + val.purchase_req_author + "</td>";
						book += "<td>" + val.purchase_req_publisher + "</td>";
						book += "<td>" + val.purchase_req_isbn + "</td></tr>";
					});
					$('#apList').html(output);
					$('#bkInfo').html(book);
				}
			});
			$('#id01').css("display", "block");
		});
		
		$(".regist_btn").on('click', function(){
			var isbn = $(this).attr('isbn');
			
			$.ajax({
				type : "GET",
				url : "/등록하러보내자",
				data : {
					'isbn' : isbn
				},
				dataType : "json",
				error : function() {
					alert('통신실패!!');
				},
				success : function(data) {
				
				}
			});
		});
	});
</script>
</head>
<body>
	<!-- The Modal -->
	<div id="id01" class="w3-modal">
		<div class="w3-modal-content" style="background: transparent;">
			<div class="w3-container">
				<div class="card">
					<div class="header">
						<h4 class="title">도서 정보</h4>
					</div>
					<div class="content">
						<table class="table" style="margin-bottom: 0px;">
							<thead>
								<th>도서명</th>
								<th>저자</th>
								<th>출판사</th>
								<th>ISBN</th>
							</thead>
							<tbody id="bkInfo">

							</tbody>
						</table>
					</div>
				</div>
				<div class="card">
					<div class="header">
						<h4 class="title">신청자 정보</h4>
					</div>
					<div class="content">
						<table class="table" style="margin-bottom: 0px;">
							<thead>
								<th>ID</th>
								<th>신청자</th>
								<th>신청이유</th>
								<th>신청일</th>
							</thead>
							<tbody id="apList">

							</tbody>
							<thead>
								<th colspan="6" class="text-center"><button
										onclick="document.getElementById('id01').style.display='none'"
										class="btn btn-info btn-fill btn-wd">닫기</button></th>
							</thead>
						</table>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="wrapper">
		<div class="sidebar" data-background-color="white"
			data-active-color="danger">

			<!--
		Tip 1: you can change the color of the sidebar's background using: data-background-color="white | black"
		Tip 2: you can change the color of the active button using the data-active-color="primary | info | success | warning | danger"
	-->

			<div class="sidebar-wrapper">
				<div class="logo">
					<a href="http://www.creative-tim.com" class="simple-text"> SES
						Library<br>for Admin
					</a>
				</div>

				<ul class="nav">
					<li><a href="admin_main"> <i class="ti-home"></i>
							<p>홈</p>
					</a></li>
					<li><a href="status_manage"> <i class="ti-bookmark"></i>
							<p>대여 현황</p>
					</a></li>
					<li><a href="status_reserv"> <i class="ti-clip"></i>
							<p>예약 현황</p>
					</a></li>
					<hr>
					<li><a href="book_lend"> <i class="ti-bell"></i>
							<p>대여 신청</p>
					</a></li>
					<li><a href="admin_member"> <i class="ti-user"></i>
							<p>회원 관리</p>
					</a></li>
					<hr>
					<li><a href="book_list"> <i class="ti-view-list-alt"></i>
							<p>도서 관리</p>
					</a></li>

					<li class="active"><a href="book_apply"> <i
							class="ti-pencil-alt2"></i>
							<p>도서 신청 목록</p>
					</a></li>
					<li><a href="admin_subadmin"> <i class="ti-eye"></i>
							<p>부계정 관리</p>
					</a></li>
				</ul>
			</div>
		</div>

		<div class="main-panel">
			<nav class="navbar navbar-default">
			<div class="container-fluid">
				<div class="navbar-header">
					<button type="button" class="navbar-toggle">
						<span class="sr-only">Toggle navigation</span> <span
							class="icon-bar bar1"></span> <span class="icon-bar bar2"></span>
						<span class="icon-bar bar3"></span>
					</button>
					<a class="navbar-brand" href="#">관리자 페이지</a>
				</div>
				<div class="collapse navbar-collapse">
					<ul class="nav navbar-nav navbar-right">
						<li><a href="#" class="dropdown-toggle"
							data-toggle="dropdown"> <i class="ti-panel"></i>
								<p>Stats</p>
						</a></li>
						<li class="dropdown"><a href="#" class="dropdown-toggle"
							data-toggle="dropdown"> <i class="ti-bell"></i>
								<p class="notification">5</p>
								<p>Notifications</p> <b class="caret"></b>
						</a>
							<ul class="dropdown-menu">
								<li><a href="#">Notification 1</a></li>
								<li><a href="#">Notification 2</a></li>
								<li><a href="#">Notification 3</a></li>
								<li><a href="#">Notification 4</a></li>
								<li><a href="#">Another notification</a></li>
							</ul></li>
						<li><a href="admin_setting"> <i class="ti-settings"></i>
								<p>Settings</p>
						</a></li>
					</ul>

				</div>
			</div>
			</nav>

			<div class="content">
				<div class="container-fluid">
					<div class="row"></div>

					<div class="row">
						<div class="col-md-12">
							<div class="card">
								<div class="header">
									<h4 class="title">신규 도서 신청 현황</h4>
									<br>
								</div>
								<div class="content">
									<div class="card card-plain">
										<div class="content table-responsive table-full-width">
											<table class="table table-hover">
												<thead>
													<th>ID</th>
													<th>도서명</th>
													<th>저자</th>
													<th>출판사</th>
													<th>신청인원 수</th>
													<th>링크</th>
												</thead>
												<tbody>
													<c:forEach var="data" items="${applyList}"
														varStatus="status">
														<tr>
															<td>${ status.count }</td>
															<td>${ data.purchase_req_book_nm }</td>
															<td>${ data.purchase_req_author }</td>
															<td>${ data.purchase_req_publisher }</td>
															<td><button class="btn apply_btn"
																	isbn="${ data.purchase_req_isbn }">
																	<span class="ti-user"> ${ data.purchase_req_cnt }</span>
																</button></td>
															<td><input class="btn regist_btn" type="button"
																isbn="${ data.purchase_req_isbn }" value="바로등록"></td>
														</tr>
													</c:forEach>
												</tbody>
											</table>

										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<footer class="footer">
			<div class="container-fluid">
				<nav class="pull-left">
				<ul>
					<li><a href="../../../../client_main"> Client Site </a></li>
					<li><a href="http://job.sesoc.global/society/index"> SESOC
							GLOBAL JOB </a></li>
				</ul>
				</nav>
				<div class="copyright pull-right">
					&copy;
					<script>
						document.write(new Date().getFullYear())
					</script>
					, made with <i class="fa fa-heart heart"></i> by <a href="#">SR11</a>
				</div>
			</div>
			</footer>
		</div>
	</div>
</body>

<!--   Core JS Files   -->
<script
	src="<c:url value='/resources/segroup/school/book/admin/js/jquery-1.10.2.js'/>"
	type="text/javascript"></script>
<script
	src="<c:url value='/resources/segroup/school/book/admin/js/bootstrap.min.js'/>"
	type="text/javascript"></script>

<!--  Checkbox, Radio & Switch Plugins -->
<script
	src="<c:url value='/resources/segroup/school/book/admin/js/bootstrap-checkbox-radio.js'/>"></script>

<!--  Notifications Plugin    -->
<script
	src="<c:url value='/resources/segroup/school/book/admin/js/bootstrap-notify.js'/>"></script>

<!-- Paper Dashboard Core javascript and methods for Demo purpose -->
<script
	src="<c:url value='/resources/segroup/school/book/admin/js/paper-dashboard.js'/>"></script>
<!-- 
<script type="text/javascript">
	$(document)
			.ready(
					function() {

						demo.initChartist();

						$
								.notify(
										{
											icon : 'ti-gift',
											message : "Welcome to <b>Paper Dashboard</b> - a beautiful Bootstrap freebie for your next project."
										}, {
											type : 'success',
											timer : 4000
										});

					});
</script>
 -->
</html>

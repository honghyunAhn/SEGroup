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
</head>

<body>

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

					<li><a href="book_apply"> <i class="ti-pencil-alt2"></i>
							<p>도서 신청 목록</p>
					</a></li>
					<li class="active"><a href="admin_subadmin"> <i
							class="ti-eye"></i>
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
					<div class="row">
						<div class="col-md-6">
							<div class="card">
								<div class="header">
									<h4 class="title">부계정 관리</h4>
									<br>
									<div style="float: right;">
										<input type="button" name='osx'
											class="osx demo btn btn-info btn-fill btn-wd" value="계정 생성" />
									</div>
								</div>
								<div class="content">
									<table class="table table-hover">
										<thead>
											<th>ID</th>
											<th>담당학생</th>
											<th>최근 접속일</th>
											<th>금일 내역</th>
											<th>상세 보기</th>
										</thead>
										<tbody>
											<tr>
												<td>scm32_a3</td>
												<td>선희경</td>
												<td>2017.07.17</td>
												<td>15</td>
												<td><input type="button"
													class="btn btn-info btn-fill btn-simple" value="보기"></td>
											</tr>
											<tr>
												<td>scm32_c?</td>
												<td>서민수</td>
												<td>2017.07.16</td>
												<td>12</td>
												<td><input type="button"
													class="btn btn-info btn-fill btn-simple" value="보기"></td>
											</tr>
										</tbody>
									</table>
								</div>
							</div>
						</div>
						<div class="col-md-6">
							<div class="card">
								<div class="header">
									<h4 class="title">활동 로그</h4>
									<category>부관리자 scm32_a3의 활동 로그</category>
									<br>
								</div>
								<div class="content">
									<table class="table table-hover">
										<thead>
											<th>접속 날짜</th>
											<th>활동 시간</th>
											<th>활동 내용</th>
											<th>상세 내용</th>
										</thead>
										<tbody>
											<tr>
												<td>2017.07.17</td>
												<td>15:20:00</td>
												<td>반납처리</td>
												<td>000의 도서 반납처리</td>
											</tr>
											<tr>
												<td>2017.07.17</td>
												<td>15:19:00</td>
												<td>반납처리</td>
												<td>000의 도서 반납처리</td>
											</tr>
											<tr>
												<td>2017.07.17</td>
												<td>15:18:00</td>
												<td>반납처리</td>
												<td>000의 도서 반납처리</td>
											</tr>
											<tr>
												<td>2017.07.16</td>
												<td>15:22:00</td>
												<td>반납처리</td>
												<td>000의 도서 반납처리</td>
											</tr>
										</tbody>
									</table>
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
	<!-- <div id="osx-modal-content" class="card">
		<div class="header">
			<h4 class="title">부 관리자 계정 생성</h4>
			<br>
		</div>
		<div class="content">
			<form>
				<div class="row">
					<div class="col-md-6">
						<div class="form-group">
							<label>관리자 아이디</label> <input type="text"
								class="form-control border-input" placeholder="sub_admin_01">
						</div>
					</div>
					<div class="col-md-6">
						<div class="form-group">
							<label>비밀번호</label> <input type="password"
								class="form-control border-input" value="0000">
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-md-6">
						<div class="form-group">
							<label>담당자 아이디</label> <input type="text"
								class="form-control border-input" placeholder="scm32_a3">
						</div>
					</div>
					<div class="col-md-6">
						<div class="form-group">
							<label>연락처</label> <input type="text"
								class="form-control border-input" placeholder="010-1123-4567">
						</div>
					</div>
				</div>
				<div class="text-center">
					<button type="submit" class="btn btn-info btn-fill btn-wd">계정
						생성</button>
				</div>
				<div class="clearfix"></div>
			</form>
		</div>
	</div> -->

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

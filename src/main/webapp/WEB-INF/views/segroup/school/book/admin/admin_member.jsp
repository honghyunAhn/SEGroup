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

.w3-modal {
	padding-top: 75px;
}

.w3-modal-content {
	background: transparent;
	width: 100%
}

.stu_name {
	height: 40px;
	width: 90%;
}

.stu_title {
	padding: 20px;
	vertical-align: middle;
	display: flex;
}
</style>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script>
	$(function() {

		$(".modal_btn")
				.on(
						'click',
						function() {
							var this_id = $(this).attr('this_id');
							$
									.ajax({

										type : "GET",
										url : "/getStdMngInfo",
										data : {
											'this_id' : this_id
										},
										dataType : "json",
										error : function() {
											alert('통신실패!!');
										},
										success : function(data) {
											$('#stu_name').html(data.stu_nm);

											var output = '';
											$
													.each(
															data.myList,
															function(index, val) {
																output += '<tr>'
																output += "<td>"
																		+ (index + 1)
																		+ "</td>";
																output += "<td>"
																		+ val.bookinfo_book_nm
																		+ "</td>";
																output += "<td>"
																		+ val.rental_req_permit_dt
																		+ "</td>";
																output += "<td>"
																		+ val.rental_rtn_due_dt
																		+ "</td>";
																output += "<td>"
																		+ val.rental_rtn_state
																		+ "</td>";
																output += "<td><input class='btn rtn_proc' type='button' value='바로가기' rtn_seq='"+val.rental_seq+"'></td>";
																output += '</tr>'
															});
											$('#myList').html(output);

											$(".rtn_proc")
													.on(
															'click',
															function() {
																var rtn_seq = $(
																		this)
																		.attr(
																				'rtn_seq');
																window
																		.open(
																				'book_return?rtn_seq='
																						+ rtn_seq,
																				'반납 처리',
																				'width=700px, height=400px, menubar=no,location=no,toolbar=no');
															});
											output = '<tr>';
											output += "<td>"
													+ data.total
													+ "<span class='text-danger'>("
													+ data.overdue
													+ ")</span></td>";
											output += "<td>" + data.state0
													+ "</td>";
											output += "<td>" + data.state1
													+ "</td>";

											var totalPason = (data.state2 * 1
													+ data.state3 * 1
													+ data.state4 * 1
													+ data.state5 * 1 + data.state6 * 1);
											output += "<td>" + totalPason
													+ "</td>";
											output += '</tr>';
											$('#myRecord').html(output);

											output = '<tr>';
											output += "<td>" + data.state2
													+ "</td>";
											output += "<td>" + data.state3
													+ "</td>";
											output += "<td>" + data.state4
													+ "</td>";
											output += "<td>" + data.state5
													+ "</td>";
											output += "<td>" + data.state6
													+ "</td>";
											$('#pason').html(output);
										}
									});
							$('#id01').css("display", "block");
						});

		$(".search_btn")
				.on(
						'click',
						function() {
							var selectGisu = $('#selectGisu').val();
							var searchNm = $('#searchNm').val();

							$.ajax({

										type : "GET",
										url : "/stdList",
										data : {
											'gisu' : selectGisu,
											'name' : searchNm
										},
										dataType : "json",
										error : function() {
											alert('통신실패!!');
										},
										success : function(data) {
											var output = '';
											$
													.each(
															data,
															function(index, val) {
																output += "<tr><td>"
																		+ (index + 1)
																		+ "</td>";
																output += "<td>"
																		+ val.user_nm
																		+ "</td>";
																output += "<td>"
																		+ val.gisu_num
																		+ "</td>";
																output += "<td>"
																		+ val.user_flag
																		+ "</td>";
																output += "<td>"
																		+ val.user_sex
																		+ "</td>";
																output += "<td>"
																		+ val.user_phone
																		+ "</td>";
																output += "<td>"
																		+ val.user_email
																		+ "</td>";
																output += "<td><input class='btn modal_btn' type='button' value='보기' this_id='"+ val.user_id + "'></td></tr>";
															});
											$('#stdList').html(output);
										}
									});
						});
	});
</script>

</head>

<body>

	<!-- The Modal -->
	<div id="id01" class="w3-modal">
		<div class="w3-modal-content">
			<div class="w3-container">
				<div class="row">
					<div class="col-md-12">
						<div class="card">
							<div class="stu_title">
								<h3 class="stu_name">
									<span id="stu_name"></span> 학생
								</h3>
								<span style="float: right; margin: 10px 0;"><button
										onclick="document.getElementById('id01').style.display='none'"
										class="btn btn-info btn-fill btn-wd">닫기</button></span>
							</div>
						</div>
					</div>
					<div class="col-md-2"></div>
				</div>
				<div class="row">
					<div class="col-md-6">
						<div class="card">
							<div class="header">
								<h4 class="title">누적 대여 정보</h4>
							</div>
							<div class="content">
								<table class="table" style="margin-bottom: 0px;">
									<thead>
										<tr>
											<th rowspan="2">누적 도서(연체)</th>
											<th colspan="3">반납 처리</th>
										</tr>
										<tr>
											<th>정상</th>
											<th>분실</th>
											<th>파손</th>
										</tr>
									</thead>
									<tbody id="myRecord">
									</tbody>
								</table>
							</div>
							<div class="content">
								<table class="table" style="margin-bottom: 0px;">
									<thead>
										<tr>
											<th colspan="5">파손 정도</th>
										</tr>
										<tr>
											<th>lv.1</th>
											<th>lv.2</th>
											<th>lv.3</th>
											<th>lv.4</th>
											<th>lv.5</th>
										</tr>
									</thead>
									<tbody id="pason">
									</tbody>
								</table>
							</div>
						</div>
					</div>
					<div class="col-md-6">
						<div class="card">
							<div class="header">
								<h4 class="title">현재 대여 정보</h4>
							</div>
							<div class="content">
								<table class="table" style="margin-bottom: 0px;">
									<thead>
										<th>ID</th>
										<th>도서명</th>
										<th>대여일</th>
										<th>반납예정일</th>
										<th>도서상태</th>
										<th>반납처리</th>
									</thead>
									<tbody id="myList">

									</tbody>
								</table>
							</div>
						</div>
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
					<li class="active"><a href="admin_member"> <i
							class="ti-user"></i>
							<p>회원 관리</p>
					</a></li>
					<hr>
					<li><a href="book_list"> <i class="ti-view-list-alt"></i>
							<p>도서 관리</p>
					</a></li>

					<li><a href="book_apply"> <i class="ti-pencil-alt2"></i>
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
									<h4 class="title">대여 현황</h4>
								</div>
								<div class="content">
									<div class="card card-plain">
										<div class="content table-responsive table-full-width">
											<div class="col-md-2">
												<select id="selectGisu" class="form-control border-input">
													<option value="0" selected>기수</option>
													<option value="32">32기</option>
													<option value="33">33기</option>
												</select>
											</div>
											<div class="col-md-8">
												<input id="searchNm" type="text"
													class="form-control border-input"
													placeholder="학생명을 입력해주세요.">
											</div>
											<div class="col-md-2">
												<input type="button"
													class="search_btn btn btn-info btn-fill btn-wd"
													value="Search">
											</div>
											<br> <br>
											<hr>
											<table class="table table-hover">
												<thead>
													<th>ID</th>
													<th>학생명</th>
													<th>기수</th>
													<th>종류</th>
													<th>성별</th>
													<th>전화번호</th>
													<th>이메일</th>
													<th>대여정보</th>

												</thead>
												<tbody id="stdList">
													<c:forEach var="data" items="${stdList}" varStatus="status">
														<tr>
															<td>${ status.count }</td>
															<td>${ data.user_nm }</td>
															<td>${ data.gisu_num }</td>
															<td>${ data.user_flag }</td>
															<td>${ data.user_sex }</td>
															<td>${ data.user_phone }</td>
															<td>${ data.user_email }</td>
															<td><input class="btn modal_btn" type="button"
																value="보기" this_id="${ data.user_id }"></td>
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


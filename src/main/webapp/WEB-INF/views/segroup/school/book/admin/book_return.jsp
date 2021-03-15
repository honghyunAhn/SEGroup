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
<%-- <link
	href="<c:url value='/resources/segroup/school/book/admin/css/animate.min.css'/>"
	rel="stylesheet" /> --%>

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

</head>
<style>
.main-panel {
	float: none;
	width: auto;
}

table {
	width: 100%;
}

#rtn_state_pason {
	visibility: hidden;
}
</style>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script>
	$(function() {
		$("input:radio[name=rtn_state]").click(function() {
			$("#rtn_state_pason").css("visibility", "hidden");
		});

		$("input:radio[id=other]").click(function() {
			$("#rtn_state_pason").css("visibility", "visible");
		});

		$(".book_return_btn")
				.click(
						function() {
							var rtn_seq = $(this).attr('rtn_seq');
							var rtn_code = $(':radio[name="rtn_state"]:checked')
									.val();
							if (rtn_code == 'other') {
								rtn_code = $(':radio[name="rtn_state_p"]:checked')
										.val();
							}
							$
									.ajax({
										url : 'rtnBookProc',
										data : {
											'rtn_seq' : rtn_seq,
											'rtn_code' : rtn_code
										},
										type : 'POST',
										success : function(data) {
											alert('완벽히 처리하였습니다.');
											close();
										}
									});

						});
	});

</script>
<body>
	<div class="wrapper">
		<div class="main-panel">
			<div class="content">
				<div class="container-fluid">
					<div class="row">
						<div class="col-lg-8 col-md-7">
							<div class="card">
								<div class="header">
									<h4 class="title">도서 반납 처리</h4>
								</div>
								<div class="content">
									<form>
										<div class="row">
											<div class="col-xs-4">
												<div class="form-group">
													<label>대여자</label> <input type="text"
														class="form-control border-input"
														value="${ rtnBookInfo.user_nm }">
												</div>
											</div>
											<div class="col-xs-8">
												<div class="form-group">
													<label>도서명</label> <input type="text"
														class="form-control border-input"
														value="${ rtnBookInfo.bookinfo_book_nm }">
												</div>
											</div>
										</div>
										<div class="row">
											<div class="col-xs-12">
												<div class="form-group">
													<label>반납 상태</label><br>
													<table>
														<tr>
															<td><input type="radio" value="B0000"
																name="rtn_state" id="B0000" checked> <label
																for="B0000"><span></span>정상</label></td>
															<td><input type="radio" value="B0001"
																name="rtn_state" id="B0001"> <label for="B0001"><span></span>분실</label></td>
															<td><input type="radio" value="other"
																name="rtn_state" id="other"> <label for="other"><span></span>파손</label></td>
														</tr>
													</table>
												</div>
											</div>
										</div>
										<div class="row">
											<div class="col-xs-12">
												<div class="form-group" id="rtn_state_pason">
													<label>파손 상태</label><br>
													<table>
														<tr>
															<td><input type="radio" value="B0002"
																name="rtn_state_p" id="B0002" checked> <label
																for="B0002"><span></span>파손 1단계</label></td>
															<td><input type="radio" value="B0003"
																name="rtn_state_p" id="B0003" checked> <label
																for="B0003"><span></span>파손 2단계</label></td>
															<td><input type="radio" value="B0004"
																name="rtn_state_p" id="B0004" checked> <label
																for="B0004"><span></span>파손 3단계</label></td>
															<td><input type="radio" value="B0005"
																name="rtn_state_p" id="B0005" checked> <label
																for="B0005"><span></span>파손 4단계</label></td>
															<td><input type="radio" value="B0006"
																name="rtn_state_p" id="B0006" checked> <label
																for="B0006"><span></span>파손 5단계</label></td>
														</tr>
													</table>
												</div>
											</div>
										</div>
										<div class="text-center">
											<button class="book_return_btn btn btn-info btn-fill btn-wd"
												rtn_seq="${ rtnBookInfo.rental_seq }">반납 처리</button>
										</div>
										<div class="clearfix"></div>
									</form>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
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
<%-- <script
	src="<c:url value='/resources/segroup/school/book/admin/js/paper-dashboard.js'/>"></script> --%>
</html>


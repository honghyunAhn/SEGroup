<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<sec:authorize access="isAuthenticated()">
	<sec:authentication property="details" var="check"/>
	<input type="hidden" id="checkId" value="${check.user.user_id }" />
</sec:authorize>
<div id="fh5co-offcanvas" style="float: right">
		<a href="#" class="fh5co-close-offcanvas js-fh5co-close-offcanvas"><span><i>X</i>
				<span> Close</span></span></a>
		<div class="fh5co-bio">
			<figure>
				<img src="/resources/segroup/school/book/user/images/person1.jpg"
					alt="No Image" class="img-responsive">
			</figure>
			<h3 class="heading">${sbUser.gisu_num }기</h3>
			<h3>${sbUser.user_nm }</h3>
		</div>

		<div class="fh5co-menu">
			<div class="fh5co-box">
				<h3 class="heading">마이 페이지</h3>
				<ul>
					<li><a href="/book/user/user_status">대여 현황</a></li>
					<li><a href="/book/user/user_bookmark">관심 도서</a></li>
					<li><a href="/book/user/user_rent_record">내	대여 기록</a></li>
					<li><a href="/book/user/user_review">내	글 보기</a></li>
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
					<a href="/book/user/user_main">SES Library</a>
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
						<c:when test="${empty check }">
							<button type="button" id="loginForm"
								class="navbar-btn nav-button wow bounceInRight login"
								data-toggle="modal" data-target="#myModal" id="loginForm"
								data-wow-delay="0.8s">Login</button>
						</c:when>
						<c:otherwise>
							<button type="button"
								class="navbar-btn nav-button wow fadeInRight" id="logout"
								data-wow-delay="0.6s">Logout</button>
							<button type="button"
								class="navbar-btn nav-button wow fadeInRight js-fh5co-nav-toggle"
								id="mypage" data-wow-delay="0.6s">My Page</button>
						</c:otherwise>
					</c:choose>

					<!--로그인 모달  -->
					<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
						aria-labelledby="myLargeModalLabel" aria-hidden="true">
						<div class="modal-dialog modal-lg loginModal">
							<div class="modal-content">
								<div class="modal-header">
									<button type="button" class="close" data-dismiss="modal"
										aria-hidden="true">×</button>

									<h4 class="modal-title" id="myModalLabel">SES Library</h4>
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
															<input type="text" class="form-control"
																id="id" placeholder="ID" />
														</div>
													</div>
													<div class="form-group">
														<label for="InputPassword" class="col-sm-2 control-label">Password</label>
														<div class="col-sm-10">
															<input type="password" 
																class="form-control" id="pw" placeholder="Password" />
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
			</div>
		</div>
	</nav>
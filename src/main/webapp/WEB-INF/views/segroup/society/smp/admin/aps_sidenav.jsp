<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%-- <!DOCTYPE >
<html>
<head>
<!--Import Google Icon Font-->
<link href="http://fonts.googleapis.com/icon?family=Material+Icons"
	rel="stylesheet">
<!--Import materialize.css-->
<link type="text/css" rel="stylesheet"
	href="<c:url value="/resources/segroup/society/smp/one/css/materialize.css" />" media="screen,projection" />
<link type="text/css" rel="stylesheet"
	href="<c:url value="/resources/segroup/society/smp/one/css/aps_total.css" />" media="screen,projection" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript"
	src="https://code.jquery.com/jquery-2.1.1.min.js"></script>
<script type="text/javascript" src="<c:url value="/resources/segroup/society/smp/one/js/materialize.min.js" />"></script>
</head> --%>
<style type="text/css">
	.sidenav_menu_color{
		background-color : #2bbbad;
	}
</style>
<title>sidenav</title>
<body>
	<!-- 김홍일 : 사이드 메뉴바 -->
	<ul id="slide-out" class="sidenav sidenav-fixed">
		<li><div class="user-view">
				<div class="background">
					<img src="<c:url value="/resources/segroup/society/smp/one/images/main.jpg" />"
						style="height: 100%; width: 100%;">
				</div>
				<i class="material-icons" style="color: #ffffff;">account_circle</i>
				<a href="#name"><span class="white-text name">김 홍일</span></a> <a
					href="#email"><span class="white-text email">clroyan01@gmail.com</span></a>
			</div></li>
		<li><a href="#!" style="font-weight: bold;">홈으로</a></li>
		<li><a href="#!" style="font-weight: bold;">내 정보</a></li>
		<li><div class="divider"></div></li>
		<li><a class="subheader"
			style="background-color: #aaaaaa; color: white;">평가관리</a></li>
		<li><a class="waves-effect sidenav_menu" id="aps_total_a" href="aps_total">종합평가</a></li>
		<li><a class="waves-effect sidenav_menu" id="aps_group_a" href="aps_group">그룹평가</a></li>
		<li><a class="waves-effect sidenav_menu" id="aps_detail_a" href="aps_detail">상세평가</a></li>
		<li><a class="waves-effect sidenav_menu" id="aps_seteval_a" href="aps_seteval">빠른 평가설정</a>
	</ul>

	<!-- 김홍일 : 최소화 시켰을 때 자연스럽게 사이드 메뉴가 사라지는 자바스크립트
		*이 자바스크립트를 삭제해도 최소화 시켰을 때 사이드 메뉴가 사라짐
	 -->
	<script type="text/javascript">
		document.addEventListener('DOMContentLoaded', function() {
			var elems = document.querySelectorAll('.sidenav');
			var instances = M.Sidenav.init(elems);
		});

		// Or with jQuery

		$(document).ready(function() {
			$('.sidenav').sidenav();
		});
	</script>
	
	<script type="text/javascript">
		$('.sidenav_menu').click(function(){
			$(this).parent().removeClass('sidenav_menu_color');
		})
	</script>

</body>
</html>
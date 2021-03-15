<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet"
	href="<c:url value="/resources/segroup/css/jquery-ui.min.css" />">
<script src="<c:url value="/resources/segroup/js/angular.min.js" />"></script>

<!-- 페이징관련 css 시작 -->
<!--Import Google Icon Font-->
<!-- <link href="http://fonts.googleapis.com/icon?family=Material+Icons"
	rel="stylesheet"> -->
<!--Import materialize.css-->
<link type="text/css" rel="stylesheet"
	href="<c:url value="/resources/segroup/society/smp/one/css/materialize.min.css" />" />
<link type="text/css" rel="stylesheet"
	href="<c:url value="/resources/segroup/society/smp/one/css/aps_total.css" />" />
<script type="text/javascript"
	src="https://code.jquery.com/jquery-2.1.1.min.js"></script>
<script type="text/javascript"
	src="<c:url value="/resources/segroup/society/smp/one/js/materialize.min.js" />"></script>
<!-- 페이징 관련 css 끝 -->
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>빠른 평가설정</title>
</head>
<body id="myBody" ng-app="myapp" ng-controller="AdminController">
	<!-- 김홍일 : 메뉴 바 -->
	<nav>
		<div class="nav-wrapper">
			<a href="" class="" style="margin-left: 13px;">Soft Engineer
				Society</a>
			<ul id="nav-mobile" class="right">
				<li><a href="">공지사항</a></li>
				<li><a href="">학생관리<span class="new badge">4</span></a></li>
				<li><a href="">평가관리</a></li>
				<li><a href="">성적관리</a></li>
				<li><a href="">학사일정</a></li>
			</ul>
		</div>
	</nav>

	<!-- 김홍일 : 발자국 -->
	<div style="line-height: 56px; padding-left: 15px;">
		<a href="#!" class="breadcrumb">Home</a> <a href="#!"
			class="breadcrumb">평가관리</a> <a href="#!" class="breadcrumb">빠른
			평가설정</a>
	</div>

	<!-- 김홍일 : 사이드 메뉴 -->
	<%@include file="aps_sidenav.jsp"%>

	<script type="text/javascript">
		$('#aps_seteval_a').css('color', 'white');
		$('#aps_seteval_a').parent().addClass('sidenav_menu_color');
	</script>

	<!-- 김홍일 : 우측 하단 글쓰기 버튼 및 하위 모달 호출 -->
	<%@include file="aps_insert_form.jsp"%>

	<!-- 김홍일 : 빠른 평가설정을 설명하는 카드 -->
	<div class="row">
		<div class="col s12 m12">
			<div class="card">
				<div class="card-action white-text"
					style="background-color: #1e88e5;">
					<span class="card-title" style="font-size: 14px;">빠른 평가설정</span>
				</div>
				<div class="card-content">
					<p>적용 값(위)의 기수를 선택한 후 적용 대상(아래)의 기수를 선택하고 완료를 누르시면, 적용 값(위)의 기수의 평가설정 전체가 적용 대상(아래)의 기수에 그대로 적용됩니다.</p>
				</div>

			</div>
		</div>
	</div>

	<!-- 김홍일 : 검색창 -->
	<ul class="collapsible active">
		<li class="active">
			<div class="collapsible-header" style="background-color: #eeeeee;">
				<i class="material-icons">view_stream</i>적용 값
			</div>
			<div class="collapsible-body">
				<div class="row">
					<div class="input-field col s12">
						<select id="gisuSelect"
							onchange="angular.element(this).scope().gisu_change('')">
							<optgroup label="2019년도">
								<c:forEach var="data" items="${seaCurList}">
									<option value="${data.gisu_seq }">${data.gisu_crc_nm }</option>
								</c:forEach>
							</optgroup>
						</select> <label>기수 검색</label>
					</div>
				</div>
			</div>
		</li>
	</ul>
	
	<i class="material-icons" style="margin-left: 2rem;">expand_more</i><i class="material-icons" style="float: right; margin-right: 2rem;">expand_more</i>
	
	<!-- 김홍일 : 검색창 -->
	<ul class="collapsible active">
		<li class="active">
			<div class="collapsible-header"
				style="background-color: #444444; color: #ffffff;">
				<i class="material-icons" style="color: #ffffff;">view_stream</i>적용
				대상
			</div>
			<div class="collapsible-body">
				<div class="row">
					<div class="input-field col s12">
						<select id="gisuSelect"
							onchange="angular.element(this).scope().gisu_change('')">
							<optgroup label="2019년도">
								<c:forEach var="data" items="${seaCurList}">
									<option value="${data.gisu_seq }">${data.gisu_crc_nm }</option>
								</c:forEach>
							</optgroup>
						</select> <label>기수 검색</label>
					</div>
				</div>
			</div>
		</li>
	</ul>

	<a class="btn-large" style="float: right; margin-right: 0.5rem;"><i class="material-icons right">send</i>적용</a>

	<!-- 김홍일 : 검색창 여닫기 기능 -->
	<script type="text/javascript">
		document.addEventListener('DOMContentLoaded', function() {
			var elems = document.querySelectorAll('.collapsible');
			var instances = M.Collapsible.init(elems);
		});

		// Or with jQuery

		$(document).ready(function() {
			$('.collapsible').collapsible();
		});
	</script>

	<!-- 김홍일 : 기수 검색 셀렉트 문 -->
	<script type="text/javascript">
		document.addEventListener('DOMContentLoaded', function() {
			var elems = document.querySelectorAll('select');
			var instances = M.FormSelect.init(elems);
		});

		// Or with jQuery

		$(document).ready(function() {
			$('select').formSelect();
		});
	</script>
</body>
</html>
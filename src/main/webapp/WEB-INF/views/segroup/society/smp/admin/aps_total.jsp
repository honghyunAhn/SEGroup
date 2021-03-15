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

<title>종합평가</title>

<script type="text/javascript">
	var myApp = angular.module('myapp', []);

	myApp.directive('selectcode', [ '$http', function($http) {
		return {
			restrict : "A",
			replace : true,
			scope : {
				value : '@'
			},
			controller : function($scope, $element, $attrs) {
				$http({
					method : 'POST',
					url : '/codeconverter',
					responseType : 'text',
					params : {
						code : $attrs.value
					}
				}).then(function successCallback(response) {
					$scope.filterParams = response.data;
				}, function errorCallback(response) {
					console.log(response);
				});
			},
			template : "<option>{{filterParams}}</option>"
		}
	} ]);
	myApp.directive('code', [ '$http', function($http) {
		return {
			restrict : "E",
			replace : true,
			scope : {
				value : '@'
			},
			controller : function($scope, $element, $attrs) {
				$http({
					method : 'POST',
					url : '/codeconverter',
					responseType : 'text',
					params : {
						code : $attrs.value
					}
				}).then(function successCallback(response) {
					$scope.filterParams = response.data;
				}, function errorCallback(response) {
					console.log(response);
				});
			},
			template : "<span>{{filterParams}}</span>"
		}
	} ]);
	myApp.controller('AdminController',['$scope','$compile','$http',function($scope, $compile, $http) {
								$scope.gisu_change = function() {
									var gisu_seq = $("#gisuSelect option:selected").val();

									$http({
										method : 'POST',
										url : "/smp/total_search_gisu",
										params : {
											gisu_seq : gisu_seq
										}
									}).then(function successCallback(response) {
										$scope.list_draw(response);

									}, function errorCallback(response) {
										console.log(response);

									});

								}

								$scope.list_draw = function(response) {
									var context = '';
									var map = response.data;
									var count = 0;
									$.each(response.data.resultList,function(index, item) {
														context += '<tr style="text-align: left;">';
														context += '<td>'
														context += index+1;
														context += '</td>'
														context += '<td>'
																+ item.gisu_num
																+ '</td>';
														context += '<td>'
																+ item.smp_aps_total_nm
																+ '</td>';
														context += '<td>'
																+ item.smp_aps_total_ratio
																+ '</td>';
														context += '<td><a class="btn-small" ng-click="updateTotal(&quot;'
																+ item.smp_aps_total_seq
																+ '&quot;);">수정</a></td>';
														context += '<td><a class="btn-small red" ng-click="deleteTotal(&quot;'
																+ item.smp_aps_total_seq
																+ '&quot;);">삭제</a></td>';
														context += '</tr>';
														count++;
													});
									$("#peopleCount").html(
											"총인원: " + count + "명");
									$("#search_data").html(
											$compile(context)($scope));
									$(".totalDiv").show();


								}
								$scope.deleteTotal = function(seq) {

									var smp_aps_total_seq = seq;

									$http(
											{
												method : 'POST',
												url : "/smp/deleteTotal",
												params : {
													smp_aps_total_seq : smp_aps_total_seq
												}
											}).then(
											function successCallback(response) {
												alert("삭제성공");
												$scope.gisu_change();
											},
											function errorCallback(response) {
												console.log(response);

											});
								}

								$scope.updateTotal = function(seq) {

									var smp_aps_total_seq = seq;
									location.href = "/smp/admin/aps_total_update_form?smp_aps_total_seq="
											+ smp_aps_total_seq;

								}

							} ]);
	
	$(function() {
		//등록하기
		$("#goTotalInsertForm").on("click", function() {
			location.href = "aps_total_insert_form";
		});

	})
</script>
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
			class="breadcrumb">평가관리</a> <a href="#!" class="breadcrumb">종합평가</a>
	</div>

	<!-- 김홍일 : 사이드 메뉴 -->
	<%@include file="aps_sidenav.jsp"%>

	<script type="text/javascript">
		$('#aps_total_a').css('color', 'white');
		$('#aps_total_a').parent().addClass('sidenav_menu_color');
	</script>

	<!-- 김홍일 : 우측 하단 글쓰기 버튼 및 하위 모달 호출 -->
	<%@include file="aps_insert_form.jsp"%>

	<!-- 김홍일 : 검색창 -->
	<ul class="collapsible">
		<li>
			<div class="collapsible-header">
				<!-- <i class="material-icons">view_stream</i> -->검색
			</div>
			<div class="collapsible-body">
				<div class="row">
					<div class="input-field col s12">
						<select id="gisuSelect"
							onchange="angular.element(this).scope().gisu_change()">
							<option disabled selected>기수를 선택하세요.</option>
							<c:forEach var="data" items="${seaCurList}">
								<option value="${data.gisu_seq }">${data.gisu_crc_nm }</option>
							</c:forEach>
						</select> <label>기수 검색</label>
					</div>
				</div>
			</div>
		</li>
	</ul>

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

	<!-- 현재 비율의 합 및 글쓰기 -->
	<div class="row totalDiv" style="margin-top: 2rem; display:none;">
		<div class="col s3 m3 right">
			<div class="card">
				<div class="card-image">
					<a class="btn-floating halfway-fab red modal-trigger tooltipped"
						href="#modal-total" data-position="left" data-tooltip="종합평가 작성"><i
						class="material-icons">description</i></a>
				</div>
				<div class="card-content">
					<p>
						선택하신 <span style="font-weight: bold;">34기</span>의 종합평가 비율의 합은 <span
							id="sumTR" style="font-weight: bold;">100%</span>입니다.
					</p>
				</div>
			</div>
		</div>
	</div>

	<!-- 김홍일 : 생성한 종합평가를 나타내는 표 -->
	<div style="width: 98%; display: none;" class="totalDiv">
		<table class="highlight table_manager" style="margin-left: 1rem;">
			<thead>
				<tr>
					<th>No</th>
					<th>기수</th>
					<th>과목명</th>
					<th>종합평가 반영율(%)</th>
					<th>수정</th>
					<th>삭제</th>
				</tr>
			</thead>

			<tbody id="search_data">


			</tbody>
		</table>
	</div>
</body>
</html>
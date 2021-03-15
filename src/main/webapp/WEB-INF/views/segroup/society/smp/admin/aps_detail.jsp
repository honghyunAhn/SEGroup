<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet"
	href="<c:url value="/resources/segroup/css/jquery-ui.min.css" />">
<script src="<c:url value="/resources/segroup/js/angular.min.js" />"></script>

<!-- 김홍일 : 기존에 사용하던 css를 주석처리 하였음 -->
<%-- <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css"
	href="<c:url value="/resources/segroup/society/edu/css/common.css" />">
<link rel="stylesheet" type="text/css"
	href="<c:url value="/resources/segroup/society/edu/css/sub.css" />">
<link rel="stylesheet" type="text/css"
	href="<c:url value="/resources/segroup/society/edu/css/main.css" />"> --%>
<!--Import Google Icon Font-->
<!-- <link href="http://fonts.googleapis.com/icon?family=Material+Icons"
	rel="stylesheet"> -->
<!--Import materialize.css-->
<link type="text/css" rel="stylesheet"
	href="<c:url value="/resources/segroup/society/smp/one/css/materialize.min.css" />" media="screen,projection" />
<link type="text/css" rel="stylesheet"
	href="<c:url value="/resources/segroup/society/smp/one/css/aps_total.css" />" media="screen,projection" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript"
	src="https://code.jquery.com/jquery-2.1.1.min.js"></script>
<script type="text/javascript" src="<c:url value="/resources/segroup/society/smp/one/js/materialize.min.js" />"></script>
<!-- 상단메뉴와 하단메뉴 관련 css-->

<title>상세평가</title>

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
	myApp.directive('code', ['$http',function($http){
		return {
			restrict: "E",
			replace: true,
			scope : {
				value : '@'
			},
			controller: function ($scope, $element, $attrs) {
				$http({
					method: 'POST',
					url: '/codeconverter',
			  		responseType: 'text',
					params : {
						code : $attrs.value
					}
				}).then(function successCallback(response) {
		    		$scope.filterParams = response.data;
				}, function errorCallback(response) {
					console.log(response);
				});
			}
			,template: "<span>{{filterParams}}</span>"
		}
	}]);
	myApp.controller('AdminController', [ '$scope', '$compile', '$http', function($scope, $compile, $http) {
		$scope.gisu_change = function(curPage, orderType, orderValue) {
			var gisu_seq = $("#gisuSelect option:selected").val();
			
			$http({
				method : 'POST',
				url : "/smp/total_search_gisu",
				params : {
					gisu_seq: gisu_seq,
				}
			}).then(function successCallback(response) {
				$scope.select_draw(response);
				
			}, function errorCallback(response) {
				console.log(response);
				
			});
		}

		$scope.select_draw = function(response) {
			var context = '';
			var map = response.data;
			var count = 0;
			context += '<option disabled selected>종합평가를 선택하세요.</option>';
			$.each(response.data.resultList, function(index, item) {
				context += '<option value="'+item.smp_aps_total_seq+'" title="'+item.smp_aps_total_nm+'">'+item.smp_aps_total_nm+'</option>';
				count++;
			});
			$("#totalSelect").html($compile(context)($scope));
			$("#totalSelect").formSelect();
		}
		
		$scope.total_change = function(curPage, orderType, orderValue) {
			var gisu_seq = $("#gisuSelect option:selected").val();
			var smp_aps_total_seq = $("#totalSelect option:selected").val();
			
			$http({
				method : 'POST',
				url : "/smp/admin/selectApsGroupList",
				params : {
					smp_aps_total_seq : smp_aps_total_seq
					,gisu_seq : gisu_seq
				}
			}).then(function successCallback(response) {
				/* $scope.select_draw(response); */
				$("#type-tabs-div").show();
				$(".tabs").tabs();
				//$scope.detail_draw(response.data);
			}, function errorCallback(response) {
				console.log(response);
				
			});
		}
		
		$scope.deleteTotal = function(seq) {
			
			var smp_aps_detail_seq = seq;
			
			$http({
				method : 'POST',
				url : "/smp/deleteDetail",
				params : {
					smp_aps_detail_seq: smp_aps_detail_seq
				}
			}).then(function successCallback(response) {
			
				alert("삭제성공");
				$scope.gisu_change();
			}, function errorCallback(response) {
				console.log(response);
				
			});
		}
		
		$scope.updateTotal = function(seq) {
			
			var smp_aps_detail_seq = seq;
			location.href = "/smp/admin/aps_detail_update_form?smp_aps_detail_seq="+smp_aps_detail_seq;
			
		}
		
	$scope.detail_draw = function(response){
		
		var context = '';
		$.each(response, function(index, item){
			context += '<div id="detail_tab-'+index+'" class="detail_tab">'
			context += '<ul class="collapsible popout">'
			$.each(item.groupTbList, function(index2, item2){
				alert(item2.smp_aps_group_tp);
				if(item2.smp_aps_group_tp == 'A0900'){
					
					$.each(item.groupExamList, function(index3, item3){
						
						context += '<li>';
						context += '<a ng-click="commonCssChange()"><div class="collapsible-header"><!-- <i class="material-icons">filter_drama</i> --><span>'+item3.smp_aps_group_exam_nm+'</span></div></a>';
						context += '<div class="collapsible-body">';
						context += '<!-- 현재 비율의 합 및 글쓰기 -->';
						context += '<div class="row" style="margin-top: 2rem;">';
						context += '<div class="col s3 m3 right">';
						context += '<div class="card">';
						context += '<div class="card-image">';
						context += '<a class="btn-floating modal-trigger halfway-fab yellow darken-1 tooltipped" href="#modal-group" data-position="left" data-tooltip="그룹평가 작성"><i class="material-icons">assignment</i></a></div>';
						context += '<div class="card-content">';
						context += '<p><span style="font-weight: bold;">상세평가 반영율</span>란이 <span style="font-weight: bold;">공백</span>이면 성적관리에서 입력한 점수가 그대로 반영됩니다.</p></div></div></div></div>';

						/* <!-- 김홍일 : 생성한 정규시험를 나타내는 표 --> */
						context += '<div style="width: 98%;">';
						context += '<table class="highlight table_manager" style="margin-left: 1rem;">';
						context += '<thead>';
						context += '<tr>';
						context += '<th>No</th>';
						context += '<th>기수</th>';
						context += '<th>과목명</th>';
						context += '<th>종합평가 반영율(%)</th>';
						context += '<th>정규시험명</th>';
						context += '<th>그룹평가 반영율(%)</th>';
						context += '<th>상세시험명</th>';
						context += '<th>상세평가 반영율(%)</th>';
						context += '<th>합격점</th>';
						context += '<th>수정</th>';
						context += '<th>삭제</th>';
						context += '</tr>';
						context += '</thead>';
						context += '<tbody id="smp_aps_detail_exam-'+index+'">';
						/* <!-- 상세평가 리스트가 앵귤러 js로 출력 --> */
						context += '</tbody>';
						context += '</table>';
						context += '</div>';
						context += '</div>';
						context += '</li>';

						
					});
					/* $.each(item2.groupExamList, function(index3, item3){
						console.log(item3.smp_aps_group_exam_nm);
					}) */
				
				}else if(item2.smp_aps_group_tp == 'A0901'){
					
					$.each(item.groupSubexamList, function(index3, item3){
						
						context += '<li>';
						context += '<a ng-click="commonCssChange()"><div class="collapsible-header"><!-- <i class="material-icons">computer</i> --><span>'+item3.smp_aps_group_subexam_nm+'</span></div></a>';
						context += '<div class="collapsible-body">';

						/* <!-- 현재 비율의 합 및 글쓰기 --> */
						context += '<div class="row" style="margin-top: 2rem;">';
						context += '<div class="col s3 m3 right">';
						context += '<div class="card">';
						context += '<div class="card-image">';
						context += '<a class="btn-floating modal-trigger halfway-fab yellow darken-1 tooltipped" href="#modal-group" data-position="left"mdata-tooltip="그룹평가 작성"><i class="material-icons">assignment</i></a></div>';
						context += '<div class="card-content">';
						context += '<p>선택하신 <span style="font-weight: bold;"></span>의 <span> 과목평가</span> 는 비율의 합이 없습니다. 단, 합격점 이하일 시 확인서를 발급할 수 있습니다.</p>';
						context += '</div>';
						context += '</div>';
						context += '</div>';
						context += '</div>';

						/* <!-- 김홍일 : 생성한 과목평가를 나타내는 표 --> */
						context += '<div style="width: 98%;">';
						context += '<table class="highlight" style="margin-left: 1rem;">';
						context += '<thead>';
						context += '<tr>';
						context += '<th>No</th>';
						context += '<th>기수</th>';
						context += '<th>과목명</th>';
						context += '<th>과목평가명</th>';
						context += '<th>합격점</th>';
						context += '<th>상세시험명</th>';
						context += '<th>합격점</th>';
						context += '<th>수정</th>';
						context += '<th>삭제</th>';
						context += '</tr>';
						context += '</thead>';
						context += '<tbody id="smp_aps_detail_subexam-'+index+'">';
						/* <!-- 그룹평가 리스트가 앵귤러 js로 출력 --> */
						context += '</tbody>';
						context += '</table>';
						context += '</div>';
						context += '</div>';
						context += '</li>';
						
					});
				}
			})
			context += '</ul>'
			context += '</div>'	
		});
		$("#detail_list").html($compile(context)($scope));
	}
	} ]);
	function order_change(orderType){
		var orderValue = $('#'+orderType).attr('class');
		if(orderType=='user_name'){
			if(orderValue=='desc'){
				$("#user_name").attr('class','asc');
				orderValue='asc';
			}else{
				$("#user_name").attr('class','desc');
				orderValue='desc';
			}
		}else if(orderType=='user_class'){
			if(orderValue=='desc'){
				$("#user_class").attr('class','asc');
				orderValue='asc';
			}else{
				$("#user_class").attr('class','desc');
				orderValue='desc';
			}
		}
		var scope = angular.element(document.getElementById('myBody')).scope();
		scope.gisu_change(1, orderType, orderValue);
	}

	$(function() {
	//등록하기
		$("#goTotalInsertForm").on("click", function() {
			location.href = "aps_detail_insert_form";
		});

	})
	
	
</script>
</head>
<body id="myBody" ng-app="myapp" ng-controller="AdminController">
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
			class="breadcrumb">평가관리</a> <a href="#!" class="breadcrumb">상세평가</a>
	</div>

	<!-- 김홍일 : 사이드 메뉴 -->
	<%@include file="aps_sidenav.jsp"%>

	<script type="text/javascript">
		$('#aps_detail_a').css('color', 'white');
		$('#aps_detail_a').parent().addClass('sidenav_menu_color');
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
							onchange="angular.element(this).scope().gisu_change('')">
							<option disabled selected>기수를 선택하세요.</option>
								<c:forEach var="data" items="${seaCurList}">
									<option value="${data.gisu_seq }">${data.gisu_crc_nm }</option>
								</c:forEach>
						</select> <label>기수 검색</label>
					</div>
					<div class="input-field col s12">
						<select id="totalSelect"
							onchange="angular.element(this).scope().total_change('')">
							<option disabled selected>종합평가를 선택하세요.</option>
						</select> <label>종합평가 검색</label>
					</div>
				</div>
			</div>
		</li>
	</ul>

	<!-- 김홍일 : 검색창 여닫기 기능 -->
	<script type="text/javascript">
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

	<!-- 김홍일 : 그룹별 그룹평가 모음 탭 -->
	<div class="row">
		<div class="col s12" id="type-tabs-div" style="display:none;">
			<ul id="detail_tabs" class="tabs">
				<li class="tab col s3"><a class="active" href="#type-tab-1"><span>정규시험</span></a></li>
				<li class="tab col s3"><a href="#type-tab-2"><span>과목시험</span></a></li>
			</ul>
		</div>
	</div>

	<!-- 김홍일 : 탭 이동 제이쿼리 -->
	<script type="text/javascript">
		$(document).ready(function() {
			$('ul.tabs').tabs();
		});
	</script>
	${apsTotal } <br>
	${apsGroup } <br>
	
	<div id="detail_list">
	
	</div>
</body>
</html>
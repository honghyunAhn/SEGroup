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

<title>그룹평가</title>

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
		
		$scope.gisu_change = function() {
			//기수 변경 select
			var gisu_seq = $("#gisuSelect option:selected").val();

			$http({
				method : 'POST',
				url : "/smp/total_search_gisu",
				params : {
					gisu_seq : gisu_seq
				}
			}).then(function successCallback(response) {
				$scope.tab_draw(response);

			}, function errorCallback(response) {
				console.log(response);

			});

			$http({
				method : 'POST',
				url : "/smp/admin/selectApsGroup",
				params : {
					gisu_seq : gisu_seq
				}
			}).then(function successCallback(response) {
				$scope.group_draw(response.data);

			}, function errorCallback(response) {
				console.log(response);

			});
		}
		
		$scope.group_draw = function(response){
			
			var flag_exam = true;
			var flag_subexam = true;
			var flag_confirm = true;
			
			var context = '';
			$.each(response, function(index, item){
				context += '<div id="group_tab-'+index+'" class="group_tab" style="display:none;">'
				context += '<ul class="collapsible popout">'
				$.each(item.groupTbList, function(index2, item2){
					
					if(item2.smp_aps_group_tp == 'A0900'){
						
						if(flag_exam){
							
							context += '<li>';
							context += '<a ng-click="commonCssChange()"><div class="collapsible-header"><!-- <i class="material-icons">filter_drama</i> --><span>정규시험</span></div></a>';
							context += '<div class="collapsible-body">';
							context += '<!-- 현재 비율의 합 및 글쓰기 -->';
							context += '<div class="row" style="margin-top: 2rem;">';
							context += '<div class="col s3 m3 right">';
							context += '<div class="card">';
							context += '<div class="card-image">';
							context += '<a class="btn-floating modal-trigger halfway-fab yellow darken-1 tooltipped" href="#modal-group" data-position="left" data-tooltip="그룹평가 작성"><i class="material-icons">assignment</i></a></div>';
							context += '<div class="card-content">';
							context += '<p>선택하신 <span style="font-weight: bold;"></span>의 <span></span>그룹평가 비율의 합은 <span style="font-weight: bold;"></span>입니다.</p></div></div></div></div>';

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
							context += '<th>합격점</th>';
							context += '<th>수정</th>';
							context += '<th>삭제</th>';
							context += '</tr>';
							context += '</thead>';
							context += '<tbody id="smp_aps_group_exam-'+index+'">';
							/* <!-- 그룹평가 리스트가 앵귤러 js로 출력 --> */
							context += '</tbody>';
							context += '</table>';
							context += '</div>';
							context += '</div>';
							context += '</li>';
	
							flag_exam = false;
						}else{
							
						}
						/* $.each(item2.groupExamList, function(index3, item3){
							console.log(item3.smp_aps_group_exam_nm);
						}) */
					
					}else if(item2.smp_aps_group_tp == 'A0901'){
						
						if(flag_subexam){
							
							context += '<li>';
							context += '<a ng-click="commonCssChange()"><div class="collapsible-header"><!-- <i class="material-icons">computer</i> --><span>과목평가</span></div></a>';
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
							context += '<th>수정</th>';
							context += '<th>삭제</th>';
							context += '</tr>';
							context += '</thead>';
							context += '<tbody id="smp_aps_group_subexam-'+index+'">';
							/* <!-- 그룹평가 리스트가 앵귤러 js로 출력 --> */
							context += '</tbody>';
							context += '</table>';
							context += '</div>';
							context += '</div>';
							context += '</li>';
							
							flag_subexam = false;
						}else{
							
						}
					
					}else if(item2.smp_aps_group_tp == 'A0902'){
						if(flag_confirm){
							
							context += '<li>';
							context += '<a ng-click="commonCssChange()"><div class="collapsible-header"><!-- <i class="material-icons">computer</i> --><span>확인서</span></div></a>';
							context += '<div class="collapsible-body">';

							/* <!-- 현재 비율의 합 및 글쓰기 --> */
							context += '<div class="row" style="margin-top: 2rem;">';
							context += '<div class="col s3 m3 right">';
							context += '<div class="card">';
							context += '<div class="card-image">';
							context += '<a class="btn-floating modal-trigger halfway-fab yellow darken-1 tooltipped" href="#modal-group" data-position="left"mdata-tooltip="그룹평가 작성"><i class="material-icons">assignment</i></a></div>';
							context += '<div class="card-content">';
							context += '<p>선택하신 <span style="font-weight: bold;"></span>의 <span> 확인서</span> 는 최종 성적에 절대 점수로 합산됩니다.</p>';
							context += '</div>';
							context += '</div>';
							context += '</div>';
							context += '</div>';

							/* <!-- 김홍일 : 생성한 확인서를 나타내는 표 --> */
							context += '<div style="width: 98%;">';
							context += '<table class="highlight" style="margin-left: 1rem;">';
							context += '<thead>';
							context += '<tr>';
							context += '<th>No</th>';
							context += '<th>기수</th>';
							context += '<th>과목명</th>';
							context += '<th>개별점수 및 확인서 명</th>';
							context += '<th>수정</th>';
							context += '<th>삭제</th>';
							context += '</tr>';
							context += '</thead>';

							context += '<tbody id="smp_aps_group_confirm-' + index + '">';
							/* <!-- 그룹평가 리스트가 앵귤러 js로 출력 --> */
							context += '</tbody>';
							context += '</table>';
							context += '</div>';
							context += '</div>';
							context += '</li>';
							
							flag_confirm = false;
						}else{
							
						}
					}
				})
				context += '</ul>'
				context += '</div>'	
				flag_exam = true;
				flag_subexam = true;
				flag_confirm = true;
			});
			$("#group_list").html($compile(context)($scope));
		}
		
		$scope.commonCssChange = function () {
			$('.collapsible').collapsible();
		}
		
		$scope.tab_draw = function(response){
			var context = '';
			context += '<ul id="group-tabs" class="tabs">';
			group_list = '';
			
			$.each(response.data.resultList, function(index, item){
				context += '<li class="tab col s2"><a href="#" tab_seq="group_tab-'+index+'" seq="'+item.smp_aps_total_seq+'" title="'+item.smp_aps_total_nm+'" ng-click="tab_change($event)"><span>'+item.smp_aps_total_nm+'</span></a></li>';
				
			});
			context += '</ul>';
			$("#group-tabs-div").html($compile(context)($scope));
			$(".tabs").tabs();
		}
		
		$scope.tab_change = function(e){
			//tab 변경에 따른 그룹평가 리스트를 출력
			var gisu_seq = $("#gisuSelect option:selected").val();
			var smp_aps_total_seq = $(e.currentTarget).attr('seq');
			var smp_title = $(e.currentTarget).attr('title');
			var tab_seq = $(e.currentTarget).attr('tab_seq');
			
			$http({
				method : 'POST',
				url : "/smp/admin/selectApsGroupList",
				params : {
					smp_aps_total_seq : smp_aps_total_seq
					,gisu_seq : gisu_seq
				}
			}).then(function successCallback(response) {
				console.log(response.data);
				
				var exam_seq = 0;
				var subexam_seq = 0;
				var confirm_seq = 0;
				
				//그룹평가 리스트 그리기
				var smp_aps_group_exam = '';
				var smp_aps_group_subexam = '';
				var smp_aps_group_confirm = '';
				$.each(response.data, function(index, item){
					
					if(item.smp_aps_group_tp == 'A0900'){
						
						exam_seq += 1;	
						smp_aps_group_exam += '<tr>';
						smp_aps_group_exam += '<td>'+exam_seq+'</td>';
						smp_aps_group_exam += '<td>'+item.gisu_num+'</td>';
						smp_aps_group_exam += '<td>'+smp_title+'</td>';
						smp_aps_group_exam += '<td>'+item.smp_aps_total_ratio+'</td>';
						smp_aps_group_exam += '<td>'+item.smp_aps_group_exam_nm+'</td>';
						smp_aps_group_exam += '<td>'+item.smp_aps_group_exam_ratio+'</td>';
						smp_aps_group_exam += '<td>'+item.smp_aps_group_exam_pp+'</td>';
						smp_aps_group_exam += '<td><a seq="'+item.smp_aps_group_exam_seq+'" class="waves-effect waves-light btn-small">수정</a></td>';
						smp_aps_group_exam += '<td><a seq="'+item.smp_aps_group_exam_seq+'" class="waves-effect waves-light btn-small red" ng-click="deleteGroup(&quot;'
						+ item.smp_aps_group_seq
						+ '&quot;);">삭제</a></td>';
						smp_aps_group_exam += '</tr>';
						
					}else if(item.smp_aps_group_tp == 'A0901'){
						
						subexam_seq += 1;
						smp_aps_group_subexam += '<tr>';
						smp_aps_group_subexam += '<td>'+subexam_seq+'</td>';
						smp_aps_group_subexam += '<td>'+item.gisu_num+'</td>';
						smp_aps_group_subexam += '<td>'+smp_title+'</td>';
						smp_aps_group_subexam += '<td>'+item.smp_aps_group_subexam_nm+'</td>';
						smp_aps_group_subexam += '<td>'+item.smp_aps_group_subexam_pp+'</td>';
						smp_aps_group_subexam += '<td><a seq="'+item.smp_aps_group_subexam_seq+'" class="waves-effect waves-light btn-small">수정</a></td>';
						smp_aps_group_subexam += '<td><a seq="'+item.smp_aps_group_subexam_seq+'" class="waves-effect waves-light btn-small red" ng-click="deleteGroup(&quot;'
						+ item.smp_aps_group_seq
						+ '&quot;);">삭제</a></td>';
						smp_aps_group_subexam += '</tr>';
						
					}else if(item.smp_aps_group_tp == 'A0902'){
						
						confirm_seq += 1;
						smp_aps_group_confirm += '<tr>';
						smp_aps_group_confirm += '<td>'+confirm_seq+'</td>';
						smp_aps_group_confirm += '<td>'+item.gisu_num+'</td>';
						smp_aps_group_confirm += '<td>'+smp_title+'</td>';
						smp_aps_group_confirm += '<td>'+item.smp_aps_group_confirm_nm+'</td>';
						smp_aps_group_confirm += '<td><a seq="'+item.smp_aps_group_confirm_seq+'" class="waves-effect waves-light btn-small">수정</a></td>';
						smp_aps_group_confirm += '<td><a seq="'+item.smp_aps_group_confirm_seq+'" class="waves-effect waves-light btn-small red" ng-click="deleteGroup(&quot;'
						+ item.smp_aps_group_seq
						+ '&quot;);">삭제</a></td>';
						smp_aps_group_confirm += '</tr>';
						
					}
				});
				if(exam_seq != 0){
				$('#smp_aps_group_exam-'+tab_seq.substring(10,11)).html($compile(smp_aps_group_exam)($scope));
				}
				if(subexam_seq != 0){
				$('#smp_aps_group_subexam-'+tab_seq.substring(10,11)).html($compile(smp_aps_group_subexam)($scope));
				}
				if(confirm_seq != 0){
				$('#smp_aps_group_confirm-'+tab_seq.substring(10,11)).html($compile(smp_aps_group_confirm)($scope));
				}
				$('.group_tab').hide();
				$('#group_tab-'+tab_seq.substring(10,11)).show();
				
			}, function errorCallback(response) {
				

			});
		}
		
		
		$scope.deleteGroup = function(seq) {
			
			var smp_aps_group_seq = seq;
			
			$http({
				method : 'POST',
				url : "/smp/deleteGroup",
				params : {
					smp_aps_group_seq: smp_aps_group_seq
				}
			}).then(function successCallback(response) {
				alert("삭제성공");
				$scope.gisu_change();
			}, function errorCallback(response) {
				console.log(response);
				
			});
		}
		
		$scope.updateGroup = function(seq) {
			
			var smp_aps_group_seq = seq;
			location.href = "/smp/admin/aps_group_update_form?smp_aps_group_seq="+smp_aps_group_seq;
			
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
			location.href = "aps_group_insert_form";
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
			class="breadcrumb">평가관리</a> <a href="#!" class="breadcrumb">그룹평가</a>
	</div>

	<!-- 김홍일 : 사이드 메뉴 -->
	<%@include file="aps_sidenav.jsp"%>

	<script type="text/javascript">
		$('#aps_group_a').css('color', 'white');
		$('#aps_group_a').parent().addClass('sidenav_menu_color');
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
		<div class="col s12" id="group-tabs-div">
			<!-- <ul id="group-tabs" class="tabs">
				<li class="tab col s3"><a class="active" href="#group_tab-1"><span>ICT</span></a></li>
				<li class="tab col s3"><a href="#group_tab-2"><span>일본어</span></a></li>
				<li class="tab col s3"><a href="#group_tab-3"><span>학사</span></a></li>
			</ul> -->
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
	
	<div id="group_list">
	</div>
</body>
</html>
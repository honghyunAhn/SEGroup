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
<!-- bxSlider CSS file -->
<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css"
	href="<c:url value="/resources/segroup/society/edu/css/common.css" />">
<link rel="stylesheet" type="text/css"
	href="<c:url value="/resources/segroup/society/edu/css/sub.css" />">
<link rel="stylesheet" type="text/css"
	href="<c:url value="/resources/segroup/society/edu/css/main.css" />">
<!-- 페이징 관련 css 끝 -->

<jsp:include page="../import.jsp" flush="true" />
<!-- 상단메뉴와 하단메뉴 관련 css-->

<title>학생관리</title>

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

			var curPage = curPage;
			var orderType = orderType;
			var orderValue = orderValue;
			var search_name = $("#searchName").val();
			var pageCount = $("#pageSelect option:selected").val();
			
			$http({
				method : 'POST',
				url : "/smp/search_student_list",
				params : {
					gisu_seq : gisu_seq,
					search_name : search_name,
					curPage : curPage,
					pageCount : pageCount,
					orderType : orderType,
					orderValue : orderValue
				}
			}).then(function successCallback(response) {
				$("#orderType1").val(orderType);
				$("#orderValue1").val(orderValue);
				$("#curPage1").val(curPage);
				$scope.list_draw(response);
				
			}, function errorCallback(response) {
				console.log(response);
				
			});
		}

		$scope.list_draw = function(response) {
			var context = '';
			var map = response.data;
			var count = 0;
			$.each(response.data.resultList, function(index, item) {
				context += '<tr>';
				context += '<td>' + (index + map.adminPager.pageBegin) + '</td>';
				context += '<td><img src="/resources/segroup/society/edu/image/main/yeo.jpg;" width="100" height="130"></td>';
				context += '<td>' + item.user_nm + '</td>';
				context += '<td>' + item.birthYear + '</td>';
				context += '<td>' + item.userAge + '</td>';
	            context += '<td><code value="' + item.user_sex + '"></code></td>';
	            context += '<td><code value="' + item.smp_kmove_gb + '"></code></td>';
				context += '<td>' + item.user_birth + '</td>';
				context += '<td>' + item.finalEduNm + '</td>';
				context += '<td>' + item.finalEduMajor + '</td>';
				context += '<td>' + item.smp_class_info + '</td>';
				context += '<td><code value="' + item.smp_app_lo_gb + '"></code></td>';
				context += '<td>' + item.Japanese + '</td>';
				context += '<td>' + item.otherLang + '</td>';
				context += '<td>' + item.cLicense + '</td>';
				context += '<td><code value="' + item.smp_cup_gb + '"></code></td>';
				context += '<td>' + item.smp_class_info + '</td>';
				context += '<td>' + item.user_phone + '</td>';
				context += '<td>' + item.user_email + '</td>';
				context += '<td><code value="' + item.finalEduGdCheck + '"></code></td>';
				context += '<td>' + item.finalEduGdRq + '</td>';
				context += '<td>' + item.smp_residence + '</td>';
				context += '<td><input type="button" onclick="showApply(&quot;' + item.app_id + '&quot;);" class="showApply" value="보기" /></td>';
				context += '<td><input type="button" onclick="memoInsert(&quot;' + item.app_id + '&quot;);" class="showApply" value="메모" /></td>';
				context += '</tr>';
				count++;
			});
			$("#peopleCount").html("총인원: "+count+"명");
			$("#search_data").html($compile(context)($scope));

			
			context = '';
			context += '<div class="pagination_con">';
			context += '<span id="page"style="display: inline; margin:auto; display:table; ">';
			context += '<h4><ul><li><ol>';
			if (map.adminPager.curBlock > 1) {
				context += '<li><input type="button" ng-click="gisu_change(&quot;1&quot;)" name="" value="<<"></li>';
			}
			if (map.adminPager.curBlock > 1) {
				context += '<li><input type="button" ng-click="gisu_change(&quot;' + map.adminPager.prevPage + '&quot;)" name="" value="<"></li>';
			}
			for (var i = map.adminPager.blockBegin; i <= map.adminPager.blockEnd; i++) {
				if (i == map.adminPager.curPage) {
					context += '<li><input id="cur_page_btn" type="button" style="color:red"name="" value="' + i + '"></li>';
				} else {
					context += '<li><input type="button" ng-click="gisu_change(&quot;' + i + '&quot;)" name="" value="' + i + '"></li>';
				}
			}
			if (map.adminPager.curBlock <= map.adminPager.totBlock) {
				context += '<li><input type="button" ng-click="gisu_change(&quot;' + map.adminPager.nextPage + '&quot;)" name="" value=">"></li>';
			}
			if (map.adminPager.curPage <= map.adminPager.totPage) {
				context += '<li><input type="button" ng-click="gisu_change(&quot;' + map.adminPager.totPage + '&quot;)" name="" value=">>"></li>';
			}
			context += '</ol></h4></li></ul></span></div>';

			$(".pagination_wrap").empty();
			$(".pagination_wrap").html($compile(context)($scope));

			// pageCountList 삽입
			context = '';
			context += '<option value="10">10개씩</option>';
			for (var i = 0; i < map.adminPager.pageCountList.length; i++) {
				if (map.adminPager.pageCountList[i] == map.pageCount) {
					context += '<option value="' + map.adminPager.pageCountList[i] + '" selected>' + map.adminPager.pageCountList[i] + '개씩</option>';
				} else {
					context += '<option value="' + map.adminPager.pageCountList[i] + '">' + map.adminPager.pageCountList[i] + '개씩</option>';
				}
			}
			$("#pageSelect").html($compile(context)($scope));
			
		}
	} ]);
	function memoInsert(app_id){
		$("#memo_app_id").val(app_id);
		selectMemo();
	}

	function showApply(app_id) {
	
		var app_id = app_id;
		var gisu_seq = $("#gisuSelect option:selected").val();
		var popupX = (window.screen.width / 2) - (1200 / 2);
		var popupY = (window.screen.height / 2) - (700 / 2) - 50;
		window.open("${path}/smp/admin/student_info_update_form?updateType=student"+"&gisu_seq=" + gisu_seq + "&app_id=" + app_id + "&pageCount=${map.pageCount}&curPage=${map.adminPager.curPage}&orderType=${map.orderType}&orderValue=${map.orderValue}", '지원서 수정', 'width=1200,height=700,left=' + popupX + ',top=' + popupY + ',screenX=' + popupX + ',screenY=' + popupY + ',toolbar=no,location=no,directories=no,status=no,menubar=no,resizable=yes,scrollbars=no,copyhistory=no');
	}
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
	
</script>
</head>
<body id="myBody" ng-app="myapp" ng-controller="AdminController">
	<div id="page">
		<div class="page-inner">
			<%@include file="adminmenu.jsp"%>
			<div class="gtco-section border-bottom">
				<div class="gtco-container">
						<div class="page_title">
							<h2>학생 관리 페이지</h2>
						</div>
						<div class="custom_div">
							<table class="search_box">
								<tr>
									<th>기수 검색</th>
									<td style="float: left;"><select id="gisuSelect"
										onchange="angular.element(this).scope().gisu_change('')">
											<option value="0">선택</option>
											<c:forEach var="data" items="${seaCurList}">
												<option value="${data.gisu_seq }">${data.gisu_crc_nm }</option>
											</c:forEach>
									</select></td>
									<td></td>
								</tr>
								<tr>
									<th>이름으로 검색</th>
									<td><input style="float: left;" type="text" id="searchName"></td>
									<td class="td_search" colspan="2"><button
											class="btn_search" ng-click="gisu_change()">검색</button>
								</tr>
								<tr>
									<th id="peopleCount">총인원:</th>
								</tr>
							</table>
							
							<select id="pageSelect"
								onchange="angular.element(this).scope().gisu_change('')">
								<option value="10">10개씩</option>
							</select>
							<div class="scroll-x">
							<table class="table_manager">
								<thead>
									<tr>
										<th>No</th>
										<th>사진</th>
										<th>이름&nbsp;<a href="javascript:order_change('user_name')"><img class="desc" id="user_name" src="/resources/segroup/society/edu/image/main/triangle_down.png;"></a></th>
										<th>출생연도</th>
										<th>나이(만)</th>
										<th>성별</th>
										<th>구분</th>
										<th>생년월일</th>
										<th>학교</th>
										<th>전공</th>
										<th>클래스&nbsp;<a href="javascript:order_change('user_class')"><img class="desc" id="user_class" src="/resources/segroup/society/edu/image/main/triangle_down.png;"></a></th>
										<th>지원구분</th>
										<th>어학수준</th>
										<th>기타 어학성적</th>
										<th>정보처리기사</th>
										<th>CUP</th>
										<th>해외연수경력 / 교육이수경력</th>
										<th>연락처</th>
										<th>Email</th>
										<th>졸업여부</th>
										<th>비고</th>
										<th>거주지</th>
										<th>수정</th>
										<th>메모</th>
									</tr>
								</thead>
								<tbody id="search_data">

								</tbody>
							</table>
							</div>
						</div>
						<div class="pagination_wrap"></div>
						<div style="display: none;">
							<input type="hidden" id="curPage1" value=""> <input
								type="hidden" id="orderType1" value=""> <input
								type="hidden" id="orderValue1" value="">
						</div>
				</div>
			</div>
			<jsp:include page="../admin/memo_modal.jsp" flush="true"/>
		</div>
	</div>
</body>
</html>
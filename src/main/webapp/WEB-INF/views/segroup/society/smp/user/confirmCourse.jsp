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
			
			$.each(response.data.resultList, function(index, item) {
				context += '<tr>';
				context += '<td><input type="checkbox" class="gisuCheckBox" value="' + item.app_seq + '"/></td>';
				context += '<td>' + (index + map.adminPager.pageBegin) + '</td>';
				context += '<td>' + item.gisu_crc_nm + '</td>';
				context += '<td>' + item.gisu_num + '</td>';
				context += '<td>' + item.app_id + '</td>';
				context += '<td>' + item.user_nm + '</td>';
				context += '<td>' + item.user_phone + '</td>';
				context += '<td>' + item.user_email + '</td>';
				context += '<td><input type="button" onclick="printCourse(&quot;' + item.app_id + '&quot;);" class="showApply" value="보기" /></td>';
				context += '</tr>';

			});
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

	function printCourse(app_id) {
		var form = document.createElement("form");
	    form.setAttribute("method", "post");
	    form.setAttribute("action", "${path}/smp/user/printCourse");
	    
	    var hiddenField = document.createElement("input");
	    hiddenField.setAttribute("type", "hidden");
	    hiddenField.setAttribute("name", "app_id");
	    hiddenField.setAttribute("value", app_id);
	    form.appendChild(hiddenField);
	    
	    document.body.appendChild(form);
	    form.submit();
	}
</script>
</head>
<body id="myBody" ng-app="myapp" ng-controller="AdminController">
	<div id="page">
		<div class="page-inner">
			<%@include file="../admin/adminmenu.jsp"%>
			<div class="gtco-section border-bottom">
				<div class="gtco-container">
						<div class="page_title">
							<h2>수강 증명서 발급</h2>
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
							</table>

							<select id="pageSelect"
								onchange="angular.element(this).scope().gisu_change('')">
								<option value="10">10개씩</option>
							</select>

							<table class="table">
								<thead>
									<tr>
										<th>선택</th>
										<th>No</th>
										<th>과정명</th>
										<th>과정기수</th>
										<th>아이디</th>
										<th>성명</th>
										<th>전화번호</th>
										<th>이메일</th>
										<th>증명서발급</th>
									</tr>
								</thead>
								<tbody id="search_data">

								</tbody>
							</table>
						</div>
						<div class="pagination_wrap"></div>
						<div style="display: none;">
							<input type="hidden" id="curPage1" value=""> <input
								type="hidden" id="orderType1" value=""> <input
								type="hidden" id="orderValue1" value="">
						</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
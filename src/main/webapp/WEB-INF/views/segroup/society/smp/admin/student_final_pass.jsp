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

<title>지원자 관리 폼</title>
<script type="text/javascript">
	$(function() {

		$("#curSelect").change(function() {
			var crc_seq = $(this).val();

			if (crc_seq == 0) {
				//초기화
				var option = "<option value='0'>선택</option>";
				$("#gisuSelect").html(option);
			} else {
				//초기화 후 ajax
				$.ajax({
					type : "POST",
					url : "/edu/admin/search_cur_gisu",
					data : {
						'crc_seq' : crc_seq,
					},
					success : function(data) {
						var option = "<option value='0'>선택</option>";
						$.each(data, function(index, item) {
							option += '<option value="' + item.gisu_seq + '">' + item.gisu_crc_nm + '</option>';
						})
						$("#gisuSelect").html(option);
					},
					error : function(e) {
						console.log(e);
					}
				});
			}

		});

	});

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

		$scope.doc_change = function(doc, app_rt_seq) {
			var app_rt_doc = angular.element(doc).prevAll(".docSelect_prev").next().val();
			var gisu_seq = $("#gisuSelect option:selected").val();
			var curPage = $("#curPage1").val();
			var orderType = $("#orderType1").val();
			var orderValue = $("#orderValue1").val();
			var search_name = $("#searchName").val();
			var pageCount = $("#pageSelect option:selected").val();
			console.log(app_rt_doc);
			$http({
				method : 'POST',
				url : "/edu/admin/apply_result_update",
				params : {
					app_rt_doc : app_rt_doc,
					app_rt_seq : app_rt_seq,
					gisu_seq : gisu_seq,
					curPage : curPage,
					pageCount : pageCount,
					search_name : search_name,
					orderType : orderType,
					orderValue : orderValue
				}
			}).then(function successCallback(response) {
				alert("서류 결과를 변경 하였습니다.");
				$scope.list_draw(response);
			}, function errorCallback(response) {
				console.log(response);
			});

		};

		$scope.itv_change = function(itv, app_rt_seq) {
			var app_rt_itv = angular.element(itv).prevAll(".itvSelect_prev").next().val();
			var gisu_seq = $("#gisuSelect option:selected").val();
			var curPage = $("#curPage1").val();
			var orderType = $("#orderType1").val();
			var orderValue = $("#orderValue1").val();
			var search_name = $("#searchName").val();
			var pageCount = $("#pageSelect option:selected").val();
			console.log(app_rt_itv);
			$http({
				method : 'POST',
				url : "/edu/admin/apply_result_update",
				params : {
					app_rt_itv : app_rt_itv,
					app_rt_seq : app_rt_seq,
					gisu_seq : gisu_seq,
					curPage : curPage,
					pageCount : pageCount,
					search_name : search_name,
					orderType : orderType,
					orderValue : orderValue
				}
			}).then(function successCallback(response) {
				alert("면접 결과를 변경 하였습니다.");
				$scope.list_draw(response);
			}, function errorCallback(response) {
				console.log(response);
			});
		};

		$scope.gisu_change = function(curPage, orderType, orderValue) {
			var gisu_seq = $("#gisuSelect option:selected").val();
			var curPage = curPage;
			var orderType = orderType;
			var orderValue = orderValue;
			var search_name = $("#searchName").val();
			var pageCount = $("#pageSelect option:selected").val();
			
			$http({
				method : 'POST',
				url: "/edu/admin/search_apply_list",
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
		$scope.final_pass = function(app_seq, app_id) {
			var gisu_seq = $("#gisuSelect option:selected").val();
			var curPage = $("#curPage1").val();
			var orderType = $("#orderType1").val();
			var orderValue = $("#orderValue1").val();
			var search_name = $("#searchName").val();
			var pageCount = $("#pageSelect option:selected").val();
			
			$http({
				method : 'POST',
				url : "/smp/admin/final_pass",
				params : {
					app_seq: app_seq,
					app_id : app_id,
					gisu_seq : gisu_seq,
					search_name : search_name,
					curPage : curPage,
					pageCount : pageCount,
					orderType : orderType,
					orderValue : orderValue
				}
			}).then(function successCallback(response) {
				var result = response.result;
				$("#orderType1").val(orderType);
				$("#orderValue1").val(orderValue);
				$("#curPage1").val(curPage);
				alert("합격처리 성공");

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
				context += '<td>' + item.app_ins_dt + '</td>';
				context += '<td>' + item.app_id + '</td>';
				context += '<td>' + item.user_nm + '</td>';
				context += '<td><input type="button" onclick="showApply(&quot;' + item.app_id + '&quot;);" class="showApply" value="보기" /></td>';
				context += '<td><input type="hidden" class="docSelect_prev" />';
				context += '<select id="docSelect" class="docSelect" onchange="angular.element(this).scope().doc_change(this,' + item.app_rt_seq + ')">';
				if (item.app_rt_doc == 'B1400') {
					context += '<option selectcode value="B1400" selected></option>';
					context += '<option selectcode value="B1401"></option>';
					context += '<option selectcode value="B1402"></option>';
				} else if (item.app_rt_doc == 'B1401') {
					context += '<option selectcode value="B1400"></option>';
					context += '<option selectcode value="B1401" selected></option>';
					context += '<option selectcode value="B1402"></option>';
				} else if (item.app_rt_doc == 'B1402') {
					context += '<option selectcode value="B1400"></option>';
					context += '<option selectcode value="B1401"></option>';
					context += '<option selectcode value="B1402" selected></option>';
				}
				context += '</select>';
				context += '</td>';
				context += '<td>' + item.app_rt_doc_dt + '</td>';
				context += '<td>' + item.app_rt_doc_id + '</td>';
				context += '<td><input type="hidden" class="itvSelect_prev" />';
				context += '<select id="itvSelect" class="itvSelect" onchange="angular.element(this).scope().itv_change(this,' + item.app_rt_seq + ')">';
				if (item.app_rt_itv == 'B1700') {
					context += '<option selectcode value="B1700" selected></option>';
					context += '<option selectcode value="B1701"></option>';
					context += '<option selectcode value="B1702"></option>';
				} else if (item.app_rt_itv == 'B1701') {
					context += '<option selectcode value="B1700"></option>';
					context += '<option selectcode value="B1701" selected></option>';
					context += '<option selectcode value="B1702"></option>';
				} else if (item.app_rt_itv == 'B1702') {
					context += '<option selectcode value="B1700"></option>';
					context += '<option selectcode value="B1701"></option>';
					context += '<option selectcode value="B1702" selected></option>';
				}
				context += '</select>';
				context += '</td>';
				context += '<td>' + item.app_rt_itv_dt + '</td>';
				context += '<td>' + item.app_rt_itv_id + '</td>';
				context += '<td><input type="button" value="합격" ng-click="final_pass(&quot;' + item.app_seq + '&quot; ,&quot;'+item.app_id+'&quot;)">';
				context += '</td>';
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

	function order_change(orderType) {
		var orderValue = $('#' + orderType).attr('class');
		if (orderType == 'apply_date') {
			if (orderValue == 'desc') {
				$("#apply_date").attr('class', 'asc');
				$("#apply_date").attr('src', '/resources/segroup/society/edu/image/main/triangle_up.png;');
				orderValue = 'asc';
			} else {
				$("#apply_date").attr('class', 'desc');
				$("#apply_date").attr('src', '/resources/segroup/society/edu/image/main/triangle_down.png;');
				orderValue = 'desc';
			}
		}
		var scope = angular.element(document.getElementById('myBody')).scope();
		scope.gisu_change(1, orderType, orderValue);
	//alert(scope.gisu_seq);
	}

	function showApply(app_id) {
		var app_id = app_id;
		var gisu_seq = $("#gisuSelect option:selected").val();
		var popupX = (window.screen.width / 2) - (1200 / 2);
		var popupY = (window.screen.height / 2) - (700 / 2) - 50;
		window.open("${path}/edu/admin/apply_info_update_form?gisu_seq=" + gisu_seq + "&app_id=" + app_id + "&pageCount=${map.pageCount}&curPage=${map.adminPager.curPage}&orderType=${map.orderType}&orderValue=${map.orderValue}", '지원서 수정', 'width=1200,height=700,left=' + popupX + ',top=' + popupY + ',screenX=' + popupX + ',screenY=' + popupY + ',toolbar=no,location=no,directories=no,status=no,menubar=no,resizable=yes,scrollbars=no,copyhistory=no');
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
						<h2>지원자 관리 페이지</h2>
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
								<td><input type="text" id="searchName"></td>
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
									<th class="sort" onclick="order_change('apply_date')">지원일
									</th>
									<th>아이디</th>
									<th>성명</th>
									<th>지원신청서</th>
									<th>서류전형</th>
									<th>처리일</th>
									<th>담당자</th>
									<th>면접전형</th>
									<th>처리일</th>
									<th>담당자</th>
									<th>최종합격</th>
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
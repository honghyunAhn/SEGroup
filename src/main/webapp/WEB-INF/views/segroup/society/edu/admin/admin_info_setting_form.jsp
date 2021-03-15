<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<script src="<c:url value="/resources/segroup/js/jquery-3.1.1.js" />"></script>
<script src="<c:url value="/resources/segroup/js/jquery-ui.js" />"></script>
<script src="<c:url value="/resources/segroup/js/datepicker.js" />"></script>
<script src="<c:url value="/resources/segroup/js/angular.min.js" />"></script>
<script src="<c:url value="/resources/segroup/society/edu/js/admin_menu.js" />"></script>
<link rel="stylesheet" href="<c:url value="/resources/segroup/css/jquery-ui.min.css" />">
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/segroup/society/edu/css/admin_menu.css" />">
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/segroup/society/edu/css/bootstrap.min.css" />">

<!-- 페이징관련 css 시작 -->
<script src="<c:url value="/resources/segroup/society/edu/js/slidebanner.js" />"></script>
<script src="<c:url value="/resources/segroup/society/edu/js/jquery.bxslider.min.js" />"></script>
<!-- bxSlider CSS file -->
<link href="<c:url value="/resources/segroup/society/edu/css/jquery.bxslider.css" />" rel="stylesheet" />
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/segroup/society/edu/css/common.css" />">
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/segroup/society/edu/css/sub.css" />">
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/segroup/society/edu/css/main.css" />">
<!-- 페이징 관련 css 끝 -->

<style>
#newCur{float:right;margin:10px;margin-top:30px;}
</style>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>글로벌 엔지니어 양성</title>
<script type="text/javascript">
$(function() {
	
	cleanDatepicker();
	$(".admin_expired_st").datepicker();
	$(".admin_expired_et").datepicker();
	
	$("#pageSelect").change(function(){
		var pageCount = $(this).val();
		var searchName = $("#name").val();
		location.href="/edu/admin/admin_info_setting_form?searchName="+searchName+"&pageCount="+pageCount+"&curPage=${map.adminPager.curPage}";
	});
	
});

function cleanDatepicker() {

	var original_gotoToday = $.datepicker._gotoToday;

	$.datepicker._gotoToday = function(id) {
		var target = $(id), inst = this._getInst(target[0]);

		original_gotoToday.call(this, id);
		this._selectDate(id, this._formatDate(inst, inst.selectedDay,
				inst.drawMonth, inst.drawYear));
		target.blur();
	}

	var old_fn = $.datepicker._updateDatepicker;

	$.datepicker._updateDatepicker = function(inst) {
		old_fn.call(this, inst);

		var buttonPane = $(this).datepicker("widget").find(".ui-datepicker-buttonpane");

		$(	"<button type='button' class='ui-datepicker-clean ui-state-default ui-priority-primary ui-corner-all'>clear</button>").appendTo(buttonPane).click(function(ev) {
					$.datepicker._clearDate(inst.input);
		});
	}
}

	var myApp = angular.module('myapp', []);
	
	myApp.controller('AdminController', ['$scope','$compile','$http', function($scope,$compile,$http){
		
		$scope.admin_info = JSON.parse('${admin_info_list_json}');
		
		$scope.update = function($event){

			var _row  = angular.element($event.currentTarget).closest(".admin_row");
				var _admin_id = _row.find(".admin_id").text();
				var _admin_grade = _row.find(".admin_grade").val();
				var _admin_state = _row.find(".admin_state").val();
				var _admin_project = _row.find(".admin_project").val();
				var _admin_expired_st = _row.find(".admin_expired_st").val();
				var _admin_expired_et = _row.find(".admin_expired_et").val();

		 	$http({
				method: 'POST',
				url: '/edu/admin/admin_info_update',
				params : {
					admin_id : _admin_id,
					admin_grade : _admin_grade,
					admin_state : _admin_state,
					admin_project : _admin_project,
					admin_expired_st : _admin_expired_st,
					admin_expired_et : _admin_expired_et
				}
			}).then(function successCallback(response) {
	    		alert("정보 수정 완료 하였습니다.");
			}, function errorCallback(response) {
				console.log(response);
				alert("정보 수정 실패 하였습니다.");
			});
			
		}
	}]);
	
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


	// **원하는 페이지로 이동시 검색조건, 키워드 값을 유지하기 위해 
	function ilist(page){
	    location.href="/edu/admin/admin_info_setting_form?curPage="+page+"&pageCount=${map.pageCount}";
	}

	function search_name(){
		var searchName = $("#name").val();
		location.href="/edu/admin/admin_info_setting_form?searchName="+searchName+"&curPage=${map.adminPager.curPage}&pageCount=${map.pageCount}";
	}
    
</script>
</head>
<body ng-app="myapp" ng-controller="AdminController">
<%@include file="admin_menu.jsp"%>
<div class="page_title">
	<h2>관리자 정보 셋팅</h2>
</div>

<div class="custom_div">
	<table class="search_box">
		<tr>
			<th style="width:6%";>관리자 아이디</th>
			<td><input type="text" id="name"></td>
			<td style="text-align:left;"><button class="btn_search" onclick="search_name();">검색</button></td>
		</tr>
	</table>
	<div>
		<select id="pageSelect" style="float:left;">
			<option value="10">10개씩</option>
			<c:forEach var="data" items="${map.adminPager.pageCountList}">
				<c:if test="${data == map.pageCount}">
					<option value="${data}" selected>${data}개씩</option>
				</c:if>
				<c:if test="${data != map.pageCount}">
					<option value="${data}">${data}개씩</option>
				</c:if>
			</c:forEach>
		</select>
	</div>
	<table class="table">
		<thead>
			<tr>
				<th>번호</th>
                <th>아이디</th>
                <th>이름</th>
                <th>권한</th>
				<th>상태</th>
				<th>프로젝트</th>
				<th>권한 기간 시작일</th>
				<th>권한 기간 종료일</th>
				<th>적용</th>
			</tr>
		</thead>
		<tbody>
				<tr ng-repeat="data in admin_info" class="admin_row">
					<td>{{$index + 1}}</td>
					<td><span class="admin_id">{{data.admin_id}}</span></td>
					<td>{{data.admin_nm}}</td>
					<td>
                    	<select class="admin_grade" ng-model="data.admin_grade">
                    		<option selectcode value="A0600"></option>
                    		<option selectcode value="A0601"></option>
                    		<option selectcode value="A0602"></option>
                    	</select>
                    </td>
                    <td>
                    	<select class="admin_state" ng-model="data.admin_state">
                    		<option selectcode value="A0800"></option>
                    		<option selectcode value="A0801"></option>
                    		<option selectcode value="A0802"></option>
                    		<option selectcode value="A0803"></option>
                    		<option selectcode value="A0804"></option>
                    	</select>
                    </td>
                     <td>
                    	<select class="admin_project" ng-model="data.admin_project">
                    		<option selectcode value="A0700"></option>
                    		<option selectcode value="A0701"></option>
                    		<option selectcode value="A0702"></option>
                    		<option selectcode value="A0703"></option>
                    	</select>
                    </td>
                    <td>
                    	<input type="text" class="admin_expired_st" readonly="readonly" value="{{data.admin_expired_st }}" />
                    </td>
                    <td>
                    	<input type="text" class="admin_expired_et" readonly="readonly" value="{{data.admin_expired_et }}" />
                    </td>
                    <td>
                    	<input type="button" class="updateBtn" ng-click="update($event)" value="적용">
                    </td>
				</tr>
		</tbody>
	</table>
</div>	

<div class="pagination_wrap">
	<div class="pagination_con">
	<span id="page"style="display: inline; margin:auto; display:table; ">
	<h4>
		<ul>
			<li>
				<ol>
				<!-- **처음페이지로 이동 : 현재 페이지가 1보다 크면  [처음]하이퍼링크를 화면에 출력-->
				<c:if test="${map.adminPager.curBlock > 1}">
					<li><input type="button" onclick="javascript:ilist('1')" name="" value="<<"></li>
				</c:if>
				
				<!-- **이전페이지 블록으로 이동 : 현재 페이지 블럭이 1보다 크면 [이전]하이퍼링크를 화면에 출력 -->
				<c:if test="${map.adminPager.curBlock > 1}">
					<li><input type="button" onclick="javascript:ilist('${map.adminPager.prevPage}')" name="" value="<"></li>
				</c:if>
				
				<!-- **하나의 블럭에서 반복문 수행 시작페이지부터 끝페이지까지 -->
				<c:forEach var="num" begin="${map.adminPager.blockBegin}" end="${map.adminPager.blockEnd}">
					<!-- **현재페이지이면 하이퍼링크 제거 -->
					<c:choose>
						<c:when test="${num == map.adminPager.curPage}">
							<li><input type="button" style="color: red"name="" value="${num}"></li>
						</c:when>
						<c:otherwise>
							<li><input type="button" onclick="ilist('${num}')" name="" value="${num}"></li>
						</c:otherwise>
					</c:choose>
				</c:forEach>
				
				<!-- **다음페이지 블록으로 이동 : 현재 페이지 블럭이 전체 페이지 블럭보다 작거나 같으면 [다음]하이퍼링크를 화면에 출력 -->
				<c:if test="${map.adminPager.curBlock <= map.adminPager.totBlock}">
					<li><input type="button" onclick="javascript:ilist('${map.adminPager.nextPage}')" name="" value=">"></li>
				</c:if>
				
				<!-- **끝페이지로 이동 : 현재 페이지가 전체 페이지보다 작거나 같으면 [끝]하이퍼링크를 화면에 출력 -->
				<c:if test="${map.adminPager.curPage <= map.adminPager.totPage}">
					<li><input type="button" onclick="javascript:ilist('${map.adminPager.totPage}')" name="" value=">>"></li>
				</c:if>
				
				</ol>
			</li>
		</ul>
	</h4>
	</span>
	</div>
</div>

</body>
</html>
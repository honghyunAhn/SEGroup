<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">	
	<script src="<c:url value="/resources/segroup/js/jquery-3.1.1.js" />"></script>
	<script src="<c:url value="/resources/segroup/js/angular.min.js" />"></script>
	<!-- modal을 위한 bootstrap -->
	<link rel="stylesheet" type="text/css" href="<c:url value="/resources/segroup/society/fap/css/adminDefault.css" />" />
	<link rel="stylesheet" type="text/css" href="<c:url value="/resources/segroup/society/edu/css/bootstrap.min.css" />">
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
	<title>Bridge Job Fair</title>
	<script type="text/javascript">
		var myApp = angular.module('myapp', []);
		myApp.directive('selectcode', ['$http',function($http){
			return {
				restrict: "A",
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
				,template: "<option>{{filterParams}}</option>"
			}
		}]);
		
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
		
		myApp.controller('AdminController', ['$scope','$compile','$http', function($scope,$compile,$http){
			$scope.open_pt_change = function(){
				$scope.open_pt_init();
			}
			
			$scope.search_nm = function(){
				$scope.open_pt_init();
			}
			
			$scope.open_pt_init = function(){
				var searchNm = $("#searchName").val();
				var countPerPage = $("#count_per_page").val();
				var fap_open_pt_seq = $('#open_pt_title option:selected').val();
				if(fap_open_pt_seq == ""){
					alert("설명회를 선택해 주세요");
					return;
				}
				
				var fap_open_pt_gb = $("#fap_open_pt_gb").val();
				var page = $("#page").val();
				
				$http({
					url: "/fap/admin/fap_open_pt_applier_list",
					method: 'post',
					params: {
							fap_open_pt_seq : fap_open_pt_seq,
							fap_open_pt_gb : fap_open_pt_gb,
							searchNm : searchNm,
							page : page,
							countPerPage : countPerPage
					},
				}).then(function successCallback(response) {
					$scope.open_pt_list_draw(response.data);
				}, function errorCallback(response) {
					console.log(response);
				});
			}
			
			$scope.open_pt_list_draw = function(data){
				
				var count = '총 : '+data.count+'명';
				var num = ($("#page").val() - 1) * 10 + 1;
				var context = '';
				
				$.each(data.result,function(index, item){
					context += '<tr>';
					context += '<td><input type="checkbox" name="applier_check" value="'+item.fap_open_pt_apply_seq+'"></td>';
					context += '<td>'+num+'</td>';
					context += '<td>'+item.user_nm+'</td>';
					context += '<td>'+item.user_birth+'</td>';
					context += '<td><code value="'+item.user_sex+'"></code></td>';
					context += '<td>'+item.user_email+'</td>';
					/* context += '<td>'+item.user_phone+'</td>'; */
					context += '<td>'+item.user_phone.replace(/(\d{3})(\d{4})(\d{4})/, '$1-$2-$3');+'</td>';
					context += '<td>'+item.user_sc_nm+'</td>';
					if(item.fap_personal_user_edu_level == 'B3300'){
						context += '<td><code value="'+item.user_sc_major+'"></code></td>';
					}else{
						context += '<td>'+item.user_sc_major+'</td>';
					}				
					context += '<td>'+item.fap_personal_user_job_objective+'</td>';
					context += '<td>'+item.fap_open_pt_apply_ins_dt+'</td>';
					context += '</tr>';
					num++;
				})
				
				var pageNavi = '';
				if(data.navi.endPageGroup != 1){
					pageNavi += '<div class="faq-body-page">';
					pageNavi += '<div class="page-navi">';
					pageNavi += '<ul>';
					pageNavi += '<li>';
					if(data.navi.currentPage <= 1){
						pageNavi += '<span class="left-arrow">&lt;</span>';
					}else{
						pageNavi += '<a ng-click="pageFnc(\''+(data.navi.currentPage - 1)+'\')">&lt;</a>';
					}
					pageNavi += '</li>';
					for(var i=data.navi.startPageGroup; i <=data.navi.endPageGroup; i++){
						pageNavi += '<li>';
						if(data.navi.currentPage == i){
							pageNavi += '<span class="now">'+i+'</span>';
						}else{
							pageNavi += '<a ng-click="pageFnc(\''+i+'\')">'+i+'</a>';
						}
						pageNavi += '</li>';
					}
					pageNavi += '<li>';
					if(data.navi.currentPage >= data.navi.totalPageCount){
						pageNavi += '<span class="left-arrow">&gt;</span>';
					}else{
						pageNavi += '<a ng-click="pageFnc(\''+(data.navi.currentPage +1)+'\')">&gt;</a>';
					}
					pageNavi += '</li>';
					pageNavi += '</ul>';
					pageNavi += '</div>';
					pageNavi += '</div>';
				}
										
				$(".tbody").html($compile(context)($scope));
				$(".total_count").html(count);
				$(".page_div").html($compile(pageNavi)($scope));
			}
			
			$scope.pageFnc = function(page){
				$("#page").val(page);
				$scope.open_pt_init();
			}
			
			$scope.checked_all = function(){
				$("input:checkbox[name='applier_check']").prop("checked", true);
			}
			
			$scope.print_excel = function(){
				var seq_list = [];
				
				$("input:checkbox[name='applier_check']:checked").each(function() { 
			        seq_list.push($(this).val());
			   });
				
				if(seq_list.length == 0){
					alert("엑셀출력할 대상을 선택해 주세요.");
					return false;
				}else{
					var context = '';
					$.each(seq_list, function(index,item){
						context += '<input type="hidden" name="seq_list" value="'+item+'">';
					})
					$("#excel_form").html(context);
					$("#excel_form").submit();
				}
				
			}
		}]);
	</script>
</head>
<body ng-app="myapp" ng-controller="AdminController">
  <%@include file="admin_menu.jsp"%>
  <br>
	<div class="page_title">
		<h2>오픈잡페어 설명회 지원자 관리</h2>
	</div>
	<br>
	<div class="custom_div">
		<table class="search_box">
			<tr>
				<th>과정명으로 검색</th>
				<td>
					<select id="open_pt_title" ng-model="open_pt_title" ng-change="open_pt_change()">
						<option value="">---설명회를 선택해주세요---</option>
						<c:forEach var="data" items="${result }">
							<option value="${data.fap_open_pt_seq }">${data.fap_open_pt_title }</option>
						</c:forEach>
					</select>
				</td>
				<td></td>
			</tr>
			<tr>
				<th>이름으로 검색</th>
				<td>
					<input type="text" id="searchName">
				</td>
				<td class="td_search" colspan="2">
					<button type="button" class="btn_search" ng-click="search_nm()">검색</button>
				</td>
			</tr>
		</table>
	</div>
	<div class="custom_div">
		<div class="count_wrap">
			<div class="count_per_page_div">
				<select id="count_per_page">
					<option value="10">10개씩 보기</option>
					<option value="50">50개씩 보기</option>
					<option value="100">100개씩 보기</option>
					<option value="1000">1000개씩 보기</option>
				</select>
			</div>
			<div class="total_count">
			</div>
			<div class="print_wrap">
				<button type="button" class="btn_search" ng-click="checked_all()">전체선택</button>
				<button type="button" class="btn_search" ng-click="print_excel()">엑셀출력</button>
			</div>
		</div>
		<table class="table">
			<colgroup>
				<col class="td_w1" />
				<col class="td_w1" />
				<col class="td_w2" />
				<col class="td_w3" />
				<col class="td_w2" />
				<col class="td_w4" />
				<col class="td_w3" />
				<col class="td_w4" />
				<col class="td_w4" />
				<col class="td_w4" />
				<col class="td_w3" />
			</colgroup>
			<thead>
				<tr>
					<th></th>
					<th>No</th>
					<th>이름</th>
					<th>생년월일</th>
					<th>성별</th>
					<th>이메일</th>
					<th>전화번호</th>
					<th>최종학력</th>
					<th>전공</th>
					<th>취업희망직무</th>
					<th>신청일</th>
				</tr>
			</thead>
			<tbody class="tbody">
			</tbody>
		</table>
	</div>
	<div class="page_div">
	</div>
	
	<input type="hidden" id="fap_open_pt_gb" name="fap_open_pt_gb" value="D1000">
	<input type="hidden" id="page" name="page" value="1">
	<input type="hidden" id="searchNm" name="searchNm">
	<input type="hidden" id="fap_open_pt_seq" name="fap_open_pt_seq">
	
	<form action="/fap/admin/fap_open_pt_print_excel" method="post" id="excel_form">
		
	</form>
</body>
</html>
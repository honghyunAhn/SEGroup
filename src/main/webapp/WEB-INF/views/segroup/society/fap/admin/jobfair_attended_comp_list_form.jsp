<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">	
	<link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
	<script src="<c:url value="/resources/segroup/js/jquery-3.1.1.js" />"></script>
	<script src="<c:url value="/resources/segroup/js/jquery-ui.js" />"></script>
	<script src="<c:url value="/resources/segroup/js/angular.min.js" />"></script>
	<script src="<c:url value="/resources/segroup/js/datepicker.js" />"></script>
	<script type="text/javascript" src="/resources/segroup/js/jquery.timepicker.min.js"></script>
	<link type="text/css" rel="stylesheet" href="/resources/segroup/css/jquery.timepicker.css" media="" />
	<!-- modal을 위한 bootstrap 시작-->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
	<!--  modal을 위한 bootstrap 끝 -->
	
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
		
		//codeconverter
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
		}]);
		
		myApp.controller('PermissionController', ['$scope','$compile','$http', function($scope,$compile,$http){			
	        
			var fap_jobfair_seq = $('#select_jobfair').val();
			var fap_jobfair_divide_seq = $('#select_jobfair_divide option:selected').attr('seq');
			
			if(fap_jobfair_divide_seq == 0){
				$http({
					method: 'POST',
					url: "/fap/admin/search_jobfair_attended_comp_list",
					params : {
						fap_jobfair_seq : fap_jobfair_seq
					}
				}).then(function successCallback(response) {
					 $scope.list_draw(response);
					 
				}, function errorCallback(response) {
				
				});
			}
			
			
	        //변경시 다시 검색
			$scope.search_change = function(flag){				
				
	        	//잡페어 변경
				if(flag == 1){
					var fap_jobfair_seq = $('#select_jobfair').val();
					var fap_jobfair_divide_seq = 0;
					
					//jobfair_divide 활성화
					if($("#select_jobfair option:selected").val() != 0 ){
						$("#jobfair_divide_hidden").prop("selected", true);
						$("#select_jobfair_divide").html("<option value=\'"+0+"\' id=\"jobfair_divide_hidden\" seq=\"" + 0 + "\"  hidden>선택</option>");					
						$("#select_jobfair_divide").attr("disabled", false);
					}else{
						$("#jobfair_divide_hidden").prop("selected", true);
						$("#select_jobfair_divide").html("<option value=\'"+0+"\' id=\"jobfair_divide_hidden\" seq=\"" + 0 + "\"  hidden>선택불가</option>");					
						$("#select_jobfair_divide").attr("disabled", true);	
					}										
				
					$http({
						method: 'POST',
						url: "/fap/admin/search_jobfair_attended_comp_list",
						params : {
							fap_jobfair_seq : fap_jobfair_seq
						}
					}).then(function successCallback(response) {
						 $scope.list_draw(response);
						 
					}, function errorCallback(response) {
					
					});
					
					$http({
						method : 'POST',
						url : '/fap/admin/select_all_job_fair_divide',
						responseType : 'text',
						params : {
							fap_jobfair_seq : $("#select_jobfair option:selected").val()
							, fap_jobfair_divide_seq : fap_jobfair_divide_seq
						}
					}).then(function successCallback(response) {
						//jobfair_divide에 option 추가
						for(var i in response.data){
							$("#select_jobfair_divide").append($compile("<option selectcode value=" 
									+ response.data[i].fap_jobfair_divide_gb + " seq=\"" + response.data[i].fap_jobfair_divide_seq + "\"></option>")($scope));
						}
						
					}, function errorCallback(response) {
					
					});
				}
				
	        	//잡페어 세부 변경
				var fap_jobfair_seq = $('#select_jobfair').val();
				var fap_jobfair_divide_seq = $('#select_jobfair_divide option:selected').attr('seq');
				
				if(fap_jobfair_divide_seq != undefined && fap_jobfair_divide_seq != 0){
					$http({
						method: 'POST',
						url: "/fap/admin/search_jobfair_attended_comp_list",
						params : {
							fap_jobfair_seq : fap_jobfair_seq
							, fap_jobfair_divide_seq : fap_jobfair_divide_seq
						}
					}).then(function successCallback(response) {
						 $scope.divide_list_draw(response);
					}, function errorCallback(response) {
					
					});
				}				
				
			}
	        
			//잡페어 참가 기업리스트
			$scope.list_draw = function(response){
				$scope.results = response.data;
				var context = '';
				context += '<tr ng-repeat="results in results | filter:query">';
				context += '<td>{{$index+1}}</td>';				
				context += '<td>{{results.fap_jobfair_title}}</td>';
				context += '<td ng-if="results.fap_jobfair_divide_gb == \'C0100\' "><code value="C0100"></code></td>';
				context += '<td ng-if="results.fap_jobfair_divide_gb == \'C0101\' "><code value="C0101"></code></td>';
				context += '<td ng-if="results.fap_jobfair_divide_gb == \'C0102\' "><code value="C0102"></code></td>';
				context += '<td>{{results.fap_comp_en_nm}}</td>';
				context += '<td>{{results.fap_jobfair_comp_ins_dt}}</td>';
				context += '</td>';
				context += '</tr>';
				
				$("#search_data").html($compile(context)($scope)); 				
			}	
			
			//잡페어 참가 기업리스트
			$scope.divide_list_draw = function(response){
				$scope.result = response.data;
				var context = '';
				context += '<tr ng-repeat="result in result | filter:query">';
				context += '<td>{{$index+1}}</td>';				
				context += '<td>{{result.fap_jobfair_title}}</td>';
				context += '<td ng-if="result.fap_jobfair_divide_gb == \'C0100\' "><code value="C0100"></code></td>';
				context += '<td ng-if="result.fap_jobfair_divide_gb == \'C0101\' "><code value="C0101"></code></td>';
				context += '<td ng-if="result.fap_jobfair_divide_gb == \'C0102\' "><code value="C0102"></code></td>';
				context += '<td>{{result.fap_comp_en_nm}}</td>';
				context += '<td>{{result.fap_jobfair_comp_ins_dt}}</td>';
				context += '</td>';
				context += '</tr>';
				
				$("#search_data").html($compile(context)($scope)); 				
			}	
			
		}]);	
			
	</script>
	
	<style type="text/css">
	#myModal, #modal_dialog, #modal_content, #modal_body {
		height: 1px;
	}
	
	.wrap {
		width: 95%;
		position: relative;
		display: inline-block;
	}
	
	.wrap textarea {
		width: 100%;
		resize: none;
		line-height: 1.6em;
	}
	
	.wrap span {
		position: absolute;
		bottom: 10px;
		right: 1px;
	}
	
	#counter {
		background: rgba(255, 0, 0, 0.5);
		border-radius: 0.5em;
		padding: 0 .5em 0 .5em;
		font-size: 0.75em;
	}
	</style>
		
</head>
<body id="myBody" ng-app="myapp" ng-controller="PermissionController">
<%@include file="admin_menu.jsp"%><br>
	<div class="page_title">
		<h2>JobFair 참가 기업 목록 확인 페이지</h2>
	</div>
	<br>
	<div class="search_div">
		<table class="search_box">
			<tr>
				<th>잡페어명으로 검색</th>	
				<td>
					<select id="select_jobfair" onchange="angular.element(this).scope().search_change(1)">
						<option value="0">잡페어를 선택하세요</option>
						<c:forEach var="data" items="${jobfairList }">
							<option value="${data.fap_jobfair_seq }">${data.fap_jobfair_title }</option>
						</c:forEach>
					</select>
				</td>
				<th>세부 잡페어명으로 검색</th>	
				<td>
					<select id="select_jobfair_divide" onchange="angular.element(this).scope().search_change()">
						<option value="0" id="jobfair_divide_hidden" seq="0" hidden>선택 불가</option>
					</select>
				</td>
				<th>기업명 검색</th>
				<td><input type="text" ng-model="query"></td>			
			</tr>
		</table>
				
		<table class="table">
			<thead>
				<tr>
					<th>No &nbsp;</th>
					<th>잡페어명 &nbsp;</th>
					<th style="width: 200px;">세부 &nbsp;</th>
					<th>기업명 &nbsp;</th>
					<th>날짜 &nbsp;</th>
				</tr>
			</thead>
			<tbody id="search_data">
				
			</tbody>
		</table>
		
	</div>
	
	<!-- <div class="pagination_wrap"></div>
	<div style="display: none;">
		<input type="hidden" id="curPage1" value="">
		<input type="hidden" id="orderType1" value="">
		<input type="hidden" id="orderValue1" value="">
	</div> -->
	
</body>
</html>
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
		
		myApp.controller('PermissionController', ['$scope','$compile','$http', function($scope,$compile,$http){	
			
	        //검색할 지원자 변경시 다시 검색
			$scope.search_change = function(flag){
				
	        	//잡페어명으로 검색
				if(flag == 1){
					$scope.fap_jobfair_seq = $("#select_jobfair option:selected").val();
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
						method : 'POST',
						url : '/fap/admin/select_all_job_fair_divide',
						responseType : 'text',
						params : {
							fap_jobfair_seq: $("#select_jobfair option:selected").val()
						}
					}).then(function successCallback(response) {
						console.log(response);
						//jobfair_divide에 option 추가
						for(var i in response.data){
							$("#select_jobfair_divide").append($compile("<option selectcode value=" 
									+ response.data[i].fap_jobfair_divide_gb + " seq=\"" + response.data[i].fap_jobfair_divide_seq + "\"></option>")($scope));
						}
						
					}, function errorCallback(response) {
					
					});
					
					if($("#select_jobfair_divide").val() == 0){
						context = '';
						$("#search_data").html($compile(context)($scope));
					}
					
				}
				
				//세부 잡페어명으로 선택
				if(flag == 2){
					var fap_jobfair_divide_seq = $("#select_jobfair_divide option:selected").attr('seq');
					$http({
						method : 'POST',
						url : '/fap/admin/search_user_apply_numbers',
						responseType : 'text',
						params : {
							fap_jobfair_divide_seq: fap_jobfair_divide_seq
						}
					}).then(function successCallback(response) {
						console.log(response);
						$scope.list_draw(response);
						
					}, function errorCallback(response) {
					
					});
				}		
				
			}
	        
			//잡페어 참가 지원자
			$scope.list_draw = function(response){
				$scope.results = response.data;
				var context = '';
				context += '<tr ng-repeat="results in results | filter:query">';				
				context += '<input type="hidden" name="fap_jobfair_seq" value="'+$scope.fap_jobfair_seq+'">';
				context += '<input type="hidden" name="fap_jobfair_divide_seq" value="{{results.fap_jobfair_divide_seq}}">';
				context += '<input type="hidden" name="fap_user_apply_numbers_list[{{$index}}].fap_user_apply_numbers_seq" value="{{results.fap_user_apply_numbers_seq}}">';
				context += '<input type="hidden" name="fap_user_apply_numbers_list[{{$index}}].fap_user_apply_numbers_auto_gb" value="{{results.fap_user_apply_numbers_auto_gb}}">';
				context += '<td>{{$index+1}}</td>';				
				context += '<td>{{results.user_nm}}</td>';
				context += '<td>{{results.user_id}}</td>';
				context += '<td ng-if="results.user_flag == \'A0100\' "><code value="A0100"></code></td>';
				context += '<td ng-if="results.user_flag == \'A0101\' "><code value="A0101"></code></td>';
				context += '<td ng-if="results.user_flag == \'A0106\' "><code value="A0106"></code></td>';
				context += '<td><input type="number" name="fap_user_apply_numbers_list[{{$index}}].fap_user_apply_numbers_fixed" value="{{results.fap_user_apply_numbers_fixed}}"></td>';
				context += '<td ng-if="results.fap_user_apply_numbers_auto_gb == \'D0100\' "><code value="D0100"></code></td>';
				context += '<td ng-if="results.fap_user_apply_numbers_auto_gb == \'D0101\' "><code value="D0101"></code></td>';
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
		<h2>잡페어 지원자 지망가능 갯수 설정</h2>
	</div>
	<br>
	<div class="search_div">
		<form action="/fap/admin/update_user_apply_numbers" method="post">
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
						<select id="select_jobfair_divide" onchange="angular.element(this).scope().search_change(2)">
							<option value="0" id="jobfair_divide_hidden" seq="0" hidden>선택 불가</option>
						</select>
					</td>
					<th>
						<button>설정</button>
					</th>			
				</tr>
			</table>
		
			<table class="table">
				<thead>
					<tr>
						<th>No &nbsp;</th>
						<th>지원자명 &nbsp;</th>
						<th>아이디 &nbsp;</th>
						<th>회원구분 &nbsp;</th>
						<th>지망개수 &nbsp;</th>
						<th>설정구분 &nbsp;</th>
					</tr>
				</thead>
				<tbody id="search_data">
					
				</tbody>
			</table>			
		</form>
		
	</div>
	
	<!-- <div class="pagination_wrap"></div>
	<div style="display: none;">
		<input type="hidden" id="curPage1" value="">
		<input type="hidden" id="orderType1" value="">
		<input type="hidden" id="orderValue1" value="">
	</div> -->
	
</body>
</html>
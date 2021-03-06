<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">	
	<script src="<c:url value="/resources/segroup/js/jquery-3.1.1.js" />"></script>
	<script src="<c:url value="/resources/segroup/js/angular.min.js" />"></script>
	<!-- modal์ ์ํ bootstrap -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
<title>Bridge Job Fair</title>
<script type="text/javascript">
	var myApp = angular.module('myapp', []);
	
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
	
	myApp.controller('AdminController', ['$scope','$compile','$http', function($scope,$compile,$http){
		
		$scope.jobfair_change = function(){
			var fap_jobfair_seq = $("#jobfairSelect option:selected").val();
			if(fap_jobfair_seq != 0){
				$http({
					method: 'POST',
					url: "/fap/admin/per_comp_temp_payment_search",
					params : {
						fap_jobfair_seq : fap_jobfair_seq
					}
				}).then(function successCallback(response) {
					
					console.log(response.data);
					
					$scope.drawlist(response.data);
					
				}, function errorCallback(response) {
					console.log(response);
				});
			}else{
				$("#tbody").html("");
			}
		}
		
		$scope.drawlist = function(data){
			
			var context = '';
			
			$.each(data, function(index,item){
				context += '<tr class="hidden_tr">';
				context += '<td>';
				context += item.fap_comp_ja_nm;
				context += '</td>';
				context += '<td>';
				context += item.fap_comp_en_nm;
				context += '</td>';
				context += '<td>';
				context += '<code value="'+item.user_flag+'"></code>';
				context += '</td>';
				context += '<td>';
				if(typeof item.fap_per_jobfair_temp_group_nm != "undefined"){
					context += item.fap_per_jobfair_temp_group_nm;
				}else{
					context += '๋ฏธ์ง์?';
				}
				context += '</td>';
				context += '<td>';
				if(typeof item.fap_per_comp_temp_payment_gb != "undefined"){
					context += '<code value="'+item.fap_per_comp_temp_payment_gb+'"></code>';
				}else{
					context += '๋ฏธ์ง์?';
				}
				context += '</td>';
				context += '<td>';
				if(typeof item.fap_per_comp_temp_payment_seq != "undefined"){
					context += '<input type="hidden" class="payment_seq" value="'+item.fap_per_comp_temp_payment_seq+'">';
				}
				if(typeof item.fap_per_jobfair_temp_group_seq != "undefined"){
					context += '<input type="hidden" class="group_seq" value="'+item.fap_per_jobfair_temp_group_seq+'">';
				}
				if(typeof item.fap_per_comp_temp_payment_gb != "undefined"){
					context += '<input type="hidden" class="payment_gb" value="'+item.fap_per_comp_temp_payment_gb+'">';
				}
				context += '<input type="button" ng-click="showModal($event)" cid="'+item.fap_comp_id+'" cnm="'+item.fap_comp_ja_nm+'" value="์?์ฉ">';
				context += '</td>';
				context += '<td>';
				context += '<input type="button" ng-click="payment_delete($event)" value="์?์ฉํด์?">';
				context += '</td>';
				context += '</tr>';
			});
			
			$("#tbody").html($compile(context)($scope));
		}
		
		$scope.payment_delete = function(e){
			var payment_seq = $(e.currentTarget).closest(".hidden_tr").find(".payment_seq").val();
			
			if(typeof payment_seq != "undefined"){
				if(confirm("๊ฒฐ์?์?๋ณด๋ฅผ ํด์?ํ๊ฒ?์ต๋๊น?")){
					$http({
						method: 'POST',
						url: "/fap/admin/per_comp_temp_payment_delete",
						params : {
							payment_seq : payment_seq
						}
					}).then(function successCallback(response) {
						
						$scope.jobfair_change();
						
					}, function errorCallback(response) {
						console.log(response);
					});
				}
			}else{
				alert("์?์ฉํ๊ฒ๋ง ํด์?ํ? ์ ์์ต๋๋ค.");
			}
		}
		
		$scope.showModal = function(e){
			
			var fap_jobfair_seq = $("#jobfairSelect option:selected").val();
			var fap_comp_id = $(e.currentTarget).attr("cid");
			var fap_comp_nm = $(e.currentTarget).attr("cnm");
			var payment_seq = $(e.currentTarget).prevAll(".payment_seq").val();
			var group_seq = $(e.currentTarget).prevAll(".group_seq").val();
			var payment_gb = $(e.currentTarget).prevAll(".payment_gb").val();
			
			$scope.payment_gb = payment_gb;
			$("#payment_seq").val(payment_seq);
			$("#fap_comp_id").val(fap_comp_id);
			
			if(fap_jobfair_seq != 0){
				$http({
					method: 'POST',
					url: "/fap/admin/per_jobfair_temp_group_search",
					params : {
						fap_jobfair_seq : fap_jobfair_seq
					}
				}).then(function successCallback(response) {
					
					$scope.drawModal(response.data,fap_comp_nm,group_seq);
					if(response.data.length == 0){
						alert("ํด๋น ์กํ์ด์ ๊ฒฐ์?๋น์ฉ ๊ทธ๋ฃน ๋ฑ๋ก์ ํด์ฃผ์ธ์.");
					}else{
						$('#myModal').modal('show');
					}
					
				}, function errorCallback(response) {
					console.log(response);
				});
			}
			
			
		}
		
		
		$scope.drawModal = function(data,fap_comp_nm,group_seq){
			
			var context = '<table class="table">';
			context += '<tr>';
			context +='<td>'+fap_comp_nm+'</td>';
			context += '</tr>';
			$.each(data,function(index,item){
				context +='<tr>';
				context +='<td>';
				if(typeof group_seq != "undefined"){
					if(item.fap_per_jobfair_temp_group_seq == group_seq){
						context +='<input type="radio" name="payment_radio" checked value='+item.fap_per_jobfair_temp_group_seq+'>';
					}else{
						context +='<input type="radio" name="payment_radio" value='+item.fap_per_jobfair_temp_group_seq+'>';
					}
				}else{
					context +='<input type="radio" name="payment_radio" value='+item.fap_per_jobfair_temp_group_seq+'>';
				}
				context +='</td>';
				context +='<td>'+item.fap_per_jobfair_temp_group_nm+'</td>';
				$.each(item.divideList, function(index2, item2){
					context +='<td><code value="'+item2.fap_jobfair_divide_gb+'"></code></td>';
					context +='<td>'+item2.fap_per_jobfair_divide_temp_cost+'</td>';
				})
				context +='</tr>';
			})
			context +='<tr>';
			context +='<td>';
			context +='<input type="radio" name="payment_gb_radio" value="E0300" ng-model="payment_gb">';
			context +='๋ธ์ถ';
			context +='</td>';
			context +='<td>';
			context +='<input type="radio" name="payment_gb_radio" value="E0301" ng-model="payment_gb">';
			context +='๋ฏธ๋ธ์ถ';
			context +='</td>';
			context +='</tr>';
			context +='<tr>';
			context +='<td>';
			context +='<input type="radio" name="payment_vip_gb_radio" value="E0400" ng-model="payment_vip_gb">';
			context +='์ด์ฒญ๊ธฐ์';
			context +='</td>';
			context +='<td>';
			context +='<input type="radio" name="payment_vip_gb_radio" value="E0401" ng-model="payment_vip_gb">';
			context +='์ผ๋ฐ๊ธฐ์';
			context +='</td>';
			context +='</tr>';
			context +='</table>';
			
			$(".modal-body").html($compile(context)($scope));
		}
		
		$scope.payment_save = function(){
			
			var payment_seq = $("#payment_seq").val();
			var fap_comp_id = $("#fap_comp_id").val();
			var group_seq = $(':input[name=payment_radio]:radio:checked').val();
			var payment_gb = $(':input[name=payment_gb_radio]:radio:checked').val();
			var payment_vip_gb = $(':input[name=payment_vip_gb_radio]:radio:checked').val();
			
			if(typeof payment_seq != "undefined" && payment_seq != ""){
				
				$http({
					method: 'POST',
					url: "/fap/admin/per_comp_temp_payment_update",
					params : {
						payment_seq : payment_seq
						,group_seq : group_seq
						,payment_gb : payment_gb
						,payment_vip_gb : payment_vip_gb
					}
				}).then(function successCallback(response) {
					
					$scope.jobfair_change();
					
				}, function errorCallback(response) {
					console.log(response);
				});
				
			}else{
				if(typeof group_seq == "undefined" || group_seq == ""){
					alert("๊ทธ๋ฃน์ ์?ํํด ์ฃผ์ธ์.");
					return ;
				}else if(typeof payment_gb == "undefined" || payment_gb == ""){
					alert("๋ธ์ถ ์ฌ๋ถ๋ฅผ ์?ํํด ์ฃผ์ธ์.");
					return ;
				}else if(typeof payment_vip_gb == "undefined" || payment_vip_gb == ""){
					alert("๊ธฐ์ ์ฌ๋ถ๋ฅผ ์?ํํด ์ฃผ์ธ์.");
					return ;
				}else{
					$http({
						method: 'POST',
						url: "/fap/admin/per_comp_temp_payment_insert",
						params : {
							fap_comp_id : fap_comp_id
							,group_seq : group_seq
							,payment_gb : payment_gb
							,payment_vip_gb : payment_vip_gb
						}
					}).then(function successCallback(response) {
						
						$scope.jobfair_change();
						
					}, function errorCallback(response) {
						console.log(response);
					});
				}
			}
			
			
			
			$('#myModal').modal('hide');
		}
		
	}]);
	</script>
</head>
<body  ng-app="myapp" ng-controller="AdminController">
<%@include file="admin_menu.jsp"%>
	<br>
	<div class="page_title">
		<h2>ํ์ฌ๋ณ ์์ ๊ฒฐ์? ๊ทธ๋ฃน ๊ด๋ฆฌ</h2>
	</div>
	<br>
	<select id="jobfairSelect" onchange="angular.element(this).scope().jobfair_change()">
		<option value="0">์กํ์ด๋ฅผ ์?ํํ์ธ์</option>
		<c:forEach var="data" items="${jobfairList }">
			<option value="${data.fap_jobfair_seq }">${data.fap_jobfair_title }</option>
		</c:forEach>
	</select>
	
	<a href="/fap/admin/admin_main">๋ฉ์ธ์ผ๋ก</a>
	
	<table class="table">
		<thead>
			<tr>
				<th>
					ํ์ฌ๋ช(์ผ๋ฌธ)
				</th>
				<th>
					ํ์ฌ๋ช(์๋ฌธ)
				</th>
				<th>
					๊ตฌ๋ถ
				</th>
				<th>
					๊ทธ๋ฃน๋ช
				</th>
				<th>
					๋ธ์ถ์ฌ๋ถ
				</th>
				<th>
					์?์ฉ
				</th>
				<th>
					์?์ฉํด์?
				</th>
			</tr>
		</thead>
		<tbody id="tbody">
			
		</tbody>
	</table>
	
	<!-- ๋ชจ๋ฌ -->
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	  <div class="modal-dialog modal-lg">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h4 class="modal-title" id="myModalLabel">๊ฒฐ์?๋น์ฉ ์ค์?</h4>
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	      </div>
	      <div class="modal-body">
	       
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-default" data-dismiss="modal">์ทจ์</button>
	        <button type="button" class="btn btn-primary" ng-click="payment_save()">์?์ฅ</button>
	      </div>
	    </div>
	  </div>
	</div>
	
	<!-- ํ๋? -->
	<input type="hidden" id="payment_seq">
	<input type="hidden" id="group_seq">
	<input type="hidden" id="payment_gb">
	<input type="hidden" id="fap_comp_id">
	
</body>
</html>
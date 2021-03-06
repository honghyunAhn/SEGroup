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
	<script src="<c:url value="/resources/segroup/js/timepicker.js" />"></script>
	<link type="text/css" rel="stylesheet" href="/resources/segroup/css/jquery.timepicker.css" media="" />
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
	<link type="text/css" rel="stylesheet" href="<c:url value="/resources/segroup/society/fap/css/newAdminDefault.css" />" media="" />
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
			
			$scope.jobfair_change = function(){
				var fap_jobfair_seq = $("#jobfairSelect option:selected").val();
				$("#search_data").html('');
				if(fap_jobfair_seq != 0){
					$http({
						method: 'POST',
						url: "/fap/admin/select_all_job_fair_divide",
						params : {
							fap_jobfair_seq : fap_jobfair_seq
						}
					}).then(function successCallback(response) {
						$scope.jobfair_divide_draw(response.data);
						
						$("#insertDiv").css("display","none");
						
					}, function errorCallback(response) {
						console.log(response);
					});
				}
			}
			
			$scope.jobfair_divide_draw = function(data){
				var context = '';
				context += '<option seq="0">?????? ???????????? ???????????????</option>';
				
				$.each(data , function(index , item){
					context += '<option selectcode value="'+item.fap_jobfair_divide_gb+'" seq="'+item.fap_jobfair_divide_seq+'"></option>';
				});
				
				$("#jobfairDivideSelect").html($compile(context)($scope));
			}
			
			$scope.jobfair_divide_change = function(){
				var fap_jobfair_divide_seq = $("#jobfairDivideSelect option:selected").attr("seq");
				
				$("#insertDiv").css("display","none");
				
				if(fap_jobfair_divide_seq != 0){
					$http({
						method: 'POST',
						url: "/fap/admin/final_decision_time_select",
						params : {
							fap_jobfair_divide_seq : fap_jobfair_divide_seq
						}
					}).then(function successCallback(response) {
						$scope.list_draw(response.data);
					}, function errorCallback(response) {
						console.log(response);
					});
				}else{
					$("#search_data").html('');
				}
			}
			
			$scope.list_draw = function(data){
				var context = '';
				$.each(data, function(index,item){
					context += '<tr>';
					context += '<td><input type="checkbox" class="settingCheckBox" name="checkBoxs" value="'+item.fap_jobfair_final_decision_time_seq+'"/></td>';
					context += '<td>'+(index+1)+'</td>';
					context += '<td class="newline" title="'+item.fap_jobfair_final_decision_time_ct+'">'+item.fap_jobfair_final_decision_time_ct+'</td>'
					context += '<td>'+item.fap_jobfair_final_decision_time_st+'</td>';
					context += '<td>'+item.fap_jobfair_final_decision_time_et+'</td>';
					context += '<td><code value="'+item.fap_jobfair_final_decision_time_gb+'"></code></td>';
					context += '<td><button class="btn btn-info"  ng-click="final_commit(\''+item.fap_jobfair_final_decision_time_gb+'\',\''+item.fap_jobfair_divide_seq+'\')">??????</button></td>';
					context += '</tr>';
				});
				
				$("#search_data").html($compile(context)($scope));
			}
			
			$scope.final_commit = function(fap_jobfair_final_decision_time_gb, fap_jobfair_divide_seq){
				if(confirm("????????? ?????? ???????????? ????????? ?????? ????????? ??????\r\n???????????? ?????? ?????? ?????????.\r\n?????????????????????????")){
					if(fap_jobfair_final_decision_time_gb == 'D0900'){
						$http({
							method: 'POST',
							url: "/fap/admin/final_decision_commit_op",
							params : {
								fap_jobfair_divide_seq : fap_jobfair_divide_seq
							}
						}).then(function successCallback(response) {
							alert("?????????????????????.");
						}, function errorCallback(response) {
							console.log(response);
						});
					}else if(fap_jobfair_final_decision_time_gb == 'D0901'){
						$http({
							method: 'POST',
							url: "/fap/admin/final_decision_commit_ns",
							params : {
								fap_jobfair_divide_seq : fap_jobfair_divide_seq
							}
						}).then(function successCallback(response) {
							alert("?????????????????????.");
						}, function errorCallback(response) {
							console.log(response);
						});
					}else if(fap_jobfair_final_decision_time_gb == 'D0902'){
						$http({
							method: 'POST',
							url: "/fap/admin/final_decision_commit_last",
							params : {
								fap_jobfair_divide_seq : fap_jobfair_divide_seq
							}
						}).then(function successCallback(response) {
							alert("?????????????????????.");
						}, function errorCallback(response) {
							console.log(response);
						});
					}
				}
			}
			
			$scope.compPassBtn = function(){
				var fap_jobfair_divide_seq = $("#jobfairDivideSelect option:selected").attr("seq");
				
				if(fap_jobfair_divide_seq == 0) {
					alert("?????? ???????????? ????????? ?????????.");
				}else{
					if(confirm("????????? ?????? ???????????????????")){
						$http({
							method: 'POST',
							url: "/fap/admin/final_decision_pass_to_comp",
							params : {
								fap_jobfair_divide_seq : fap_jobfair_divide_seq
							}
						}).then(function successCallback(response) {
							alert("?????????????????????.");
						}, function errorCallback(response) {
							console.log(response);
						});
					}
				}
			}
			
			$scope.setting_delete = function(){
				var fap_jobfair_set_seq_list = new Array();
	        	$("input:checkbox[name=checkBoxs]:checked").each(function(){
	        		fap_jobfair_set_seq_list.push($(this).val());
	        	});        	
	        	
	        	if(fap_jobfair_set_seq_list.length == 0){
	          	 	alert('????????? ????????? ???????????????.');
	          		return;
	            }
	        	
	            if (confirm("?????? ??????????????????????????") == true){
	            	var fap_jobfair_divide_seq = $("#jobfairDivideSelect option:selected").attr("seq");
	
	            	var fap_jobfair_set_map = {};
	            	fap_jobfair_set_map['fap_jobfair_set_seq_list'] = fap_jobfair_set_seq_list;
	            	fap_jobfair_set_map['fap_jobfair_divide_seq'] = fap_jobfair_divide_seq;
	            	
	            	
	            	$http({
	    				method: 'POST',
	    				url: "/fap/admin/final_decision_time_delete",
	    				headers: {'Content-Type': 'application/json'},
	    				data : JSON.stringify(fap_jobfair_set_map),
	    				XMLHttpRequestResponseType: 'json'
	    			}).then(function successCallback(response) {
	    					$scope.list_draw(response.data);
	    					alert("????????? ?????? ???????????????.");
	    			}, function errorCallback(response) {
	    					console.log(response);
	    			});
	            	
	           	}else{
	           	   return;
	           }
			}
			
			$scope.final_insert = function(){
				var fap_jobfair_divide_seq = $("#jobfairDivideSelect option:selected").attr("seq");
				var fap_jobfair_final_decision_time_gb = $("#fap_jobfair_final_decision_time_gb").val();
				var fap_jobfair_final_decision_time_st = $("#jobfair_st").val();
				var fap_jobfair_final_decision_time_et = $("#jobfair_et").val();
				var fap_jobfair_final_decision_time_ct = $("#fap_jobfair_final_decision_time_ct").val();
				
				if(fap_jobfair_divide_seq == 0){
					alert("?????? ???????????? ????????? ?????????");
					return false;
				}
				
				if(fap_jobfair_final_decision_time_gb == 0){
					alert("??????????????? ?????? ?????? ????????? ????????? ?????????");
					return false;
				}
				
				if(fap_jobfair_final_decision_time_st == null || fap_jobfair_final_decision_time_st == ''){
					alert("?????????????????? ???????????? ????????? ?????????");
					return false;
				}
				
				if(fap_jobfair_final_decision_time_et == null || fap_jobfair_final_decision_time_et == ''){
					alert("?????????????????? ???????????? ????????? ?????????");
					return false;
				}
				
				$http({
					method: 'POST',
					url: "/fap/admin/final_decision_time_insert",
					params : {
						fap_jobfair_divide_seq : fap_jobfair_divide_seq
						,fap_jobfair_final_decision_time_gb : fap_jobfair_final_decision_time_gb
						,fap_jobfair_final_decision_time_st : fap_jobfair_final_decision_time_st
						,fap_jobfair_final_decision_time_et : fap_jobfair_final_decision_time_et
						,fap_jobfair_final_decision_time_ct : fap_jobfair_final_decision_time_ct
					}
				}).then(function successCallback(response) {
					if(response.data == ''){
						alert("????????? ???????????????. ?????? ???????????? ????????? ?????????.");
					}else{
						insert_init();
						$("#insertDiv").css("display","none");
						alert("?????????????????????.");
						$scope.list_draw(response.data);
					}
					
				}, function errorCallback(response) {
					console.log(response);
				});
				
			}
			
		}]);
		
		function insert_init(){
			$("#fap_jobfair_final_decision_time_gb option:eq(0)").prop("selected", true);
			$("#jobfair_st").val("");
			$("#jobfair_et").val("");
		}
		
		$(function(){
			cleanDatepicker();
			minMax("jobfair_st" , "jobfair_et");
			
			function cleanDatepicker() {
	
				var original_gotoToday = $.datepicker._gotoToday;
	
				$.datepicker._gotoToday = function(id) {
					var target = $(id), inst = this._getInst(target[0]);
	
					original_gotoToday.call(this, id);
					this._selectDate(id, this._formatDate(inst, inst.selectedDay, inst.drawMonth, inst.drawYear));
					target.blur();
				}
	
				var old_fn = $.datepicker._updateDatepicker;
	
				$.datepicker._updateDatepicker = function(inst) {
					old_fn.call(this, inst);
	
					var buttonPane = $(this).datepicker("widget").find(".ui-datepicker-buttonpane");
	
					$("<button type='button' class='ui-datepicker-clean ui-state-default ui-priority-primary ui-corner-all'>clear</button>").appendTo(buttonPane).click(function(ev) {
						$.datepicker._clearDate(inst.input);
					});
				}
			}
			
			
			$("#insertBtn").on("click",function(){
				var fap_jobfair_divide_seq = $("#jobfairDivideSelect option:selected").attr("seq");
				
				if(fap_jobfair_divide_seq == 0) {
					alert("?????? ???????????? ????????? ?????????.");
				}else{
					$("#fap_jobfair_divide_seq").val(fap_jobfair_divide_seq);
					$("#insertDiv").css("display","block");
				}
				
			});
			
		})
		
	</script>
	<style type="text/css">
		.newline{
			text-overflow: ellipsis;
			white-space: nowrap;
			overflow: hidden;
		}
	</style>
</head>
<body  ng-app="myapp" ng-controller="AdminController">
<%@include file="admin_menu.jsp"%>
	<div class="container">
		<br>
		<div class="page_title">
			<h2>???????????? ?????? ??????</h2>
		</div>
		<br>
		<div>
			<select id="jobfairSelect" onchange="angular.element(this).scope().jobfair_change()">
				<option value="0">???????????? ???????????????</option>
				<c:forEach var="data" items="${jobfairList }">
					<option value="${data.fap_jobfair_seq }">${data.fap_jobfair_title }</option>
				</c:forEach>
			</select>
			
			<select id="jobfairDivideSelect" onchange="angular.element(this).scope().jobfair_divide_change()">
				<option seq="0">?????? ???????????? ???????????????</option>
			</select>
			
			<input type="button" id="insertBtn" class="btn btn-primary" value="?????????">
			<input type="button" id="deleteBtn" class="btn btn-info" ng-click="setting_delete()" value="??????">
			<input type="button" class="btn btn-danger" ng-click="compPassBtn()" value="????????????">
		</div>
		<br>
		<div id="insertDiv" style="display: none;">
			<div class="search_div">
				<div class="search_box">
					<table class="search_box">
						<colgroup>
							<col width="20%">
							<col width="80%">
						</colgroup>
						<tr>
							<th>??????????????? <br> ?????? ?????? ??????</th>
							<td>
								<select name="fap_jobfair_final_decision_time_gb" class="select30" id="fap_jobfair_final_decision_time_gb">
									<option value="0">???????????????</option>
									<option selectcode value="D0900"></option>
									<option selectcode value="D0901"></option>
									<option selectcode value="D0902"></option>
								</select>
							</td>
						</tr>
						<tr>
							<th>?????????????????? ??????</th>
							<td>
								<input type="text" class="input30" id="jobfair_st" name="fap_jobfair_final_decision_time_st" placeholder="?????????????????? ?????????">
								 ~ 
								<input type="text" class="input30" id="jobfair_et" name="fap_jobfair_final_decision_time_et" placeholder="?????????????????? ?????????">
							</td>
						</tr>
						
						<tr>
							<th>????????????</th>
							<td>
								<textarea id="fap_jobfair_final_decision_time_ct" name="fap_jobfair_final_decision_time_ct" style="width: 62.2%;"></textarea>
								<input type="button" class="btn btn-primary" id="finalInsertBtn" ng-click="final_insert()" value="??????">	
							</td>
						</tr>
					</table>
				</div>
			</div>
		</div>
		<br>
		<table class="table">
			<thead>
				<tr>
					<th>??????</th>
					<th>??????</th>
					<th>??????</th>
					<th>???????????? ?????????</th>
					<th>???????????? ?????????</th>
					<th>??????????????? ????????????</th>
					<th>??????</th>
				</tr>
			</thead>
			<tbody id="search_data"></tbody>
		</table>
		<form action="final_decision_time_update_form" method="post" id="updateForm">
			<input type="hidden" id="fap_jobfair_set_seq" name="fap_jobfair_set_seq">
		</form>
	</div>
</body>
</html>
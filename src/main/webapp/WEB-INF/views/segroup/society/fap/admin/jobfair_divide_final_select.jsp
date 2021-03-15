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
	<script src="<c:url value="/resources/segroup/js/jquery.timepicker.min.js" />"></script>
	<link rel="stylesheet" href="/resources/segroup/css/jquery.timepicker.css">
	<!-- modal을 위한 bootstrap 시작-->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
	<!--  modal을 위한 bootstrap 끝 -->
	
	<title>Bridge Job Fair</title>
	<script type="text/javascript">
		$(function() {
			
			
			/* var setting = {
			        'minTime' : '00:00am',
			        'maxTime' : '23:55pm', 
			        'timeFormat' : 'H:i',
			        'step' : 5
			} */
			
			
			//minMaxTime("fap_job_review_time_st", "23:55pm", setting);
			
				
		});
		</script>
		
		<script type="text/javascript">	
		
		var myApp = angular.module('myapp', []);
		
		myApp.controller('ScheduleSetController', ['$scope','$compile','$http','$timeout', function($scope,$compile,$http,$timeout){
			
			cleanDatepicker();
			
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
			
			
			var fap_jobfair_seq = "${fap_jobfair_seq}";
			var fap_jobfair_divide_seq = "${fap_jobfair_divide_seq}";
			$scope.fap_jobfair_divide_seq = fap_jobfair_divide_seq;
			
			//설정후 재검색
			if(fap_jobfair_seq != 0 || fap_jobfair_divide_seq != 0){
				if(fap_jobfair_seq != 0){
					//jobfair_divide 활성화
					$("#jobfair_divide_hidden").prop("selected", true);
					$("#select_jobfair_divide").html("<option value=\'"+0+"\' id=\"jobfair_divide_hidden\" seq=\'"+0+"\'  hidden>선택</option>");
					$("#select_jobfair_divide").attr("disabled", false);
					
					$http({
						method : 'POST',
						url : '/fap/company_roadmap/select_jobfair_divide',
						responseType : 'text',
						params : {
							fap_jobfair_seq: $("#select_jobfair option:selected").val()
						}
					}).then(function successCallback(response) {
						//jobfair_divide에 option 추가
						for(var i in response.data){
							$("#select_jobfair_divide").append($compile("<option selectcode value=" 
									+ response.data[i].fap_jobfair_divide_gb + " seq=\"" + response.data[i].fap_jobfair_divide_seq + "\"></option>")($scope));
						}
						//잡페어 세부 선택
						for(var i in response.data){
							if(fap_jobfair_divide_seq == response.data[i].fap_jobfair_divide_seq){
								$('#select_jobfair_divide option[seq='+fap_jobfair_divide_seq+']').attr("selected", "selected");
							}
						}
						
					}, function errorCallback(response) {
						
					});
				}				
			}
			
			//검색창 변경
			$scope.select_change = function(flag){
				
				if(flag == 1){					
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
						url : '/fap/admin/select_jobfair_divide_info',
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
						alert("에러");
					});					
				}
				
				if(flag == 2){
					if($("#select_jobfair_divide option:selected").attr('seq') != 0){
						var fap_jobfair_divide_seq = $("#select_jobfair_divide option:selected").attr('seq');
						$http({
							method: 'POST',
							url: "/fap/admin/search_jobfair_divide_final_select_info",
							params : {
								fap_jobfair_divide_seq : fap_jobfair_divide_seq
							}
						}).then(function successCallback(response) {
							console.log(response);
							
							$scope.final_date_set(response);
							$timeout(function() {
								minMax("final_select_st" , "final_select_et");
							}, 0);
							
							//$scope.cleanDatepicker();
						}, function errorCallback(response) {
							alert("에러");
						});
					}
				}
				
				$scope.final_date_set = function(response){
					$scope.info = response.data;
					context = '';
					context += '<tr>';
					context += '<input type="hidden" name="fap_jobfair_divide_seq" value="{{info.fap_jobfair_divide_seq}}">';
					context += '<td ng-if="info.fap_jobfair_divide_final_select_st == null"><input type="text" id="final_select_st" name="fap_jobfair_divide_final_select_st"></td>';
					context += '<td ng-if="info.fap_jobfair_divide_final_select_st != null"><input type="text"  id="final_select_st" name="fap_jobfair_divide_final_select_st" value="{{info.fap_jobfair_divide_final_select_st}}"></td>';
					context += '<td ng-if="info.fap_jobfair_divide_final_select_et == null"><input type="text" id="final_select_et" name="fap_jobfair_divide_final_select_et"></td>';
					context += '<td ng-if="info.fap_jobfair_divide_final_select_et != null"><input type="text" id="final_select_et" name="fap_jobfair_divide_final_select_et" value="{{info.fap_jobfair_divide_final_select_et}}"></td>';
					context += '<td><button type="submit" class="btn btn-primary">등록</button></td>';
					context += '</tr>';
					$("#search_data").html($compile(context)($scope));
				}
				/* $scope.cleanDatepicker = function() {
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
					minMax("final_select_st" , "final_select_et");
				} */
				
			}
		
			
			
			
			
		}]);		
		
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
		}]);
				
	</script>
	<!-- <script type="text/javascript">
	$(document).ready(function(){
			
	});
	</script> -->

</head>
<body id="myBody" ng-app="myapp" ng-controller="ScheduleSetController">
 <%@include file="admin_menu.jsp"%>
	<br>
	<div class="page_title">
		<h2>잡페어 세부별 최종합격자 결정 기한 알림 설정</h2>
	</div>
	<br>
	 
	<div class="search_div">
		<table class="search_table">
			<tr>
				<th>잡페어명으로 검색</th>	
				<td>
					<select onchange="angular.element(this).scope().select_change(1)" id="select_jobfair">
						<option value="0" >선택</option>
						<optgroup label="진행중인 잡페어" flag="1">
							<c:forEach var="jobfair" items="${jobfair_map.jobfair_list_now}">
								<option value="${jobfair.fap_jobfair_seq}" <c:if test="${fap_jobfair_seq == jobfair.fap_jobfair_seq}">selected</c:if>>${jobfair.fap_jobfair_title}</option>
							</c:forEach>
						</optgroup>
						<optgroup label="예정된 잡페어" flag="2">
							<c:forEach var="jobfair" items="${jobfair_map.jobfair_list_before}">
								<option value="${jobfair.fap_jobfair_seq}" <c:if test="${fap_jobfair_seq == jobfair.fap_jobfair_seq}">selected</c:if>>${jobfair.fap_jobfair_title}</option>
							</c:forEach>
						</optgroup>						
					</select>
				</td>			
			</tr>
			<tr>
				<th>잡페어 세부로 검색</th>	
				<td>
					<select onchange="angular.element(this).scope().select_change(2)" id="select_jobfair_divide" disabled="disabled">
						<option value="0" id="jobfair_divide_hidden" seq="0" hidden>선택 불가</option>						
					</select>
				</td>
			</tr>
		</table>				

		<br><br>
		<form action="/fap/admin/insert_fap_jobfair_divide_final_select" method="post">
			<table class="table">
				<thead>
					<tr>
						<th>최종합격자 결정 기한 알림 시작 &emsp;</th>
						<th>최종합격자 결정 기한 알림 종료 &emsp;</th>
						<th>등록 &emsp;</th>
					</tr>
				</thead>
				
					<tbody id="search_data">
					
					</tbody>
				
			</table>
		</form>
	</div>
	
	
		
</body>
</html>
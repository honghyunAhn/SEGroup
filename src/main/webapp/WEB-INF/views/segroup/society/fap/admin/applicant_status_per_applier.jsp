<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
	<link type="text/css" rel="stylesheet" href="/resources/segroup/css/jquery.timepicker.css" media="" />
	<!-- modal을 위한 bootstrap 시작-->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
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
						//console.log(response);
					});
				},
				template : "<span>{{filterParams}}</span>"
			}
		} ]);
		
		myApp.controller('AdminController', ['$scope','$compile','$http', function($scope,$compile,$http){			
		   
		    $scope.search_change = function(){
		    	
		    	var jobfairSelect = $("#jobfairSelect").val();
		    	var typeSelect = $("#typeSelect").val();
		    	var searchName = $("#searchName").val();
		    	
		    	if(jobfairSelect == 0){
		    		alert("잡페어를 선택해 주세요");
		    		return false;
		    	}
		    	
		    	var search_map = {};
		    	search_map['jobfairSelect'] = jobfairSelect;
		    	search_map['typeSelect'] = typeSelect;
		    	search_map['searchName'] = searchName;
		    	
		    	$http({
					method: 'POST',
					url: "/fap/admin/applicant_status_per_applier_search",
					headers: {'Content-Type': 'application/json'},
					data : JSON.stringify(search_map),
					XMLHttpRequestResponseType: 'json'
				}).then(function successCallback(response) {
					console.log(response.data);
					
					$scope.draw_list(response.data);
				}, function errorCallback(response) {
						console.log(response);
				});
		    	
		    }
		    
		    $scope.excel_down = function(){
		    	var jobfairSelect = $("#jobfairSelect").val();
		    	var typeSelect = $("#typeSelect").val();
		    	var searchName = $("#searchName").val();
		    	
		    	if(jobfairSelect == 0){
		    		alert("잡페어를 선택해 주세요");
		    		return false;
		    	}else{
			    	$("#jobfairSelect_excel").val(jobfairSelect);
			    	$("#typeSelect_excel").val(typeSelect);
			    	$("#searchName_excel").val(searchName);
			    	
			    	$("#excel_form").submit();
		    	}
		    	
		    }
		    
		    $scope.draw_list = function(data){
		    	var k_num = data.k_num;
		    	var j_num = data.j_num;
		    	var list = data.list;
		    	var ct_header = '';
				var ct_body = '';    	
		    	
		    	ct_header += '<tr>';
		    	ct_header += '<td rowspan="2">No</td>';
		    	ct_header += '<td rowspan="2">성명</td>';
		    	ct_header += '<td rowspan="2">회원구분</td>';
		    	ct_header += '<td rowspan="2">K대상</td>';
		    	ct_header += '<td colspan="4">JOB Fair 결과</td>';
		    	ct_header += '<td colspan="4">K-Fair 지원현황</td>';
		    	ct_header += '<td colspan="'+k_num+'">K-Fair</td>';
		    	ct_header += '<td colspan="4">J-Fair 지원현황</td>';
		    	ct_header += '<td colspan="'+j_num+'">J-Fair</td>';
		    	ct_header += '</tr>';
		    	ct_header += '<tr>';
		    	ct_header += '<td>내정</td>';
		    	ct_header += '<td>예비</td>';
		    	ct_header += '<td>대기</td>';
		    	ct_header += '<td>최종불합격</td>';
		    	ct_header += '<td>지원</td>';
		    	ct_header += '<td>진행중</td>';
		    	ct_header += '<td>전형불합격</td>';
		    	ct_header += '<td>현지면접확정</td>';
		    	for (var i=0; i<k_num; i++){
		    		ct_header += '<td>'+(i+1)+'지망</td>';
		    	}
		    	ct_header += '<td>지원</td>';
		    	ct_header += '<td>진행중</td>';
		    	ct_header += '<td>전형불합격</td>';
		    	ct_header += '<td>현지면접확정</td>';
		    	for (var i=0; i<j_num; i++){
		    		ct_header += '<td>'+(i+1)+'지망</td>';
		    	}
		    	ct_header += '</tr>';
		    	
		    	$.each(list, function(index,item){
			    	ct_body += '<tr>';
			    	ct_body += '<td>'+(index+1)+'</td>';
			    	ct_body += '<td>'+item.user_nm+'</td>';
			    	ct_body += '<td><code value="'+item.user_flag+'"></code></td>';
			    	ct_body += '<td>K</td>';
			    	ct_body += '<td>'+item.rt_count+'</td>';
			    	ct_body += '<td>'+item.reserve_count+'</td>';
			    	ct_body += '<td>'+item.standby_count+'</td>';
			    	ct_body += '<td>'+item.final_fail_count+'</td>';
			    	ct_body += '<td>'+item.k_apply_count+'</td>';
			    	ct_body += '<td>'+item.k_process_count+'</td>';
			    	ct_body += '<td>'+item.k_fail_count+'</td>';
			    	ct_body += '<td>'+item.k_success_count+'</td>';
			    	
			    	for(var i=0; i < k_num; i++){
			    		var ct_td = '<td></td>';
			    		
			    		$.each(item.kFair, function(index2, item2){
			    			if((i+1) == item2.k_info_rank){
			    				if(typeof item2.k_rt_acp != "undefined"){
			    					ct_td = '<td class="'+item2.k_rt_acp+' '+item2.k_choice_gb+'">'+item2.k_comp_nm+'</td>';
				    				return;
			    				}else{
			    					ct_td = '<td>'+item2.k_comp_nm+'(미정)</td>';
			    					return;
			    				}
			    			}
			    		})
			    		
			    		ct_body += ct_td;
			    	}
			    	
			    	ct_body += '<td>'+item.apply_count+'</td>';
			    	ct_body += '<td>'+item.process_count+'</td>';
			    	ct_body += '<td>'+item.fail_count+'</td>';
			    	ct_body += '<td>'+item.success_count+'</td>';
			    	
			    	
			    	for(var i=0; i < j_num; i++){
			    		var ct_td = '<td></td>';
			    		
			    		$.each(item.jFair, function(index2, item2){
			    			if((i+1) == item2.info_rank){
			    				if(typeof item2.j_rt_acp != "undefined"){
			    					ct_td = '<td class="'+item2.j_rt_acp+' '+item2.j_choice_gb+'">'+item2.j_comp_nm+'('+item2.j_standby_rank+')</td>';
				    				return;
			    				}else{
			    					ct_td = '<td>'+item2.j_comp_nm+'(미정)</td>';
			    					return;
			    				}
			    			}
			    		})
			    		
			    		ct_body += ct_td;
			    	}
			    	
			    	ct_body += '</tr>';
		    	});
		
		    	
		    	$("#tblBody thead").html(ct_header);
		    	$("#tblBody tbody").html($compile(ct_body)($scope));
		    	
		    }
		    
		}]);
	
	</script>
	<style type="text/css">
.applier_header td {
	vertical-align: middle;
	border: 1px solid #dee2e6;
	text-align: center;
	min-width: 150px;
}
#tblBackground {
        /*
         *  화면에 보여야 할 Table의 가로크기를 잡아줍니다.
         */
        width: 100%;
        table-layout: fixed;
}
#divBodyScroll {
    /*
     *  overflow-x, overflow-y는 scroll로 지정하고,
     *  height는 테이블의 데이터가 나올 기본 크기를 잡아줍니다.
     *  세로길이를 잡아주지 않으면 overflow-y가 걸리지 않습니다.
     */
    width: 100%;
    height: 600px;
    overflow-x: scroll;
    overflow-y: scroll;
    border-top: 1px solid #d0d0d0;
}
#tblBody {
    /*
     * tblBody의 데이터는 필요한 열의 수만큼만 만드시고 헤더와 col의 width는 동일해야 합니다.
     */
    width: 1900px;
    height: 30px;
}
.D0001{
	background-color: yellow;
	font-weight: bold;
}
.D0002{
	background-color: gray;
}
.D0004{
	background-color: cyan;
	font-weight: bold;
}
.D0701{
	text-decoration: underline;
}
</style>
</head>
<body id="myBody" ng-app="myapp" ng-controller="AdminController">
     <%@include file="admin_menu.jsp"%>
	<div class="container">
		<br>
		<div class="page_title">
			<h2>관리자 지원자별 지원 페이지</h2>
		</div>
		<br>
		<div class="search_div">
			<div class="search_box">
				<table class="search_box">
					<colgroup>
						<col width="30%">
						<col width="80%">
					</colgroup>
					<tr>
					<th>잡페어명으로 검색</th>	
					<td>
						<select id="jobfairSelect" onchange="angular.element(this).scope().search_change()" class="selectMid">
							<option value="0">잡페어를 선택하세요</option>
							<c:forEach var="data" items="${jobfairList }">
								<option value="${data.fap_jobfair_seq }">${data.fap_jobfair_title }</option>
							</c:forEach>
						</select>
					</td>
				</tr>
				<tr>
					<th>회원 타입으로 검색</th>	
					<td>
						<select id="typeSelect" onchange="angular.element(this).scope().search_change()" class="selectMid">
							<option value="A0">선택</option>
							<option selectcode value="A0101"></option>
							<option selectcode value="A0106"></option>
							<option selectcode value="A0100"></option>
							<option selectcode value="A0108"></option>
						</select>
					</td>
				</tr>
				<tr>
					<th>이름으로 검색</th>
					<td>
						<input type="text" id="searchName">
						<button type="button" class="btn_search" ng-click="search_change()">검색</button>
					</td>
				</tr>
				<tr>
					<th colspan="2">
						<button type="button" class="btn btn-primary" ng-click="excel_down()">엑셀다운로드</button>
					</th>
				</tr>
				</table>
			</div>
		</div>
		<br>
		<table id="tblBackground">
			<tr>
				<td>
					<div id="divBodyScroll">
						<table class="table applier_header" id="tblBody">
							<thead>
							</thead>
							<tbody>
							</tbody>
						</table>
					</div>
				</td>
			</tr>
		</table>
		<table class="table" style="width: 400px;">
			<tr>
				<th colspan="2">확인표</th>
			</tr>
			<tr>
				<td class="D0001">회사명(예비번호)</td>
				<td>합격 기업</td>
			</tr>
			<tr>
				<td class="D0002">회사명(예비번호)</td>
				<td>불합격 기업</td>
			</tr>
			<tr>
				<td class="D0004">회사명(예비번호)</td>
				<td>예비합격 기업</td>
			</tr>
			<tr>
				<td>회사명(예비번호)</td>
				<td>진행중 기업</td>
			</tr>
			<tr>
				<td class="D0001 D0701">회사명(예비번호)</td>
				<td>내정확정 기업</td>
			</tr>
		</table>
		
		<form action="/fap/admin/applicant_status_per_applier_excel" method="post" id="excel_form">
			<input type="hidden" name="jobfairSelect" id="jobfairSelect_excel">
			<input type="hidden" name="typeSelect" id="typeSelect_excel">
			<input type="hidden" name="searchName" id="searchName_excel">
		</form>
	</div>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="<c:url value="/resources/segroup/js/jquery-3.1.1.js" />"></script>
<script src="<c:url value="/resources/segroup/js/angular.min.js" />"></script>
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

myApp.controller('MainPageController', ['$scope','$compile','$http', function($scope,$compile,$http){	
    
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
		}else{
			var fap_jobfair_divide_seq = $('#select_jobfair_divide option:selected').attr('seq');
			$("#fap_jobfair_divide_seq").val(fap_jobfair_divide_seq);
		}
		
	}
}]);	
</script>
</head>
<body ng-app="myapp" ng-controller="MainPageController">
<%@include file="admin_menu.jsp"%><br>
	<form action="/fap/admin/mainpage_ct_insert" method="post">
		노출할 채용공고들의 잡페어를 선택해 주세요. <br>
		<table class="search_box">
			<tr>
				<th>잡페어 선택</th>	
				<td>
					<select id="select_jobfair" name="fap_jobfair_seq" onchange="angular.element(this).scope().search_change(1)">
						<option value="0">잡페어를 선택하세요</option>
						<c:forEach var="data" items="${jobfairList }">
							<option value="${data.fap_jobfair_seq }">${data.fap_jobfair_title }</option>
						</c:forEach>
					</select>
				</td>
				<th>세부 잡페어 선택</th>	
				<td>
					<select id="select_jobfair_divide" onchange="angular.element(this).scope().search_change()">
						<option value="0" id="jobfair_divide_hidden" seq="0" hidden>선택 불가</option>
					</select>
					<input type="hidden" name="fap_jobfair_divide_seq" id="fap_jobfair_divide_seq">
				</td>
			</tr>
			<tr>
				<th>상단 한국어 문구</th>
				<td>
					<input type="text" name="fap_mainpage_ct_top_ko" size="50">
				</td>
				<th>상단 일본어 문구</th>
				<td>
					<input type="text" name="fap_mainpage_ct_top_ja" size="50">
				</td>
			</tr>
			<tr>
				<th>분기 한국어 문구</th>
				<td>
					<input type="text" name="fap_mainpage_ct_quarter_ko" size="20">
				</td>
				<th>분기 일본어 문구</th>
				<td>
					<input type="text" name="fap_mainpage_ct_quarter_ja" size="20">
				</td>
			</tr>
			<tr>
				<th>우선 배정 그룹코드</th>
				<td>
					<input type="text" name="fap_mainpage_ct_imp_code" size="20">
				</td>
				<th></th>
				<td>
					<input type="submit" value="등록">
				</td>
			</tr>
		</table>
		
	
	</form>
</body>
</html>
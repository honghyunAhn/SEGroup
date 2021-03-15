<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">	
	<script src="<c:url value="/resources/segroup/js/jquery-3.1.1.js" />"></script>
	<script src="<c:url value="/resources/segroup/js/angular.min.js" />"></script>
	<!-- modal을 위한 bootstrap -->
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
	
	$scope.fap_open_delete = function(e){
		var fap_open_pt_seq = $(e.currentTarget).attr("open_seq");
		$("#fap_open_pt_delete_seq").val(fap_open_pt_seq);
		
		$("#open_pt_delete").submit();
		
	}
	
	$scope.open_set_modal = function(e){
		var fap_open_pt_seq = $(e.currentTarget).attr("open_seq");
		
		$http({
			method: 'POST',
			url: "/fap/admin/open_pt_select_one",
			params : {
				fap_open_pt_seq : fap_open_pt_seq
			}
		}).then(function successCallback(response) {
			
			var data = response.data;
			$scope.open_pt = response.data;
			
			var context = '';
			
			context += '<table class="table">';
			context += '<tr>	';
			context += '<td>타이틀</td>';
			context += '<td>'+data.fap_open_pt_title+'</td>';
			context += '</tr>';
			context += '<tr>';
			context += '<td>노출구분</td>';
			context += '<td>';
			context += '<input type="radio" name="show_gb" ng-model="open_pt.fap_open_pt_show_gb" value="D1100"><code value="D1100"></code>';
			context += '<input type="radio" name="show_gb" ng-model="open_pt.fap_open_pt_show_gb" value="D1101"><code value="D1101"></code>';
			context += '</td>';
			context += '</tr>';
			context += '<tr>';
			context += '<td>마감구분</td>';
			context += '<td>';
			context += '<input type="radio" name="close_gb" ng-model="open_pt.fap_open_pt_close_gb" value="D1200"><code value="D1200"></code>';
			context += '<input type="radio" name="close_gb" ng-model="open_pt.fap_open_pt_close_gb" value="D1201"><code value="D1201"></code>';
			context += '<input type="radio" name="close_gb" ng-model="open_pt.fap_open_pt_close_gb" value="D1202"><code value="D1202"></code>';
			context += '</td>';
			context += '</tr>';
			context += '</table>';
			context += '<input type="hidden" id="open_seq" value="'+data.fap_open_pt_seq+'">';
			context += '<input type="hidden" id="open_gb" value="'+data.fap_open_pt_gb+'">';
			
			$(".modal-body").html($compile(context)($scope));
      		
			$('#myModal').modal('show');
		}, function errorCallback(response) {
			console.log(response);
		});
	}
	
	$scope.open_pt_save = function(){
		
		if(confirm("노출 변경시 같은 종류의 다른 설명회는 전부 비노출로 변경됩니다. 변경하시겠습니까?")){
			var fap_open_pt_seq = $("#open_seq").val();
			var fap_open_pt_gb = $("#open_gb").val();
			var fap_open_pt_show_gb = $(":input:radio[name=show_gb]:checked").val();
			var fap_open_pt_close_gb =  $(":input:radio[name=close_gb]:checked").val();
			
			$("#fap_open_pt_seq").val(fap_open_pt_seq);
			$("#fap_open_pt_gb").val(fap_open_pt_gb);
			$("#fap_open_pt_show_gb").val(fap_open_pt_show_gb);
			$("#fap_open_pt_close_gb").val(fap_open_pt_close_gb);
			
			$("#open_gb_form").submit();
		}
		
	}
}]);

</script>
</head>
<body  ng-app="myapp" ng-controller="AdminController">
  <%@include file="admin_menu.jsp"%>
	<br>
	<div class="page_title">
		<h2>오픈잡페어 설명회 관리</h2>
	</div>
	<br>
	<table class="table">
		<thead>
			<tr>
				<th>
					타이틀
				</th>
				<th>
					종류
				</th>
				<th>
					노출
				</th>
				<th>
					마감
				</th>
				<th>
					설정
				</th>
				<th>
					삭제
				</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="open" items="${result }">
				<tr>	
					<td>
						<a href="/fap/admin/open_pt_update_form?fap_open_pt_seq=${open.fap_open_pt_seq }">${open.fap_open_pt_title }</a>
					</td>
					<td>
						<code value="${open.fap_open_pt_gb }"></code>
					</td>
					<td>
						<code value="${open.fap_open_pt_show_gb }"></code>
					</td>
					<td>
						<code value="${open.fap_open_pt_close_gb }"></code>
					</td>
					<td>
						<input type="button" ng-click="open_set_modal($event)" open_seq="${open.fap_open_pt_seq }" value="설정">
					</td>
					<td>
						<input type="button" ng-click="fap_open_delete($event)" open_seq="${open.fap_open_pt_seq }" value="삭제">
					</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>

	<!-- 모달 -->
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	  <div class="modal-dialog modal-lg">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h4 class="modal-title" id="myModalLabel">설명회 설정</h4>
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	      </div>
	      <div class="modal-body">
	      	
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
	        <button type="button" class="btn btn-primary" ng-click="open_pt_save()">저장</button>
	      </div>
	    </div>
	  </div>
	</div>
	<form action="/fap/admin/open_pt_delete" method="post" id="open_pt_delete">
		<input type="hidden" name="fap_open_pt_seq" id="fap_open_pt_delete_seq">
	</form>
	<form action="/fap/admin/open_pt_update_gb" method="post" id="open_gb_form">
		<input type="hidden" name="fap_open_pt_seq" id="fap_open_pt_seq">
		<input type="hidden" name="fap_open_pt_gb" id="fap_open_pt_gb">
		<input type="hidden" name="fap_open_pt_show_gb" id="fap_open_pt_show_gb">
		<input type="hidden" name="fap_open_pt_close_gb" id="fap_open_pt_close_gb">
	</form>
<a href="/fap/admin/open_pt_insert_form">설명회 등록폼</a>
</body>
</html>
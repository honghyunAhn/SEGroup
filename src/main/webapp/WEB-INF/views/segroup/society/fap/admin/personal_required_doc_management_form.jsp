<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Bridge Job Fair</title>
	<script src="<c:url value="/resources/segroup/js/jquery-3.1.1.js" />"></script>
	<script src="<c:url value="/resources/segroup/js/jquery-ui.js" />"></script>
	<script src="<c:url value="/resources/segroup/js/angular.min.js" />"></script>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
	<script type="text/javascript">
		$(function() {
			$('#logout').off("click").on("click", function() {
				$('#logoutForm').submit();
				return false;
			});
		})
	</script>
	<script type="text/javascript">
		var myApp = angular.module('myapp', []);		
		
		myApp.controller('RequiredDocController', ['$scope','$compile','$http', function($scope,$compile,$http){	
		
			//개인 내정서류 리스트 검색
			if("${nominee_info.fap_nominee_seq}" != null && "${nominee_info.fap_nominee_seq}" != ''){
				var fap_nominee_seq = "${nominee_info.fap_nominee_seq}";
				var fap_job_ad_seq = "${nominee_info.fap_job_ad_seq}";
				var fap_comp_id = "${nominee_info.fap_comp_id}";
				var user_id = "${nominee_info.user_id}";
				$http({
					method: 'POST',
					url: "/fap/admin/personal_required_doc_search_list",
					params : {
						'fap_nominee_seq' : fap_nominee_seq
					}
				}).then(function successCallback(response) {
					$scope.personal_required_doc_draw(response);
					$scope.personal_user_required_doc_draw(response);
					
						//내정자 정보 검색
						$http({
							method: 'POST',
							url: "/fap/admin/nominee_info_search",
							params : {
								'fap_nominee_seq' : fap_nominee_seq, 'fap_job_ad_seq' : fap_job_ad_seq, 'fap_comp_id' : fap_comp_id, 'user_id' : user_id
							}
						}).then(function successCallback(response) {		
							$scope.nominee_draw(response);
							
						}, function errorCallback(response) {
						
						});
						
				}, function errorCallback(response) {
				
				});
			}
						
			//회사가 등록한 개인 내정서류 리스트
			$scope.personal_required_doc_draw = function(response){
				$scope.results = response.data;
				var context = '';
				context += '<tr ng-repeat="result in results | filter:query">';
				context += '<td ng-if="result.fap_personal_required_doc_uploader_gb == \'C4800\' ">';
				context += '<span>{{result.fap_personal_required_doc_title}}</span>';
				context += '</td>';
				context += '<td ng-if="result.fap_personal_required_doc_uploader_gb == \'C4800\' ">';
				context += '<span style="width: 400px;">{{result.fap_personal_required_doc_origin}}</span>';
				context += '</td>';
				context += '<td ng-if="result.fap_personal_required_doc_uploader_gb == \'C4800\' ">';
				context += '<button value="{{result.fap_personal_required_doc_detail}}" ng-click="detail(result.fap_personal_required_doc_detail)">설명보기</button>';
				context += '</td>';
				context += '<td ng-if="result.fap_personal_required_doc_uploader_gb == \'C4800\' ">';
				context += '<a href="/file_download?origin={{result.fap_personal_required_doc_origin}}&saved={{result.fap_personal_required_doc_saved}}&path=/fap/company/required_doc_file/{{result.fap_comp_id}}_{{result.fap_job_ad_seq}}/{{result.fap_nominee_seq}} "><button value="{{result.fap_personal_required_doc_seq}}">다운로드</button></a>';
				context += '</td>';
				context += '<td ng-if="result.fap_personal_required_doc_uploader_gb == \'C4800\' ">';
				context += '<button value="{{result.fap_personal_required_doc_seq}}" ng-click="update(result.fap_personal_required_doc_seq)">수정</button>';
				context += '</td>';
				context += '<td ng-if="result.fap_personal_required_doc_uploader_gb == \'C4800\' ">';
				context += '<a href="/fap/admin/personal_required_doc_delete?fap_personal_required_doc_seq={{result.fap_personal_required_doc_seq}}&fap_nominee_seq={{result.fap_nominee_seq}}&fap_personal_required_doc_saved={{result.fap_personal_required_doc_saved}}"><button value="{{result.fap_personal_required_doc_seq}}">삭제</button></a>';
				context += '</td>';
				context += '</tr>';
				
				$("#search_data").html($compile(context)($scope)); 	
			}
			
			//내정자가 등록한 개인 내정서류 리스트
			$scope.personal_user_required_doc_draw = function(response){
				$scope.results = response.data;
				var context = '';
				context += '<tr ng-repeat="result in results | filter:query">';
				context += '<td ng-if="result.fap_personal_required_doc_uploader_gb == \'C4801\' ">';
				context += '<span>{{result.fap_personal_required_doc_title}}</span>';
				context += '</td>';
				context += '<td ng-if="result.fap_personal_required_doc_uploader_gb == \'C4801\' ">';
				context += '<span style="width: 400px;">{{result.fap_personal_required_doc_origin}}</span>';
				context += '</td>';
				context += '<td ng-if="result.fap_personal_required_doc_uploader_gb == \'C4801\' ">';
				context += '<button value="{{result.fap_personal_required_doc_detail}}" ng-click="detail(result.fap_personal_required_doc_detail)">설명보기</button>';
				context += '</td>';
				context += '<td ng-if="result.fap_personal_required_doc_uploader_gb == \'C4801\' ">';
				context += '<a href="/file_download?origin={{result.fap_personal_required_doc_origin}}&saved={{result.fap_personal_required_doc_saved}}&path=/fap/company/required_doc_file/{{result.fap_comp_id}}_{{result.fap_job_ad_seq}}/{{result.fap_nominee_seq}} "><button value="{{result.fap_personal_required_doc_seq}}">다운로드</button></a>';
				context += '</td>';
				context += '<td ng-if="result.fap_personal_required_doc_uploader_gb == \'C4801\' ">';
				context += '<button value="{{result.fap_personal_required_doc_seq}}" ng-click="update(result.fap_personal_required_doc_seq)">수정</button>';
				context += '</td>';
				context += '<td ng-if="result.fap_personal_required_doc_uploader_gb == \'C4801\' ">';
				context += '<a href="/fap/admin/personal_required_doc_delete?fap_personal_required_doc_seq={{result.fap_personal_required_doc_seq}}&fap_nominee_seq={{result.fap_nominee_seq}}&fap_personal_required_doc_saved={{result.fap_personal_required_doc_saved}}"><button value="{{result.fap_personal_required_doc_seq}}">삭제</button></a>';
				context += '</td>';
				context += '</tr>';
				
				$("#search_user_data").html($compile(context)($scope)); 	
			}
			
			//검색한 내정자 정보 
			$scope.nominee_draw = function(response){
				$scope.nominee = response.data;
				context = '';
				context += '<div>';
				context += '<div style="display: inline;">{{nominee.fap_resume_nm}}</div>&emsp;';		
				context += '<div ng-if="nominee.fap_resume_pic_saved != null " style="display: inline;">';
				context += '<img ng-src="/fap/user/resume_photo_image/{{nominee.fap_resume_pic_saved}}" style="width:100px;">';
				context += '</div>';
				context += '<div ng-if="nominee.fap_resume_pic_saved == null " style="display: inline;">';
				context += '<img style="width:100px;" ng-src="/fap/user/resume_photo_image/photo.gif">';
				context += '</div>';
				context += '</div>';
				
				$("#nominee_data").html($compile(context)($scope));
				
			}
			
			//개인서류 등록 페이지로 이동
			$scope.personal_doc = function(fap_nominee_seq){
				var fap_nominee_seq = fap_nominee_seq;
				location.href = "/fap/company/company_personal_required_doc_management?fap_nominee_seq" + fap_nominee_seq;
			}
			
			//세부내용 alert로 띄우기
			$scope.detail = function(fap_common_required_doc_detail){
				var fap_common_required_doc_detail = fap_common_required_doc_detail;
				alert(fap_common_required_doc_detail);
			}			
			
			//수정할 내정서류 검색
			$scope.update = function(fap_personal_required_doc_seq){
				var fap_personal_required_doc_seq = fap_personal_required_doc_seq;
				$http({
					method: 'POST',
					url: "/fap/company/company_personal_required_doc_search",
					params : {
						'fap_personal_required_doc_seq' : fap_personal_required_doc_seq
					}
				}).then(function successCallback(response) {
					$scope.update_required_doc_draw(response.data);					
					$("#updateModal").modal();
				}, function errorCallback(response) {
				
				});
			}
			
			//수정할 내정서류 MODAL
			$scope.update_required_doc_draw = function(result){
				$scope.result = result;
				var context = '';
				context += '<div class="modal fade" id="updateModal" tabindex="-1" role="dialog" aria-labelledby="modal" aria-hidden="true">';
				context += '<div class="modal-dialog">';
				context += '<div class="modal-content">';					
				context += '	<div class="modal-header">';
				context += '<h5 class="modal-title" id="modal">내정자 개인서류 수정</h5>';
				context += '<button type="button" class="close" data-dismiss="modal" aria-label="Close">';
				context += '<span aria-hidden="true">&times;</span>';
				context += '</button>';
				context += '</div>';
				context += '<form action="/fap/admin/personal_required_doc_update" method="post" onsubmit="return update_form_Check();" enctype="multipart/form-data">';
				context += '<div class="modal-body">';
				context += '<input type="hidden" name="fap_personal_required_doc_seq" value="'+result.fap_personal_required_doc_seq+'">';
				context += '<input type="hidden" name="fap_nominee_seq" value="'+result.fap_nominee_seq+'">';
				context += '<input type="hidden" name="fap_comp_id" value="'+result.fap_comp_id+'">';
				context += '<input type="hidden" name="user_id" value="'+result.user_id+'">';
				context += '<input type="hidden" name="fap_personal_required_doc_origin" value="'+result.fap_personal_required_doc_origin+'">';
				context += '<input type="hidden" name="fap_personal_required_doc_saved" value="'+result.fap_personal_required_doc_saved+'">';
				context += '<div class="form-group">';
				context += '<label>서류 제목</label>';
				context += '<input type="text" name="fap_personal_required_doc_title" id="fap_personal_required_doc_update_title" value="'+result.fap_personal_required_doc_title+'" class="form-control" maxlength="100">';
				context += '</div>';
				context += '<div class="form-row">';
				context += '<label>서류 상세</label>';
				context += '</div>';
				context += '<div class="form-row">';
				context += '<input type="text" name="fap_personal_required_doc_detail" id="fap_personal_required_doc_update_detail" value="'+result.fap_personal_required_doc_detail+'" class="form-control" maxlength="500" style="text-align: inherit; width:490px; height: 100px;" >';
				context += '</div>';
				context += '</div>';
				context += '<div class="form-group">';
				context += '<div class="file_input_div">';
				context += '<input type="button" value="'+result.fap_personal_required_doc_origin+'" id="updateFileBtn" class="file_input_button" />';
				context += '<input type="file" class="file_input_hidden" name="fap_personal_required_doc_file" id="fap_personal_required_doc_update_file" value="'+result.fap_personal_required_doc_origin+'" onchange="file_change(this.files[0].name)" >';
				context += '</div>';
				context += '</div>';							
				context += '<div class="modal-footer">';
				context += '<button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>';
				context += '<button type="submit" class="btn btn-primary">수정하기</button>';
				context += '</div>';							
				context += '</form>';
				context += '</div>';
				context += '</div>';
				context += '</div>';
				
				$("#update_required_doc_div").html($compile(context)($scope)); 	
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
	
	</script>
	<script type="text/javascript">
		//유효성 검사
		function form_Check() {
			var fap_personal_required_doc_title = $('#fap_personal_required_doc_title').val();
			var fap_personal_required_doc_file = $('#fap_personal_required_doc_file').val();			
			
			//서류제목
			if(fap_personal_required_doc_title == ''){
				alert('제목은 필수 입력 사항입니다.');
				$('#fap_personal_required_doc_title').focus();
				return false;
			}
			//서류파일
			if(fap_personal_required_doc_file == ''){
				alert('서류는 필수 입력 사항입니다.');
				return false;
			}			
		}
		
		function user_form_Check() {
			var fap_user_required_doc_title = $('#fap_user_required_doc_title').val();
			var fap_user_required_doc_file = $('#fap_user_required_doc_file').val();			
			
			//서류제목
			if(fap_user_required_doc_title == ''){
				alert('제목은 필수 입력 사항입니다.');
				$('#fap_user_required_doc_title').focus();
				return false;
			}
			//서류파일
			if(fap_user_required_doc_file == ''){
				alert('서류는 필수 입력 사항입니다.');
				return false;
			}			
		}
		
		function update_form_Check() {
			var fap_personal_required_doc_update_title = $('#fap_personal_required_doc_update_title').val();						
			//수정한 서류제목
			if(fap_personal_required_doc_update_title == ''){
				alert('제목은 필수 입력 사항입니다.');
				$('#fap_common_required_doc_title').focus();
				return false;
			}		
		}
		
		//파일명 변경
		function file_change(file_name){
			var file_name= file_name
			$('#updateFileBtn').val(file_name);
		}	
		
	</script>
	<script type="text/javascript">
		//수정 파일명 변경
		$(document).ready(function() { 
		    $("#fap_personal_required_doc_update_file").on("change", function() { 
		    	$("#updateFileBtn").html(this.value); 
		    }); 
		}); 
	</script>
	
	<style type="text/css">
		.file_input_div
		{
		margin : 10px;
		position: relative;
		width: 450px;
		height: 50px;
		overflow: hidden;
		}
		 
		.file_input_button
		{
		width: 450px;
		position: absolute;
		top: 0px;
		background-color: #464946;
		color: #FFFFFF;
		border-style: solid;
		}
		 
		.file_input_hidden
		{
		font-size: 45px;
		position: absolute;
		right: 0px;
		top: 0px;
		opacity: 0;
		 
		filter: alpha(opacity=0);
		-ms-filter: "alpha(opacity=0)";
		-khtml-opacity: 0;
		-moz-opacity: 0;
		}

	</style>
</head>
<body ng-app="myapp" ng-controller="RequiredDocController">
<!--
<sec:authorize access="isAuthenticated()">
	<sec:authentication property="details" var="check" />
</sec:authorize>
<form id="logoutForm" action="/fap/company/logout" method="post" style="display: none">
	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
</form>
<c:if test="${not empty check }">
	<a href="#none" id="logout">로그아웃</a>
</c:if>
-->
  <%@include file="admin_menu.jsp"%>
	<br>
	<div class="page_title">
		<h2>내정자 개인서류 관리 페이지</h2>
	</div>
	<br>

 
	
	<h4 style="display: inline;">${company_info.fap_comp_ja_nm} 내정자 개인서류</h4>
	<img alt="" src="/resources/segroup/society/fap/images/main/plus_icon.png" data-toggle="modal" data-target="#registerModal">
	<br>
	
	<div id="">
		<table border="1" bordercolor="black">
			<thead>
				<tr>
				<th>내정자 개인서류 제목&emsp;</th>
				<th>내정자 개인서류 파일&emsp;</th>
				<th>설명보기&emsp;</th>
				<th>다운로드&emsp;</th>
				<th>수정&emsp;</th>
				<th>삭제&emsp;</th>
				</tr>
			</thead>
			<tbody id="search_data">
			
			</tbody>
		</table>	
	</div>
	<br><br><br><br><br><br><br><br><br>
	
	<div id="nominee_div">
		<div id="nominee_data">
			
		</div>
	</div>
	
	<br><br>
	<h4 style="display: inline;">{{nominee.fap_resume_nm}} 내정자 </h4>
	<h4 style="display: inline;">서류 업로드</h4><img alt="" src="/resources/segroup/society/fap/images/main/plus_icon.png" data-toggle="modal" data-target="#uploadModal">
	<div id="">
		<table border="1" bordercolor="black">
			<thead>
				<tr>
					<th>내정자 개인서류 제목&emsp;</th>
					<th>내정자 개인서류 파일&emsp;</th>
					<th>설명보기&emsp;</th>
					<th>다운로드&emsp;</th>
					<th>수정&emsp;</th>
					<th>삭제&emsp;</th>
				</tr>
			</thead>
			<tbody id="search_user_data">
			
			</tbody>
		</table>	
	</div>
		
	<!-- 내정자 개인서류 등록 MODAL 시작-->
	<div class="modal fade" id="registerModal" tabindex="-1" role="dialog" aria-labelledby="modal" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
			
				<div class="modal-header">
					<h5 class="modal-title" id="modal">내정자 개인서류 등록</h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				
				<form action="/fap/admin/personal_required_doc_insert" method="post" onsubmit="return form_Check();" enctype="multipart/form-data">
					<div class="modal-body">					
						<!-- 잡페어 -->
						<input type="hidden" name="fap_job_ad_seq" value="${nominee_info.fap_job_ad_seq }">
						<input type="hidden" name="fap_comp_id" value="${nominee_info.fap_comp_id }">						
						<input type="hidden" name="fap_nominee_seq" value="${nominee_info.fap_nominee_seq}">
						<div class="form-group">
							<label>내정자 개인서류 제목</label>
							<input type="text" name="fap_personal_required_doc_title" id="fap_personal_required_doc_title" class="form-control" maxlength="100">
						</div>
						<div class="form-row">
							<label>내정자 개인서류 상세</label>
						</div>
						<div class="form-row">
							<textarea name="fap_personal_required_doc_detail" id="fap_personal_required_doc_detail" class="form-control" maxlength="500" style=" width:490px; height: 100px;"></textarea>
						</div>
					</div>
					<div class="form-group">
						&emsp;<input type="file" name="fap_personal_required_doc_file" id="fap_personal_required_doc_file">
					</div>
					
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
						<button type="submit" class="btn btn-primary">등록하기</button>
					</div>
					
				</form>
			</div>
		</div>
	</div>
	<!-- 내정자 개인서류 등록 MODAL 종료-->
	
	<!-- 업로드할 내정서류 등록 MODAL 시작-->
	<div class="modal fade" id="uploadModal" tabindex="-1" role="dialog" aria-labelledby="modal" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
			
				<div class="modal-header">
					<h5 class="modal-title" id="modal">서류 업로드</h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				
				<form action="/fap/admin/nominee_required_doc_insert" method="post" onsubmit="return upload_form_Check();" enctype="multipart/form-data">
					<div class="modal-body">					
						<!-- 잡페어 -->
						<input type="hidden" name="fap_job_ad_seq" value="${nominee_info.fap_job_ad_seq }">
						<input type="hidden" name="fap_comp_id" value="${nominee_info.fap_comp_id }">
						<input type="hidden" name="user_id" value="${nominee_info.user_id }">
						<input type="hidden" name="fap_nominee_seq" value="${nominee_info.fap_nominee_seq}">
						<div class="form-group">
							<label>서류 제목</label>
							<input type="text" name="fap_personal_required_doc_title" id="fap_user_required_doc_title" class="form-control" maxlength="100">
						</div>
						<div class="form-row">
							<label>서류 상세</label>
						</div>
						<div class="form-row">
							<textarea name="fap_personal_required_doc_detail" id="fap_user_required_doc_detail" class="form-control" maxlength="500" style=" width:490px; height: 100px;"></textarea>
						</div>
					</div>
					<div class="form-group">
						&emsp;<input type="file" name="fap_personal_required_doc_file" id="fap_user_required_doc_file">
					</div>
					
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
						<button type="submit" class="btn btn-primary">등록하기</button>
					</div>
					
				</form>
			</div>
		</div>
	</div>
	<!-- 업로드할 내정서류 등록 MODAL 종료-->
	
	
	<!-- 내정자 개인서류 수정 MODAL 시작-->
		<div id="update_required_doc_div">
		
		</div>
	<!-- 내정자 개인서류 수정 MODAL 종료-->
	
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Bridge Job Fair</title>
</head>
	<link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
	<link type="text/css" rel="stylesheet" href="<c:url value="/resources/segroup/society/fap/css/popModal.css" />">
	<link rel="stylesheet" type="text/css" href="<c:url value="/resources/segroup/society/fap/css/default.css" />" />
	<link type="text/css" rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto:400,500">		
	<script src="<c:url value="/resources/segroup/js/jquery-3.1.1.js" />"></script>
	<script src="<c:url value="/resources/segroup/js/jquery-ui.js" />"></script>
	<script src="<c:url value="/resources/segroup/js/angular.min.js" />"></script>	
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
	
	<script type="text/javascript">
		var myApp = angular.module('myapp', []);		
		
		myApp.controller('RequiredDocController', ['$scope','$compile','$http', function($scope,$compile,$http){	
					
			//내정서류 리스트 검색
			if("${nominee_info.fap_nominee_seq}" != null && "${nominee_info.fap_nominee_seq}" != ''){
				var fap_nominee_seq = "${nominee_info.fap_nominee_seq}";
				var fap_job_ad_seq = "${nominee_info.fap_job_ad_seq}";
				var fap_comp_id = "${nominee_info.fap_comp_id}";
				var user_id = "${nominee_info.user_id}";
				
				$('#fap_job_ad_seq').val(fap_job_ad_seq);
				$('#fap_comp_id').val(fap_comp_id);
				$('#fap_nominee_seq').val(fap_nominee_seq);
				
				if(fap_comp_id != null && fap_comp_id != ""){
					$('#required_doc_div').show();
				}else{
					$('#required_doc_div').hide();
				}
				
				//회사가 등록한 공통내정서류 검색
				$http({
					method: 'POST',
					url: "/fap/user/user_common_required_doc_search_list",
					params : {
						'fap_job_ad_seq' : fap_job_ad_seq, 'fap_comp_id' : fap_comp_id
					},
					headers : {
						"AJAX" : true
					}
				}).then(function successCallback(response) {
					$scope.common_required_doc_draw(response);
						
						//회사가 등록한 개인내정서류 검색
						$http({
							method: 'POST',
							url: "/fap/user/user_personal_required_doc_search_list",
							params : {
								'fap_nominee_seq' : fap_nominee_seq
							}
						}).then(function successCallback(response) {
							$scope.personal_required_doc_draw(response);
							$scope.user_required_doc_draw(response);
							
						}, function errorCallback(response) {
						
						});
					
				}, function errorCallback(response) {
					if(response.status == 403){
						alert('<spring:message code="com.login.ajaxSesstion" javaScriptEscape="true" />');
						location.href = "/fap/user/user_login";
					}
				});
			}			
			
			//선택한 내정회사 내정서류 검색
			$scope.search_change = function(){
				var fap_comp_id = $('#nominated_company_select option:selected').val();
				var fap_nominee_seq = $('#nominated_company_select option:selected').attr('nominee_seq');
				var fap_job_ad_seq = $('#nominated_company_select option:selected').attr('ad_seq');
				
				$('#fap_job_ad_seq').val(fap_job_ad_seq);
				$('#fap_comp_id').val(fap_comp_id);
				$('#fap_nominee_seq').val(fap_nominee_seq);
				
				if(fap_comp_id != null && fap_comp_id != 0){
					$('#required_doc_div').show();
				}else{
					$('#required_doc_div').hide();
				}
				
				//선택한 회사가 등록한 공통내정서류 검색
				$http({
					method: 'POST',
					url: "/fap/user/user_common_required_doc_search_list",
					params : {
						'fap_job_ad_seq' : fap_job_ad_seq, 'fap_comp_id' : fap_comp_id
					},
					headers : {
						"AJAX" : true
					}
				}).then(function successCallback(response) {
					$scope.common_required_doc_draw(response);
						
						//선택한 회사가 등록한 개인내정서류 검색
						$http({
							method: 'POST',
							url: "/fap/user/user_personal_required_doc_search_list",
							params : {
								'fap_nominee_seq' : fap_nominee_seq
							}
						}).then(function successCallback(response) {
							$scope.personal_required_doc_draw(response);
							$scope.user_required_doc_draw(response);
							
						}, function errorCallback(response) {
						
						});
					
				}, function errorCallback(response) {
					if(response.status == 403){
						alert('<spring:message code="com.login.ajaxSesstion" javaScriptEscape="true" />');
						location.href = "/fap/user/user_login";
					}
				});
			}
			
			//공통 내정서류 리스트 
			$scope.common_required_doc_draw = function(response){
				$scope.results = response.data;
				
				var context = '';								
				context += '<ul ng-repeat="result in results" class="tit6">';
				context += '<li class="wi5">';
				context += '{{result.fap_common_required_doc_title}}';
				context += '</li>';
				context += '<li class="wi6">';
				context += '{{result.fap_common_required_doc_origin}}';
				context += '</li>';
				context += '<li class="wi7">';
				context += '<button value="{{result.fap_common_required_doc_detail}}" ng-click="detail(result.fap_common_required_doc_detail)" class="detailBtn"><spring:message code="fap.common.details" /></button>';
				context += '</li>';
				context += '<li class="wi8">';
				context += '<a href="/file_download?origin={{result.fap_common_required_doc_origin}}&saved={{result.fap_common_required_doc_saved}}&path=/fap/company/required_doc_file/{{result.fap_comp_id}}_{{result.fap_job_ad_seq}}"><button value="{{result.fap_common_required_doc_seq}}" class="downloadBtn"><spring:message code="fap.comp.required_doc_download" /></button></a>';
				context += '	</li>';
				context += '</ul>';					
				
				$("#nuguBB6").html($compile(context)($scope)); 	
			}
			
			//개인 내정서류 리스트 
			$scope.personal_required_doc_draw = function(response){
				$scope.personal_required_doc = response.data;
				
				var context = '';
				context += '<ul ng-repeat="personal in personal_required_doc" class="tit6" ng-if="personal.fap_personal_required_doc_uploader_gb == \'C4800\' ">';
				context += '<li class="wi5">';
				context += '{{personal.fap_personal_required_doc_title}}';
				context += '</li>';
				context += '<li class="wi6">';;
				context += '{{personal.fap_personal_required_doc_origin}}';
				context += '</li>';
				context += '<li class="wi7">';
				context += '<button value="{{personal.fap_personal_required_doc_detail}}" ng-click="detail(personal.fap_personal_required_doc_detail)" class="detailBtn"><spring:message code="fap.common.details" /></button>';
				context += '</li>';
				context += '<li class="wi8">';
				context += '<a href="/file_download?origin={{personal.fap_personal_required_doc_origin}}&saved={{personal.fap_personal_required_doc_saved}}&path=/fap/company/required_doc_file/{{personal.fap_comp_id}}_{{personal.fap_job_ad_seq}}/{{personal.fap_nominee_seq}}"><button value="{{personal.fap_personal_required_doc_seq}}" class="downloadBtn"><spring:message code="fap.comp.required_doc_download" /></button></a>';
				context += '	</li>';
				context += '</ul>';
				
				$("#nuguBB6_1").html($compile(context)($scope));
	
			}
			
			//내정자 내정서류 리스트 
			$scope.user_required_doc_draw = function(response){
				$scope.user_required_doc = response.data;
				
				var context = '';
				context += '<ul ng-repeat="user in user_required_doc" class="title8" ng-if="user.fap_personal_required_doc_uploader_gb == \'C4801\' ">';
				context += '<li class="widt6">';
				context += '{{user.fap_personal_required_doc_title}}';
				context += '</li>';
				context += '<li class="widt7">';
				context += '{{user.fap_personal_required_doc_origin}}';
				context += '</li>';
				context += '<li class="widt8">';
				context += '<button value="{{user.fap_personal_required_doc_detail}}" ng-click="detail(user.fap_personal_required_doc_detail)" class="detailBtn"><spring:message code="fap.common.details" /></button>';
				context += '</li>';
				context += '<li class="widt9">';
				context += '<button value="{{user.fap_personal_required_doc_seq}}" ng-click="update(user.fap_personal_required_doc_seq)" class="updateBtn"><spring:message code="fap.comp.required_doc_update" /></button>';
				context += '</li>';
				context += '<li class="widt10">';
				context += '<a href="/fap/user/user_personal_required_doc_delete?fap_personal_required_doc_seq={{user.fap_personal_required_doc_seq}}&fap_nominee_seq={{user.fap_nominee_seq}}&fap_personal_required_doc_saved={{user.fap_personal_required_doc_saved}}"><button value="{{user.fap_personal_required_doc_seq}}" class="deleteBtn"><spring:message code="fap.comp.required_doc_delete" /></button></a>';
				context += '</li>';
				context += '</ul>';
				
				$("#nuguBB8").html($compile(context)($scope)); 
				
			}
								
			//세부내용 모달로 띄우기
			$scope.detail = function(fap_common_required_doc_detail){
				var fap_common_required_doc_detail = fap_common_required_doc_detail;
				$("#required_doc_detail").val(fap_common_required_doc_detail);				
				$("#detailModal").modal();
			}			
			
			//수정할 내정서류 검색
			$scope.update = function(fap_personal_required_doc_seq){
				var fap_personal_required_doc_seq = fap_personal_required_doc_seq;
				$http({
					method: 'POST',
					url: "/fap/user/user_personal_required_doc_search",
					params : {
						'fap_personal_required_doc_seq' : fap_personal_required_doc_seq
					},
					headers : {
						"AJAX" : true
					}
				}).then(function successCallback(response) {
					$scope.update_required_doc_draw(response.data);					
					$("#updateModal").modal();
				}, function errorCallback(response) {
					if(response.status == 403){
						alert('<spring:message code="com.login.ajaxSesstion" javaScriptEscape="true" />');
						location.href = "/fap/user/user_login";
					}
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
				context += '<h5 class="modal-title" id="modal">내정자 내정서류 수정</h5>';
				context += '<button type="button" class="close" data-dismiss="modal" aria-label="Close">';
				context += '<span aria-hidden="true">&times;</span>';
				context += '</button>';
				context += '</div>';
				context += '<form action="/fap/user/user_personal_required_doc_update" method="post" onsubmit="return update_form_Check();" enctype="multipart/form-data">';
				context += '<div class="modal-body">';
				context += '<input type="hidden" name="fap_personal_required_doc_seq" value="'+result.fap_personal_required_doc_seq+'">';
				context += '<input type="hidden" name="fap_nominee_seq" value="'+result.fap_nominee_seq+'">';
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
				context += '<textarea name="fap_personal_required_doc_detail" id="fap_personal_required_doc_update_detail" class="form-control" maxlength="500" style="text-align: inherit; width:670px; height: 100px;" >{{result.fap_personal_required_doc_detail}}</textarea>';
				context += '</div>';
				context += '</div>';
				context += '<div class="form-group">';
				context += '<div class="file_input_div" style="width: 670px;">';
				context += '<input type="button" value="'+result.fap_personal_required_doc_origin+'" id="updateFileBtn" class="file_update_button" style="left: 0px;" />';
				context += '<input type="file" class="file_input_hidden" name="fap_personal_required_doc_file" id="fap_personal_required_doc_update_file" value="'+result.fap_personal_required_doc_origin+'" onchange="file_change(this.files[0].name)" style="width: 900px;">';
				context += '</div>';
				context += '</div>';							
				context += '<div class="modal-footer">';
				context += '<button type="button" class="btn btn-primary" data-dismiss="modal"><spring:message code="fap.comp.modal_cancel" /></button>';
				context += '<button type="submit" class="btn btn-primary"><spring:message code="fap.comp.required_doc_update" /></button>';
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
			var fap_common_required_doc_title = $('#fap_common_required_doc_title').val();
			var fap_common_required_doc_file = $('#fap_common_required_doc_file').val();
			
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
			var fap_user_required_doc_update_title = $('#fap_user_required_doc_update_title').val();						
			//서류제목
			if(fap_user_required_doc_update_title == ''){
				alert('제목은 필수 입력 사항입니다.');
				$('#fap_user_required_doc_title').focus();
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
		    $("#fap_user_required_doc_update_file").on("change", function() { 
		    	$("#updateFileBtn").html(this.value); 
		    }); 
		}); 
		
		//등록 MODAL
		function register(){
			if($('#nominated_company_select option:selected').val() == 0){
				alert('내정기업을 선택하세요.');
				return false;
			}
			$("#uploadModal").modal();
		}
		
	</script>
	
<body ng-app="myapp" ng-controller="RequiredDocController">
	<%@include file="user_menu.jsp"%><%@include file="user_quick_menu.jsp"%>
		<div id="subcontents">
	<h3 >내정자 내정서류 관리</h3>	
	<br><br>
	
	<h3 style="display: inline;" >내정 회사</h3>
	<select id="nominated_company_select" onchange="angular.element(this).scope().search_change()" style="width: 300px; height:30px; ">
		<option value="0">선택</option>
		<c:forEach var="result" items="${nominated_company_list}">									
			<option value="${result.fap_comp_id}" <c:if test="${nominee_info.fap_comp_id == result.fap_comp_id}">selected</c:if> ad_seq="${result.fap_job_ad_seq }" nominee_seq="${result.fap_nominee_seq }">${result.fap_comp_en_nm}</option>		
		</c:forEach>
	</select>
	
	<br><br>
	
	<div id="nugu">
	 <br><br>
		<div id="nuguBox">
			 <ul>		   	 
		        <li class="jointxt1">
						공통내정서류
				</li>		       
		        <li class="jointxt2"><img src="/resources/segroup/society/fap/images/login_bar.gif" /></li>
		        <li> 
	        		<div id="nuguBB5">
		                <ul class="tit5">
		                	<li class="wi1"><spring:message code="fap.comp.required_doc_title" /></li>
		                    <li class="wi2"><spring:message code="fap.comp.required_doc_file" /></li>
		                    <li class="wi3"><spring:message code="fap.common.details" /></li>
		                    <li class="wi4"><spring:message code="fap.comp.required_doc_download" /></li>
		                </ul>
		            </div>
		            <div id="nuguBB6">    
		                
		             </div>        
		        </li>
		    </ul>
		    <br><br>
		   </div>
		    
		    <div id="nuguBox">
			 <ul>		   	 
		        <li class="jointxt1">
						개인내정서류
				</li>		       
		        <li class="jointxt2"><img src="/resources/segroup/society/fap/images/login_bar.gif" /></li>
		        <li> 
	        		<div id="nuguBB5">
		                <ul class="tit5">
		                	<li class="wi1"><spring:message code="fap.comp.required_doc_title" /></li>
		                    <li class="wi2"><spring:message code="fap.comp.required_doc_file" /></li>
		                    <li class="wi3"><spring:message code="fap.common.details" /></li>
		                    <li class="wi4"><spring:message code="fap.comp.required_doc_download" /></li>
		                </ul>
		            </div>
		            <div id="nuguBB6_1">    
		                
		             </div>        
		        </li>
		    </ul>
		    <br><br>
		</div>
		
		<div id="nuguBox">
			 <ul>		   	 
		        <li class="jointxt1">
					<h4 style="display: inline;">서류 업로드</h4>
					<img alt="" src="/resources/segroup/society/fap/images/main/plus_icon.png" data-toggle="modal" onclick="register()">
				</li>		       
		        <li class="jointxt2"><img src="/resources/segroup/society/fap/images/login_bar.gif" /></li>
		        <li> 
	        		<div id="nuguBB7">
		                <ul class="title7">
		                	<li class="widt1"><spring:message code="fap.comp.required_doc_title" /></li>
		                    <li class="widt2"><spring:message code="fap.comp.required_doc_file" /></li>
		                    <li class="widt3"><spring:message code="fap.common.details" /></li>
		                    <li class="widt4"><spring:message code="fap.comp.required_doc_update" /></li>
		                    <li class="widt5"><spring:message code="fap.comp.required_doc_delete" /></li>
		                </ul>
		             </div>
		            <div id="nuguBB8">    
		                
		             </div>        
		        </li>
		    </ul>
		    <br><br>
		</div>
	</div>
</div>

	<%@include file="../common_footer_fap.jsp"%>
	
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
				
				<form action="/fap/user/user_required_doc_insert" method="post" onsubmit="return form_Check();" enctype="multipart/form-data">
					<div class="modal-body">					
						<!-- 잡페어 -->
						<input type="hidden" id="fap_job_ad_seq" name="fap_job_ad_seq" value="">
						<input type="hidden" id="fap_comp_id" name="fap_comp_id" value="">
						<input type="hidden" id="fap_nominee_seq" name="fap_nominee_seq" value="">
						<div class="form-group">
							<label>서류 제목</label>
							<input type="text" name="fap_personal_required_doc_title" id="fap_user_required_doc_title" class="form-control" maxlength="100">
						</div>
						<div class="form-row">
							<label>서류 상세</label>
						</div>
						<div class="form-row">
							<textarea name="fap_personal_required_doc_detail" id="fap_user_required_doc_detail" class="form-control" maxlength="500" style="text-align: inherit; width:670px; height: 100px;"></textarea>
						</div>
					</div>
					<div class="form-group">
						&emsp;<input type="file" name="fap_personal_required_doc_file" id="fap_user_required_doc_file">
					</div>
					
					<div class="modal-footer">
						<button type="button" class="btn btn-primary" data-dismiss="modal"><spring:message code="fap.comp.modal_cancel" /></button>
						<button type="submit" class="btn btn-primary"><spring:message code="fap.comp.modal_insert" /></button>
					</div>
					
				</form>
			</div>
		</div>
	</div>
	<!-- 업로드할 내정서류 등록 MODAL 종료-->
	
	<!-- 내정자 내정서류 수정 MODAL 시작-->
		<div id="update_required_doc_div">
		
		</div>
	<!-- 내정자 내정서류 수정 MODAL 종료-->
	
	<!-- 내정자 공통서류 상세 MODAL 시작-->
	<div class="modal fade" id="detailModal" tabindex="-1" role="dialog" aria-labelledby="modal" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">			
				<div class="modal-header">
					<h3 class="modal-title" id="modal"><spring:message code="fap.comp.required_doc_detail" /></h3>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>				
					<div class="modal-body">
						<div class="form-row">
							<label><spring:message code="fap.common.details" /></label>
						</div>
						<div class="form-row">
							<textarea id="required_doc_detail" class="form-control" maxlength="500" style="text-align: inherit; width:670px; height: 100px;"></textarea>
						</div>
					</div>
			</div>
		</div>
	</div>
	<!-- 내정자 공통서류 상세 MODAL 종료-->
		
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Bridge Job Fair</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css"> -->
<script src="<c:url value="/resources/segroup/js/jquery-3.1.1.js" />"></script>
<!-- <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script> -->
<script src="<c:url value="/resources/segroup/js/angular.min.js" />"></script>
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/segroup/society/fap/css/default.css" />" />
<!-- css 동적 변화 감지하는 라이브러리 -->
<%-- <script src="<c:url value="/resources/segroup/js/attrchange.js" />"></script> --%>

<script type="text/javascript">
	var myApp = angular.module('myapp',[]);
	
	myApp.controller('AdminController',['$scope','$compile','$http', function($scope,$compile,$http){
		// [start] 세부잡페어 출력 시작
		$http({
				url: 'select_jobfair_divide_list_in_additional_apply',
				method: 'get',
				params: {fap_jobfair_seq : $('#fap_jobfair_seq').val()},
				XMLHttpRequestResponseType: 'json'
			}).then(function successCallback(response) {
				var context = '';
				context +=	'<select onchange="angular.element(this).scope().select_change()" id="select_jobfair_detail" class="m10">';
				context +=		'<option seq="0">선택해주세요.</option>';
				$(response.data).each(function (index, jobfairDivideInfo) {
					context += '<option selectcode seq="' + jobfairDivideInfo.fap_jobfair_divide_seq + '" value="'+ jobfairDivideInfo.fap_jobfair_divide_gb +'\"></option>';
				});
				context +=	'</select>';
				
				$('#select-box-layout').append($compile(context)($scope));
				
			}, function errorCallback(response) {
				console.log(response);
			});
		// [end] 세부잡페어 출력 종료
		
		$scope.select_change = function(){
			$(".rule-body").empty();
			$(".pagination").empty();
			var fap_jobfair_divide_seq = $('#select_jobfair_detail option:selected').attr('seq');
			if(fap_jobfair_divide_seq == 0){
				$("#select_time_nm").remove();
			}else{
				
				$http({
					url:'select_jobfair_applicable_time_nm_list',
					method:'post',
					params:{fap_jobfair_divide_seq : fap_jobfair_divide_seq},
					XMLHttpRequestResponseType: 'json'
				}).then(function successCallback(response){
					var data = response.data;
					console.log(data);
					if(data.length > 0){
						$("#select_time_nm").remove();
						
						var context = '';
						context +=	'<select onchange="angular.element(this).scope().select_nm()" id="select_time_nm" class="m10">';
						context +=		'<option value="0">선택해주세요.</option>';
						$.each(data,function(index,item){
							context += '<option value="'+item.fap_jobfair_applicable_time_seq+'">'+item.fap_jobfair_applicable_time_nm+'</option>';
						})
						context += '</select>';
						
						$('#select-box-layout').append(context);
					}else{
						$("#select_time_nm").remove();
						alert("설정된 지원가능 기간이 없습니다.");
					}
					
				},function errorCallback(response){
					console.log(response);
				});
			}
		}
		
		$scope.select_nm = function(){
			var fap_jobfair_applicable_time_seq = $("#select_time_nm").val();
			var pageCount = $("#search_count").val();
			if(fap_jobfair_applicable_time_seq == 0){
				//밑에부분 리무브
				$(".rule-body").empty();
				$(".pagination").empty();
			}else{
				$scope.drawlist(fap_jobfair_applicable_time_seq,pageCount,1,0);
			}
			
		}
		
		$scope.select_count = function(){
			var pageCount = $("#search_count").val();
			var fap_jobfair_applicable_time_seq = $("#select_time_nm").val();
			
			if(fap_jobfair_applicable_time_seq == 0 || typeof fap_jobfair_applicable_time_seq == "undefined"){
				alert("기간을 선택 하세요");
			}else{
				$scope.drawlist(fap_jobfair_applicable_time_seq,pageCount,1,0);
			}
			
		}
		
		$scope.select_page = function(curPage){
			var fap_jobfair_applicable_time_seq = $("#select_time_nm").val();
			var pageCount = $("#search_count").val();
			$scope.drawlist(fap_jobfair_applicable_time_seq,pageCount,curPage,0);
		}
		
		$scope.rule_apply_btn = function(){
			var fap_job_ad_seq_list = [];
			var fap_jobfair_rule_seq_list = [];
			$(".rule-check").each(function(index,item){
				if(!$(this).hasClass("all")){
					if($(this).hasClass("ck")){
						fap_job_ad_seq_list.push($(this).attr("seq"));
						fap_jobfair_rule_seq_list.push($(this).attr("rule"));
					}
				}
			})
			
			if(fap_job_ad_seq_list.length == 0){
				alert("채용공고를 선택해 주세요.");
			}else{
				if(confirm("룰 적용을 하시겠습니까? 적용 후에는 지원자가 기업에게 노출 됩니다. 되돌릴 수 없습니다.")){
					$scope.rule_apply_fnc(fap_job_ad_seq_list,fap_jobfair_rule_seq_list);
				}
			}
		}
		$scope.rule_apply_one_btn = function(fap_job_ad_seq,fap_jobfair_rule_seq){
			var fap_job_ad_seq_list = [];
			var fap_jobfair_rule_seq_list = [];
			fap_job_ad_seq_list.push(fap_job_ad_seq);
			fap_jobfair_rule_seq_list.push(fap_jobfair_rule_seq);
			if(confirm("룰 적용을 하시겠습니까? 적용 후에는 지원자가 기업에게 노출 됩니다. 되돌릴 수 없습니다.")){
				$scope.rule_apply_fnc(fap_job_ad_seq_list,fap_jobfair_rule_seq_list);
			}
		}
		
		$scope.rule_apply_fnc = function(fap_job_ad_seq_list,fap_jobfair_rule_seq_list){
			
			var fap_jobfair_divide_seq = $('#select_jobfair_detail option:selected').attr('seq');
			var fap_jobfair_applicable_time_seq = $("#select_time_nm").val();
			
			$http({
				url:'resume_approval_after_rule_apply',
				method:'post',
				params:{
						fap_job_ad_seq_list : fap_job_ad_seq_list,
						fap_jobfair_rule_seq_list : fap_jobfair_rule_seq_list,
						fap_jobfair_divide_seq : fap_jobfair_divide_seq,
						fap_jobfair_apply_rule_gb : 'D1901',
						fap_jobfair_applicable_time_seq : fap_jobfair_applicable_time_seq
				},
				XMLHttpRequestResponseType:'json'
			}).then(function successCallback(response){
				var fap_jobfair_applicable_time_seq = $("#select_time_nm").val();
				var pageCount = $("#search_count").val();
				var curPage = $(".pagination").find("a.active").text();
				var orderNo = $("#order_no").val();
				
				$scope.drawlist(fap_jobfair_applicable_time_seq,pageCount,curPage,orderNo);
			}, function errorCallback(response){
				console.log(response);
			})
		}
		
		$scope.exception_apply_btn = function(){
			var fap_job_ad_seq_list = [];
			var fap_jobfair_rule_seq_list = [];
			
			$(".rule-check").each(function(index,item){
				if(!$(this).hasClass("all")){
					if($(this).hasClass("ck")){
						fap_job_ad_seq_list.push($(this).attr("seq"));
						fap_jobfair_rule_seq_list.push($(this).attr("rule"));
					}
				}
			})
			
			if(fap_job_ad_seq_list.length == 0){
				alert("채용공고를 선택해 주세요.");
			}else{
				if(confirm("룰 예외 적용을 하시겠습니까? 적용 후에는 지원자가 기업에게 노출 됩니다. 되돌릴 수 없습니다.")){
					$scope.exception_apply_fnc(fap_job_ad_seq_list,fap_jobfair_rule_seq_list);
				}
			}
		}
		
		$scope.exception_apply_one_btn = function(fap_job_ad_seq,fap_jobfair_rule_seq){
			var fap_job_ad_seq_list = [];
			var fap_jobfair_rule_seq_list = [];
			fap_job_ad_seq_list.push(fap_job_ad_seq);
			fap_jobfair_rule_seq_list.push(fap_jobfair_rule_seq)
			if(confirm("룰 예외 적용을 하시겠습니까? 적용 후에는 지원자가 기업에게 노출 됩니다. 되돌릴 수 없습니다.")){
				$scope.exception_apply_fnc(fap_job_ad_seq_list,fap_jobfair_rule_seq_list);
			}
		}
		
		$scope.exception_apply_fnc = function(fap_job_ad_seq_list,fap_jobfair_rule_seq_list){
			var fap_jobfair_divide_seq = $('#select_jobfair_detail option:selected').attr('seq');
			var fap_jobfair_applicable_time_seq = $("#select_time_nm").val();
			
			$http({
				url:'resume_ignore_after_rule_apply',
				method:'post',
				params:{
						fap_job_ad_seq_list : fap_job_ad_seq_list,
						fap_jobfair_rule_seq_list : fap_jobfair_rule_seq_list,
						fap_jobfair_divide_seq : fap_jobfair_divide_seq,
						fap_jobfair_apply_rule_gb : 'D1902',
						fap_jobfair_applicable_time_seq : fap_jobfair_applicable_time_seq
				},
				XMLHttpRequestResponseType:'json'
			}).then(function successCallback(response){
				var fap_jobfair_applicable_time_seq = $("#select_time_nm").val();
				var pageCount = $("#search_count").val();
				var curPage = $(".pagination").find("a.active").text();
				var orderNo = $("#order_no").val();
				
				$scope.drawlist(fap_jobfair_applicable_time_seq,pageCount,curPage,orderNo);
			}, function errorCallback(response){
				console.log(response);
			})
		}
		
		$scope.drawlist = function(fap_jobfair_applicable_time_seq,pageCount,curPage,orderNo){
			$http({
				url:'select_jobfair_applicable_ad_list',
				method:'post',
				params:{
						fap_jobfair_applicable_time_seq : fap_jobfair_applicable_time_seq,
						pageCount : pageCount,
						curPage : curPage,
						orderNo : orderNo
				},
				XMLHttpRequestResponseType:'json'
			}).then(function successCallback(response){
				console.log(response);
				var data = response.data.result;
				var navi = response.data.navi;
				var context = '';
				
				if(data.length == 0){
					context += '<tr><td rowspan="4" colspan="9">검색된 결과가 없습니다</td></tr>';
					context += '<tr></tr><tr></tr><tr></tr>';
					$(".pagination").empty();
					
				}else{
					$.each(data,function(index,item){
						context += '<tr><td>';
						if(item.fap_jobfair_apply_rule_gb == 'D1900'){
							context += '<span class="rule-check" seq="'+item.fap_job_ad_seq+'" rule="'+item.fap_jobfair_apply_rule_seq+'"><label class="rule-check-label"></label></span>';
						}
						context += '</td>';
						context += '<td class="ellipsis min60 max100"><code value="'+item.fap_job_ad_category_type+'"></code></td>';
						context += '<td class="ellipsis max300" title="'+item.fap_job_ad_title+'">'+item.fap_job_ad_title+'</td>';
						context += '<td class="ellipsis max230" title="'+item.fap_comp_en_nm+'">'+item.fap_comp_en_nm+'</td>';
						context += '<td>'+item.fap_job_apply_num+'</td>';
						context += '<td>'+item.fap_job_applied_num+'</td>';
						context += '<td>'+item.fap_job_app_per_settled_num+'</td>';
						context += '<td>'+item.fap_job_ad_recruit_num+'</td>';

						if(item.fap_jobfair_apply_rule_gb == 'D1900'){
							context += '<td><a class="pointer" onclick="angular.element(this).scope().rule_apply_one_btn('+item.fap_job_ad_seq+','+item.fap_jobfair_apply_rule_seq+')"><code value="'+item.fap_jobfair_apply_rule_gb+'"></code></a></td>';
							context += '<td><a class="pointer" onclick="angular.element(this).scope().exception_apply_one_btn('+item.fap_job_ad_seq+','+item.fap_jobfair_apply_rule_seq+')"><code value="'+item.fap_jobfair_apply_rule_gb+'"></code></a></td>';
						}else if(item.fap_jobfair_apply_rule_gb == 'D1901'){
							context += '<td><code value="'+item.fap_jobfair_apply_rule_gb+'"></code></td>';
							context += '<td> - </td>';
						}else if(item.fap_jobfair_apply_rule_gb == 'D1902'){
							context += '<td> - </td>';
							context += '<td><code value="'+item.fap_jobfair_apply_rule_gb+'"></code></td>';
						}
						context += '</tr>';
					})
					
					var page = '<a class="pointer" onclick="angular.element(this).scope().select_page('+(navi.currentPage - 1)+')">&laquo;</a>';
					for(var i = navi.startPageGroup; i <= navi.endPageGroup; i++){
						if(i == navi.currentPage){
							page += '<a class="pointer active" onclick="angular.element(this).scope().select_page('+i+')">'+i+'</a>';
						}else{
							page += '<a class="pointer" onclick="angular.element(this).scope().select_page('+i+')">'+i+'</a>';
						}
					}
					page += '<a class="pointer" onclick="angular.element(this).scope().select_page('+(navi.currentPage + 1)+')">&raquo;</a>';

					$(".pagination").html(page);
				}
				
				$(".rule-body").html($compile(context)($scope));
				
				$(".rule-check").off("click").on("click",function(){
					$(this).toggleClass("ck");
					
					if($(this).hasClass("all")){
						if($(this).hasClass("ck")){
							$(".rule-check").each(function(index,item){
								if(!$(this).hasClass("ck")){
									$(this).toggleClass("ck");
								}
							})
						}else{
							$(".rule-check").each(function(index,item){
								if($(this).hasClass("ck")){
									$(this).toggleClass("ck");
								}
							})
						}
					}
					
				})
				
				$(".order").off("click").on("click",function(){
					$(this).toggleClass("on");
					var orderNo = 0;
					var curPage = $(".pagination").find("a.active").text();
					//계열
					if($(this).hasClass("category-type")){
						if($(this).hasClass("on")){
							orderNo = 1;
						}else{
							orderNo = 2;
						}
					}else if($(this).hasClass("rule-apply")){
						if($(this).hasClass("on")){
							orderNo = 3;
						}else{
							orderNo = 4;
						}
					}else if($(this).hasClass("exception-apply")){
						if($(this).hasClass("on")){
							orderNo = 5;
						}else{
							orderNo = 6;
						}
					}
					
					var pageCount = $("#search_count").val();
					var fap_jobfair_applicable_time_seq = $("#select_time_nm").val();
					
					if(fap_jobfair_applicable_time_seq == 0 || typeof fap_jobfair_applicable_time_seq == "undefined"){
						alert("기간을 선택 하세요");
					}else{
						$("#order_no").val(orderNo);
						$scope.drawlist(fap_jobfair_applicable_time_seq,pageCount,curPage,orderNo);
					}
					
				})
				
			}, function errorCallback(response){
				console.log(response);
			});
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
</head>
<body ng-app="myapp" ng-controller="AdminController">
<%@include file="admin_menu.jsp"%>
<input type="hidden" value="${fap_jobfair_seq}" name="fap_jobfair_seq" id="fap_jobfair_seq">
<input type="hidden" id="order_no" value="0">
<div class="join-wrap">
	<div id="subcontents" class="admin">
		<h1>지원룰 적용</h1>
		<div id="nowBox">
			<div class="box-wrap">
				<div id="select-box-layout">
					<select class="m10" id="search_count" onchange="angular.element(this).scope().select_count()">
						<option value="10">10개씩 보기</option>
						<option value="50">50개씩 보기</option>
						<option value="100">100개씩 보기</option>
					</select>
				</div>
				<div id="btn-box-layout">
					<button class="rule-btn" ng-click="rule_apply_btn()">선택 룰 적용</button>
					<button class="rule-btn" ng-click="exception_apply_btn()">선택 예외 적용</button>
				</div>
			</div>
			<div class="rule-list">
				<table class="rule-table">
					<thead>
						<tr>
							<th class="min60">
								<span class="rule-check all">
									<label class="rule-check-label"></label>
								</span>
								<input type="checkbox">
							</th>
							<th class="min60 category-type pointer order">계열</th>
							<th class="max300">채용공고제목</th>
							<th class="max230">회사명</th>
							<th>지원인원</th>
							<th>지원된인원</th>
							<th>지원설정인원</th>
							<th>채용예정인원</th>
							<th class="min60 pointer rule-apply order">지원룰적용</th>
							<th class="min60 pointer exception-apply order">룰예외적용</th>
						</tr>
					</thead>
					<tbody class="rule-body">
					</tbody>
				</table>
			</div>
		</div>
		<div class="pagination">
		</div>
	</div>
</div>
</body>

<%-- <script type="text/javascript">
	$(function() {
		$('#myModal').modal('show');
		
		$('#closeModalBtn').click(function () {
		 	location.href="/fap/admin/jobfair_management";
		});
		//모달창에 바깥부분 클릭시 모달창 종료되는데 그때 변화 감지해서 관리페이지동 이동시킴
	 	$('#myModal').attrchange({
			trackValues: true,
			callback : function(evnt) {
		        if(evnt.attributeName == 'style') {
		            if(evnt.newValue.search(/block/i) == -1) {
		            	location.href="/fap/admin/jobfair_management";
		            }
		        }
		    }
		});
	});

	var myApp = angular.module('myapp', []);
	
	myApp.controller('applyBusinessRuleApplicationFormController', ['$scope','$compile','$http', function($scope, $compile, $http){
		
		// [start] 세부잡페어 출력 시작
		$http({
				url: 'select_jobfair_divide_list_in_additional_apply',
				method: 'get',
				params: {fap_jobfair_seq : $('#fap_jobfair_seq').val()},
				XMLHttpRequestResponseType: 'json'
			}).then(function successCallback(response) {
				$("#choicedJobFairDivide").children().remove();
				$('#choicedJobFairDivide').append('<option seq="0" value="">---잡페어를 선택해주세요---</option>');
				$(response.data).each(function (index, jobfairDivideInfo) {
					$('#choicedJobFairDivide').append($compile(
							'<option selectcode seq="' + jobfairDivideInfo.fap_jobfair_divide_seq + '" value="'
							+ jobfairDivideInfo.fap_jobfair_divide_gb +'\"></option>')($scope));
				});
				
			}, function errorCallback(response) {
				console.log(response);
			});
		// [end] 세부잡페어 출력 종료
		
		// [start] 잡페어 세부 검색 클릭 후 취업지원자 승인해줘야 할 시간 리스트 출력 시작
		$scope.mustApprovalApplicableTimeList = function(){
			var fap_jobfair_divide_seq =  $('#choicedJobFairDivide option:selected').attr('seq');
			
			//잡페어 세부별 지원가능 시간 조회
			$http({
				url: 'select_jobfair_divide_applicable_time',
				method: 'post',
				params: {fap_jobfair_divide_seq : fap_jobfair_divide_seq},
				XMLHttpRequestResponseType: 'json'
			}).then(function successCallback(response) {
				$('#applicableTimeContainer').children().remove();
				var context = '';
				var cnt = 0;
				for(var i in response.data){
					cnt += 1;
					context += '<div id="applicableTimeDetailDiv'+ response.data[i].fap_jobfair_applicable_time_seq +'"  style="text-align: center;">';
					context += '<input type="hidden" id="fap_jobfair_divide_seq" name="fap_jobfair_divide_seq" value="' + response.data[i].fap_jobfair_divide_seq + '">';
					context += '<h4>' + cnt +'.&nbsp;<code value="'+ response.data[i].fap_jobfair_applicable_time_first +'"></code>';
					context += '<h4>지원 시작 시간&nbsp;:&nbsp;' + response.data[i].fap_jobfair_applicable_time_st + '시</h4>';
					context += '<h4>지원 종료 시간&nbsp;:&nbsp;' + response.data[i].fap_jobfair_applicable_time_et + '시</h4>';
					if (response.data[i].rule_apply_time == undefined) {
						context += '<h6>*&nbsp;아직 마감시간이 지나지않았습니다.</h6>'
					}else{
						context += '<h6>*&nbsp;마감시간이 지났습니다. 지원룰을 적용해주세요</h6>';
						context += '<button type="button" seq="'+ response.data[i].fap_jobfair_applicable_time_seq +'" ng-click="resumeApprovalAfterRuleApply($event)" class="btn btn-primary">룰 적용 후 승인</button>';
						context += '&nbsp;&nbsp;';
						context += '<button type="button" seq="'+ response.data[i].fap_jobfair_applicable_time_seq +'" ng-click="resumeIgnoreAfterRuleApply($event)" class="btn btn-danger">룰 무시 후 승인</button>';	
					}
					context += '</div>';
					context += '<br><br>';
				}
				if(cnt == 0){
					context = '<h4 style="text-align: center;"><기간이 도래한 설정시간이 존재하지 않습니다.></h4>' 
				}
				$('#applicableTimeContainer').append($compile(context)($scope));
				
			}, function errorCallback(response) {
				console.log(response);
			});
			
		}
		// [end] 잡페어 세부 검색 클릭 후 취업지원자 승인해줘야 할 시간 리스트 출력 종료
		
		// [start] 룰 적용 후 취업지원자 이력서 승인 시작
		$scope.resumeApprovalAfterRuleApply = function(e) {
			var realApply = confirm('정말 승인하시겠습니까?');
			if(realApply == false){
				return false;
			}
			var fap_jobfair_applicable_time_seq = $(e.currentTarget).attr('seq');
			var fap_jobfair_divide_seq = $('#applicableTimeDetailDiv'+fap_jobfair_applicable_time_seq).find('#fap_jobfair_divide_seq').val();
			var approvalInsertInfoMap = {
					'fap_jobfair_applicable_time_seq' : fap_jobfair_applicable_time_seq
					,'fap_jobfair_divide_seq' : fap_jobfair_divide_seq
			}
			
			$http({
				url: 'resume_approval_after_rule_apply',
				method: 'post',
				headers: {'Content-Type': 'application/json'},
				data: JSON.stringify(approvalInsertInfoMap),
				responseType : 'text'
			}).then(function successCallback(response) {
				switch(response.data){
					case 'insertFail' : 
						alert('승인되었지만 적용된 취업지원자가 없었습니다.');
						break;
					case 'insertAfterUpdateSuccess' : 
						alert('승인되었습니다.');
						break;
					default : 
						alert('문제가 발생하였습니다. 관리자에게 문의해 주세요.');
						break;
						//이 부분 실행되었을 시 insert는 됬으나 update가 안되는 버그상태이므로 쿼리 확인 요망
				}
				$scope.mustApprovalApplicableTimeList();
			}, function errorCallback(response) {
				console.log(response);
			});
		}
		// [end] 룰 적용 후 취업지원자 이력서 승인 종료
		
		// [start] 룰 무시하고 취업지원자 이력서 승인 시작
		$scope.resumeIgnoreAfterRuleApply = function(e) {
			var realApply = confirm('정말 승인하시겠습니까?');
			if(realApply == false){
				return false;
			}
			var fap_jobfair_applicable_time_seq = $(e.currentTarget).attr('seq');
			var fap_jobfair_divide_seq = $('#applicableTimeDetailDiv'+fap_jobfair_applicable_time_seq).find('#fap_jobfair_divide_seq').val();
			var ignoreInsertInfoMap = {
					'fap_jobfair_applicable_time_seq' : fap_jobfair_applicable_time_seq
					,'fap_jobfair_divide_seq' : fap_jobfair_divide_seq
			}
			
			$http({
				url: 'resume_ignore_after_rule_apply',
				method: 'post',
				headers: {'Content-Type': 'application/json'},
				data: JSON.stringify(ignoreInsertInfoMap),
				responseType : 'text'
			}).then(function successCallback(response) {
				switch(response.data){
					case 'insertFail' : 
						alert('승인되었지만 적용된 취업지원자가 없었습니다.');
						break;
					case 'insertAfterUpdateSuccess' : 
						alert('승인되었습니다.');
						break;
					default : 
						alert('문제가 발생하였습니다. 관리자에게 문의해 주세요.');
						break;
						//이 부분 실행되었을 시 insert는 됬으나 update가 안되는 버그상태이므로 쿼리 확인 요망
				}
				$scope.mustApprovalApplicableTimeList();
			}, function errorCallback(response) {
				console.log(response);
			});
		}
		// [end] 룰룰 무시하고 취업지원자 이력서 승인 종료
		
	}]);
	
	//selectcode
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
</script>
<title>Bridge Job Fair</title>
</head>
<body ng-app="myapp" ng-controller="applyBusinessRuleApplicationFormController">

	<input type="hidden" value="${fap_jobfair_seq}" name="fap_jobfair_seq" id="fap_jobfair_seq">
	
	<!-- Modal --------------->
	<div class="modal fade" id="myModal" role="dialog">
	
		<!-- Modal dialog------------------------->
		<div class="modal-dialog" id="modal-dialog">
		
			<!-- 1 Modal content------------------------->
			<div class="modal-content">
				<div class="modal-header">
					<h4 class="modal-title" id="title">
						지원룰 적용
					</h4>
				</div>
				
				<!-- body 시작-->
				<div class="modal-body">
					<select id="choicedJobFairDivide" onchange="angular.element(this).scope().mustApprovalApplicableTimeList()"></select>
					<br><br>
					<h4 style="text-align: center;">현재 진행중인 지원가능시간</h4>
					<br>
					<!-- inner html 출력할 부분 -->
					<div id="applicableTimeContainer">
						
					</div>
						
        		</div>
				<!-- body 끝 -->

				<div class="modal-footer">
					<button type="button" id="closeModalBtnClose" class="btn btn-default" data-dismiss="modal">닫기</button>
				</div>
			
			</div>
			<!-- modal content div 종료 -->
			
		</div>
		<!-- modal-dialog div 종료 -->
		
	</div>  
	<!-- modal fade div 종료 -->
	
	
</body> --%>
</html>
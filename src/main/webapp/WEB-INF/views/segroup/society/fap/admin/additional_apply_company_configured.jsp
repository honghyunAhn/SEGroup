<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html PUBLIC>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">
<script src="<c:url value="/resources/segroup/js/jquery-3.1.1.js" />"></script>
<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
<script src="<c:url value="/resources/segroup/js/angular.min.js" />"></script>
<!-- css 동적 변화 감지하는 라이브러리 -->
<script src="<c:url value="/resources/segroup/js/attrchange.js" />"></script>
<script type="text/javascript">
	$(function() {
		$('#myModal').modal('show');
		
		$('#closeModalBtn, #closeModalBtnClose').click(function () {
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
	
	myApp.controller('additionalApplyCompanyConfiguredController', ['$scope','$compile','$http', function($scope, $compile, $http){
		
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
		
		// [start] 잡페어 세부 검색 클릭 후 채용공고 리스트, 추가지원 가능한 채용공고 리스트 출력 시작
		$scope.readCompanyAdList = function(){
			var fap_jobfair_divide_seq =  $('#choicedJobFairDivide option:selected').attr('seq');
			
			// [start] 전체 채용공고 리스트 출력 시작
			$http({
				url: 'select_jobfair_divide_ad_apply_status_info',
				method: 'post',
				params: {fap_jobfair_divide_seq : fap_jobfair_divide_seq},
				XMLHttpRequestResponseType: 'json'
			}).then(function successCallback(response) {
				$('#adApplyStatusInfoListTbody').children().remove();
				var context = '';
				var cnt = 1;
				for(var i in response.data){
					context += '<tr id="adApplyStatusInfoListTr'+ response.data[i].fap_job_ad_seq +'">';
					context += '<input type="hidden" id="fap_jobfair_divide_seq" name="fap_jobfair_divide_seq" value="' + response.data[i].fap_jobfair_divide_seq + '">';
					context += '<input type="hidden" id="fap_job_ad_seq" name="fap_job_ad_seq" value="' + response.data[i].fap_job_ad_seq + '">';
					context += '<td>'+ cnt + '</td>';					
					context += '<td>'+ response.data[i].fap_comp_ja_nm +'</td>';
					context += '<td>'+ response.data[i].fap_job_ad_title + '<br>';
					context += '(<code value="'+ response.data[i].fap_job_ad_is_mismatching +'"></code>)</td>';
					context += '<td><code value="'+ response.data[i].fap_job_ad_state +'"></code></td>';
					context += '<td>'+ response.data[i].fap_job_ad_groupcode +'</td>';
					context += '<td>'+ response.data[i].fap_job_ad_recruit_num +'</td>';
					context += '<td>'+ response.data[i].fap_job_app_per_settled_num +'</td>';
					context += '<td>'+ response.data[i].now_apply_nums +'</td>';
					context += '<td><button type="button" ng-click="insertIntoAdditionalApplyInfoBtn($event)" data-id="adApplyStatusInfoListTr'+ response.data[i].fap_job_ad_seq +'" class="btn btn-default">추가</button></td>';
					context += '</tr>';
					cnt += 1;
				}
				$('#adApplyStatusInfoListTbody').append($compile(context)($scope));
				
			}, function errorCallback(response) {
				console.log(response);
			});
			// [end] 전체 채용공고 리스트 출력 종료
			
			// [start] 추가지원 가능한 채용공고 리스트 출력 시작
			$http({
				url: 'select_jobfair_divide_addition_comp_list',
				method: 'post',
				params: {fap_jobfair_divide_seq : fap_jobfair_divide_seq},
				XMLHttpRequestResponseType: 'json'
			}).then(function successCallback(response) {
				$('#additionCompListTbody').children().remove();
				var context = '';
				var cnt = 1;
				for(var i in response.data){
					console.log("fap_jobfair_applicable_time_seq:"+response.data[i].fap_jobfair_applicable_time_seq+",fap_jobfair_apply_rule_seq:"+response.data[i].fap_jobfair_apply_rule_seq);
					context += '<tr id="additionCompListTr'+ response.data[i].fap_job_ad_seq +'">';
					context += '<input type="hidden" id="fap_jobfair_divide_seq" name="fap_jobfair_divide_seq" value="' + response.data[i].fap_jobfair_divide_seq + '">';
					context += '<input type="hidden" id="fap_job_ad_seq" name="fap_job_ad_seq" value="' + response.data[i].fap_job_ad_seq + '">';
					context += '<input type="hidden" id="fap_jobfair_applicable_time_seq" name="fap_jobfair_applicable_time_seq" value="' + response.data[i].fap_jobfair_applicable_time_seq + '">';
					context += '<input type="hidden" id="fap_jobfair_apply_rule_seq" name="fap_jobfair_apply_rule_seq" value="' + response.data[i].fap_jobfair_apply_rule_seq + '">';
					context += '<td>'+ cnt + '</td>';
					context += '<td>'+ response.data[i].fap_comp_ja_nm +'</td>';
					context += '<td>'+ response.data[i].fap_job_ad_title + '<br>';
					context += '(<code value="'+ response.data[i].fap_job_ad_is_mismatching +'"></code>)</td>';
					context += '<td><code value="'+ response.data[i].fap_job_ad_state +'"></code></td>';
					context += '<td>'+ response.data[i].fap_job_ad_groupcode +'</td>';
					context += '<td>'+ response.data[i].fap_job_ad_recruit_num +'</td>';
					context += '<td>'+ response.data[i].fap_job_app_per_settled_num +'</td>';
					context += '<td>'+ response.data[i].now_apply_nums +'</td>';
					context += '<td><button type="button" ng-click="deleteFromAdditionalApplyInfoBtn($event)" data-id="additionCompListTr'+ response.data[i].fap_job_ad_seq +'" class="btn btn-default">삭제</button></td>';
					context += '</tr>';
					cnt += 1;
				}
				$('#additionCompListTbody').append($compile(context)($scope));
			}, function errorCallback(response) {
				console.log(response);
			});
			// [end] 추가지원 가능한 채용공고 리스트 출력 종료
			
		}
		// [end] 잡페어 세부 검색 클릭 후 채용공고 리스트, 추가지원 가능한 채용공고 리스트 출력 종료
		
		// [start] 추가지원 가능한 채용공고로 설정하기 시작
		$scope.insertIntoAdditionalApplyInfoBtn = function(e){
			var culAdApplyStatusInfoListTr = $(e.currentTarget).attr('data-id');
			var fap_job_ad_seq = $('#'+ culAdApplyStatusInfoListTr).children('#fap_job_ad_seq').val();
			var fap_jobfair_divide_seq = $('#'+ culAdApplyStatusInfoListTr).children('#fap_jobfair_divide_seq').val();
			var insertIntoAdditionalApplyInfoMap = {
					'fap_job_ad_seq' : fap_job_ad_seq
					,'fap_jobfair_divide_seq' : fap_jobfair_divide_seq
			}

			$http({
				url: 'insert_jobfair_divide_addition_comp_list',
				method: 'post',
				headers: {'Content-Type': 'application/json'},
				data: JSON.stringify(insertIntoAdditionalApplyInfoMap),
				responseType : 'text'
			}).then(function successCallback(response) {
				(response.data == 'insertSuccess') ? alert('등록되었습니다.') : alert('등록에 실패하였습니다. 관리자에게 문의해주세요.');
				$scope.readCompanyAdList();
			}, function errorCallback(response) {
				console.log(response);
			});
		}
		// [end] 추가지원 가능한 채용공고로 설정하기 종료
		
		// [start] 추가지원 가능한 채용공고에서 설정 삭제 시작
		$scope.deleteFromAdditionalApplyInfoBtn = function(e){
			var culAdditionCompListTr = $(e.currentTarget).attr('data-id');
			var fap_job_ad_seq = $('#' + culAdditionCompListTr).children('#fap_job_ad_seq').val();
			var fap_jobfair_divide_seq = $('#' + culAdditionCompListTr).children('#fap_jobfair_divide_seq').val();
			var fap_jobfair_apply_rule_seq = $('#' + culAdditionCompListTr).children('#fap_jobfair_apply_rule_seq').val(); // 확인 
		   alert("fap_jobfair_apply_rule_seq:"+fap_jobfair_apply_rule_seq); // 확인 
			var deleteFromAdditionalApplyInfoMap = {
					'fap_job_ad_seq' : fap_job_ad_seq
					,'fap_jobfair_divide_seq' : fap_jobfair_divide_seq
					, 'fap_jobfair_apply_rule_seq' : fap_jobfair_apply_rule_seq // 확인 
			}
			
			$http({
				url: 'delete_jobfair_divide_addition_comp_list',
				method: 'post',
				headers: {'Content-Type': 'application/json'},
				data: JSON.stringify(deleteFromAdditionalApplyInfoMap),
				responseType : 'text'
			}).then(function successCallback(response) {
				(response.data == 'deleteSuccess') ? alert('추가지원가능 기업목록에서 삭제 되었습니다.') : alert('추가지원가능 기업목록에서 삭제에 실패하셨습니다. 관리자에게 문의해주세요.');
				$scope.readCompanyAdList();
			}, function errorCallback(response) {
				console.log(response);
			});
		}
		// [end] 추가지원 가능한 채용공고에서 설정 삭제 종료
		
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
<body ng-app="myapp" ng-controller="additionalApplyCompanyConfiguredController">
	
	<input type="hidden" value="${fap_jobfair_seq}" name="fap_jobfair_seq" id="fap_jobfair_seq">
	
	<!-- Modal --------------->
	<div class="modal fade" id="myModal" role="dialog">
	
		<!-- Modal dialog------------------------->
		<div class="modal-dialog" id="modal-dialog" style="float: left; width: 95%; margin-left: 2%">
		
			<!-- 1 Modal content------------------------->
			<div class="modal-content" id="modal-content1" style="float: left; width: 50%;">
				<div class="modal-header">
					<h4 class="modal-title" id="title">
						잡페어 세부별 전체 회사목록
					</h4>
				</div>
				
				<!-- body 시작-->
				<div class="modal-body" id="modal-body1">
					<select id="choicedJobFairDivide" onchange="angular.element(this).scope().readCompanyAdList()"></select>
					<br><br>
					
					<table border= "1" id ="adApplyStatusInfoList" style="margin-left: 2%;">
						<thead id="adApplyStatusInfoListThead">
							<tr>
								<th>No.</th>
								<th>기업명(일문)</th>
								<th>채용공고 제목</th>
								<th>상태</th>
								<th>직군</th>
								<th>채용예정인원</th>
								<th>채용가능인원</th>
								<th>현재지원인원</th>
								<th>추가</th>
							</tr>
						</thead>
						<tbody id="adApplyStatusInfoListTbody">
							<!-- inner html 들어올 부분 -->
						</tbody>
					</table>	
        		</div>
				<!-- body 끝 -->
			</div>
			<!-- modal content div 종료 -->
			
			<!-- 2 Modal content------------------------->
			<div class="modal-content" id="modal-content2" style="float: left; width: 50%;">
				
				<div class="modal-header">
					<button type="button" id="closeModalBtn"  class="close" data-dismiss="modal">&times;</button>
					<h4 class="modal-title" id="title">
						잡페어 세부별 추가지원 설정한 회사목록
					</h4>
				</div>
				
				<!-- body 시작-->
				<div class="modal-body" id="modal-body2">
					<table border= "1" id ="additionCompList" style="margin-left: 2%;">
						<thead id="additionCompListThead">
							<tr>
								<th>No.</th>
								<th>기업명(일문)</th>
								<th>채용공고 제목</th>
								<th>상태</th>
								<th>직군</th>
								<th>채용예정인원</th>
								<th>채용가능인원</th>
								<th>현재지원인원</th>
								<th>추가</th>
							</tr>
						</thead>
						<tbody id="additionCompListTbody">
							<!-- inner html 들어올 부분 -->
						</tbody>
					</table>	
        		</div>
				<!-- body 끝 -->

				<div class="modal-footer">
					<button type="button" id="closeModalBtnClose" class="btn btn-default" data-dismiss="modal">Close</button>
				</div>
			
			</div>
			<!-- modal content div 종료 -->
			
		</div>
		<!-- modal-dialog div 종료 -->
		
	</div>  
	<!-- modal fade div 종료 -->
	
</body>
</html>
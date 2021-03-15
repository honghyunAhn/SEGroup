<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>​
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
	<script src="<c:url value="/resources/segroup/society/fap/js/tooltip.js" />"></script>	
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>

<script type="text/javascript">
$(function() {
	$("input").attr("readonly",true);
	$("input[type=radio]").attr('disabled', true);	
	
	$(".resume-check").off("click").on("click",function(){
		$(this).toggleClass("ck");
	})
	
	$(".resume_print").off("click").on("click",function(){
		
		var check_flag = false;
		var context = '';
		
		$.each($(".resume-check"),function(index,item){
			if($(this).hasClass("ck")){
				check_flag = true;
				var fap_resume_seq = $(this).closest(".wid1").nextAll(".wid4").find(".resumeButton").val();
				context += '<input type="hidden" name="fap_resume_seq" value="'+fap_resume_seq+'">';
			}
		})
		
		if(!check_flag){
			alert('<spring:message code="fap.comp.app_print_comment" />');
		}else{
			$("#resume_popup").html(context);
			
			var popupX = (window.screen.width / 2) - ( 1200 / 2 );
	        var popupY = (window.screen.height / 2) - ( 700 / 2 ) - 50;
			
			var resume_popup = document.resume_popup;
			window.open('','resume_print',"width=1200,height=700,left='+popupX+',top='+popupY+',screenX='+popupX+',screenY='+popupY+',toolbar=no,location=no,directories=no,status=no,menubar=no,resizable=yes,scrollbars=no,copyhistory=no,scrollbars=yes");
			resume_popup.target = 'resume_print';
			resume_popup.submit();
		}
		
	})
});
	var myApp = angular.module('myapp', []);
	
	myApp.controller('CompanyController',['$scope','$compile', '$http','$timeout', function($scope, $compile, $http,$timeout) {
		
		$scope.onChange = function(option){
			//진행중 선택
	    	if($(option).children("option:selected").val() == 'D0000'){
	    		$(option).val("D0000");
	    		$(option).children("option[value='D0000']").attr("selected", true);
	    		$(option).children("option[value='D0001']").attr("selected", false);
	    		$(option).children("option[value='D0002']").attr("selected", false);
	    		$(option).children("option[value='D0004']").attr("selected", false);
	    	}
	    	
	    	//합격 선택
	    	if($(option).children("option:selected").val() == 'D0001'){
	    		//이전 전형 진행중인 경우
	    		var count = 0;
	    		for(var i = 0; i < $(option).parent().prevAll(".wid6").length; i++){
					if($(option).parent().prevAll('.wid6:eq('+i+')').children(".app_result_select").val() == "D0000"){
				   		count += 1;
			   	 	}
				}
	    		if(count > 0){
					alert('<spring:message code="fap.comp.applicant_status_info" />');
					$(option).val("D0000");
		    		$(option).children("option[value='D0000']").attr("selected", true);
		    		$(option).children("option[value='D0001']").attr("selected", false);
		    		$(option).children("option[value='D0002']").attr("selected", false);
		    		$(option).children("option[value='D0004']").attr("selected", false);
		    		return false;
				}
	    		
	    		$(option).val("D0001");
	    		$(option).children("option[value='D0000']").attr("selected", false);
	    		$(option).children("option[value='D0001']").attr("selected", true);
	    		$(option).children("option[value='D0002']").attr("selected", false);
	    		$(option).children("option[value='D0004']").attr("selected", false);
	    	}
	    	
	    	 //예비합격 선택
	    	if($(option).children("option:selected").val() == 'D0004'){
	    		//이전 전형 진행중인 경우
	    		var count = 0;
	    		for(var i = 0; i < $(option).parent().prevAll(".wid6").length; i++){
					if($(option).parent().prevAll('.wid6:eq('+i+')').children(".app_result_select").val() == "D0000"){
				   		count += 1;
			   	 	}
				}
	    		if(count > 0){
					alert('<spring:message code="fap.comp.applicant_status_info" />');
					$(option).val("D0000");
		    		$(option).children("option[value='D0000']").attr("selected", true);
		    		$(option).children("option[value='D0001']").attr("selected", false);
		    		$(option).children("option[value='D0002']").attr("selected", false);
		    		$(option).children("option[value='D0004']").attr("selected", false);
		    		
		    		context = '';
		    		$(option).nextAll(".waiting_list_ranking_div").html(context);
		    		
		    		return false;
				}
	    		
	    		//예비합격 순위 생성
	    		var index = $(option).prevAll("input[type=hidden]").attr('index');
	    		
	    		context = '<div class="waiting_list_ranking_div">';
	    		context += '<select name="fap_job_apply_info_list['+index+'].fap_job_app_standby_rank" class="standby_rank">';
	    		context += '<option disabled="disabled"><spring:message code="fap.comp.app_final_stand_by_ranking" /></option>';
	    		for(var i=1; i<11; i++){
	    			if(i==1){
	    				context += '<option value="number:'+i+'" selected="selected">'+i+'</option>';
	    			}else{
	    				context += '<option value="number:'+i+'">'+i+'</option>';
	    			}
	    		}
				context += '</select>';
				context += '</div>';
				
				$(option).after(context);
								
				$(option).val("D0004");
	    		$(option).children("option[value='D0000']").attr("selected", false);
	    		$(option).children("option[value='D0001']").attr("selected", false);
	    		$(option).children("option[value='D0002']").attr("selected", false);
	    		$(option).children("option[value='D0004']").attr("selected", true);
				
	    		//예비합격 순위 선택
			    $(".standby_rank").change(function(){
			    	for(var i=1; i<11; i++){
			    		if($(this).children("option:selected").val() == 'number:'+i){
			    			$(this).children('option[value="number:'+i+'"]').attr("selected", true);
			    		}else{
			    			$(this).children('option[value="number:'+i+'"]').attr("selected", false);
			    		}
			    	}
			    });
	    	}else{
	    		context = '';
	    		$(option).nextAll(".waiting_list_ranking_div").html(context);
	    	}
	    	
	    	//불합격 선택
	    	if($(option).children("option:selected").val() == 'D0002'){
	    		//이전 전형 진행중인 경우
	    		var count = 0;
	    		for(var i = 0; i < $(option).parent().prevAll(".wid6").length; i++){
					if($(option).parent().prevAll('.wid6:eq('+i+')').children(".app_result_select").val() == "D0000"){
				   		count += 1;
			   	 	}
				}
	    		if(count > 0){
					alert('<spring:message code="fap.comp.applicant_status_info" />');
					$(option).val("D0000");
		    		$(option).children("option[value='D0000']").attr("selected", true);
		    		$(option).children("option[value='D0001']").attr("selected", false);
		    		$(option).children("option[value='D0002']").attr("selected", false);
		    		$(option).children("option[value='D0004']").attr("selected", false);
		    		return false;
				}
	    		
	    		$(option).val("D0002");
	    		$(option).children("option[value='D0000']").attr("selected", false);
	    		$(option).children("option[value='D0001']").attr("selected", false);
	    		$(option).children("option[value='D0002']").attr("selected", true);
	    		$(option).children("option[value='D0004']").attr("selected", false);
	    	}
		}
		
		var fap_job_ad_seq = '${fap_job_ad_seq}';
		var fap_comp_id = '${fap_comp_id}';
		//정규지원 진행중, 합격자, 예비합격 지원자 정보
		var resultMap = '${resultMap}';
		resultMap = resultMap.replace(/(?:\r\n|\r|\n)/g, '\\r\\n');
	    var applicantInfo = JSON.parse(resultMap);
	    $scope.applicantInfo = JSON.parse(resultMap);
		//미스매칭 진행중, 합격자, 예비합격 지원자 정보
		var missResultMap = '${missResultMap}';
		missResultMap = missResultMap.replace(/(?:\r\n|\r|\n)/g, '\\r\\n');
	    var missApplicantInfo = JSON.parse(missResultMap);
	    $scope.missApplicantInfo = JSON.parse(missResultMap);
	 	//불합격 지원자 정보
		var unacceptedResultMap = '${unacceptedResultMap}';
		unacceptedResultMap = unacceptedResultMap.replace(/(?:\r\n|\r|\n)/g, '\\r\\n');
	    var unacceptedApplicantInfo = JSON.parse(unacceptedResultMap);
	    $scope.unacceptedApplicantInfo = JSON.parse(unacceptedResultMap);
	    //채용전형 정보
	    var recruit_pcs = '${recruit_pcs}';
	    recruit_pcs = recruit_pcs.replace(/(?:\r\n|\r|\n)/g, '\\r\\n');
	    var recruitPcs = JSON.parse(recruit_pcs);
	    $scope.recruitPcs = JSON.parse(recruit_pcs);
	    
	    //합격사유 작성
	   $scope.insertPassComment = function(index ,e , fap_job_app_final_rt_seq){
	    	if($(e.currentTarget).parent().prevAll('.wid7').children('select').val() == 'D0000'){
	    		alert('<spring:message code="fap.comp.app_final_rt_comment_ck" />');
	    		return;
	    	}
			var infoSeq = fap_job_app_final_rt_seq;
			
			$scope.pass_comment_insert_draw(index, infoSeq);
			$("#insertPassCommentModal").modal();
	   }
	    
	   //정규지원 합격사유 수정
	   $scope.updatePassComment = function(index ,e ,fap_job_app_final_rt_seq){
		   if($(e.currentTarget).parent().prevAll('.wid7').children('select').val() == 'D0000'){
	    		alert('<spring:message code="fap.comp.app_final_rt_comment_ck" />');
	    		return;
	    	}
		   var infoSeq = fap_job_app_final_rt_seq;
		   if($scope.applicantInfo[index].finalResultMap[0].fap_job_app_final_rt_seq == infoSeq){
			   var comment = applicantInfo[index].finalResultMap[0].fap_job_app_pass_comment;
		   }				
			$scope.pass_comment_update_draw(index, infoSeq, comment);
			$("#updatePassCommentModal").modal();
	   }
	   
	   //미스매칭 합격사유 수정
	   $scope.missUpdatePassComment = function(index ,e ,fap_job_app_final_rt_seq){
		   if($(e.currentTarget).parent().prevAll('.wid7').children('select').val() == 'D0000'){
	    		alert('<spring:message code="fap.comp.app_final_rt_comment_ck" />');
	    		return;
	    	}
		   var infoSeq = fap_job_app_final_rt_seq;
		   if($scope.missApplicantInfo[index].missFinalResultMap[0].fap_job_app_final_rt_seq == infoSeq){
			   var comment = missApplicantInfo[index].missFinalResultMap[0].fap_job_app_pass_comment;
		   }				
			$scope.pass_comment_update_draw(index, infoSeq, comment);
			$("#updatePassCommentModal").modal();
	   }
	    
	   //합격사유 등록 MODAL
		$scope.pass_comment_insert_draw = function(index, infoSeq){
			var context = '';
			context += '<div class="modal fade" id="insertPassCommentModal" tabindex="-1" role="dialog" aria-labelledby="modal" aria-hidden="true">';
			context += '<div class="modal-dialog">';
			context += '<div class="modal-content">';					
			context += '	<div class="modal-header">';
			context += '<h3 class="modal-title" id="modal"><spring:message code="fap.comp.app_final_rt_pass_reason_write" /></h3>';
			context += '<button type="button" class="close" data-dismiss="modal" aria-label="Close">';
			context += '<span aria-hidden="true">&times;</span>';
			context += '</button>';
			context += '</div>';
			context += '<form action="/fap/agency/insert_pass_comment" method="post">';
			context += '<input type="hidden" name="fap_jobfair_divide_seq" value="${fap_jobfair_divide_seq}">';
			context += '<input type="hidden" name="fap_job_ad_seq" value="${fap_job_ad_seq}">';
			context += '<input type="hidden" name="fap_comp_id" value="${fap_comp_id}">';
			context += '<input type="hidden" name="fap_job_app_final_rt_seq" value="'+infoSeq+'">';
			context += '<div class="modal-body">';
			context += '<div class="form-group">';
			context += '<div class="form-row">';
			context += '<label>Comment</label>';
			context += '</div>';
			context += '<div class="form-row">';
			context += '<textarea name="fap_job_app_pass_comment" class="form-control" maxlength="500" style="text-align: left; width:670px; height: 100px;" ></textarea>';
			context += '</div>';
			context += '</div>';
			context += '</div>';								
			context += '<div class="modal-footer">';
			context += '<button type="button" class="btn btn-primary" data-dismiss="modal"><spring:message code="fap.comp.modal_cancel" /></button>';
			context += '<button type="submit" class="btn btn-primary"><spring:message code="fap.comp.modal_insert" /></button>';
			context += '</div>';							
			context += '</form>';
			context += '</div>';
			context += '</div>';
			context += '</div>';
			
			$('.pass_comment_div').html($compile(context)($scope)); 	
		}
	   
		//합격사유 수정 MODAL
		$scope.pass_comment_update_draw = function(index, infoSeq, comment){
			var context = '';
			context += '<div class="modal fade" id="updatePassCommentModal" tabindex="-1" role="dialog" aria-labelledby="modal" aria-hidden="true">';
			context += '<div class="modal-dialog">';
			context += '<div class="modal-content">';					
			context += '	<div class="modal-header">';
			context += '<h3 class="modal-title" id="modal"><spring:message code="fap.comp.app_final_rt_pass_reason_update" /></h3>';
			context += '<button type="button" class="close" data-dismiss="modal" aria-label="Close">';
			context += '<span aria-hidden="true">&times;</span>';
			context += '</button>';
			context += '</div>';
			context += '<form action="/fap/agency/insert_pass_comment" method="post">';
			context += '<input type="hidden" name="fap_jobfair_divide_seq" value="${fap_jobfair_divide_seq}">';
			context += '<input type="hidden" name="fap_job_ad_seq" value="${fap_job_ad_seq}">';
			context += '<input type="hidden" name="fap_comp_id" value="${fap_comp_id}">';
			context += '<input type="hidden" name="fap_job_app_final_rt_seq" value="'+infoSeq+'">';
			context += '<div class="modal-body">';
			context += '<div class="form-group">';
			context += '<div class="form-row">';
			context += '<label>Comment</label>';
			context += '</div>';
			context += '<div class="form-row">';
			context += '<textarea name="fap_job_app_pass_comment" class="form-control" maxlength="500" style="text-align: left; width:670px; height: 100px;" >'+comment+'</textarea>';
			context += '</div>';
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
			
			$('.pass_comment_div').html($compile(context)($scope)); 	
		}
	   
		//이력서 출력 
		$scope.resumeModal = function(e) {
			var user_id = $(e.currentTarget).attr('id');
			var fap_resume_seq = $(e.currentTarget).val();
			$('#myModal').modal('show');
			
			$http({
				url: 'applied_resume_list',
				method: 'post',
				params: {
							fap_resume_seq : fap_resume_seq
							,user_id : user_id
				},
				headers : {
					"AJAX" : true
				},
				dataType: 'json'
			}).then(function successCallback(response) {
				
				var wholeResumeJson = JSON.stringify(response.data);
				var replaceJson = wholeResumeJson.replace(/(?:\r\n|\r|\n)/g, '<br />');
				$scope.resumeApply = JSON.parse(replaceJson);
				
				$timeout(function() {
					
					$.each($(".span-code"), function(index, item){
						var cd = $(this).attr("cd");
						var context = '<code value="'+cd+'"></code>';
						$(this).html(context);
					})

					$compile(".span-code")($scope);
				
				}, 0);
				
			}, function errorCallback(response) {
				console.log(response);
				if(e.status == 403){
					alert('<spring:message code="com.login.ajaxSesstion" javaScriptEscape="true" />');
					location.href = "/fap/agency/agency_login";
				}
			});
		}
		
		$timeout(function() {
			
			$.each($(".user-code"), function(index, item){
				var cd = $(this).attr("cd");
				var context = '<code value="'+cd+'"></code>';
				$(this).html(context);
			})

			$compile(".user-code")($scope);
		
		}, 0);
		
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
	
</script>
<script type="text/javascript">
	$(document).ready( function() {
		//예비합격 순위 value 변경
		$(".standby_rank").change(function(){
			for(var i=1; i<$(this).children("option").length; i++){
				if('number:'+i == $(this).children("option:selected").attr('value')){
					$(this).children('option[value="number:'+i+'"]').attr("selected", true);
				}else{
					$(this).children('option[value="number:'+i+'"]').attr("selected", false);
				}
			}
		});
		
		//현지인원 제한 체크 함수
		function itvLimitFnc(btnId){
			var ck_count = 0;
	    	
	    	$(".peoplemain, .peoplemain1").each(function(index,item){
	    		if($(item).find(".wid6").last().find(".app_result_select").val() == 'D0001'){
	    			ck_count++;
	    		}
	    	});
	    	
	    	if(ck_count > 0){
	    		var job_ad_seq = '${fap_job_ad_seq}';
	    		
	    		$.ajax({
	    			url : '/fap/agency/interview_limit_check',
	    			type : 'post',
	    			data : {
	    							'fap_job_ad_seq' : job_ad_seq,
	    							'ck_count' : ck_count
	    					},
	    			dataType : 'json',
	    			async: false,
	    			success : function(res){
	    				if(res){
	    					alert('<spring:message code="fap.comp.app_final_rt_limit" />');
	    				}else{
	    					if(confirm('<spring:message code="fap.comp.app_final_rt_submit1" />\n<spring:message code="fap.comp.app_final_rt_submit2" />\n<spring:message code="fap.comp.app_final_rt_submit3" />')){
	    						$('select').attr('disabled', false);
	    						$("#"+btnId).submit();
	    					}
	    				}
	    			}
	    		});
	    	}
		}
		
		//정규결과 저장버튼
		$("#saveBtn").click(function(){
			//전형별 결과 체크 카운트
			var app_count = 0;
			//최종결과 체크 카운트
			var final_count = 0;
			//불합격 이후 전형 체크 카운트
			var unaccepted_count = 0;
			//합격처리 대상 지원자수
	    	var app_index =  $(".peoplemain").length;
	    	//전형의 수
	    	var pcs_total_index = $(".fap_job_recruit_pcs_gb option").length;
	    	
			for(var i=0; i<app_index; i++){
				//최종결과 합불처리 저장위해 이전의 진행중인 전형 체크
				if($(this).closest('.peoplefind').nextAll('.peoplemain:eq('+i+')').children('.wid7').children('.final_result_select').children("option:selected").attr('value') == 'D0001'
					|| $(this).closest('.peoplefind').nextAll('.peoplemain:eq('+i+')').children('.wid7').children('.final_result_select').children("option:selected").attr('value') == 'D0002'
					|| $(this).closest('.peoplefind').nextAll('.peoplemain:eq('+i+')').children('.wid7').children('.final_result_select').children("option:selected").attr('value') == 'D0004'){		
					for(var j=0; j<pcs_total_index; j++){
						if($(this).closest('.peoplefind').nextAll('.peoplemain:eq('+i+')').children('.wid6:eq('+j+')').children('.app_result_select').children("option:selected").attr('value') == 'D0000'){
							final_count++;
						}
					}				
				}
				//전형별 합불처리 저장위해 이전의 진행중인 전형 체크
				for(var k=1; 0<pcs_total_index-k; k++ ){
					if($(this).closest('.peoplefind').nextAll('.peoplemain:eq('+i+')').children('.wid6:eq('+(pcs_total_index-k)+')').children('.app_result_select').children("option:selected").attr('value') != 'D0000'){
						if($(this).closest('.peoplefind').nextAll('.peoplemain:eq('+i+')').children('.wid6:eq('+(pcs_total_index-k-1)+')').children('.app_result_select').children("option:selected").attr('value') == 'D0000'){
							app_count++;
						}
					}
				}
				//불합격 전형 이후 진행중, 합격 전형있는지 체크
				for(var m=1; m<pcs_total_index; m++){
					if($(this).closest('.peoplefind').nextAll('.peoplemain:eq('+i+')').children('.wid6:eq('+(m-1)+')').children('.app_result_select').children("option:selected").attr('value') == 'D0002'){
						for(var n=m; n<pcs_total_index; n++){
							if($(this).closest('.peoplefind').nextAll('.peoplemain:eq('+i+')').children('.wid6:eq('+n+')').children('.app_result_select').children("option:selected").attr('value') == 'D0000'){
								unaccepted_count++;
							}
						}
						for(var n=m; n<pcs_total_index; n++){
							if($(this).closest('.peoplefind').nextAll('.peoplemain:eq('+i+')').children('.wid6:eq('+n+')').children('.app_result_select').children("option:selected").attr('value') == 'D0001'){
								unaccepted_count++;
							}
						}
					}
				}				
			}
			
			//같은 예비합격번호 체크
			var rank_arr = [];
			$.each($(".standby_rank"), function(index, item){
				rank_arr.push($(this).val());
			});
			
			for ( var i = 0; i < rank_arr.length; i++ ){
				for ( var j = rank_arr.length-1 ; j > i; j--){
					if(rank_arr[i] == rank_arr[j]){
						alert('<spring:message code="fap.comp.app_final_stand_by_same_ranking" />');
						return false;
					}
				}
			}
			
	    	if(final_count > 0 || app_count > 0){
	    		alert('<spring:message code="fap.comp.applicant_status_info" />');
	    		return false;
	    	}
	    	if(unaccepted_count > 0){
	    		alert('<spring:message code="fap.comp.unaccepted_app_rt_ck" />');
	    		return false;
	    	}
	    	
	    	itvLimitFnc("regular_apply_btn");
	    	
		});
		
		//미스매칭 결과 저장버튼
		$("#missSaveBtn").click(function(){
			//전형별 결과 체크 카운트
			var app_count = 0;
			//최종결과 체크 카운트
			var final_count = 0;
			//불합격 이후 전형 체크 카운트
			var unaccepted_count = 0;
			//합격처리 대상 지원자수
	    	var app_index =  $(".peoplemain1").length;
	    	//전형의 수
	    	var pcs_total_index = $(".miss_fap_job_recruit_pcs_gb option").length;
	    	
			for(var i=0; i<app_index; i++){
				//최종결과 합불처리 저장위해 이전의 진행중인 전형 체크
				if($(this).closest('.peoplefind').nextAll('.peoplemain1:eq('+i+')').children('.wid7').children('.final_result_select').children("option:selected").attr('value') == 'D0001'
					|| $(this).closest('.peoplefind').nextAll('.peoplemain1:eq('+i+')').children('.wid7').children('.final_result_select').children("option:selected").attr('value') == 'D0002'
					|| $(this).closest('.peoplefind').nextAll('.peoplemain1:eq('+i+')').children('.wid7').children('.final_result_select').children("option:selected").attr('value') == 'D0004'){		
					for(var j=0; j<pcs_total_index; j++){
						if($(this).closest('.peoplefind').nextAll('.peoplemain1:eq('+i+')').children('.wid6:eq('+j+')').children('.app_result_select').children("option:selected").attr('value') == 'D0000'){
							final_count++;
						}
					}
				}
				//전형별 합불처리 저장위해 이전의 진행중인 전형 체크
				for(var k=1; 0<pcs_total_index-k; k++ ){
					if($(this).closest('.peoplefind').nextAll('.peoplemain1:eq('+i+')').children('.wid6:eq('+(pcs_total_index-k)+')').children('.app_result_select').children("option:selected").attr('value') != 'D0000'){
						if($(this).closest('.peoplefind').nextAll('.peoplemain1:eq('+i+')').children('.wid6:eq('+(pcs_total_index-k-1)+')').children('.app_result_select').children("option:selected").attr('value') == 'D0000'){
							app_count++;
						}
					}
				}
				//불합격 전형 이후 진행중, 합격 전형있는지 체크
				for(var m=1; m<pcs_total_index; m++){
					if($(this).closest('.peoplefind').nextAll('.peoplemain1:eq('+i+')').children('.wid6:eq('+(m-1)+')').children('.app_result_select').children("option:selected").attr('value') == 'D0002'){
						for(var n=m; n<pcs_total_index; n++){
							if($(this).closest('.peoplefind').nextAll('.peoplemain1:eq('+i+')').children('.wid6:eq('+n+')').children('.app_result_select').children("option:selected").attr('value') == 'D0000'){
								unaccepted_count++;
							}
						}
						for(var n=m; n<pcs_total_index; n++){
							if($(this).closest('.peoplefind').nextAll('.peoplemain1:eq('+i+')').children('.wid6:eq('+n+')').children('.app_result_select').children("option:selected").attr('value') == 'D0001'){
								unaccepted_count++;
							}
						}
					}
				}
			}
			
			//같은 예비합격번호 체크
			var rank_arr = [];
			$.each($(".standby_rank"), function(index, item){
				rank_arr.push($(this).val());
			});
			
			for ( var i = 0; i < rank_arr.length; i++ ){
				for ( var j = rank_arr.length-1 ; j > i; j--){
					if(rank_arr[i] == rank_arr[j]){
						alert('<spring:message code="fap.comp.app_final_stand_by_same_ranking" />');
						return false;
					}
				}
			}
			
			if(final_count > 0 || app_count > 0){
	    		alert('<spring:message code="fap.comp.applicant_status_info" />');
	    		return false;
	    	}
			if(unaccepted_count > 0){
	    		alert('<spring:message code="fap.comp.unaccepted_app_rt_ck" />');
	    		return false;
	    	}
	    	
			itvLimitFnc("missmatching_apply_btn");
			
		});
	    
	    //정규지원 일괄합격
	    $("#everybody_pass").click(function(){
	    	var count = 0;
	    	//합격처리 대상 지원자수
	    	var app_index =  $(".peoplemain").length;	    	
	    	//전형 선택 옵션 인덱스
	    	var pcs_index = $(".fap_job_recruit_pcs_gb option").index($(".fap_job_recruit_pcs_gb option:selected"));	
	    	//전형의 수
	    	var pcs_total_index = $(".fap_job_recruit_pcs_gb option").length;
	    	
			//일괄 합격 설정
			for(var i=1; i<=app_index; i++){
				for(var j=0; j<(pcs_total_index-pcs_index); j++){
					//일괄 합격 처리
					if(j==0){
						$('[name="fap_job_apply_info_list['+(app_index-i)+'].jobApplyResult.fap_job_app_rt_list['+(pcs_index+j)+'].fap_job_app_rt_acp"]').val("D0001");
						$('[name="fap_job_apply_info_list['+(app_index-i)+'].jobApplyResult.fap_job_app_rt_list['+(pcs_index+j)+'].fap_job_app_rt_acp"]').attr("disabled", false);
						$('[name="fap_job_apply_info_list['+(app_index-i)+'].jobApplyResult.fap_job_app_rt_list['+(pcs_index+j)+'].fap_job_app_rt_acp"]').children("option[value='D0000']").attr("selected", false);
						$('[name="fap_job_apply_info_list['+(app_index-i)+'].jobApplyResult.fap_job_app_rt_list['+(pcs_index+j)+'].fap_job_app_rt_acp"]').children("option[value='D0001']").attr("selected", true);
						$('[name="fap_job_apply_info_list['+(app_index-i)+'].jobApplyResult.fap_job_app_rt_list['+(pcs_index+j)+'].fap_job_app_rt_acp"]').children("option[value='D0002']").attr("selected", false);
						$('[name="fap_job_apply_info_list['+(app_index-i)+'].jobApplyResult.fap_job_app_rt_list['+(pcs_index+j)+'].fap_job_app_rt_acp"]').children("option[value='D0003']").attr("selected", false);
					}else{		//이후 전형 일괄 진행중 처리
						$('[name="fap_job_apply_info_list['+(app_index-i)+'].jobApplyResult.fap_job_app_rt_list['+(pcs_index+j)+'].fap_job_app_rt_acp"]').val("D0000");
						$('[name="fap_job_apply_info_list['+(app_index-i)+'].jobApplyResult.fap_job_app_rt_list['+(pcs_index+j)+'].fap_job_app_rt_acp"]').attr("disabled", false);
						$('[name="fap_job_apply_info_list['+(app_index-i)+'].jobApplyResult.fap_job_app_rt_list['+(pcs_index+j)+'].fap_job_app_rt_acp"]').children("option[value='D0000']").attr("selected", true);
						$('[name="fap_job_apply_info_list['+(app_index-i)+'].jobApplyResult.fap_job_app_rt_list['+(pcs_index+j)+'].fap_job_app_rt_acp"]').children("option[value='D0001']").attr("selected", false);
						$('[name="fap_job_apply_info_list['+(app_index-i)+'].jobApplyResult.fap_job_app_rt_list['+(pcs_index+j)+'].fap_job_app_rt_acp"]').children("option[value='D0002']").attr("selected", false);
						$('[name="fap_job_apply_info_list['+(app_index-i)+'].jobApplyResult.fap_job_app_rt_list['+(pcs_index+j)+'].fap_job_app_rt_acp"]').children("option[value='D0003']").attr("selected", false);
					}
					//최종결과 진행중 처리
					$('[name="fap_job_apply_info_list['+(app_index-i)+'].fap_job_app_final_rt_acp"]').val("D0000");
					$('[name="fap_job_apply_info_list['+(app_index-i)+'].fap_job_app_final_rt_acp"]').attr("disabled", false);
					$('[name="fap_job_apply_info_list['+(app_index-i)+'].fap_job_app_final_rt_acp"]').children("option[value='D0000']").attr("selected", true);
					$('[name="fap_job_apply_info_list['+(app_index-i)+'].fap_job_app_final_rt_acp"]').children("option[value='D0001']").attr("selected", false);
					$('[name="fap_job_apply_info_list['+(app_index-i)+'].fap_job_app_final_rt_acp"]').children("option[value='D0002']").attr("selected", false);
					$('[name="fap_job_apply_info_list['+(app_index-i)+'].fap_job_app_final_rt_acp"]').children("option[value='D0004']").attr("selected", false);
					//예비합격 순위 div 초기화
		    		context = '';
		    		$('[name="fap_job_apply_info_list['+(app_index-i)+'].fap_job_app_final_rt_acp"]').next(".waiting_list_ranking_div").html(context);
				}
				
				//이전 전형 진행중인 경우
				for(var k = 0; k < $('[name="fap_job_apply_info_list['+(app_index-i)+'].jobApplyResult.fap_job_app_rt_list['+pcs_index+'].fap_job_app_rt_acp"]').parent().prevAll(".wid6").length; k++){
					if($('[name="fap_job_apply_info_list['+(app_index-i)+'].jobApplyResult.fap_job_app_rt_list['+pcs_index+'].fap_job_app_rt_acp"]').parent().prevAll('.wid6:eq('+k+')').children(".app_result_select").val() == "D0000"){
				   		count += 1;
			   	 	}
				}
			}
			
			if(count > 0){
				alert('<spring:message code="fap.comp.applicant_status_info" />');
			}
			
    	});
	    
	    //정규지원 일괄 불합격
	    $("#nobody_pass").click(function(){
	    	var count = 0;	    	
	    	//불합격처리 대상 지원자수
	    	var app_index =  $(".peoplemain").length;
	    	//전형 선택 옵션 인덱스
	    	var pcs_index = $(".fap_job_recruit_pcs_gb option").index($(".fap_job_recruit_pcs_gb option:selected"));
	    	//전형의 수
	    	var pcs_total_index = $(".fap_job_recruit_pcs_gb option").length;
	    	
			//일괄 불합격 설정
			for(var i=1; i<=app_index; i++){
				for(var j=0; j<(pcs_total_index-pcs_index); j++){
					//일괄 불합격 처리
					if(j==0){
						$('[name="fap_job_apply_info_list['+(app_index-i)+'].jobApplyResult.fap_job_app_rt_list['+(pcs_index+j)+'].fap_job_app_rt_acp"]').val("D0002");
						$('[name="fap_job_apply_info_list['+(app_index-i)+'].jobApplyResult.fap_job_app_rt_list['+(pcs_index+j)+'].fap_job_app_rt_acp"]').children("option[value='D0000']").attr("selected", false);
						$('[name="fap_job_apply_info_list['+(app_index-i)+'].jobApplyResult.fap_job_app_rt_list['+(pcs_index+j)+'].fap_job_app_rt_acp"]').children("option[value='D0001']").attr("selected", false);
						$('[name="fap_job_apply_info_list['+(app_index-i)+'].jobApplyResult.fap_job_app_rt_list['+(pcs_index+j)+'].fap_job_app_rt_acp"]').children("option[value='D0002']").attr("selected", true);
						$('[name="fap_job_apply_info_list['+(app_index-i)+'].jobApplyResult.fap_job_app_rt_list['+(pcs_index+j)+'].fap_job_app_rt_acp"]').children("option[value='D0003']").attr("selected", false);
					}else{		//이후 전형 - 처리
						$('[name="fap_job_apply_info_list['+(app_index-i)+'].jobApplyResult.fap_job_app_rt_list['+(pcs_index+j)+'].fap_job_app_rt_acp"]').val("D0003");
						$('[name="fap_job_apply_info_list['+(app_index-i)+'].jobApplyResult.fap_job_app_rt_list['+(pcs_index+j)+'].fap_job_app_rt_acp"]').attr("disabled", "disabled");
						$('[name="fap_job_apply_info_list['+(app_index-i)+'].jobApplyResult.fap_job_app_rt_list['+(pcs_index+j)+'].fap_job_app_rt_acp"]').children("option[value='D0000']").attr("selected", false);
						$('[name="fap_job_apply_info_list['+(app_index-i)+'].jobApplyResult.fap_job_app_rt_list['+(pcs_index+j)+'].fap_job_app_rt_acp"]').children("option[value='D0001']").attr("selected", false);
						$('[name="fap_job_apply_info_list['+(app_index-i)+'].jobApplyResult.fap_job_app_rt_list['+(pcs_index+j)+'].fap_job_app_rt_acp"]').children("option[value='D0002']").attr("selected", false);
						$('[name="fap_job_apply_info_list['+(app_index-i)+'].jobApplyResult.fap_job_app_rt_list['+(pcs_index+j)+'].fap_job_app_rt_acp"]').children("option[value='D0003']").attr("selected", true);
					}
					//최종결과 불합격 처리
					$('[name="fap_job_apply_info_list['+(app_index-i)+'].fap_job_app_final_rt_acp"]').val("D0002");
					$('[name="fap_job_apply_info_list['+(app_index-i)+'].fap_job_app_final_rt_acp"]').attr("disabled", "disabled");
					$('[name="fap_job_apply_info_list['+(app_index-i)+'].fap_job_app_final_rt_acp"]').children("option[value='D0000']").attr("selected", false);
					$('[name="fap_job_apply_info_list['+(app_index-i)+'].fap_job_app_final_rt_acp"]').children("option[value='D0001']").attr("selected", false);
					$('[name="fap_job_apply_info_list['+(app_index-i)+'].fap_job_app_final_rt_acp"]').children("option[value='D0002']").attr("selected", true);
					$('[name="fap_job_apply_info_list['+(app_index-i)+'].fap_job_app_final_rt_acp"]').children("option[value='D0004']").attr("selected", false);
					//예비합격 순위 div 초기화
		    		context = '';
		    		$('[name="fap_job_apply_info_list['+(app_index-i)+'].fap_job_app_final_rt_acp"]').next(".waiting_list_ranking_div").html(context);
				}
				
				//이전 전형 진행중인 경우
				for(var k = 0; k < $('[name="fap_job_apply_info_list['+(app_index-i)+'].jobApplyResult.fap_job_app_rt_list['+pcs_index+'].fap_job_app_rt_acp"]').parent().prevAll(".wid6").length; k++){
					if($('[name="fap_job_apply_info_list['+(app_index-i)+'].jobApplyResult.fap_job_app_rt_list['+pcs_index+'].fap_job_app_rt_acp"]').parent().prevAll('.wid6:eq('+k+')').children(".app_result_select").val() == "D0000"){
				   		count += 1;
			   	 	}
				}
			}
			
			if(count > 0){
				alert('<spring:message code="fap.comp.applicant_status_info" />');
			}
    	});
	    
	    //미스매칭 일괄합격
	    $("#miss_everybody_pass").click(function(){
	    	var count = 0;
	    	//합격처리 대상 지원자수
	    	var app_index =  $(".peoplemain1").length;	    	
	    	//전형 선택 옵션 인덱스
	    	var pcs_index = $(".miss_fap_job_recruit_pcs_gb option").index($(".miss_fap_job_recruit_pcs_gb option:selected"));	
	    	//전형의 수
	    	var pcs_total_index = $(".miss_fap_job_recruit_pcs_gb option").length;
	    	
			//일괄 합격 설정
			for(var i=1; i<=app_index; i++){
				for(var j=0; j<(pcs_total_index-pcs_index); j++){
					//일괄 합격 처리
					if(j==0){
						$('[name="fap_job_apply_info_list['+(app_index-i)+'].jobApplyResult.fap_job_app_rt_list['+(pcs_index+j)+'].fap_job_app_rt_acp_miss"]').val("D0001");
						$('[name="fap_job_apply_info_list['+(app_index-i)+'].jobApplyResult.fap_job_app_rt_list['+(pcs_index+j)+'].fap_job_app_rt_acp_miss"]').attr("disabled", false);
						$('[name="fap_job_apply_info_list['+(app_index-i)+'].jobApplyResult.fap_job_app_rt_list['+(pcs_index+j)+'].fap_job_app_rt_acp_miss"]').children("option[value='D0000']").attr("selected", false);
						$('[name="fap_job_apply_info_list['+(app_index-i)+'].jobApplyResult.fap_job_app_rt_list['+(pcs_index+j)+'].fap_job_app_rt_acp_miss"]').children("option[value='D0001']").attr("selected", true);
						$('[name="fap_job_apply_info_list['+(app_index-i)+'].jobApplyResult.fap_job_app_rt_list['+(pcs_index+j)+'].fap_job_app_rt_acp_miss"]').children("option[value='D0002']").attr("selected", false);
						$('[name="fap_job_apply_info_list['+(app_index-i)+'].jobApplyResult.fap_job_app_rt_list['+(pcs_index+j)+'].fap_job_app_rt_acp_miss"]').children("option[value='D0003']").attr("selected", false);
					}else{		//이후 전형 일괄 진행중 처리
						$('[name="fap_job_apply_info_list['+(app_index-i)+'].jobApplyResult.fap_job_app_rt_list['+(pcs_index+j)+'].fap_job_app_rt_acp_miss"]').val("D0000");
						$('[name="fap_job_apply_info_list['+(app_index-i)+'].jobApplyResult.fap_job_app_rt_list['+(pcs_index+j)+'].fap_job_app_rt_acp_miss"]').attr("disabled", false);
						$('[name="fap_job_apply_info_list['+(app_index-i)+'].jobApplyResult.fap_job_app_rt_list['+(pcs_index+j)+'].fap_job_app_rt_acp_miss"]').children("option[value='D0000']").attr("selected", true);
						$('[name="fap_job_apply_info_list['+(app_index-i)+'].jobApplyResult.fap_job_app_rt_list['+(pcs_index+j)+'].fap_job_app_rt_acp_miss"]').children("option[value='D0001']").attr("selected", false);
						$('[name="fap_job_apply_info_list['+(app_index-i)+'].jobApplyResult.fap_job_app_rt_list['+(pcs_index+j)+'].fap_job_app_rt_acp_miss"]').children("option[value='D0002']").attr("selected", false);
						$('[name="fap_job_apply_info_list['+(app_index-i)+'].jobApplyResult.fap_job_app_rt_list['+(pcs_index+j)+'].fap_job_app_rt_acp_miss"]').children("option[value='D0003']").attr("selected", false);
					}
					//최종결과 진행중 처리
					$('[name="fap_job_apply_info_list['+(app_index-i)+'].fap_job_app_final_rt_acp_miss"]').val("D0000");
					$('[name="fap_job_apply_info_list['+(app_index-i)+'].fap_job_app_final_rt_acp_miss"]').attr("disabled", false);
					$('[name="fap_job_apply_info_list['+(app_index-i)+'].fap_job_app_final_rt_acp_miss"]').children("option[value='D0000']").attr("selected", true);
					$('[name="fap_job_apply_info_list['+(app_index-i)+'].fap_job_app_final_rt_acp_miss"]').children("option[value='D0001']").attr("selected", false);
					$('[name="fap_job_apply_info_list['+(app_index-i)+'].fap_job_app_final_rt_acp_miss"]').children("option[value='D0002']").attr("selected", false);
					$('[name="fap_job_apply_info_list['+(app_index-i)+'].fap_job_app_final_rt_acp_miss"]').children("option[value='D0004']").attr("selected", false);
					//예비합격 순위 div 초기화
		    		context = '';
		    		$('[name="fap_job_apply_info_list['+(app_index-i)+'].fap_job_app_final_rt_acp_miss"]').next(".waiting_list_ranking_div").html(context);
				}
				
				//이전 전형 진행중인 경우
				for(var k = 0; k < $('[name="fap_job_apply_info_list['+(app_index-i)+'].jobApplyResult.fap_job_app_rt_list['+pcs_index+'].fap_job_app_rt_acp_miss"]').parent().prevAll(".wid6").length; k++){
					if($('[name="fap_job_apply_info_list['+(app_index-i)+'].jobApplyResult.fap_job_app_rt_list['+pcs_index+'].fap_job_app_rt_acp_miss"]').parent().prevAll('.wid6:eq('+k+')').children(".app_result_select").val() == "D0000"){
				   		count += 1;
			   	 	}
				}
			}
			
			if(count > 0){
				alert('<spring:message code="fap.comp.applicant_status_info" />');
			}
			
    	});
	    
	    //미스매칭 일괄 불합격
	    $("#miss_nobody_pass").click(function(){
	    	var count = 0;
	    	//불합격처리 대상 지원자수
	    	var app_index =  $(".peoplemain1").length;
	    	//전형 선택 옵션 인덱스
	    	var pcs_index = $(".miss_fap_job_recruit_pcs_gb option").index($(".miss_fap_job_recruit_pcs_gb option:selected"));
	    	//전형의 수
	    	var pcs_total_index = $(".miss_fap_job_recruit_pcs_gb option").length;
	    	
			//일괄 불합격 설정
			for(var i=1; i<=app_index; i++){
				for(var j=0; j<(pcs_total_index-pcs_index); j++){
					//일괄 불합격 처리
					if(j==0){
						$('[name="fap_job_apply_info_list['+(app_index-i)+'].jobApplyResult.fap_job_app_rt_list['+(pcs_index+j)+'].fap_job_app_rt_acp_miss"]').val("D0002");
						$('[name="fap_job_apply_info_list['+(app_index-i)+'].jobApplyResult.fap_job_app_rt_list['+(pcs_index+j)+'].fap_job_app_rt_acp_miss"]').children("option[value='D0000']").attr("selected", false);
						$('[name="fap_job_apply_info_list['+(app_index-i)+'].jobApplyResult.fap_job_app_rt_list['+(pcs_index+j)+'].fap_job_app_rt_acp_miss"]').children("option[value='D0001']").attr("selected", false);
						$('[name="fap_job_apply_info_list['+(app_index-i)+'].jobApplyResult.fap_job_app_rt_list['+(pcs_index+j)+'].fap_job_app_rt_acp_miss"]').children("option[value='D0002']").attr("selected", true);
						$('[name="fap_job_apply_info_list['+(app_index-i)+'].jobApplyResult.fap_job_app_rt_list['+(pcs_index+j)+'].fap_job_app_rt_acp_miss"]').children("option[value='D0003']").attr("selected", false);
					}else{		//이후 전형 - 처리
						$('[name="fap_job_apply_info_list['+(app_index-i)+'].jobApplyResult.fap_job_app_rt_list['+(pcs_index+j)+'].fap_job_app_rt_acp_miss"]').val("D0003");
						$('[name="fap_job_apply_info_list['+(app_index-i)+'].jobApplyResult.fap_job_app_rt_list['+(pcs_index+j)+'].fap_job_app_rt_acp_miss"]').attr("disabled", "disabled");
						$('[name="fap_job_apply_info_list['+(app_index-i)+'].jobApplyResult.fap_job_app_rt_list['+(pcs_index+j)+'].fap_job_app_rt_acp_miss"]').children("option[value='D0000']").attr("selected", false);
						$('[name="fap_job_apply_info_list['+(app_index-i)+'].jobApplyResult.fap_job_app_rt_list['+(pcs_index+j)+'].fap_job_app_rt_acp_miss"]').children("option[value='D0001']").attr("selected", false);
						$('[name="fap_job_apply_info_list['+(app_index-i)+'].jobApplyResult.fap_job_app_rt_list['+(pcs_index+j)+'].fap_job_app_rt_acp_miss"]').children("option[value='D0002']").attr("selected", false);
						$('[name="fap_job_apply_info_list['+(app_index-i)+'].jobApplyResult.fap_job_app_rt_list['+(pcs_index+j)+'].fap_job_app_rt_acp_miss"]').children("option[value='D0003']").attr("selected", true);
					}
					//최종결과 불합격 처리
					$('[name="fap_job_apply_info_list['+(app_index-i)+'].fap_job_app_final_rt_acp_miss"]').val("D0002");
					$('[name="fap_job_apply_info_list['+(app_index-i)+'].fap_job_app_final_rt_acp_miss"]').attr("disabled", "disabled");
					$('[name="fap_job_apply_info_list['+(app_index-i)+'].fap_job_app_final_rt_acp_miss"]').children("option[value='D0000']").attr("selected", false);
					$('[name="fap_job_apply_info_list['+(app_index-i)+'].fap_job_app_final_rt_acp_miss"]').children("option[value='D0001']").attr("selected", false);
					$('[name="fap_job_apply_info_list['+(app_index-i)+'].fap_job_app_final_rt_acp_miss"]').children("option[value='D0002']").attr("selected", true);
					$('[name="fap_job_apply_info_list['+(app_index-i)+'].fap_job_app_final_rt_acp_miss"]').children("option[value='D0004']").attr("selected", false);
					//예비합격 순위 div 초기화
		    		context = '';
		    		$('[name="fap_job_apply_info_list['+(app_index-i)+'].fap_job_app_final_rt_acp_miss"]').next(".waiting_list_ranking_div").html(context);
				}
				
				//이전 전형 진행중인 경우
				for(var k = 0; k < $('[name="fap_job_apply_info_list['+(app_index-i)+'].jobApplyResult.fap_job_app_rt_list['+pcs_index+'].fap_job_app_rt_acp_miss"]').parent().prevAll(".wid6").length; k++){
					if($('[name="fap_job_apply_info_list['+(app_index-i)+'].jobApplyResult.fap_job_app_rt_list['+pcs_index+'].fap_job_app_rt_acp_miss"]').parent().prevAll('.wid6:eq('+k+')').children(".app_result_select").val() == "D0000"){
				   		count += 1;
			   	 	}
				}				
			}
			
			if(count > 0){
				alert('<spring:message code="fap.comp.applicant_status_info" />');
			}
			
    	});
	    
	    //전형별 합불
	  	$(".app_result_select").change(function(){
	  		//진행중 선택
	  		 if($(this).children("option:selected").val() == 'D0000'){
	  			$(this).val("D0000");
	    		$(this).children("option[value='D0000']").attr("selected", true);
	    		$(this).children("option[value='D0001']").attr("selected", false);
	    		$(this).children("option[value='D0002']").attr("selected", false);	    		
	    		$(this).parent().nextAll(".wid6").children(".app_result_select").val("D0000");
	    		$(this).parent().nextAll(".wid6").children(".app_result_select").attr("disabled", false);
	    		$(this).parent().nextAll(".wid6").children(".app_result_select").children("option[value='D0000']").attr("selected", true);
	    		$(this).parent().nextAll(".wid6").children(".app_result_select").children("option[value='D0001']").attr("selected", false);
	    		$(this).parent().nextAll(".wid6").children(".app_result_select").children("option[value='D0002']").attr("selected", false);
	    		$(this).parent().nextAll(".wid6").children(".app_result_select").children("option[value='D0003']").attr("selected", false);
	    		$(this).parent().nextAll(".wid6").children(".app_result_select").children("option[value='D0003']").attr("hidden", "hidden");
	    		$(this).parent().nextAll(".wid7").children(".final_result_select").val("D0000");
	    		$(this).parent().nextAll(".wid7").children(".final_result_select").attr("disabled", false);
	    		$(this).parent().nextAll(".wid7").children(".final_result_select").children("option[value='D0000']").attr("selected", true);
	    		$(this).parent().nextAll(".wid7").children(".final_result_select").children("option[value='D0001']").attr("selected", false);
	    		$(this).parent().nextAll(".wid7").children(".final_result_select").children("option[value='D0002']").attr("selected", false);
	    		$(this).parent().nextAll(".wid7").children(".final_result_select").children("option[value='D0004']").attr("selected", false);
	    		context = '';
	    		$(this).parent().nextAll(".wid7").children(".waiting_list_ranking_div").html(context);
	  		 }
		   //합격 선택
		   if($(this).children("option:selected").val() == 'D0001'){
			   //이전 전형 진행중인 경우
			   var count = 0;
	    		for(var i = 0; i < $(this).parent().prevAll(".wid6").length; i++){		    		
					if($(this).parent().prevAll('.wid6:eq('+i+')').children(".app_result_select").val() == "D0000"){				   			
				   		count += 1;
			   	 	}					
				}
	    		if(count > 0){
					alert('<spring:message code="fap.comp.applicant_status_info" />');
					$(this).val("D0000");
		    		$(this).children("option[value='D0000']").attr("selected", true);
		    		$(this).children("option[value='D0001']").attr("selected", false);
		    		$(this).children("option[value='D0002']").attr("selected", false);	    	
					return false;
				}
	    		$(this).val("D0001");
	    		$(this).children("option[value='D0000']").attr("selected", false);
	    		$(this).children("option[value='D0001']").attr("selected", true);
	    		$(this).children("option[value='D0002']").attr("selected", false);	    		
	    		$(this).parent().nextAll(".wid6").children(".app_result_select").val("D0000");
	    		$(this).parent().nextAll(".wid6").children(".app_result_select").attr("disabled", false);
	    		$(this).parent().nextAll(".wid6").children(".app_result_select").children("option[value='D0000']").attr("selected", true);
	    		$(this).parent().nextAll(".wid6").children(".app_result_select").children("option[value='D0001']").attr("selected", false);
	    		$(this).parent().nextAll(".wid6").children(".app_result_select").children("option[value='D0002']").attr("selected", false);
	    		$(this).parent().nextAll(".wid6").children(".app_result_select").children("option[value='D0003']").attr("selected", false);
	    		$(this).parent().nextAll(".wid6").children(".app_result_select").children("option[value='D0003']").attr("hidden", "hidden");
	    		$(this).parent().nextAll(".wid7").children(".final_result_select").val("D0000");
	    		$(this).parent().nextAll(".wid7").children(".final_result_select").attr("disabled", false);
	    		$(this).parent().nextAll(".wid7").children(".final_result_select").children("option[value='D0000']").attr("selected", true);
	    		$(this).parent().nextAll(".wid7").children(".final_result_select").children("option[value='D0001']").attr("selected", false);
	    		$(this).parent().nextAll(".wid7").children(".final_result_select").children("option[value='D0002']").attr("selected", false);
	    		$(this).parent().nextAll(".wid7").children(".final_result_select").children("option[value='D0004']").attr("selected", false);
	    		context = '';
	    		$(this).parent().nextAll(".wid7").children(".waiting_list_ranking_div").html(context);
		   }
	    	//불합격
	    	if($(this).children("option:selected").val() == 'D0002'){
	    		//이전 전형이 진행중인 경우
	    		var count = 0;
	    		for(var i = 0; i < $(this).parent().prevAll(".wid6").length; i++){
					if($(this).parent().prevAll('.wid6:eq('+i+')').children(".app_result_select").val() == "D0000"){
				   		count += 1;
			   	 	}
				}
	    		if(count > 0){
					alert('<spring:message code="fap.comp.applicant_status_info" />');
					$(this).val("D0000");
		    		$(this).children("option[value='D0000']").attr("selected", true);
		    		$(this).children("option[value='D0001']").attr("selected", false);
		    		$(this).children("option[value='D0002']").attr("selected", false);	    	
					return false;
				}
	    		
	    		$(this).val("D0002");
	    		$(this).children("option[value='D0000']").attr("selected", false);
	    		$(this).children("option[value='D0001']").attr("selected", false);
	    		$(this).children("option[value='D0002']").attr("selected", true);
	    		$(this).parent().nextAll(".wid6").children(".app_result_select").val("D0003");
	    		$(this).parent().nextAll(".wid6").children(".app_result_select").attr("disabled", "disabled");
	    		$(this).parent().nextAll(".wid6").children(".app_result_select").children("option[value='D0000']").attr("selected", false);
	    		$(this).parent().nextAll(".wid6").children(".app_result_select").children("option[value='D0001']").attr("selected", false);
	    		$(this).parent().nextAll(".wid6").children(".app_result_select").children("option[value='D0002']").attr("selected", false);
	    		$(this).parent().nextAll(".wid6").children(".app_result_select").children("option[value='D0003']").attr("selected", true);
	    		$(this).parent().nextAll(".wid7").children(".final_result_select").val("D0002");
	    		$(this).parent().nextAll(".wid7").children(".final_result_select").attr("disabled", "disabled");
	    		$(this).parent().nextAll(".wid7").children(".final_result_select").children("option[value='D0000']").attr("selected", false);
	    		$(this).parent().nextAll(".wid7").children(".final_result_select").children("option[value='D0001']").attr("selected", false);
	    		$(this).parent().nextAll(".wid7").children(".final_result_select").children("option[value='D0002']").attr("selected", true);
	    		$(this).parent().nextAll(".wid7").children(".final_result_select").children("option[value='D0003']").attr("selected", false);
	    		context = '';
	    		$(this).parent().nextAll(".wid7").children(".waiting_list_ranking_div").html(context);
	    	}
	    	
	    });
	    
	});
</script>
<body ng-app="myapp" ng-controller="CompanyController">
<%@include file="agency_menu.jsp"%>
<div class="join-wrap">
	<div id="subcontents">
		<c:set var="now" value="<%=new java.util.Date()%>" />
		<fmt:parseDate value="${final_select_info.fap_jobfair_divide_final_select_st}" pattern="yyyy-MM-dd" var="startDate" />
		<fmt:parseDate value="${final_select_info.fap_jobfair_divide_final_select_et}" pattern="yyyy-MM-dd" var="endDate" />
		 
		<fmt:formatDate value="${now}" pattern="yyyy-MM-dd" var="nowDate" />             <%-- 오늘날짜 --%>
		<fmt:formatDate value="${startDate}" pattern="yyyy-MM-dd" var="openDate"/>       <%-- 시작날짜 --%>
		<fmt:formatDate value="${endDate}" pattern="yyyy-MM-dd" var="closeDate"/>        <%-- 마감날짜 --%>
		<c:if test="${openDate <= nowDate  && nowDate <= closeDate}">
			<c:if test="${final_select_info.fap_jobfair_divide_final_select_et != null}">
				<c:set var="final_select_date" value="${final_select_info.fap_jobfair_divide_final_select_et}"/>
				<span style="color: red">${fn:substring(final_select_date,0,4) }<spring:message code="com.placeholder.year" />
				 ${fn:substring(final_select_date,5,7) }<spring:message code="com.placeholder.month" />
				  ${fn:substring(final_select_date,8,10) }<spring:message code="com.placeholder.day" /></span>
				<spring:message code="fap.comp.applicant_final_rt_select" />
			</c:if>
		</c:if>	
		<c:if test="${limit_type != null }">
			<spring:message code="fap.comp.app_final_rt_limit_comment1" />${limit_count }<spring:message code="fap.comp.app_final_rt_limit_comment2" />
		</c:if>
		
		<!-- 정규지원자 -->
		<div id="peopleBBS" ng-if="applicantInfo[0] != null">
			<ul class="peoplechk" display="table">
				<li class="pb-5" display="table-cell">
					<h2><spring:message code="fap.comp.regular_apply" /></h2>
					<c:if test="${fap_job_ad_state != 'C2102'}">
						<select class="fap_job_recruit_pcs_gb" style="width: 150px;">
							<option ng-repeat="recruit_pcs in recruitPcs" ng-if="recruit_pcs.fap_job_recruit_pcs_gb == 'C2500'" selectcode value="C2500" pcs_seq="{{recruit_pcs.fap_job_recruit_pcs_seq}}" selected></option>
							<option ng-repeat="recruit_pcs in recruitPcs" ng-if="recruit_pcs.fap_job_recruit_pcs_gb == 'C2501'" selectcode value="C2501" pcs_seq="{{recruit_pcs.fap_job_recruit_pcs_seq}}"></option>
							<option ng-repeat="recruit_pcs in recruitPcs" ng-if="recruit_pcs.fap_job_recruit_pcs_gb == 'C2502'" selectcode value="C2502" pcs_seq="{{recruit_pcs.fap_job_recruit_pcs_seq}}"></option>
							<option ng-repeat="recruit_pcs in recruitPcs" ng-if="recruit_pcs.fap_job_recruit_pcs_gb == 'C2503'" selectcode value="C2503" pcs_seq="{{recruit_pcs.fap_job_recruit_pcs_seq}}"></option>
							<option ng-repeat="recruit_pcs in recruitPcs" ng-if="recruit_pcs.fap_job_recruit_pcs_gb == 'C2504'" selectcode value="C2504" pcs_seq="{{recruit_pcs.fap_job_recruit_pcs_seq}}"></option>
						</select>
						<button class="btn3 btn-primary" id="everybody_pass"><spring:message code="fap.comp.app_rt_everybody_pass" /></button>
						<button class="btn3 btn-primary" id="nobody_pass"><spring:message code="fap.comp.app_rt_nobody_pass" /></button>
					</c:if>
					<button class="btn3 btn-primary resume_print"><spring:message code="fap.comp.app_print" /></button>
					&emsp;<span style="color: red;">*</span><spring:message code="fap.comp.applicant_status_save" />
				</li>
			</ul>
			<c:if test="${fap_job_ad_state != 'C2102'}">
				<ul class="peoplefind"><li><button class="btn3 btn-primary" id="saveBtn"><spring:message code="fap.comp.app_rt_save" /></button></li></ul>				
			</c:if>
				<ul class="peopletitle">
					<li class="wid1"></li>
					<li class="wid1">No</li>
					<li class="wid4"><spring:message code="fap.comp.applicant_info" /></li>
					<li class="wid6" ng-repeat="pcs in recruitPcs">
						<code value="C2500" ng-if="pcs.fap_job_recruit_pcs_gb == 'C2500' "></code>
						<code value="C2501" ng-if="pcs.fap_job_recruit_pcs_gb == 'C2501' "></code>
						<code value="C2502" ng-if="pcs.fap_job_recruit_pcs_gb == 'C2502' "></code>
						<code value="C2503" ng-if="pcs.fap_job_recruit_pcs_gb == 'C2503' "></code>
						<code value="C2504" ng-if="pcs.fap_job_recruit_pcs_gb == 'C2504' "></code>
					</li>
					<li class="wid7"><spring:message code="fap.comp.app_final_rt" /></li>
					<li class="wid8"><spring:message code="fap.comp.join_work_or_not" /></li>
					<li class="wid9"><spring:message code="fap.comp.app_final_rt_pass_reason" /></li>
				</ul>
				
				<form action="/fap/agency/update_fap_job_apply_result" method="POST" id="regular_apply_btn">			
				<input type="hidden" name="fap_jobfair_divide_seq" value="${fap_jobfair_divide_seq}">
				<input type="hidden" name="fap_job_ad_seq" value="${fap_job_ad_seq}">
				<input type="hidden" name="fap_comp_id" value="${fap_comp_id}">
				<div ng-repeat="info in applicantInfo" ng-if="info.fap_job_ad_is_mismatching == 'C4900' " ng-init="infoIndex = $index">				
					<ul class="peoplemain" ng-repeat="finalCheck in info.finalResultMap" ng-if="::finalCheck.fap_job_app_final_rt_acp == 'D0000' "  >
						<li class="wid1">
							<span class="resume-check">
								<label class="resume-check-label">
								</label>
							</span>
						</li>
						<li class="wid1"> 
							{{infoIndex+1}}
						</li>
						<li class="wid4">
							<input type="hidden" name="fap_job_apply_info_list[{{infoIndex}}].user_id" value="{{info.user_id}}">
							<div class="screenshot" tooltip="/fap/user/resume_photo_image/{{info.resumeMap.fap_resume_pic_saved}}">
								<span ng-bind="info.resumeNmList[2].fap_resume_nm"></span>
								<img class="tooltip-image" alt="photo" src="<c:url value="/resources/segroup/society/fap/images/icon-photo.png" />">
							</div>
							<div ng-if="info.resumeMap.fap_resume_gender == 'A0000' ">
								<code value="A0000"></code>
							</div>
							<div ng-if="info.resumeMap.fap_resume_gender == 'A0001' ">
								<code value="A0001"></code>
							</div>
							<div class="user-code" cd="{{info.user_flag}}"></div>
							<div><button type="button" class="resumeButton btn3" value="{{info.resumeMap.fap_resume_seq}}" id="{{info.user_id}}" ng-click="resumeModal($event)"><spring:message code="fap.common.resume" /></button></div>
						</li>
						<li class="wid6" ng-repeat="result in info.applyResultMap">
							<input type="hidden" name="fap_job_apply_info_list[{{infoIndex}}].jobApplyResult.fap_job_app_rt_list[{{$index}}].fap_job_app_rt_seq" value="{{result.fap_job_app_rt_seq}}">
							<select name="fap_job_apply_info_list[{{infoIndex}}].jobApplyResult.fap_job_app_rt_list[{{$index}}].fap_job_app_rt_acp" class="app_result_select" ng-model="::result.fap_job_app_rt_acp">
								<option selectcode value="D0000" selected></option>
								<option selectcode value="D0001"></option>
								<option selectcode value="D0002"></option>
								<option selectcode value="D0003" hidden></option>
							</select>
						</li>
						<li class="wid7" ng-repeat="final in info.finalResultMap">
							<input type="hidden" name="fap_job_apply_info_list[{{infoIndex}}].fap_job_app_final_rt_seq" value="{{final.fap_job_app_final_rt_seq}}" index="{{infoIndex}}">
							<select name="fap_job_apply_info_list[{{infoIndex}}].fap_job_app_final_rt_acp" class="final_result_select" ng-model="::final.fap_job_app_final_rt_acp" onchange="angular.element(this).scope().onChange(this)">
								<option selectcode value="D0000" selected></option>
								<option selectcode value="D0001"></option>
								<option selectcode value="D0002"></option>
								<option selectcode value="D0004"></option>
							</select>
							<div class="waiting_list_ranking_div" ng-if="::final.fap_job_app_final_rt_acp == 'D0004'">
								<select name="fap_job_apply_info_list[{{infoIndex}}].fap_job_app_standby_rank" class="standby_rank" ng-model="::final.fap_job_app_standby_rank">
									<option disabled="disabled"><spring:message code="fap.comp.app_final_stand_by_ranking" /></option>
									<option ng-value="1">1</option>
									<option ng-value="2">2</option>
									<option ng-value="3">3</option>
									<option ng-value="4">4</option>
									<option ng-value="5">5</option>
									<option ng-value="6">6</option>
									<option ng-value="7">7</option>
									<option ng-value="8">8</option>
									<option ng-value="9">9</option>
									<option ng-value="10">10</option>
								</select>
							</div>
						</li>
						<li class="wid8" ng-repeat="finalRe in info.finalResultMap">
							<div ng-if="finalRe.fap_job_app_approval_gb == 'D0801' ">
								<code value="D0700"  ng-if="finalRe.fap_job_app_choice_comp_gb == 'D0700' "></code>
								<code value="D0701"  ng-if="finalRe.fap_job_app_choice_comp_gb == 'D0701' "></code>
								<code value="D0702"  ng-if="finalRe.fap_job_app_choice_comp_gb == 'D0702' "></code>
							</div>
							<div ng-if="finalRe.fap_job_app_approval_gb == 'D0800' ">
								<code value="D0700"></code>
							</div>
						</li>
						<li class="wid9" ng-repeat="finalResult in info.finalResultMap">
							<button type="button" ng-if="finalResult.fap_job_app_pass_comment != null && finalResult.fap_job_app_pass_comment != '' " infoIndex="{{infoIndex}}" ng-click="updatePassComment(infoIndex, $event, finalResult.fap_job_app_final_rt_seq)" class="btn3 btn-primary"><spring:message code="fap.common.update.btn" /></button>
							<button type="button" ng-if="finalResult.fap_job_app_pass_comment == null || finalResult.fap_job_app_pass_comment == '' " infoIndex="{{infoIndex}}" ng-click="insertPassComment(infoIndex, $event, finalResult.fap_job_app_final_rt_seq)" class="btn3 btn-primary"><spring:message code="fap.common.join.btn" /></button>
							<div class="pass_comment_div">
								
							</div>
						</li>
					</ul>
					<ul  class="peoplemain" ng-repeat="final in info.finalResultMap" ng-if="::final.fap_job_app_final_rt_acp != 'D0000' ">
						<li class="wid1">
							<span class="resume-check">
								<label class="resume-check-label">
								</label>
							</span>
						</li>
						<li class="wid1">
							<div>{{infoIndex+1}}</div>
						</li>
						<li class="wid4">
							<div class="screenshot" tooltip="/fap/user/resume_photo_image/{{info.resumeMap.fap_resume_pic_saved}}">
								<span ng-bind="info.resumeNmList[2].fap_resume_nm"></span>
								<img class="tooltip-image" alt="photo" src="<c:url value="/resources/segroup/society/fap/images/icon-photo.png" />">
							</div>
							<div ng-if="info.resumeMap.fap_resume_gender == 'A0000' ">
								<code value="A0000"></code>
							</div>
							<div ng-if="info.resumeMap.fap_resume_gender == 'A0001' ">
								<code value="A0001"></code>
							</div>
							<div class="user-code" cd="{{info.user_flag}}"></div>
							<div><button type="button" class="resumeButton btn3" value="{{info.resumeMap.fap_resume_seq}}" id="{{info.user_id}}" ng-click="resumeModal($event)"><spring:message code="fap.common.resume" /></button></div>
						</li>
						<li class="wid6" ng-repeat="result in info.applyResultMap">
							<select class="app_result_select" ng-model="::result.fap_job_app_rt_acp" disabled="disabled">
								<option selectcode value="D0000" selected></option>
								<option selectcode value="D0001"></option>
								<option selectcode value="D0002"></option>
								<option selectcode value="D0003" hidden></option>
							</select>
						</li>
						<li class="wid7" ng-repeat="final in info.finalResultMap">
							<select class="final_result_select" ng-model="::final.fap_job_app_final_rt_acp" disabled="disabled">
								<option selectcode value="D0000" selected></option>
								<option selectcode value="D0001"></option>
								<option selectcode value="D0002"></option>
								<option selectcode value="D0004"></option>
							</select>
							<div class="waiting_list_ranking_div" ng-if="final.fap_job_app_final_rt_acp == 'D0004'">
								<select class="standby_rank" ng-model="::final.fap_job_app_standby_rank" disabled="disabled">
									<option disabled="disabled"><spring:message code="fap.comp.app_final_stand_by_ranking" /></option>
									<option ng-value="1">1</option>
									<option ng-value="2">2</option>
									<option ng-value="3">3</option>
									<option ng-value="4">4</option>
									<option ng-value="5">5</option>
									<option ng-value="6">6</option>
									<option ng-value="7">7</option>
									<option ng-value="8">8</option>
									<option ng-value="9">9</option>
									<option ng-value="10">10</option>
								</select>
							</div>
						</li>
						<li class="wid8" ng-repeat="finalRe in info.finalResultMap">
							<div ng-if="finalRe.fap_job_app_approval_gb == 'D0801' ">
								<code value="D0700"  ng-if="finalRe.fap_job_app_choice_comp_gb == 'D0700' "></code>
								<code value="D0701"  ng-if="finalRe.fap_job_app_choice_comp_gb == 'D0701' "></code>
								<code value="D0702"  ng-if="finalRe.fap_job_app_choice_comp_gb == 'D0702' "></code>
							</div>
							<div ng-if="finalRe.fap_job_app_approval_gb == 'D0800' ">
								<code value="D0700"></code>
							</div>
						</li>
						<li class="wid9" ng-repeat="finalResult in info.finalResultMap">
							<button type="button" ng-if="finalResult.fap_job_app_pass_comment != null && finalResult.fap_job_app_pass_comment != '' " infoIndex="{{infoIndex}}" ng-click="updatePassComment(infoIndex, $event ,finalResult.fap_job_app_final_rt_seq)" class="btn3 btn-primary"><spring:message code="fap.common.update.btn" /></button>
							<button type="button" ng-if="finalResult.fap_job_app_pass_comment == null || finalResult.fap_job_app_pass_comment == '' " infoIndex="{{infoIndex}}" ng-click="insertPassComment(infoIndex, $event , finalResult.fap_job_app_final_rt_seq)" class="btn3 btn-primary"><spring:message code="fap.common.join.btn" /></button>
							<div class="pass_comment_div">
								
							</div>
						</li>
					</ul>
				</div>
			</form>
			<br><br><br><br>
		</div>		
		
		<!-- 미스매칭 지원자 -->
		<div id="peopleBBS" ng-if="missApplicantInfo[0] != null">
			<ul class="peoplechk" display="table">
				<li class="pb-5" display="table-cell">
				<c:if test="${fap_job_ad_state != 'C2102'}">
						<h2><spring:message code="fap.comp.missmatching_apply" /></h2>
						<select class="miss_fap_job_recruit_pcs_gb" style="width: 150px;">
							<option ng-repeat="miss_recruit_pcs in recruitPcs" ng-if="miss_recruit_pcs.fap_job_recruit_pcs_gb == 'C2500'" selectcode value="C2500" pcs_seq="{{miss_recruit_pcs.fap_job_recruit_pcs_seq}}" selected></option>
							<option ng-repeat="miss_recruit_pcs in recruitPcs" ng-if="miss_recruit_pcs.fap_job_recruit_pcs_gb == 'C2501'" selectcode value="C2501" pcs_seq="{{miss_recruit_pcs.fap_job_recruit_pcs_seq}}"></option>
							<option ng-repeat="miss_recruit_pcs in recruitPcs" ng-if="miss_recruit_pcs.fap_job_recruit_pcs_gb == 'C2502'" selectcode value="C2502" pcs_seq="{{miss_recruit_pcs.fap_job_recruit_pcs_seq}}"></option>
							<option ng-repeat="miss_recruit_pcs in recruitPcs" ng-if="miss_recruit_pcs.fap_job_recruit_pcs_gb == 'C2503'" selectcode value="C2503" pcs_seq="{{miss_recruit_pcs.fap_job_recruit_pcs_seq}}"></option>
							<option ng-repeat="miss_recruit_pcs in recruitPcs" ng-if="miss_recruit_pcs.fap_job_recruit_pcs_gb == 'C2504'" selectcode value="C2504" pcs_seq="{{miss_recruit_pcs.fap_job_recruit_pcs_seq}}"></option>
						</select>
						<button class="btn3 btn-primary" id="miss_everybody_pass"><spring:message code="fap.comp.app_rt_everybody_pass" /></button>
						<button class="btn3 btn-primary" id="miss_nobody_pass"><spring:message code="fap.comp.app_rt_nobody_pass" /></button>
				</c:if>
					<button class="btn3 btn-primary resume_print"><spring:message code="fap.comp.app_print" /></button>
					&emsp;<span style="color: red;">*</span><spring:message code="fap.comp.applicant_status_save" />
				</li>
			</ul>
			    <c:if test="${fap_job_ad_state != 'C2102'}">
					<ul class="peoplefind"><li><button class="btn3 btn-primary" id="missSaveBtn"><spring:message code="fap.comp.app_rt_save" /></button></li></ul>				
				</c:if>
				<ul class="peopletitle">
					<li class="wid1"></li>
					<li class="wid1">No</li>
					<li class="wid4"><spring:message code="fap.comp.applicant_info" /></li>
					<li class="wid6" ng-repeat="miss_pcs in recruitPcs">
						<code value="C2500" ng-if="miss_pcs.fap_job_recruit_pcs_gb == 'C2500' "></code>
						<code value="C2501" ng-if="miss_pcs.fap_job_recruit_pcs_gb == 'C2501' "></code>
						<code value="C2502" ng-if="miss_pcs.fap_job_recruit_pcs_gb == 'C2502' "></code>
						<code value="C2503" ng-if="miss_pcs.fap_job_recruit_pcs_gb == 'C2503' "></code>
						<code value="C2504" ng-if="miss_pcs.fap_job_recruit_pcs_gb == 'C2504' "></code>
					</li>
					<li class="wid7"><spring:message code="fap.comp.app_final_rt" /></li>
					<li class="wid8"><spring:message code="fap.comp.join_work_or_not" /></li>
					<li class="wid9"><spring:message code="fap.comp.app_final_rt_pass_reason" /></li>
				</ul>
				<form action="/fap/agency/update_missmatching_fap_job_apply_result" method="POST" id="missmatching_apply_btn">
					<input type="hidden" name="fap_jobfair_divide_seq" value="${fap_jobfair_divide_seq}">
					<input type="hidden" name="fap_job_ad_seq" value="${fap_job_ad_seq}">
					<input type="hidden" name="fap_comp_id" value="${fap_comp_id}">
				<div ng-repeat="missInfo in missApplicantInfo" ng-if="missInfo.fap_job_ad_is_mismatching == 'C4901' " ng-init="missInfoIndex = $index">
					<ul class="peoplemain1" ng-repeat="missFinalCheck in missInfo.missFinalResultMap" ng-if="::missFinalCheck.fap_job_app_final_rt_acp == 'D0000' ">
						<li class="wid1">
							<span class="resume-check">
								<label class="resume-check-label">
								</label>
							</span>
						</li>
						<li class="wid1">
							{{missInfoIndex+1}}
						</li>
						<li class="wid4">
							<input type="hidden" name="fap_job_apply_info_list[{{missInfoIndex}}].user_id" value="{{missInfo.user_id}}">
							<div class="screenshot" tooltip="/fap/user/resume_photo_image/{{missInfo.missResumeMap.fap_resume_pic_saved}}">
								<span ng-bind="missInfo.missResumeNmList[2].fap_resume_nm"></span>
								<img class="tooltip-image" alt="photo" src="<c:url value="/resources/segroup/society/fap/images/icon-photo.png" />">
							</div>
							<div ng-if="missInfo.missResumeMap.fap_resume_gender == 'A0000' ">
								<code value="A0000"></code>
							</div>
							<div ng-if="missInfo.missResumeMap.fap_resume_gender == 'A0001' ">
								<code value="A0001"></code>
							</div>
							<div class="user-code" cd="{{missInfo.user_flag}}"></div>
							<div><button type="button" class="resumeButton btn3" value="{{missInfo.missResumeMap.fap_resume_seq}}" id="{{missInfo.user_id}}" ng-click="resumeModal($event)"><spring:message code="fap.common.resume" /></button></div>
						</li>
						<li class="wid6" ng-repeat="missResult in missInfo.missApplyResultMap">
							<input type="hidden" name="fap_job_apply_info_list[{{missInfoIndex}}].jobApplyResult.fap_job_app_rt_list[{{$index}}].fap_job_app_rt_seq" value="{{missResult.fap_job_app_rt_seq}}">
							<select name="fap_job_apply_info_list[{{missInfoIndex}}].jobApplyResult.fap_job_app_rt_list[{{$index}}].fap_job_app_rt_acp_miss" class="app_result_select" ng-model="::missResult.fap_job_app_rt_acp">
								<option selectcode value="D0000" selected></option>
								<option selectcode value="D0001"></option>
								<option selectcode value="D0002"></option>
								<option selectcode value="D0003" hidden></option>
							</select>
						</li>
						<li class="wid7" ng-repeat="missFinal in missInfo.missFinalResultMap">
							<input type="hidden" name="fap_job_apply_info_list[{{missInfoIndex}}].fap_job_app_final_rt_seq" value="{{missFinal.fap_job_app_final_rt_seq}}" index="{{missInfoIndex}}">
							<select name="fap_job_apply_info_list[{{missInfoIndex}}].fap_job_app_final_rt_acp_miss" class="final_result_select" ng-model="::missFinal.fap_job_app_final_rt_acp" onchange="angular.element(this).scope().onChange(this)">
								<option selectcode value="D0000" selected></option>
								<option selectcode value="D0001"></option>
								<option selectcode value="D0002"></option>
								<option selectcode value="D0004"></option>
							</select>
							<div class="waiting_list_ranking_div" ng-if="::missFinal.fap_job_app_final_rt_acp == 'D0004'">
								<select name="fap_job_apply_info_list[{{missInfoIndex}}].fap_job_app_standby_rank" class="standby_rank" ng-model="::missFinal.fap_job_app_standby_rank">
									<option disabled="disabled"><spring:message code="fap.comp.app_final_stand_by_ranking" /></option>
									<option ng-value="1">1</option>
									<option ng-value="2">2</option>
									<option ng-value="3">3</option>
									<option ng-value="4">4</option>
									<option ng-value="5">5</option>
									<option ng-value="6">6</option>
									<option ng-value="7">7</option>
									<option ng-value="8">8</option>
									<option ng-value="9">9</option>
									<option ng-value="10">10</option>
								</select>
							</div>
						</li>
						<li class="wid8" ng-repeat="missFinalRe in missInfo.missFinalResultMap">
							<div ng-if="missFinalRe.fap_job_app_approval_gb == 'D0801' ">
								<code value="D0700"  ng-if="missFinalRe.fap_job_app_choice_comp_gb == 'D0700' "></code>
								<code value="D0701"  ng-if="missFinalRe.fap_job_app_choice_comp_gb == 'D0701' "></code>
								<code value="D0702"  ng-if="missFinalRe.fap_job_app_choice_comp_gb == 'D0702' "></code>
							</div>
							<div ng-if="missFinalRe.fap_job_app_approval_gb == 'D0800' ">
								<code value="D0700"></code>
							</div>
						</li>
						<li class="wid9" ng-repeat="missFinalResult in missInfo.missFinalResultMap">
							<button type="button" ng-if="missFinalResult.fap_job_app_pass_comment != null && missFinalResult.fap_job_app_pass_comment != '' " infoIndex="{{missInfoIndex}}" ng-click="missUpdatePassComment(missInfoIndex, $event,missFinalResult.fap_job_app_final_rt_seq)" class="btn3 btn-primary"><spring:message code="fap.common.update.btn" /></button>
							<button type="button" ng-if="missFinalResult.fap_job_app_pass_comment == null || missFinalResult.fap_job_app_pass_comment == '' " infoIndex="{{missInfoIndex}}" ng-click="insertPassComment(missInfoIndex, $event,missFinalResult.fap_job_app_final_rt_seq)" class="btn3 btn-primary"><spring:message code="fap.common.join.btn" /></button>
							<div class="pass_comment_div">
								
							</div>
						</li>
					</ul>
					<ul class="peoplemain1" ng-repeat="missFinalCheck in missInfo.missFinalResultMap" ng-if="::missFinalCheck.fap_job_app_final_rt_acp != 'D0000' ">
						<li class="wid1">
							<span class="resume-check">
								<label class="resume-check-label">
								</label>
							</span>
						</li>
						<li class="wid1">
							{{missInfoIndex+1}}
						</li>
					<li class="wid4">
						<div class="screenshot" tooltip="/fap/user/resume_photo_image/{{missInfo.missResumeMap.fap_resume_pic_saved}}">
							<span ng-bind="missInfo.missResumeNmList[2].fap_resume_nm"></span>
							<img class="tooltip-image" alt="photo" src="<c:url value="/resources/segroup/society/fap/images/icon-photo.png" />">
						</div>
						<div ng-if="missInfo.missResumeMap.fap_resume_gender == 'A0000' ">
							<code value="A0000"></code>
						</div>
						<div ng-if="missInfo.missResumeMap.fap_resume_gender == 'A0001' ">
							<code value="A0001"></code>
						</div>
						<div class="user-code" cd="{{missInfo.user_flag}}"></div>
						<div><button type="button" class="resumeButton btn3" value="{{missInfo.missResumeMap.fap_resume_seq}}" id="{{missInfo.user_id}}" ng-click="resumeModal($event)"><spring:message code="fap.common.resume" /></button></div>
					</li>
					<li class="wid6" ng-repeat="missResult in missInfo.missApplyResultMap">
						<select class="app_result_select" ng-model="::missResult.fap_job_app_rt_acp" disabled="disabled">
							<option selectcode value="D0000" selected></option>
							<option selectcode value="D0001"></option>
							<option selectcode value="D0002"></option>
							<option selectcode value="D0003" hidden></option>
						</select>
					</li>
					<li class="wid7" ng-repeat="missFinal in missInfo.missFinalResultMap">
						<select class="final_result_select" ng-model="::missFinal.fap_job_app_final_rt_acp"  onchange="angular.element(this).scope().onChange(this)" disabled="disabled">
							<option selectcode value="D0000" selected></option>
							<option selectcode value="D0001"></option>
							<option selectcode value="D0002"></option>
							<option selectcode value="D0004"></option>
						</select>
						<div class="waiting_list_ranking_div" ng-if="missFinal.fap_job_app_final_rt_acp == 'D0004'">
							<select class="standby_rank" ng-model="::missFinal.fap_job_app_standby_rank" disabled="disabled">
								<option disabled="disabled"><spring:message code="fap.comp.app_final_stand_by_ranking" /></option>
								<option ng-value="1">1</option>
								<option ng-value="2">2</option>
								<option ng-value="3">3</option>
								<option ng-value="4">4</option>
								<option ng-value="5">5</option>
								<option ng-value="6">6</option>
								<option ng-value="7">7</option>
								<option ng-value="8">8</option>
								<option ng-value="9">9</option>
								<option ng-value="10">10</option>
							</select>
						</div>
					</li>
					<li class="wid8" ng-repeat="missFinalRe in missInfo.missFinalResultMap">
						<div ng-if="missFinalRe.fap_job_app_approval_gb == 'D0801' ">
							<code value="D0700"  ng-if="missFinalRe.fap_job_app_choice_comp_gb == 'D0700' "></code>
							<code value="D0701"  ng-if="missFinalRe.fap_job_app_choice_comp_gb == 'D0701' "></code>
							<code value="D0702"  ng-if="missFinalRe.fap_job_app_choice_comp_gb == 'D0702' "></code>
						</div>
						<div ng-if="missFinalRe.fap_job_app_approval_gb == 'D0800' ">
							<code value="D0700"></code>
						</div>
					</li>
					<li class="wid9" ng-repeat="missFinalResult in missInfo.missFinalResultMap">
						<button type="button" ng-if="missFinalResult.fap_job_app_pass_comment != null && missFinalResult.fap_job_app_pass_comment != '' " infoIndex="{{missInfoIndex}}" ng-click="missUpdatePassComment(missInfoIndex, $event ,missFinalResult.fap_job_app_final_rt_seq)" class="btn3 btn-primary"><spring:message code="fap.common.update.btn" /></button>
						<button type="button" ng-if="missFinalResult.fap_job_app_pass_comment == null || missFinalResult.fap_job_app_pass_comment == '' " infoIndex="{{missInfoIndex}}" ng-click="insertPassComment(missInfoIndex, $event ,missFinalResult.fap_job_app_final_rt_seq)" class="btn3 btn-primary"><spring:message code="fap.common.join.btn" /></button>
						<div class="pass_comment_div">
							
						</div>
					</li>
				</ul>
				</div>
			</form>
			<br><br><br><br>
		</div>						
						
		<!-- 불합격자 -->
		<div id="peopleBBS" ng-if="unacceptedApplicantInfo[0] != null">
			<h2><spring:message code="fap.comp.unaccepted_applicant" /></h2>
			<ul class="peopletitle" style="width: 100%;">
				<li class="wid4"><spring:message code="fap.comp.applicant_info" /></li>
				<li class="wid6" ng-repeat="pcs in recruitPcs">
					<code value="C2500" ng-if="pcs.fap_job_recruit_pcs_gb == 'C2500' "></code>
					<code value="C2501" ng-if="pcs.fap_job_recruit_pcs_gb == 'C2501' "></code>
					<code value="C2502" ng-if="pcs.fap_job_recruit_pcs_gb == 'C2502' "></code>
					<code value="C2503" ng-if="pcs.fap_job_recruit_pcs_gb == 'C2503' "></code>
					<code value="C2504" ng-if="pcs.fap_job_recruit_pcs_gb == 'C2504' "></code>
				</li>
				<li class="wid7"><spring:message code="fap.comp.app_final_rt" /></li>
			</ul>
			
			<ul class="peoplemain2" ng-repeat="un_info in unacceptedApplicantInfo" ng-init="un_infoIndex = $index">
				<li class="wid4">
					<div class="screenshot" tooltip="/fap/user/resume_photo_image/{{un_info.unacceptedResumeMap.fap_resume_pic_saved}}">
							<span ng-bind="un_info.unacceptedResumeNmList[2].fap_resume_nm"></span>
							<img class="tooltip-image" alt="photo" src="<c:url value="/resources/segroup/society/fap/images/icon-photo.png" />">
						</div>
					<div ng-if="un_info.unacceptedResumeMap.fap_resume_gender == 'A0000' ">
						<code value="A0000"></code>
					</div>
					<div ng-if="un_info.unacceptedResumeMap.fap_resume_gender == 'A0001' ">
						<code value="A0001"></code>
					</div>
					<div class="user-code" cd="{{un_info.user_flag}}"></div>
					<div><button class="resumeButton btn3" value="{{un_info.unacceptedResumeMap.fap_resume_seq}}" id="{{un_info.user_id}}" ng-click="resumeModal($event)"><spring:message code="fap.common.resume" /></button></div>
				</li>
				<li class="wid6" ng-repeat="un_result in unacceptedApplicantInfo[$index].unacceptedApplyResultMap">
					<select ng-model="::un_result.fap_job_app_rt_acp" disabled="disabled">
						<option selectcode value="D0000"></option>
						<option selectcode value="D0001"></option>
						<option selectcode value="D0002"></option>
						<option selectcode value="D0003" selected></option>
					</select>
				</li>
				<li class="wid7">
					<select disabled="disabled">
						<option selectcode value="D0002" selected></option>
					</select>
				</li>
			</ul>			
		</div>	
			
		<!-- 정규지원자, 미스매칭 지원자, 불합격자가 없는 경우 -->			
		<div ng-if="applicantInfo[0] == null && missApplicantInfo[0] == null && unacceptedApplicantInfo[0] == null">
			<h1><spring:message code="fap.comp.applicant_does_not_exist" /></h1>
		</div>	
			
	</div>
</div>


	<!-- Modal --------------->
  <div class="modal fade" id="myModal" role="dialog">
    <div class="modal-dialog" style="max-width: 1200px;">
      <!-- Modal content------------------------->
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal">&times;</button>
          <h4 class="modal-title" id="title"></h4>
        </div>
        <div class="modal-body">
        	<div class="resume_wrap">
				<div class="resume_sub">
				
					<div class="userjoinBox">
						<div id="sub3_bbs2" class="basic_top">
							<h2><spring:message code="fap.resume.user_info" /></h2>
							<ul class="tit1">
								<li class="photo">
									<img alt="" ng-src="/fap/user/resume_photo_image/{{resumeApply.fap_resume_pic_saved}}">
								</li>
							</ul>
							<ul class="tit2 first">
								<li class="wid1"><code value="B3100"></code></li>
								<li class="wid2">
									<span ng-bind="resumeApply.resumeNameList[0].fap_resume_nm"></span>
								</li>
								<li class="wid3"><spring:message code="fap.resume.user_nationality" /></li>
								<li class="wid4">
									<span ng-bind="resumeApply.fap_resume_nationality"></span>
								</li>
							</ul>
							<ul class="tit2">
								<li class="wid1"><code value="B3102"></code></li>
								<li class="wid2">
									<span ng-bind="resumeApply.resumeNameList[2].fap_resume_nm"></span>
								</li>
								<li class="wid3"><code value="B3103"></code></li>
								<li class="wid4">
									<span ng-bind="resumeApply.resumeNameList[3].fap_resume_nm"></span>
								</li>						
							</ul>
							<ul class="tit2">
								<li class="wid1"><code value="B3101"></code></li>
								<li class="wid2">
									<span ng-bind="resumeApply.resumeNameList[1].fap_resume_nm"></span>
								</li>
								<li class="wid3"><spring:message code="fap.resume.user_dependent" /></li>
								<li class="wid4">
									<span ng-bind="resumeApply.fap_resume_dependents"></span><spring:message code="com.placeholder.people" />
								</li>						
							</ul>
						</div>
						<div id="sub3_bbs2">
							<ul class="tit3">
								<li class="wid1"><spring:message code="fap.resume.user_birth" /></li>
								<li class="wid2_birth">
									<span ng-bind="resumeApply.fap_resume_birth.substr(0,4)"></span><spring:message code="com.placeholder.year" />
								</li>
								<li class="wid2_birth">
									<span ng-bind="resumeApply.fap_resume_birth.substr(5,2)"></span><spring:message code="com.placeholder.month" />
								</li>
								<li class="wid2_birth"> 
									<span ng-bind="resumeApply.fap_resume_birth.substr(8,2)"></span><spring:message code="com.placeholder.day" />
								</li>
							</ul>
							<ul class="tit3">
								<li class="wid1"><spring:message code="fap.resume.user_address" /></li>
								<li class="wid2 resumeAddr" ng-repeat="addr in resumeApply.resumeAddrList">	
									<span ng-bind="addr.fap_resume_address"></span>
								</li>
							</ul>
							<ul class="tit3">
								<li class="wid1"><spring:message code="fap.resume.user_gender" /></li>
								<li class="wid2">
									<div class="span-code" cd="{{resumeApply.fap_resume_gender}}"></div>
								</li>
							</ul>
							<ul class="tit3">
								<li class="wid1"><spring:message code="fap.resume.user_married_or_not" /></li>
								<li class="wid2">
									<div class="span-code" cd="{{resumeApply.fap_resume_marital}}"></div>
								</li>
							</ul>
						</div><!-- <div id="sub3_bbs2"> -->
					</div> <!-- <div id="userjoinBox"> -->		
		
					<!-- ------------------------------------기본정보---------------------------------------------->
					<div class="userjoinBox">
						<h2><spring:message code="fap.resume.edu_history" /></h2>
						<div class="sub3_bbs3 resume_edu" ng-repeat="eduHistory in resumeApply.resumeEduList">
							<ul class="tit2 title">
								<li class="wid1"><spring:message code="fap.resume.edu_entrance" /></li>
								<li class="wid2"><spring:message code="fap.resume.edu_graduation" /></li>
								<li class="wid3"><spring:message code="fap.resume.edu_period" /></li>
								<li class="wid4"><spring:message code="fap.resume.edu_graduated_or_not" /></li>
							</ul>
							<ul class="tit2">
								<li class="wid1">
									<span ng-bind="eduHistory.fap_resume_edu_er_dt"></span>
								</li>
								<li class="wid2">
									<span ng-bind="eduHistory.fap_resume_edu_gd_dt"></span>
								</li>
								<li class="wid3">
									<span ng-bind="eduHistory.fap_resume_edu_pd_summary"></span>
								</li>
								<li class="wid4">
									<div class="span-code" cd="{{eduHistory.fap_resume_edu_gd_ck}}"></div>
								</li>
							</ul>
							<ul class="tit3">
								<li class="wid1"><spring:message code="fap.resume.edu_school_nm" /></li>
								<li class="wid2">
									<span ng-bind="eduHistory.fap_resume_edu_sc_nm"></span>
								</li>
							</ul>
							<ul class="tit3">
								<li class="wid1"><spring:message code="fap.resume.edu_curriculum" /></li>
								<li class="wid2">
									<span ng-bind="eduHistory.fap_resume_edu_coll"></span>
								</li>					
							</ul>
							<ul class="tit3">
								<li class="wid1"><spring:message code="fap.resume.edu_major_field" /></li>
								<li class="wid2">
									<div class="span-code" cd="{{eduHistory.fap_resume_edu_field}}"></div>
								</li>					
							</ul>
							<ul class="tit3">
								<li class="wid1"><spring:message code="fap.resume.edu_major_nm" /></li>
								<li class="wid2">
									<span ng-bind="eduHistory.fap_resume_edu_major"></span>
								</li>					
							</ul>
							<ul class="tit3">
								<li class="wid1"><spring:message code="fap.resume.edu_remarks" /></li>
								<li class="wid2 textarea">
									<textarea class="readonly_textarea" ng-bind="eduHistory.fap_resume_edu_note" readonly="readonly"></textarea>
								</li>
							</ul>					
						</div><!-- <div id="sub3_bbs3"> -->
					</div><!-- <div id="userjoinBox"> -->
					<!-- ------------------------------------학력관련 교육이수 ---------------------------------------------->
					<div class="userjoinBox">
						<h2><spring:message code="fap.resume.career" /></h2>
						<div class="sub3_bbs3 resume_crr" ng-repeat ="career in resumeApply.resumeCareerList">
							<ul class="tit2 title">
								<li class="wid1"><spring:message code="fap.resume.career_service_start_day" /></li>
								<li class="wid2"><spring:message code="fap.resume.career_service_completion_day" /></li>
								<li class="wid3"><spring:message code="fap.resume.edu_period" /></li>
								<li class="wid4"><spring:message code="fap.resume.career_position" /></li>
							</ul>
							<ul class="tit2">
								<li class="wid1">
									<span ng-bind="career.fap_resume_crr_st"></span>
								</li>
								<li class="wid2">
									<span ng-bind="career.fap_resume_crr_et"></span>
								</li>
								<li class="wid3">
									<span ng-bind="career.fap_resume_crr_pd_summary"></span>
								</li>
								<li class="wid4">
									<span ng-bind="career.fap_resume_crr_job_position"></span>
								</li>
							</ul>
							<ul class="tit3">
								<li class="wid1"><spring:message code="fap.resume.career_comp_nm" /></li>
								<li class="wid2">
									<span ng-bind="career.fap_resume_crr_comp_nm"></span>
								</li>
							</ul>
							<ul class="tit3">
								<li class="wid1"><spring:message code="fap.resume.career_comp_major_business" /></li>
								<li class="wid2">
									<span ng-bind="career.fap_resume_crr_major_bussiness"></span>
								</li>					
							</ul>
							<ul class="tit3">
								<li class="wid1"><spring:message code="fap.resume.career_field" /></li>
								<li class="wid2">
									<div class="span-code" cd="{{career.fap_resume_crr_gb}}"></div>
								</li>					
							</ul>
							<ul class="tit3">
								<li class="wid1"><spring:message code="fap.resume.career_responsibility" /></li>
								<li class="wid2 textarea">
									<textarea class="readonly_textarea" ng-bind="career.fap_resume_crr_job_function" readonly="readonly"></textarea>
								</li>
							</ul>					
						</div>
					</div>	
					<!-- ------------------------------------사회 경력 ---------------------------------------------->
					<div class="userjoinBox">
						<h2><spring:message code="fap.resume.certification" /></h2>
						<div class="sub3_bbs3 resume_license" ng-repeat="license in resumeApply.resumeLicenseList">
							<ul class="tit2 title">
								<li class="wid1"><spring:message code="fap.resume.certification_license" /></li>
								<li class="wid2"><spring:message code="fap.resume.certification_obtained_year" /></li>
								<li class="wid3"><spring:message code="fap.resume.certification_obtained_month" /></li>
								<li class="wid4"><spring:message code="fap.resume.certification_issuing_organization" /></li>
							</ul>
							<ul class="tit2">
								<li class="wid1">
									<div class="span-code" cd="{{license.fap_resume_license_nm}}"></div>
								</li>
								<li class="wid2">
									<span ng-bind="license.fap_resume_license_get_year"></span>
								</li>
								<li class="wid3">
									<span ng-bind="license.fap_resume_license_get_month"></span>
								</li>
								<li class="wid4">
									<span ng-bind="license.fap_resume_license_issuing_organization"></span>
								</li>
							</ul>
							<ul class="tit3">
								<li class="wid1"><spring:message code="fap.resume.certification_score" /></li>
								<li class="wid2">
									<span ng-bind="license.fap_resume_license_score"></span>
								</li>
							</ul>
							<ul class="tit3">
								<li class="wid1"><spring:message code="fap.resume.certification_remarks" /></li>
								<li class="wid2 textarea">
									<textarea class="readonly_textarea" ng-bind="license.fap_resume_license_note" readonly="readonly"></textarea>
								</li>
							</ul>					
						</div><!-- <div id="sub3_bbs3"> -->
					</div>
					<!-- ----------------------------자격(기술 및 외국어 역량 중심) --------------------------------------------->
					<div class="userjoinBox">
						<h2><spring:message code="fap.resume.talent" /></h2>
						<div class="sub3_bbs7 resume_talent" ng-repeat="talent in resumeApply.resumeTalentList">
							<ul class="tit2">
								<li class="wid1"><spring:message code="fap.resume.talent_number" /></li>
								<li class="wid2"><spring:message code="fap.resume.talent_context" /></li>
							</ul>
							<ul class="tit3">
								<li class="wid1">{{$index+1}}</li>
								<li class="wid2 textarea">
									<textarea class="readonly_textarea_talent" ng-bind="talent.fap_resume_talent_content" readonly="readonly"></textarea>
								</li>
							</ul>				
						</div><!-- <div id="sub3_bbs7"> -->
					</div><!-- <div id="userjoinBox"> -->				
					<!-- ----------------------------역량/재능(ICT, 외국어, 인간관계 등 업무 관련 상세) --------------------------------------------->
					<div class="userjoinBox">
						<h2><spring:message code="fap.resume.project_development_career" /></h2>
						<div class="sub3_bbs3 resume_project" ng-repeat="project in resumeApply.resumeProjectList">
							<ul class="tit2 title">
								<li class="wid1"><spring:message code="fap.resume.project_development_start_date" /></li>
								<li class="wid2"><spring:message code="fap.resume.project_development_end_date" /></li>
								<li class="wid3"><spring:message code="fap.resume.edu_period" /></li>
								<li class="wid4"><spring:message code="fap.resume.project_development_member" /></li>
							</ul>
							<ul class="tit2">
								<li class="wid1">
									<span ng-bind="project.fap_resume_project_st"></span>
								</li>
								<li class="wid2">
									<span ng-bind="project.fap_resume_project_et"></span>
								</li>
								<li class="wid3">
									<span ng-bind="project.fap_resume_project_pd_summary"></span>
								</li>
								<li class="wid4">
									<span ng-bind="project.fap_resume_project_peoples_num"></span>
									<spring:message code="com.placeholder.people" />
								</li>
							</ul>
							<ul class="tit3">
								<li class="wid1"><spring:message code="fap.resume.project_nm" /></li>
								<li class="wid2">
									<span ng-bind="project.fap_resume_project_nm"></span>
								</li>
							</ul>
							<ul class="tit3">
								<li class="wid1"><spring:message code="fap.resume.project_main_service" /></li>
								<li class="wid2 textarea">
									<textarea class="readonly_textarea" ng-bind="project.fap_resume_project_service" readonly="readonly"></textarea>
								</li>					
							</ul>
							<ul class="tit3">
								<li class="wid1"><spring:message code="fap.resume.project_charge_filed" /></li>
								<li class="wid2 textarea">
									<textarea class="readonly_textarea" ng-bind="project.fap_resume_project_responsibility" readonly="readonly"></textarea>
								</li>
							</ul>
							<ul class="tit3">
								<li class="wid1"><spring:message code="fap.resume.project_used_technique" /></li>
								<li class="wid2 textarea">
									<textarea class="readonly_textarea" ng-bind="project.fap_resume_project_technique" readonly="readonly"></textarea>
								</li>
							</ul>					
						</div><!-- <div id="sub3_bbs3"> -->
					</div>		
					<!-- ----------------------------SW 프로젝트 개발경력 --------------------------------------------->
					<div class="userjoinBox">
						<h2><spring:message code="fap.resume.self_introduction" /></h2>
						<div class="sub3_bbs8">
							<ul class="tit2">
								<li class="wid1">
									<code value="B4100"></code>
								</li>					
							</ul>
							<ul class="tit3">
								<li class="wid1 textarea">
									<textarea class="readonly_textarea_pr" ng-bind="resumeApply.resumeProfileList[0].fap_resume_pr_content" readonly="readonly"></textarea>
								</li>						
							</ul>
							<ul class="tit2">
								<li class="wid1">
									<code value="B4101"></code>
								</li>					
							</ul>
							<ul class="tit3">
								<li class="wid1">
									<textarea class="readonly_textarea_pr" ng-bind="resumeApply.resumeProfileList[1].fap_resume_pr_content" readonly="readonly"></textarea>
								</li>						
							</ul>
							<ul class="tit2">
								<li class="wid1">
									<code value="B4102"></code>
								</li>				
							</ul>
							<ul class="tit3">
								<li class="wid1">
									<textarea class="readonly_textarea_pr" ng-bind="resumeApply.resumeProfileList[2].fap_resume_pr_content" readonly="readonly"></textarea>
								</li>						
							</ul>
						</div> <!-- <div id="sub3_bbs8"> -->
					</div><!-- <div id="userjoinBox"> -->				
					<!-- ----------------------------------------------자기소개서----------- --------------------------------------------->
					<div class="userjoinBox">
						<h2><spring:message code="fap.resume.self_introduction_video_portfolio" /></h2>
						<div id="sub3_bbs9">
							<ul class="tit2 resumeFile" ng-switch="!!resumeApply.resumeFileList[0].fap_resume_file_origin">
								<li class="wid1"><spring:message code="fap.resume.self_introduction_file" /></li>	
								<li class="wid2" ng-switch-when="true">
									<a class="display-inline" ng-href="/file_download?origin={{resumeApply.resumeFileList[0].fap_resume_file_origin}}&saved={{resumeApply.resumeFileList[0].fap_resume_file_saved}}&path=/fap/user/resume_movie_file">
										{{resumeApply.resumeFileList[0].fap_resume_file_origin}}
									</a>
								</li>
							</ul>
							<ul class="tit2 resumeFile" ng-switch="!!resumeApply.resumeFileList[1].fap_resume_file_origin">
								<li class="wid1"></li>
								<li class="wid2" ng-switch-when="true">
									<a class="display-inline" ng-href="/file_download?origin={{resumeApply.resumeFileList[1].fap_resume_file_origin}}&saved={{resumeApply.resumeFileList[1].fap_resume_file_saved}}&path=/fap/user/resume_portfolio_file">
										{{resumeApply.resumeFileList[1].fap_resume_file_origin}}
									</a>
								</li>
							</ul>	
							<ul class="tit2 resumeFile" ng-switch="!!resumeApply.resumeFileList[2].fap_resume_file_origin">
								<li class="wid1"></li>	
								<li class="wid2" ng-switch-when="true">
									<a class="display-inline" ng-href="/file_download?origin={{resumeApply.resumeFileList[2].fap_resume_file_origin}}&saved={{resumeApply.resumeFileList[2].fap_resume_file_saved}}&path=/fap/user/resume_project_file">
										{{resumeApply.resumeFileList[2].fap_resume_file_origin}}
									</a>
								</li>
							</ul>	
							<ul class="tit2">
								<li class="wid1"><spring:message code="fap.resume.self_introduction_url" /></li>
								<li class="wid2">
									<a href="{{resumeApply.fap_resume_url}}" target="_blank">{{resumeApply.fap_resume_url}}</a>
								</li>
							</ul>		
						</div> <!-- <div id="sub3_bbs9"> -->
					</div><!-- <div id="userjoinBox"> -->				
					<!-- ----------------------------------------------개인 동영상 및 포트폴리오 파일----------- --------------------------------------------->
				</div>
				</div>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        </div>
      </div>
    </div>
  </div>  
  <!-- end of Resume Modal -->
<%@include file="agency_footer.jsp"%>

<form action="/fap/agency/applicant_resume_print_form" method="post" name="resume_popup" id="resume_popup">
	
</form>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
	<%-- <link rel="stylesheet" type="text/css" href="<c:url value="/resources/segroup/society/fap/css/default.css" />" /> --%>
	<link type="text/css" rel="stylesheet" href="/resources/segroup/css/jquery.timepicker.css" media="" />
	<link type="text/css" rel="stylesheet" href="<c:url value="/resources/segroup/society/fap/css/layer.css" />" media="" />
	<link type="text/css" rel="stylesheet" href="<c:url value="/resources/segroup/society/fap/css/calendar.css" />" media="" />
	<script src="<c:url value="/resources/segroup/js/jquery-3.1.1.js" />"></script>
	<script src="<c:url value="/resources/segroup/js/jquery-ui.js" />"></script>
	<script src="<c:url value="/resources/segroup/js/angular.min.js" />"></script>
	<script src="<c:url value="/resources/segroup/js/datepicker.js" />"></script>
	<script type="text/javascript" src="/resources/segroup/js/jquery.timepicker.min.js"></script>
	<script src="<c:url value="/resources/segroup/society/fap/js/calendar.js" />"></script>
	<script src="<c:url value="/resources/segroup/js/timepicker.js" />"></script>
	<script src="<c:url value="/resources/segroup/society/fap/js/layer.js" />"></script>
	<title>Bridge Job Fair</title>
<script type="text/javascript">
	
	$(function(){
		
		$(".list-close").on("click",function(){
			$(".list-wran").html("");
			$("#admin-schedule-type option:eq(0)").prop("selected",true);
			$("#admin-schedule-time option:eq(0)").prop("selected",true);
		});
	});

	var myApp = angular.module('myapp', []);
	
	myApp.controller('TokyoFairController', ['$scope','$compile','$http', function($scope,$compile,$http){
		
		var tokyofairDateJson = '${tokyofairSetMap.tokyofairDate}';
		tokyofairDateJson = tokyofairDateJson.replace(/(?:\r\n|\r|\n)/g, '\\r\\n');
	    var tokyofairDate = JSON.parse(tokyofairDateJson);
	    $scope.tokyofairDate = tokyofairDate;
	    
	    var tokyofairSetJson = '${tokyofairSetMap.tokyofairSet}';
	    tokyofairSetJson = tokyofairSetJson.replace(/(?:\r\n|\r|\n)/g, '\\r\\n');
	    var tokyofairSet = JSON.parse(tokyofairSetJson);
	    $scope.tokyofairSet = tokyofairSet;
	    
	    var tokyofairSchJson = '${tokyofairSetMap.tokyofairSch}';
	    tokyofairSchJson = tokyofairSchJson.replace(/(?:\r\n|\r|\n)/g, '\\r\\n');
	    var tokyofairSch = JSON.parse(tokyofairSchJson);
	    $scope.tokyofairSch = tokyofairSch;
	    
	    $("#fap_tokyofair_date_dt").val(tokyofairSet.fap_jobfair_set_st);
	    
	    
	    var day = null;
	   
	    var time_st = parseInt($scope.tokyofairSet.fap_jobfair_set_room_st.substring(0,2));
		var time_et = parseInt($scope.tokyofairSet.fap_jobfair_set_room_et.substring(0,2));
		
		var caltest = $(".tokyofairSchedule").PACalendar({
		   	startDate : $scope.tokyofairSet.fap_jobfair_set_st,
		   	endDate : $scope.tokyofairSet.fap_jobfair_set_et,
		   	startTime : time_st,
		   	endTime : time_et,
		   	printFlag : false,
		   	roomCount : $scope.tokyofairSet.fap_jobfair_set_room_cnt,
		   	btnAttrs : {
		   		left : {
		   			'class' : "btn_left",
		   			'value' : ""
		   		},
		   		right : {
		   			'class' : "btn_right",
		   			'value' : ""
		   		},
				print : {
					'class' : "btn_print",
					'value' : ""
				}
		   	},
		   	messages : {
				roomName : "<spring:message code='fap.tokyofair.schedule.calendar.room' />",
				leftOver : "<spring:message code='fap.tokyofair.schedule.calendar.left' />",
				rightOver : "<spring:message code='fap.tokyofair.schedule.calendar.right' />"
			}
		});
		
		$(".btn_left").on("click",function(){
			var fap_tokyofair_date_dt = $(".calendar_table.on").find(".scheduleTitle").html();
			$("#fap_tokyofair_date_dt").val(fap_tokyofair_date_dt);
			$scope.reloadSchedule();
		});
		
		$(".btn_right").on("click",function(){
			var fap_tokyofair_date_dt = $(".calendar_table.on").find(".scheduleTitle").html();
			$("#fap_tokyofair_date_dt").val(fap_tokyofair_date_dt);
			$scope.reloadSchedule();
		});
		
		$(".btn_print").on("click",function(){
			
		});
		
		$(".c_td").off().on("click",function(index,item){
			
			$elm = $(this);
			//관리자 일정
			if($elm.hasClass("disabled")) return;
			//본인기업 일정
			if($elm.hasClass("merged")) {
				
				if($elm.attr("fap_tokyofair_screening_gb") == 'E0502' || $elm.attr("fap_tokyofair_screening_gb") == 'E0503'){
					$scope.delete_schedule_member();
				}else{
					return;
				}
			}else{
				$scope.screening_callback();
			}
			
		});
		
		$scope.screening_callback = function(){
			var room = $elm.attr("room");
			var st = $elm.attr("time");
			var day = $elm.attr("day");
			
			$(".c_td").removeClass("ck");
			$(this).addClass("ck");
			
			var fap_jobfair_divide_seq = $("#fap_jobfair_divide_seq").val();
			
			$http({
				method : 'POST',
				url : '/fap/admin/tokyofair_screening_search_bookable',
				params : {
					fap_jobfair_divide_seq: fap_jobfair_divide_seq
				},
				headers : {
					"AJAX" : true
				}
			}).then(function successCallback(response) {
				console.log(response);
				
				$(".layer-header .member-header").html("추가 전형 등록");
				var context = '';
				$.each(response.data, function(index,item){
					context +='<div class="check-wrap">';
					context += '<div class="check-line" title="['+item.fap_comp_en_nm+'] '+item.fap_job_ad_title+'">';
					context += '<input type="radio" class="job-ad-check" name="job-ad-radio" value="'+item.fap_job_ad_seq+'" comp_id="'+item.fap_comp_id+'">';
					context += ' ['+item.fap_comp_en_nm+']';
					context += ' '+item.fap_job_ad_title;
					context +='</div>';
					context +='<div class="job-ad-line">';
					context +='<a href="javascript:void(0);" class="job-ad-detail">채용공고 보기</a>';
					context +='</div>';
					context +='</div>';
				});
				
				$(".layer-message .member-message").html(context);
				
				layer_popup("#schedule_member_layer");
			}, function errorCallback(response) {
				if(response.status == 403){
					alert('<spring:message code="com.login.ajaxSesstion" javaScriptEscape="true" />');
					location.href = "/fap/admin/admin_login";
				}
			});
		}
		
		$(".c_td").hover(
			function(){
				$(this).prevAll("td:first-child").addClass("th_hover");
		}, function(){
				$(this).prevAll("td:first-child").removeClass("th_hover");
		});
		
		//관리자 일정 그리기
		 $.each(tokyofairDate.tokyofairScheduleDateList, function(index, item){
	    	if(item.fap_jobfair_set_date_room_hid_gb == 'E0201'){
		    	$("." + item.fap_jobfair_set_date_dt).find(".room[num="+item.fap_jobfair_set_date_room_num+"]").find(".room_ck").prop("checked",true);
	    	}
	    	
	    	$.each(item.tokyofairScheduleTimeList,function(){
	    		var eq = $("." + item.fap_jobfair_set_date_dt).find(".room[num="+item.fap_jobfair_set_date_room_num+"]").index();
		    	var _target = $("." + item.fap_jobfair_set_date_dt).find('tbody tr').find('td:eq('+eq+')[time="'+this.fap_jobfair_set_time+'"]');
		    	
		    	var rowSpan = this.fap_jobfair_set_time_merge_num;
		    	_target.attr("rowSpan",rowSpan);
		    	
		    	_target.closest(".day-list").nextAll().each(function(index2,item2){
					if(index2 < rowSpan-1){
						$(this).find("td").eq(item.fap_jobfair_set_date_room_num).addClass("hidden");
					}else{
						return;
					}
				})
				_target.addClass("merged disabled");
		    	_target.html(this.fap_jobfair_set_time_ct);
				
	    	});
	    	
	    });
		 $scope.insert_schedule_member = function(){
			 var fap_job_ad_seq = $("#fap_job_ad_seq").val();
			 var comp_id = $("#comp_id").val();
			 var fap_tokyofair_screening_gb = $("#admin-schedule-type").val();
			 var fap_tokyofair_screening_nm = $("#admin-schedule-type option:selected").text();
			 var fap_tokyofair_screening_time = $("#admin-schedule-time").val();
			 var fap_jobfair_set_seq = $scope.tokyofairSet.fap_jobfair_set_seq;
			 var fap_tokyofair_date_dt = $elm.attr("day");;
			 var fap_tokyofair_date_room_num = $elm.attr("room");
			 var fap_tokyofair_schedule_st = $elm.attr("time");
			 
			 
			 var merge_st = parseInt(fap_tokyofair_schedule_st.substring(0,2));
			 var merge_sm = parseInt(fap_tokyofair_schedule_st.substring(3));
			 var merge_date = new Date(0,0,0,merge_st,merge_sm);
			 
		 	 merge_date.setMinutes(merge_date.getMinutes() + parseInt(fap_tokyofair_screening_time));
		 	 
			 var mergeLength = fap_tokyofair_screening_time / 10; 
			 var fap_tokyofair_schedule_et = merge_date.format("HH:mm");
			 
			 if(fap_tokyofair_screening_gb == 0){
				 alert("전형을 선택해 주세요");
				 return false;
			 }
			 
			 if(fap_tokyofair_screening_time == 0){
				 alert("시간을 선택해 주세요");
				 return false;
			 }
			 
			 var scheduleMap = {};
			 scheduleMap['fap_job_ad_seq'] = fap_job_ad_seq;
			 scheduleMap['comp_id'] = comp_id;
			 scheduleMap['fap_tokyofair_screening_gb'] = fap_tokyofair_screening_gb;
			 scheduleMap['fap_tokyofair_screening_nm'] = fap_tokyofair_screening_nm;
			 scheduleMap['fap_tokyofair_screening_time'] = fap_tokyofair_screening_time;
			 scheduleMap['fap_jobfair_set_seq'] = fap_jobfair_set_seq;
			 scheduleMap['fap_tokyofair_date_dt'] = fap_tokyofair_date_dt;
			 scheduleMap['fap_tokyofair_date_room_num'] = fap_tokyofair_date_room_num;
			 scheduleMap['fap_tokyofair_schedule_st'] = fap_tokyofair_schedule_st;
			 scheduleMap['fap_tokyofair_schedule_et'] = fap_tokyofair_schedule_et;
			 scheduleMap['fap_tokyofair_schedule_merge'] = mergeLength;
			 scheduleMap['fap_jobfair_itv_stu_dt'] = $scope.tokyofairSet.fap_jobfair_set_itv_stu_dt;
			 
			 $http({
					method : 'POST',
					url : '/fap/admin/tokyofair_schedule_admin_insert',
					headers: {'Content-Type': 'application/json'},
					data: JSON.stringify(scheduleMap),
					XMLHttpRequestResponseType: 'json',
					headers : {
						"AJAX" : true
					}
				}).then(function successCallback(response) {
					
					var _data = response.data;
					
					if(!_data.flag){
						$(".list-wran").html("일정이 중복됩니다. 다른일정을 선택해 주세요");
						return;
					}else if(_data.duplicateList.length != 0){
						
						var context = '';
						$.each(_data.duplicateList, function(index,item){
							context += '<span class="blue">';
							context += ' '+item.fap_resume_nm+'('+item.fap_resume_birth+') ';
							context += '</span>';
							if(index%3 == 2) context += '<br>';
						});
						context += '<br><spring:message code="fap.tokyofair.schedule.bookable.dupulicate.reason2" />';
						$(".list-wran").html(context);
						return;
					}else{
						layer_close("#schedule_list_layer");
						
						$(".list-wran").html("");
						$("#admin-schedule-type option:eq(0)").prop("selected",true);
						$("#admin-schedule-time option:eq(0)").prop("selected",true);
						
						$scope.reloadSchedule();
					}
					
				}, function errorCallback(response) {
					if(response.status == 403){
						alert('<spring:message code="com.login.ajaxSesstion" javaScriptEscape="true" />');
						location.href = "/fap/admin/admin_login";
					}
				});
		 }
		 
		 $scope.select_schedule_detail = function(){
			 layer_close("#schedule_member_layer");
			 var fap_job_ad_seq = $(':input:radio[name="job-ad-radio"]:checked').val();
			 var comp_id = $(':input:radio[name="job-ad-radio"]:checked').attr("comp_id");
			 
			 $("#fap_job_ad_seq").val(fap_job_ad_seq);
			 $("#comp_id").val(comp_id);
			 layer_popup("#schedule_list_layer");
		 };
		 
		 $scope.delete_schedule_member = function(){
			
			$(".confirm-header").html('<spring:message code="fap.tokyofair.schedule.bookable.confirm.delete.title" />');
			$(".confirm-message").html('<spring:message code="fap.tokyofair.schedule.bookable.confirm.delete.message" />');
			
			confirm_popup("#schedule_confirm_layer", function(){
				 var fap_tokyofair_screening_seq = $elm.find(".merged-comp-nm").attr("seq");
				
				 $http({
					method : 'POST',
					url : '/fap/admin/tokyofair_screening_delete',
					params : {
						fap_tokyofair_screening_seq : fap_tokyofair_screening_seq
					},
					headers : {
						"AJAX" : true
					}
				}).then(function successCallback(response) {
					 window.location.reload();
					 
				}, function errorCallback(response) {
					if(response.status == 403){
						alert('<spring:message code="com.login.ajaxSesstion" javaScriptEscape="true" />');
						location.href = "/fap/admin/admin_login";
					}
				});
			});
		 }
		 
		 $scope.reloadSchedule = function(){
			 var fap_jobfair_set_seq = $scope.tokyofairSet.fap_jobfair_set_seq;
			 var fap_tokyofair_date_dt = $("#fap_tokyofair_date_dt").val();
			 
			 var reloadMap = {};
			 reloadMap['fap_jobfair_set_seq'] = fap_jobfair_set_seq;
			 reloadMap['fap_tokyofair_date_dt'] = fap_tokyofair_date_dt;
			 
			 $http({
					method : 'POST',
					url : '/fap/admin/tokyofair_schedule_reload',
					headers: {'Content-Type': 'application/json'},
					data: JSON.stringify(reloadMap),
					XMLHttpRequestResponseType: 'json',
					headers : {
						"AJAX" : true
					}
				}).then(function successCallback(response) {
					
					$scope.drawSchedule(response.data);
					
				}, function errorCallback(response) {
					if(response.status == 403){
						alert('<spring:message code="com.login.ajaxSesstion" javaScriptEscape="true" />');
						location.href = "/fap/company/company_login";
					}
				});
		 }
		 
		 $scope.drawSchedule = function(tokyofairSch){
			 
			 $.each(tokyofairSch, function(index,item){
				 var fap_comp_id = $("#fap_comp_id").val();
				 var eq = $("."+item.fap_tokyofair_date_dt).find(".room[num="+item.fap_tokyofair_date_room_num+"]").index();
				 var _target = $("."+item.fap_tokyofair_date_dt).find('tbody tr').find('td:eq('+eq+')[time="'+item.fap_tokyofair_schedule_st+'"]');
				 
				 var rowSpan = item.fap_tokyofair_schedule_merge;
				 _target.attr("rowSpan",rowSpan);
				 
				 _target.closest(".day-list").nextAll().each(function(index2,item2){
					if(index2 < rowSpan-1){
						$(this).find("td").eq(item.fap_tokyofair_date_room_num).addClass("hidden");
					}else{
						return;
					}
				})
				
				console.log(tokyofairSch);
				
				_target.addClass("merged");
				_target.attr("fap_tokyofair_screening_gb",item.fap_tokyofair_screening_gb);
				//개별면접
				if(item.fap_tokyofair_screening_gb == 'E0500'){
					var context = '<div class="merged-comp-head">';
					context += '<div class="merged-comp-nm" title="'+item.fap_comp_en_nm+'">';
					context += item.fap_comp_en_nm;
					context += '</div>';
					context += '<div class="merged-comp-screening-nm" title="'+item.fap_tokyofair_screening_nm+'">';
					context += item.fap_tokyofair_screening_nm;
					context += '</div>';
					context += '</div>';
					context += '<div class="merged-comp-body">';
					$.each(item.tokyoMemberList, function(index2,item2){
						context += '<div class="merged-user-nm">';
						context += '<p>';
						context += item2.fap_tokyofair_member_st+'~'+item2.fap_tokyofair_member_et;
						context += '</p>';
						context += '<p title="'+item2.user_birth+'">';
						context += item2.user_nm;
						context += '</p>';
						context += '</div>';
					});
					context += '</div>';
				}
				//그룹면접
				else if(item.fap_tokyofair_screening_gb == 'E0501'){
					var context = '<div class="merged-comp-head">';
					context += '<div class="merged-comp-nm" title="'+item.fap_comp_en_nm+'">';
					context += item.fap_comp_en_nm;
					context += '</div>';
					context += '<div class="merged-comp-screening-nm" title="'+item.fap_tokyofair_screening_nm+'">';
					context += item.fap_tokyofair_screening_nm;
					context += '</div>';
					context += '</div>';
					context += '<div class="merged-comp-body">';
					$.each(item.tokyoMemberList, function(index2,item2){
						context += '<div class="merged-user-nm">';
						if(index2%item.fap_tokyofair_screening_user_num == 0){
							context += '<p>';
							context += item2.fap_tokyofair_member_st+'~'+item2.fap_tokyofair_member_et;
							context += '</p>';
						}
						context += '<p title="'+item2.user_birth+'">';
						context += item2.user_nm;
						context += '</p>';
						context += '</div>';
					});
					context += '</div>';
				}
				//설명회
				else if(item.fap_tokyofair_screening_gb == 'E0502'){
					var context = '<div class="merged-comp-head">';
					context += '<div class="merged-comp-nm" title="'+item.fap_comp_en_nm+'" seq="'+item.fap_tokyofair_screening_seq+'">';
					context += item.fap_comp_en_nm;
					context += '</div>';
					context += '<div class="merfed-comp-screening-nm" title="'+item.fap_tokyofair_screening_nm+'">';
					context += item.fap_tokyofair_screening_nm;
					context += '</div>';
					context += '</div>';
					context += '<div class="merged-comp-body">';
					$.each(item.tokyoMemberList, function(index2,item2){
						context += '<div class="merged-user-nm">';
						if(index2 == 0){
							context += '<p>';
							context += item2.fap_tokyofair_member_st+'~'+item2.fap_tokyofair_member_et;
							context += '</p>';
						}
						context += '<p title="'+item2.user_birth+'">';
						context += item2.user_nm;
						context += '</p>';
						context += '</div>';
					});
					context += '</div>';
				}
				//시험
				else if(item.fap_tokyofair_screening_gb == 'E0503'){
					var context = '<div class="merged-comp-head">';
					context += '<div class="merged-comp-nm" title="'+item.fap_comp_en_nm+'" seq="'+item.fap_tokyofair_screening_seq+'">';
					context += item.fap_comp_en_nm;
					context += '</div>';
					context += '<div class="merfed-comp-screening-nm" title="'+item.fap_tokyofair_screening_nm+'">';
					context += item.fap_tokyofair_screening_nm;
					context += '</div>';
					context += '</div>';
					context += '<div class="merged-comp-body">';
					$.each(item.tokyoMemberList, function(index2,item2){
						context += '<div class="merged-user-nm">';
						if(index2 == 0){
							context += '<p>';
							context += item2.fap_tokyofair_member_st+'~'+item2.fap_tokyofair_member_et;
							context += '</p>';
						}
						context += '<p title="'+item2.user_birth+'">';
						context += item2.user_nm;
						context += '</p>';
						context += '</div>';
					});
					context += '</div>';
				}
				
		    	_target.html(context);
				 
			 });
		 }

		 //등록된 일정 그리기
		 $scope.drawSchedule($scope.tokyofairSch);
		 
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
	function printWindow() {
		window.print();
	}
</script>
<style type="text/css" media="print">
@page {
	size: A3; /* auto is the initial value */
	margin: 10mm; /* this affects the margin in the printer settings */
}

html {
	margin: 0px;
}

body {
	margin: 0mm; /* margin you want for the content */
}
.printBtn {
	display: none !important;
}
</style>
</head>
<body  ng-app="myapp" ng-controller="TokyoFairController">
<div style="display: block; position: fixed; top: 1px; left: 25px; z-index: 150;">
	<input class="printBtn" type="button" style="height: 60px; width: 100px;" onclick="printWindow()" value="print">
</div>
<div class="tokyofair-container">
	<div class="tokyofair-wrap">
		
		<div>
			<div class="tokyofairSchedule">
			</div>
		
		</div>
		
	</div>
</div>

<div>
	<input type="hidden" id="fap_jobfair_divide_seq" value="${fap_jobfair_divide_seq }">
	<input type="hidden" id="fap_tokyofair_date_dt">
	<input type="hidden" id="fap_job_ad_seq">
	<input type="hidden" id="comp_id">
</div>

</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
	<link rel="stylesheet" type="text/css" href="<c:url value="/resources/segroup/society/fap/css/default.css" />" />
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
		
		document.onkeydown = function(e){
		    if(e.keyCode == 116 || e.ctrlKey == true && (e.keyCode == 82)){
		        e.cancelBubble = true; 
		        e.returnValue = false; 
		        setTimeout(function(){
		            window.location.reload();
		        }, 100);
		        return false;
		    }
		}
		
		$(window).on('beforeunload', function(){
			
			var fap_tokyofair_schedule_seq = $("#fap_tokyofair_schedule_seq").val();
			 
			 if(fap_tokyofair_schedule_seq != 0){
				 $.ajax({
					method : 'POST',
					url : '/fap/company/tokyofair_schedule_delete',
					async : false,
					data : {
						fap_tokyofair_schedule_seq: fap_tokyofair_schedule_seq
					},
					headers : {
						"AJAX" : true
					},
					success : function(){
					},
					error : function(e){
					}
				});
			 }
			
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
	    
	    var hiddenNumbers = [];
	    
	    var day = null;
	    var hiddenObj;
	    
	    $.each(tokyofairDate.tokyofairScheduleDateList, function(index, item){
	    	
    		if(day != item.fap_jobfair_set_date_dt){
    			hiddenObj = {
	    				'day' : null,
	    				'num': []
	    		};
    			
    			if(item.fap_jobfair_set_date_room_hid_gb == 'E0201'){
		    		if(typeof hiddenObj != 'undefined') hiddenNumbers.push(hiddenObj);
		    		
		    		day = item.fap_jobfair_set_date_dt;
		    		hiddenObj.day = item.fap_jobfair_set_date_dt;
		    		hiddenObj.num.push(item.fap_jobfair_set_date_room_num);
		    	}
    		}else{
    			if(item.fap_jobfair_set_date_room_hid_gb == 'E0201'){
		    		hiddenObj.num.push(item.fap_jobfair_set_date_room_num);
    			}
	    	}
	    
	    });
	   
	    var time_st = parseInt($scope.tokyofairSet.fap_jobfair_set_room_st.substring(0,2));
		var time_et = parseInt($scope.tokyofairSet.fap_jobfair_set_room_et.substring(0,2));
		
		var caltest = $(".tokyofairSchedule").PACalendar({
		   	startDate : $scope.tokyofairSet.fap_jobfair_set_st,
		   	endDate : $scope.tokyofairSet.fap_jobfair_set_et,
		   	startTime : time_st,
		   	endTime : time_et,
		   	printFlag : false,
		   	roomCount : $scope.tokyofairSet.fap_jobfair_set_room_cnt,
		   	hiddenNumbers : hiddenNumbers,			// ex : [{day : "2019-09-02",num : [2,4]},{day : "2019-09-04",num : [3,6]	}]
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
		
		$(".c_td").off().on("click",function(index,item){
			
			$elm = $(this);
			//관리자 일정
			if($elm.hasClass("disabled")) return;
			//다른기업 일정
			if($elm.hasClass("booked")) return;
			//본인기업 일정
			if($elm.hasClass("merged")) {
				var fap_tokyofair_schedule_seq = $elm.find("a").attr("seq");
				
				$http({
					method : 'POST',
					url : '/fap/company/tokyofair_schedule_search_detail',
					params : {
						fap_tokyofair_schedule_seq: fap_tokyofair_schedule_seq
					},
					headers : {
						"AJAX" : true
					}
				}).then(function successCallback(response) {
					console.log(response.data);
					var _data = response.data;
					$(".member-update-message").html("");	
					$("#fap_tokyofair_schedule_seq_update").val(_data.fap_tokyofair_schedule_seq);
					$("#fap_tokyofair_screening_gb").val(_data.fap_tokyofair_screening_gb);
					$(".member-update-header").html(_data.fap_tokyofair_screening_nm);
					
					//개별면접 리스트
					if(_data.fap_tokyofair_screening_gb == 'E0500'){
						
						var individual_interview_context = '';
						
						$.each(_data.tokyoScrUserUpdateList, function(index, item){
							individual_interview_context += '<div class="individual_interview_line">';
							individual_interview_context += '<span class="individual_interview_time">';
							individual_interview_context += item.fap_tokyofair_member_st + ' ~ ';
							individual_interview_context += '<input type="hidden" class="fap_tokyofair_member_st" value="'+item.fap_tokyofair_member_st+'">';
							individual_interview_context += '<input type="hidden" class="fap_tokyofair_member_et" value="'+item.fap_tokyofair_member_et+'">';
							individual_interview_context += item.fap_tokyofair_member_et;
							individual_interview_context += '</span>';
							individual_interview_context += '<select class="individual_select member_select">';
							
							$.each(_data.tokyoScrUserUpdateList, function(index2, item2){
								if(item.fap_tokyofair_member_id == item2.fap_tokyofair_member_id){
									individual_interview_context += '<option value="'+item2.fap_tokyofair_member_id+'" seq="'+item2.fap_tokyofair_member_resume_seq+'" nm="'+item2.fap_resume_nm+'" selected>';
								}else{
									individual_interview_context += '<option value="'+item2.fap_tokyofair_member_id+'" seq="'+item2.fap_tokyofair_member_resume_seq+'" nm="'+item2.fap_resume_nm+'">';
								}
								individual_interview_context += (index2+1)+'. '+item2.fap_resume_nm+'('+item2.fap_resume_birth+')';
								individual_interview_context += '</option>';
							});
							individual_interview_context += '</select>';
							individual_interview_context += '</div>';
						});
						
						$(".member-update-message").html(individual_interview_context);		
					}
					//그룹면접 리스트
					else if(_data.fap_tokyofair_screening_gb == 'E0501'){
						var group_cnt = _data.tokyoScrUserUpdateList.length / _data.fap_tokyofair_screening_user_num;
						group_cnt = Math.ceil(group_cnt);
						var select_limit_cnt = 0;
						var group_interview_context = '';
						for(var group_index = 0; group_index < group_cnt; group_index++){
							group_interview_context += '<div class="group_interview_line">';
							group_interview_context += '<div class="group_num_wrap">';
							group_interview_context += '<p>';
							group_interview_context += '<span class="group_interview_num">';
							group_interview_context += (group_index+1)+' Group';
							group_interview_context += '</span>';
							group_interview_context += '</p>';
							group_interview_context += '<p>';
							group_interview_context += '<span class="group_interview_time">';
							group_interview_context += _data.tokyoScrUserUpdateList[group_index*_data.fap_tokyofair_screening_user_num].fap_tokyofair_member_st + ' ~ ';
							group_interview_context += '<input type="hidden" class="fap_tokyofair_member_st" value="'+_data.tokyoScrUserUpdateList[group_index*_data.fap_tokyofair_screening_user_num].fap_tokyofair_member_st+'">';
							group_interview_context += '<input type="hidden" class="fap_tokyofair_member_et" value="'+_data.tokyoScrUserUpdateList[group_index*_data.fap_tokyofair_screening_user_num].fap_tokyofair_member_et+'">';
							group_interview_context += _data.tokyoScrUserUpdateList[group_index*_data.fap_tokyofair_screening_user_num].fap_tokyofair_member_et;
							group_interview_context += '</span>';
							group_interview_context += '</p>';
							group_interview_context += '</div>';
							group_interview_context += '<div class="group_member_wrap">';
							
							for(var group_member_index = 0; group_member_index < _data.fap_tokyofair_screening_user_num; group_member_index++){
								
								if(select_limit_cnt >= _data.tokyoScrUserUpdateList.length) break;
								
								group_interview_context += '<div class="group_select_wrap">';
								group_interview_context += '<select class="group_select member_select">';
								$.each(_data.tokyoScrUserUpdateList, function(index, item){
									if(_data.tokyoScrUserUpdateList[(group_index*_data.fap_tokyofair_screening_user_num)+group_member_index].fap_tokyofair_member_id == item.fap_tokyofair_member_id){
										group_interview_context += '<option value="'+item.fap_tokyofair_member_id+'" seq="'+item.fap_tokyofair_member_resume_seq+'" nm="'+item.fap_resume_nm+'" selected>';
									}else{
										group_interview_context += '<option value="'+item.fap_tokyofair_member_id+'" seq="'+item.fap_tokyofair_member_resume_seq+'" nm="'+item.fap_resume_nm+'">';
									}
									group_interview_context += (index+1)+'. '+item.fap_resume_nm+'('+item.fap_resume_birth+')';
									group_interview_context += '</option>';
								});
								group_interview_context += '</select>';
								group_interview_context += '</div>';
								
								select_limit_cnt++;
							}
							
							group_interview_context += '</div>';
							group_interview_context += '</div>';
						}
						$(".member-update-message").html(group_interview_context);
					}else{
						$(".alert-header").html(_data.fap_tokyofair_screening_nm);
						
						var extra_context = '';
						extra_context += '<div class="individual_interview_line">';
						extra_context += '<span class="individual_interview_time">';
						extra_context += _data.tokyoScrUserUpdateList[0].fap_tokyofair_member_st + ' ~ ';
						extra_context += _data.tokyoScrUserUpdateList[0].fap_tokyofair_member_et;
						extra_context += '</span>';
						extra_context += '<div class="member_wrap">';
						
						$.each(_data.tokyoScrUserUpdateList, function(index, item){
							extra_context += '<span>'+item.fap_resume_nm+'('+item.fap_resume_birth+')'+'</span>&nbsp;';
							if(index%5==4) extra_context += '<br/>';
						});
						individual_interview_context += '</div>';
						individual_interview_context += '</div>';
						
						$(".alert-message").html(extra_context);	
						layer_popup("#schedule_alert_layer");
						return;
					}
					$("#fap_tokyofair_screening_seq").val(_data.fap_tokyofair_screening_seq);
					$(".member-update-wran").html("");
					$(".member-message").html("");
					layer_popup("#schedule_member_update_layer");
				}, function errorCallback(response) {
					if(response.status == 403){
						alert('<spring:message code="com.login.ajaxSesstion" javaScriptEscape="true" />');
						location.href = "/fap/company/company_login";
					}
				});
				
			}else{
				var room = $(this).attr("room");
				var st = $(this).attr("time");
				var day = $(this).attr("day");
				
				//해당일 최초 등록일 경우 9시,12시,15시 등록 체크 (단, 관리자가 등록한 일정도 일정으로 판단한다)
				var td_index = $elm.index();
				var first_check = false;
				$elm.closest(".calendar_table").find(".day-list").each(function(index, item){
					if($(item).find("td").eq(td_index).hasClass("merged")){
						first_check = true;
						return;
					}
				});
				
				var fap_jobfair_set_seq = $scope.tokyofairSet.fap_jobfair_set_seq;

				/* if(!first_check){
					
					$.ajax({
						method : 'POST',
						url : '/fap/company/tokyofair_schedule_first_check',
						async : false,
						data : {
							fap_jobfair_set_seq : fap_jobfair_set_seq,
							fap_tokyofair_date_dt : day,
							fap_tokyofair_date_room_num : room
						},
						headers : {
							"AJAX" : true
						},
						success : function(res){
							first_check = res;
						},
						error : function(e){
							console.log(e);
						}
					});
				}
				
				//최초이면서 기준시간이 아닐떄
				if(!first_check && (st != '09:00' && st != '12:00' && st != '15:00')){
					$(".alert-header").html('<spring:message code="fap.tokyofair.schedule.bookable.warn.title" />');
					$(".alert-message").html('<spring:message code="fap.tokyofair.schedule.bookable.warn.reason4" />');
					layer_popup("#schedule_alert_layer");
					return false;
				} */
				
				//앞면접 과의 면접준비시간 체크
				//같은 잡페어 같은 날짜 같은 면접실의 일정중에 시작시간 < 다른일정 종료시간 + 면접준비시간
				var fap_comp_id = $("#fap_comp_id").val();
				var itv_comp_check = false;
				
				$.ajax({
					method : 'POST',
					url : '/fap/company/tokyofair_schedule_itv_comp_before_check',
					async : false,
					contentType: 'application/json',
					data : JSON.stringify({
						fap_jobfair_set_seq : fap_jobfair_set_seq,
						fap_tokyofair_date_dt : day,
						fap_tokyofair_date_room_num : room,
						fap_tokyofair_schedule_st : st,
						fap_jobfair_set_itv_comp_dt : $scope.tokyofairSet.fap_jobfair_set_itv_comp_dt,
						fap_comp_id : fap_comp_id
					}),
					headers : {
						"AJAX" : true
					},
					success : function(res){
						itv_comp_check = res;
					},
					error : function(e){
						console.log(e);
					}
				});
				
				if(itv_comp_check){
					$(".alert-header").html('<spring:message code="fap.tokyofair.schedule.bookable.warn.title" />');
					$(".alert-message").html('<spring:message code="fap.tokyofair.schedule.bookable.warn.reason5" />');
					layer_popup("#schedule_alert_layer");
					return false;
				}
				
				//앞면접 종료후 2시간이상 3시간 이하의 간격으로 선택시 (앞면접 종료시간 1시간 이내로 선택해 달라는 메세지 (강제x))
				var term_check = false;
				
				$.ajax({
					method : 'POST',
					url : '/fap/company/tokyofair_schedule_term_check',
					async : false,
					contentType: 'application/json',
					data : JSON.stringify({
						fap_jobfair_set_seq : fap_jobfair_set_seq,
						fap_tokyofair_date_dt : day,
						fap_tokyofair_date_room_num : room,
						fap_tokyofair_schedule_st : st,
						fap_jobfair_set_itv_comp_dt : $scope.tokyofairSet.fap_jobfair_set_itv_comp_dt
					}),
					headers : {
						"AJAX" : true
					},
					success : function(res){
						term_check = res;
					},
					error : function(e){
						console.log(e);
					}
				});
				
				if(term_check){
					$(".confirm-header").html('<spring:message code="fap.tokyofair.schedule.bookable.confirm.title" />');
					$(".confirm-message").html('<spring:message code="fap.tokyofair.schedule.bookable.confirm.reason1" />'+'<br />'+'<spring:message code="fap.tokyofair.schedule.bookable.confirm.reason2" />');
					confirm_popup("#schedule_confirm_layer", function(){
						$scope.screening_callback();
					});
				}else{
					$scope.screening_callback();
				}
			}
			
		});
		
		$scope.screening_callback = function(){
			var room = $elm.attr("room");
			var st = $elm.attr("time");
			var day = $elm.attr("day");
			
			$(".c_td").removeClass("ck");
			$(this).addClass("ck");
			
			var fap_job_ad_seq = $("#fap_job_ad_seq").val();
			
			$http({
				method : 'POST',
				url : '/fap/company/tokyofair_screening_search_bookable',
				params : {
					fap_job_ad_seq: fap_job_ad_seq
				},
				headers : {
					"AJAX" : true
				}
			}).then(function successCallback(response) {
				console.log(response);
				
				$(".layer-header .list-header").html(day+" room : "+room+" time : "+st);
				var context = '';
				context +=	'<select id="select_schedule_detail">';
				context +=		'<option value="0"><spring:message code="fap.tokyofair.schedule.bookable.title" /></option>';
				$.each(response.data, function(index,item){
					context += '<option value="'+item.fap_tokyofair_screening_seq+'">'+item.fap_tokyofair_screening_nm+'</option>';
				});
				context +=	'</select>';
				
				$(".layer-message .list-message").html(context);
				layer_popup("#schedule_list_layer");
			}, function errorCallback(response) {
				if(response.status == 403){
					alert('<spring:message code="com.login.ajaxSesstion" javaScriptEscape="true" />');
					location.href = "/fap/company/company_login";
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
		 $scope.select_schedule_detail = function(){
			var fap_tokyofair_screening_seq = $("#select_schedule_detail option:selected").val();
			if(fap_tokyofair_screening_seq != 0){
				
				$http({
					method : 'POST',
					url : '/fap/company/tokyofair_screening_search_one',
					params : {
						fap_tokyofair_screening_seq: fap_tokyofair_screening_seq
					},
					headers : {
						"AJAX" : true
					}
				}).then(function successCallback(response) {
					var _data = response.data;
					var totalTime;
					var fap_tokyofair_date_dt = $elm.attr("day");
					var fap_tokyofair_date_room_num = $elm.attr("room");
					var fap_tokyofair_schedule_st = $elm.attr("time");
					var fap_job_ad_seq = $("#fap_job_ad_seq").val();
					var fap_comp_id = $("#fap_comp_id").val();
					var scheduleMap = {};
					scheduleMap['fap_tokyofair_date_dt'] = fap_tokyofair_date_dt;
					scheduleMap['fap_tokyofair_date_room_num'] = fap_tokyofair_date_room_num;
					scheduleMap['fap_tokyofair_schedule_st'] = fap_tokyofair_schedule_st;
					scheduleMap['fap_job_ad_seq'] = fap_job_ad_seq;
					scheduleMap['fap_comp_id'] = fap_comp_id;

					//개별면접
					if(_data.fap_tokyofair_screening_gb == 'E0500'){
						totalTime = _data.fap_tokyofair_screening_time * _data.tokyoScrUserList.length;
					}
					//그룹면접
					else if(_data.fap_tokyofair_screening_gb == 'E0501'){
						groupCnt = _data.tokyoScrUserList.length / _data.fap_tokyofair_screening_user_num;
						groupCnt = Math.ceil(groupCnt);
						totalTime = _data.fap_tokyofair_screening_time * groupCnt;
					}
					
					var merge_st = parseInt(fap_tokyofair_schedule_st.substring(0,2));
					var merge_sm = parseInt(fap_tokyofair_schedule_st.substring(3));
					var merge_date = new Date(0,0,0,merge_st,merge_sm);
					merge_date.setMinutes(merge_date.getMinutes() + totalTime);
					
					var mergeLength = totalTime / 10; 
					var fap_tokyofair_schedule_et = merge_date.format("HH:mm");
					
					var compare_time = $scope.tokyofairSet.fap_jobfair_set_room_et;
					var compare_st = parseInt(compare_time.substring(0,2));
					var compare_sm = parseInt(compare_time.substring(3));
					var compare_date = new Date(0,0,0,compare_st,compare_sm);
					
					//동시성의 문제 및 설정시간 초과 체크
					if(merge_date.getTime() > compare_date.getTime()){
						//일정 레이어 닫기
						$(".list-close").trigger("click");
						//경고 레이어 열기
						$(".alert-header").html('<spring:message code="fap.tokyofair.schedule.bookable.warn.title" />');
						$(".alert-message").html('<spring:message code="fap.tokyofair.schedule.bookable.warn.reason1" />'+'<br/>'+'<spring:message code="fap.tokyofair.schedule.bookable.warn.reason2" />'+'<br/>'+'<spring:message code="fap.tokyofair.schedule.bookable.warn.reason3" />');				
						layer_popup("#schedule_alert_layer");
						return;
					}
					
					var merged_check = false;
					
					$elm.closest(".day-list").nextAll().each(function(index,item){
						if(index < mergeLength-1){
							if($(this).find("td").eq(fap_tokyofair_date_room_num).hasClass("merged")){
								$(".list-close").trigger("click");
								//경고 레이어 열기
								$(".alert-header").html('<spring:message code="fap.tokyofair.schedule.bookable.warn.title" />');
								$(".alert-message").html('<spring:message code="fap.tokyofair.schedule.bookable.warn.reason1" />'+'<br/>'+'<spring:message code="fap.tokyofair.schedule.bookable.warn.reason2" />'+'<br/>'+'<spring:message code="fap.tokyofair.schedule.bookable.warn.reason3" />');				
								layer_popup("#schedule_alert_layer");
								merged_check = true;
								return false;
							}
						}
					});
					
					if(merged_check) return;
					
					scheduleMap['fap_tokyofair_schedule_merge'] = mergeLength;
					scheduleMap['fap_tokyofair_schedule_et'] = fap_tokyofair_schedule_et;
					scheduleMap['fap_jobfair_set_seq'] = $scope.tokyofairSet.fap_jobfair_set_seq;
					scheduleMap['fap_tokyofair_screening_seq'] = _data.fap_tokyofair_screening_seq;
					scheduleMap['fap_jobfair_set_itv_comp_dt'] = $scope.tokyofairSet.fap_jobfair_set_itv_comp_dt;
					
					//예약가능한 시간때 인지 확인 후 가능하면 일정 등록
					$http({
						method : 'POST',
						url : '/fap/company/tokyofair_schedule_insert',
						headers: {'Content-Type': 'application/json'},
						data: JSON.stringify(scheduleMap),
						XMLHttpRequestResponseType: 'json',
						headers : {
							"AJAX" : true
						}
					}).then(function successCallback(response) {
						var _result = response.data;
						
						if(_result.insertFlag){
							//일정 레이어 닫기
							$(".list-close").trigger("click");
							$(".member-message").html("");		
							$("#fap_tokyofair_schedule_seq").val(_result.fap_tokyofair_schedule_seq);
							$("#fap_tokyofair_screening_gb").val(_data.fap_tokyofair_screening_gb);
							$(".member-header").html(_data.fap_tokyofair_screening_nm);
							
							//개별면접 리스트
							if(_data.fap_tokyofair_screening_gb == 'E0500'){
								var individual_interview_st = parseInt(fap_tokyofair_schedule_st.substring(0,2));
								var individual_interview_sm = parseInt(fap_tokyofair_schedule_st.substring(3));
								var individual_interview_date = new Date(0,0,0,individual_interview_st,individual_interview_sm);
								
								var individual_interview_context = '';
								
								for(var individual_index = 0 ; individual_index < _data.tokyoScrUserList.length; individual_index++){
									individual_interview_context += '<div class="individual_interview_line">';
									individual_interview_context += '<span class="individual_interview_time">';
									individual_interview_context += individual_interview_date.format("HH:mm") + ' ~ ';
									individual_interview_context += '<input type="hidden" class="fap_tokyofair_member_st" value="'+individual_interview_date.format("HH:mm")+'">';
									individual_interview_date.setMinutes(individual_interview_date.getMinutes() + _data.fap_tokyofair_screening_time);
									individual_interview_context += '<input type="hidden" class="fap_tokyofair_member_et" value="'+individual_interview_date.format("HH:mm")+'">';
									individual_interview_context += individual_interview_date.format("HH:mm");
									individual_interview_context += '</span>';
									individual_interview_context += '<select class="individual_select member_select">';
									
									$.each(_data.tokyoScrUserList, function(index, item){
										individual_interview_context += '<option value="'+item.user_id+'" seq="'+item.fap_resume_seq+'" nm="'+item.fap_resume_nm+'">';
										individual_interview_context += (index+1)+'. '+item.fap_resume_nm+'('+item.fap_resume_birth+')';
										individual_interview_context += '</option>';
									});
									
									individual_interview_context += '</select>';
									individual_interview_context += '</div>';
								}
								
								$(".member-message").html(individual_interview_context);		
							}
							//그룹면접 리스트
							else if(_data.fap_tokyofair_screening_gb == 'E0501'){
								var group_interview_st = parseInt(fap_tokyofair_schedule_st.substring(0,2));
								var group_interview_sm = parseInt(fap_tokyofair_schedule_st.substring(3));
								var group_interview_date = new Date(0,0,0,group_interview_st,group_interview_sm);
								var group_cnt = _data.tokyoScrUserList.length / _data.fap_tokyofair_screening_user_num;
								group_cnt = Math.ceil(group_cnt);
								var select_limit_cnt = 0;
								var group_interview_context = '';
								for(var group_index = 0; group_index < group_cnt; group_index++){
									group_interview_context += '<div class="group_interview_line">';
									group_interview_context += '<div class="group_num_wrap">';
									group_interview_context += '<p>';
									group_interview_context += '<span class="group_interview_num">';
									group_interview_context += (group_index+1)+' Group';
									group_interview_context += '</span>';
									group_interview_context += '</p>';
									group_interview_context += '<p>';
									group_interview_context += '<span class="group_interview_time">';
									group_interview_context += group_interview_date.format("HH:mm") + ' ~ ';
									group_interview_context += '<input type="hidden" class="fap_tokyofair_member_st" value="'+group_interview_date.format("HH:mm")+'">';
									group_interview_date.setMinutes(group_interview_date.getMinutes() + _data.fap_tokyofair_screening_time);
									group_interview_context += '<input type="hidden" class="fap_tokyofair_member_et" value="'+group_interview_date.format("HH:mm")+'">';
									group_interview_context += group_interview_date.format("HH:mm");
									group_interview_context += '</span>';
									group_interview_context += '</p>';
									group_interview_context += '</div>';
									group_interview_context += '<div class="group_member_wrap">';
									
									for(var group_member_index = 0; group_member_index < _data.fap_tokyofair_screening_user_num; group_member_index++){
										
										if(select_limit_cnt >= _data.tokyoScrUserList.length) break;
										
										group_interview_context += '<div class="group_select_wrap">';
										group_interview_context += '<select class="group_select member_select">';
										$.each(_data.tokyoScrUserList, function(index, item){
											group_interview_context += '<option value="'+item.user_id+'" seq="'+item.fap_resume_seq+'" nm="'+item.fap_resume_nm+'">';
											group_interview_context += (index+1)+'. '+item.fap_resume_nm+'('+item.fap_resume_birth+')';
											group_interview_context += '</option>';
										});
										group_interview_context += '</select>';
										group_interview_context += '</div>';
										
										select_limit_cnt++;
									}
									
									group_interview_context += '</div>';
									group_interview_context += '</div>';
								}
								$(".member-message").html(group_interview_context);
							}
							$("#fap_tokyofair_screening_seq").val(_data.fap_tokyofair_screening_seq);
							$(".member-wran").html("");
							$(".member-update-message").html("");
							layer_popup("#schedule_member_layer");
						}else{
							//일정 레이어 닫기
							$(".list-close").trigger("click");
							//경고 레이어 열기
							$(".alert-header").html('<spring:message code="fap.tokyofair.schedule.bookable.warn.title" />');
							$(".alert-message").html('<spring:message code="fap.tokyofair.schedule.bookable.warn.reason1" />'+'<br/>'+'<spring:message code="fap.tokyofair.schedule.bookable.warn.reason2" />'+'<br/>'+'<spring:message code="fap.tokyofair.schedule.bookable.warn.reason3" />');				
							layer_popup("#schedule_alert_layer");
						}
						
					}, function errorCallback(response) {
						if(response.status == 403){
							alert('<spring:message code="com.login.ajaxSesstion" javaScriptEscape="true" />');
							location.href = "/fap/company/company_login";
						}
					});
					
					
				}, function errorCallback(response) {
					if(response.status == 403){
						alert('<spring:message code="com.login.ajaxSesstion" javaScriptEscape="true" />');
						location.href = "/fap/company/company_login";
					}
				});
				
			}
		 }
		 
		 $(".member-close").on("click",function(){
			 
			 var fap_tokyofair_schedule_seq = $("#fap_tokyofair_schedule_seq").val();
			 
			 if(fap_tokyofair_schedule_seq != 0){
				 $http({
					method : 'POST',
					url : '/fap/company/tokyofair_schedule_delete',
					params : {
						fap_tokyofair_schedule_seq: fap_tokyofair_schedule_seq
					},
					headers : {
						"AJAX" : true
					}
				}).then(function successCallback(response) {
					 $("#fap_tokyofair_schedule_seq").val(0);
					 $scope.reloadSchedule();
				}, function errorCallback(response) {
					if(response.status == 403){
						alert('<spring:message code="com.login.ajaxSesstion" javaScriptEscape="true" />');
						location.href = "/fap/company/company_login";
					}
				});
			 }
			 
			 
		 });
		 
		 $scope.insert_schedule_member = function(){
			 //셀렉트 박스 중복 체크
			var temp = [];
			var obj = $(".member_select");
			var result = false;
			var duplicate = [];
			
			 $(obj).each(function(index,item){
				 temp[index] = $(this).find("option:selected").attr("nm");
			 });
			
			 temp = temp.sort();
			 
			 for ( var i = 0; i < temp.length -1; i++){
				 if(temp[i + 1] == temp[i]){
					 duplicate.push(temp[i]);
					 result = true;
					 break;
				 }
			 }
			 
			 if(result){
				$(".member-wran").html('<span class="blue">'+duplicate+'</span><spring:message code="fap.tokyofair.schedule.bookable.dupulicate.reason1" />');
				return;
			 }
			 
			 //동일인 중복시간 체크 + 지원자 다음면접회사 준비시간 간격 체크 
			 var fap_tokyofair_screening_seq = $("#fap_tokyofair_screening_seq").val();
			 var scheduleMemberMap = {};
			 scheduleMemberMap['fap_tokyofair_screening_seq'] = fap_tokyofair_screening_seq;
			 scheduleMemberMap['fap_jobfair_itv_stu_dt'] = $scope.tokyofairSet.fap_jobfair_set_itv_stu_dt;
			 scheduleMemberMap['fap_tokyofair_date_dt'] = $elm.attr("day");
			 scheduleMemberMap['fap_tokyofair_date_room_num'] = $elm.attr("room");
			 scheduleMemberMap['fap_jobfair_set_seq'] = $scope.tokyofairSet.fap_jobfair_set_seq;
			 scheduleMemberMap['fap_tokyofair_schedule_seq'] = $("#fap_tokyofair_schedule_seq").val();
			 
			 var fap_tokyofair_screening_gb = $("#fap_tokyofair_screening_gb").val();
			 //개별
			 if(fap_tokyofair_screening_gb == 'E0500'){
				 var individualArr = [];
				 $(".individual_interview_line").each(function(index, item){
					 var memberMap = {};
					 memberMap['fap_tokyofair_member_st'] = $(this).find(".fap_tokyofair_member_st").val();
					 memberMap['fap_tokyofair_member_et'] = $(this).find(".fap_tokyofair_member_et").val();
					 memberMap['fap_tokyofair_member_id'] = $(this).find(".member_select").val();
					 memberMap['fap_tokyofair_member_resume_seq'] = $(this).find(".member_select option:selected").attr("seq");
					 individualArr.push(memberMap);
				 });
				 scheduleMemberMap['memberArr'] = individualArr;
			 }
			 //그룹
			 else if(fap_tokyofair_screening_gb == 'E0501'){
				 var groupArr = [];
				 $(".group_select_wrap").each(function(index,item){
					 var memberMap = {};
					 memberMap['fap_tokyofair_member_st'] = $(this).closest(".group_interview_line").find(".fap_tokyofair_member_st").val();
					 memberMap['fap_tokyofair_member_et'] = $(this).closest(".group_interview_line").find(".fap_tokyofair_member_et").val();
					 memberMap['fap_tokyofair_member_id'] = $(this).find(".member_select").val();
					 memberMap['fap_tokyofair_member_resume_seq'] = $(this).find(".member_select option:selected").attr("seq");
					 groupArr.push(memberMap);
				 });
				 scheduleMemberMap['memberArr'] = groupArr;
			 }
			 
			 $http({
				method : 'POST',
				url : '/fap/company/tokyofair_schedule_member_insert',
				headers: {'Content-Type': 'application/json'},
				data: JSON.stringify(scheduleMemberMap),
				XMLHttpRequestResponseType: 'json',
				headers : {
					"AJAX" : true
				}
			}).then(function successCallback(response) {
				
				if(response.data.length != 0){
					var context = '';
					$.each(response.data, function(index, item){
						context += '<span class="blue">';
						context += ' '+item.fap_resume_nm+'('+item.fap_resume_birth+') ';
						context += '</span>';
						if(index%3 == 2) context += '<br>';
					});
					context += '<br><spring:message code="fap.tokyofair.schedule.bookable.dupulicate.reason2" />';
					$(".member-wran").html(context);
				}else{
					layer_close("#schedule_member_layer");
					$scope.reloadSchedule();
				}
			}, function errorCallback(response) {
				if(response.status == 403){
					alert('<spring:message code="com.login.ajaxSesstion" javaScriptEscape="true" />');
					location.href = "/fap/company/company_login";
				}
			});
			 
		 };
		 
		 $scope.update_schedule_member = function(){
			 //셀렉트 박스 중복 체크
			var temp = [];
			var obj = $(".member_select");
			var result = false;
			var duplicate = [];
			
			 $(obj).each(function(index,item){
				 temp[index] = $(this).find("option:selected").attr("nm");
			 });
			
			 temp = temp.sort();
			 
			 for ( var i = 0; i < temp.length -1; i++){
				 if(temp[i + 1] == temp[i]){
					 duplicate.push(temp[i]);
					 result = true;
					 break;
				 }
			 }
			 
			 if(result){
				$(".member-update-wran").html('<span class="blue">'+duplicate+'</span><spring:message code="fap.tokyofair.schedule.bookable.dupulicate.reason1" />');
				return;
			 }
			 
			 //동일인 중복시간 체크 + 지원자 다음면접회사 준비시간 간격 체크 
			 var fap_tokyofair_screening_seq = $("#fap_tokyofair_screening_seq").val();
			 var scheduleMemberMap = {};
			 scheduleMemberMap['fap_tokyofair_screening_seq'] = fap_tokyofair_screening_seq;
			 scheduleMemberMap['fap_jobfair_itv_stu_dt'] = $scope.tokyofairSet.fap_jobfair_set_itv_stu_dt;
			 scheduleMemberMap['fap_tokyofair_date_dt'] = $elm.attr("day");
			 scheduleMemberMap['fap_tokyofair_date_room_num'] = $elm.attr("room");
			 scheduleMemberMap['fap_jobfair_set_seq'] = $scope.tokyofairSet.fap_jobfair_set_seq;
			 scheduleMemberMap['fap_tokyofair_schedule_seq'] = $("#fap_tokyofair_schedule_seq_update").val();
			 
			 var fap_tokyofair_screening_gb = $("#fap_tokyofair_screening_gb").val();
			 //개별
			 if(fap_tokyofair_screening_gb == 'E0500'){
				 var individualArr = [];
				 $(".individual_interview_line").each(function(index, item){
					 var memberMap = {};
					 memberMap['fap_tokyofair_member_st'] = $(this).find(".fap_tokyofair_member_st").val();
					 memberMap['fap_tokyofair_member_et'] = $(this).find(".fap_tokyofair_member_et").val();
					 memberMap['fap_tokyofair_member_id'] = $(this).find(".member_select").val();
					 memberMap['fap_tokyofair_member_resume_seq'] = $(this).find(".member_select option:selected").attr("seq");
					 individualArr.push(memberMap);
				 });
				 scheduleMemberMap['memberArr'] = individualArr;
			 }
			 //그룹
			 else if(fap_tokyofair_screening_gb == 'E0501'){
				 var groupArr = [];
				 $(".group_select_wrap").each(function(index,item){
					 var memberMap = {};
					 memberMap['fap_tokyofair_member_st'] = $(this).closest(".group_interview_line").find(".fap_tokyofair_member_st").val();
					 memberMap['fap_tokyofair_member_et'] = $(this).closest(".group_interview_line").find(".fap_tokyofair_member_et").val();
					 memberMap['fap_tokyofair_member_id'] = $(this).find(".member_select").val();
					 memberMap['fap_tokyofair_member_resume_seq'] = $(this).find(".member_select option:selected").attr("seq");
					 groupArr.push(memberMap);
				 });
				 scheduleMemberMap['memberArr'] = groupArr;
			 }
			 
			 $http({
				method : 'POST',
				url : '/fap/company/tokyofair_schedule_member_update',
				headers: {'Content-Type': 'application/json'},
				data: JSON.stringify(scheduleMemberMap),
				XMLHttpRequestResponseType: 'json',
				headers : {
					"AJAX" : true
				}
			}).then(function successCallback(response) {
				
				if(response.data.length != 0){
					var context = '';
					$.each(response.data, function(index, item){
						context += '<span class="blue">';
						context += ' '+item.fap_resume_nm+'('+item.fap_resume_birth+') ';
						context += '</span>';
						if(index%3 == 2) context += '<br>';
					});
					context += '<br><spring:message code="fap.tokyofair.schedule.bookable.dupulicate.reason2" />';
					$(".member-update-wran").html(context);
				}else{
					layer_close("#schedule_member_update_layer");
					$scope.reloadSchedule();
				}
			}, function errorCallback(response) {
				if(response.status == 403){
					alert('<spring:message code="com.login.ajaxSesstion" javaScriptEscape="true" />');
					location.href = "/fap/company/company_login";
				}
			});
			 
		 };
		 
		 $scope.delete_schedule_member = function(){
			
			layer_close("#schedule_member_update_layer");
			 
			$(".confirm-header").html('<spring:message code="fap.tokyofair.schedule.bookable.confirm.delete.title" />');
			$(".confirm-message").html('<spring:message code="fap.tokyofair.schedule.bookable.confirm.delete.message" />');
			
			confirm_popup("#schedule_confirm_layer", function(){
				 var fap_tokyofair_schedule_seq = $("#fap_tokyofair_schedule_seq_update").val();
				 var fap_tokyofair_screening_seq = $("#fap_tokyofair_screening_seq").val();
				
				 $http({
					method : 'POST',
					url : '/fap/company/tokyofair_schedule_member_delete',
					params : {
						fap_tokyofair_schedule_seq: fap_tokyofair_schedule_seq,
						fap_tokyofair_screening_seq : fap_tokyofair_screening_seq
					},
					headers : {
						"AJAX" : true
					}
				}).then(function successCallback(response) {
					 $("#fap_tokyofair_schedule_seq").val(0);
					 window.location.reload();
					 
				}, function errorCallback(response) {
					if(response.status == 403){
						alert('<spring:message code="com.login.ajaxSesstion" javaScriptEscape="true" />');
						location.href = "/fap/company/company_login";
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
					url : '/fap/company/tokyofair_schedule_reload',
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
			 
			 $("#fap_tokyofair_schedule_seq").val(0);
			 
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
				if(fap_comp_id == item.fap_comp_id){
					_target.addClass("merged");
					var context = '<p><a href="javascript:void(0);" seq="'+item.fap_tokyofair_schedule_seq+'" cp="'+item.fap_comp_id+'" >';
					context += '<b><spring:message code="fap.tokyofair.schedule.calendar.read" /></b>';
					context += '</a></p>';
			    	_target.html(context);
				}else{
					_target.addClass("merged booked");
			    	_target.html('<spring:message code="fap.tokyofair.schedule.calendar.booked" />');
				}
				 
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
</script>
</head>
<body  ng-app="myapp" ng-controller="TokyoFairController">
<%@include file="company_menu.jsp"%>
<div class="tokyofair-container">
	<div class="tokyofair-wrap">
		<h1><spring:message code="fap.tokyofair.schedule.management.title" /></h1>
		<h6></h6>	
		
		<div>
			<div class="tokyofairSchedule">
			</div>
		
		</div>
		
	</div>
</div>

<div>
	<input type="hidden" id="fap_job_ad_seq" value="${fap_job_ad_seq }">
	<input type="hidden" id="fap_comp_id" value="${fap_comp_id }">
	<input type="hidden" id="fap_tokyofair_date_dt">
	<input type="hidden" id="fap_tokyofair_schedule_seq">
	<input type="hidden" id="fap_tokyofair_schedule_seq_update">
	<input type="hidden" id="fap_tokyofair_screening_seq">
	<input type="hidden" id="fap_tokyofair_screening_gb">
</div>
<%@include file="../common_footer_fap.jsp"%>

<!-- 리스트용 layer 시작 -->
<div class="dim-layer">
    <div class="dimBg"></div>
    <div id="schedule_list_layer" class="pop-layer">
        <div class="pop-container">
            <div class="pop-conts">
                <div class="layer-header">
            		<h3 class="list-header">
            		</h3>
            	</div>
            	<div class="layer-message">
            		<div class="list-message">
            		</div>
            	</div>
                <div class="btn-r">
                    <a href="#" class="btn-layerClose list-close">Close</a>
                    <a href="javascript:void(0);" ng-click="select_schedule_detail()" class="btn-layerDelete">Next</a>
                </div>
                <!--// content-->
            </div>
        </div>
    </div>
</div>
<!-- 리스트용 layer 종료 -->

<!-- 메세지용 layer 시작 -->
<div class="dim-layer">
    <div class="dimBg"></div>
    <div id="schedule_alert_layer" class="pop-layer md">
        <div class="pop-container">
            <div class="pop-conts">
                <div class="layer-header">
            		<h3 class="alert-header">
            		</h3>
            	</div>
            	<div class="layer-message">
            		<div class="alert-message">
            		</div>
            	</div>
                <div class="btn-r">
                    <a href="#" class="btn-layerClose alert-close">Close</a>
                </div>
                <!--// content-->
            </div>
        </div>
    </div>
</div>
<!-- 메세지용 layer 종료 -->

<!-- 컨펌용 layer 시작 -->
<div class="dim-layer">
    <div class="dimBg"></div>
    <div id="schedule_confirm_layer" class="pop-layer md">
        <div class="pop-container">
            <div class="pop-conts">
                <div class="layer-header">
            		<h3 class="confirm-header">
            		</h3>
            	</div>
            	<div class="layer-message">
            		<div class="confirm-message">
            		</div>
            	</div>
                <div class="btn-r">
                    <a href="#" class="btn-layerClose confirm-close">Close</a>
                    <a href="javascript:void(0);" class="btn-layerDelete confirm-next">Next</a>
                </div>
                <!--// content-->
            </div>
        </div>
    </div>
</div>
<!-- 컨펌용 layer 종료 -->

<!-- 인원 layer 시작 -->
<div class="dim-layer">
    <div class="dimBg"></div>
    <div id="schedule_member_layer" class="pop-layer scroll">
        <div class="pop-container">
            <div class="pop-conts">
                <div class="layer-header">
            		<h3 class="member-header">
            		</h3>
            	</div>
            	<div class="layer-message">
            		<div class="member-wran">
            		</div>
            		<div class="member-message">
            		</div>
            	</div>
                <div class="btn-r">
                    <a href="#" class="btn-layerClose member-close">Close</a>
                    <a href="javascript:void(0);" ng-click="insert_schedule_member()" class="btn-layerDelete">Insert</a>
                </div>
                <!--// content-->
            </div>
        </div>
    </div>
</div>
<!-- 인원 layer 종료 -->

<!-- 인원 수정 layer 시작 -->
<div class="dim-layer">
    <div class="dimBg"></div>
    <div id="schedule_member_update_layer" class="pop-layer scroll">
        <div class="pop-container">
            <div class="pop-conts">
                <div class="layer-header">
            		<h3 class="member-update-header">
            		</h3>
            	</div>
            	<div class="layer-message">
            		<div class="member-update-wran">
            		</div>
            		<div class="member-update-message">
            		</div>
            	</div>
                <div class="btn-r">
                    <a href="#" class="btn-layerClose member-update-close">Close</a>
                    <a href="javascript:void(0);" ng-click="delete_schedule_member()" class="btn-layerDelete">Delete</a>
                    <a href="javascript:void(0);" ng-click="update_schedule_member()" class="btn-layerDelete">Update</a>
                </div>
                <!--// content-->
            </div>
        </div>
    </div>
</div>
<!-- 인원 수정 layer 종료 -->

</body>
</html>
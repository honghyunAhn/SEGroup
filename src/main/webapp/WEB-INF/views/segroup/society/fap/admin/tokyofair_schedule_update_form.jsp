<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">	
	<link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
	<script src="<c:url value="/resources/segroup/js/jquery-3.1.1.js" />"></script>
	<script src="<c:url value="/resources/segroup/js/jquery-ui.js" />"></script>
	<script src="<c:url value="/resources/segroup/js/angular.min.js" />"></script>
	<script src="<c:url value="/resources/segroup/js/datepicker.js" />"></script>
	<script type="text/javascript" src="/resources/segroup/js/jquery.timepicker.min.js"></script>
	<script src="<c:url value="/resources/segroup/society/fap/js/layer.js" />"></script>
	<script src="<c:url value="/resources/segroup/society/fap/js/calendar.js" />"></script>
	<script src="<c:url value="/resources/segroup/js/timepicker.js" />"></script>
	<link type="text/css" rel="stylesheet" href="/resources/segroup/css/jquery.timepicker.css" media="" />
	<link type="text/css" rel="stylesheet" href="<c:url value="/resources/segroup/society/fap/css/layer.css" />" media="" />
	<link type="text/css" rel="stylesheet" href="<c:url value="/resources/segroup/society/fap/css/calendar.css" />" media="" />
<title>Bridge Job Fair</title>
<script type="text/javascript">

	var myApp = angular.module('myapp', []);
	
	myApp.controller('AdminController', ['$scope','$compile','$http', function($scope,$compile,$http){
			
	}]);	
	
	$(function() {
		
		var fap_jobfair_set_itv_stu_dt = $("#fap_jobfair_set_itv_stu_dt").attr("dt");
		var fap_jobfair_set_itv_comp_dt = $("#fap_jobfair_set_itv_comp_dt").attr("dt");
		$("#fap_jobfair_set_itv_stu_dt option:contains('"+fap_jobfair_set_itv_stu_dt+"')").prop('selected', 'selected');
		$("#fap_jobfair_set_itv_comp_dt option:contains('"+fap_jobfair_set_itv_comp_dt+"')").prop('selected', 'selected');
		
		calInit();
		
		var tokyofairDateJson = '${result.tokyofairDate}';
		tokyofairDateJson = tokyofairDateJson.replace(/(?:\r\n|\r|\n)/g, '\\r\\n');
	    var tokyofairDate = JSON.parse(tokyofairDateJson);
	    console.log(tokyofairDate);
		
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
				_target.addClass("merged");
		    	_target.html(this.fap_jobfair_set_time_ct);
				
	    	});
	    	
	    });
		
		cleanDatepicker();
		minMax("jobfair_st" , "jobfair_et");
		minMax("fap_jobfair_set_comp_sd" , "fap_jobfair_set_comp_ed");
		
		var setting = {
		        'minTime' : '00:00am',
		        'maxTime' : '23:00pm', 
		        'timeFormat' : 'H:i',
		        'step' : 60
		}
		minMaxTime("jobfair_room_st", "jobfair_room_et",setting);
		var comp_setting = {
				'minTime' : '00:00am',
		        'maxTime' : '23:00pm', 
		        'timeFormat' : 'H:i',
		        'step' : 10
		}
		minMaxTime("fap_jobfair_set_comp_st", "fap_jobfair_set_comp_et",comp_setting);
		
		function cleanDatepicker() {

			var original_gotoToday = $.datepicker._gotoToday;

			$.datepicker._gotoToday = function(id) {
				var target = $(id), inst = this._getInst(target[0]);

				original_gotoToday.call(this, id);
				this._selectDate(id, this._formatDate(inst, inst.selectedDay, inst.drawMonth, inst.drawYear));
				target.blur();
			}

			var old_fn = $.datepicker._updateDatepicker;

			$.datepicker._updateDatepicker = function(inst) {
				old_fn.call(this, inst);

				var buttonPane = $(this).datepicker("widget").find(".ui-datepicker-buttonpane");

				$("<button type='button' class='ui-datepicker-clean ui-state-default ui-priority-primary ui-corner-all'>clear</button>").appendTo(buttonPane).click(function(ev) {
					$.datepicker._clearDate(inst.input);
				});
			}
		}
		
		$("#calendarBtn").on("click",function(){
			if(confirm("작성중인 일정이 있을경우 일정이 삭제 되고 새롭게 생성됩니다.\n 진행하시겠습니까?")){
				$(".plugInTest").empty();
			}else{
				return;
			}
			calInit();
		});
		
		$(".btn-layerSave").off().on("click",function(){
				var take_time = $("#take_time").val();
				var layer_tx = $("#layer_tx").val();
				var room = $elm.attr("room");
				var merged_check = false;
				var length_check = $elm.closest(".day-list").nextAll().length;
				
				if((take_time-1) > length_check){
					alert('<spring:message code="fap.calendar.time.excess" />');
					return;
				}
				
				$elm.closest(".day-list").nextAll().each(function(index,item){
					if(index < take_time-1){
						if($(this).find("td").eq(room).hasClass("merged")){
							merged_check = true;
							return;
						}
					}else{
						return;
					}
				});
				
				if(merged_check){
					alert('<spring:message code="fap.calendar.time.overlap" />');
				}else{
					$elm.attr("rowSpan",take_time);
					
					$elm.closest(".day-list").nextAll().each(function(index,item){
						if(index < take_time-1){
							$(this).find("td").eq(room).addClass("hidden");
						}else{
							return;
						}
					})
					
					$elm.addClass("merged");
					$elm.html(layer_tx);
				}
				
				$(".btn-layerClose").trigger("click");
		});
		
		$(".btn-layerDelete").off().on("click",function(){
			var rowSpan = $elm.attr("rowSpan");
			var room = $elm.attr("room");
			
			$elm.closest(".day-list").nextAll().each(function(index,item){
				if(index < rowSpan-1){
					$(this).find("td").eq(room).removeClass("hidden");
				}else{
					return;
				}
			})
			
			$elm.attr("rowSpan",1);
			
			$elm.removeClass("merged");
			$elm.html("");
			
			$(".btn-layerClose").trigger("click");
		});
		
		$(".btn-layerClose").on("click",function(){
			layerInit();
		})
		
		
		$("#updateBtn").on("click",function(){
			var fap_jobfair_set_seq = $("#fap_jobfair_set_seq").val();
			var fap_jobfair_divide_seq = $("#fap_jobfair_divide_seq").val();
			var fap_jobfair_set_nm = $("#fap_jobfair_set_nm").val();
			var fap_jobfair_set_addr = $("#fap_jobfair_set_addr").val();
			var fap_jobfair_set_comp_sd = $("#fap_jobfair_set_comp_sd").val();
			var fap_jobfair_set_comp_ed = $("#fap_jobfair_set_comp_ed").val();
			var fap_jobfair_set_comp_st = $("#fap_jobfair_set_comp_st").val();
			var fap_jobfair_set_comp_et = $("#fap_jobfair_set_comp_et").val();
			var fap_jobfair_set_st = $("#jobfair_st").val();
			var fap_jobfair_set_et = $("#jobfair_et").val();
			var fap_jobfair_set_room_st = $("#jobfair_room_st").val();
			var fap_jobfair_set_room_et = $("#jobfair_room_et").val();
			var fap_jobfair_set_room_cnt = $("#fap_jobfair_set_room_cnt").val();
			var fap_jobfair_set_itv_cnt = $("#fap_jobfair_set_itv_cnt").val();
			var fap_jobfair_set_itv_stu_dt = $("#fap_jobfair_set_itv_stu_dt").val();
			var fap_jobfair_set_itv_comp_dt = $("#fap_jobfair_set_itv_comp_dt").val();
			
			if(checkValidation(fap_jobfair_set_nm)){
				alert("현지잡페어 일정 명칭을 입력해 주세요");
				return false;
			}
			if(checkValidation(fap_jobfair_set_addr)){
				alert("현지잡페어 장소를 입력해 주세요");
				return false;
			}
			if(checkValidation(fap_jobfair_set_st)){
				alert("현지잡페어 시작일을 입력해 주세요");
				return false;
			}
			if(checkValidation(fap_jobfair_set_et)){
				alert("현지잡페어 종료일을 입력해 주세요");
				return false;
			}
			if(checkValidation(fap_jobfair_set_room_st)){
				alert("현지잡페어 면접장 시작시간을 입력해 주세요");
				return false;
			}
			if(checkValidation(fap_jobfair_set_room_et)){
				alert("현지잡페어 면접장 종료시간을 입력해 주세요");
				return false;
			}
			if(checkValidation(fap_jobfair_set_room_cnt)){
				alert("현지잡페어 면접장 개수를 입력해 주세요");
				return false;
			}
			if(checkValidation(fap_jobfair_set_itv_cnt)){
				alert("지원자의 하루 최대 면접 횟수를 입력해 주세요");
				return false;
			}
			if(checkValidation(fap_jobfair_set_itv_stu_dt)){
				alert("동일 면접자 다음 면접 준비시간 간격을 입력해 주세요");
				return false;
			}
			if(checkValidation(fap_jobfair_set_itv_comp_dt)){
				alert("다음 면접회사 준비시간 간격을 입력해 주세요");
				return false;
			}
			
			var fap_jobfair_set = {
					fap_jobfair_set_seq : fap_jobfair_set_seq,
					fap_jobfair_divide_seq : fap_jobfair_divide_seq,
					fap_jobfair_set_nm : fap_jobfair_set_nm,
					fap_jobfair_set_addr : fap_jobfair_set_addr,
					fap_jobfair_set_comp_sd : fap_jobfair_set_comp_sd,
					fap_jobfair_set_comp_ed : fap_jobfair_set_comp_ed,
					fap_jobfair_set_comp_st : fap_jobfair_set_comp_st,
					fap_jobfair_set_comp_et : fap_jobfair_set_comp_et,
					fap_jobfair_set_st : fap_jobfair_set_st,
					fap_jobfair_set_et : fap_jobfair_set_et,
					fap_jobfair_set_room_st : fap_jobfair_set_room_st,
					fap_jobfair_set_room_et : fap_jobfair_set_room_et,
					fap_jobfair_set_room_cnt : fap_jobfair_set_room_cnt,
					fap_jobfair_set_itv_cnt : fap_jobfair_set_itv_cnt,
					fap_jobfair_set_itv_stu_dt : fap_jobfair_set_itv_stu_dt,
					fap_jobfair_set_itv_comp_dt : fap_jobfair_set_itv_comp_dt
			};

			var fap_jobfair_set_date_info_arr = [];
			
			$(".calendar_table").each(function(index,item){
				var cal = $(this);
				var fap_jobfair_set_date_dt = $(item).find(".scheduleTitle").html();
				
				$(item).find(".room").each(function(){
					var eq = $(this).index();
					var fap_jobfair_set_date_room_num = $(this).attr("num");
					var fap_jobfair_set_date_room_hid_gb = $(this).find(".room_ck").prop("checked") ? "E0201" : "E0200" ;
					var fap_jobfair_set_time_arr = [];
					
					cal.find("tr").find('td:eq('+eq+').merged').each(function(){
						var fap_jobfair_set_time = $(this).attr("time");
						var fap_jobfair_set_time_merge_num = $(this).attr("rowSpan");
						var fap_jobfair_set_time_ct = $(this).html();
						
						var fap_jobfair_set_time_info = {
								fap_jobfair_set_time : fap_jobfair_set_time,
								fap_jobfair_set_time_merge_num : fap_jobfair_set_time_merge_num,
								fap_jobfair_set_time_ct : fap_jobfair_set_time_ct
						};
						
						fap_jobfair_set_time_arr.push(fap_jobfair_set_time_info);
					});
					
					var fap_jobfair_set_date_info = {
							fap_jobfair_set_date_dt : fap_jobfair_set_date_dt,
							fap_jobfair_set_date_room_num : fap_jobfair_set_date_room_num,
							fap_jobfair_set_date_room_hid_gb : fap_jobfair_set_date_room_hid_gb,
							fap_jobfair_set_time_arr : fap_jobfair_set_time_arr
					};

					fap_jobfair_set_date_info_arr.push(fap_jobfair_set_date_info);
				
				});
				
			});
			
			fap_jobfair_set.fap_jobfair_set_date_info_arr = fap_jobfair_set_date_info_arr;
			
			console.log(fap_jobfair_set);
			
			$.ajax({
				beforeSend: function(xhr) {
				     xhr.setRequestHeader("AJAX", true);
				},
				url : '/fap/admin/tokyofair_schedule_update',
				type : 'post',
				contentType : 'application/json',
				data : JSON.stringify(fap_jobfair_set),
		        dataType : "json", 
				success : function(response) {
					location.href = "/fap/admin/tokyofair_schedule_management";
				},
				error : function(response){
					console.log(response);
					if(response.status == 403){
						alert('<spring:message code="com.login.ajaxSesstion" javaScriptEscape="true" />');
						location.href = "/fap/admin/admin_login";
					}
				}
			});
			
		});
		
		function checkValidation(val){
			return $.trim(val) == '' ? true : false; 
		}
		
	});
	
	function layerInit(){
		$("#layer_tx").val("");
		$("#take_time").find("option:first").prop("selected",true);
		
		$(".layer_title").html("");
		$(".layer_st").html("");
		$(".layer_dt").html("");
		$(".layer_room").html("");
	}
	
	function calInit(){
		var jobfair_st = $("#jobfair_st").val();
		var jobfair_et = $("#jobfair_et").val();
		var jobfair_room_st = $("#jobfair_room_st").val();
		var jobfair_room_et = $("#jobfair_room_et").val();
		var fap_jobfair_set_room_cnt = parseInt($("#fap_jobfair_set_room_cnt").val());
		
		if(jobfair_st == '' || jobfair_et == '' || jobfair_room_st == '' || jobfair_room_et == ''){
			alert("일정을 입력해 주세요.");
			return false;
		}
		
		var time_st = parseInt(jobfair_room_st.substring(0,2));
		var time_et = parseInt(jobfair_room_et.substring(0,2));
		
		 var caltest = $(".plugInTest").PACalendar({
		    	startDate : jobfair_st,
		    	endDate : jobfair_et,
		    	startTime : time_st,
		    	endTime : time_et,
		    	roomCount : fap_jobfair_set_room_cnt,
		    	hiddenFlag : true
		    });
			
			$(".c_td").off().on("click",function(index,item){
				
				$elm = $(this);
				
				$(".c_td").removeClass("ck");
				$(this).addClass("ck");
				
				var room = $(this).attr("room");
				var st = $(this).attr("time");
				
				$("#calendar_layer .pop-contents .st").html(st);
				$("#calendar_layer .pop-contents .room").html(room);
				
				if($(this).hasClass("merged")){
					$(".layer_title").html($(this).html());
					$("#calendar_layer_ck .pop-contents .layer_st").html(st);
					$("#calendar_layer_ck .pop-contents .layer_room").html(room);
					var rowSpan = $(this).attr("rowspan");
					var dt = rowSpan * 10;
					$("#calendar_layer_ck .pop-contents .layer_dt").html(dt+'<spring:message code="fap.calendar.min" />');
					layer_popup("#calendar_layer_ck");
					return ;
				}
				
				layer_popup("#calendar_layer");
				
			});
			
			$(".c_td").hover(
				function(){
					$(this).addClass("td_hover");
					$(this).prevAll("td:first-child").addClass("th_hover");
			}, function(){
					$(this).removeClass("td_hover");
					$(this).prevAll("td:first-child").removeClass("th_hover");
			})
	}
	
</script>

</head>
<%@include file="admin_menu.jsp"%>
	<br>
	<div class="page_title">
		<h2>알고리즘 현지 잡페어 설정 등록</h2>
	</div>
	<br>
<body  ng-app="myapp" ng-controller="AdminController">
	<a href="/fap/admin/tokyofair_schedule_management">목록으로 가기</a>
		<input type="hidden" id="fap_jobfair_divide_seq" value="${result.tokyofairSet.fap_jobfair_divide_seq }">
		<input type="hidden" id="fap_jobfair_set_seq" value="${fap_jobfair_set_seq}">
		<table class="search_box">
			<tr>
				<th>일정 명칭</th>
				<td>
					<input type="text" id="fap_jobfair_set_nm" size="30" value="${result.tokyofairSet.fap_jobfair_set_nm }">
				</td>
			</tr>
			<tr>
				<th>면접장소</th>
				<td>
					<input type="text" id="fap_jobfair_set_addr" size="30"  value="${result.tokyofairSet.fap_jobfair_set_addr }">
				</td>
			</tr>
			<tr>
				<th>잡페어 일정</th>
				<td>
					시작<input type="text" id="jobfair_st" name="fap_jobfair_set_st"  value="${result.tokyofairSet.fap_jobfair_set_st }"> ~ 종료<input type="text" id="jobfair_et" name="fap_jobfair_set_et"  value="${result.tokyofairSet.fap_jobfair_set_et }">
				</td>
			</tr>
			<tr>
				<th>기업 등록 일정</th>
				<td>
					시작<input type="text" id="fap_jobfair_set_comp_sd" name="fap_jobfair_set_comp_sd" value="${result.tokyofairSet.fap_jobfair_set_comp_sd   }"><input type="text" id="fap_jobfair_set_comp_st" name="fap_jobfair_set_comp_st" value="${result.tokyofairSet.fap_jobfair_set_comp_st   }"> ~ 종료<input type="text" id="fap_jobfair_set_comp_ed" name="fap_jobfair_set_comp_ed" value="${result.tokyofairSet.fap_jobfair_set_comp_ed   }"><input type="text" id="fap_jobfair_set_comp_et" name="fap_jobfair_set_comp_et" value="${result.tokyofairSet.fap_jobfair_set_comp_et   }">
				</td>
			</tr>
			<tr>
				<th>면접장 개수</th>
				<td>
					<input type="number" name="fap_jobfair_set_room_cnt" id="fap_jobfair_set_room_cnt" value="${result.tokyofairSet.fap_jobfair_set_room_cnt }">
				</td>
			</tr>
			<tr>
				<th>지원자의 하루 최대 면접 횟수</th>
				<td>
					<input type="number" name="fap_jobfair_set_itv_cnt" id="fap_jobfair_set_itv_cnt" value="${result.tokyofairSet.fap_jobfair_set_itv_cnt }">
				</td>
			</tr>
			<tr>
				<th>면접장 사용 시간</th>
				<td>
					시작<input type="text" id="jobfair_room_st" name="fap_jobfair_set_room_st"  value="${result.tokyofairSet.fap_jobfair_set_room_st }"> ~ 종료<input type="text" id="jobfair_room_et" name="fap_jobfair_set_room_et"  value="${result.tokyofairSet.fap_jobfair_set_room_et }"> 
				</td>
			</tr>
			<tr>
				<th>동일 면접자 다음 면접 준비시간 간격</th>
				<td>
					<select name="fap_jobfair_set_itv_stu_dt" id="fap_jobfair_set_itv_stu_dt"  dt="${result.tokyofairSet.fap_jobfair_set_itv_stu_dt }">
						<option value="60">60분</option>
						<option value="70">70분</option>
						<option value="80">80분</option>
						<option value="90">90분</option>
						<option value="100">100분</option>
						<option value="110">110분</option>
						<option value="120">120분</option>
					</select>
				</td>
			</tr>
			<tr>
				<th>다음 면접회사 준비시간 간격</th>
				<td>
					<select name="fap_jobfair_set_itv_comp_dt" id="fap_jobfair_set_itv_comp_dt"  dt="${result.tokyofairSet.fap_jobfair_set_itv_comp_dt }">
						<option value="30">30분</option>
						<option value="40">40분</option>
						<option value="50">50분</option>
						<option value="60">60분</option>
					</select>
				</td>
			</tr>
		</table>
			
			
	<input type="button" id="calendarBtn" value="달력설정">
	<input type="button" id="updateBtn" value="수정">
	
	<div class="dim-layer">
	    <div class="dimBg"></div>
	    <div id="calendar_layer" class="pop-layer">
	        <div class="pop-container">
	            <div class="pop-conts">
	                <!--content //-->
					<div class="pop-contents hd">
						<b>참가 불가능 시간 선택</b>
					</div>
					<div class="pop-contents">
						<p>
							<span>표시 문구</span>
							<input type="text" id="layer_tx">
						</p>
						<p>
							<span>면접실</span> : <span class="room"></span>
						</p>
						<p>
							<span>시작시간</span> : <span class="st"></span>
						</p>
						<p>
							<span>소요시간</span>
							<select id="take_time">
								<option value="3">30분</option>
								<option value="6">60분</option>
								<option value="9">90분</option>
								<option value="12">120분</option>
								<option value="15">150분</option>
								<option value="18">180분</option>
								<option value="21">210분</option>
								<option value="24">240분</option>
								<option value="27">270분</option>
								<option value="30">300분</option>
								<option value="33">330분</option>
								<option value="36">360분</option>
							</select>							
						</p>
					</div>
	                <div class="btn-r">
	                    <a href="javascript:void(0);" class="btn-layerSave">저장</a>
	                    <a href="#" class="btn-layerClose">Close</a>
	                </div>
	                <!--// content-->
	            </div>
	        </div>
	    </div>
	</div>
	
	<div class="dim-layer">
	    <div class="dimBg"></div>
	    <div id="calendar_layer_ck" class="pop-layer">
	        <div class="pop-container">
	            <div class="pop-conts">
	                <!--content //-->
					<div class="pop-contents hd">
						<b>참가 불가능 시간 선택</b>
					</div>
					<div class="pop-contents">
						<p>
							<span>표시 문구</span> : <span class="layer_title"></span>
						</p>
						<p>
							<span>면접실</span> : <span class="layer_room"></span>
						</p>
						<p>
							<span>시작시간</span> : <span class="layer_st"></span>
						</p>
						<p>
							<span>소요시간</span> : <span class="layer_dt"></span>					
						</p>
					</div>
	                <div class="btn-r">
	                    <a href="javascript:void(0);" class="btn-layerDelete">삭제</a>
	                    <a href="#" class="btn-layerClose">Close</a>
	                </div>
	                <!--// content-->
	            </div>
	        </div>
	    </div>
	</div>
	
	<div class="plugInTest">
	
	</div>
	
</body>
</html>
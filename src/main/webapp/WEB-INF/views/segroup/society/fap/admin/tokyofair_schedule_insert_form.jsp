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
			var jobfair_st = $("#jobfair_st").val();
			var jobfair_et = $("#jobfair_et").val();
			var jobfair_room_st = $("#jobfair_room_st").val();
			var jobfair_room_et = $("#jobfair_room_et").val();
			var fap_jobfair_set_room_cnt = parseInt($("#fap_jobfair_set_room_cnt").val());
			
			if(jobfair_st == '' || jobfair_et == '' || jobfair_room_st == '' || jobfair_room_et == ''){
				alert("????????? ????????? ?????????.");
				return false;
			}
			
			var time_st = parseInt(jobfair_room_st.substring(0,2));
			var time_et = parseInt(jobfair_room_et.substring(0,2));
			
			if(confirm("???????????? ????????? ???????????? ????????? ?????? ?????? ????????? ???????????????.\n ?????????????????????????")){
				$(".plugInTest").empty();
			}else{
				return;
			}
			
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
		
		
		$("#insertBtn").on("click",function(){
			
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
				alert("??????????????? ?????? ????????? ????????? ?????????");
				return false;
			}
			if(checkValidation(fap_jobfair_set_addr)){
				alert("??????????????? ????????? ????????? ?????????");
				return false;
			}
			if(checkValidation(fap_jobfair_set_comp_sd)){
				alert("???????????? ???????????? ????????? ?????????");
				return false;
			}
			if(checkValidation(fap_jobfair_set_comp_ed)){
				alert("???????????? ???????????? ????????? ?????????");
				return false;
			}
			if(checkValidation(fap_jobfair_set_comp_st)){
				alert("???????????? ??????????????? ????????? ?????????");
				return false;
			}
			if(checkValidation(fap_jobfair_set_comp_et)){
				alert("???????????? ??????????????? ????????? ?????????");
				return false;
			}
			if(checkValidation(fap_jobfair_set_st)){
				alert("??????????????? ???????????? ????????? ?????????");
				return false;
			}
			if(checkValidation(fap_jobfair_set_et)){
				alert("??????????????? ???????????? ????????? ?????????");
				return false;
			}
			if(checkValidation(fap_jobfair_set_room_st)){
				alert("??????????????? ????????? ??????????????? ????????? ?????????");
				return false;
			}
			if(checkValidation(fap_jobfair_set_room_et)){
				alert("??????????????? ????????? ??????????????? ????????? ?????????");
				return false;
			}
			if(checkValidation(fap_jobfair_set_room_cnt)){
				alert("??????????????? ????????? ????????? ????????? ?????????");
				return false;
			}
			if(checkValidation(fap_jobfair_set_itv_cnt)){
				alert("???????????? ?????? ?????? ?????? ????????? ????????? ?????????");
				return false;
			}
			if(checkValidation(fap_jobfair_set_itv_stu_dt)){
				alert("?????? ????????? ?????? ?????? ???????????? ????????? ????????? ?????????");
				return false;
			}
			if(checkValidation(fap_jobfair_set_itv_comp_dt)){
				alert("?????? ???????????? ???????????? ????????? ????????? ?????????");
				return false;
			}
			
			var fap_jobfair_set = {
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
			
			$.ajax({
				beforeSend: function(xhr) {
				     xhr.setRequestHeader("AJAX", true);
				},
				url : '/fap/admin/tokyofair_schedule_insert',
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
	
</script>

</head>
<%@include file="admin_menu.jsp"%>
	<br>
	<div class="page_title">
		<h2>???????????? ?????? ????????? ?????? ??????</h2>
	</div>
	<br>
<body  ng-app="myapp" ng-controller="AdminController">
	<a href="/fap/admin/tokyofair_schedule_management">???????????? ??????</a>
		<input type="hidden" id="fap_jobfair_divide_seq" value="${fap_jobfair_divide_seq }">
		<table class="search_box">
			<tr>
				<th>?????? ??????</th>
				<td>
					<input type="text" id="fap_jobfair_set_nm" size="30">
				</td>
			</tr>
			<tr>
				<th>????????????</th>
				<td>
					<input type="text" id="fap_jobfair_set_addr" size="30">
				</td>
			</tr>
			<tr>
				<th>????????? ??????</th>
				<td>
					??????<input type="text" id="jobfair_st" name="fap_jobfair_set_st"> ~ ??????<input type="text" id="jobfair_et" name="fap_jobfair_set_et">
				</td>
			</tr>
			<tr>
				<th>?????? ?????? ??????</th>
				<td>
					??????<input type="text" id="fap_jobfair_set_comp_sd" name="fap_jobfair_set_comp_sd"><input type="text" id="fap_jobfair_set_comp_st" name="fap_jobfair_set_comp_st"> ~ ??????<input type="text" id="fap_jobfair_set_comp_ed" name="fap_jobfair_set_comp_ed"><input type="text" id="fap_jobfair_set_comp_et" name="fap_jobfair_set_comp_et">
				</td>
			</tr>
			<tr>
				<th>????????? ??????</th>
				<td>
					<input type="number" name="fap_jobfair_set_room_cnt" id="fap_jobfair_set_room_cnt">
				</td>
			</tr>
			<tr>
				<th>???????????? ?????? ?????? ?????? ??????</th>
				<td>
					<input type="number" name="fap_jobfair_set_itv_cnt" id="fap_jobfair_set_itv_cnt">
				</td>
			</tr>
			<tr>
				<th>????????? ?????? ??????</th>
				<td>
					??????<input type="text" id="jobfair_room_st" name="fap_jobfair_set_room_st"> ~ ??????<input type="text" id="jobfair_room_et" name="fap_jobfair_set_room_et"> 
				</td>
			</tr>
			<tr>
				<th>?????? ????????? ?????? ?????? ???????????? ??????</th>
				<td>
					<select name="fap_jobfair_set_itv_stu_dt" id="fap_jobfair_set_itv_stu_dt">
						<option value="60">60???</option>
						<option value="70">70???</option>
						<option value="80">80???</option>
						<option value="90">90???</option>
						<option value="100">100???</option>
						<option value="110">110???</option>
						<option value="120">120???</option>
					</select>
				</td>
			</tr>
			<tr>
				<th>?????? ???????????? ???????????? ??????</th>
				<td>
					<select name="fap_jobfair_set_itv_comp_dt" id="fap_jobfair_set_itv_comp_dt">
						<option value="30">30???</option>
						<option value="40">40???</option>
						<option value="50">50???</option>
						<option value="60">60???</option>
					</select>
				</td>
			</tr>
		</table>
			
			
	<input type="button" id="calendarBtn" value="????????????">
	<input type="button" id="insertBtn" value="??????">
	
	<div class="dim-layer">
	    <div class="dimBg"></div>
	    <div id="calendar_layer" class="pop-layer">
	        <div class="pop-container">
	            <div class="pop-conts">
	                <!--content //-->
					<div class="pop-contents hd">
						<b>?????? ????????? ?????? ??????</b>
					</div>
					<div class="pop-contents">
						<p>
							<span>?????? ??????</span>
							<input type="text" id="layer_tx">
						</p>
						<p>
							<span>?????????</span> : <span class="room"></span>
						</p>
						<p>
							<span>????????????</span> : <span class="st"></span>
						</p>
						<p>
							<span>????????????</span>
							<select id="take_time">
								<option value="3">30???</option>
								<option value="6">60???</option>
								<option value="9">90???</option>
								<option value="12">120???</option>
								<option value="15">150???</option>
								<option value="18">180???</option>
								<option value="21">210???</option>
								<option value="24">240???</option>
								<option value="27">270???</option>
								<option value="30">300???</option>
								<option value="33">330???</option>
								<option value="36">360???</option>
							</select>							
						</p>
					</div>
	                <div class="btn-r">
	                    <a href="javascript:void(0);" class="btn-layerSave">??????</a>
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
						<b>?????? ????????? ?????? ??????</b>
					</div>
					<div class="pop-contents">
						<p>
							<span>?????? ??????</span> : <span class="layer_title"></span>
						</p>
						<p>
							<span>?????????</span> : <span class="layer_room"></span>
						</p>
						<p>
							<span>????????????</span> : <span class="layer_st"></span>
						</p>
						<p>
							<span>????????????</span> : <span class="layer_dt"></span>					
						</p>
					</div>
	                <div class="btn-r">
	                    <a href="javascript:void(0);" class="btn-layerDelete">??????</a>
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
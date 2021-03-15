<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Bridge Job Fair</title>
	<script src="<c:url value="/resources/segroup/js/jquery-3.1.1.js" />"></script>
	<script src="<c:url value="/resources/segroup/js/jquery-ui.js" />"></script>
	<script src="<c:url value="/resources/segroup/js/angular.min.js" />"></script>
	<script src="<c:url value="/resources/segroup/js/datepicker.js" />"></script>
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	<script type="text/javascript">
	var _selectRange = false, _deselectQueue = [];
	var checkGubun = false;

	var myApp = angular.module('myapp', []);
	
	myApp.controller('CompanyController', ['$scope','$compile','$http', function($scope,$compile,$http){
		
		$scope.result = ${result};
		
		$scope.range = function(min, max, step) {
	        // parameters validation for method overloading
	        if (max == undefined) {
	            max = min;
	            min = 0;
	        }
	        step = Math.abs(step) || 1;
	        if (min > max) {
	            step = -step;
	        }
	        // building the array
	        var output = [];
	        for (var value=min; value<max; value+=step) {
	            output.push(value);
	        }
	        // returning the generated array
	        return output;
	    };
		
		$scope.selectCheck = function(){
			
			var jobfair_st = $scope.result.fap_jobfair_set_st;
			var jobfair_et = $scope.result.fap_jobfair_set_et;
			var jobfair_room_st = $scope.result.fap_jobfair_set_room_st;
			var jobfair_room_et = $scope.result.fap_jobfair_set_room_et;
			
			var time_st = parseInt(jobfair_room_st.substring(0,2));
			var time_et = parseInt(jobfair_room_et.substring(0,2));
			
			var diffDate_1 = jobfair_st instanceof Date ? jobfair_st : new Date(jobfair_st);
		    var diffDate_2 = jobfair_et instanceof Date ? jobfair_et : new Date(jobfair_et);
		 
		    diffDate_1 = new Date(diffDate_1.getFullYear(), diffDate_1.getMonth(), diffDate_1.getDate());
		    diffDate_2 = new Date(diffDate_2.getFullYear(), diffDate_2.getMonth(), diffDate_2.getDate());
		 
		    var diff = Math.abs(diffDate_2.getTime() - diffDate_1.getTime());
		    diff = Math.ceil(diff / (1000 * 3600 * 24));
		    
		    $scope.diff = diff;
		    
		    var lastLength = $scope.result.setting_time_list.length - 1;
			var list = $scope.result.setting_time_list;
			
			 var context = '참가 불가능한 시간을 선택해 주세요.<br>';
			context += '<table>';			
			context += '<tr>';			
			context += '<th></th>';
			for(var i=0; i <=diff; i++){
				var dummyDate = new Date(diffDate_1.getFullYear(), diffDate_1.getMonth(), diffDate_1.getDate()+i);
				context += '<th>'+dummyDate.format("yyyy-MM-dd")+'</th>';			
			}
			context += '</tr>';
			
			$.each(list , function(index, item){
				//마지막
				if(index == lastLength){
					context += '<td day="'+item.fap_jobfair_set_time_dt+'" ng-class="{\'disabled\' : \''+item.fap_jobfair_set_time_room_gb+'\' == \'E0101\'}"></td>';
					context += '</tr>';
				}else{
					//처음
					if(index == 0){
						context += '<tr class="day-list">';
						context += '<th time="'+item.fap_jobfair_set_time_room_dt+'">';
						context += item.fap_jobfair_set_time_room_dt+':00'+"~"+(parseInt(item.fap_jobfair_set_time_room_dt)+1)+':00';
						context += '</th>';
						context += '<td day="'+item.fap_jobfair_set_time_dt+'" ng-class="{\'disabled\' : \''+item.fap_jobfair_set_time_room_gb+'\' == \'E0101\'}"></td>';
					}
					//시간이 같다면
					else if(list[index].fap_jobfair_set_time_room_dt == list[index+1].fap_jobfair_set_time_room_dt){
						context += '<td day="'+item.fap_jobfair_set_time_dt+'" ng-class="{\'disabled\' : \''+item.fap_jobfair_set_time_room_gb+'\' == \'E0101\'}"></td>';
					}
					//시간이 바뀌면
					else{
						context += '<td day="'+item.fap_jobfair_set_time_dt+'" ng-class="{\'disabled\' : \''+item.fap_jobfair_set_time_room_gb+'\' == \'E0101\'}"></td>';
						context += '</tr>';
						context += '<tr class="day-list">';
						context += '<th time="'+list[index+1].fap_jobfair_set_time_room_dt+'">';
						context += list[index+1].fap_jobfair_set_time_room_dt+':00'+"~"+(parseInt(list[index+1].fap_jobfair_set_time_room_dt)+1)+':00';
						context += '</th>';
					}
				}
				
				
			});
			context += '</table>';			
			
			$("#calendarDiv").html(context);
			$compile("#calendarDiv")($scope);
			$scope.$digest();
			
			selectableBind();
		}
		
	}]);
	
	$(function() {			
		angular.element("#myBody").scope().selectCheck();
	})
	
	function selectableBind(){
		
		$.each($(".day-list > td"), function(index,item){
			if($(this).hasClass("disabled")){
				$(this).attr("gubun","E0202");
			}else{
				$(this).attr("gubun","E0200");
			}
		});
		
		$(".week-days").selectable({
		    filter: ".day-list > td:not(.disabled)",
		    selecting: function (event, ui) {
		    	
	            $(ui.selecting).attr("gubun", "E0201");
	            
	            if ($(ui.selecting).hasClass('ui-selected')) {
	                _deselectQueue.push(ui.selecting);
	                $(ui.selecting).attr("gubun", "E0200");
	            }
	            
	        },
	        unselecting: function (event, ui) {
	        	$(ui.unselecting).addClass('ui-selected');
	        },
	        stop: function () {
	            if (!_selectRange) {
	                $.each(_deselectQueue, function (ix, de) {
	                    $(de)
	                        .removeClass('ui-selecting')
	                        .removeClass('ui-selected');
	                });
	            }
	            _selectRange = false;
	            _deselectQueue = [];
	        }
		  });
		
		checkGubun = true;
	}
	
	function formCheck(){
		
		var context = '';
		$.each($(".day-list > td"),function(index, item){
			var day = $( this ).attr("day");
            var time = $( this ).prevAll("th").attr("time");
            var gubun = $( this ).attr("gubun");
            var fap_job_ad_seq = $("#fap_job_ad_seq").val();
			context +='<input type="hidden" name="setTimeList['+index+'].fap_job_ad_seq" value="'+fap_job_ad_seq+'">';
			context +='<input type="hidden" name="setTimeList['+index+'].fap_la_job_plan_dt" value="'+day+'">';
			context +='<input type="hidden" name="setTimeList['+index+'].fap_la_job_plan_tm" value="'+time+'">';
			context +='<input type="hidden" name="setTimeList['+index+'].fap_la_job_plan_gb" value="'+gubun+'">';
		});
		
		$("#settingInfoDiv").html(context);
		return checkGubun;
	}
	</script>
	<style type="text/css">
		.day-list .ui-selecting {
		  background: #FECA40;
		  border-color: #999;
		}
		
		.day-list .ui-selected {
		  background: #F39814;
		  color: white;
		  border: 2px solid #000;
		}
		
		.day-list td {
		  margin: 3px;
		  padding: 0.2em;
		  font-size: 1.3em;
		  height: 18px;
		  border: 2px solid #eee;
		}
		.disabled {
			background-color: #ccc;
		}
	</style>
</head>
<body id="myBody" ng-app="myapp" ng-controller="CompanyController">
	<form action="algorithm_calendar_setting_insert" method="post" onsubmit="return formCheck()">
		<input type="hidden" name="fap_job_ad_seq" id="fap_job_ad_seq" value="${fap_job_ad_seq}">
		
		<span>{{diff+1}}</span>일 중
		<select name="fap_la_job_set_join_dt">
			<option ng-repeat="i in range(diff+1)" value="{{i + 1}}">{{i + 1}}</option>
		</select>
		일 참가가능 전형은
		<select name="fap_la_job_set_itv_dt">
			<option value="1">1</option>
			<option value="2">2</option>
		</select>
		일 동안 진행
		
		<div id="calendarDiv" class="week-days"></div>
			
		<div id="settingInfoDiv"></div>
		<input type="submit" value="다음">
	</form>
</body>
</html>
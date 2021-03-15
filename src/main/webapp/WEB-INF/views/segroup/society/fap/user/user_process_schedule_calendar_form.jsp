<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Bridge Job Fair</title>
	<link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
	<script src="<c:url value="/resources/segroup/js/jquery-3.1.1.js" />"></script>
	<script src="<c:url value="/resources/segroup/js/jquery-ui.js" />"></script>
	<script src="<c:url value="/resources/segroup/js/angular.min.js" />"></script>
	<link rel="stylesheet" href="/resources/segroup/society/fap/css/fullcalendar.css">
	<link rel="stylesheet" href="/resources/segroup/society/fap/css/fullcalendar.print.css" media="print">
	<script src="<c:url value="/resources/segroup/society/fap/js/moment.min.js" />"></script>
	<script src="<c:url value="/resources/segroup/society/fap/js/fullcalendar.js" />"></script>	
	<script src="<c:url value="/resources/segroup/society/fap/js/locale-all.js" />"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
	<link rel="stylesheet" type="text/css" href="<c:url value="/resources/segroup/society/fap/css/default.css" />" />

	<style type="text/css">
	    body {
	        margin :0px 10px;
	        padding : 0;
	        font-family : "Lucida Grande", Helvetica, Arial, Verdana,sans-serif;
	        font-size : 14px;
	    }	    
	    #calendar {
	        max-width : 1150px;
	        margin : 0 auto;
	    }
	    
	   .fc-sat {color : blue;}
	   .fc-sun {color : red;}
	   
	</style>
	<script type="text/javascript">
		var myApp = angular.module('myapp', []);		
		myApp.controller('CalendarController', ['$scope','$compile','$http', function($scope,$compile,$http){
				
			//오늘 날짜 설정
			var today = new Date();
			var dd = today.getDate();
			var mm = today.getMonth() + 1;
			var yyyy = today.getFullYear();
			
			if(dd < 10){
				dd = '0' + dd;
			}
			if(mm < 10){
				mm = '0' + mm;
			}	
			today = mm + '/' + dd + '/' + yyyy
			
			//언어 설정
			var initialLocaleCode = 'ko';		
			
		    $(document).ready(function() {				    			
		    	
		    	//FullCalendar
	    		$("#calendar").fullCalendar({
		            header : {
		            	left : 'clear'
		            	, center : 'title'
		            	, right : 'prev, next today'
		            }
			    	, defaultDate : today
			    	, navLinks : false		//월,주별 달력에서 일자를 클릭하면 일별보기로 전환하는 기능을 사용할지 여부 결정
			        , locale: "ko"		//지역 언어 : 한국어
			        , eventDurationEditable : true		//이벤트를 드래그하고 크기를 조정할 수 있는지 결정
			        , editable : false	//실행된 달력에서 일정(event)을 표시한 바(bar)를 마우스 이동할 수 있게 하는 것
			        , eventLimit : true	//하루에 일정(event)을 3개만 보여주고 그 이상은 more로 처리할지 여부 결정
			        , selectable : true	//클릭하고 드래그해서 요일이나 시간대를 강조 표시
			        , textColor : 'black'
			        , timeFormat : 'HH:mm'	        
		            , events: function(start, end, timezone, callback) {
		    			$.ajax({
		    				beforeSend: function(xhr) {
		    				     xhr.setRequestHeader("AJAX", true);
		    				}
		    				, url : '/fap/user/user_recruit_process_schedule_select'
		    				, type : 'post'	    				
		    				, success : function(data){
		    					console.log(data);
		    					var events=[];
		    					$.each(data, function(index, value) {    						
		    						events.push({
	    		        				id : value.schedule_seq
	    		        				, title : value.schedule_title
	    		        				, start : value.date_start
	    		        				, end : value.date_end
	    		    					, backgroundColor : value.schedule_color
	    		    					, content : value.schedule_gb
	    		    					, textColor : 'black'
	    							});
		    		            });
		    					callback(events);     					
		    				},
		    				error:function(e){
		    					console.log(e);
		    					if(e.status == 403){
		    						alert('<spring:message code="com.login.ajaxSesstion" javaScriptEscape="true" />');
		    						location.href = "/fap/user/user_login";
		    					}
		    				}    				
		    			});  
		            }
		            ,eventClick : function(event){	            	
		            	//각 전형별 모달창 띄우기
	        			if(event.content == 'C2500'){
	        				reviewPcs(event.id);
	        			}
	        			if(event.content == 'C2501'){
	        				examPcs(event.id);
	        			}
	        			if(event.content == 'C2502'){
	        				itvPcs(event.id);
	        			}
	        			if(event.content == 'C2503'){
	        				testEtcPcs(event.id);
	        			}					
		            }
		        });  		
		    		
		    });		
		       
		 	 //설정할 서류전형 검색
			function reviewPcs(fap_job_recruit_pcs_seq){
				$http({
					method: 'POST',
					url: "/fap/user/user_review_process_select",
					params : {
						fap_job_recruit_pcs_seq : fap_job_recruit_pcs_seq
					},
					headers : {
						"AJAX" : true
					}
				}).then(function successCallback(reviewResponse) {
					$scope.review = reviewResponse.data;
					
					//서류전형 시작일
					if(reviewResponse.data.fap_job_recruit_pcs_sch_st != null){
						var st = reviewResponse.data.fap_job_recruit_pcs_sch_st.split(" ");
						$(".modal-body #fap_job_review_date_st").val(st[0]);
						$(".modal-body #fap_job_review_time_st").val(st[1]);
					}
					//서류전형 종료일
					if(reviewResponse.data.fap_job_recruit_pcs_sch_et != null){
						var et = reviewResponse.data.fap_job_recruit_pcs_sch_et.split(" ");					
						$(".modal-body #fap_job_review_date_et").val(et[0]);
						$(".modal-body #fap_job_review_time_et").val(et[1]);
					}											
					//서류전형 모달창
					$("#reviewModal").modal();
					
				}, function errorCallback(reviewResponse) {
					if(reviewResponse.status == 403){
						alert('<spring:message code="com.login.ajaxSesstion" javaScriptEscape="true" />');
						location.href = "/fap/user/user_login";
					}
				});
			}
    		
			//설정할 시험전형 검색
			function examPcs(fap_job_recruit_pcs_seq){
				$http({
					method: 'POST',
					url: "/fap/user/user_exam_process_select",
					params : {
						fap_job_recruit_pcs_seq : fap_job_recruit_pcs_seq
					},
					headers : {
						"AJAX" : true
					}
				}).then(function successCallback(examResponse) {
					$scope.exam = examResponse.data;
					
					//시험전형 시작일
					if(examResponse.data.fap_job_recruit_pcs_sch_st != null){
						var st = examResponse.data.fap_job_recruit_pcs_sch_st.split(" ");
						$(".modal-body #fap_job_exam_date_st").val(st[0]);
						$(".modal-body #fap_job_exam_time_st").val(st[1]);
					}
					//시험전형 종료일
					if(examResponse.data.fap_job_recruit_pcs_sch_et != null){
						var et = examResponse.data.fap_job_recruit_pcs_sch_et.split(" ");
						$(".modal-body #fap_job_exam_date_et").val(et[0]);
						$(".modal-body #fap_job_exam_time_et").val(et[1]);
					}							
					//시험전형 모달창
					$("#examModal").modal();
					
				}, function errorCallback(examResponse) {
					if(examResponse.status == 403){
						alert('<spring:message code="com.login.ajaxSesstion" javaScriptEscape="true" />');
						location.href = "/fap/user/user_login";
					}
				});
			}
			
			//설정할 면접전형 검색
			function itvPcs(fap_job_recruit_pcs_seq){
				$http({
					method: 'POST',
					url: '/fap/user/user_itv_process_select',
					params: {
						fap_job_recruit_pcs_seq : fap_job_recruit_pcs_seq
					},
					headers : {
						"AJAX" : true
					}
				}).then(function successCallback(itvResponse){
					$scope.itv = itvResponse.data;
					
					//면접전형 종료일
					if(itvResponse.data.fap_job_recruit_pcs_sch_st != null){
						var st = itvResponse.data.fap_job_recruit_pcs_sch_st.split(" ");
						$(".modal-body #fap_job_itv_date_st").val(st[0]);
						$(".modal-body #fap_job_itv_time_st").val(st[1]);	
					}
					//면접전형 종료일
					if(itvResponse.data.fap_job_recruit_pcs_sch_et != null){
						var et = itvResponse.data.fap_job_recruit_pcs_sch_et.split(" ");
						$(".modal-body #fap_job_itv_date_et").val(et[0]);
						$(".modal-body #fap_job_itv_time_et").val(et[1]);	
					}			
					//면접전형 모달창
					$("#itvModal").modal();
					
				}, function errorCallback(itvResponse){
					if(itvResponse.status == 403){
						alert('<spring:message code="com.login.ajaxSesstion" javaScriptEscape="true" />');
						location.href = "/fap/user/user_login";
					}
				});
			}
			
			//설정할 기타전형 검색
			 function testEtcPcs(fap_job_recruit_pcs_seq){
				$http({
					method: 'POST',
					url: '/fap/user/user_test_etc_process_select',
					params: {
						fap_job_recruit_pcs_seq : fap_job_recruit_pcs_seq
					},
					headers : {
						"AJAX" : true
					}
				}).then(function successCallback(testEtcResponse){
					$scope.etc = testEtcResponse.data;
					
					//기타전형 시작일
					if(testEtcResponse.data.fap_job_recruit_pcs_sch_st != null){
						var st = testEtcResponse.data.fap_job_recruit_pcs_sch_st.split(" ");
						$(".modal-body #fap_job_test_etc_date_st").val(st[0]);
						$(".modal-body #fap_job_test_etc_time_st").val(st[1]);
					}
					//기타전형 종료일
					if(testEtcResponse.data.fap_job_recruit_pcs_sch_et != null){
						var et = testEtcResponse.data.fap_job_recruit_pcs_sch_et.split(" ");
						$(".modal-body #fap_job_test_etc_date_et").val(et[0]);
						$(".modal-body #fap_job_test_etc_time_et").val(et[1]);
					}				
					//기타전형 모달창
					$("#testEtcModal").modal();
					
				}, function errorCallback(testEtcResponse){
					if(testEtcResponse.status == 403){
						alert('<spring:message code="com.login.ajaxSesstion" javaScriptEscape="true" />');
						location.href = "/fap/user/user_login";
					}
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
	<body id="myBody" ng-app="myapp" ng-controller="CalendarController">
	<%@include file="user_menu.jsp"%>
	<div id="calendar-contents">
		<div id="calendar">
		
		</div>
	</div>
	
	<!-- 서류전형 일정 MODAL 시작-->
	<div class="modal fade" id="reviewModal" tabindex="-1" role="dialog" aria-labelledby="modal" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
			
				<div class="modal-header">
					<h5 class="modal-title" id="modal"><spring:message code="fap.comp.review_pcs_sch" /></h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>				
				
				<div class="modal-body">											
					<div class="form-group">
						<div class="form-row">
							<ul>
								<li class="m6">
									<label><spring:message code="fap.comp.review_pcs_st" /></label>
								</li>
								<li class="m6">
									
								</li>
							</ul>
						</div>
						<div class="form-row">
							<ul>
								<li class="m6">
									<input type="text" id="fap_job_review_date_st" readonly="readonly" class="form-control blue bold">&emsp;
								</li>
								<li class="m6">
									<input type="text" id="fap_job_review_time_st" readonly="readonly" class="form-control blue bold">
								</li>
							</ul>
						</div>		
						<div class="form-row">
							<ul>
								<li class="m6">
									<label><spring:message code="fap.comp.review_pcs_et" /></label>
								</li>
								<li class="m6">
									
								</li>
							</ul>
						</div>
						<div class="form-row">
							<ul>
								<li class="m6">
									<input type="text" id="fap_job_review_date_et" readonly="readonly" class="form-control red bold">&emsp;
								</li>
								<li class="m6">
									<input type="text" id="fap_job_review_time_et" readonly="readonly" class="form-control red bold">
								</li>
							</ul>
						</div>							
					</div>
					<div class="form-row">
						<label><spring:message code="fap.comp.submission_doc_list" /></label>
					</div>
					<div class="form-row">
						<textarea id="fap_job_recruit_pcs_dtl" class="form-control" ng-model="review.fap_job_recruit_pcs_dtl" style="height: 100px;" readonly="readonly"></textarea>
					</div>					
				</div>
			</div>
		</div>
	</div>
	<!-- 서류전형 일정 MODAL 종료-->

	<!-- 시험전형 일정 MODAL 시작-->
	<div class="modal fade" id="examModal" tabindex="-1" role="dialog" aria-labelledby="modal" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
			
				<div class="modal-header">
					<h5 class="modal-title" id="modal"><spring:message code="fap.comp.exam_pcs_sch" /></h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>				
				
				<div class="modal-body">						
					<div class="form-group">
						<div class="form-row">
							<ul>
								<li class="m6">
									<label><spring:message code="fap.comp.exam_pcs_date_st" /></label>&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;
								</li>
								<li class="m6">
									<label><spring:message code="fap.comp.exam_pcs_time_st" /></label>
								</li>
							</ul>
						</div>
						<div class="form-row">
							<ul>
								<li class="m6">
									<input class="form-control blue bold" type="text" id="fap_job_exam_date_st" readonly="readonly">&emsp;
								</li>
								<li class="m6">
									<input class="form-control blue bold" type="text" id="fap_job_exam_time_st" readonly="readonly">
								</li>
							</ul>
						</div>
						<div class="form-row">
							<ul>
								<li class="m6">
									<label><spring:message code="fap.comp.exam_pcs_date_et" /></label>&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;
								</li>
								<li class="m6">
									<label><spring:message code="fap.comp.exam_pcs_time_et" /></label>
								</li>
							</ul>
						</div>
						<div class="form-row">
							<ul>
								<li class="m6">
									<input class="form-control red bold" type="text" id="fap_job_exam_date_et" readonly="readonly">&emsp;
								</li>
								<li class="m6">
									<input class="form-control red bold" type="text" id="fap_job_exam_time_et" readonly="readonly">
								</li>	
							</ul>
						</div>	
						<div class="form-row">
							<label><spring:message code="fap.comp.exam_lo" /></label>
						</div>
						<div class="form-row">
							<input type="text" id="fap_job_exam_pcs_sch_lo" class="form-control bold" value="{{exam.fap_job_recruit_pcs_sch_lo}}" readonly="readonly">
						</div>	
						<br>
						<div ng-hide="exam.fap_job_recruit_pcs_sch_detail == null || exam.fap_job_recruit_pcs_sch_detail == '' || exam.fap_job_recruit_pcs_sch_detail == undefined">	
							<div class="form-row" >
								<label><spring:message code="fap.comp.exam_detail" /></label>
							</div>
							<div class="form-row">
								<textarea class="form-control" id="fap_job_exam_pcs_sch_detail" maxlength="500" style="height: 100px;" readonly="readonly">{{exam.fap_job_recruit_pcs_sch_detail}}</textarea>
							</div>
						</div>									
					</div>	
					
					<div class="form-group">
						<div class="form-row form-row-bottom">
							<ul>
								<li>
									<label><spring:message code="fap.comp.exam_obj" /></label>
								</li>
								<li class="m3" >
									<select class="form-control" id="fap_job_exam_obj" ng-model="exam.fap_job_exam_obj" disabled="disabled">
										<option selectcode value="C2700"></option>
										<option selectcode value="C2701"></option>
										<option selectcode value="C2702"></option>
									</select>
								</li>
								
								<li class="m8">
									<input class="form-control" type="text" id="fap_job_exam_obj_etc_dtl" value="{{exam.fap_job_exam_obj_etc_dtl}}" readonly="readonly" ng-hide="exam.fap_job_exam_obj_etc_dtl == null || exam.fap_job_exam_obj_etc_dtl == undefined || exam.fap_job_exam_obj_etc_dtl == ''">
								</li>
							</ul>
						</div>
						<div class="form-row">
							<label><spring:message code="fap.comp.exam_gb" /></label>
						</div>
						<div class="form-row form-row-bottom">
							<ul>
								<li class="m6">
									<select class="form-control" id="fap_job_exam_gb" ng-model="exam.fap_job_exam_gb" disabled="disabled">
										<option selectcode value="C2600"></option>
										<option selectcode value="C2601"></option>
									</select>		
								</li>
							</ul>						
						</div>
						<div class="form-row">
							<label><spring:message code="fap.comp.exam_type_gb" /></label>
						</div>
						<div class="form-row form-row-bottom">
							<ul>
								<li class="m6" ng-repeat="fapExamType in exam.fapRecruitExamList">
									<select class="form-control" id="fap_job_exam_type_gb" ng-model="fapExamType.fap_job_exam_type_gb" disabled="disabled">
										<option selectcode value="C3200"></option>
										<option selectcode value="C3201"></option>
										<option selectcode value="C3202"></option>
										<option selectcode value="C3203"></option>
										<option selectcode value="C3204"></option>
										<option selectcode value="C3205"></option>
									</select>
								</li>
							</ul>										
						</div>
						<div class="form-row">
							<label><spring:message code="fap.comp.exam_tm" /></label>
						</div>
						<div class="form-row form-row-bottom">
							<ul>
								<li class="m6">
									<input class="form-control" type="text" id="fap_job_exam_tm" value="{{exam.fap_job_exam_tm}}" readonly="readonly">
								</li>
							</ul>
						</div>	
						<div class="form-row">
							<label><spring:message code="fap.comp.exam_need" /></label>
						</div>
						<div class="form-row form-row-bottom">
							<ul>
								<li class="m4" >
									<select class="form-control" id="fap_job_exam_need" ng-model="exam.fap_job_exam_need" disabled="disabled">
										<option selectcode value="C3000"></option>
										<option selectcode value="C3001"></option>
										<option selectcode value="C3002"></option>
									</select>
								</li>
								<li class="m7">
									<input class="form-control" type="text" id="fap_job_exam_need_etc_dtl" value="{{fap_job_exam_need_etc_dtl}}" readonly="readonly" ng-hide="fap_job_exam_need_etc_dtl == null || fap_job_exam_need_etc_dtl == undefined || fap_job_exam_need_etc_dtl == ''">
								</li>
							</ul>
						</div>
					</div>			
				</div>
			</div>
		</div>
	</div>
	<!-- 시험전형 일정 MODAL 종료-->
	
	<!-- 면접전형 일정 MODAL 시작-->
	<div class="modal fade" id="itvModal" tabindex="-1" role="dialog" aria-labelledby="modal" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
			
				<div class="modal-header">
					<h5 class="modal-title" id="modal"><spring:message code="fap.comp.itv_pcs_sch" /></h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>				
				
				<div class="modal-body">					
					<div class="form-group">
						<div class="form-row">
							<ul>
								<li class="m6">
									<label><spring:message code="fap.comp.itv_pcs_date_st" /></label>&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;
								</li>
								<li class="m6">
									<label><spring:message code="fap.comp.itv_pcs_time_st" /></label>
								</li>
							</ul>
						</div>
						<div class="form-row">
							<ul>
								<li class="m6">
									<input class="form-control blue bold" type="text" id="fap_job_itv_date_st" readonly="readonly">&emsp;
								</li>
								<li class="m6">
									<input class="form-control blue bold" type="text" id="fap_job_itv_time_st" readonly="readonly">
								</li>
							</ul>
						</div>
						<div class="form-row">
							<ul>
								<li class="m6">
									<label><spring:message code="fap.comp.itv_pcs_date_et" /></label>&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;
								</li>
								<li class="m6">
									<label><spring:message code="fap.comp.itv_pcs_time_et" /></label>
								</li>
							</ul>
						</div>
						<div class="form-row">
							<ul>
								<li class="m6">
									<input class="form-control red bold" type="text" id="fap_job_itv_date_et" readonly="readonly">&emsp;
								</li>
								<li class="m6">
									<input class="form-control red bold" type="text" id="fap_job_itv_time_et" readonly="readonly">
								</li>
							</ul>
						</div>	
						<div class="form-row">
							<label><spring:message code="fap.comp.itv_lo" /></label>
						</div>
						<div class="form-row">
							<ul>
								<li class="">
									<input class="form-control bold" type="text" id="fap_job_itv_pcs_sch_lo" value="{{itv.fap_job_recruit_pcs_sch_lo}}" readonly="readonly">
								</li>
							</ul>
						</div>	
						<div class="form-row">
							<label><spring:message code="fap.comp.itv_waitingroom" /></label>
						</div>
						<div class="form-row">
							<ul>
								<li class="">
									<input class="form-control" type="text" id="fap_job_itv_pcs_sch_waitingroom" value="{{itv.fap_job_recruit_pcs_sch_waitingroom}}" readonly="readonly" >
								</li>
							</ul>
						</div>	
						<div class="form-row">
							<label><spring:message code="fap.comp.itv_detail" /></label>
						</div>
						<div class="form-row">
							<textarea class="form-control" id="fap_job_itv_pcs_sch_detail" readonly="readonly" style="height: 100px;">{{itv.fap_job_recruit_pcs_sch_detail}}</textarea>
						</div>											
					</div>						
					
					<div class="form-group">
						<div class="form-row">
							<label><spring:message code="fap.comp.itv_obj" /></label>
						</div>
						<div class="form-row">
							<ul>
								<li class="m3">
									<select class="form-control" id="fap_job_itv_obj" ng-model="itv.fap_job_itv_obj" disabled="disabled">
										<option selectcode value="C3400"></option>
										<option selectcode value="C3401"></option>
										<option selectcode value="C3402"></option>
										<option selectcode value="C3403"></option>
									</select>
								</li>
								<li class="m8">
									<input class="form-control" type="text" id="fap_job_itv_obj_etc_dtl" value="{{itv.fap_job_itv_obj_etc_dtl}}" readonly="readonly" ng-hide="itv.fap_job_itv_obj_etc_dtl == null || itv.fap_job_itv_obj_etc_dtl == '' || itv.fap_job_itv_obj_etc_dtl == undefined">
								</li>
							</ul>
						</div>
						<div class="form-row">
							<label><spring:message code="fap.comp.itv_gb" /></label>
						</div>
						<div class="form-row">
							<ul>
								<li class="m6">
									<select class="form-control" id="fap_job_itv_gb" ng-model="itv.fap_job_itv_gb" disabled="disabled">
										<option selectcode value="C3300"></option>
										<option selectcode value="C3301"></option>
									</select>			
								</li>
							</ul>								
						</div>
						<div class="form-row">
							<label><spring:message code="fap.comp.itv_tp" /></label>
						</div>
						<div class="form-row">
							<ul>
								<li class="m3">
									<select class="form-control" id="fap_job_itv_tp" ng-model="itv.fap_job_itv_tp" disabled="disabled">
										<option selectcode value="C3500"></option>
										<option selectcode value="C3501"></option>
										<option selectcode value="C3502"></option>
										<option selectcode value="C3503"></option>
									</select>
								</li>
								<li class="m8">
									<input class="form-control" type="text" id="fap_job_itv_tp_etc_dtl" value="{{itv.fap_job_itv_tp_etc_dtl}}" readonly="readonly" ng-hide="itv.fap_job_itv_tp_etc_dtl == null || itv.fap_job_itv_tp_etc_dtl == undefined || itv.fap_job_itv_tp_etc_dtl == ''">
								</li>
							</ul>								
						</div>
						<div class="form-row">
							<label><spring:message code="fap.comp.itv_tm" /></label>
						</div>
						<div class="form-row">
							<input class="form-control" type="text" id="fap_job_itv_tm" value="{{itv.fap_job_itv_tm}}" readonly="readonly">
						</div>	
						<div ng-hide="itv.fap_job_itv_pcs_dtl == null || itv.fap_job_itv_pcs_dtl == undefined || itv.fap_job_itv_pcs_dtl == ''">
							<div class="form-row">
								<label><spring:message code="fap.comp.itv_detail" /></label>
							</div>
							<div class="form-row">
								<textarea class="form-control" id="fap_job_itv_pcs_dtl" style="height: 100px;" readonly="readonly">{{itv.fap_job_recruit_pcs_dtl}}</textarea>
							</div>	
						</div>	
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- 면접전형 일정 MODAL 종료-->
	
	<!-- 기타전형 일정 MODAL 시작-->
	<div class="modal fade" id="testEtcModal" tabindex="-1" role="dialog" aria-labelledby="modal" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
			
				<div class="modal-header">
					<h5 class="modal-title" id="modal"><spring:message code="fap.comp.test_etc_pcs_sch" /></h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>		
				
				<div class="modal-body">						
					<div class="form-group">
						<div class="form-row">
							<ul>
								<li class="m6">
									<label><spring:message code="fap.comp.test_etc_date_st" /></label>
								</li>
								<li class="m6">
									<label><spring:message code="fap.comp.test_etc_time_st" /></label>
								</li>
							</ul>
						</div>
						<div class="form-row" style="margin-bottom: 1rem;">
							<ul>
								<li class="m6">
									<input class="form-control blue bold" type="text" id="fap_job_test_etc_date_st" readonly="readonly">
								</li>
								<li class="m6">
									<input class="form-control blue bold" type="text" id="fap_job_test_etc_time_st" readonly="readonly">
								</li>
							</ul>
						</div>
						<div class="form-row">
							<ul>
								<li class="m6">
									<label><spring:message code="fap.comp.test_etc_date_et" /></label>
								</li>
								<li class="m6">
									<label><spring:message code="fap.comp.test_etc_time_et" /></label>
								</li>
							</ul>
						</div>
						<div class="form-row" style="margin-bottom: 1rem;">
							<ul>
								<li class="m6">
									<input class="form-control red bold" type="text" id="fap_job_test_etc_date_et" readonly="readonly">
								</li>
								<li class="m6">
									<input class="form-control red bold" type="text" id="fap_job_test_etc_time_et" readonly="readonly">
								</li>
							</ul>
						</div>	
						<div class="form-row">
							<label><spring:message code="fap.comp.test_etc_lo" /></label>
						</div>
						<div class="form-row" style="margin-bottom: 1rem;">
							<input class="form-control bold" type="text" id="fap_job_test_etc_pcs_sch_lo" value="{{etc.fap_job_recruit_pcs_sch_lo}}" readonly="readonly">
						</div>
						<div class="form-row">
							<label><spring:message code="fap.comp.test_etc_detail" /></label>
						</div>
						<div class="form-row">
							<textarea class="form-control" id="fap_job_test_etc_pcs_sch_detail" style="height: 100px;" readonly="readonly">{{etc.fap_job_recruit_pcs_sch_detail}}</textarea>
						</div>	
					</div>						
					
					<div class="form-group">
						<div class="form-row">
							<label><spring:message code="fap.comp.test_etc_obj" /></label>
						</div>
						<div class="form-row" style="margin-bottom: 1rem;">
							<ul>
								<li class="m3">
									<select class="form-control" id="fap_job_test_etc_obj" ng-model="etc.fap_job_test_etc_obj" disabled="disabled">
										<option selectcode value="C3600"></option>
										<option selectcode value="C3601"></option>
										<option selectcode value="C3602"></option>
										<option selectcode value="C3603"></option>
									</select>
								</li>
								<li class="m8">
									<input class="form-control" type="text" id="fap_job_test_etc_obj_dtl" value="{{etc.fap_job_test_etc_obj_dtl}}" readonly="readonly">
								</li>
							</ul>
						</div>
						<div class="form-row">
							<label><spring:message code="fap.comp.test_etc_detail" /></label>
						</div>
						<div class="form-row">
							<textarea class="form-control" id="fap_job_test_etc_dtl" style="height: 100px;" readonly="readonly">{{etc.fap_job_test_etc_dtl}}</textarea>
						</div>	
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- 기타전형 일정 MODAL 종료-->

	<br><br><br>
	<%@include file="../common_footer_fap.jsp"%>
</body>
</html>
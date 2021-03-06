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
	
	<link rel="stylesheet" type="text/css" href="<c:url value="/resources/segroup/society/fap/css/default.css" />" />
	<link type="text/css" rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto:400,500">
	<link type="text/css" rel="stylesheet" href="<c:url value="/resources/segroup/society/fap/css/popModal.css" />">
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>

	<style type="text/css">
		#top {
			background : #eee;
			border-bottom : 1px solid #ddd;
			padding : 0 10px;
			line-height : 40px;
			font-size : 12px;
			margin-top: 30px;
			text-align: center;
		}
	    #calendar-contents {
	        max-width : 1127px;
	        margin : 0 auto;
	    }
	    
	   .fc-sat {color : blue;}
	   .fc-sun {color : red;}
	   
	</style>
	<script type="text/javascript">
		var myApp = angular.module('myapp', []);		
		myApp.controller('CalendarController', ['$scope','$compile','$http', function($scope,$compile,$http){
				
			//?????? ?????? ??????
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
			
			//?????? ??????
			var initialLocaleCode = 'ja';				
			
			//????????? ????????? ??????		
			var fap_comp_id = "${fap_comp_id}";
			var fap_jobfair_seq = "${fap_jobfair_seq}";
			var fap_jobfair_divide_seq = "${fap_jobfair_divide_seq}";
			var agency_id="${resultMap.agency_info.fap_comp_id}";
			$scope.fap_jobfair_divide_seq = fap_jobfair_divide_seq;
	    	
			if(fap_jobfair_seq == null || fap_jobfair_seq == ''){
				fap_jobfair_seq = 0;
				fap_jobfair_divide_seq = 0;
			}			
			
		    $(document).ready(function() {				    			
		    	
		    	//FullCalendar
	    		$("#calendar").fullCalendar({
		            header : {
		            	left : 'clear'
		            	, center : 'title'
		            	, right : 'prev, next today'
		            }
			    	, defaultDate : today
			    	, navLinks : false		//???,?????? ???????????? ????????? ???????????? ??????????????? ???????????? ????????? ???????????? ?????? ??????
			        , locale: "ja"		//?????? ?????? : ?????????
			        , eventDurationEditable : true		//???????????? ??????????????? ????????? ????????? ??? ????????? ??????
			        , editable : false	//????????? ???????????? ??????(event)??? ????????? ???(bar)??? ????????? ????????? ??? ?????? ?????? ???
			        , eventLimit : true	//????????? ??????(event)??? 3?????? ???????????? ??? ????????? more??? ???????????? ?????? ??????
			        , selectable : true	//???????????? ??????????????? ???????????? ???????????? ?????? ??????
			        , textColor : 'black'
			        , timeFormat : 'HH:mm'	        
		            , events: function(start, end, timezone, callback) {
		    			$.ajax({
		    				beforeSend: function(xhr) {
		    				     xhr.setRequestHeader("AJAX", true);
		    				}
		    				, url : '/fap/agency/agency_recruit_process_schedule_select'
		    				,type : 'post'
		    				, dataType : 'text'
				    		, data : {fap_jobfair_seq : fap_jobfair_seq, fap_jobfair_divide_seq : fap_jobfair_divide_seq, fap_comp_id : fap_comp_id}
		    				,success : function(data){
		    					var events=[];
		    					$.each(JSON.parse(data), function(index, value) {    						
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
		    						location.href = "/fap/agency/agency_login";
		    					}
		    				}
		    			});
		            }
		            ,eventClick : function(event){
		            	//??? ????????? ????????? ?????????
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
	    		
	    		//jobfair_divide ?????????
				if($("#select_jobfair option:selected").val() != 0 ){
					$("#jobfair_divide_hidden").prop("selected", true);
					$("#select_jobfair_divide").html("<option value=\'"+0+"\' id=\"jobfair_divide_hidden\" seq=\"" + 0 + "\"  hidden><spring:message code="fap.comp.select" /></option>");					
					$("#select_jobfair_divide").attr("disabled", false);	
				}else{
					$("#jobfair_divide_hidden").prop("selected", true);
					$("#select_jobfair_divide").html("<option value=\'"+0+"\' id=\"jobfair_divide_hidden\" seq=\"" + 0 + "\"  hidden><spring:message code="fap.comp.select_imposible" /></option>");					
					$("#select_jobfair_divide").attr("disabled", true);	
				}
	    		
	    		$http({
					method : 'POST',
					url : '/fap/agency/agency_jobfair_divide_list_search',
					responseType : 'text',
					params : {
						fap_jobfair_seq: $("#select_jobfair option:selected").val()
					},
					headers : {
						"AJAX" : true
					}
				}).then(function successCallback(response) {
					if(response.data.length > 1){					
						//jobfair_divide??? option ??????
						for(var i in response.data){
							$("#select_jobfair_divide").append($compile("<option selectcode value=" 
									+ response.data[i].fap_jobfair_divide_gb + " seq=\"" + response.data[i].fap_jobfair_divide_seq + "\"></option>")($scope));
						}
						//????????? ?????? ??????
						for(var i in response.data){
							if(fap_jobfair_divide_seq == response.data[i].fap_jobfair_divide_seq){
								$('#select_jobfair_divide option[seq='+fap_jobfair_divide_seq+']').attr("selected", "selected");
							}
						}
					}
				}, function errorCallback(response) {
					if(response.status == 403){
						alert('<spring:message code="com.login.ajaxSesstion" javaScriptEscape="true" />');
						location.href = "/fap/agency/agency_login";
					}
				});	    		
		    		
		    });		    		
		   
			//????????? ??????
			$scope.select_change = function(flag){
				
				//????????? ??????
				if(flag == 0){
					//????????? ??????
					$http({
						method : 'POST',
						url : '/fap/agency/agency_company_jobfair_list_search',
						responseType : 'text',
						params : {
							fap_comp_id: $("#select_company option:selected").val()
						},
						headers : {
							"AJAX" : true
						}
					}).then(function successCallback(response) {
						//jobfair??? option ??????
						$("#select_jobfair").html($compile("<option value=" + 0 + "><spring:message code="fap.comp.select" /></option>")($scope));
						for(var i in response.data){
							$("#select_jobfair").append($compile("<option value=" + response.data[i].fap_jobfair_seq + ">" + response.data[i].fap_jobfair_title + "</option>")($scope));
						}
						
					}, function errorCallback(response) {
						if(response.status == 403){
							alert('<spring:message code="com.login.ajaxSesstion" javaScriptEscape="true" />');
							location.href = "/fap/agency/agency_login";
						}
					});
					
					//jobfair_divide ????????????
					$("#jobfair_divide_hidden").prop("selected", true);
					$("#select_jobfair_divide").html("<option value=\'"+0+"\' id=\"jobfair_divide_hidden\" seq=\"" + 0 + "\"  hidden><spring:message code="fap.comp.select_imposible" /></option>");					
					$("#select_jobfair_divide").attr("disabled", true);
					
				}
				
				//????????? ??????
				if(flag == 1){
					//jobfair_divide ?????????
					if($("#select_jobfair option:selected").val() != 0 ){
						$("#jobfair_divide_hidden").prop("selected", true);
						$("#select_jobfair_divide").html("<option value=\'"+0+"\' id=\"jobfair_divide_hidden\" seq=\"" + 0 + "\"  hidden><spring:message code="fap.comp.select" /></option>");					
						$("#select_jobfair_divide").attr("disabled", false);	
					}else{
						$("#jobfair_divide_hidden").prop("selected", true);
						$("#select_jobfair_divide").html("<option value=\'"+0+"\' id=\"jobfair_divide_hidden\" seq=\"" + 0 + "\"  hidden><spring:message code="fap.comp.select_imposible" /></option>");					
						$("#select_jobfair_divide").attr("disabled", true);	
					}										
				
					$http({
						method : 'POST',
						url : '/fap/agency/agency_jobfair_divide_list_search',
						responseType : 'text',
						params : {
							fap_jobfair_seq: $("#select_jobfair option:selected").val()
							, fap_comp_id : $("#select_company option:selected").val()
						},
						headers : {
							"AJAX" : true
						}
					}).then(function successCallback(response) {
						//jobfair_divide??? option ??????
						for(var i in response.data){
							$("#select_jobfair_divide").append($compile("<option selectcode value=" 
									+ response.data[i].fap_jobfair_divide_gb + " seq=\"" + response.data[i].fap_jobfair_divide_seq + "\"></option>")($scope));
						}					
						
					}, function errorCallback(response) {
						if(response.status == 403){
							alert('<spring:message code="com.login.ajaxSesstion" javaScriptEscape="true" />');
							location.href = "/fap/agency/agency_login";
						}
					});
				}
				
				//?????? ?????????
				var fap_comp_id = $('#select_company').val();
				var fap_jobfair_seq = $('#select_jobfair').val();
				var fap_jobfair_divide_seq = $('#select_jobfair_divide option:selected').attr('seq');				
				
				//?????? fullCalendar ?????????
				$("#calendar").fullCalendar('destroy');
				//????????? fullCalendar
				$("#calendar").fullCalendar({
		            header : {
		            	left : 'clear'
		            	, center : 'title'
		            	, right : 'prev, next today'
		            }
			    	, defaultDate : today
			    	, navLinks : false	
			        , locale: "ja"
			        , eventDurationEditable : true
			        , editable : false
			        , eventLimit : true
			        , selectable : true
			        , textColor : 'black'
			        , timeFormat : 'HH:mm'	        
		            , events: function(start, end, timezone, callback) {
		    			$.ajax({
		    				beforeSend: function(xhr) {
		    				     xhr.setRequestHeader("AJAX", true);
		    				}
		    				, url : '/fap/agency/agency_recruit_process_schedule_select'
		    				, type : 'post'		
		    				, dataType : 'text'
		    				, data : {fap_jobfair_seq : fap_jobfair_seq, fap_jobfair_divide_seq : fap_jobfair_divide_seq, fap_comp_id : fap_comp_id}
		    				, success : function(data){
		    					var events=[];
		    					$.each(JSON.parse(data), function(index, value) {    						
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
		    						location.href = "/fap/agency/agency_login";
		    					}
		    				}    				
		    			});  
		            }
		            ,eventClick : function(event){	            	
		            	//??? ????????? ????????? ?????????
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
				
			}//????????? ?????????
	    	
	        // ?????? ?????? ??????
	        $.each($.fullCalendar.locales, function(localeCode) {
	        	$('#locale_selector').append(
	        		$('<option/>')
	        			.attr('value', localeCode)
	        			.prop('selected', localeCode == initialLocaleCode)        			
	        			.text(localeCode)
	        	);
	        });
	        
	       // ????????? ????????? ????????? ???????????? ????????? ?????? ??????
	       $('#locale_selector').on('change', function() { 
	    	   if(this.value) {
	    		   $('#calendar').fullCalendar('option', 'locale', this.value);
	    	   }
	       });
		       
		  //????????? ???????????? ??????
			function reviewPcs(fap_job_recruit_pcs_seq){
				$http({
					method: 'POST',
					url: "/fap/agency/agency_review_process_select",
					params : {
						fap_job_recruit_pcs_seq : fap_job_recruit_pcs_seq
					},
					headers : {
						"AJAX" : true
					}
				}).then(function successCallback(reviewResponse) {
					$scope.review = reviewResponse.data;
					
					//???????????? ?????????
					if(reviewResponse.data.fap_job_recruit_pcs_sch_st != null){
						var st = reviewResponse.data.fap_job_recruit_pcs_sch_st.split(" ");
						$(".modal-body #fap_job_review_date_st").val(st[0]);
						$(".modal-body #fap_job_review_time_st").val(st[1]);
					}
					//???????????? ?????????
					if(reviewResponse.data.fap_job_recruit_pcs_sch_et != null){
						var et = reviewResponse.data.fap_job_recruit_pcs_sch_et.split(" ");					
						$(".modal-body #fap_job_review_date_et").val(et[0]);
						$(".modal-body #fap_job_review_time_et").val(et[1]);
					}											
					//???????????? ?????????
					$("#reviewModal").modal();
					
				}, function errorCallback(reviewResponse) {
					if(reviewResponse.status == 403){
						alert('<spring:message code="com.login.ajaxSesstion" javaScriptEscape="true" />');
						location.href = "/fap/agency/agency_login";
					}
				});
			}
    		
			//????????? ???????????? ??????
			function examPcs(fap_job_recruit_pcs_seq){
				$http({
					method: 'POST',
					url: "/fap/agency/agency_exam_process_select",
					params : {
						fap_job_recruit_pcs_seq : fap_job_recruit_pcs_seq
					},
					headers : {
						"AJAX" : true
					}
				}).then(function successCallback(examResponse) {
					$scope.exam = examResponse.data;
					
					//???????????? ?????????
					if(examResponse.data.fap_job_recruit_pcs_sch_st != null){
						var st = examResponse.data.fap_job_recruit_pcs_sch_st.split(" ");
						$(".modal-body #fap_job_exam_date_st").val(st[0]);
						$(".modal-body #fap_job_exam_time_st").val(st[1]);
					}
					//???????????? ?????????
					if(examResponse.data.fap_job_recruit_pcs_sch_et != null){
						var et = examResponse.data.fap_job_recruit_pcs_sch_et.split(" ");
						$(".modal-body #fap_job_exam_date_et").val(et[0]);
						$(".modal-body #fap_job_exam_time_et").val(et[1]);
					}							
					//???????????? ?????????
					$("#examModal").modal();
					
				}, function errorCallback(examResponse) {
					if(examResponse.status == 403){
						alert('<spring:message code="com.login.ajaxSesstion" javaScriptEscape="true" />');
						location.href = "/fap/agency/agency_login";
					}
				});
			}
			
			//????????? ???????????? ??????
			function itvPcs(fap_job_recruit_pcs_seq){
				$http({
					method: 'POST',
					url: '/fap/agency/agency_itv_process_select',
					params: {
						fap_job_recruit_pcs_seq : fap_job_recruit_pcs_seq
					},
					headers : {
						"AJAX" : true
					}
				}).then(function successCallback(itvResponse){
					$scope.itv = itvResponse.data;
					
					//???????????? ?????????
					if(itvResponse.data.fap_job_recruit_pcs_sch_st != null){
						var st = itvResponse.data.fap_job_recruit_pcs_sch_st.split(" ");
						$(".modal-body #fap_job_itv_date_st").val(st[0]);
						$(".modal-body #fap_job_itv_time_st").val(st[1]);	
					}
					//???????????? ?????????
					if(itvResponse.data.fap_job_recruit_pcs_sch_et != null){
						var et = itvResponse.data.fap_job_recruit_pcs_sch_et.split(" ");
						$(".modal-body #fap_job_itv_date_et").val(et[0]);
						$(".modal-body #fap_job_itv_time_et").val(et[1]);	
					}			
					//???????????? ?????????
					$("#itvModal").modal();
					
				}, function errorCallback(itvResponse){
					if(itvResponse.status == 403){
						alert('<spring:message code="com.login.ajaxSesstion" javaScriptEscape="true" />');
						location.href = "/fap/agency/agency_login";
					}
				});
			}
			
			//????????? ???????????? ??????
			 function testEtcPcs(fap_job_recruit_pcs_seq){
				$http({
					method: 'POST',
					url: '/fap/agency/agency_test_etc_process_select',
					params: {
						fap_job_recruit_pcs_seq : fap_job_recruit_pcs_seq
					},
					headers : {
						"AJAX" : true
					}
				}).then(function successCallback(testEtcResponse){
					$scope.etc = testEtcResponse.data;
					
					//???????????? ?????????
					if(testEtcResponse.data.fap_job_recruit_pcs_sch_st != null){
						var st = testEtcResponse.data.fap_job_recruit_pcs_sch_st.split(" ");
						$(".modal-body #fap_job_test_etc_date_st").val(st[0]);
						$(".modal-body #fap_job_test_etc_time_st").val(st[1]);
					}
					//???????????? ?????????
					if(testEtcResponse.data.fap_job_recruit_pcs_sch_et != null){
						var et = testEtcResponse.data.fap_job_recruit_pcs_sch_et.split(" ");
						$(".modal-body #fap_job_test_etc_date_et").val(et[0]);
						$(".modal-body #fap_job_test_etc_time_et").val(et[1]);
					}				
					//???????????? ?????????
					$("#testEtcModal").modal();
					
				}, function errorCallback(testEtcResponse){
					if(testEtcResponse.status == 403){
						alert('<spring:message code="com.login.ajaxSesstion" javaScriptEscape="true" />');
						location.href = "/fap/agency/agency_login";
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
	
	<%@include file="agency_menu.jsp"%>
	
	<div id="calendar-contents">
		<div id="top">
			<div>
				<span><spring:message code="fap.comp.search_comp_nm" /> : </span>
				<select onchange="angular.element(this).scope().select_change(0)" id="select_company" style="width: 200px; height: 26px;">
					<option value="${resultMap.agency_info.fap_comp_id}" <c:if test="${agency == resultMap.agency_info.fap_comp_id}">selected</c:if>>${resultMap.agency_info.fap_comp_ja_nm}</option>
					<c:forEach var="company" items="${resultMap.select_approval_comp}">
						<option value="${company.fap_comp_id}" <c:if test="${fap_comp_id == company.fap_comp_id}">selected</c:if>>${company.fap_comp_ja_nm}</option>
					</c:forEach>
				</select>
				&emsp;&emsp;
				<span><spring:message code="fap.comp.search_jobfair" /> : </span>
				<select onchange="angular.element(this).scope().select_change(1)" id="select_jobfair" style="width: 200px; height: 26px;">
					<option value="0" ><spring:message code="fap.comp.select" /></option>
					<c:forEach var="jobfair" items="${jobfair_list}">
						<option value="${jobfair.fap_jobfair_seq}" <c:if test="${fap_jobfair_seq == jobfair.fap_jobfair_seq}">selected</c:if>>${jobfair.fap_jobfair_title}</option>
					</c:forEach>
				</select>
				&emsp;&emsp;
				<span><spring:message code="fap.comp.search_jobfair_divide" /> : </span>
				<select onchange="angular.element(this).scope().select_change()" id="select_jobfair_divide" disabled="disabled" style="width: 100px; height: 26px;">
					<option value="0" id="jobfair_divide_hidden" seq="0" hidden><spring:message code="fap.comp.select_imposible" /></option>
				</select>
			</div>		
		</div>
		<input type="hidden" id="fap_comp_id" value="${jobfair_list[0].fap_comp_id }">
		
		<div id="calendar" style="margin-top: 10px;">
		
		</div>
	</div>
	
	<!-- ???????????? ?????? MODAL ??????-->
	<div class="modal fade" id="reviewModal" tabindex="-1" role="dialog" aria-labelledby="modal" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
			
				<div class="modal-header">
					<h3 class="modal-title" id="modal"><spring:message code="fap.comp.review_pcs_sch" /></h3>
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
						<br>	
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
						<textarea class="form-control" id="fap_job_recruit_pcs_dtl" readonly="readonly" class="form-control" ng-model="review.fap_job_recruit_pcs_dtl" style="height: 100px;"></textarea>
						
					</div>					
				</div>
			</div>
		</div>
	</div>
	<!-- ???????????? ?????? MODAL ??????-->

	<!-- ???????????? ?????? MODAL ??????-->
	<div class="modal fade" id="examModal" tabindex="-1" role="dialog" aria-labelledby="modal" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
			
				<div class="modal-header">
					<h3 class="modal-title" id="modal"><spring:message code="fap.comp.exam_pcs_sch" /></h3>
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
						<div class="form-row" style="margin-bottom: 10px;">
							<input class="form-control bold" type="text" id="fap_job_exam_pcs_sch_lo" value="{{exam.fap_job_recruit_pcs_sch_lo}}" readonly="readonly">
						</div>	
						<div ng-hide="exam.fap_job_recruit_pcs_sch_detail == null || exam.fap_job_recruit_pcs_sch_detail == undefined || exam.fap_job_recruit_pcs_sch_detail == ''">	
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
								<li class="m6">
									<select class="form-control" id="fap_job_exam_type_gb" ng-model="exam.fap_job_exam_type_gb" disabled="disabled">
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
							<label><spring:message code="fap.comp.exam_mail" /></label>
						</div>
						<div class="form-row form-row-bottom">
							<ul>
								<li class="m6">
									<select class="form-control" id="fap_job_exam_mail" ng-model="exam.fap_job_exam_mail" disabled="disabled">
										<option selectcode value="C2800"></option>
										<option selectcode value="C2801"></option>
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
							<label><spring:message code="fap.comp.exam_sv" /></label>
						</div>
						<div class="form-row form-row-bottom">
							<ul>
								<li class="m4" >
									<select class="form-control" id="fap_job_exam_sv" ng-model="exam.fap_job_exam_sv" disabled="disabled">
										<option selectcode value="C2900"></option>
										<option selectcode value="C2901"></option>
										<option selectcode value="C2902"></option>
										<option selectcode value="C2903"></option>
									</select>
								</li>
								<li class="m7">
									<input class="form-control" type="text" id="fap_job_exam_sv_etc_dtl" value="{{exam.fap_job_exam_sv_etc_dtl}}" readonly="readonly" ng-hide="exam.fap_job_exam_sv_etc_dtl == null || exam.fap_job_exam_sv_etc_dtl == undefined || exam.fap_job_exam_sv_etc_dtl ==''">
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
									<input class="form-control" type="text" id="fap_job_exam_need_etc_dtl" value="{{fap_job_exam_need_etc_dtl}}" readonly="readonly" ng-hide="fap_job_exam_need_etc_dtl == null || fap_job_exam_need_etc_dtl == undefined || fap_job_exam_need_etc_dtl ==''">
								</li>
							</ul>
						</div>
					</div>
					<div ng-hide="exam.fap_job_exam_file_origin == null || exam.fap_job_exam_file_origin == undefined || exam.fap_job_exam_file_origin == ''">
						<div class="form-row">
								<label><spring:message code="fap.comp.exam_file" /></label>
						</div>
						<div class="form-row">
							<input class="form-control" type="text" value="{{exam.fap_job_exam_file_origin}}" readonly="readonly">
						</div>	
					</div>					
				</div>
			</div>
		</div>
	</div>
	<!-- ???????????? ?????? MODAL ??????-->
	
	<!-- ???????????? ?????? MODAL ??????-->
	<div class="modal fade" id="itvModal" tabindex="-1" role="dialog" aria-labelledby="modal" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
			
				<div class="modal-header">
					<h3 class="modal-title" id="modal"><spring:message code="fap.comp.itv_pcs_sch" /></h3>
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
							<textarea class="form-control" id="fap_job_itv_pcs_sch_detail" readonly="readonly" height: 100px;">{{itv.fap_job_recruit_pcs_sch_detail}}</textarea>
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
									<input class="form-control" type="text" id="fap_job_itv_obj_etc_dtl" value="{{itv.fap_job_itv_obj_etc_dtl}}" readonly="readonly" ng-hide="itv.fap_job_itv_obj_etc_dtl == null || itv.fap_job_itv_obj_etc_dtl == undefined || itv.fap_job_itv_obj_etc_dtl == ''">
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
	<!-- ???????????? ?????? MODAL ??????-->
	
	<!-- ???????????? ?????? MODAL ??????-->
	<div class="modal fade" id="testEtcModal" tabindex="-1" role="dialog" aria-labelledby="modal" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
			
				<div class="modal-header">
					<h3 class="modal-title" id="modal"><spring:message code="fap.comp.test_etc_pcs_sch" /></h3>
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
	<!-- ???????????? ?????? MODAL ??????-->
	
	
	<br><br><br>
	
	<%@include file="agency_footer.jsp"%>
	
</body>
</html>
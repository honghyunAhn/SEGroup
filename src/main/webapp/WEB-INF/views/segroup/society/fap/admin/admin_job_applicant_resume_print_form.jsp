<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="<c:url value="/resources/segroup/js/jquery-3.1.1.js" />"></script>
<script src="<c:url value="/resources/segroup/js/jquery-ui.js" />"></script>
<script src="<c:url value="/resources/segroup/js/angular.min.js" />"></script>
<script src="<c:url value="/resources/segroup/js/datepicker.js" />"></script>
<script src="<c:url value="/resources/segroup/society/fap/js/lodash.js" />"></script>
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/segroup/society/fap/css/userDefault.css" />" />
<link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
<title>Bridge Job Fair</title>
<script type="text/javascript">
	$(function() {
		realTimeValidation();
		_update = _.debounce(function(){
			$('#resume_form').submit(); 
		},500,true);
		
		cleanDatepicker();
		
		//이력서 사진 파일에 관한 함수
		$('#fap_resume_pic').change(function() {
			var val = $(this).val();
			
			if(val == "") {
				$(this).val('');
				$(".photo").empty();
				return;	
			} else if(fileImageCheck(val)) {
				photoAjax();
			} else {
				$(this).val('');
				$(".photo").empty();
				alert("이미지 파일이 아닙니다. gif, jpg, png 형식만 가능합니다.");
				return;
			}
		});
		
		
		//개인 동영상 파일 체크
		$("#resume_personal_video").change(function(){
			 var file = $(this).val();
			
			 if(file == ""){
				 $(this).val("");
				 return;
			 }
			 
			//확장자 체크
			if( extension_check_video(file) ) {
				
			} else {
				alert('<spring:message code="fap.err.video_type" javaScriptEscape="true" />');
				$(this).val("");
			} 
			
			//파일 사이즈 체크
			var size = 0;
			// 브라우저 확인
			var browser=navigator.appName;
			
			// 익스플로러일 경우
			if (browser=="Microsoft Internet Explorer") {
				var oas = new ActiveXObject("Scripting.FileSystemObject");
				fileSize = oas.getFile( file ).size;
			}
			// 익스플로러가 아닐경우
			else {
				size = $(this)[0].files[0].size;
			}
			
			//100MB
			if(file_size_check(size, 100)){
				//alert("size ok");
			}else{
				alert('<spring:message code="fap.err.video_size" javaScriptEscape="true" />');
				$(this).val("");
			}
		
		});
		
		//포트폴리오 파일 체크
		$("#resume_personal_pr").change(function(){
			var file = $(this).val();
			
			if(file == "") {
				$(this).val("");
				return;
			} 
			
			//확장자 체크
			if( extension_check_pdf(file) ) {
				
			} else {
				alert('<spring:message code="fap.err.pdf_type" javaScriptEscape="true" />');
				$(this).val("");
			} 
			
			//파일 사이즈 체크
			var size = 0;
			// 브라우저 확인
			var browser=navigator.appName;
			
			// 익스플로러일 경우
			if (browser=="Microsoft Internet Explorer") {
				var oas = new ActiveXObject("Scripting.FileSystemObject");
				fileSize = oas.getFile( file ).size;
			}
			// 익스플로러가 아닐경우
			else {
				size = $(this)[0].files[0].size;
			}
			
			//5MB
			if(file_size_check(size, 5)){
				//alert("size ok");
			}else{
				alert('<spring:message code="fap.err.pdf_size" javaScriptEscape="true" />');
				$(this).val("");
			}
			
		});
		
	});
	
	//innerHtml용 유효성체크
	function realTimeValidation(){
		$('input[type="text"]').change(function(){
		        this.value = $.trim(this.value);
		});
		//모든 textarea trim
		$('textarea').off('change').change(function(){
		        this.value = $.trim(this.value);
		});
		$("input[type='text']").off('keyup').keyup( function(){
			//모든 input text 글자수 제한
		    if ($(this).val().length >= $(this).attr('maxlength')) {
		        alert('<spring:message code="fap.err.over_maxlength" javaScriptEscape="true" />');
		        $(this).val($(this).val().substr(0, $(this).attr('maxlength')));
		    }
		});
		$("input[type='number']").off('keyup').keyup( function(){
			//모든 input text 글자수 제한
		    if ($(this).val().length >= $(this).attr('maxlength')) {
		        alert('<spring:message code="fap.err.over_maxlength" javaScriptEscape="true" />');
		        $(this).val($(this).val().substr(0, $(this).attr('maxlength')));
		    }
		});
		$('textarea').off('keyup').keyup( function() {
				if($(this).val().length >= $(this).attr('maxlength')) {
					alert('<spring:message code="fap.err.over_maxlength" javaScriptEscape="true" />');
					$(this).val($(this).val().substring(0, $(this).attr('maxlength')));
				}
		});
		$("input[type='text']").off('keyup').keyup( function(){
			//모든 input 태그 제한
			var disallow_char = /(<([^>]+)>)/ig;
			var tempValue = $(this).val();
		    if (disallow_char.test(tempValue)) {
		        alert('<spring:message code="fap.err.tag_insert" javaScriptEscape="true" />');
		        $(this).val(tempValue.replace(disallow_char,""));
		    }
		});
		$("textarea").off('keyup').keyup( function(){
			//모든 input 태그 제한
			var disallow_char = /(<([^>]+)>)/ig;
			var tempValue = $(this).val();
		    if (disallow_char.test(tempValue)) {
		        alert('<spring:message code="fap.err.tag_insert" javaScriptEscape="true" />');
		        $(this).val(tempValue.replace(disallow_char,""));
		    }
		});
	
	}
	
	//angular module 
	var myApp = angular.module('myapp', []);
	
	
	myApp.controller('ResumeController',['$scope','$compile','$timeout', function($scope, $compile,$timeout) {
						
			var resume_json_list = '${resume_json_list}';
		
			var replaceJson = resume_json_list.replace(/(?:\r\n|\r|\n)/g, '\\r\\n');
			
			$scope.resumeApplyList = JSON.parse(replaceJson);
			
			$timeout(function() {
				
				$.each($(".resume-select-btn"), function(index, item){
					var cd = $(this).attr("cd");
					var context = '<code value="'+cd+'"></code>';
					$(this).html(context);
				})

				$compile(".resume-select-btn")($scope);
			
			}, 0);
			
			
			$timeout(function() {
				
				$.each($(".span-code"), function(index, item){
					var cd = $(this).attr("cd");
					var context = '<code value="'+cd+'"></code>';
					$(this).html(context);
				})

				$compile(".span-code")($scope);
			
				$.each($(".auto_heigth"),function(index,item){
					$(this).css('height', $(this).prop('scrollHeight')+12);
				})
			}, 0);
			
		}
	]);
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
	} ]);
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
	} ]);
	
	myApp.directive('blurCurrency',['$filter',  function($filter) {
		return {
			require : 'ngModel',
			scope: true,
			link : function($scope, $el, $attr, $ngModelCtrl){
			 function formatter(value){
					value = value ? parseFloat(value.toString().replace(/[^0-9._-]/g, '')) || 0 : 0;
					var formattedValue = $filter('currency')(value,"",0);
					
					$ngModelCtrl.$setViewValue(value);
					$ngModelCtrl.$render();
					
					$el.val(formattedValue);
					
					return formattedValue;
				}
				
				$ngModelCtrl.$formatters.push(formatter);
				
				$el.bind('focus', function(){
					//$el.val('');
				});
				
				$el.bind('blur', function(){
					formatter($el.val());
				});
			}
		}
	}])

	//datepicker
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
	
	//목록으로
	function readList(){
		location.href = "/fap/user/resume_management";
	}
	
		
		
	//이력서에 이미지 파일 ajax로 넘겨주기 
	function photoAjax() {
		
		var size = $("#fap_resume_pic")[0].files[0].size;
		if(file_size_check(size,5)) {
			var formData = new FormData();
			formData.append("file", $("#fap_resume_pic")[0].files[0]);
			
			$.ajax({
				type : "POST",
				url : "/temporarily_upload",
				data : formData,
				processData : false,
				contentType : false,
				dataType: "json",
				success : function(data) {
					$(".photo").empty();
					$(".photo").html('<img alt="" src="/edu/temporarilyPath/'+data.savedfile+'">');
				},
				error : function(e) {
					console.log(e);
				}
			});
		} else {
			$("#fap_resume_pic").val('');
			$(".photo").empty();
			alert("파일 사이즈는 5MB까지 입니다.");
		}
	}
	
	//사이즈 체크 함수
	function file_size_check (size, max_size) {
		
		max_size = max_size * 1024 * 1024;	//MB를 byte로 변경
		
		if (size > max_size){
			return false;
		}
		
		return true;
	}
	
	//pdf
	function extension_check_pdf (file_name){
		var extension = file_name.substring(file_name.lastIndexOf('.') + 1).toLowerCase();
		
		switch (extension) {
		case "pdf":
			return true;
		default:
			return false;
		}
	}
	
	//동영상
	function extension_check_video (file_name){
		var extension = file_name.substring(file_name.lastIndexOf('.') + 1).toLowerCase();
		
		switch (extension) {
		case "mp4":
		case "wmv":
		case "mpg":
		case "mpeg":
		case "avi":
			return true;
		default:
			return false;
		}
	}
	
	//이력서 이미지 파일 체크
	function fileImageCheck(name) {
		switch(name.substring(name.lastIndexOf('.') +1).toLowerCase()) {
		case 'gif':
		case 'jpg':
		case 'png':
		case 'jpeg': 
			return true;
		default:
			return false;
		}
	}
	function printWindow() {
		window.print();
	}
</script>
<style type="text/css" media="print">
@page {
	size: auto; /* auto is the initial value */
	margin: 30mm; /* this affects the margin in the printer settings */
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
	<body ng-app="myapp" ng-controller="ResumeController">
		<div style="display: block; position: fixed; top: 1px; left: 25px; z-index: 150;">
			<input class="printBtn" type="button" style="height: 60px; width: 100px;" onclick="printWindow()" value="print">
		</div>
		<div class="resume_wrap page-break" ng-repeat="resumeApply in resumeApplyList">
		<div id="subcontents">
			
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
							<input type="text" class="input1" name="resumeNameList[0].fap_resume_nm" id="fap_resume_nm" ng-model="resumeApply.resumeNameList[0].fap_resume_nm" readonly>
						</li>
						<li class="wid3"><spring:message code="fap.resume.user_nationality" /></li>
						<li class="wid4">
							<input type="text" class="input1" name="fap_resume_nationality" ng-model="resumeApply.fap_resume_nationality" maxlength="10" placeholder="10<spring:message code="fap.placeholder.limit_characters" />" readonly>
						</li>
					</ul>
					<ul class="tit2">
						<li class="wid1"><code value="B3102"></code></li>
						<li class="wid2">
							<input type="hidden" name="resumeNameList[2].fap_resume_lang_gb" value="B3102">
							<input type="text" class="input1" name="resumeNameList[2].fap_resume_nm" id="fap_resume_nm_ja" ng-model="resumeApply.resumeNameList[2].fap_resume_nm" maxlength="10" placeholder="10<spring:message code="fap.placeholder.limit_characters" />" readonly>
						</li>
						<li class="wid3"><code value="B3103"></code></li>
						<li class="wid4">
							<input type="hidden" name="resumeNameList[3].fap_resume_lang_gb" value="B3103">
							<input type="text" class="input1" name="resumeNameList[3].fap_resume_nm" id="fap_resume_nm_yomi" ng-model="resumeApply.resumeNameList[3].fap_resume_nm" maxlength="10" placeholder="10<spring:message code="fap.placeholder.limit_characters" />" readonly>
						</li>						
					</ul>
					<ul class="tit2">
						<li class="wid1"><code value="B3101"></code></li>
						<li class="wid2">
							<input type="hidden" name="resumeNameList[1].fap_resume_lang_gb" value="B3101">
							<input type="text" class="input1" name="resumeNameList[1].fap_resume_nm" id="fap_resume_nm_eng"  ng-model="resumeApply.resumeNameList[1].fap_resume_nm" maxlength="10" placeholder="10<spring:message code="fap.placeholder.limit_characters" />" readonly>
						</li>
						<li class="wid3"><spring:message code="fap.resume.user_dependent" /></li>
						<li class="wid4">
							<input type="text" class="input1" name="fap_resume_dependents" ng-model="resumeApply.fap_resume_dependents" readonly>
							<span class="hiddenTx"><spring:message code="com.placeholder.people" /></span>
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
							<input type="text" class="input1" name="resumeAddrList[{{$index}}].fap_resume_address" ng-model="addr.fap_resume_address" maxlength="100" placeholder="100<spring:message code="fap.placeholder.limit_characters" />" readonly>
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
				<div class="resume_edu_wrap">
					<div class="sub3_bbs3 resume_edu" ng-repeat="eduHistory in resumeApply.resumeEduList">
						<ul class="tit2 title">
							<li class="wid1"><spring:message code="fap.resume.edu_entrance" /></li>
							<li class="wid2"><spring:message code="fap.resume.edu_graduation" /></li>
							<li class="wid3"><spring:message code="fap.resume.edu_period" /></li>
							<li class="wid4"><spring:message code="fap.resume.edu_graduated_or_not" /></li>
						</ul>
						<ul class="tit2">
							<li class="wid1">
								<input type="text" class="input1 fap_resume_edu_er_dt" name="resumeEduList[{{$index}}].fap_resume_edu_er_dt" id="fap_resume_edu_er_dt_{{$index}}" ng-model="eduHistory.fap_resume_edu_er_dt" readonly>
							</li>
							<li class="wid2">
								<input type="text" class="input1 fap_resume_edu_gd_dt" name="resumeEduList[{{$index}}].fap_resume_edu_gd_dt" id="fap_resume_edu_gd_dt_{{$index}}" ng-model="eduHistory.fap_resume_edu_gd_dt" readonly>
							</li>
							<li class="wid3">
								<input type="text" class="input1 fap_resume_edu_pd_summary" name="resumeEduList[{{$index}}].fap_resume_edu_pd_summary" ng-model="eduHistory.fap_resume_edu_pd_summary" maxlength="10" placeholder="10<spring:message code="fap.placeholder.limit_characters" />" readonly>
							</li>
							<li class="wid4">
								<div class="resume-dropdown">
									<div class="resume-select">
										<button type="button" class="resume-select-btn" cd="{{eduHistory.fap_resume_edu_gd_ck}}"></button>
										<input type="hidden" id="resume-gd-gb" name="resumeEduList[{{$index}}].fap_resume_edu_gd_ck" value="{{eduHistory.fap_resume_edu_gd_ck}}">
									</div>
									<div class="resume-select-option">
										<ul class="option-list">
											<li class="resume-gd"  ng-class="{'selected' : eduHistory.fap_resume_edu_gd_ck=='B1000'}">
												<button type="button" resume-gd="B1000"><code value="B1000"></code></button>
											</li>
											<li class="resume-gd"  ng-class="{'selected' : eduHistory.fap_resume_edu_gd_ck=='B1001'}">
												<button type="button" resume-gd="B1001"><code value="B1001"></code></button>
											</li>
											<li class="resume-gd"  ng-class="{'selected' : eduHistory.fap_resume_edu_gd_ck=='B1002'}">
												<button type="button" resume-gd="B1002"><code value="B1002"></code></button>
											</li>
										</ul>
									</div>
								</div>
							</li>
						</ul>
						<ul class="tit3">
							<li class="wid1"><spring:message code="fap.resume.edu_school_nm" /></li>
							<li class="wid2">
								<input type="text" class="input2 fap_resume_edu_sc_nm" name="resumeEduList[0].fap_resume_edu_sc_nm" ng-model="eduHistory.fap_resume_edu_sc_nm" maxlength="50" placeholder="50<spring:message code="fap.placeholder.limit_characters" />" readonly>
							</li>
						</ul>
						<ul class="tit3">
							<li class="wid1"><spring:message code="fap.resume.edu_curriculum" /></li>
							<li class="wid2">
								<input type="text" class="input2" name="resumeEduList[{{$index}}].fap_resume_edu_coll" ng-model="eduHistory.fap_resume_edu_coll"  maxlength="50" placeholder="50<spring:message code="fap.placeholder.limit_characters" />" readonly>
							</li>					
						</ul>
						<ul class="tit3">
							<li class="wid1"><spring:message code="fap.resume.edu_major_field" /></li>
							<li class="wid2">
								<div class="resume-dropdown">
									<div class="resume-select">
										<button type="button" class="resume-select-btn" cd="{{eduHistory.fap_resume_edu_field}}"></button>
										<input type="hidden" id="resume-field-gb" name="resumeEduList[{{$index}}].fap_resume_edu_field" value="{{eduHistory.fap_resume_edu_field}}">
									</div>
									<div class="resume-select-option">
										<ul class="option-list">
											<li class="resume-field" ng-class="{'selected' : eduHistory.fap_resume_edu_field=='B2800'}">
												<button type="button" resume-field="B2800"><code value="B2800"></code></button>
											</li>
											<li class="resume-field" ng-class="{'selected' : eduHistory.fap_resume_edu_field=='B2801'}">
												<button type="button" resume-field="B2801"><code value="B2801"></code></button>
											</li>
											<li class="resume-field" ng-class="{'selected' : eduHistory.fap_resume_edu_field=='B2802'}">
												<button type="button" resume-field="B2802"><code value="B2802"></code></button>
											</li>
											<li class="resume-field" ng-class="{'selected' : eduHistory.fap_resume_edu_field=='B2803'}">
												<button type="button" resume-field="B2803"><code value="B2803"></code></button>
											</li>
											<li class="resume-field" ng-class="{'selected' : eduHistory.fap_resume_edu_field=='B2804'}">
												<button type="button" resume-field="B2804"><code value="B2804"></code></button>
											</li>
											<li class="resume-field" ng-class="{'selected' : eduHistory.fap_resume_edu_field=='B2805'}">
												<button type="button" resume-field="B2805"><code value="B2805"></code></button>
											</li>
											<li class="resume-field" ng-class="{'selected' : eduHistory.fap_resume_edu_field=='B2806'}">
												<button type="button" resume-field="B2806"><code value="B2806"></code></button>
											</li>
											<li class="resume-field" ng-class="{'selected' : eduHistory.fap_resume_edu_field=='B2807'}">
												<button type="button" resume-field="B2807"><code value="B2807"></code></button>
											</li>
										</ul>
									</div>
								</div>
							</li>					
						</ul>
						<ul class="tit3">
							<li class="wid1"><spring:message code="fap.resume.edu_major_nm" /></li>
							<li class="wid2">
								<input type="text" class="input2" name="resumeEduList[{{$index}}].fap_resume_edu_major" ng-model="eduHistory.fap_resume_edu_major"  maxlength="50" placeholder="50<spring:message code="fap.placeholder.limit_characters" />" readonly>
							</li>					
						</ul>
						<ul class="tit3">
							<li class="wid1"><spring:message code="fap.resume.edu_remarks" /></li>
							<li class="wid2">
								<textarea class="auto_heigth" rows="4" cols="20" name="resumeEduList[{{$index}}].fap_resume_edu_note" ng-model="eduHistory.fap_resume_edu_note"  maxlength="150" placeholder="150<spring:message code="fap.placeholder.limit_characters" />" readonly></textarea>
							</li>
						</ul>					
					</div><!-- <div id="sub3_bbs3"> -->
				</div>
			</div><!-- <div id="userjoinBox"> -->
			<!-- ------------------------------------학력관련 교육이수 ---------------------------------------------->
			<div class="userjoinBox">
				<h2><spring:message code="fap.resume.career" /></h2>
				<div class="resume_crr_wrap">
					<div class="sub3_bbs3 resume_crr" ng-repeat ="career in resumeApply.resumeCareerList">
						<ul class="tit2 title">
							<li class="wid1"><spring:message code="fap.resume.career_service_start_day" /></li>
							<li class="wid2"><spring:message code="fap.resume.career_service_completion_day" /></li>
							<li class="wid3"><spring:message code="fap.resume.edu_period" /></li>
							<li class="wid4"><spring:message code="fap.resume.career_position" /></li>
						</ul>
						<ul class="tit2">
							<li class="wid1">
								<input type="text" class="input1 fap_resume_crr_st" name="resumeCareerList[{{$index}}].fap_resume_crr_st" id="fap_resume_crr_st_{{$index}}" ng-model="career.fap_resume_crr_st" readonly>
							</li>
							<li class="wid2">
								<input type="text" class="input1 fap_resume_crr_et" name="resumeCareerList[{{$index}}].fap_resume_crr_et" id="fap_resume_crr_et_{{$index}}" ng-model="career.fap_resume_crr_et" readonly>
							</li>
							<li class="wid3">
								<input type="text" class="input1 fap_resume_crr_pd_summary" name="resumeCareerList[{{$index}}].fap_resume_crr_pd_summary" id ="fap_resume_crr_pd_summary{{$index}}" ng-model="career.fap_resume_crr_pd_summary" maxlength="10" placeholder="10<spring:message code="fap.placeholder.limit_characters" />" readonly>
							</li>
							<li class="wid4">
								<input type="text" class="input1 fap_resume_crr_job_position" name="resumeCareerList[{{$index}}].fap_resume_crr_job_position" ng-model="career.fap_resume_crr_job_position" maxlength="10" placeholder="10<spring:message code="fap.placeholder.limit_characters" />" readonly>
							</li>
						</ul>
						<ul class="tit3">
							<li class="wid1"><spring:message code="fap.resume.career_comp_nm" /></li>
							<li class="wid2">
								<input type="text" class="input2 fap_resume_crr_comp_nm" name="resumeCareerList[{{$index}}].fap_resume_crr_comp_nm" ng-model="career.fap_resume_crr_comp_nm" maxlength="50" placeholder="50<spring:message code="fap.placeholder.limit_characters" />" readonly>
							</li>
						</ul>
						<ul class="tit3">
							<li class="wid1"><spring:message code="fap.resume.career_comp_major_business" /></li>
							<li class="wid2">
								<input type="text" class="input2 fap_resume_crr_major_bussiness" name="resumeCareerList[{{$index}}].fap_resume_crr_major_bussiness" ng-model="career.fap_resume_crr_major_bussiness" maxlength="50" placeholder="50<spring:message code="fap.placeholder.limit_characters" />" readonly>
							</li>					
						</ul>
						<ul class="tit3">
							<li class="wid1"><spring:message code="fap.resume.career_field" /></li>
							<li class="wid2">
								<div class="resume-dropdown">
									<div class="resume-select">
										<button type="button" class="resume-select-btn" cd="{{career.fap_resume_crr_gb}}"></button>
										<input type="hidden" id="resume-crr-gb" name="resumeCareerList[{{$index}}].fap_resume_crr_gb"  value="{{career.fap_resume_crr_gb}}">
									</div>
									<div class="resume-select-option">
										<ul class="option-list">
											<li class="resume-crr">
												<button type="button" resume-crr="B3900"><code value="B3900"></code></button>
											</li>
											<li class="resume-crr">
												<button type="button" resume-crr="B3901"><code value="B3901"></code></button>
											</li>
											<li class="resume-crr">
												<button type="button" resume-crr="B3902"><code value="B3902"></code></button>
											</li>
										</ul>
									</div>
								</div>
							</li>					
						</ul>
						<ul class="tit3">
							<li class="wid1"><spring:message code="fap.resume.career_responsibility" /></li>
							<li class="wid2">
								<textarea class="auto_heigth" rows="4" cols="20" class="fap_resume_crr_job_function" name="resumeCareerList[{{$index}}].fap_resume_crr_job_function"  ng-model="career.fap_resume_crr_job_function" maxlength="150" placeholder="150<spring:message code="fap.placeholder.limit_characters" />" readonly></textarea>
							</li>
						</ul>					
					</div>
				</div>
			</div>	
			<!-- ------------------------------------사회 경력 ---------------------------------------------->
			<div class="userjoinBox">
				<h2><spring:message code="fap.resume.certification" /></h2>
				<div class="resume_license_wrap">
					<div class="sub3_bbs3 resume_license" ng-repeat="license in resumeApply.resumeLicenseList">
						<ul class="tit2 title">
							<li class="wid1"><spring:message code="fap.resume.certification_license" /></li>
							<li class="wid2"><spring:message code="fap.resume.certification_obtained_year" /></li>
							<li class="wid3"><spring:message code="fap.resume.certification_obtained_month" /></li>
							<li class="wid4"><spring:message code="fap.resume.certification_issuing_organization" /></li>
						</ul>
						<ul class="tit2">
							<li class="wid1">
								<div class="resume-dropdown">
									<div class="resume-select">
										<button type="button" class="resume-select-btn" cd="{{license.fap_resume_license_nm}}"></button>
										<input type="hidden" id="resume-license-gb" name="resumeLicenseList[{{$index}}].fap_resume_license_nm" value="{{license.fap_resume_license_nm}}">
									</div>
									<div class="resume-select-option">
										<ul class="option-list">
											<li class="resume-license selected">
												<button type="button" resume-license="B2900"><code value="B2900"></code></button>
											</li>
											<li class="resume-license">
												<button type="button" resume-license="B2901"><code value="B2901"></code></button>
											</li>
											<li class="resume-license">
												<button type="button" resume-license="B2902"><code value="B2902"></code></button>
											</li>
											<li class="resume-license">
												<button type="button" resume-license="B2903"><code value="B2903"></code></button>
											</li>
											<li class="resume-license">
												<button type="button" resume-license="B2904"><code value="B2904"></code></button>
											</li>
											<li class="resume-license">
												<button type="button" resume-license="B2905"><code value="B2905"></code></button>
											</li>
											<li class="resume-license">
												<button type="button" resume-license="B2906"><code value="B2906"></code></button>
											</li>
										</ul>
									</div>
								</div>						
							</li>
							<li class="wid2">
								<input type="text" class="input1 fap_resume_license_get_year" name="resumeLicenseList[{{$index}}].fap_resume_license_get_year" ng-model="license.fap_resume_license_get_year" maxlength="4" placeholder="<spring:message code="com.placeholder.yyyy" />" readonly>
							</li>
							<li class="wid3">
								<input type="text" class="input1 fap_resume_license_get_month" name="resumeLicenseList[{{$index}}].fap_resume_license_get_month" ng-model="license.fap_resume_license_get_month" maxlength="2" placeholder="<spring:message code="com.placeholder.mm" />" readonly>
							</li>
							<li class="wid4">
								<input type="text" class="input1 fap_resume_license_issuing_organization" name="resumeLicenseList[{{$index}}].fap_resume_license_issuing_organization" ng-model="license.fap_resume_license_issuing_organization" maxlength="15" placeholder="15<spring:message code="fap.placeholder.limit_characters" />" readonly>
							</li>
						</ul>
						<ul class="tit3">
							<li class="wid1"><spring:message code="fap.resume.certification_score" /></li>
							<li class="wid2">
								<input type="number" class="input2" name="resumeLicenseList[{{$index}}].fap_resume_license_score" ng-model="license.fap_resume_license_score" maxlength="10" placeholder="10<spring:message code="fap.placeholder.limit_characters" />" readonly>
							</li>
						</ul>
						<ul class="tit3">
							<li class="wid1"><spring:message code="fap.resume.certification_remarks" /></li>
							<li class="wid2">
								<textarea class="auto_heigth" rows="4" cols="20" name="resumeLicenseList[{{$index}}].fap_resume_license_note" ng-model="license.fap_resume_license_note" maxlength="150" placeholder="150<spring:message code="fap.placeholder.limit_characters" />" readonly></textarea>
							</li>
						</ul>					
					</div><!-- <div id="sub3_bbs3"> -->
				</div>
			</div>
			<!-- ----------------------------자격(기술 및 외국어 역량 중심) --------------------------------------------->
			<div class="userjoinBox page-break">
				<h2><spring:message code="fap.resume.talent" /></h2>
				<div class="resume_talent_wrap">
					<div class="sub3_bbs7 resume_talent" ng-repeat="talent in resumeApply.resumeTalentList">
						<ul class="tit2">
							<li class="wid1"><spring:message code="fap.resume.talent_number" /></li>
							<li class="wid2"><spring:message code="fap.resume.talent_context" /></li>
						</ul>
						<ul class="tit3">
							<li class="wid1">{{$index+1}}</li>
							<li class="wid2">
								<textarea class="auto_heigth" rows="4" cols="20" class="fap_resume_talent_content" name="resumeTalentList[{{$index}}].fap_resume_talent_content" ng-model="talent.fap_resume_talent_content" maxlength="200" placeholder="200<spring:message code="fap.placeholder.limit_characters" />" readonly></textarea>
							</li>
						</ul>				
					</div><!-- <div id="sub3_bbs7"> -->
				</div>
			</div><!-- <div id="userjoinBox"> -->				
			<!-- ----------------------------역량/재능(ICT, 외국어, 인간관계 등 업무 관련 상세) --------------------------------------------->
			<div class="userjoinBox">
				<h2><spring:message code="fap.resume.project_development_career" /></h2>
				<div class="resume_project_wrap">
					<div class="sub3_bbs3 resume_project" ng-repeat="project in resumeApply.resumeProjectList">
						<ul class="tit2 title">
							<li class="wid1"><spring:message code="fap.resume.project_development_start_date" /></li>
							<li class="wid2"><spring:message code="fap.resume.project_development_end_date" /></li>
							<li class="wid3"><spring:message code="fap.resume.edu_period" /></li>
							<li class="wid4"><spring:message code="fap.resume.project_development_member" /></li>
						</ul>
						<ul class="tit2">
							<li class="wid1">
								<input type="text" class="input1 fap_resume_project_st" name="resumeProjectList[{{$index}}].fap_resume_project_st" id="fap_resume_project_st_{{$index}}" ng-model="project.fap_resume_project_st" readonly>
							</li>
							<li class="wid2">
								<input type="text" class="input1 fap_resume_project_et" name="resumeProjectList[{{$index}}].fap_resume_project_et" id="fap_resume_project_et_{{$index}}" ng-model="project.fap_resume_project_et" readonly>
							</li>
							<li class="wid3">
								<input type="text" class="input1 fap_resume_project_pd_summary" name="resumeProjectList[{{$index}}].fap_resume_project_pd_summary" id ="fap_resume_project_pd_summary{{$index}}" ng-model="project.fap_resume_project_pd_summary"  maxlength="10" placeholder="10<spring:message code="fap.placeholder.limit_characters" />" readonly>
							</li>
							<li class="wid4">
								<input type="number" class="input1 fap_resume_project_peoples_num" name="resumeProjectList[{{$index}}].fap_resume_project_peoples_num" id="fap_resume_project_peoples_num{{$index}}" ng-model="project.fap_resume_project_peoples_num" maxlength="10" placeholder="10<spring:message code="fap.placeholder.limit_characters" />" readonly>
								<span class="hiddenTx"><spring:message code="com.placeholder.people" /></span>
							</li>
						</ul>
						<ul class="tit3">
							<li class="wid1"><spring:message code="fap.resume.project_nm" /></li>
							<li class="wid2">
								<input type="text" class="input2 fap_resume_project_nm" name="resumeProjectList[{{$index}}].fap_resume_project_nm" ng-model="project.fap_resume_project_nm" maxlength="50" placeholder="50<spring:message code="fap.placeholder.limit_characters" />" readonly>
							</li>
						</ul>
						<ul class="tit3">
							<li class="wid1"><spring:message code="fap.resume.project_main_service" /></li>
							<li class="wid2">
								<textarea class="auto_heigth" rows="4" cols="20" class="fap_resume_project_service" name="resumeProjectList[{{$index}}].fap_resume_project_service" ng-model="project.fap_resume_project_service" maxlength="150" placeholder="150<spring:message code="fap.placeholder.limit_characters" />" readonly></textarea>
							</li>					
						</ul>
						<ul class="tit3">
							<li class="wid1"><spring:message code="fap.resume.project_charge_filed" /></li>
							<li class="wid2">
								<textarea class="auto_heigth" rows="4" cols="20" class="fap_resume_project_responsibility" name="resumeProjectList[{{$index}}].fap_resume_project_responsibility"  ng-model="project.fap_resume_project_responsibility" maxlength="150" placeholder="150<spring:message code="fap.placeholder.limit_characters" />" readonly></textarea>
							</li>
						</ul>
						<ul class="tit3">
							<li class="wid1"><spring:message code="fap.resume.project_used_technique" /></li>
							<li class="wid2">
								<textarea class="auto_heigth" rows="4" cols="20" class="fap_resume_project_technique" name="resumeProjectList[{{$index}}].fap_resume_project_technique" ng-model="project.fap_resume_project_technique" maxlength="150" placeholder="150<spring:message code="fap.placeholder.limit_characters" />" readonly></textarea>
							</li>
						</ul>					
					</div><!-- <div id="sub3_bbs3"> -->
				</div>
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
						<li class="wid1">
							<textarea class="auto_heigth" rows="4" cols="20" name="resumeProfileList[0].fap_resume_pr_content" ng-model="resumeApply.resumeProfileList[0].fap_resume_pr_content" maxlength="1000" placeholder="1000<spring:message code="fap.placeholder.limit_characters" />" readonly></textarea>
						</li>						
					</ul>
					<ul class="tit2">
						<li class="wid1">
							<code value="B4101"></code>
						</li>					
					</ul>
					<ul class="tit3">
						<li class="wid1">
							<textarea class="auto_heigth" rows="4" cols="20" name="resumeProfileList[1].fap_resume_pr_content" ng-model="resumeApply.resumeProfileList[1].fap_resume_pr_content" maxlength="1000" placeholder="1000<spring:message code="fap.placeholder.limit_characters" />" readonly></textarea>
						</li>						
					</ul>
					<ul class="tit2">
						<li class="wid1">
							<code value="B4102"></code>
						</li>				
					</ul>
					<ul class="tit3">
						<li class="wid1">
							<textarea class="auto_heigth" rows="4" cols="20" name="resumeProfileList[2].fap_resume_pr_content" ng-model="resumeApply.resumeProfileList[2].fap_resume_pr_content" maxlength="1000" placeholder="1000<spring:message code="fap.placeholder.limit_characters" />" readonly></textarea>
						</li>						
					</ul>
				</div> <!-- <div id="sub3_bbs8"> -->
			</div><!-- <div id="userjoinBox"> -->			
			<div class="userjoinBox">
				<h2><spring:message code="fap.resume.self_introduction_video_portfolio" /></h2>
				<div id="sub3_bbs9">
					<ul class="tit2">
						<li class="wid1"><spring:message code="fap.resume.self_introduction_url" /></li>
						<li class="wid2">
							<input type="text" class="input1" id="fap_resume_url" name="fap_resume_url" maxlength="100" value="{{resumeApply.fap_resume_url}}" readonly>
						</li>
					</ul>
				</div>
			</div>		
		</div>
		</div>
	</body>
</html>
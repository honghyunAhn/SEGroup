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
<%-- <script src="<c:url value="/resources/segroup/js/jquery-3.1.1.js" />"></script>
<script src="<c:url value="/resources/segroup/js/jquery-ui.js" />"></script>
<script src="<c:url value="/resources/segroup/js/angular.min.js" />"></script>
<script src="<c:url value="/resources/segroup/js/datepicker.js" />"></script>
<script src="<c:url value="/resources/segroup/society/fap/js/lodash.js" />"></script>
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/segroup/society/fap/css/userDefault.css" />" />
<link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css"> --%>

<script src="<c:url value="/resources/segroup/js/jquery-3.1.1.js" />"></script>
<script src="<c:url value="/resources/segroup/js/jquery-ui.js" />"></script>
<script src="<c:url value="/resources/segroup/js/angular.min.js" />"></script>
<script src="<c:url value="/resources/segroup/js/datepicker.js" />"></script>
<script src="<c:url value="/resources/segroup/society/fap/js/lodash.js" />"></script>
<%-- <link rel="stylesheet" type="text/css" href="<c:url value="/resources/segroup/society/fap/css/userDefault.css" />" /> --%>
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/segroup/society/fap/css/default.css" />" />
<link type="text/css" rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto:400,500">		
<link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
<title>Bridge Job Fair</title>
<script type="text/javascript">
	$(function() {
		realTimeValidation();
		_update = _.debounce(function(){
			$('#resume_form').submit(); 
		},500,true);
		
		cleanDatepicker();
		//calPrintHeight();
		
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
		//calPrintHeight();
		window.print();
	}
	
	// 용지 크기에 맞게 지원서 잘라주는 메소드 현재 수정 필요
	function calPrintHeight() {
		
		//지원서가 들어있는 div를 가져온다
		var resumeContent = $(".resume_wrap");
		
		$.each(resumeContent, function(index, item) {
			
			//지원서 안에 요소들을 가지고 있는 div를 가져온다
			var resumeSection = $(this).children("#subcontents");
			
			//지원서 요소를 가지고 있는 div의 높이가 a4 용지를 넘을 때
			if (resumeSection.outerHeight() > 1500) {
				
				//헤더의 높이
				//var headerHeight = resumeSection.children("h2").outerHeight();
				//각 요소들을 가져온다
				var resumeWrap = resumeSection.find(".userjoinBox");
				//요소들의 총 높이
				var totalElemHeight = 0;
				
				//요소들의 높이를 더하다가, A4 크기가 넘어가는 순간 
				//해당 요소에 페이지를 넘겨주는 css를 가진 class값을 추가한다
				$.each(resumeWrap, function(index, item){
					
					totalElemHeight += $(item).outerHeight();
					
					if(totalElemHeight > 1500) {
						var ul = $(this).children();
						console.log(ul.get().reverse())
						$.each(ul.get().reverse(), function(index, item){
							if($(item).is('div')) {
								$.each($(item).find('ul').get().reverse(), function(index, item){
									totalElemHeight = totalElemHeight - $(item).outerHeight();
									
									if(totalElemHeight < 1500) {
										console.log("dd = " + totalElemHeight)
										console.log($(item))
										$(item).addClass("pageBreak");
										totalElemHeight = 0;
										return false
									}
								})
							} else if($(item).is('h2')){
								console.log("h2")
								totalElemHeight = totalElemHeight - $(item).outerHeight();
								
								if(totalElemHeight < 1500) {
									console.log("dd = " + totalElemHeight)
									console.log($(item))
									$(item).addClass("pageBreak");
									totalElemHeight = 0;
								}
							}
							if(totalElemHeight == 0) {
								return false
							}
						})
					}
				});
			}
		});
	}
</script>
<!-- <style>
@page {
	size: auto; /* auto is the initial value */
	margin: 0; /* this affects the margin in the printer settings */
}

html {
	margin: 0px;
}

body {
	margin: 0mm; /* margin you want for the content */
}
.sub3_bbs3 {
 	margin-top: 0px;
 	margin-bottom: 0px;
}
.sub3_bbs3 .tit2 {
	padding-top: 0px;
	padding-bottom: 0px;
	/* border-bottom: none; */
}
.sub3_bbs3 .tit3 {
	padding-top: 0px;
	padding-bottom: 0px;
}
.userjoinBox {
	padding-bottom: 0px;
}
.print_style ul	{
display:table;
width: 100%;
text-align: center;
table-layout:fixed;
word-break : break-all;
}
.print_style ul > li{
display: table-cell !important;
vertical-align : middle;
border : 1px solid #ccc; 
padding: 2px;
text-align: center !important;
}
.print_style ul > li:nth-child(1)~*{
	border-left:none;
}
textarea.auto_heigth {
	height: inherit;
	min-height: 25px;
}
.sub3_bbs7 .tit3 {
	min-height: 0px;
}
.sub3_bbs7 .tit3 .wid2 {
	/* height: auto; */
}
</style> -->
<style type="text/css" media="print">
@page {
	size: auto; /* auto is the initial value */
	margin: 0; /* this affects the margin in the printer settings */
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
#sub3_bbs2.basic_top {
	height: 230px;
}
textarea.auto_heigth {
	height: auto; 
	min-height: 25px;
}
.sub3_bbs3 {
 	margin-top: 0px;
 	margin-bottom: 0px;
}
.sub3_bbs3 .tit2 {
	padding-top: 0px;
	padding-bottom: 0px;
	/* border-bottom: none; */
}
.sub3_bbs3 .tit3 {
	padding-top: 0px;
	padding-bottom: 0px;
}
.userjoinBox {
	padding-bottom: 0px;
}
.print_style ul	{
display:table;
width: 100%;
text-align: center;
table-layout:fixed;
word-break : break-all;
       }
.print_style ul > li{
display: table-cell !important;
vertical-align : middle;
/* border : 1px solid #ccc; */
padding: 2px;
text-align: center !important;
       }
.print_style ul>li:nth-child(1)~*{
border-left:none;
       }
.pageBreak {
	page-break-before: always;
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
				<h2><spring:message code="fap.resume.user_info" /></h2>
				<div id="sub3_bbs2" class="basic_top">
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
						<li class="wid1"><code value="B3102"></code></li>
						<li class="wid2">
							<span ng-bind="resumeApply.resumeNameList[2].fap_resume_nm"></span>
						</li>
						<li class="wid3"><code value="B3103"></code></li>
						<li class="wid4">
							<span ng-bind="resumeApply.resumeNameList[3].fap_resume_nm"></span>
						</li>
							<li class="wid1"><code value="B3101"></code></li>
						<li class="wid2">
							<span ng-bind="resumeApply.resumeNameList[1].fap_resume_nm"></span>
						</li>
						<li class="wid3"><spring:message code="fap.resume.user_dependent" /></li>
						<li class="wid4">
							<span ng-bind="resumeApply.fap_resume_dependents"></span><spring:message code="com.placeholder.people" />
						</li>
						<li class="wid1"><spring:message code="fap.resume.user_gender" /></li>
						<li class="wid2">
							<div class="span-code" cd="{{resumeApply.fap_resume_gender}}"></div>
						</li>
						<li class="wid1"><spring:message code="fap.resume.user_married_or_not" /></li>
						<li class="wid2">
							<div class="span-code" cd="{{resumeApply.fap_resume_marital}}"></div>
						</li>
						<li class="wid1"><spring:message code="fap.resume.user_birth" /></li>
						<li class="wid2">
							<span ng-bind="resumeApply.fap_resume_birth"></span>
						</li>
						<li class="wid1"><spring:message code="fap.resume.user_address" /></li>
						<li class="wid2 resumeAddr" ng-repeat="addr in resumeApply.resumeAddrList">	
							<span ng-bind="addr.fap_resume_address"></span>
						</li>
					</ul>
				</div><!-- <div id="sub3_bbs2"> -->
			</div> <!-- <div id="userjoinBox"> -->		

			<!-- ------------------------------------기본정보---------------------------------------------->
			<div class="userjoinBox">
				<h2><spring:message code="fap.resume.edu_history" /></h2>
				<div class="sub3_bbs3 resume_edu print_style" ng-repeat="eduHistory in resumeApply.resumeEduList">
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
					<ul class="tit2 title">
						<li class="wid1"><spring:message code="fap.resume.edu_school_nm" /></li>
						<li class="wid2"><spring:message code="fap.resume.edu_curriculum" /></li>
						<li class="wid3"><spring:message code="fap.resume.edu_major_field" /></li>
						<li class="wid4"><spring:message code="fap.resume.edu_major_nm" /></li>
					</ul>
					<ul class="tit2">
						<li class="wid1">
							<span ng-bind="eduHistory.fap_resume_edu_sc_nm"></span>
						</li>
						<li class="wid2 ">
							<span ng-bind="eduHistory.fap_resume_edu_coll"></span>
						</li>
						<li class="wid3">
							<div class="span-code" cd="{{eduHistory.fap_resume_edu_field}}"></div>
						</li>
						<li class="wid4">
							<span ng-bind="eduHistory.fap_resume_edu_major"></span>
						</li>
					</ul>
					<ul class="tit3" ng-if="eduHistory.fap_resume_edu_note != ''">
						<li class="wid1"><spring:message code="fap.resume.edu_remarks" /></li>
						<li class="wid2">
							<textarea class="auto_heigth"  ng-bind="eduHistory.fap_resume_edu_note" readonly="readonly"></textarea>
						</li>
					</ul>		
				</div><!-- <div id="sub3_bbs3"> -->
			</div><!-- <div id="userjoinBox"> -->
			<!-- ------------------------------------학력관련 교육이수 ---------------------------------------------->
			<div class="userjoinBox">
				<h2><spring:message code="fap.resume.career" /></h2>
				<div class="sub3_bbs3 resume_crr print_style" ng-repeat ="career in resumeApply.resumeCareerList">
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
					<ul class="tit2 title">
						<li class="wid1"><spring:message code="fap.resume.career_comp_nm" /></li>
						<li class="wid2"><spring:message code="fap.resume.career_comp_major_business" /></li>
						<li class="wid3"><spring:message code="fap.resume.career_field" /></li>
					</ul>
					<ul class="tit2">
						<li class="wid1">
							<span ng-bind="career.fap_resume_crr_comp_nm"></span>
						</li>
						<li class="wid2">
							<span ng-bind="career.fap_resume_crr_major_bussiness"></span>
						</li>
						<li class="wid3">
							<div class="span-code" cd="{{career.fap_resume_crr_gb}}"></div>
						</li>	
					</ul>
					<ul class="tit3" ng-if="career.fap_resume_crr_job_function != ''">
						<li class="wid1"><spring:message code="fap.resume.career_responsibility" /></li>
						<li class="wid2">
							<textarea class="auto_heigth"  ng-bind="career.fap_resume_crr_job_function" readonly="readonly"></textarea>
						</li>
					</ul>				
				</div>
			</div>	
			<!-- ------------------------------------사회 경력 ---------------------------------------------->
			<div class="userjoinBox">
				<h2><spring:message code="fap.resume.certification" /></h2>
				<div class="sub3_bbs3 resume_license print_style" ng-repeat="license in resumeApply.resumeLicenseList">
					<ul class="tit2 title">
						<li class="wid1"><spring:message code="fap.resume.certification_license" /></li>
						<li class="wid2"><spring:message code="fap.resume.certification_obtained_year" /></li>
						<li class="wid3"><spring:message code="fap.resume.certification_issuing_organization" /></li>
						<li class="wid4"><spring:message code="fap.resume.certification_score" /></li>
					</ul>
					<ul class="tit2">
						<li class="wid1">
							<div class="span-code" cd="{{license.fap_resume_license_nm}}"></div>
						</li>
						<li class="wid2">
							<span ng-bind="license.fap_resume_license_get_year"></span>-<span ng-bind="license.fap_resume_license_get_month"></span>
						</li>
						<li class="wid3">
							<span ng-bind="license.fap_resume_license_issuing_organization"></span>
						</li>
						<li class="wid4">
							<span ng-bind="license.fap_resume_license_score"></span>
						</li>
					</ul>
					<ul class="tit3" ng-if="license.fap_resume_license_note != ''">
						<li class="wid1"><spring:message code="fap.resume.certification_remarks" /></li>
						<li class="wid2">
							<textarea class="auto_heigth"  ng-bind="license.fap_resume_license_note" readonly="readonly"></textarea>
						</li>
					</ul>				
				</div><!-- <div id="sub3_bbs3"> -->
			</div>
			<!-- ----------------------------자격(기술 및 외국어 역량 중심) --------------------------------------------->
			<div class="userjoinBox ">
				<h2><spring:message code="fap.resume.talent" /></h2>
				<div class="sub3_bbs7 resume_talent print_style">
					<ul class="tit2">
						<li class="wid1"><spring:message code="fap.resume.talent_number" /></li>
						<li class="wid2"><spring:message code="fap.resume.talent_context" /></li>
					</ul>
					<ul class="tit3" ng-repeat="talent in resumeApply.resumeTalentList">
						<li class="wid1">{{$index+1}}</li>
						<li class="wid2">
							<textarea class="auto_heigth" ng-bind="talent.fap_resume_talent_content" readonly="readonly"></textarea>
						</li>
					</ul>				
				</div><!-- <div id="sub3_bbs7"> -->
			</div><!-- <div id="userjoinBox"> -->				
			<!-- ----------------------------역량/재능(ICT, 외국어, 인간관계 등 업무 관련 상세) --------------------------------------------->
			<div class="userjoinBox">
				<h2><spring:message code="fap.resume.project_development_career" /></h2>
				<div class="sub3_bbs3 resume_project print_style" ng-repeat="project in resumeApply.resumeProjectList">
					<ul class="tit2 title">
						<li class="wid1"><spring:message code="fap.resume.project_development_start_date" /></li>
						<li class="wid2"><spring:message code="fap.resume.project_development_end_date" /></li>
						<li class="wid3"><spring:message code="fap.resume.project_development_member" /></li>
						<li class="wid4"><spring:message code="fap.resume.project_nm" /></li>
					</ul>
					<ul class="tit2">
						<li class="wid1">
							<span ng-bind="project.fap_resume_project_st"></span>
						</li>
						<li class="wid2">
							<span ng-bind="project.fap_resume_project_et"></span>
						</li>
						<li class="wid3">
							<span ng-bind="project.fap_resume_project_peoples_num"></span>
							<spring:message code="com.placeholder.people" />
						</li>
						<li class="wid4">
							<span ng-bind="project.fap_resume_project_nm"></span>
						</li>
					</ul>
					<ul class="tit3">
						<li class="wid1"><spring:message code="fap.resume.project_main_service" /></li>
						<li class="wid2">
							<textarea class="auto_heigth"  ng-bind="project.fap_resume_project_service" readonly="readonly"></textarea>
						</li>					
					</ul>
					<ul class="tit3 ">
						<li class="wid1"><spring:message code="fap.resume.project_charge_filed" /></li>
						<li class="wid2">
							<textarea class="auto_heigth"  ng-bind="project.fap_resume_project_responsibility" readonly="readonly"></textarea>
						</li>
					</ul>
					<ul class="tit3">
						<li class="wid1"><spring:message code="fap.resume.project_used_technique" /></li>
						<li class="wid2">
							<textarea class="auto_heigth" ng-bind="project.fap_resume_project_technique" readonly="readonly"></textarea>
						</li>
					</ul>			
				</div><!-- <div id="sub3_bbs3"> -->
			</div>		
			<!-- ----------------------------SW 프로젝트 개발경력 --------------------------------------------->
			<div class="userjoinBox ">
				<h2><spring:message code="fap.resume.self_introduction" /></h2>
				<div class="sub3_bbs8">
					<ul class="tit2">
						<li class="wid1">
							<code value="B4100"></code>
						</li>					
					</ul>
					<ul class="tit3">
						<li class="wid1">
							<textarea class="auto_heigth"  ng-bind="resumeApply.resumeProfileList[0].fap_resume_pr_content" readonly="readonly"></textarea>
						</li>						
					</ul>
					<ul class="tit2">
						<li class="wid1">
							<code value="B4101"></code>
						</li>
					</ul>
					<ul class="tit3">
						<li class="wid1">
							<textarea class="auto_heigth"  ng-bind="resumeApply.resumeProfileList[1].fap_resume_pr_content" readonly="readonly"></textarea>
						</li>						
					</ul>
					<ul class="tit2">
						<li class="wid1">
							<code value="B4102"></code>
						</li>
					</ul>
					<ul class="tit3">
						<li class="wid1">
							<textarea class="auto_heigth"  ng-bind="resumeApply.resumeProfileList[2].fap_resume_pr_content" readonly="readonly"></textarea>
						</li>						
					</ul>
				</div> <!-- <div id="sub3_bbs8"> -->
			</div><!-- <div id="userjoinBox"> -->	
			<div class="userjoinBox">
				<h2><spring:message code="fap.resume.self_introduction_video_portfolio" /></h2>
				<div id="sub3_bbs9" class="sub3">
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
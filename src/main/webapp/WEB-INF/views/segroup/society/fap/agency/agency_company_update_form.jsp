<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Bridge Job Fair</title>
</head>
<script src="<c:url value="/resources/segroup/js/jquery-3.1.1.js" />"></script>
<script src="<c:url value="/resources/segroup/js/angular.min.js" />"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
<script src="<c:url value="/resources/segroup/js/jquery-ui.js" />"></script>
<script src="<c:url value="/resources/segroup/js/angular.min.js" />"></script>

<link type="text/css" rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto:400,500">
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/segroup/society/fap/css/default.css" />" />
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/segroup/society/fap/css/popModal.css" />" />
<script type="text/javascript">
var blank_regex = /\s/g;

	$(function() {
		//모든 input text 글자수 제한
		$("input[type='text']").keyup(function(){
		        if ($(this).val().length > $(this).attr('maxlength')) {
		            alert('<spring:message code="fap.err.over_maxlength" javaScriptEscape="true" />');
		            $(this).val($(this).val().substr(0, $(this).attr('maxlength')));
		        }
		});
		$("input[type='number']").keyup(function(){
	        if ($(this).val().length > $(this).attr('maxlength')) {
	            alert('<spring:message code="fap.err.over_maxlength" javaScriptEscape="true" />');
	            $(this).val($(this).val().substr(0, $(this).attr('maxlength')));
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
		$("#fap_comp_log_file").change(function() {
			var val = $(this).val();

			if (val == "") {
				$(this).val('');
				$("#imgDiv").empty();
				return;
			} else if (fileImageCheck(val)) {
				photoAjax();
			} else {
				$(this).val('');
				$("#imgDiv").empty();
				alert('<spring:message code="fap.err.image_type" javaScriptEscape="true" />');
				return;
			}
		});
	});
	//trim 함수
	function trim(stringToTrim) {
	    return stringToTrim.replace(/^\s+|\s+$/g,"");
	};
	/**
	 * angular.js
	 */
	var myApp = angular.module('myapp', []);
	
	myApp.controller('AgencyController',['$scope','$compile', '$http', function($scope, $compile, $http) {
		
		var company_info = '${company_info}';
		var company_info_json = JSON.parse(company_info);
		console.log(company_info_json);
		//이미지 {{}} 앵귤러 썻을 때 에러 처리하는 부분
		$('#imgDiv').children().remove();
		$('#imgDiv').append('<img style="width:30%; height:30%;" alt="" src="/fap/company/user_logo_image/' + company_info_json.fap_comp_id + '/' + company_info_json.fap_comp_log_saved + '">');
		$scope.company_info = company_info_json;
		
	}]);
	
	myApp.directive('code', ['$http', function($http){
		return {
			restrict: "E",
			replace: true,
			scope : {
				value : '@'
			}
			, controller: function ($scope, $element, $attrs) {
				$http({
					method: 'POST',
					url: '/codeconverter',
			  		responseType: 'text',
					params : {
						code : $attrs.value
					}
				}).then(function successCallback(response) {
		    		$scope.filterParams = response.data;
				} , function errorCallback(response) {
					console.log(response);
				});
			}
			, template: "<span>{{filterParams}}</span>"
		}
	}]);
	//blurCurrency
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
	function form_check() {
		//blurCurrency
		$.each($(".currency"),function(index,item){
			var commaValue = angular.element(item).val();
			
			angular.element(item).val(commaValue.replace(/,/g, ''));
		});
		var fap_comp_ja_nm = $('#fap_comp_ja_nm');
		var fap_comp_en_nm = $('#fap_comp_en_nm');
		var fap_comp_business_num = $('#fap_comp_business_num');
		var fap_comp_rep = $('#fap_comp_rep');
		var fap_comp_major_bussiness = $('#fap_comp_major_bussiness');
		var fap_comp_homepage = $('#fap_comp_homepage');
		var fap_comp_postcode = $('#fap_comp_postcode');
		var fap_comp_address = $('#fap_comp_address')
		var fap_comp_address_detail = $('#fap_comp_address_detail');;
		var fap_comp_est_dt = $('#fap_comp_est_dt');
		var fap_comp_stock =$('#fap_comp_stock');
		var fap_comp_3years_avg_sales =$('#fap_comp_3years_avg_sales');
		var fap_comp_employee_num = $('#fap_comp_employee_num');
		//사진유무체크

		fap_comp_ja_nm.val(trim(fap_comp_ja_nm.val()));
		if(fap_comp_ja_nm.val() == ''){
			alert('<spring:message code="fap.err.comp_ja_name_input" javaScriptEscape="true" />');
			$('#fap_comp_ja_nm').focus();
			return false;
		}
		
		fap_comp_en_nm.val(trim(fap_comp_en_nm.val()));
		if(fap_comp_en_nm.val() == ''){
			alert('<spring:message code="fap.err.comp_en_name_input" javaScriptEscape="true" />');
			$('#fap_comp_en_nm').focus();
			return false;
		}
		
		fap_comp_business_num.val(trim(fap_comp_business_num.val()));
	
		fap_comp_rep.val(trim(fap_comp_rep.val()));
		if(fap_comp_rep.val() == ''){
			alert('<spring:message code="fap.err.represent_name_input" javaScriptEscape="true" />');
			$('#fap_comp_rep').focus();
			return false;
		}
		
		fap_comp_major_bussiness.val(trim(fap_comp_major_bussiness.val()));
		if(fap_comp_major_bussiness.val() == ''){
			alert('<spring:message code="fap.err.major_bussiness_input" javaScriptEscape="true" />');
			$('#fap_comp_major_bussiness').focus();
			return false;
		}
		
		fap_comp_homepage.val(trim(fap_comp_homepage.val()));
		
		fap_comp_postcode.val(trim(fap_comp_postcode.val()));
		if(fap_comp_postcode.val() == ''){
			alert('<spring:message code="fap.err.postcode_input" javaScriptEscape="true" />');
			$('#fap_comp_postcode').focus();
			return false;
		}
		
		fap_comp_address.val(trim(fap_comp_address.val()));
		if(fap_comp_address.val() == ''){
			alert('<spring:message code="fap.err.addr_input" javaScriptEscape="true" />');
			$('#fap_comp_address').focus();
			return false;
		}
		
		fap_comp_address_detail.val(trim(fap_comp_address_detail.val()));
		
		fap_comp_est_dt.val(trim(fap_comp_est_dt.val()));
		if(fap_comp_est_dt.val() == ''){
			alert('<spring:message code="fap.err.comp_est_dt_input" javaScriptEscape="true" />');
			$('#fap_comp_est_dt').focus();
			return false;
		}
		//자본금
		if(fap_comp_stock.val() == 0){
			alert('<spring:message code="fap.err.comp_stock" javaScriptEscape="true" />');
			$('#fap_comp_stock').focus();
			return false;
		}
		//최근 3년 매출
		if(fap_comp_3years_avg_sales.val() == 0){
			alert('<spring:message code="fap.err.comp_est_dt_input" javaScriptEscape="true" />');
			$('#fap_comp_3years_avg_sales').focus();
			return false;
		}
		fap_comp_employee_num.val(trim(fap_comp_employee_num.val()));
		if(fap_comp_employee_num.val() == 0){
			alert('<spring:message code="fap.err.emp_num_input" javaScriptEscape="true" />');
			$('#fap_comp_employee_num').focus();
			return false;
		}
		
		$("input[type='number']").each(function(index, item){
			var value = $(item).val();
			if(value == null || value == ""){
				
				$(item).val("0");
			}
			
		})
		
		$('#agency_company_update').submit();
	}

	// 회사 정보 입력폼
	function show_company_insert_form(company_ck) {
		if(company_ck == 'nonexistent'){
			$('#company_insert').show();
		} else if(company_ck == 'existent'){
			$('#company_insert').hide();
		}
	}
	
	// 사진 AJAX
	function photoAjax() {
		var size = $("#fap_comp_log_file")[0].files[0].size;
		if (fileSizeCheck(size)) {
			var formData = new FormData();
			formData.append("file", $("#fap_comp_log_file")[0].files[0]);

			$.ajax({
				type : "POST",
				url : "/temporarily_upload",
				data : formData,
				processData : false,
				contentType : false,
				dataType : "json",
				success : function(data) {
					$("#imgDiv").empty();
					$("#imgDiv").html('<img alt="" style="width:30%; height:30%;" src="/edu/temporarilyPath/'+data.savedfile+'">');
				},
				error : function(e) {
					console.log(e);
				}
			});
		} else {
			$("#app_photo_file").val('');
			$("#imgDiv").empty();
			alert('<spring:message code="fap.err.file_size" javaScriptEscape="true" />');
		}
	}
	
	function fileSizeCheck(size) {
		//5MB
		var maxSize = 5242880;
		var fileSize = Math.round(size);
		if (fileSize > maxSize) {
			return false;
		}
		return true;
	}
	
	function fileImageCheck(name) {
		switch (name.substring(name.lastIndexOf('.') + 1).toLowerCase()) {
		case 'gif':
		case 'jpg':
		case 'png':
			return true;
		default:
			return false;
		}
	}
	
</script>
<body ng-app="myapp" ng-controller="AgencyController">
<%@include file="agency_menu.jsp"%>
<div class="join-wrap">
	<div id="subcontents">
		<form action="/fap/agency/agency_company_update" method="post" enctype="multipart/form-data" id="agency_company_update">
		
			<div id="company_insert">
				<div class="joinBox">
						<div class="jointt">
							<p class="jointxt1">
						        <spring:message code="fap.common.responsible_company_info" />
							</p>
						</div>
						<div class="join-contents">
							<div class="joinBBS">
									<div class="joinBBS-row">
										<!-- 기업명 일문 -->
										<div class="joinlt point"><spring:message code="fap.comp.ja_nm" /><span class="red-point"></span></div>
										<div class="joinrt"><input type="text" id="fap_comp_ja_nm" name="fap_comp_ja_nm" ng-model="company_info.fap_comp_ja_nm" maxlength="50" placeholder="50<spring:message code="fap.placeholder.limit_characters" />"></div>
									</div>
									<div class="joinBBS-row">
										<!-- 기업명 영문 -->
										<div class="joinlt point"><spring:message code="fap.comp.en_nm" /><span class="red-point"></span></div>
										<div class="joinrt"><input type="text" id="fap_comp_en_nm" name="fap_comp_en_nm" ng-model="company_info.fap_comp_en_nm" maxlength="50" placeholder="50<spring:message code="fap.placeholder.limit_characters" />"></div>
									</div>
									<div class="joinBBS-row">
										<!-- 사업자 등록번호 -->
										<div class="joinlt"><spring:message code="fap.comp.business_num" /></div>
										<div class="joinrt"><input type="text" id="fap_comp_business_num" name="fap_comp_business_num" ng-model="company_info.fap_comp_business_num" placeholder="<spring:message code="fap.placeholder.business_num" />"　maxlength="25"></div>
									</div>
									<div class="joinBBS-row">
										<!-- 대표자명 -->
											<div class="joinlt point"><spring:message code="fap.comp.rep" /><span class="red-point"></span></div>
											<div class="joinrt"><input type="text" id="fap_comp_rep" name="fap_comp_rep" ng-model="company_info.fap_comp_rep" maxlength="15"></div>
									</div>
									<div class="joinBBS-row">
										<!-- 주요산업분야 -->
										<div class="joinlt point"><spring:message code="fap.comp.major_bussiness" /><span class="red-point"></span></div>
										<div class="joinrt"><input type="text" id="fap_comp_major_bussiness" name="fap_comp_major_bussiness" ng-model="company_info.fap_comp_major_bussiness" maxlength="100" placeholder="50<spring:message code="fap.placeholder.limit_characters" />"></div>
									</div>
									<div class="joinBBS-row">	
										<!-- 홈페이지 -->
										<div class="joinlt"><spring:message code="fap.comp.homepage" /></div>
										<div class="joinrt"><input type="text" id="fap_comp_homepage" name="fap_comp_homepage" ng-model="company_info.fap_comp_homepage" maxlength="75"></div>
									</div>
									<div class="joinBBS-row">
										<!-- 우편번호 -->
										<div class="joinlt point"><spring:message code="fap.comp.postcode" /><span class="red-point"></span></div>
										<div class="joinrt"><input type="text" id="fap_comp_postcode" name="fap_comp_postcode" ng-model="company_info.fap_comp_postcode" maxlength="10" placeholder="<spring:message code="fap.placholder.postcode" />"></div>
									</div>
									<div class="joinBBS-row">
										<!-- 주소 -->
										<div class="joinlt point"><spring:message code="fap.comp.address" /><span class="red-point"></span></div>
										<div class="joinrt"><input type="text" id="fap_comp_address" name="fap_comp_address" ng-model="company_info.fap_comp_address" maxlength="150"></div>
									</div>
									<div class="joinBBS-row">
										<!-- 상세주소 -->
										<div class="joinlt"><spring:message code="fap.comp.address_detail" /></div>
										<div class="joinrt"><input type="text" id="fap_comp_address_detail" name="fap_comp_address_detail" ng-model="company_info.fap_comp_address_detail" maxlength="150"></div>
									</div>
									<div class="joinBBS-row">	
										<!-- 설립일 -->
										<div class="joinlt point"><spring:message code="fap.comp.est_dt" /><span class="red-point"></span></div>
										<div class="joinrt"><input type="text" id="fap_comp_est_dt" name="fap_comp_est_dt" ng-model="company_info.fap_comp_est_dt" placeholder="<spring:message code="fap.placeholder.est_dt" />" maxlength="25"></div>
									</div>
									<div class="joinBBS-row">
										<!-- 자본금 -->
										<div class="joinlt point"><spring:message code="fap.comp.stock" /><span class="red-point"></span></div>
										<div class="joinrt"><input type="text" class="currency" id="fap_comp_stock" name="fap_comp_stock" ng-model="company_info.fap_comp_stock" blur-currency maxlength="22">
										<span class="hiddenTx">円</span>
										</div>
									</div>
									<div class="joinBBS-row">
										<!-- 최근 3년간 평균매출 -->
										<div class="joinlt point"><spring:message code="fap.comp.3years_avg_sales" /><span class="red-point"></span></div>
										<div class="joinrt"><input type="text" class="currency" id="fap_comp_3years_avg_sales" name="fap_comp_3years_avg_sales" ng-model="company_info.fap_comp_3years_avg_sales" blur-currency maxlength="22">
										<span class="hiddenTx">円</span>
										</div>
									</div>
									<div class="joinBBS-row">	
										<!-- 사원수 -->
										<div class="joinlt point"><spring:message code="fap.comp.employee_num" /><span class="red-point"></span></div>
										<div class="joinrt"><input type="text" class="currency" id="fap_comp_employee_num" name="fap_comp_employee_num" ng-model="company_info.fap_comp_employee_num" maxlength="9" blur-currency>
										<span class="hiddenTx">名</span>
										</div>
									</div>
									<div class="joinBBS-row">
										<!-- SC IT Master 사원수 -->
										<div class="joinlt nl"><spring:message code="fap.comp.scit_num" /></div>
										<div class="joinrt"><input type="text" class="currency" id="fap_comp_scit_num" name="fap_comp_scit_num" ng-model="company_info.fap_comp_scit_num" maxlength="9" blur-currency>
										<span class="hiddenTx">名</span>
										</div>
									</div>
									<div class="joinBBS-row">
										<!-- 한국인 사원수 -->
										<div class="joinlt"><spring:message code="fap.comp.korean_num" /></div>
										<div class="joinrt"><input type="text" class="currency" id="fap_comp_korean_num" name="fap_comp_korean_num" ng-model="company_info.fap_comp_korean_num" maxlength="9" blur-currency>
										<span class="hiddenTx">名</span>
										</div>
									</div>
									<div class="joinBBS-row">
										<!-- 기타 외국인 사원수 -->
										<div class="joinlt"><spring:message code="fap.comp.foreigner_num" /></div>
										<div class="joinrt"><input type="text" class="currency" id="fap_comp_foreigner_num" name="fap_comp_foreigner_num" ng-model="company_info.fap_comp_foreigner_num" maxlength="9" blur-currency>
										<span class="hiddenTx">名</span>
										</div>
									</div>
									<div class="joinBBS-row">
										<!-- 로고등록 -->
										<div class="joinlt point"><spring:message code="fap.comp.log_file" /><span class="red-point"></span></div>
										<div class="joinrt"><input type="file" id="fap_comp_log_file" name="fap_comp_log_file" accept="image/*"></div>
									</div>
									
									<div class="joinBBS-row2">
										<!-- 로고 동의 여부-->
										<div><spring:message code="fap.comp.log_using" /></div>	
										<input type="radio" id="radio3" name="fap_comp_log_using" value="B3200" checked="checked" ng-model="company_info.fap_comp_log_using">
										<label for="radio3">
											<span class="radio-span"></span>
											<b><code value="B3200"></code></b>
										</label> &nbsp;
										
										<input type="radio" id="radio4" name="fap_comp_log_using" value="B3201" ng-model="company_info.fap_comp_log_using">
										<label for="radio4">
											<span class="radio-span"></span>
											<b><code value="B3201"></code></b>
										</label> &nbsp;
										
										<input type="radio" id="radio5" name="fap_comp_log_using" value="B3202" ng-model="company_info.fap_comp_log_using">
										<label for="radio5">
											<span class="radio-span"></span>
											<b><code value="B3202"></code></b>
										</label>
										<br><br>
										<div id="imgDiv">
										<!-- 이미지 나올부분  -->
										</div>
									</div>
									<input type="hidden" id="fap_comp_log_saved" name="fap_comp_log_saved" value="{{company_info.fap_comp_log_saved}}">
								</div>
							</div>
						</div>
					</div>
					<input type="hidden" name="fap_comp_id" value="{{company_info.fap_comp_id}}">
					<div class="joinBox">
						<div class="join-policy">
							<div id="joinBtn">
								<button class="join-btn icon submitBtn" type="button" onclick="form_check();"><spring:message code="fap.common.update.btn" /></button>
							</div>
						</div>
					</div>
				</form>
			</div>
		</div>
<%@include file="agency_footer.jsp"%>
</body>
</html>
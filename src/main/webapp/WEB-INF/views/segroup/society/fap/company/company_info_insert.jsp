<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
<script src="<c:url value="/resources/segroup/society/fap/js/lodash.js" />"></script>

<link type="text/css" rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto:400,500">
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/segroup/society/fap/css/default.css" />" />
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/segroup/society/fap/css/popModal.css" />" />

<script type="text/javascript">

	$(function() {
		_insert = _.debounce(function(){
			 $('#company_info_insert').submit();
		},500,true);
		
		$("input[type='text']").keyup(function(){
			//모든 input text 글자수 제한
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
	
	/**
	 * angular.js
	 */
	var myApp = angular.module('myapp', []);
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
					//console.log(response);
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
	//trim 함수
	function trim(stringToTrim) {
	    return stringToTrim.replace(/^\s+|\s+$/g,"");
	};
	
 	function checkOnSubmit() {
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
		var fap_comp_address = $('#fap_comp_address');
		var fap_comp_address_detail =$('#fap_comp_address_detail');
		var fap_comp_est_dt = $('#fap_comp_est_dt');
		var fap_comp_stock =$('#fap_comp_stock');
		var fap_comp_3years_avg_sales =$('#fap_comp_3years_avg_sales');
		var fap_comp_employee_num = $('#fap_comp_employee_num');
		//사진유무체크
		var photoSize = $("#fap_comp_log_file")[0].files;
		
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
			alert('<spring:message code="fap.err.comp_recent_sales" javaScriptEscape="true" />');
			$('#fap_comp_3years_avg_sales').focus();
			return false;
		}
		//정사원수
		if(fap_comp_employee_num.val() == 0){
			alert('<spring:message code="fap.err.emp_num_input" javaScriptEscape="true" />');
			$('#fap_comp_employee_num').focus();
			return false;
		}
	
		//기업 로고 사진
		if(photoSize.length == 0) {
			alert('<spring:message code="fap.err.photo_input" javaScriptEscape="true" />');
			$("#fap_comp_log_file").focus();
			return false;
		}
		_insert();
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
					//console.log(e);
				}
			});
		} else {
			$("#fap_comp_log_file").val('');
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
<body ng-app="myapp">
<%@include file="company_menu.jsp"%>
<form action="/fap/company/company_info_insert" method="post" enctype="multipart/form-data" id="company_info_insert">
<!-- 라디오 박스 선택전 입력란 종료 -->
<div class="join-wrap">
	<div id="subcontents">
		<div id="company_insert">
			<div class="joinBox">
				<div class="jointt">
					<p class="jointxt1">
				        <spring:message code="fap.common.insert_comp_info" />
					</p>
				</div>
				<div class="join-contents">
					<div class="joinBBS">
							<div class="joinBBS-row">
								<!-- 기업명 일문 -->
								<div class="joinlt point"><spring:message code="fap.comp.ja_nm" /><span class="red-point"></span></div>
								<div class="joinrt"><input type="text" id="fap_comp_ja_nm" name="fap_comp_ja_nm" class="input" maxlength="50" placeholder="50<spring:message code="fap.placeholder.limit_characters" />"></div>
							</div>
							<div class="joinBBS-row">
								<!-- 기업명 영문 -->
								<div class="joinlt point"><spring:message code="fap.comp.en_nm" /><span class="red-point"></span></div>
								<div class="joinrt"><input type="text" id="fap_comp_en_nm" name="fap_comp_en_nm" class="input" maxlength="50" placeholder="50<spring:message code="fap.placeholder.limit_characters" />"></div>
							</div>
							<div class="joinBBS-row">
								<!-- 사업자 등록번호 -->
								<div class="joinlt"><spring:message code="fap.comp.business_num" /></div>
								<div class="joinrt"><input type="text" id="fap_comp_business_num" name="fap_comp_business_num" class="input" maxlength="25" placeholder="<spring:message code="fap.placeholder.business_num" />"></div>
							</div>
							<div class="joinBBS-row">
								<!-- 대표자명 -->
									<div class="joinlt point"><spring:message code="fap.comp.rep" /><span class="red-point"></span></div>
									<div class="joinrt"><input type="text" id="fap_comp_rep" name="fap_comp_rep" class="input" maxlength="15"></div>
							</div>
							<div class="joinBBS-row">
								<!-- 주요산업분야 -->
								<div class="joinlt point"><spring:message code="fap.comp.major_bussiness" /><span class="red-point"></span></div>
								<div class="joinrt"><input type="text" id="fap_comp_major_bussiness" name="fap_comp_major_bussiness" class="input" maxlength="100" placeholder="100<spring:message code="fap.placeholder.limit_characters" />"></div>
							</div>
							<div class="joinBBS-row">	
								<!-- 홈페이지 -->
								<div class="joinlt"><spring:message code="fap.comp.homepage" /></div>
								<div class="joinrt"><input type="text" id="fap_comp_homepage" name="fap_comp_homepage" class="input" maxlength="75"></div>
							</div>
							<div class="joinBBS-row">
								<!-- 우편번호 -->
								<div class="joinlt point"><spring:message code="fap.comp.postcode" /><span class="red-point"></span></div>
								<div class="joinrt"><input type="text" id="fap_comp_postcode" name="fap_comp_postcode" class="input" placeholder="<spring:message code="fap.placholder.postcode" />" maxlength="10"></div>
							</div>
							<div class="joinBBS-row">
								<!-- 주소 -->
								<div class="joinlt point"><spring:message code="fap.comp.address" /><span class="red-point"></span></div>
								<div class="joinrt"><input type="text" id="fap_comp_address" name="fap_comp_address" class="input" maxlength="150"></div>
							</div>
							<div class="joinBBS-row">
								<!-- 상세주소 -->
								<div class="joinlt"><spring:message code="fap.comp.address_detail" /></div>
								<div class="joinrt"><input type="text" id="fap_comp_address_detail" name="fap_comp_address_detail" class="input" maxlength="150"></div>
							</div>
							<div class="joinBBS-row">	
								<!-- 설립일 -->
								<div class="joinlt point"><spring:message code="fap.comp.est_dt" /><span class="red-point"></span></div>
								<div class="joinrt"><input type="text" id="fap_comp_est_dt" name="fap_comp_est_dt" class="input" maxlength="25" placeholder="<spring:message code="fap.placeholder.est_dt" />"></div>
							</div>
							<div class="joinBBS-row">
								<!-- 자본금 -->
								<div class="joinlt point"><spring:message code="fap.comp.stock" /><span class="red-point"></span></div>
								<div class="joinrt"><input type="text" class="input currency" id="fap_comp_stock" name="fap_comp_stock" ng-model="fap_comp_stock_inst" blur-currency maxlength="22">
								<span class="hiddenTx">円</span>
								</div>
							</div>
							<div class="joinBBS-row">
								<!-- 최근 3년간 평균매출 -->
								<div class="joinlt point"><spring:message code="fap.comp.3years_avg_sales" /><span class="red-point"></span></div>
								<div class="joinrt"><input type="text" class="input currency" id="fap_comp_3years_avg_sales" name="fap_comp_3years_avg_sales" ng-model="fap_comp_3years_avg_sales_inst" blur-currency maxlength="22">
								<span class="hiddenTx">円</span>
								</div>
							</div>
							<div class="joinBBS-row">	
								<!-- 사원수 -->
								<div class="joinlt point"><spring:message code="fap.comp.employee_num" /><span class="red-point"></span></div>
								<div class="joinrt"><input type="text" id="fap_comp_employee_num" name="fap_comp_employee_num" class="input currency" maxlength="9" blur-currency ng-model="fap_comp_employee_num">
								<span class="hiddenTx">名</span>
								</div>
							</div>
							<div class="joinBBS-row">
								<!-- SC IT Master 사원수 -->
								<div class="joinlt nl"><spring:message code="fap.comp.scit_num" /></div>
								<div class="joinrt"><input type="text" id="fap_comp_scit_num" name="fap_comp_scit_num" class="input currency" maxlength="9" blur-currency ng-model="fap_comp_scit_num">
								<span class="hiddenTx">名</span>
								</div>
							</div>
							<div class="joinBBS-row">
								<!-- 한국인 사원수 -->
								<div class="joinlt"><spring:message code="fap.comp.korean_num" /></div>
								<div class="joinrt"><input type="text" id="fap_comp_korean_num" name="fap_comp_korean_num" class="input currency" maxlength="9" blur-currency ng-model="fap_comp_korean_num">
								<span class="hiddenTx">名</span>
								</div>
							</div>
							<div class="joinBBS-row">
								<!-- 기타 외국인 사원수 -->
								<div class="joinlt"><spring:message code="fap.comp.foreigner_num" /></div>
								<div class="joinrt"><input type="text" id="fap_comp_foreigner_num" name="fap_comp_foreigner_num" class="input currency" maxlength="9" blur-currency ng-model="fap_comp_foreigner_num"> 
								<span class="hiddenTx">名</span>
								</div>
							</div>
							<div class="joinBBS-row">
								<!-- 로고등록 -->
								<div class="joinlt point"><spring:message code="fap.comp.log_file" /><span class="red-point"></span></div>
								<div class="joinrt">
									<input type="file" id="fap_comp_log_file" name="fap_comp_log_file" class="input3" accept="image/*">
								</div>
							</div>
							<div class="joinBBS-row2">
								<div id="imgDiv"></div>
							</div>
							<div class="joinBBS-row2">
								<div><spring:message code="fap.comp.log_using" /></div>	
								<input type="radio" id="radio3" name="fap_comp_log_using" value="B3200" checked="checked">
								<label for="radio3">
									<span class="radio-span"></span>
									<b><code value="B3200"></code></b>
								</label> &nbsp;
								
								<input type="radio" id="radio4" name="fap_comp_log_using" value="B3201">
								<label for="radio4">
									<span class="radio-span"></span>
									<b><code value="B3201"></code></b>
								</label> &nbsp;
								
								<input type="radio" id="radio5" name="fap_comp_log_using" value="B3202">
								<label for="radio5">
									<span class="radio-span"></span>
									<b><code value="B3202"></code></b>
								</label>
						</div>
					</div>
					<div class="joinBox">
						<div id="joinBtn">
							<button type="button" class="join-btn icon submitBtn" onclick="checkOnSubmit();"><spring:message code="fap.common.join.btn" /></button>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
</form>

<%@include file="company_footer.jsp"%>
</body>
</html>
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
<script type="text/javascript">

	$(function() {
		
		cleanDatepicker();
		
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
				alert("이미지 파일이 아닙니다. gif, jpg, png 형식만 가능 합니다.");
				return;
			}
		});
		
		$('#fap_comp_est_dt').datepicker({
			dateFormat : 'yy/mm/dd'
			, changeMonth: true
			, changeYear: true
			, yearRange: "1900:"
		});
		
		//라디오버튼 초기값 설정
		$("input:radio[value='${company_info.fap_comp_log_using}']").prop("checked", true);
		
	});
	
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
					console.log(response);
				});
			}
			, template: "<span>{{filterParams}}</span>"
		}
	}]);
	
	function form_check() {

		var fap_comp_ja_nm = $('#fap_comp_ja_nm').val();
		var fap_comp_en_nm = $('#fap_comp_en_nm').val();
		var fap_comp_business_num = $('#fap_comp_business_num').val();
		var fap_comp_rep = $('#fap_comp_rep').val();
		var fap_comp_major_bussiness = $('#fap_comp_major_bussiness').val();
		var fap_comp_postcode = $('#fap_comp_postcode').val();
		var fap_comp_address = $('#fap_comp_address').val();
		var fap_comp_nationality = $('#fap_comp_nationality').val();
		var fap_comp_est_dt = $('#fap_comp_est_dt').val();
		var fap_comp_employee_num = $('#fap_comp_employee_num').val();
		var fap_comp_scit_num = $('#fap_comp_scit_num').val();
		var fap_comp_korean_num = $('#fap_comp_korean_num').val();
		var fap_comp_foreigner_num = $('#fap_comp_foreigner_num').val();

		if(fap_comp_ja_nm == ''){
			alert('회사 일어명을 입력해 주세요.');
			$('#fap_comp_ja_nm').focus();
			return false;
		}
		
		if(fap_comp_en_nm == ''){
			alert('회사 영문명을 입력해 주세요.');
			$('#fap_comp_en_nm').focus();
			return false;
		}
		
		if(fap_comp_business_num == ''){
			alert('사업자등록번호를 입력해 주세요.');
			$('#fap_comp_business_num').focus();
			return false;
		}
		
		if(fap_comp_rep == ''){
			alert('대표자명을 입력해 주세요.');
			$('#fap_comp_rep').focus();
			return false;
		}
		
		if(fap_comp_major_bussiness == ''){
			alert('주요사업분야를 입력해 주세요.');
			$('#fap_comp_major_bussiness').focus();
			return false;
		}
		
		if(fap_comp_postcode == ''){
			alert('회사우편번호를 입력해 주세요.');
			$('#fap_comp_postcode').focus();
			return false;
		}
		
		if(fap_comp_address == ''){
			alert('회사 상세주소를 입력해 주세요.');
			$('#fap_comp_address').focus();
			return false;
		}
		
		if(fap_comp_nationality == ''){
			alert('국적을 입력해 주세요.');
			$('#fap_comp_nationality').focus();
			return false;
		}
		
		if(fap_comp_est_dt == ''){
			alert('설립일을 입력해 주세요.');
			$('#fap_comp_est_dt').focus();
			return false;
		}
		
		if(fap_comp_employee_num == ''){
			alert('종업원수를 입력해 주세요.');
			$('#fap_comp_employee_num').focus();
			return false;
		}
		
		if(fap_comp_scit_num == ''){
			alert('SCIT Master 사원수를 입력해 주세요.');
			$('#fap_comp_scit_num').focus();
			return false;
		}
		
		if(fap_comp_korean_num == ''){
			alert('한국인 사원수를 입력해 주세요.');
			$('#fap_comp_korean_num').focus();
			return false;
		}
		
		if(fap_comp_foreigner_num == ''){
			alert('기타 외국인 사원수를 입력해 주세요.');
			$('#fap_comp_foreigner_num').focus();
			return false;
		}
		
		return true;
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
					$("#imgDiv").html('<img alt="" src="/edu/temporarilyPath/'+data.savedfile+'">');
				},
				error : function(e) {
					console.log(e);
				}
			});
		} else {
			$("#app_photo_file").val('');
			$("#imgDiv").empty();
			alert("파일 사이즈는 5MB 까지 입니다.");
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
 <%@include file="admin_menu.jsp"%>
	<br>
	<div class="page_title">
		<h2>회사 정보 수정</h2>
	</div>
	<br>

<form action="/fap/admin/company_info_update" method="post" onsubmit="return form_check();" enctype="multipart/form-data">

	<div id="company_insert">
		회사 일어명<input type="text" id="fap_comp_ja_nm" name="fap_comp_ja_nm" value="${company_info.fap_comp_ja_nm}"><br>
		회사 영문명<input type="text" id="fap_comp_en_nm" name="fap_comp_en_nm" value="${company_info.fap_comp_en_nm}"><br>
		사업자 등록번호<input type="text" id="fap_comp_business_num" name="fap_comp_business_num" value="${company_info.fap_comp_business_num}"><br>
		대표자명<input type="text" id="fap_comp_rep" name="fap_comp_rep" value="${company_info.fap_comp_rep}"><br>
		주요사업분여<input type="text" id="fap_comp_major_bussiness" name="fap_comp_major_bussiness" value="${company_info.fap_comp_major_bussiness}"><br>
		회사 홈페이지<input type="text" id="fap_comp_homepage" name="fap_comp_homepage" value="${company_info.fap_comp_homepage}"><br>
		회사우편번호<input type="text" id="fap_comp_postcode" name="fap_comp_postcode" value="${company_info.fap_comp_postcode}"><br>
		회사주소<input type="text" id="fap_comp_address" name="fap_comp_address" value="${company_info.fap_comp_address}"><br>
		회사상세주소<input type="text" id="fap_comp_address_detail" name="fap_comp_address_detail" value="${company_info.fap_comp_address_detail}"><br>
		국적<input type="text" id="fap_comp_nationality" name="fap_comp_nationality" value="${company_info.fap_comp_nationality}"><br>
		설립일<input type="text" id="fap_comp_est_dt" name="fap_comp_est_dt" value="${company_info.fap_comp_est_dt}" readonly="readonly"><br>
		자본금<input type="number" id="fap_comp_stock" name="fap_comp_stock" value="${company_info.fap_comp_stock}"><br>
		최근 3년간 평균매출<input type="number" id="fap_comp_3years_avg_sales" name="fap_comp_3years_avg_sales" value="${company_info.fap_comp_3years_avg_sales}"><br>
		종업원수<input type="number" id="fap_comp_employee_num" name="fap_comp_employee_num" value="${company_info.fap_comp_employee_num}"><br>
		SCIT Master 사원수<input type="number" id="fap_comp_scit_num" name="fap_comp_scit_num" value="${company_info.fap_comp_scit_num}"><br>
		한국인 사원수<input type="number" id="fap_comp_korean_num" name="fap_comp_korean_num" value="${company_info.fap_comp_korean_num}"><br>
		기타 외국인 사원수<input type="number" id="fap_comp_foreigner_num" name="fap_comp_foreigner_num" value="${company_info.fap_comp_foreigner_num}"><br>
		로고<input type="file" id="fap_comp_log_file" name="fap_comp_log_file"><br>
		<div id="imgDiv">
			<img alt="" src="/fap/company/user_logo_image/${company_info.fap_comp_log_saved}">
		</div>
		로고 사용여부<input type="radio" name="fap_comp_log_using" value="B3200" checked="checked"><code value="B3200"></code>
	    		 <input type="radio" name="fap_comp_log_using" value="B3201"><code value="B3201"></code>
	    		 <input type="radio" name="fap_comp_log_using" value="B3202"><code value="B3202"></code><br>
	</div>
	<input type="hidden" name="fap_comp_id" value="${company_info.fap_comp_id}">
	<input type="hidden" name="fap_comp_ins_id" value="${company_info.fap_comp_id}">
	
	<input type="submit" value="정보 수정">
</form>

</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet"
	href="<c:url value="/resources/segroup/css/jquery-ui.min.css" />">
<script src="<c:url value="/resources/segroup/js/jquery-3.1.1.js" />"></script>
<script src="<c:url value="/resources/segroup/js/jquery-ui.js" />"></script>
<script src="<c:url value="/resources/segroup/js/datepicker.js" />"></script>
<script src="<c:url value="/resources/segroup/js/angular.min.js" />"></script>
<script
	src="<c:url value="/resources/segroup/society/edu/js/jquery.bxslider.min.js" />"></script>
<script
	src="<c:url value="/resources/segroup/society/edu/js/slidebanner.js" />"></script>

<link
	href="<c:url value="/resources/segroup/society/edu/css/jquery.bxslider.css" />"
	rel="stylesheet" />
<link rel="stylesheet" type="text/css"
	href="<c:url value="/resources/segroup/society/edu/css/common.css" />">
<link rel="stylesheet" type="text/css"
	href="<c:url value="/resources/segroup/society/edu/css/sub.css" />">
<link rel="stylesheet" type="text/css"
	href="<c:url value="/resources/segroup/society/edu/css/main.css" />">

<link rel="stylesheet" type="text/css"
	href="<c:url value="/resources/segroup/society/edu/css/admin_menu.css" />">

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- 페이징 관련 css 끝 -->
<title>학생 정보 수정 폼</title>
<script type="text/javascript">
	$(function() {

		//DatePicker
		minMax("smp_crr_frm_0", "smp_crr_end_0");
		minMax("smp_study_frm_0", "smp_study_end_0");
		minMax("smp_overseas_frm_0", "smp_overseas_end_0");
		minMax("smp_kmove_frm", "smp_kmove_end");
		$("#smp_eduHIstory_dt_0").datepicker();
		$("#smp_lang_dt_0").datepicker();
		$("#smp_license_dt_0").datepicker();
		$("#smp_take_dt").datepicker();

		$(".smp_files").change(function() {
			var val = $(this).val();
			var size = $(this)[0].files[0].size;

			if (val == "") {
				$(this).val('');
				return;
			} else if (!filepdfCheck(val)) {
				$(this).val('');
				alert("지원하는 파일 형식이 아닙니다. gif, jpg, png, pdf 형식만 가능 합니다.");
				return;
			}

			if (!fileSizeCheck(size)) {
				$(this).val('');
				alert("파일 사이즈는 5MB 까지 입니다.");
				return;
			}
		});

	});
	var myApp = angular.module('myapp', []);

	myApp.controller('ApplyController', [ '$scope', '$compile', function($scope, $compile) {

		var eduJson = '${smpApplyJson}';
		var replaceJson = eduJson.replace(/(?:\r\n|\r|\n)/g, '<br />');

		$scope.smpApply = JSON.parse(replaceJson);

		$scope.file_change = function(file) {
			var val = $("#smp_photo_file").val();

			if (val == "") {
				$("#smp_photo_file").val('');
				$("#imgDiv").empty();
				return;
			} else if (fileImageCheck(val)) {
				photoAjax();
			} else {
				$("#smp_photo_file").val('');
				$("#imgDiv").empty();
				alert("이미지 파일이 아닙니다. gif, jpg, png 형식만 가능 합니다.");
				return;
			}
		}

		$scope.addEduHistory = function() {
			var eduHistoryClass = $(".eduHistory");
			var c_edu = $(".pop_1").clone();
			var smpIndex = eduHistoryClass.length;
			var smpDateId = "smp_eduHIstory_dt_" + smpIndex;

			var content = '<ul class="form_full_text edu_ul eduHistory">';
			content += '<li><input type="text" class="text-center" name="eduHistoryList[' + smpIndex + '].smp_edu_sc_nm" /></li>';
			content += '<li><input type="text" class="text-center" name="eduHistoryList[' + smpIndex + '].smp_edu_major" /></li>';
			content += '<li><select class="select_gradu" name="eduHistoryList[' + smpIndex + '].smp_edu_gd_ck">';
			content += '<option selectcode value="B1000" selected></option>';
			content += '<option selectcode value="B1001"></option>';
			content += '<option selectcode value="B1002"></option>';
			content += '</select></li>';
			content += '<li><input type="text" class="text-center" name="eduHistoryList[' + smpIndex + '].smp_edu_gd_dt" id="smp_eduHistory_dt_' + smpIndex + '" readonly="readonly" /></li>';
			content += '<li class="li_last"><input type="text" class="text-center" name="eduHistoryList[' + smpIndex + '].smp_edu_sc_lo" /></li>';
			content += '<div class="clear"></div>';
			content += '<ul class="require gradu_con"><li class="sub_title pop_1">';
			content += c_edu.html();
			content += '</ul>';

			$(".eduHistory:last").after($compile(content)($scope));
			$("#" + eduDateId).datepicker();

		}

		$scope.removeEduHistory = function() {
			var eduIndex = $(".eduHistory").length;
			if (eduIndex > 1) {
				$(".eduHistory:last").remove();
			}
		}

		$scope.addCareer = function() {
			var careerClass = $(".career");
			var crrIndex = careerClass.length;
			var crrFrmId = "smp_crr_frm_" + crrIndex;
			var crrEndId = "smp_crr_end_" + crrIndex;

			var content = '<ul class="form_full_text form_full_6 car_ul career">';
			content += '<li><input type="text" class="text-center" name="careerList[' + crrIndex + '].smp_crr_place" /></li>';
			content += '<li><input type="text" class="text-center" name="careerList[' + crrIndex + '].smp_crr_position" /></li>';
			content += '<li><input type="text" class="text-center" name="careerList[' + crrIndex + '].smp_crr_st" id="' + crrFrmId + '" readonly="readonly" /></li>';
			content += '<li><input type="text" class="text-center" name="careerList[' + crrIndex + '].smp_crr_et" id="' + crrEndId + '" readonly="readonly" /></li>';
			content += '<li><input type="text" class="text-center" name="careerList[' + crrIndex + '].smp_crr_dept" /></li>';
			content += '<li class="li_last"><input type="text" name="careerList[' + crrIndex + '].smp_crr_phone" class="text-center nullable" /></li>';
			content += '<div class="clear"></div>';
			content += '</ul>';

			$(".career:last").after(content);
			minMax(crrFrmId, crrEndId);

		}

		$scope.removeCareer = function() {
			var crrIndex = $(".career").length;
			if (crrIndex > 1) {
				$(".career:last").remove();
			}
		}

		$scope.addStudy = function() {
			var studyClass = $(".study");
			var studyIndex = studyClass.length;
			var studyFrmId = "smp_study_frm_" + studyIndex;
			var studyEndId = "smp_study_end_" + studyIndex;

			var content = '<ul class="form_full_text form_full_6 edu2_ul study">';
			content += '<li><input type="text" class="text-center" name="studyList[' + studyIndex + '].smp_study_nm" /></li>';
			content += '<li><input type="text" class="text-center" name="studyList[' + studyIndex + '].smp_study_st" id="' + studyFrmId + '"  readonly="readonly" /> </li>';
			content += '<li><input type="text" class="text-center" name="studyList[' + studyIndex + '].smp_study_et" id="' + studyEndId + '"  readonly="readonly" /></li>';
			content += '<li><input type="text" class="text-center" name="studyList[' + studyIndex + '].smp_study_ag" /></li>';
			content += '<li class="li_last"  style="width:33.3%;"><input type="text" class="text-center" name="studyList[' + studyIndex + '].smp_study_detail" /></li>';
			content += '<div class="clear"></div>';
			content += '</ul>';

			$(".study:last").after(content);
			minMax(studyFrmId, studyEndId);
		}

		$scope.removeStudy = function() {
			var studyIndex = $(".study").length;

			if (studyIndex > 1) {
				$(".study:last").remove();
			}
		}

		$scope.addLang = function() {
			var langClass = $(".language");
			var langIndex = langClass.length;
			var langDateId = "smp_lang_dt_" + langIndex;

			var content = '<ul class="form_full_text lang_ul language">';
			content += '<li><input type="text" class="text-center nullable" name="languageList[' + langIndex + '].smp_lang_nm" /></li>';
			content += '<li><input type="text" class="text-center" name="languageList[' + langIndex + '].smp_lang_test_nm" /></li>';
			content += '<li><input type="text" class="text-center" name="languageList[' + langIndex + '].smp_lang_grade" /></li>';
			content += '<li><input type="text" class="text-center nullable" name="languageList[' + langIndex + '].smp_lang_ag" /></li>';
			content += '<li class="li_last"><input type="text" class="text-center" name="languageList[' + langIndex + '].smp_lang_obtain_dt" id="' + langDateId + '" readonly="readonly" /></li>';
			content += '</ul>';

			$(".language:last").after(content);
			$("#" + langDateId).datepicker();
		}

		$scope.removeLang = function() {
			var langIndex = $(".language").length;
			if (langIndex > 1) {
				$(".language:last").remove();
			}
		}

		$scope.addLicense = function() {
			var licenseClass = $(".license");
			var licenseIndex = licenseClass.length;
			var licenseDateId = "smp_license_dt_" + licenseIndex;

			var content = '<ul class="form_full_text form_full_4 lic_ul license">';
			content += '<li><input type="text" class="text-center" name="licenseList[' + licenseIndex + '].smp_license_nm" /></li>';
			content += '<li><input type="text" class="text-center" name="licenseList[' + licenseIndex + '].smp_license_grade" /></li>';
			content += '<li><input type="text" name="licenseList[' + licenseIndex + '].smp_license_ag" class="text-center nullable" /></li>';
			content += '<li class="li_last"><input type="text" class="text-center" name="licenseList[' + licenseIndex + '].smp_license_obtain_dt" id="' + licenseDateId + '" readonly="readonly" /></li>';
			content += '</ul>';

			$(".license:last").after(content);
			$("#" + licenseDateId).datepicker();
		}

		$scope.removeLicense = function() {
			var licenseIndex = $(".license").length;

			if (licenseIndex > 1) {
				$(".license:last").remove();
			}
		}

		$scope.addOverseas = function() {
			var overseasClass = $(".overseas");
			var overseasIndex = overseasClass.length;
			var overseasFrmId = "smp_overseas_frm_" + overseasIndex;
			var overseasEndId = "smp_overseas_end_" + overseasIndex;
			var disabled = $(":input:radio[name=smp_abroad_ck]:checked").val();

			var content = '<ul class="form_full_text fore_ul overseas" >';
			if (disabled == 'B0800') {
				content += '<li style="width:25%;"><input type="text" class="li_inp text-center" name="overseasList[' + overseasIndex + '].smp_overseas_nm" /></li>';
				content += '<li style="width:25%;"><input type="text" class="li_inp text-center" name="overseasList[' + overseasIndex + '].smp_overseas_st" id="' + overseasFrmId + '"  readonly="readonly" /></li>';
				content += '<li style="width:25%;"><input type="text" class="li_inp text-center" name="overseasList[' + overseasIndex + '].smp_overseas_et" id="' + overseasEndId + '"  readonly="readonly" /></li>';
				content += '<li class="li_last" style="width:25%;"><input type="text" class="li_inp text-center" name="overseasList[' + overseasIndex + '].smp_overseas_purpose" /></li>';
			} else if (disabled == 'B0801') {
				content += '<li style="width:25%;"><input type="text" class="li_inp text-center disabled" name="overseasList[' + overseasIndex + '].smp_overseas_nm" /></li>';
				content += '<li style="width:25%;"><input type="text" class="li_inp text-center disabled" name="overseasList[' + overseasIndex + '].smp_overseas_st" id="' + overseasFrmId + '"  readonly="readonly" /></li>';
				content += '<li style="width:25%;"><input type="text" class="li_inp text-center disabled" name="overseasList[' + overseasIndex + '].smp_overseas_et" id="' + overseasEndId + '"  readonly="readonly" /></li>';
				content += '<li class="li_last" style="width:25%;"><input type="text" class="li_inp text-center disabled" name="overseasList[' + overseasIndex + '].smp_overseas_purpose" /></li>';
			}
			content += '</ul>';

			$(".overseas:last").after(content);
			minMax(overseasFrmId, overseasEndId);
		}

		$scope.removeOverseas = function() {
			var overseasIndex = $(".overseas").length;

			if (overseasIndex > 1) {
				$(".overseas:last").remove();
			}
		}

	} ]);

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

	myApp.filter('pre', function() {
		return function(str) {
			var regex = /<br\s*[\/]?>/gi;
			return str.replace(regex, "\n");
		}
	});

	function findAddr() {
		window.open("/popupTest", "pop", "width=570,height=420, scrollbars=yes, resizable=yes");
	}

	function update_submit() {
		var result = formCheck();
		if(result){
			var update_form = $("#smp_update_form").serialize();
			$.ajax({
				type : "POST",
				url : "/smp/student_update",
				data : update_form,
				success : function(data) {
					alert("수정이 완료되었습니다.");
					window.close();
				},
				error : function(e) {
					console.log(e);
				}
			});
		}
	}

	function formCheck() {
		var eduUi = $(".eduHistory");
		var crrUi = $(".career");
		var studyUi = $(".study");
		var langUi = $(".language");
		var licenseUi = $(".license");
		var overseasUi = $(".overseas");

		//군병력 체크
		var smp_mt_ck = $('input:radio[name="smp_mt_ck"]:checked').val();
		if (smp_mt_ck === undefined) {
			alert("군 병력을 체크 해 주세요.");
			return false;
		}

		//주소 체크
		var zipcode = $("#zipcode").val();
		if (zipcode.length == 0) {
			alert("주소를 입력 해 주세요.");
			return false;
		}

		//학력정보 체크
		var eduResult = true;

		$.each(eduUi, function() {
			$.each($(this).find("input"), function(index, item) {
				if (!$(this).hasClass("nullable")) {
					if (item.value.length == 0) {
						alert("학력사항은 필수 항목 입니다.");
						eduResult = false;
					}
					return eduResult;
				}
			})
		})

		if (eduResult) {
			//세부정보 체크
			if (inputCheck(crrUi) && inputCheck(studyUi) && inputCheck(langUi) && inputCheck(licenseUi) && inputCheck(overseasUi)) {

				//비상연락처
				var smp_em_phone = $("#smp_em_phone1").val() + $("#smp_em_phone2").val() + $("#smp_em_phone3").val();
				$('#smp_em_phone').val(smp_em_phone);

				// 수정할 것인지 확인.
				var check = confirm('수정 하시겠습니까? 정말 후회안하시겠습니까?');
				if (check == false) 
					return false;
				return true;
			} else {
				return false;
			}
		} else {
			return eduResult;
		}

	}

	function inputCheck(ul) {
		var result = true;

		$.each(ul, function() {
			$.each($(this).find("input"), function(index, item) {
				if (!$(this).hasClass("nullable")) {
					if (item.value.length != 0) {
						$.each(ul, function() {
							$.each($(this).find("input"), function(index2, item2) {
								if (!$(this).hasClass("nullable")) {
									if (item2.value.length == 0) {
										alert(ul.prev("ul").find("li").eq(index2).text() + "을(를) 입력해 주세요.");
										result = false;
									}
								}
								return result;
							});
							return result;
						});
					}
				}
			});
		});

		return result;
	}

	function photoAjax() {
		var size = $("#smp_photo_file")[0].files[0].size;
		if (fileSizeCheck(size)) {
			var formData = new FormData();
			formData.append("file", $("#smp_photo_file")[0].files[0]);

			$.ajax({
				type : "POST",
				url : "/temporarily_upload",
				data : formData,
				processData : false,
				contentType : false,
				dataType : "json",
				success : function(data) {
					$("#imgDiv").empty();
					$("#imgDiv").html('<img alt="" class="edu_photo_img" src="/temporarily_download?origin=' + data.originalfile + '&saved=' + data.savedfile + '">');
				},
				error : function(e) {
					console.log(e);
				}
			});
		} else {
			$("#smp_photo_file").val('');
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

	function filepdfCheck(name) {
		switch (name.substring(name.lastIndexOf('.') + 1).toLowerCase()) {
		case 'gif':
		case 'jpg':
		case 'png':
		case 'pdf':
			return true;
		default:
			return false;
		}
	}
</script>
</head>
<body ng-app="myapp" ng-controller="ApplyController">

	<form id="smp_update_form" enctype="multipart/form-data">
		<input type="hidden" name="gisu_seq" value="{{smpApply.gisu_seq }}" />
		<input type="hidden" name="app_id" value="${detail.user_id }" /> <input
			type="hidden" name="smp_seq" value="{{smpApply.smp_seq}}" /> <input
			type="hidden" name="smp_ins_id" value="${detail.user_id }" /> <input
			type="hidden" name="smp_udt_id" value="${detail.user_id }" />

		<div class="sub_m_contents">
			<div class="apply_form_wrap">
				<h1>SMART Cloud IT마스터 지원신청서</h1>

				<div class="form_wrap">
					<div class="form_line"></div>
					<div class="form_photo">
						<div ng-switch="!!smpApply.smp_photo_origin">
							<div ng-switch-when="true">
								<div class="form_photo_area" id="imgDiv">
									<input type="hidden" name="smp_photo_origin"
										value="{{smpApply.smp_photo_origin}}"> <input
										type="hidden" name="smp_photo_saved"
										value="{{smpApply.smp_photo_saved}}"> <img
										class="edu_photo_img" alt=""
										ng-src="/file_download?origin={{smpApply.smp_photo_origin}}&saved={{smpApply.smp_photo_saved}}&path=/edu/apply/photo/{{smpApply.smp_id}}_{{smpApply.gisu_seq}}">
									<div class="text-center">
										<a class="display-inline"
											ng-href="/file_download?origin={{smpApply.smp_photo_origin}}&saved={{smpApply.smp_photo_saved}}&path=/edu/apply/photo/{{smpApply.smp_id}}_{{smpApply.gisu_seq}}">{{smpApply.smp_photo_origin}}</a><img
											class="x_icon" ng-click="smpApply.smp_photo_origin=false"
											src="<c:url value="/resources/segroup/society/edu/image/sub/x_icon.png" />"
											alt="" />
									</div>
								</div>
							</div>
							<div ng-switch-default>
								<div class="form_photo_area" id="imgDiv"></div>
								<input type="hidden" name="smp_photo_saved"
									value="{{smpApply.smp_photo_saved}}"> <input
									type="file" name="smp_photo_file" id="smp_photo_file"
									onchange="angular.element(this).scope().file_change(this)"
									accept="image/*"><br />
							</div>
						</div>
					</div>

					<ul class="form_basic form_first">
						<li class="form_title"><span>성 명 <em>*</em></span></li>
						<li class="form_text"><input type="text" class="text-center"
							name="user_nm" value="${detail.user_nm }" readonly /></li>

					</ul>

					<ul class="form_basic">
						<c:set var="birth" value="${detail.user_birth }" />

						<li class="form_title"><span>생년월일 <em>*</em></span></li>
						<li class="form_text"><input type="text"
							class="in_ex_sm text-right" value="${fn:substring(birth,0,4) }"
							readonly>년 <input type="text" class="in_ex_sm text-right"
							value="${fn:substring(birth,5,7) }" readonly>월 <input
							type="text" class="in_ex_sm text-right"
							value="${fn:substring(birth,8,10) }" readonly>일</li>

					</ul>

					<ul class="form_basic">
						<li class="form_title"><span>군병력 <em>*</em></span></li>
						<li class="form_text"><input type="radio" name="smp_mt_ck"
							value="B0600" ng-model="smpApply.smp_mt_ck" /> <code
								value="B0600"></code> <input type="radio" name="smp_mt_ck"
							value="B0601" ng-model="smpApply.smp_mt_ck" /> <code
								value="B0601"></code> <input type="radio" name="smp_mt_ck"
							value="B0602" ng-model="smpApply.smp_mt_ck" /> <code
								value="B0602"></code>( 면제사유:<input type="text" class="in_small"
							name="smp_mt_etc" value="{{smpApply.smp_mt_etc}}">)</li>

					</ul>

					<ul class="form_basic form_large">
						<li class="form_title"><span>현 주소 <em>*</em></span></li>
						<li class="form_large_text">
							<ul>
								<li class="form_text border_bt"><b>(우편번호)</b><input
									type="text" class="in_mid" id="zipcode" name="smp_zipcode"
									readonly="readonly" value="{{smpApply.smp_zipcode }}" /><input
									type="button" class="in_small" id="btn" onclick="findAddr()"
									value="주소검색"></li>
								<li class="form_text border_bt"><input type="text"
									id="address" name="smp_address" readonly="readonly"
									value="{{smpApply.smp_address }}" /></li>
								<li class="form_text"><input type="text" id="addressDetail"
									name="smp_address_detail" readonly="readonly"
									value="{{smpApply.smp_address_detail }}" /></li>
							</ul>
						</li>
					</ul>

					<ul class="form_basic">
						<c:set var="phone" value="${detail.user_phone }" />

						<li class="form_title"><span>휴대전화 <em>*</em></span></li>
						<li class="form_text"><input type="text"
							class="in_small text-center" value="${fn:substring(phone,0,3) }"
							readonly> - <input type="text"
							class="in_small text-center" value="${fn:substring(phone,3,7) }"
							readonly> - <input type="text"
							class="in_small text-center" value="${fn:substring(phone,7,11) }"
							readonly></li>
					</ul>

					<ul class="form_basic">
						<c:set var="em_phone" value="${smpApply.smp_em_phone }" />

						<li class="form_title"><span>비상연락처</span></li>
						<li class="form_text"><input type="text"
							class="in_small text-center" id="smp_em_phone1"
							value="${fn:substring(em_phone,0,3) }"> - <input
							type="text" class="in_small text-center" id="smp_em_phone2"
							value="${fn:substring(em_phone,3,7) }"> - <input
							type="text" class="in_small text-center" id="smp_em_phone3"
							value="${fn:substring(em_phone,7,11) }"></li>
						<input type="hidden" name="smp_em_phone" id="smp_em_phone" />
					</ul>

					<ul class="form_basic">
						<li class="form_title"><span>이메일 <em>*</em></span></li>
						<li class="form_text"><input type="email" class="text-center"
							value="${detail.user_email }" readonly /></li>

					</ul>
					<div class="clear"></div>
					<div class="form_line"></div>

					<h2>
						<img class="form_arrow"
							src="<c:url value="/resources/segroup/society/edu/image/main/ico_black.png" />"
							alt="" /> <span>재학생 정보 <em>*</em></span>
					</h2>
					<ul class="form_full form_full_6">
						<li class="sub_title">K-MOVE 대상자</li>
						<li class="sub_title">반 정보</li>
						<li class="sub_title">재학생 지원 지역 구분</li>
						<li class="sub_title">재학생 CUP과정 대상자 구분</li>
						<li class="sub_title">거주지</li>
						<li class="sub_title">이전 기수 지원 여부</li>
					</ul>

					<ul class="form_full_text form_full_6 car_ul">
						<li><select class="select_gradu"
							name="smp_kmove_gb" ng-model="smpApply.smp_kmove_gb">
								<option selectcode value="B1800"></option>
								<option selectcode value="B1801"></option>
						</select></li>

						<li class="form_text"><input type="text" id="smp_class_info"
							name="smp_class_info" value="{{smpApply.smp_class_info}}" /></li>

						<li><select class="select_gradu"
							name="smp_app_lo_gb"
							ng-model="smpApply.smp_app_lo_gb">
								<option selectcode value="B2000"></option>
								<option selectcode value="B2001"></option>
						</select></li>

						<li><select class="select_gradu"
							name="smp_cup_gb" ng-model="smpApply.smp_cup_gb">
								<option selectcode value="B2100"></option>
								<option selectcode value="B2101"></option>
						</select></li>

						<li class="form_text"><input type="text" id="residence"
							name="smp_residence_info" value="{{smpApply.smp_residence }}" /></li>

						<li><select class="select_gradu"
							name="smp_applied_ck"
							ng-model="smpApply.smp_applied_ck">
								<option selectcode value="B2200"></option>
								<option selectcode value="B2201"></option>
						</select></li>

						<div class="clear"></div></ul>
						<div class="form_line"></div>

						<h2>
							<img class="form_arrow"
								src="<c:url value="/resources/segroup/society/edu/image/main/ico_black.png" />"
								alt="" /> <span>학력사항 <em>*</em></span><i><b><img
									class="edu_add" ng-click="addEduHistory()"
									src="<c:url value="/resources/segroup/society/edu/image/sub/plus_icon.png" />"
									alt="" /></b><b><img class="edu_del"
									ng-click="removeEduHistory()"
									src="<c:url value="/resources/segroup/society/edu/image/sub/minus_icon.png" />"
									alt="" /></b></i>
						</h2>
						<ul class="form_full edu_title">
							<li class="sub_title">학교명</li>
							<li class="sub_title">전공</li>
							<li class="sub_title">졸업상태(선택)</li>
							<li class="sub_title"><b>졸업</b>년월</li>
							<li class="sub_title li_last">소재지</li>
						</ul>

						<ul class="form_full_text edu_ul eduHistory"
							ng-repeat="eduHistory in smpApply.eduHistoryList">
							<li><input type="text" class="text-center"
								name="eduHistoryList[{{$index}}].smp_edu_sc_nm"
								value="{{eduHistory.smp_edu_sc_nm}}"></li>

							<li><input type="text" class="text-center"
								name="eduHistoryList[{{$index}}].smp_edu_major"
								value="{{eduHistory.smp_edu_major}}"></li>

							<li><select class="select_gradu"
								name="eduHistoryList[{{$index}}].smp_edu_gd_ck"
								ng-model="eduHistory.smp_edu_gd_ck">
									<option selectcode value="B1000"></option>
									<option selectcode value="B1001"></option>
									<option selectcode value="B1002"></option>
							</select></li>

							<li><input type="text" class="text-center"
								name="eduHistoryList[{{$index}}].smp_edu_gd_dt"
								id="smp_infoHistory_dt_{{$index}}" readonly="readonly"
								value="{{eduHistory.smp_edu_gd_dt}}" /></li>

							<li class="li_last"><input type="text" class="text-center"
								name="eduHistoryList[{{$index}}].smp_edu_sc_lo"
								value="{{eduHistory.smp_edu_sc_lo}}"></li>

							<div class="clear"></div>
							</ul>
							<ul class="require gradu_con"
								ng-class="{'display-block' : eduHistory.smp_edu_gd_ck=='B1001'}">
								<li class="sub_title pop_1">졸업요건 <img class="que_icon"
									src="<c:url value="/resources/segroup/society/edu/image/sub/question_icon.png" />"
									alt="" />
									<div class="form_popup">
										<img class="form_close"
											src="<c:url value="/resources/segroup/society/edu/image/sub/form_close.png" />"
											alt="" />
										<p>
											졸업예정자의 <i>"졸업요건"</i>은,<br> 현재 학적사항 및 연수기간 내 졸업가능 여부를
											확인하기 위함입니다.<br> 틀림이 없이 정확히 기재하기 바랍니다.<br> (모든 졸업요건을
											충족하고 졸업을 미룬 경우는 졸업상태에서 <i>"유예"</i>를 선택하세요.)<br> <br>
											<i>작성 예)</i><br> 1. 미 이수 학점이 있을 경우, 잔여학점 수와 이수계획에 대해 기재<br>
											잔여학점 00학점(온라인 강의수강으로 이수예정)<br> 잔여학점 00학점(자격증 취득 시 00학점
											취득가능)<br> 잔여학점 00학점(중간/기말고사 응시 및 레포트로 대체가능)<br> <br>
											2. 그 외 졸업기준을 미달성한 경우<br> 졸업기준 학점은 이수완료/ 공인어학성적(000점 이상)
											취득 시 졸업<br> 졸업기준 학점은 이수완료/ 논문 제출 시 졸업
										</p>

									</div>
								</li>
								<li class="require_add li_last" style="width: 60%;"><input
									type="text" class="text-center nullable"
									name="eduHistoryList[{{$index}}].smp_edu_gd_rq"
									value="{{eduHistory.smp_edu_gd_rq}}"></li>
							</ul>
						</ul>

						<h2>
							<img class="form_arrow"
								src="<c:url value="/resources/segroup/society/edu/image/main/ico_black.png" />"
								alt="" /><span>경력사항</span><i><b><img class="car_add"
									ng-click="addCareer()"
									src="<c:url value="/resources/segroup/society/edu/image/sub/plus_icon.png" />"
									alt="" /></b><b><img class="car_del" ng-click="removeCareer()"
									src="<c:url value="/resources/segroup/society/edu/image/sub/minus_icon.png" />"
									alt="" /></b></i>
						</h2>
						<ul class="form_full form_full_6">
							<li class="sub_title">근무처</li>
							<li class="sub_title">직위</li>
							<li class="sub_title">근무기간 시작일</li>
							<li class="sub_title">근무기간 종료일</li>
							<li class="sub_title">근무부서</li>
							<li class="sub_title li_last">회사전화번호</li>
						</ul>
						<div ng-switch="!!smpApply.careerList.length">
							<div ng-switch-when="true">
								<ul class="form_full_text form_full_6 car_ul career"
									ng-repeat="career in smpApply.careerList">
									<li><input type="text" class="text-center"
										name="careerList[{{$index}}].smp_crr_place"
										value="{{career.smp_crr_place}}"></li>
									<li><input type="text" class="text-center"
										name="careerList[{{$index}}].smp_crr_position"
										value="{{career.smp_crr_position}}"></li>
									<li><input type="text" class="text-center"
										name="careerList[{{$index}}].smp_crr_st"
										id="smp_crr_frm_{{$index}}" readonly="readonly"
										value="{{career.smp_crr_st}}"></li>
									<li><input type="text" class="text-center"
										name="careerList[{{$index}}].smp_crr_et"
										id="smp_crr_end_{{$index}}" readonly="readonly"
										value="{{career.smp_crr_et}}"></li>
									<li><input type="text" class="text-center"
										name="careerList[{{$index}}].smp_crr_dept"
										value="{{career.smp_crr_dept}}"></li>
									<li class="li_last"><input type="text"
										class="text-center nullable"
										name="careerList[{{$index}}].smp_crr_phone"
										value="{{career.smp_crr_phone}}"></li>
									<div class="clear"></div>
								</ul>
							</div>
							<div ng-switch-default>
								<ul class="form_full_text form_full_6 car_ul career">
									<li><input type="text" class="text-center"
										name="careerList[0].smp_crr_place"></li>

									<li><input type="text" class="text-center"
										name="careerList[0].smp_crr_position"></li>

									<li><input type="text" class="text-center"
										name="careerList[0].smp_crr_st" id="smp_crr_frm_0"
										readonly="readonly"></li>

									<li><input type="text" class="text-center"
										name="careerList[0].smp_crr_et" id="smp_crr_end_0"
										readonly="readonly"></li>

									<li><input type="text" class="text-center"
										name="careerList[0].smp_crr_dept"></li>
									<li class="li_last"><input type="text"
										class="text-center nullable"
										name="careerList[0].smp_crr_phone"></li>

									<div class="clear"></div>
								</ul>
							</div>
						</div>
						<h2>
							<img class="form_arrow"
								src="<c:url value="/resources/segroup/society/edu/image/main/ico_black.png" />"
								alt="" /><span>교육이수 경력</span><i><b><img
									class="edu2_add" ng-click="addStudy()"
									src="<c:url value="/resources/segroup/society/edu/image/sub/plus_icon.png" />"
									alt="" /></b><b><img class="edu2_del" ng-click="removeStudy()"
									src="<c:url value="/resources/segroup/society/edu/image/sub/minus_icon.png" />"
									alt="" /></b></i>
						</h2>
						<ul class="form_full form_full_6">
							<li class="sub_title">교육과정명</li>
							<li class="sub_title">교육기간시작일</li>
							<li class="sub_title">교육기간종료일</li>
							<li class="sub_title">기관명</li>
							<li class="sub_title li_last" style="width: 33.3%;">교육내용</li>
						</ul>
						<div ng-switch="!!smpApply.studyList.length">
							<div ng-switch-when="true">
								<ul class="form_full_text form_full_6 edu2_ul study"
									ng-repeat="study in smpApply.studyList">
									<li><input type="text" class="text-center"
										name="studyList[{{$index}}].smp_study_nm"
										value="{{study.smp_study_nm}}"></li>

									<li><input type="text" class="text-center"
										name="studyList[{{$index}}].smp_study_st"
										id="smp_study_frm_{{$index}}" readonly="readonly"
										value="{{study.smp_study_st}}"></li>

									<li><input type="text" class="text-center"
										name="studyList[{{$index}}].smp_study_et"
										id="smp_study_end_{{$index}}" readonly="readonly"
										value="{{study.smp_study_et}}"></li>

									<li><input type="text" class="text-center"
										name="studyList[{{$index}}].smp_study_ag"
										value="{{study.smp_study_ag}}"></li>

									<li class="li_last" style="width: 33.3%;"><input
										type="text" class="text-center"
										name="studyList[{{$index}}].smp_study_detail"
										value="{{study.smp_study_detail}}"></li>
									<div class="clear"></div>
								</ul>
							</div>
							<div ng-switch-default>
								<ul class="form_full_text form_full_6 edu2_ul study">
									<li><input type="text" class="text-center"
										name="studyList[0].smp_study_nm"></li>

									<li><input type="text" class="text-center"
										name="studyList[0].smp_study_st" id="smp_study_frm_0"
										readonly="readonly"></li>

									<li><input type="text" class="text-center"
										name="studyList[0].smp_study_et" id="smp_study_end_0"
										readonly="readonly"></li>

									<li><input type="text" class="text-center"
										name="studyList[0].smp_study_ag"></li>

									<li class="li_last" style="width: 33.3%;"><input
										type="text" class="text-center"
										name="studyList[0].smp_study_detail"></li>

									<div class="clear"></div>

								</ul>
							</div>
						</div>
						<h2>
							<img class="form_arrow"
								src="<c:url value="/resources/segroup/society/edu/image/main/ico_black.png" />"
								alt="" /><span>언어능력</span><i><b><img class="lang_add"
									ng-click="addLang()"
									src="<c:url value="/resources/segroup/society/edu/image/sub/plus_icon.png" />"
									alt="" /></b><b><img class="lang_del" ng-click="removeLang()"
									src="<c:url value="/resources/segroup/society/edu/image/sub/minus_icon.png" />"
									alt="" /></b></i>
						</h2>
						<ul class="form_full">
							<li class="sub_title">언어</li>
							<li class="sub_title">시험명</li>
							<li class="sub_title">점수/등급</li>
							<li class="sub_title">발급기관</li>
							<li class="sub_title li_last">취득일자</li>
						</ul>
						<div ng-switch="!!smpApply.languageList.length">
							<div ng-switch-when="true">
								<ul class="form_full_text lang_ul language"
									ng-repeat="language in smpApply.languageList">
									<li><input type="text" class="text-center nullable"
										name="languageList[{{$index}}].smp_lang_nm"
										value="{{language.smp_lang_nm}}"></li>
									<li><input type="text" class="text-center"
										name="languageList[{{$index}}].smp_lang_test_nm"
										value="{{language.smp_lang_test_nm}}"></li>
									<li><input type="text" class="text-center"
										name="languageList[{{$index}}].smp_lang_grade"
										value="{{language.smp_lang_grade}}"></li>
									<li><input type="text" class="text-center nullable"
										name="languageList[{{$index}}].smp_lang_ag"
										value="{{language.smp_lang_ag}}"></li>
									<li class="li_last"><input type="text" class="text-center"
										name="languageList[{{$index}}].smp_lang_obtain_dt"
										id="smp_lang_dt_{{$index}}" readonly="readonly"
										value="{{language.smp_lang_obtain_dt}}"></li>
								</ul>
							</div>
							<div ng-switch-default>
								<ul class="form_full_text lang_ul language">
									<li><input type="text" class="text-center nullable"
										name="languageList[0].smp_lang_nm"></li>

									<li><input type="text" class="text-center"
										name="languageList[0].smp_lang_test_nm"></li>

									<li><input type="text" class="text-center"
										name="languageList[0].smp_lang_grade"></li>

									<li><input type="text" class="text-center nullable"
										name="languageList[0].smp_lang_ag"></li>

									<li class="li_last"><input type="text" class="text-center"
										name="languageList[0].smp_lang_obtain_dt" id="smp_lang_dt_0"
										readonly="readonly"></li>
								</ul>
							</div>
						</div>
						<h2>
							<img class="form_arrow"
								src="<c:url value="/resources/segroup/society/edu/image/main/ico_black.png" />"
								alt="" /><span>자격증</span><i><b><img class="lic_add"
									ng-click="addLicense()"
									src="<c:url value="/resources/segroup/society/edu/image/sub/plus_icon.png" />"
									alt="" /></b><b><img class="lic_del"
									ng-click="removeLicense()"
									src="<c:url value="/resources/segroup/society/edu/image/sub/minus_icon.png" />"
									alt="" /></b></i>
						</h2>
						<ul class="form_full form_full_4">
							<li class="sub_title">자격증명</li>
							<li class="sub_title">등급</li>
							<li class="sub_title">발급기관</li>
							<li class="sub_title li_last">취득일자</li>
						</ul>
						<div ng-switch="!!smpApply.licenseList.length">
							<div ng-switch-when="true">
								<ul class="form_full_text form_full_4 lic_ul license"
									ng-repeat="license in smpApply.licenseList">
									<li><input type="text" class="text-center"
										name="licenseList[{{$index}}].smp_license_nm"
										value="{{license.smp_license_nm}}"></li>
									<li><input type="text" class="text-center"
										name="licenseList[{{$index}}].smp_license_grade"
										value="{{license.smp_license_grade}}"></li>
									<li><input type="text"
										name="licenseList[{{$index}}].smp_license_ag"
										class="text-center nullable"
										value="{{license.smp_license_ag}}"></li>
									<li class="li_last"><input type="text" class="text-center"
										name="licenseList[{{$index}}].smp_license_obtain_dt"
										id="smp_license_dt_{{$index}}" readonly="readonly"
										value="{{license.smp_license_obtain_dt}}"></li>
								</ul>
							</div>
							<div ng-switch-default>
								<ul class="form_full_text form_full_4 lic_ul license">
									<li><input type="text" class="text-center"
										name="licenseList[0].smp_license_nm"></li>

									<li><input type="text" class="text-center"
										name="licenseList[0].smp_license_grade"></li>

									<li><input type="text"
										name="licenseList[0].smp_license_ag"
										class="text-center nullable"></li>

									<li class="li_last"><input type="text" class="text-center"
										name="licenseList[0].smp_license_obtain_dt"
										id="smp_license_dt_0" readonly="readonly"></li>
								</ul>
							</div>
						</div>
						<h2>
							<img class="form_arrow"
								src="<c:url value="/resources/segroup/society/edu/image/main/ico_black.png" />"
								alt="" /><span>본 과정 응시 여부 <em>*</em></span>
						</h2>
						<ul class="form_full">
							<li class="sub_title" style="width: 40%;">본 과정을 응시한 적이</li>
							<li class="sub_title">지원년월</li>
							<li class="sub_title li_last" style="width: 40%;">선발전형 결과</li>
						</ul>
						<ul class="form_full_text">
							<li style="width: 40%;"><input type="radio"
								class="apply_check" name="smp_take_ck" value="B0700"
								ng-model="smpApply.smp_take_ck"> <code value="B0700"></code>
								<input class="apply_none" type="radio" name="smp_take_ck"
								value="B0701" ng-model="smpApply.smp_take_ck"> <code
									value="B0701"></code></li>
							<li><input type="text" name="smp_take_dt" id="smp_take_dt"
								readonly="readonly" class="apply_inp text-center"
								ng-class="{'disabled' : smpApply.smp_take_ck=='B0701'}"
								value="{{smpApply.smp_take_dt}}"></li>
							<li class="li_last" style="width: 40%;"><input type="text"
								class="apply_inp text-center" name="smp_take_rt"
								ng-class="{'disabled' : smpApply.smp_take_ck=='B0701'}"
								value="{{smpApply.smp_take_rt}}"></li>
						</ul>
						<h2>
							<img class="form_arrow"
								src="<c:url value="/resources/segroup/society/edu/image/main/ico_black.png" />"
								alt="" /><span>K-MOVE 스쿨 참여여부 <em>*</em></span>
						</h2>
						<ul class="form_full">
							<li class="sub_title" style="width: 40%;">한국산업인력공단의 해외취업
								연수과정에 참여한 적이</li>
							<li class="sub_title" style="width: 15%;">과정명</li>
							<li class="sub_title" style="width: 15%;">운영기관</li>
							<li class="sub_title" style="width: 15%;">수강기간 시작일</li>
							<li class="sub_title li_last" style="width: 15%;">수강기간 종료일</li>
						</ul>
						<ul class="form_full_text">
							<li style="width: 40%;"><input type="radio"
								class="k_move_check" name="smp_kmove_ck" value="B0900"
								ng-model="smpApply.smp_kmove_ck"> <code value="B0900"></code>
								<input class="k_move_none" type="radio" name="smp_kmove_ck"
								value="B0901" ng-model="smpApply.smp_kmove_ck"> <code
									value="B0901"></code></li>

							<li style="width: 15%;"><input type="text"
								class="k_move_inp text-center" name="smp_kmove_nm"
								ng-class="{'disabled' : smpApply.smp_kmove_ck=='B0901'}"
								value="{{smpApply.smp_kmove_nm}}"></li>

							<li style="width: 15%;"><input type="text"
								class="k_move_inp text-center" name="smp_kmove_ag"
								ng-class="{'disabled' : smpApply.smp_kmove_ck=='B0901'}"
								value="{{smpApply.smp_kmove_ag}}"></li>
							<li style="width: 15%;"><input type="text"
								name="smp_kmove_st" id="smp_kmove_frm" readonly="readonly"
								class="k_move_inp text-center"
								ng-class="{'disabled' : smpApply.smp_kmove_ck=='B0901'}"
								value="{{smpApply.smp_kmove_st}}"></li>
							<li class="li_last" style="width: 15%;"><input type="text"
								name="smp_kmove_et" id="smp_kmove_end" readonly="readonly"
								class="k_move_inp text-center"
								ng-class="{'disabled' : smpApply.smp_kmove_ck=='B0901'}"
								value="{{smpApply.smp_kmove_et}}"></li>
						</ul>
						<h2>
							<img class="form_arrow"
								src="<c:url value="/resources/segroup/society/edu/image/main/ico_black.png" />"
								alt="" /><span>해외체류 경험</span><i><b><img
									class="fore_add" ng-click="addOverseas()"
									src="<c:url value="/resources/segroup/society/edu/image/sub/plus_icon.png" />"
									alt="" /></b><b><img class="fore_del"
									ng-click="removeOverseas()"
									src="<c:url value="/resources/segroup/society/edu/image/sub/minus_icon.png" />"
									alt="" /></b></i>
						</h2>
						<ul class="form_full">
							<li class="sub_title" style="width: 50%;">본인은 과거 해외연수 경험이</li>
							<li class="li_last" style="width: 50%;"><input type="radio"
								class="li_check" name="smp_abroad_ck" value="B0800"
								ng-model="smpApply.smp_abroad_ck"> <code value="B0800"></code>
								<input type="radio" class="li_none" name="smp_abroad_ck"
								value="B0801" ng-model="smpApply.smp_abroad_ck"> <code
									value="B0801"></code></li>
						</ul>
						<ul class="form_full " style="border-top: 0;">
							<li class="sub_title" style="width: 25%;">국가명</li>
							<li class="sub_title" style="width: 25%;">체류기간 시작일</li>
							<li class="sub_title" style="width: 25%;">체류기간 종료일</li>
							<li class="sub_title li_last" style="width: 25%;">목적</li>
						</ul>
						<div ng-switch="!!smpApply.overseasList.length">
							<div ng-switch-when="true">
								<ul class="form_full_text fore_ul overseas"
									ng-repeat="overseas in smpApply.overseasList">
									<li style="width: 25%;"><input type="text"
										class="li_inp text-center"
										name="overseasList[{{$index}}].smp_overseas_nm"
										ng-class="{'disabled' : smpApply.smp_abroad_ck=='B0801'}"
										value="{{overseas.smp_overseas_nm}}"></li>
									<li style="width: 25%;"><input type="text"
										class="li_inp text-center"
										name="overseasList[{{$index}}].smp_overseas_st"
										id="smp_overseas_frm_{{$index}}" readonly="readonly"
										ng-class="{'disabled' : smpApply.smp_abroad_ck=='B0801'}"
										value="{{overseas.smp_overseas_st}}"></li>
									<li style="width: 25%;"><input type="text"
										class="li_inp text-center"
										name="overseasList[{{$index}}].smp_overseas_et"
										id="smp_overseas_end_{{$index}}" readonly="readonly"
										ng-class="{'disabled' : smpApply.smp_abroad_ck=='B0801'}"
										value="{{overseas.smp_overseas_et}}"></li>
									<li class="li_last" style="width: 25%;"><input type="text"
										class="li_inp text-center"
										name="overseasList[{{$index}}].smp_overseas_purpose"
										ng-class="{'disabled' : smpApply.smp_abroad_ck=='B0801'}"
										value="{{overseas.smp_overseas_purpose}}"></li>
								</ul>
							</div>
							<div ng-switch-default>
								<ul class="form_full_text fore_ul overseas">
									<li style="width: 25%;"><input type="text"
										class="li_inp text-center disabled"
										name="overseasList[0].smp_overseas_nm"></li>

									<li style="width: 25%;"><input type="text"
										class="li_inp text-center disabled"
										name="overseasList[0].smp_overseas_st" id="smp_overseas_frm_0"
										readonly="readonly"></li>
									<li style="width: 25%;"><input type="text"
										class="li_inp text-center disabled"
										name="overseasList[0].smp_overseas_et" id="smp_overseas_end_0"
										readonly="readonly"></li>

									<li class="li_last" style="width: 25%;"><input type="text"
										class="li_inp text-center disabled"
										name="overseasList[0].smp_overseas_purpose"></li>
								</ul>
							</div>
						</div>
						<!-- 해외체류 경험 -->
						<h2>
							<img class="form_arrow"
								src="<c:url value="/resources/segroup/society/edu/image/main/ico_black.png" />"
								alt="" /><span>기숙사 신청</span>
						</h2>
						<ul class="form_full">
							<li class="li_last" style="width: 100%;"><input type="radio"
								name="smp_domitory_ck" value="A0900"
								ng-model="smpApply.smp_domitory_ck" /> <code value="A0900"></code>
								<input type="radio" name="smp_domitory_ck" value="A0901"
								ng-model="smpApply.smp_domitory_ck" /> <code value="A0901"></code></li>
						</ul>
						<h2>
							<img class="form_arrow"
								src="<c:url value="/resources/segroup/society/edu/image/main/ico_black.png" />"
								alt="" /><span>자기소개 <em>*</em></span>
						</h2>
						<ul class="form_full">
							<li class="sub_title li_last" style="width: 100%;">지원동기,성장과정,성격,
								가치관 및 특이사항 등을 자유롭게 기술</li>
						</ul>
						<ul class="form_full_text">
							<li class="li_last" style="width: 100%; height: 240px;"><textarea
									name="smp_self_intro" id="selfIntro">${smp_self_intro}
				</textarea></li>
						</ul>
						<h2>
							<img class="form_arrow"
								src="<c:url value="/resources/segroup/society/edu/image/main/ico_black.png" />"
								alt="" /><span>증빙자료 업로드</span>
						</h2>

						<ul class="form_full">
							<li class="sub_title li_last pop_2" style="width: 100%;">최종
								학력증명서<i class="que"><img class="que_icon file_info"
									src="<c:url value="/resources/segroup/society/edu/image/sub/question_icon.png" />"
									alt="" /></i>
								<div class="form_popup file_pop">
									<img class="form_close"
										src="<c:url value="/resources/segroup/society/edu/image/sub/form_close.png" />"
										alt="" />
									<p>
										파일명 : 항목_이름 ex) 최종학력증명서_홍길동, 고용보험상실확인_홍길동<br> <br>
										1) 최종학력증명서(필수)<br> - 졸업증명서, 학위증명서, 졸업장, 졸업예정증명서(졸업예정일 기재)
										<br> - (졸예자, 유예자 중) 상기의 서류가 제출 불가능할 경우(수료증명서 포함) <br>
										: 학적상태를 증명할 수 있는 서류 제출(졸업요건, 달성상태기재, 학교 직인필수)<br> <br>
										2) 고용보험 상실내역 확인서(필수)<br> - 발급처: 고용보험(www.ei.go.kr) → 로그인
										→ 개인서비스<br> → 고용보험 가입(상용이력) 이력조회 <br> - 고용보험가입이력이 아예
										없는 경우에도 해당화면 캡처하여 제출<br> ※1. 본인의 이름과 주민번호 앞 6자리, “고용보험조회
										내역이 없습니다”라는 <br> 문구가 명확히 보이도록 캡쳐해주시기 바랍니다.<br> ※2.
										고용보험 상실신고가 지연되어 상실내역 확인서 제출이 어려운 경우 : <br> 퇴사일이 명기 된
										“퇴사증명서”를 제출 하고, 반드시 연수과정 개시 전까지 <br> 상실처리가 되어야 함(고용보험 상실일
										역시 연수과정 개시이전으로 신고) <br> <br> 3) 출입국 사실증명서(필수)<br>
										- 출입국 조회기간: 개강일 기준 1년 전 일자 ~ 현재까지<br> - 발급처: 민원
										24(www.minwon.go.kr) 로그인 → 출입국 기록 신청 <br> → 관련정보 입력 후
										민원신청하기<br> ※1. 출입국 내역이 없어 온라인 조회가 안 되는 경우<br> :
										동사무소에서 출입국 사실 증명원 발급<br> ※2. 조회기간 내 해외체류기간이 8개월 이상 되는 경우<br>
										: 방문국가를 확인할 수 있는 별도 증명서류 제출(여권 내 출입국 날인 사본 등)<br> <br>
										4) 기타(선택)<br> - 일본어 공인자격(JLPT 또는 JPT 등)<br> - 정보처리기사
										또는 산업기사 자격증 사본<br> - 개인의 경력/교육이수 내용을 확인할 수 있는 자료(포트폴리오 등)<br>
										- 그 외(IT관련 자격증 등)
									</p>

								</div>
							</li>
						</ul>

						<ul class="form_full_text"
							ng-switch="!!smpApply.smp_info_file_origin">
							<li class="li_last" style="width: 100%;" ng-switch-when="true">
								<input type="hidden" name="smp_info_file_origin"
								value="{{smpApply.smp_info_file_origin}}"> <input
								type="hidden" name="smp_info_file_saved"
								value="{{smpApply.smp_info_file_saved}}">
								<div class="text-center">
									<a class="display-inline"
										ng-href="/file_download?origin={{smpApply.smp_info_file_origin}}&saved={{smpApply.smp_info_file_saved}}&path=/edu/apply/edu_history/{{smpApply.smp_id}}_{{smpApply.gisu_seq}}">{{smpApply.smp_info_file_origin}}</a><img
										class="x_icon" ng-click="smpApply.smp_info_file_origin=false"
										src="<c:url value="/resources/segroup/society/edu/image/sub/x_icon.png" />"
										alt="" />
								</div>
							</li>
							<li class="li_last" style="width: 100%;" ng-switch-default><input
								type="hidden" name="smp_info_file_saved"
								value="{{smpApply.smp_info_file_saved}}"> <input
								type="file" class="smp_files" name="smp_info_file"
								accept="image/*, application/pdf"><br /></li>
						</ul>

						<ul class="form_full" style="border-top: 0;">
							<li class="sub_title li_last" style="width: 100%;">고용보험 상실확인</li>
						</ul>

						<ul class="form_full_text"
							ng-switch="!!smpApply.smp_isr_file_origin">
							<li class="li_last" style="width: 100%;" ng-switch-when="true">
								<input type="hidden" name="smp_isr_file_origin"
								value="{{smpApply.smp_isr_file_origin}}"> <input
								type="hidden" name="smp_isr_file_saved"
								value="{{smpApply.smp_isr_file_saved}}">
								<div class="text-center">
									<a class="display-inline"
										ng-href="/file_download?origin={{smpApply.smp_isr_file_origin}}&saved={{smpApply.smp_isr_file_saved}}&path=/edu/apply/insurance/{{smpApply.smp_id}}_{{smpApply.gisu_seq}}">{{smpApply.smp_isr_file_origin}}</a><img
										class="x_icon" ng-click="smpApply.smp_isr_file_origin=false"
										src="<c:url value="/resources/segroup/society/edu/image/sub/x_icon.png" />"
										alt="" />
								</div>
							</li>
							<li class="li_last" style="width: 100%;" ng-switch-default><input
								type="hidden" name="smp_isr_file_saved"
								value="{{smpApply.smp_isr_file_saved}}"> <input
								type="file" class="smp_files" name="smp_isr_file"
								accept="image/*, application/pdf"><br /></li>
						</ul>

						<ul class="form_full" style="border-top: 0;">
							<li class="sub_title li_last" style="width: 100%;">출입국 사실증명서</li>
						</ul>

						<ul class="form_full_text"
							ng-switch="!!smpApply.smp_imm_file_origin">
							<li class="li_last" style="width: 100%;" ng-switch-when="true">
								<input type="hidden" name="smp_imm_file_origin"
								value="{{smpApply.smp_imm_file_origin}}"> <input
								type="hidden" name="smp_imm_file_saved"
								value="{{smpApply.smp_imm_file_saved}}">
								<div class="text-center">
									<a class="display-inline"
										ng-href="/file_download?origin={{smpApply.smp_imm_file_origin}}&saved={{smpApply.smp_imm_file_saved}}&path=/edu/apply/immigration/{{smpApply.smp_id}}_{{smpApply.gisu_seq}}">{{smpApply.smp_imm_file_origin}}</a><img
										class="x_icon" ng-click="smpApply.smp_imm_file_origin=false"
										src="<c:url value="/resources/segroup/society/edu/image/sub/x_icon.png" />"
										alt="" />
								</div>
							</li>
							<li class="li_last" style="width: 100%;" ng-switch-default><input
								type="hidden" name="smp_imm_file_saved"
								value="{{smpApply.smp_imm_file_saved}}"> <input
								type="file" class="smp_files" name="smp_imm_file"
								accept="image/*, application/pdf"><br /></li>
						</ul>


						<div ng-repeat="i in [1,2,3]">
							<ul class="form_full" style="border-top: 0;">
								<li class="sub_title li_last" style="width: 100%;">기타 {{i}}</li>
							</ul>

							<ul class="form_full_text"
								ng-switch="!!smpApply.fileList[$index].smp_file_origin">
								<li class="li_last" style="width: 100%;" ng-switch-when="true">
									<input type="hidden"
									name="fileList[{{$index}}].smp_file_origin"
									value="{{smpApply.fileList[$index].smp_file_origin}}">
									<input type="hidden" name="fileList[{{$index}}].smp_file_saved"
									value="{{smpApply.fileList[$index].smp_file_saved}}">
									<div class="text-center">
										<a class="display-inline"
											ng-href="/file_download?origin={{smpApply.fileList[$index].smp_file_origin}}&saved={{smpApply.fileList[$index].smp_file_saved}}&path=/edu/apply/etc/{{smpApply.smp_id}}_{{smpApply.gisu_seq}}">{{smpApply.fileList[$index].smp_file_origin}}</a><img
											class="x_icon"
											ng-click="smpApply.fileList[$index].smp_file_origin=false"
											src="<c:url value="/resources/segroup/society/edu/image/sub/x_icon.png" />"
											alt="" />
									</div>
								</li>
								<li class="li_last" style="width: 100%;" ng-switch-default>
									<input type="hidden" name="fileList[{{$index}}].smp_file_saved"
									value="{{smpApply.fileList[$index].smp_file_saved}}"> <input
									type="file" class="smp_files"
									name="fileList[{{$index}}].smp_file"
									accept="image/*, application/pdf"><br />
								</li>
							</ul>
						</div>
						<p class="notice_choice">
							<em>*</em>는 필수항목 나머지는 선택
						</p>
				</div>
				<input type="button" onClick="update_submit();" class="apply_btn"
					value="수정하기">
			</div>
		</div>
	</form>
</body>
</html>
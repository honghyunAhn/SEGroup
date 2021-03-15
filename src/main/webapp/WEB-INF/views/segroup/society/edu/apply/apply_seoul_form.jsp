<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- Global site tag (gtag.js) - Google Analytics -->
<script async src="https://www.googletagmanager.com/gtag/js?id=UA-105593058-2"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());
  gtag('config', 'UA-105593058-2');
</script>
<link rel="stylesheet" href="<c:url value="/resources/segroup/css/jquery-ui.min.css" />">
<script src="<c:url value="/resources/segroup/js/jquery-3.1.1.js" />"></script>
<script src="<c:url value="/resources/segroup/js/jquery-ui.js" />"></script>
<script src="<c:url value="/resources/segroup/js/datepicker.js" />"></script>
<script src="<c:url value="/resources/segroup/js/angular.min.js" />"></script>
<script src="<c:url value="/resources/segroup/society/edu/js/jquery.bxslider.min.js" />"></script>
<script src="<c:url value="/resources/segroup/society/edu/js/slidebanner.js" />"></script>
<link href="<c:url value="/resources/segroup/society/edu/css/jquery.bxslider.css" />" rel="stylesheet" />
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/segroup/society/edu/css/common.css" />">
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/segroup/society/edu/css/sub.css" />">
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/segroup/society/edu/css/main.css" />">
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/segroup/society/edu/css/join.css" />">
<title>글로벌 엔지니어 양성</title>
<script type="text/javascript">
	$(function() {
		cleanDatepicker();
		//DatePicker
		minMax("app_crr_frm_0", "app_crr_end_0");
		minMax("app_study_frm_0", "app_study_end_0");
		minMax("app_overseas_frm_0", "app_overseas_end_0");
		minMax("app_kmove_frm", "app_kmove_end");
		$("#app_eduHIstory_dt_0").datepicker();
		$("#app_lang_dt_0").datepicker();
		$("#app_license_dt_0").datepicker();
		$("#app_take_dt").datepicker();

		$("#app_photo_file").change(function() {
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

		$(".app_files").change(function() {

			var val = $(this).val();

			if (val == "") {
				$(this).val('');
				return;
			} else if (!filepdfCheck(val)) {
				$(this).val('');
				alert("지원하는 파일 형식이 아닙니다. gif, jpg, png, pdf 형식만 가능 합니다.");
				return;
			}

			var size = $(this)[0].files[0].size;

			if (!fileSizeCheck(size)) {
				$(this).val('');
				alert("파일 사이즈는 5MB 까지 입니다.");
				return;
			}
		});

	});
	var myApp = angular.module('myapp', []);

	myApp
			.controller(
					'ApplyController',
					[
							'$scope',
							'$compile',
							function($scope, $compile) {
								$scope.addEduHistory = function() {
									var eduHistoryClass = $(".eduHistory");
									var c_edu = $(".pop_1").clone();
									var eduIndex = eduHistoryClass.length;
									var eduDateId = "app_eduHIstory_dt_" + eduIndex;

									var content = '<ul class="form_full_text edu_ul eduHistory">';
									content += '<li><input type="text" class="text-center" name="eduHistoryList['+eduIndex+'].app_edu_sc_nm" maxlength="60" /></li>';
									content += '<li><input type="text" class="text-center" name="eduHistoryList['+eduIndex+'].app_edu_major" maxlength="60" /></li>';
									content += '<li><select class="select_gradu" name="eduHistoryList['+eduIndex+'].app_edu_gd_ck">';
									content += '<option selectcode value="B1000" selected></option>';
									content += '<option selectcode value="B1001"></option>';
									content += '<option selectcode value="B1002"></option>';
									content += '</select></li>';
									content += '<li><input type="text" class="text-center" name="eduHistoryList['+eduIndex+'].app_edu_gd_dt" id="app_eduHIstory_dt_'+eduIndex+'" readonly="readonly" /></li>';
									content += '<li class="li_last"><input type="text" class="text-center" name="eduHistoryList['+eduIndex+'].app_edu_sc_lo" maxlength="30" /></li>';
									content += '<div class="clear"></div>';
									content += '<ul class="require gradu_con"><li class="sub_title pop_1">';
									content += c_edu.html();
									content += '</li><li class="require_add li_last" style="width:60%;"><input type="text" class="text-center nullable" name="eduHistoryList['+eduIndex+'].app_edu_gd_rq"></li>';
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
									var crrFrmId = "app_crr_frm_" + crrIndex;
									var crrEndId = "app_crr_end_" + crrIndex;

									var content = '<ul class="form_full_text form_full_6 car_ul career">';
									content += '<li><input type="text" class="text-center" name="careerList['+crrIndex+'].app_crr_place" maxlength="30" /></li>';
									content += '<li><input type="text" class="text-center" name="careerList['+crrIndex+'].app_crr_position" maxlength="10" /></li>';
									content += '<li><input type="text" class="text-center" name="careerList['+crrIndex+'].app_crr_st" id="'+crrFrmId+'" readonly="readonly" /></li>';
									content += '<li><input type="text" class="text-center" name="careerList['+crrIndex+'].app_crr_et" id="'+crrEndId+'" readonly="readonly" /></li>';
									content += '<li><input type="text" class="text-center" name="careerList['+crrIndex+'].app_crr_dept" maxlength="30" /></li>';
									content += '<li class="li_last"><input type="text" name="careerList['+crrIndex+'].app_crr_phone" class="text-center nullable" maxlength="13" /></li>';
									content += '<div class="clear"></div>	';
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
									var studyFrmId = "app_study_frm_" + studyIndex;
									var studyEndId = "app_study_end_" + studyIndex;

									var content = '<ul class="form_full_text form_full_6 edu2_ul study">';
									content += '<li><input type="text" class="text-center" name="studyList['+studyIndex+'].app_study_nm" maxlength="30" /></li>';
									content += '<li><input type="text" class="text-center" name="studyList['+studyIndex+'].app_study_st" id="'+studyFrmId+'"  readonly="readonly" /> </li>';
									content += '<li><input type="text" class="text-center" name="studyList['+studyIndex+'].app_study_et" id="'+studyEndId+'"  readonly="readonly" /></li>';
									content += '<li><input type="text" class="text-center" name="studyList['+studyIndex+'].app_study_ag" maxlength="30" /></li>';
									content += '<li class="li_last"  style="width:33.3%;"><input type="text" class="text-center" name="studyList['+studyIndex+'].app_study_detail" maxlength="100" /></li>';
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
									var langDateId = "app_lang_dt_" + langIndex;

									var content = '<ul class="form_full_text lang_ul language">';
									content += '<li><input type="text" class="text-center nullable" name="languageList['+langIndex+'].app_lang_nm" maxlength="10" /></li>';
									content += '<li><input type="text" class="text-center" name="languageList['+langIndex+'].app_lang_test_nm" maxlength="30" /></li>';
									content += '<li><input type="text" class="text-center" name="languageList['+langIndex+'].app_lang_grade" maxlength="10" /></li>';
									content += '<li><input type="text" class="text-center nullable" name="languageList['+langIndex+'].app_lang_ag" maxlength="30" /></li>';
									content += '<li class="li_last"><input type="text" class="text-center" name="languageList['+langIndex+'].app_lang_obtain_dt" id="'+langDateId+'" readonly="readonly" /></li>';
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
									var licenseDateId = "app_license_dt_" + licenseIndex;

									var content = '<ul class="form_full_text form_full_4 lic_ul license">';
									content += '<li><input type="text" class="text-center" name="licenseList['+licenseIndex+'].app_license_nm" maxlength="30" /></li>';
									content += '<li><input type="text" class="text-center" name="licenseList['+licenseIndex+'].app_license_grade" maxlength="10" /></li>';
									content += '<li><input type="text" name="licenseList['+licenseIndex+'].app_license_ag" class="text-center nullable" maxlength="30" /></li>';
									content += '<li class="li_last"><input type="text" class="text-center" name="licenseList['+licenseIndex+'].app_license_obtain_dt" id="'+licenseDateId+'" readonly="readonly" /></li>';
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
									var overseasFrmId = "app_overseas_frm_" + overseasIndex;
									var overseasEndId = "app_overseas_end_" + overseasIndex;
									var disabled = $(":input:radio[name=app_abroad_ck]:checked").val();

									var content = '<ul class="form_full_text fore_ul overseas" >';
									if (disabled == 'B0800') {
										content += '<li style="width:25%;"><input type="text" class="li_inp text-center" name="overseasList['+overseasIndex+'].app_overseas_nm" maxlength="30" /></li>';
										content += '<li style="width:25%;"><input type="text" class="li_inp text-center" name="overseasList['+overseasIndex+'].app_overseas_st" id="'+overseasFrmId+'"  readonly="readonly" /></li>';
										content += '<li style="width:25%;"><input type="text" class="li_inp text-center" name="overseasList['+overseasIndex+'].app_overseas_et" id="'+overseasEndId+'"  readonly="readonly" /></li>';
										content += '<li class="li_last" style="width:25%;"><input type="text" class="li_inp text-center" name="overseasList['+overseasIndex+'].app_overseas_purpose" maxlength="60" /></li>';
									} else if (disabled == 'B0801') {
										content += '<li style="width:25%;"><input type="text" class="li_inp text-center disabled" name="overseasList['+overseasIndex+'].app_overseas_nm" maxlength="30" /></li>';
										content += '<li style="width:25%;"><input type="text" class="li_inp text-center disabled" name="overseasList['+overseasIndex+'].app_overseas_st" id="'+overseasFrmId+'"  readonly="readonly" /></li>';
										content += '<li style="width:25%;"><input type="text" class="li_inp text-center disabled" name="overseasList['+overseasIndex+'].app_overseas_et" id="'+overseasEndId+'"  readonly="readonly" /></li>';
										content += '<li class="li_last" style="width:25%;"><input type="text" class="li_inp text-center disabled" name="overseasList['+overseasIndex+'].app_overseas_purpose" maxlength="60" /></li>';
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

	function findAddr() {
		window.open("/popupTest", "pop", "width=570,height=420, scrollbars=yes, resizable=yes");
	}

	function formCheck() {

		var eduUi = $(".eduHistory");
		var crrUi = $(".career");
		var studyUi = $(".study");
		var langUi = $(".language");
		var licenseUi = $(".license");
		var overseasUi = $(".overseas");

		//사진유무체크
		var photoSize = $("#app_photo_file")[0].files;

		if (photoSize.length == 0) {
			alert("사진을 등록해 주세요.")
			return false;
		}

		//군병력 체크
		var app_mt_ck = $('input:radio[name="app_mt_ck"]:checked').val();
		if (app_mt_ck === undefined) {
			alert("군 병력을 체크 해 주세요.");
			return false;
		} else if (app_mt_ck == "B0602") {
			var app_mt_etc = $("#app_mt_etc").val();
			if (app_mt_etc.length == 0) {
				alert("면제사유를 적어 주세요.");
				return false;
			}
		}

		//본 과정 응시 여부 체크
		var app_take_ck = $('input:radio[name="app_take_ck"]:checked').val();
		if (app_take_ck == "B0700") {
			var app_take_dt = $("#app_take_dt").val();
			var app_take_rt = $("#app_take_rt").val();

			if (app_take_dt.length == 0 || app_take_rt.length == 0) {
				alert("본 과정 응시 정보를 입력해 주세요.");
				return false;
			}
		}

		//K-MOVE 스쿨 참여어부 체크
		var app_kmove_ck = $('input:radio[name="app_kmove_ck"]:checked').val();
		if (app_kmove_ck == "B0900") {
			var app_kmove_nm = $("#app_kmove_nm").val();
			var app_kmove_ag = $("#app_kmove_ag").val();
			var app_kmove_frm = $("#app_kmove_frm").val();
			var app_kmove_end = $("#app_kmove_end").val();

			if (app_kmove_nm.length == 0 || app_kmove_ag.length == 0 || app_kmove_frm.length == 0 || app_kmove_end.length == 0) {
				alert("K-MOVE 스쿨 참여 정보를 입력해 주세요.");
				return false;
			}

		}

		//주소 체크
		var zipcode = $("#zipcode").val();
		if (zipcode.length == 0) {
			alert("주소를 입력 해 주세요.");
			return false;
		}

		//학력정보 체크
		var eduResult = true;

		var today = new Date();

		$.each(eduUi, function() {
			$.each($(this).find("input"), function(index, item) {
				if (!$(this).hasClass("nullable")) {
					if (index < 4 && item.value.length == 0) {
						alert("학력사항은 필수 항목 입니다.");
						eduResult = false;
					} else {
						if (index == 2) {
							if ($(this).closest("ul").find("select").val() == "B1000") {
								var grDate = new Date(item.value);
								if(today.getTime() < grDate.getTime()){
									alert('졸업년월이 잘못되었습니다');
									eduResult = false;
								}
								
							} else if ($(this).closest("ul").find("select").val() == "B1001" || $(this).closest("ul").find("select").val() == "B1002") {
								var grDate = new Date(item.value);
								if(today.getTime() >= grDate.getTime()){
									alert('졸업년월이 잘못되었습니다');
									eduResult = false;
								}
								
							}
						}
					}
					return eduResult;
				}
			})
		})

		if (eduResult) {
			//세부정보 체크
			if (inputCheck(crrUi) && inputCheck(studyUi) && inputCheck(langUi) && inputCheck(licenseUi) && inputCheck(overseasUi)) {

				var em_phone1 = $("#app_em_phone1").val();
				var em_phone2 = $("#app_em_phone2").val();
				var em_phone3 = $("#app_em_phone3").val();

				if (em_phone1.length != 0 || em_phone2.length != 0 || em_phone2.length != 0) {
					var phoneReg = /^\d{2,3}-\d{3,4}-\d{4}$/;
					var em_phone_ck = em_phone1 + "-" + em_phone2 + "-" + em_phone3;

					// 비상연락처 숫자만 입력체크
					if (!phoneReg.test(em_phone_ck)) {
						alert('비상연락처 번호를 양식에 맞게 입력해 주세요.');
						return false;
					}
				}

				//비상연락처
				var app_em_phone = $("#app_em_phone1").val() + $("#app_em_phone2").val() + $("#app_em_phone3").val();
				$('#app_em_phone').val(app_em_phone);

				var check = confirm("정말로 지원 하시겠습니까?");
				if (!check) {
					return false;
				}
				alert("지원 신청이 완료되었습니다.")
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

		var size = $("#app_photo_file")[0].files[0].size;
		if (fileSizeCheck(size)) {
			var formData = new FormData();
			formData.append("file", $("#app_photo_file")[0].files[0]);

			$.ajax({
				type : "POST",
				url : "/temporarily_upload",
				data : formData,
				processData : false,
				contentType : false,
				dataType : "json",
				success : function(data) {
					$("#imgDiv").empty();
					/* $("#imgDiv").html('<img class="edu_photo_img" alt="" src="/temporarily_download?origin=' + data.originalfile + '&saved=' + data.savedfile + '">'); */
					$("#imgDiv").html('<img class="edu_photo_img" alt="" src="/edu/temporarilyPath/'+data.savedfile+'">');
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
	<sec:authorize access="hasAnyRole('ROLE_A0100','ROLE_A0101','ROLE_A0105','ROLE_A0106')">
		<sec:authentication property="details.user" var="detail" />
	</sec:authorize>
	<%@include file="../menu.jsp"%>
	<form action="/edu/apply/apply_insert" method="post" onsubmit="return formCheck();" enctype="multipart/form-data">
		<input type="hidden" name="gisu_seq" value="${gisu_seq }" />
		<input type="hidden" name="app_id" value="${detail.user_id }" />
		<input type="hidden" name="app_ins_id" value="${detail.user_id }" />
		<input type="hidden" name="app_udt_id" value="${detail.user_id }" />
		<div class="sub_m_contents">
			<div class="apply_form_wrap">
				<h1 style="width: 430px;">SC IT 마스터 지원신청서</h1>
				<div style="float: right;">
					<span>지원기간 중에는 언제든 수정이 가능합니다</span>
				</div>
				<div style="overflow: hidden; width: 100%; height: 5px;"></div>
				<div class="form_wrap">
					<div class="form_line"></div>
					<div class="form_photo">
						<div class="form_photo_area" id="imgDiv"></div>
						<input type="file" id="app_photo_file" name="app_photo_file" accept="image/*">
					</div>
					<ul class="form_basic form_first">
						<li class="form_title">
							<span>
								성 명 <em>*</em>
							</span>
						</li>
						<li class="form_text">
							<input type="text" class="text-center" name="user_nm" value="${detail.user_nm }" readonly />
						</li>
					</ul>
					<ul class="form_basic">
						<c:set var="birth" value="${detail.user_birth }" />
						<li class="form_title">
							<span>
								생년월일 <em>*</em>
							</span>
						</li>
						<li class="form_text">
							<input type="text" class="in_ex_sm text-right" value="${fn:substring(birth,0,4) }" readonly>
							년
							<input type="text" class="in_ex_sm text-right" value="${fn:substring(birth,5,7) }" readonly>
							월
							<input type="text" class="in_ex_sm text-right" value="${fn:substring(birth,8,10) }" readonly>
							일
						</li>
					</ul>
					<ul class="form_basic">
						<li class="form_title">
							<span>
								군병력 <em>*</em>
							</span>
						</li>
						<li class="form_text">
							<input type="radio" name="app_mt_ck" value="B0600" ng-model="eduApply.app_mt_ck" />
							<code value="B0600"></code>
							<input type="radio" name="app_mt_ck" value="B0601" ng-model="eduApply.app_mt_ck" />
							<code value="B0601"></code>
							<input type="radio" name="app_mt_ck" value="B0603" ng-model="eduApply.app_mt_ck" />
							<code value="B0603"></code>
							<input type="radio" name="app_mt_ck" value="B0602" ng-model="eduApply.app_mt_ck" />
							<code value="B0602"></code>
							( 면제사유:
							<input type="text" class="in_small" name="app_mt_etc" id="app_mt_etc" ng-class="{'disabled' : eduApply.app_mt_ck!='B0602'}" maxlength="30" placeholder="30자 이내로 서술">
							)
						</li>
					</ul>
					<ul class="form_basic form_large">
						<li class="form_title">
							<span>
								현 주소 <em>*</em>
							</span>
						</li>
						<li class="form_large_text">
							<ul>
								<li class="form_text border_bt">
									<b>(우편번호)</b>
									<input type="text" class="in_mid" id="zipcode" name="app_zipcode" readonly="readonly" />
									<input type="button" class="in_small" id="btn" onclick="findAddr()" value="주소검색">
								</li>
								<li class="form_text border_bt">
									<input type="text" id="address" name="app_address" readonly="readonly" />
								</li>
								<li class="form_text">
									<input type="text" id="addressDetail" name="app_address_detail" readonly="readonly" />
								</li>
							</ul>
						</li>
					</ul>
					<ul class="form_basic">
						<c:set var="phone" value="${detail.user_phone }" />
						<li class="form_title">
							<span>
								휴대전화 <em>*</em>
							</span>
						</li>
						<li class="form_text">
							<input type="text" class="in_small text-center" value="${fn:substring(phone,0,3) }" readonly>
							-
							<input type="text" class="in_small text-center" value="${fn:substring(phone,3,7) }" readonly>
							-
							<input type="text" class="in_small text-center" value="${fn:substring(phone,7,11) }" readonly>
						</li>
					</ul>
					<ul class="form_basic">
						<li class="form_title">
							<span>비상연락처</span>
						</li>
						<li class="form_text">
							<input type="text" class="in_small text-center" id="app_em_phone1" maxlength="3">
							-
							<input type="text" class="in_small text-center" id="app_em_phone2" maxlength="4">
							-
							<input type="text" class="in_small text-center" id="app_em_phone3" maxlength="4">
						</li>
						<input type="hidden" name="app_em_phone" id="app_em_phone" />
					</ul>
					<ul class="form_basic">
						<li class="form_title">
							<span>
								이메일 <em>*</em>
							</span>
						</li>
						<li class="form_text">
							<input type="email" class="text-center" value="${detail.user_email }" readonly />
						</li>
					</ul>
					<div class="clear"></div>
					<div class="form_line"></div>
					<h2>
						<img class="form_arrow" src="<c:url value="/resources/segroup/society/edu/image/main/ico_black.png" />" alt="" />
						<span>
							학력사항 <em>*</em>
						</span>
						<i><b><img class="edu_add" ng-click="addEduHistory()" src="<c:url value="/resources/segroup/society/edu/image/sub/plus_icon.png" />" alt="" /></b><b><img class="edu_del" ng-click="removeEduHistory()" src="<c:url value="/resources/segroup/society/edu/image/sub/minus_icon.png" />" alt="" /></b></i>
					</h2>
					<ul class="form_full edu_title">
						<li class="sub_title">학교명</li>
						<li class="sub_title">전공</li>
						<li class="sub_title">졸업상태(선택)</li>
						<li class="sub_title">
							<b>졸업</b>년월
						</li>
						<li class="sub_title li_last margin_8">소재지</li>
					</ul>
					<ul class="form_full_text edu_ul eduHistory">
						<li>
							<input type="text" class="text-center" name="eduHistoryList[0].app_edu_sc_nm" maxlength="60">
						</li>
						<li>
							<input type="text" class="text-center" name="eduHistoryList[0].app_edu_major" maxlength="60">
						</li>
						<li>
							<select class="select_gradu" name="eduHistoryList[0].app_edu_gd_ck">
								<option selectcode value="B1000" selected></option>
								<option selectcode value="B1001"></option>
								<option selectcode value="B1002"></option>
							</select>
						</li>
						<li>
							<input type="text" class="text-center" name="eduHistoryList[0].app_edu_gd_dt" id="app_eduHIstory_dt_0" readonly="readonly" />
						</li>
						<li class="li_last">
							<input type="text" class="text-center" name="eduHistoryList[0].app_edu_sc_lo" maxlength="30">
						</li>
						<div class="clear"></div>
						<ul class="require gradu_con">
							<li class="sub_title pop_1">
								졸업요건
								<img class="que_icon" src="<c:url value="/resources/segroup/society/edu/image/sub/question_icon.png" />" alt="" />
								<div class="form_popup">
									<img class="form_close" src="<c:url value="/resources/segroup/society/edu/image/sub/form_close.png" />" alt="" />
									<p>
										졸업예정자의 <i>"졸업요건"</i>은,<br> 현재 학적사항 및 연수기간 내 졸업가능 여부를 확인하기 위함입니다.<br> 틀림이 없이 정확히 기재하기 바랍니다.<br> (모든 졸업요건을 충족하고 졸업을 미룬 경우는 졸업상태에서 <i>"유예"</i>를 선택하세요.)<br> <br> <i>작성 예)</i><br> 1. 미 이수 학점이 있을 경우, 잔여학점 수와 이수계획에 대해 기재<br> 잔여학점 00학점(온라인 강의수강으로 이수예정)<br> 잔여학점 00학점(자격증 취득 시 00학점 취득가능)<br> 잔여학점 00학점(중간/기말고사 응시 및 레포트로 대체가능)<br> <br> 2. 그 외 졸업기준을 미달성한 경우<br> 졸업기준 학점은 이수완료/ 공인어학성적(000점 이상) 취득 시 졸업<br> 졸업기준 학점은 이수완료/ 논문 제출 시 졸업
									</p>
								</div>
							</li>
							<li class="require_add li_last" style="width: 60%;">
								<input type="text" class="text-center nullable" name="eduHistoryList[0].app_edu_gd_rq">
							</li>
						</ul>
					</ul>
					<!-- 학력사항 -->
					<h2>
						<img class="form_arrow" src="<c:url value="/resources/segroup/society/edu/image/main/ico_black.png" />" alt="" />
						<span>경력사항</span>
						<i><b><img class="car_add" ng-click="addCareer()" src="<c:url value="/resources/segroup/society/edu/image/sub/plus_icon.png" />" alt="" /></b><b><img class="car_del" ng-click="removeCareer()" src="<c:url value="/resources/segroup/society/edu/image/sub/minus_icon.png" />" alt="" /></b></i>
					</h2>
					<ul class="form_full form_full_6">
						<li class="sub_title">근무처</li>
						<li class="sub_title">직위</li>
						<li class="sub_title">근무기간 시작일</li>
						<li class="sub_title">근무기간 종료일</li>
						<li class="sub_title">근무부서</li>
						<li class="sub_title li_last margin_8">회사전화번호</li>
					</ul>
					<ul class="form_full_text form_full_6 car_ul career">
						<li>
							<input type="text" class="text-center" name="careerList[0].app_crr_place" maxlength="30">
						</li>
						<li>
							<input type="text" class="text-center" name="careerList[0].app_crr_position" maxlength="10">
						</li>
						<li>
							<input type="text" class="text-center" name="careerList[0].app_crr_st" id="app_crr_frm_0" readonly="readonly">
						</li>
						<li>
							<input type="text" class="text-center" name="careerList[0].app_crr_et" id="app_crr_end_0" readonly="readonly">
						</li>
						<li>
							<input type="text" class="text-center" name="careerList[0].app_crr_dept" maxlength="30">
						</li>
						<li class="li_last">
							<input type="text" class="text-center nullable" name="careerList[0].app_crr_phone" maxlength="13">
						</li>
						<div class="clear"></div>
					</ul>
					<!-- 경력사항 -->
					<h2>
						<img class="form_arrow" src="<c:url value="/resources/segroup/society/edu/image/main/ico_black.png" />" alt="" />
						<span>교육이수 경력</span>
						<i><b><img class="edu2_add" ng-click="addStudy()" src="<c:url value="/resources/segroup/society/edu/image/sub/plus_icon.png" />" alt="" /></b><b><img class="edu2_del" ng-click="removeStudy()" src="<c:url value="/resources/segroup/society/edu/image/sub/minus_icon.png" />" alt="" /></b></i>
					</h2>
					<ul class="form_full form_full_6">
						<li class="sub_title">교육과정명</li>
						<li class="sub_title">교육기간시작일</li>
						<li class="sub_title">교육기간종료일</li>
						<li class="sub_title">기관명</li>
						<li class="sub_title li_last margin_8" style="width: 33.3%;">교육내용</li>
					</ul>
					<ul class="form_full_text form_full_6 edu2_ul study">
						<li>
							<input type="text" class="text-center" name="studyList[0].app_study_nm" maxlength="30">
						</li>
						<li>
							<input type="text" class="text-center" name="studyList[0].app_study_st" id="app_study_frm_0" readonly="readonly">
						</li>
						<li>
							<input type="text" class="text-center" name="studyList[0].app_study_et" id="app_study_end_0" readonly="readonly">
						</li>
						<li>
							<input type="text" class="text-center" name="studyList[0].app_study_ag" maxlength="30">
						</li>
						<li class="li_last" style="width: 33.3%;">
							<input type="text" class="text-center" name="studyList[0].app_study_detail" maxlength="100">
						</li>
						<div class="clear"></div>
					</ul>
					<!-- 교육이수 경력 -->
					<h2>
						<img class="form_arrow" src="<c:url value="/resources/segroup/society/edu/image/main/ico_black.png" />" alt="" />
						<span>언어능력</span>
						<i><b><img class="lang_add" ng-click="addLang()" src="<c:url value="/resources/segroup/society/edu/image/sub/plus_icon.png" />" alt="" /></b><b><img class="lang_del" ng-click="removeLang()" src="<c:url value="/resources/segroup/society/edu/image/sub/minus_icon.png" />" alt="" /></b></i>
					</h2>
					<ul class="form_full">
						<li class="sub_title">언어</li>
						<li class="sub_title">시험명</li>
						<li class="sub_title">점수/등급</li>
						<li class="sub_title">발급기관</li>
						<li class="sub_title li_last margin_8">취득일자</li>
					</ul>
					<ul class="form_full_text lang_ul language">
						<li>
							<input type="text" class="text-center nullable" name="languageList[0].app_lang_nm" maxlength="10">
						</li>
						<li>
							<input type="text" class="text-center" name="languageList[0].app_lang_test_nm" maxlength="30">
						</li>
						<li>
							<input type="text" class="text-center" name="languageList[0].app_lang_grade" maxlength="10">
						</li>
						<li>
							<input type="text" class="text-center nullable" name="languageList[0].app_lang_ag" maxlength="30">
						</li>
						<li class="li_last">
							<input type="text" class="text-center" name="languageList[0].app_lang_obtain_dt" id="app_lang_dt_0" readonly="readonly">
						</li>
					</ul>
					<!-- 언어능력 -->
					<h2>
						<img class="form_arrow" src="<c:url value="/resources/segroup/society/edu/image/main/ico_black.png" />" alt="" />
						<span>자격증</span>
						<i><b><img class="lic_add" ng-click="addLicense()" src="<c:url value="/resources/segroup/society/edu/image/sub/plus_icon.png" />" alt="" /></b><b><img class="lic_del" ng-click="removeLicense()" src="<c:url value="/resources/segroup/society/edu/image/sub/minus_icon.png" />" alt="" /></b></i>
					</h2>
					<ul class="form_full form_full_4">
						<li class="sub_title">자격증명</li>
						<li class="sub_title">등급</li>
						<li class="sub_title">발급기관</li>
						<li class="sub_title li_last margin_8">취득일자</li>
					</ul>
					<ul class="form_full_text form_full_4 lic_ul license">
						<li>
							<input type="text" class="text-center" name="licenseList[0].app_license_nm" maxlength="30">
						</li>
						<li>
							<input type="text" class="text-center" name="licenseList[0].app_license_grade" maxlength="10">
						</li>
						<li>
							<input type="text" name="licenseList[0].app_license_ag" class="text-center nullable" maxlength="30">
						</li>
						<li class="li_last">
							<input type="text" class="text-center" name="licenseList[0].app_license_obtain_dt" id="app_license_dt_0" readonly="readonly">
						</li>
					</ul>
					<!-- 자격증 -->
					<h2>
						<img class="form_arrow" src="<c:url value="/resources/segroup/society/edu/image/main/ico_black.png" />" alt="" />
						<span>
							본 과정 응시 여부(SC IT마스터과정 포함) <em>*</em>
						</span>
					</h2>
					<ul class="form_full">
						<li class="sub_title" style="width: 40%;">본 과정을 응시한 적이</li>
						<li class="sub_title">지원년월</li>
						<li class="sub_title li_last" style="width: 40%;">선발전형 결과</li>
					</ul>
					<ul class="form_full_text">
						<li style="width: 40%;">
							<input type="radio" class="apply_check" name="app_take_ck" value="B0700">
							<code value="B0700"></code>
							<input class="apply_none" type="radio" name="app_take_ck" value="B0701" checked="checked">
							<code value="B0701"></code>
						</li>
						<li>
							<input type="text" name="app_take_dt" id="app_take_dt" readonly="readonly" class="apply_inp text-center" disabled="disabled">
						</li>
						<li class="li_last" style="width: 40%;">
							<input type="text" class="apply_inp text-center" name="app_take_rt" disabled="disabled" maxlength="10">
						</li>
					</ul>
					<!-- 본 과정 응시 여부 -->
					<h2>
						<img class="form_arrow" src="<c:url value="/resources/segroup/society/edu/image/main/ico_black.png" />" alt="" />
						<span>
							K-MOVE 스쿨 참여여부 <em>*</em>
						</span>
					</h2>
					<ul class="form_full">
						<li class="sub_title" style="width: 40%;">한국산업인력공단의 해외취업 연수과정에 참여한 적이</li>
						<li class="sub_title" style="width: 15%;">과정명</li>
						<li class="sub_title" style="width: 15%;">운영기관</li>
						<li class="sub_title" style="width: 15%;">수강기간 시작일</li>
						<li class="sub_title li_last" style="width: 15%;">수강기간 종료일</li>
					</ul>
					<ul class="form_full_text">
						<li style="width: 40%;">
							<input type="radio" class="k_move_check" name="app_kmove_ck" value="B0900">
							<code value="B0900"></code>
							<input class="k_move_none" type="radio" name="app_kmove_ck" value="B0901" checked="checked">
							<code value="B0901"></code>
						</li>
						<li style="width: 15%;">
							<input type="text" class="k_move_inp text-center" name="app_kmove_nm" disabled="disabled" maxlength="15">
						</li>
						<li style="width: 15%;">
							<input type="text" class="k_move_inp text-center" name="app_kmove_ag" disabled="disabled" maxlength="15">
						</li>
						<li style="width: 15%;">
							<input type="text" name="app_kmove_st" id="app_kmove_frm" readonly="readonly" class="k_move_inp text-center" disabled="disabled">
						</li>
						<li class="li_last" style="width: 15%;">
							<input type="text" name="app_kmove_et" id="app_kmove_end" readonly="readonly" class="k_move_inp text-center" disabled="disabled">
						</li>
					</ul>
					<!-- K-MOVE 스쿨 참여여부 -->
					<h2>
						<img class="form_arrow" src="<c:url value="/resources/segroup/society/edu/image/main/ico_black.png" />" alt="" />
						<span>해외체류 경험</span>
						<i><b><img class="fore_add" ng-click="addOverseas()" src="<c:url value="/resources/segroup/society/edu/image/sub/plus_icon.png" />" alt="" /></b><b><img class="fore_del" ng-click="removeOverseas()" src="<c:url value="/resources/segroup/society/edu/image/sub/minus_icon.png" />" alt="" /></b></i>
					</h2>
					<ul class="form_full">
						<li class="sub_title" style="width: 50%;">본인은 과거 해외연수 경험이</li>
						<li class="li_last margin_8" style="width: 50%;">
							<input type="radio" class="li_check" name="app_abroad_ck" value="B0800">
							<code value="B0800"></code>
							<input type="radio" class="li_none" name="app_abroad_ck" value="B0801" checked="checked">
							<code value="B0801"></code>
						</li>
					</ul>
					<ul class="form_full " style="border-top: 0;">
						<li class="sub_title" style="width: 25%;">국가명</li>
						<li class="sub_title" style="width: 25%;">체류기간 시작일</li>
						<li class="sub_title" style="width: 25%;">체류기간 종료일</li>
						<li class="sub_title li_last" style="width: 25%;">목적</li>
					</ul>
					<ul class="form_full_text fore_ul overseas">
						<li style="width: 25%;">
							<input type="text" class="li_inp text-center disabled" name="overseasList[0].app_overseas_nm" maxlength="30">
						</li>
						<li style="width: 25%;">
							<input type="text" class="li_inp text-center disabled" name="overseasList[0].app_overseas_st" id="app_overseas_frm_0" readonly="readonly">
						</li>
						<li style="width: 25%;">
							<input type="text" class="li_inp text-center disabled" name="overseasList[0].app_overseas_et" id="app_overseas_end_0" readonly="readonly">
						</li>
						<li class="li_last" style="width: 25%;">
							<input type="text" class="li_inp text-center disabled" name="overseasList[0].app_overseas_purpose" maxlength="60">
						</li>
					</ul>
					<!-- 해외체류 경험 -->
					<!-- 					<h2> -->
					<!-- 						<img class="form_arrow" -->
					<%-- 							src="<c:url value="/resources/segroup/society/edu/image/main/ico_black.png" />" --%>
					<!-- 							alt="" /><span>기숙사 신청</span> -->
					<!-- 					</h2> -->
					<!-- 					<ul class="form_full"> -->
					<!-- 						<li class="li_last" style="width: 100%;"> -->
					<%-- 					        <input type="radio" name="app_domitory_ck" value="A0900"  /><code value="A0900"></code> --%>
					<%-- 					        <input type="radio" name="app_domitory_ck" value="A0901"  checked="checked" /><code value="A0901"></code> --%>
					<!-- 						</li> -->
					<!-- 					</ul> -->
					<!--                     기숙사 신청 -->
					<h2>
						<img class="form_arrow" src="<c:url value="/resources/segroup/society/edu/image/main/ico_black.png" />" alt="" />
						<span>
							자기소개 <em>*</em>
						</span>
					</h2>
					<ul class="form_full">
						<li class="sub_title li_last" style="width: 100%;">지원동기, 성장과정, 성격, 가치관 및 특이사항 등을 자유롭게 기술</li>
					</ul>
					<ul class="form_full_text">
						<li class="li_last" style="width: 100%; height: 240px;">
							<textarea name="app_self_intro" id="selfIntro">

1.해외취업 지원동기에 대해 작성하세요.(100자 이상)

2.과정에 입학하게 된다면 어떤 계획과 목표를 설정할 것인가요?(100자 이상)

3.이외에 하고싶은 말이 있다면 작성해주세요.

</textarea>
						</li>
					</ul>
					<!-- 자기소개 -->
					<h2>
						<img class="form_arrow" src="<c:url value="/resources/segroup/society/edu/image/main/ico_black.png" />" alt="" />
						<span>증빙자료 업로드</span>
					</h2>
					<ul class="form_full">
						<li class="sub_title li_last pop_2" style="width: 100%;">
							최종 학력증명서<i class="que"><img class="que_icon file_info" src="<c:url value="/resources/segroup/society/edu/image/sub/question_icon.png" />" alt="" /></i>
							<div class="form_popup file_pop">
								<img class="form_close" src="<c:url value="/resources/segroup/society/edu/image/sub/form_close.png" />" alt="" />
								<p>
									파일명 : 항목_이름 ex) 최종학력증명서_홍길동, 고용보험상실확인_홍길동<br>
									<br> 1) 최종학력증명서(필수)<br> - 졸업증명서, 학위증명서, 졸업장, 졸업예정증명서(졸업예정일 기재) <br> - (졸예자, 유예자 중) 상기의 서류가 제출 불가능할 경우(수료증명서 포함) <br> : 학적상태를 증명할 수 있는 서류 제출(졸업요건, 달성상태기재, 학교 직인필수)<br>
									<br> 2) 고용보험 상실내역 확인서(필수)<br> - 발급처: 고용보험(www.ei.go.kr) → 로그인 → 개인서비스<br> → 고용보험 가입(상용이력) 이력조회 <br> - 고용보험가입이력이 아예 없는 경우에도 해당화면 캡처하여 제출<br> ※1. 본인의 이름과 주민번호 앞 6자리, “고용보험조회 내역이 없습니다”라는 <br> 문구가 명확히 보이도록 캡쳐해주시기 바랍니다.<br> ※2. 고용보험 상실신고가 지연되어 상실내역 확인서 제출이 어려운 경우 : <br> 퇴사일이 명기 된 “퇴사증명서”를 제출 하고, 반드시 연수과정 개시 전까지 <br> 상실처리가 되어야 함(고용보험 상실일 역시 연수과정 개시이전으로 신고) <br>
									<br> 3) 출입국 사실증명서(필수)<br> - 출입국 조회기간: 개강일 기준 1년 전 일자 ~ 현재까지<br> - 발급처: 민원 24(www.minwon.go.kr) 로그인 → 출입국 기록 신청 <br> → 관련정보 입력 후 민원신청하기<br> ※1. 출입국 내역이 없어 온라인 조회가 안 되는 경우<br> : 동사무소에서 출입국 사실 증명원 발급<br> ※2. 조회기간 내 해외체류기간이 8개월 이상 되는 경우<br> : 방문국가를 확인할 수 있는 별도 증명서류 제출(여권 내 출입국 날인 사본 등)<br>
									<br> 4) 워크넷 직무평가 결과(필수)<br> - 발급처: 워크넷(www.work.go.kr) → 로그인 →직업심리검사(성인)<br> → IT직무 기본역량검사를 실시 → 결과조회 → 파일로 저장후 첨부<br> - zip파일로 압축하여 첨부해주시기 바랍니다.<br>
									<br> 5) 기타(선택)<br> - 일본어 공인자격(JLPT 또는 JPT 등)<br> - 정보처리기사 또는 산업기사 자격증 사본<br> - 개인의 경력/교육이수 내용을 확인할 수 있는 자료(포트폴리오 등)<br> - 그 외(IT관련 자격증 등)
								</p>
							</div>
						</li>
					</ul>
					<ul class="form_full_text">
						<li class="li_last" style="width: 100%;">
							<input type="file" class="app_files" name="app_edu_file" accept="image/*, application/pdf">
						</li>
					</ul>
					<ul class="form_full" style="border-top: 0;">
						<li class="sub_title li_last" style="width: 100%;">고용보험 상실확인</li>
					</ul>
					<ul class="form_full_text">
						<li class="li_last" style="width: 100%;">
							<input type="file" class="app_files" name="app_edu_file" accept="image/*, application/pdf">
						</li>
					</ul>
					<ul class="form_full" style="border-top: 0;">
						<li class="sub_title li_last" style="width: 100%;">출입국 사실증명서</li>
					</ul>
					<ul class="form_full_text">
						<li class="li_last" style="width: 100%;">
							<input type="file" class="app_files" name="app_imm_file" accept="image/*, application/pdf">
						</li>
					</ul>
					<ul class="form_full" style="border-top: 0;">
						<li class="sub_title li_last" style="width: 100%;">워크넷 직무평가 결과</li>
					</ul>
					<ul class="form_full_text">
						<li class="li_last" style="width: 100%;">
							<input type="file" class="app_files" name="app_worknet_file" accept="image/*, application/pdf">
						</li>
					</ul>
					<ul class="form_full" style="border-top: 0;">
						<li class="sub_title li_last" style="width: 100%;">기타 (1)</li>
					</ul>
					<ul class="form_full_text">
						<li class="li_last" style="width: 100%;">
							<input type="file" class="app_files" name="fileList[0].app_file" accept="image/*, application/pdf">
						</li>
					</ul>
					<ul class="form_full" style="border-top: 0;">
						<li class="sub_title li_last" style="width: 100%;">기타 (2)</li>
					</ul>
					<ul class="form_full_text">
						<li class="li_last" style="width: 100%;">
							<input type="file" class="app_files" name="fileList[1].app_file" accept="image/*, application/pdf">
						</li>
					</ul>
					<ul class="form_full" style="border-top: 0;">
						<li class="sub_title li_last" style="width: 100%;">기타 (3)</li>
					</ul>
					<ul class="form_full_text">
						<li class="li_last" style="width: 100%;">
							<input type="file" class="app_files" name="fileList[2].app_file" accept="image/*, application/pdf">
						</li>
					</ul>
					<p class="notice_choice">
						<em>*</em>는 필수항목 나머지는 선택
					</p>
				</div>
				<input type="submit" class="apply_btn" value="지원하기">
			</div>
		</div>
	</form>
	<%@include file="../footer.jsp"%>
</body>
</html>
// resumeForm.js
$(function () {
    // DatePicker 세팅
    cleanDatepicker();

    minMax("stu_app_crr_frm_0", "stu_app_crr_end_0");
    minMax("stu_app_study_frm_0", "stu_app_study_end_0");
    minMax("stu_app_kmove_frm", "stu_app_kmove_end");
    minMax("stu_app_overseas_frm_0", "stu_app_overseas_end_0");
    $("#stu_app_eduHistory_dt_0").datepicker();
    $("#stu_app_lang_dt_0").datepicker();
    $("#stu_app_license_dt_0").datepicker();
    $("#stu_app_ses_dt_0").datepicker();

    // 등록 이미지 등록 미리보기
    function readInputFile(input) {
        if (input.files && input.files[0]) {
            var reader = new FileReader();
            reader.onload = function (e) {
                $('.imgHere').html("<img src=" + e.target.result + ">");
            }
            reader.readAsDataURL(input.files[0]);
        }
    }

    $(".addImg").on('change', function () {
        readInputFile(this);
    });

    // 등록 이미지 삭제 ( input file reset )
    function resetInputFile($input, $preview) {
        var agent = navigator.userAgent.toLowerCase();
        if ((navigator.appName == 'Netscape' && navigator.userAgent.search('Trident') != -1) || (agent.indexOf("msie") != -1)) {
            // ie 일때
            $input.replaceWith($input.clone(true));
            $preview.empty();
        } else {
            //other
            $input.val("");
            $preview.empty();
        }
    }

    $(".delImg").click(function (event) {
        var $input = $(".addImg");
        var $preview = $('.imgHere');
        resetInputFile($input, $preview);
    });

    // 병역 항목 : 여성 - 군 면제 항목 비활성화, 남성 - 미대상 항목 비활성화
    // if(user_sex == "A0001") $('#militaryService_04').attr('disabled', true);
    // if(user_sex == "A0000") $('#militaryService_03').attr('disabled', true);

    // 학력사항 추가
    $('.addEduHistory').click(function () {
        var $wrapper = $(this).parent().find('.resumeFormWrapper');
        var wrapperDp = $wrapper.css("display");

        if (wrapperDp == 'none') {
            $wrapper.css("display", "block");
        } else {
            var clone = $(this).parent().find('.resumeFormWrapper').eq(0).clone(true).addClass('resumeForm_addStyle');
            var eduIndex = $(".edu_sc_nm").length;
            var eduDateId = "stu_app_eduHistory_dt_" + eduIndex;

            clone.find('.edu_sc_nm').attr('name', 'eduHistoryList[' + eduIndex + '].stu_app_edu_sc_nm');
            clone.find('.edu_field').attr('name', 'eduHistoryList[' + eduIndex + '].stu_app_edu_field');
            clone.find('.edu_major').attr('name', 'eduHistoryList[' + eduIndex + '].stu_app_edu_major');
            clone.find('.edu_gd_ck').attr('name', 'eduHistoryList[' + eduIndex + '].stu_app_edu_gd_ck');
            clone.find('.edu_gd_dt').attr('name', 'eduHistoryList[' + eduIndex + '].stu_app_edu_gd_dt');
            clone.find('.edu_sc_lo').attr('name', 'eduHistoryList[' + eduIndex + '].stu_app_edu_sc_lo');
            clone.find('.edu_gd_rq').attr('name', 'eduHistoryList[' + eduIndex + '].stu_app_edu_gd_rq');
            clone.find('.edu_gd_dt').attr('id', eduDateId);
            clone.find('.rsm_input').val('');

            clone.appendTo($(this).siblings('.resumeFormContainer'));
            $("#" + eduDateId).removeClass('hasDatepicker').datepicker();
            // 복제된 div에 각각 ID부여해서 컨트롤 해야합니다.
        }
    });

    // 경력사항 추가
    $('.addCareer').click(function () {
        var $wrapper = $(this).parent().find('.resumeFormWrapper');
        var wrapperDp = $wrapper.css("display");

        if (wrapperDp == 'none') {
            $wrapper.css("display", "block");
        } else {
            var clone = $wrapper.eq(0).clone(true);
            var crrIndex = $(".crr_st").length;
            var crrFrmId = "stu_app_crr_frm_" + crrIndex;
            var crrEndId = "stu_app_crr_end_" + crrIndex;

            clone.find('.crr_place').attr('name', 'careerList[' + crrIndex + '].stu_app_crr_place');
            clone.find('.crr_dept').attr('name', 'careerList[' + crrIndex + '].stu_app_crr_dept');
            clone.find('.crr_position').attr('name', 'careerList[' + crrIndex + '].stu_app_crr_position');
            clone.find('.crr_phone').attr('name', 'careerList[' + crrIndex + '].stu_app_crr_phone');
            clone.find('.crr_st').attr('name', 'careerList[' + crrIndex + '].stu_app_crr_st');
            clone.find('.crr_et').attr('name', 'careerList[' + crrIndex + '].stu_app_crr_et');
            clone.find('.crr_description').attr('name', 'careerList[' + crrIndex + '].stu_app_crr_description');
            clone.find('.crr_st').attr('id', crrFrmId);
            clone.find('.crr_et').attr('id', crrEndId);
            clone.find('.rsm_input').val('');

            clone.appendTo($(this).siblings('.resumeFormContainer'));
            minMax(crrFrmId, crrEndId);
        }
    });

    // 교육이수 경력 추가
    $('.addStudy').click(function () {
        var $wrapper = $(this).parent().find('.resumeFormWrapper');
        var wrapperDp = $wrapper.css("display");

        if (wrapperDp == 'none') {
            $wrapper.css("display", "block");
        } else {
            var clone = $wrapper.eq(0).clone(true);
            var studyIndex = $(".study_st").length;
            var studyFrmId = "stu_app_study_frm_" + studyIndex;
            var studyEndId = "stu_app_study_end_" + studyIndex;

            clone.find('.study_nm').attr('name', 'studyList[' + studyIndex + '].stu_app_study_nm');
            clone.find('.study_st').attr('name', 'studyList[' + studyIndex + '].stu_app_study_st');
            clone.find('.study_et').attr('name', 'studyList[' + studyIndex + '].stu_app_study_et');
            clone.find('.study_ag').attr('name', 'studyList[' + studyIndex + '].stu_app_study_ag');
            clone.find('.study_detail').attr('name', 'studyList[' + studyIndex + '].stu_app_study_detail');
            clone.find('.study_st').attr('id', studyFrmId);
            clone.find('.study_et').attr('id', studyEndId);
            clone.find('.rsm_input').val('');

            clone.appendTo($(this).siblings('.resumeFormContainer'));
            minMax(studyFrmId, studyEndId);
        }
    });

    // 언어능력 추가
    $('.addLang').click(function () {
        var $wrapper = $(this).parent().find('.resumeFormWrapper');
        var wrapperDp = $wrapper.css("display");

        if (wrapperDp == 'none') {
            $wrapper.css("display", "block");
        } else {
            var clone = $wrapper.eq(0).clone(true);
            var langIndex = $(".lang_obtain_dt").length;
            var langDateId = "stu_app_lang_dt_" + langIndex

            clone.find('.lang_test_nm').attr('name', 'languageList[' + langIndex + '].stu_app_lang_test_nm');
            clone.find('.lang_grade').attr('name', 'languageList[' + langIndex + '].stu_app_lang_grade');
            clone.find('.lang_ag').attr('name', 'languageList[' + langIndex + '].stu_app_lang_ag');
            clone.find('.lang_obtain_dt').attr('name', 'languageList[' + langIndex + '].stu_app_lang_obtain_dt');
            clone.find('.lang_note').attr('name', 'languageList[' + langIndex + '].stu_app_lang_note');
            clone.find('.lang_obtain_dt').attr('id', langDateId);
            clone.find('.rsm_input').val('');

            clone.appendTo($(this).siblings('.resumeFormContainer'));
            $("#" + langDateId).removeClass('hasDatepicker').datepicker();
        }
    });

    // 자격증 추가
    $('.addLicense').click(function () {
        var $wrapper = $(this).parent().find('.resumeFormWrapper');
        var wrapperDp = $wrapper.css("display");

        if (wrapperDp == 'none') {
            $wrapper.css("display", "block");
        } else {
            var clone = $wrapper.eq(0).clone(true);
            var licenseIndex = $(".license_obtain_dt").length;
            var licenseDateId = "stu_app_license_dt_" + licenseIndex

            clone.find('.license_nm').attr('name', 'licenseList[' + licenseIndex + '].stu_app_license_nm');
            clone.find('.license_ag').attr('name', 'licenseList[' + licenseIndex + '].stu_app_license_ag');
            clone.find('.license_obtain_dt').attr('name', 'licenseList[' + licenseIndex + '].stu_app_license_obtain_dt');
            clone.find('.license_note').attr('name', 'licenseList[' + licenseIndex + '].stu_app_license_note');
            clone.find('.license_obtain_dt').attr('id', licenseDateId);
            clone.find('.rsm_input').val('');

            clone.appendTo($(this).siblings('.resumeFormContainer'));
            $("#" + licenseDateId).removeClass('hasDatepicker').datepicker();
        }
    });

    // 본 과정 응시여부  추가
    $('.addSes').click(function () {
        var $wrapper = $(this).parent().find('.resumeFormWrapper');
        var wrapperDp = $wrapper.css("display");

        if (wrapperDp == 'none') {
            $wrapper.css("display", "block");
        } else {
            var clone = $(this).parent().find('.resumeFormWrapper').eq(0).clone(true).addClass('resumeForm_addStyle');
            var sesIndex = $(".ses_dt").length;
            var sesDateId = "stu_app_ses_dt_" + sesIndex

            clone.find('.ses_ck').attr('name', 'sesList[' + sesIndex + '].stu_app_ses_ck').prop('checked', false);;
            clone.find('.ses_dt').attr('name', 'sesList[' + sesIndex + '].stu_app_ses_apply_dt');
            clone.find('.ses_rt').attr('name', 'sesList[' + sesIndex + '].stu_app_ses_apply_rt');
            clone.find('.ses_dt').attr('id', sesDateId);
            clone.find('.rsm_input').val('');

            clone.appendTo($(this).siblings('.resumeFormContainer'));
            $("#" + sesDateId).removeClass('hasDatepicker').datepicker();
        }
    });

    // Kmove스쿨 참여여부  추가
    $('.addKmove').click(function () {
        var $wrapper = $(this).parent().find('.resumeFormWrapper');
        var wrapperDp = $wrapper.css("display");

        if (wrapperDp == 'none') {
            $wrapper.css("display", "block");
        } else {
            var clone = $(this).parent().find('.resumeFormWrapper').eq(0).clone(true).addClass('resumeForm_addStyle');
            var kmoveIndex = $(".kmove_st").length;
            var kmoveFrmId = "stu_app_kmove_frm_" + kmoveIndex;
            var kmoveEndId = "stu_app_kmove_end_" + kmoveIndex;

            clone.find('.kmove_ck').attr('name', 'kmoveList[' + kmoveIndex + '].stu_app_kmove_ck').prop('checked', false);
            clone.find('.kmove_nm').attr('name', 'kmoveList[' + kmoveIndex + '].stu_app_kmove_nm');
            clone.find('.kmove_ag').attr('name', 'kmoveList[' + kmoveIndex + '].stu_app_kmove_ag');
            clone.find('.kmove_st').attr('name', 'kmoveList[' + kmoveIndex + '].stu_app_kmove_st');
            clone.find('.kmove_et').attr('name', 'kmoveList[' + kmoveIndex + '].stu_app_kmove_et');
            clone.find('.kmove_st').attr('id', kmoveFrmId);
            clone.find('.kmove_et').attr('id', kmoveEndId);
            clone.find('.rsm_input').val('');

            clone.appendTo($(this).siblings('.resumeFormContainer'));
            minMax(kmoveFrmId, kmoveEndId);
        }
    });

    // 해외체류경험  추가
    $('.addOverseas').click(function () {
        var $wrapper = $(this).parent().find('.resumeFormWrapper');
        var wrapperDp = $wrapper.css("display");

        if (wrapperDp == 'none') {
            $wrapper.css("display", "block");
        } else {
            var clone = $wrapper.eq(0).clone(true);
            var overseasIndex = $(".overseas_st").length;
            var overseasFrmId = "stu_app_overseas_frm_" + overseasIndex;
            var overseasEndId = "stu_app_overseas_end_" + overseasIndex;

            clone.find('.overseas_ck').attr('name', 'overseasList[' + overseasIndex + '].stu_app_overseas_ck').prop('checked', false);
            clone.find('.overseas_nm').attr('name', 'overseasList[' + overseasIndex + '].stu_app_overseas_nm');
            clone.find('.overseas_st').attr('name', 'overseasList[' + overseasIndex + '].stu_app_overseas_st');
            clone.find('.overseas_et').attr('name', 'overseasList[' + overseasIndex + '].stu_app_overseas_et');
            clone.find('.overseas_purpose').attr('name', 'overseasList[' + overseasIndex + '].stu_app_overseas_purpose');
            clone.find('.overseas_st').attr('id', overseasFrmId);
            clone.find('.overseas_et').attr('id', overseasEndId);
            clone.find('.rsm_input').val('');

            clone.appendTo($(this).siblings('.resumeFormContainer'));
            minMax(overseasFrmId, overseasEndId);
        }
    });

    // 자기소개서  추가
    $('.addIntroduce').click(function () {
        var $wrapper = $(this).parent().find('.resumeFormWrapper');
        var wrapperDp = $wrapper.css("display");

        if (wrapperDp == 'none') {
            $wrapper.css("display", "block");
        } else {
            var clone = $(this).parent().find('.resumeFormWrapper').eq(0).clone(true).addClass('resumeForm_addStyle');
            var introduceIndex = $(".introduce_title").length;

            clone.find('.introduce_title').attr('name', 'introduceList[' + introduceIndex + '].stu_app_introduce_title');
            clone.find('.introduce_detail').attr('name', 'introduceList[' + introduceIndex + '].stu_app_introduce_detail').val('');
            clone.find('.rsm_input').val('');

            clone.appendTo($(this).siblings('.resumeFormContainer'));
        }
    });

    // 이력서 항목 삭제
    $('.resumeForm_delBtn').click(function () {
        var $wrapper = $(this).parents('.resumeFormContainer').children();
        var leng = $wrapper.length;
        var necessary = $wrapper.hasClass('necessary');

        if (leng == 1) {
            var wrapperDp = $wrapper.css("display");
            if (necessary == true) {
                var rsmTitle = $(this).parents('.resumeSection').prev().children('.h3').html();

                alert(rsmTitle + '은(는) 필수 입력항목이므로 반드시 입력 하여 주시기 바랍니다.');
            } else if (necessary == false && wrapperDp == "block") {
                var result = confirm('정말 삭제하시겠습니까? 입력하신 내용은 모두 삭제됩니다.');
                if (result) {
                    var resumeFormWrapper = $(this).parent('.resumeFormWrapper');

                    $.each(resumeFormWrapper.find(".rsm_input"), function (index, item) {
                        item.value = '';
                    })
                    resumeFormWrapper.find(".rsm_selectBox").val("").attr('selected', 'selected');
                    resumeFormWrapper.find(".ses_ck").prop('checked', false);
                    resumeFormWrapper.find(".kmove_ck").prop('checked', false);
                    resumeFormWrapper.find(".overseas_ck").prop('checked', false);
                    resumeFormWrapper.find(".rsm_textarea").val('');
                    resumeFormWrapper.hide();
                }
            }

        } else if (leng > 1) {
            var result = confirm('정말 삭제하시겠습니까? 입력하신 내용은 모두 삭제됩니다.');
            if (result) {
                $(this).parent('.resumeFormWrapper').remove();
            };
        }
    });

    // 이미지 파일 확인
    $("#resumePhoto").change(function () {
        var val = $(this).val();

        if (val == "") {
            $(this).val('');
            $("#imgHere").empty();
            return;
        } else if (!fileImageCheck(val)) {
            $(this).val('');
            $("#imgDiv").empty();
            alert("이미지 파일이 아닙니다. gif, jpg, png 형식만 가능 합니다.");
            return;
        }
    });

    // 파일 형식 확인
    $(".resumeEvidence_file").change(function () {

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

        //파일 사이즈 확인
        if (!fileSizeCheck(size)) {
            $(this).val('');
            alert("파일 사이즈는 5MB 까지 입니다.");
            return;
        }
    });

    // 증빙자료 업로드 안내문
    $('.resumeForm_ntcBtn').click(function () {
        var notice = $(this).prev();
        var dp = $(this).prev().css('display');
        if (dp == "none") {
            notice.show();
            $(this).removeClass('question-circle').addClass('times-circle');
        } else {
            notice.hide();
            $(this).removeClass('times-circle').addClass('question-circle');
        }
    });

    // 증빙자료 업로드_첨부파일명 표시
    for (var i = 1; i < 5; i++) {
        var str = "resumeEvidence" + i;
        document.getElementById(str).onchange = function () {
            var text = this.id + "_url";
            document.getElementById(text).value = this.value.replace(/C:\\fakepath\\/i, '');
        };
    }

    // 지원하기
    $('.resumeBtn').click(function () {
        formCheck();
        /*var result = confirm('지원하시겠습니까? 지원기간 중에는 언제든 수정이 가능합니다.');
        if (result) {
            confirm('지원완료되었습니다. 마이페이지로 이동합니다.')
            // 마이페이지로 이동
        };*/
    });

    // 지원신청 Aside Scroll
    document.addEventListener('scroll', function () {
        const scroll = document.documentElement.scrollTop;
        const applyContainer = document.querySelector(".course-applyContainer").offsetHeight;
        const menuHeight = document.querySelector(".headerWrap").offsetHeight;
        const aside = document.querySelector(".resumeAside");
        const containerHeight = applyContainer - menuHeight - '500';
        // side 지원신청 bar -> fixed
        if (scroll >= containerHeight || scroll >= applyContainer) {
            aside.classList.add("scrollFixed")
        } else {
            aside.classList.remove("scrollFixed")
        }
    });

}); //readyFunction 끝

var myApp = angular.module('myApp', []);

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

function gd_ck_change(obj) {
    var code = $(obj).val();

    if (code == 'B1001' || code == 'B1002')
        $(obj).parents('.row').find('.gd_label').html('졸업예정일<strong class="cRed">＊</strong>');
    else
        $(obj).parents('.row').find('.gd_label').html('졸업일<strong class="cRed">＊</strong>');
}

function ses_ck_change(obj) {
    var code = $(obj).val();

    switch (code) {
        case 'B0700':
            var ses_dt = $(obj).parents('.row').find('.ses_dt').val();
            var ses_rt = $(obj).parents('.row').find('.ses_rt').val();

            if (ses_dt.length == 0 && ses_rt.trim().length == 0) {
                $(obj).parents('.row').find('.ses_dt').val('').attr('disabled', false);
                $(obj).parents('.row').find('.ses_rt').val('').attr('disabled', false).attr('placeholder', '합격/불합격');
            }
            break;
        case 'B0701':
            $(obj).parents('.row').find('.ses_dt').val('').attr('disabled', true);
            $(obj).parents('.row').find('.ses_rt').val('').attr('disabled', true).attr('placeholder', '');
            break;
    }
}

function kmove_ck_change(obj) {
    var code = $(obj).val();

    switch (code) {
        case 'B0900':
            var kmove_nm = $(obj).parents('.row').find('.kmove_nm').val();
            var kmove_ag = $(obj).parents('.row').find('.kmove_ag').val();
            var kmove_st = $(obj).parents('.row').find('.kmove_st').val();
            var kmove_et = $(obj).parents('.row').find('.kmove_et').val();

            if (kmove_nm.trim().length == 0 && kmove_ag.trim().length == 0 && kmove_st.length == 0 && kmove_et.length == 0) {
                $(obj).parents('.row').find('.kmove_nm').val('').attr('disabled', false);
                $(obj).parents('.row').find('.kmove_ag').val('').attr('disabled', false);
                $(obj).parents('.row').find('.kmove_st').val('').attr('disabled', false);
                $(obj).parents('.row').find('.kmove_et').val('').attr('disabled', false);
            }
            break;
        case 'B0901':
            $(obj).parents('.row').find('.kmove_nm').val('').attr('disabled', true);
            $(obj).parents('.row').find('.kmove_ag').val('').attr('disabled', true);
            $(obj).parents('.row').find('.kmove_st').val('').attr('disabled', true);
            $(obj).parents('.row').find('.kmove_et').val('').attr('disabled', true);
            break;
    }
}

function overseas_ck_change(obj) {
    var code = $(obj).val();

    switch (code) {
        case 'B0800':
            var overseas_nm = $(obj).parents('.row').find('.overseas_nm').val();
            var overseas_st = $(obj).parents('.row').find('.overseas_st').val();
            var overseas_et = $(obj).parents('.row').find('.overseas_et').val();
            var overseas_purpose = $(obj).parents('.row').find('.overseas_purpose').val();

            if (overseas_nm.trim().length == 0 && overseas_st.length == 0 && overseas_et.length == 0 && overseas_purpose.trim().length == 0) {
                $(obj).parents('.row').find('.overseas_nm').val('').attr('disabled', false);
                $(obj).parents('.row').find('.overseas_st').val('').attr('disabled', false);
                $(obj).parents('.row').find('.overseas_et').val('').attr('disabled', false);
                $(obj).parents('.row').find('.overseas_purpose').val('').attr('disabled', false);
            }
            break;
        case 'B0801':
            $(obj).parents('.row').find('.overseas_nm').val('').attr('disabled', true);
            $(obj).parents('.row').find('.overseas_st').val('').attr('disabled', true);
            $(obj).parents('.row').find('.overseas_et').val('').attr('disabled', true);
            $(obj).parents('.row').find('.overseas_purpose').val('').attr('disabled', true);
            break;
    }
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
        case 'zip':
            return true;
        default:
            return false;
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

function formCheck() {
    /*	// 필수 파일 체크
    var fileResult = true;
    
    var fileSize = $(".resumeEvidence_file");
    
    $.each(fileSize, function(index, item) {
    	
    	if(index < 4 && item.files.length == 0) {
    		alert($(this).parent().prev().text() + "를 입력하세요.");
    		fileResult = false;
    	}
    	return fileResult;
    });*/

    var crrUi = $(".rsm_career");
    var studyUi = $(".rsm_learn");
    var langUi = $(".rsm_language");
    var licenseUi = $(".rsm_certificate");

    if (basicInfo_Check() && edu_Check() && ses_Check() && kmove_Check() && overseas_Check() && introduce_Check()) {

        if (others_Check(crrUi) && others_Check(studyUi) && others_Check2(langUi) && others_Check2(licenseUi)) {
            //		if(inputCheck(crrUi) && inputCheck(studyUi) && inputCheck(langUi) && inputCheck(licenseUi)) {

            if (confirm("지원하시겠습니까? 지원기간 중에는 언제든 수정이 가능합니다.")) return $('#resumeForm').submit();
            else return false;

        } else return false;
    } else return false;
}

function basicInfo_Check() {
    //지원기간 이내인지 체크
    var end_date = endDt;
    var now = getToday();

    function getToday() {
        var date = new Date();
        return date.getFullYear() + "-" + ("0" + (date.getMonth() + 1)).slice(-2) + "-" + ("0" + date.getDate()).slice(-2);
    }

    if (end_date < now) {
        alert("지원기간이 끝났습니다.");
        return false;
    }

    //사진유무체크
    var photoSize = $("#resumePhoto")[0].files;

    if (photoSize.length == 0) {
        alert("사진을 등록해 주세요.")
        $("#resumePhoto").focus();
        return false;
    }

    //군병력 체크
    var stu_app_mt_ck = $('input:radio[name="stu_app_mt_ck"]:checked').val();

    if (stu_app_mt_ck === undefined) {
        alert("군 병력을 체크해 주세요.");
        $('input:radio[name="stu_app_mt_ck"]').focus();
        return false;
    } else if (stu_app_mt_ck == "B0602") {
        var stu_app_mt_etc = $('input:text[name="stu_app_mt_etc"]').val();
        if (stu_app_mt_etc.length == 0) {
            alert("면제사유를 적어 주세요.");
            $('input:text[name="stu_app_mt_etc"]').focus();
            return false;
        }
    }

    //주소 체크
    var zipcode = $("#zipcode").val();
    if (zipcode.length == 0) {
        alert("주소를 입력해 주세요.");
        $("#zipcode").focus();
        return false;
    }

    var addressDetail = $("#addressDetail").val();
    if (addressDetail.length == 0) {
        alert("상세주소를 입력해 주세요");
        $("#addressDetail").focus();
        return false;
    }

    //휴대전화 체크
    var phone = $('input:text[name="stu_app_phone"]').val();
    if (phone.length == 0) {
        alert("휴대전화 번호를 입력해 주세요.");
        $('input:text[name="stu_app_phone"]').focus();
        return false;
    }

    //이메일 체크
    var email = $('input:text[name="stu_app_email"]').val();
    if (email.length == 0) {
        alert("이메일 주소를 입력해 주세요.");
        $('input:text[name="stu_app_email"]').focus();
        return false;
    }

    return true;
}

//학력정보 체크  : 항목 하나라도 입력하면 다른 항목도 전부 입력하도록. 아무것도 작성하지 않은 빈 줄은 무시하고 service 파일에서 삭제한다.
function edu_Check() {
    var edu = $(".rsm_education").find(".resumeFormWrapper");
    var eduResult = true;
    var today = new Date();
    var cnt = 0;

    $.each(edu, function (index, item) {
        $.each($(this).find(".edu_input"), function (index2, item2) {
            if (item2.value.trim() != "") cnt++;
        });

        if (cnt > 0) {
            $.each($(this).find(".edu_input"), function (index2, item2) {
                if (index2 < 6 && item2.value.trim().length == 0) {
                    alert("학력사항을 입력해주세요.");
                    location.href = "#rsm_education";
                    eduResult = false;
                    //return false;
                } else {
                    if (index2 == 2) {
                        if ($(this).parent().prev("div").find("select").val() == "B1000") {
                            var grDate = new Date(item2.value);
                            if (today.getTime() < grDate.getTime()) {
                                alert("졸업일이 잘못되었습니다.");
                                location.href = "#rsm_education";
                                eduResult = false;
                            }
                        } else if ($(this).parent().prev("div").find("select").val() == "B1001" || $(this).parent().prev("div").find("select").val() == "B1002") {
                            var grDate = new Date(item2.value);
                            if (today.getTime() >= grDate.getTime()) {
                                alert("졸업예정일이 잘못되었습니다.");
                                location.href = "#rsm_education";
                                eduResult = false;
                            }
                        }
                    }
                }
                return eduResult;
            });
        }
        cnt = 0;
        return eduResult;
    });
    return eduResult;
}

//본 과정 응시 여부 체크	 : 항목 하나라도 입력하면 다른 항목도 전부 입력하도록
function ses_Check() {
    var ses = $(".rsm_participation").find(".resumeFormWrapper");
    var sesResult = true;

    $.each(ses, function (index, item) {
        var app_take_ck = $('input:radio[name="sesList[' + index + '].stu_app_ses_ck"]:checked').val();
        var app_take_dt = $('input:text[name="sesList[' + index + '].stu_app_ses_apply_dt"]').val();
        var app_take_rt = $('input:text[name="sesList[' + index + '].stu_app_ses_apply_rt"]').val();

        if (app_take_ck == "B0700") {
            if (app_take_dt.length == 0 || app_take_rt.trim().length == 0) {
                alert("본 과정 응시 정보를 입력해 주세요.");
                location.href = "#rsm_participation";
                sesResult = false;
            }
        } else if (app_take_ck == undefined) {
            if (app_take_dt.length != 0 || app_take_rt.trim().length != 0) {
                alert("본 과정 응시여부에 체크해 주세요.")
                location.href = "#rsm_participation";
                sesResult = false;
            }
        }
        return sesResult;
    });
    return sesResult;
}

//K-MOVE 스쿨 참여어부 체크 : 항목 하나라도 입력하면 다른 항목도 전부 입력하도록
function kmove_Check() {
    var kmove = $(".rsm_kmove").find(".resumeFormWrapper");
    var kmoveResult = true;

    $.each(kmove, function (index, item) {
        var kmove_ck = $('input:radio[name="kmoveList[' + index + '].stu_app_kmove_ck"]:checked').val();
        var kmove_nm = $('input:text[name="kmoveList[' + index + '].stu_app_kmove_nm"]').val();
        var kmove_ag = $('input:text[name="kmoveList[' + index + '].stu_app_kmove_ag"]').val();
        var kmove_st = $('input:text[name="kmoveList[' + index + '].stu_app_kmove_st"]').val();
        var kmove_et = $('input:text[name="kmoveList[' + index + '].stu_app_kmove_et"]').val();

        if (kmove_ck == "B0900") {
            if (kmove_nm.trim().length == 0 || kmove_ag.trim().length == 0 || kmove_st.length == 0 || kmove_et.length == 0) {
                alert("K-MOVE 스쿨 참여 정보를 입력해 주세요.");
                location.href = "#rsm_kmove";
                kmoveResult = false;
            }
        } else if (kmove_ck == undefined) {
            if (kmove_nm.trim().length != 0 || kmove_ag.trim().length != 0 || kmove_st.length != 0 || kmove_et.length != 0) {
                alert("K-MOVE 스쿨 참여여부에 체크해 주세요.");
                location.href = "#rsm_kmove";
                kmoveResult = false;
            }
        }
        return kmoveResult;
    });
    return kmoveResult;
}

//해외경험 체크 : 항목 하나라도 입력하면 다른 항목도 전부 입력하도록
function overseas_Check() {
    var overseas = $(".rsm_experience").find(".resumeFormWrapper");
    var overseasResult = true;

    $.each(overseas, function (index, item) {
        var overseas_ck = $('input:radio[name="overseasList[' + index + '].stu_app_overseas_ck"]:checked').val();
        var overseas_nm = $('input:text[name="overseasList[' + index + '].stu_app_overseas_nm"]').val();
        var overseas_st = $('input:text[name="overseasList[' + index + '].stu_app_overseas_st"]').val();
        var overseas_et = $('input:text[name="overseasList[' + index + '].stu_app_overseas_et"]').val();
        var overseas_purpose = $('input:text[name="overseasList[' + index + '].stu_app_overseas_purpose"]').val();

        if (overseas_ck == "B0800") {
            if (overseas_nm.trim().length == 0 || overseas_st.length == 0 || overseas_et.length == 0 || overseas_purpose.trim().length == 0) {
                alert("해외경험 항목을 입력해 주세요.");
                location.href = "#rsm_experience";
                overseasResult = false;
            }
        } else if (overseas_ck == undefined) {
            if (overseas_nm.trim().length != 0 || overseas_st.length != 0 || overseas_et.length != 0 || overseas_purpose.trim().length != 0) {
                alert("해외경험 유무에 체크해 주세요.");
                location.href = "#rsm_experience";
                overseasResult = false;
            }
        }
        return overseasResult;
    });
    return overseasResult;
}

// 자기소개서 체크 : 항목 하나라도 입력하면 다른 항목도 전부 입력하도록
function introduce_Check() {
    var introduce = $(".rsm_introduction").find(".resumeFormWrapper");
    var introduceResult = true;
    var cnt = 0;

    $.each(introduce, function (index, item) {
        $.each($(this).find(".introduce_input"), function (index2, item2) {
            if (item2.value.trim() != "") cnt++;
        });

        if (cnt > 0) {
            if ($(this).find("input").val().trim().length == 0) {
                alert("자기소개서 제목을 입력하세요.");
                introduceResult = false;
            } else if ($(this).find("textarea").val().trim().length == 0) {
                alert("자기소개서 내용을 입력하세요.");
                introduceResult = false;
            }
            return introduceResult;
        }
        cnt = 0;
    });
    return introduceResult;
}

// 경력, 교육이수 체크 : 항목 하나라도 입력하면 다른 항목도 전부 입력하도록
function others_Check(div) {
    var $wrapper = $(div).find('.resumeFormWrapper');
    var result = true;
    var cnt = 0;
    var category_nm = $(div).find('h3').text();
    var category_position = "#" + $(div).attr('id');

    $.each($wrapper, function (index, item) {
        $.each($(this).find("input"), function (index2, item2) {
            if (item2.value.trim() != "") cnt++;
        });

        if (cnt > 0) {
            $.each($(this).find("input"), function (index2, item2) {
                if (item2.value.trim().length == 0) {
                    alert(category_nm + " 항목을 입력해주세요.");
                    location.href = category_position;
                    result = false;
                }
                return result;
            })
        }
        cnt = 0;
        return result;
    });
    return result;
}

//언어, 자격증 체크 : 위와 동일 + selectbox에서 기타 선택했을 때에만 비고란 기입 강제
function others_Check2(div) {
    var $wrapper = $(div).find('.resumeFormWrapper');
    var result = true;
    var cnt = 0;
    var category_nm = $(div).find('h3').text();
    var category_position = "#" + $(div).attr('id');

    $.each($wrapper, function (index, item) {
        var code = $(this).find("select").val();

        switch (code) {
            case "":
                $.each($(this).find("input"), function (index2, item2) {
                    if (item2.value.trim() != "") cnt++;
                });

                if (cnt > 0) {
                    alert(category_nm + " 항목을 입력해주세요.");
                    location.href = category_position;
                    result = false;
                }
                cnt = 0;
                return result;
                break;
            case "B2906":
                $.each($(this).find("input"), function (index2, item2) {
                    if (item2.value.trim().length == 0) {
                        alert(category_nm + " 항목을 입력해주세요.");
                        location.href = category_position;
                        result = false;
                    }
                    return result;
                })
                return result;
                break;
            default:
                var final_index = $(this).find("input").length - 1;

                $.each($(this).find("input"), function (index2, item2) {
                    if (index2 < final_index && item2.value.trim().length == 0) {
                        alert(category_nm + " 항목을 입력해 주세요.");
                        location.href = category_position;
                        result = false;
                    }
                    return result;
                })
                return result;
        } //swith-case 끝
    });
    return result;
}

/*
function inputCheck(div) {
	var result = true;
	var $wrapper = $(div).find('.resumeFormWrapper');
    var wrapperDp = $wrapper.css("display");
    
    if(wrapperDp == 'block'){
		$.each($wrapper, function() {
			$.each($(this).find("input"), function(index2, item2) {
				
					if(item2.value.trim().length == 0) {
						alert($(this).prev().text()+"을(를) 입력해 주세요.")
						result = false;
					}
				return result;
			});
			return result;
		});
    }
    return result;
}*/
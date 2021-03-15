// resumeForm.js
$(function() {
    // 등록 이미지 등록 미리보기
    function readInputFile(input) {
        if (input.files && input.files[0]) {
            var reader = new FileReader();
            reader.onload = function(e) {
                $('.imgHere').html("<img src=" + e.target.result + ">");
            }
            reader.readAsDataURL(input.files[0]);
        }
    }

    $(".addImg").on('change', function() {
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

    $(".delImg").click(function(event) {
        var $input = $(".addImg");
        var $preview = $('.imgHere');
        resetInputFile($input, $preview);
    });

    // 이력서 항목 추가
    $('.resumeForm_addBtn').click(function() {
        var clone = $(this).parent().find('.resumeFormWrapper').eq(0).clone(true).addClass('resumeForm_addStyle');
        clone.find('.rsm_input').val('');
        clone.appendTo($(this).siblings('.resumeFormContainer'));
        // 복제된 div에 각각 ID부여해서 컨트롤 해야합니다.
    });
    // 이력서 항목 삭제
    $('.resumeForm_delBtn').click(function() {
        var result = confirm('정말 삭제하시겠습니까? 입력하신 내용은 모두 삭제됩니다.');
        if (result) {
            $(this).parent('.resumeFormWrapper').remove();
        };
    });

    // 증빙자료 업로드_첨부파일 명 표시
    for (var i = 1; i < 10; i++) {
        var str = "resumeEvidence" + i;

        document.getElementById(str).onchange = function() {
            var text = this.id + "_url";
            document.getElementById(text).value = this.value.replace(/C:\\fakepath\\/i, '');
        };
    }

    // 증빙자료 업로드 안내문
    $('.resumeForm_ntcBtn').click(function() {
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

    // 지원서 항목 resume Aside Nav
    $('.resumeNav_add').click(function() {
        var link = $(this).prev().find('a').attr('href');
        var wrapDp = $(link).css('display');

        if (wrapDp == "none") {
            $(this).removeClass('plus-circle-gray').addClass('minus-circle-navy').prev().find('.navTxt').css('color','#11283b');
            $(this).prev().find('.img-icon').addClass('iconHover');
            $(link).css("display","block");
        } else {
            $(this).removeClass('minus-circle-navy').addClass('plus-circle-gray').prev().find('.navTxt').css('color','#9b9ea0');
            $(this).prev().find('.img-icon').removeClass('iconHover');
            $(link).css("display","none");
        }
    });

    // 지원하기
    $('.resumeBtn').click(function() {
        var result = confirm('지원하시겠습니까? 지원기간 중에는 언제든 수정이 가능합니다.');
        if (result) {
            confirm('지원완료되었습니다. 마이페이지로 이동합니다.')
            // 마이페이지로 이동
        };
    });
});

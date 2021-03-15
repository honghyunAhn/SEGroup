// index.js
$(function() {

    //header>.top-menu Language Event 호버시 드랍 메뉴
    var $nav = $('.hdr .nav'),
        $gnb = $('.hdr .nav .gnb'),
        $lnb = $('.hdr .nav .lnb');

    $lnb.css('display', 'none');

    $gnb.on("mouseenter click",function() {
        var dp = $(this).next().css('display');
        if (dp == 'none') {
            $lnb.show();
            $(this).next().show();
        }
    });

    $nav.mouseleave(function() {
        $lnb.hide();
    });

    //lnb hover시 gnb 활성화
    $lnb.mouseenter(function() {
        $(this).prev().addClass('fontHover');
    });
    $lnb.mouseleave(function() {
        $(this).prev().removeClass('fontHover');
    });

    // 반응형
    var responsive1024 = window.matchMedia("screen and (max-width : 1024px)");

    //기기의 너비가 1024px 이하시 작동하는 기능
    if (responsive1024.matches) {
        // 모바일 네비 >> ▤ 클릭 기능
        $(".m-navIcon .bars").on("click", function() {
            var mobileNav = $('.mNavWrap').css("display");
            $(".mNavWrap").slideToggle();

            if (mobileNav == "none") {
                $('.m-navIcon>.bars').attr('class', 'img-icon times');
                // 풀메뉴 제외한 나머지 영역(BackGround)클릭시 메뉴 닫기

            } else if (mobileNav == "block") {
                $('html, body').removeClass("not-scroll");
                // console.log('풀메뉴닫기');
                $('.m-navIcon>.times').attr('class', 'img-icon bars');
            }
        });
        // 모바일 네비 >> ▤ 클릭 기능 끝
    };
});

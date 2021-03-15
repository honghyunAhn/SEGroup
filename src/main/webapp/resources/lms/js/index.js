// index.js
$(function() {


    //메인 >> 배너 슬라이드(롤링)
    var swiper = new Swiper(".swiper1", {

        spaceBetween: 300,
        centeredSlides: true,
        autoplay: {
            speed: 1000,
            delay: 5000,
            disableOnInteraction: false
        },
        pagination: {
            el: ".swiper-pagination",
            clickable: true
        },
        navigation: {
            nextEl: ".swiper-button-next",
            prevEl: ".swiper-button-prev"
        }
    });
    //메인 >> 배너 슬라이드(롤링) 끝

    // 메인 >> 비디오 슬라이드
    var swiper = new Swiper('.swiper2', {
        centeredSlides: true,
        slidesPerView: 4,
        spaceBetween: 20,
        loop: true,
        pagination: {
            el: '.swiper-pagination',
            clickable: true,
        },
        navigation: {
            nextEl: '.swiper-button-next',
            prevEl: '.swiper-button-prev',
        },
        //반응형
        breakpointsInverse: true,
        breakpoints: {

            640 : {
                slidesPerView: 2,
                spaceBetween: 20
            },
            320 : {
                slidesPerView: 1,
                spaceBetween: 10
            }
        }
    });



    // 메인 >> 비디오 슬라이드 끝

    //메인 >> 버튼 Quick 메뉴 20-08-18 추가
    $('.menu-btn').on('mouseenter',function(){
        $(this).addClass('menu-btn-hover');
    });
    $('.menu-btn').on('mouseleave',function(){
        $(this).removeClass('menu-btn-hover');
    });
    //메인 >> 버튼 Quick 메뉴 끝

    //메인 >> header_공지사항 슬라이드 버튼
    $(".button-wrap .btn-prev").click(function() {
        $(".topMenu-notice").css({
            marginBottom: -20
        });
        $(".topMenu-notice li").last().prependTo(".topMenu-notice");
        $(".topMenu-notice").animate({
            marginBottom: 0
        });
    });

    $(".button-wrap .btn-next").click(function() {
        $(".topMenu-notice").css({
            marginBottom: 20
        });
        $(".topMenu-notice li").first().appendTo(".topMenu-notice");
        $(".topMenu-notice").animate({
            marginBottom: 0
        });
    });
    //메인 >> header_공지사항 슬라이드 버튼 끝


    // 2020-08-18 분야별 추천 강좌 >> 마우스오버 강좌정보보기 삭제
    // $(".class-card-event>a").on("mouseenter", function() {
    //     $(this).children(".class-seg").show();
    //     $(".class-card-event").mouseleave(none);
    // });
    //
    // function none() {
    //     $(".class-card-event>a").children(".class-seg").hide();
    // };
    //분야별 추천 강좌 >> 마우스오버 강좌정보보기 끝



    // 2020-08-18 홍보영상/인터뷰 >> 좌우 슬라이드 삭제
    // $(".interviewWrap .btnWrap .prev").click(function() {
    //     $(".videoWrap").css({
    //         // marginLeft: -346
    //         marginLeft: -300
    //     });
    //     $(".videoWrap div.video").last().prependTo(".videoWrap");
    //     $(".videoWrap").animate({
    //         // marginLeft: 0
    //         marginLeft: -20 + '%'
    //     });
    // });
    //
    //
    // $(".interviewWrap .btnWrap .next").click(function() {
    //     $(".videoWrap").css({
    //         // marginLeft: 346
    //         marginLeft: 0
    //     });
    //     $(".videoWrap div.video").first().appendTo(".videoWrap");
    //     $(".videoWrap").animate({
    //         // marginLeft: 0
    //         marginLeft: -20 + '%'
    //     }, 700);
    // });
    //홍보영상/인터뷰 >> 좌우 슬라이드 끝


    // 반응형
    var responsive480 = window.matchMedia("screen and (max-width : 480px)");

    //기기의 너비가 480px 이하시 작동하는 기능
    if (responsive480.matches) {

        //2020-08-18 홍보영상/인터뷰 >> 좌우 슬라이드 삭제
        // var $btL = $(".interviewWrap .btnWrap .prev");
        // var $btR = $(".interviewWrap .btnWrap .next");
        // var $iGroup = $(".videoWrap");
        // var $igItem = $(".videoWrap div.video");
        // var igMargin = 0;
        // var pos = 0;
        // var iTwidth = parseInt($igItem.css('width')) + parseInt(10);
        //
        // $iGroup.css('margin-left', -iTwidth + 'px');
        // $igItem.last().prependTo($iGroup);
        // $btR.click(slideImg);
        //
        // function slideImg() {
        //     pos = parseInt($iGroup.css('margin-left'));
        //     $iGroup.stop().animate({
        //         marginLeft: pos - iTwidth
        //     }, function() {
        //         $igItem = $('div.sliderImg>.imgGroup>li');
        //         $iGroup.css('margin-left', -iTwidth + 'px');
        //         $igItem.first().appendTo($iGroup);
        //     });
        // }
        //
        // $btL.click(function() {
        //     pos = parseInt($iGroup.css('margin-left'));
        //     $iGroup.stop().animate({
        //         marginLeft: pos + iTwidth
        //     }, function() {
        //         $igItem = $('div.sliderImg>.imgGroup>li');
        //         $iGroup.css('margin-left', -iTwidth + 'px');
        //         $igItem.last().prependTo($iGroup);
        //     });
        // });
        //홍보영상/인터뷰 >> 좌우 슬라이드 끝
    }



});

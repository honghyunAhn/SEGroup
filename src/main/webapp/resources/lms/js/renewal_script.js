// renewal_script.js
$(function() {
    // index >> 분야별추천강좌 슬라이더
    var swiper = new Swiper('.swiper-container', {
        slidesPerView: 5,
        spaceBetween: 0,
        // slidesPerGroup: 5,
        // loop: true,
        // loopFillGroupWithBlank: true,
        pagination: {
            el: '.swiper-pagination',
            clickable: true,
        },
        navigation: {
            nextEl: '.swiper-button-next',
            prevEl: '.swiper-button-prev',
        },
    });
    
    // 반응형 >> index >> 이벤트 배너 이미지 슬라이더
    var swiper = new Swiper('.bannerImg_responsive', {
      spaceBetween: 30,
      centeredSlides: true,
      loop: true,
      autoplay: {
        delay: 2500,
        disableOnInteraction: false,
      },
      pagination: {
        el: '.swiper-pagination',
        clickable: true,
      },
      navigation: {
        nextEl: '.swiper-button-next',
        prevEl: '.swiper-button-prev',
      },
    });
  

    //topButton 스크롤탑
    $('.scrollToTop').click(function() {
        $('html, body').animate({
            scrollTop: 0
        }, 300);
        return false;
    });
    $(window).scroll(function() {
        var scroll = $(this).scrollTop();

        if (scroll > 150) {
            $('.scrollToTop').fadeIn();
        } else {
            $('.scrollToTop').fadeOut();
        }
    });

    //네비 전체메뉴  보기 / 닫기 기능
    $(".fullNav").on("click", function() {
        $(".fullWrapper").show();
        $('body').addClass('not-scroll');
    });
    $('.fullWrapper .close').click(function() {
        $(".fullWrapper").hide();
        $('body').removeClass('not-scroll');
    });

    //PC 네비 마우스오버시 메뉴 드롭 기능
    var $nav = $('.subPage_header .subNav .navGroup');
    var $gnb = $('.subPage_header .subNav .navGroup .gnb');
    var $lnb = $('.subPage_header .subNav .navGroup .lnb');

    $gnb.on("mouseenter", function() {
        var dp = $(this).children().next().css('display');
        if (dp == 'none') {
            $lnb.hide();
            $(this).children().next().slideDown();
        }
    });
    $nav.on("mouseleave", function() {
        $lnb.hide().prev().removeClass('active');
    });

    $lnb.mouseenter(function() {
        $(this).prev().addClass('active');
    }).mouseleave(function() {
        $(this).prev().removeClass('active');
    });
});

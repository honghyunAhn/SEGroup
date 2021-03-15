// renewal_script.js
$(function() {
    // index >> 이벤트 배너 이미지 슬라이더
    var swiper = new Swiper('.bannerWrap', {
        spaceBetween: 10,
        centeredSlides: true,
        loop: true,
        autoplay: {
            delay: 4000,
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

    // nav
    $('#showNav').click(function(){
        $(this).parents('.headerWrap').prev('.fullWrapper').show();
    });
    $('#hideNav').click(function(){
        $(this).parents('.fullWrapper').hide();
    });
});

// main.header.js
$(function(){

    //header>.top-menu Language Event 호버시 드랍 메뉴
    var $nav = $('ul.user-menu'),
    $navWrap = $('ul.user-menu .navWrap'),
        $gnb = $('ul.user-menu .gnb'),
        $lnb = $('ul.user-menu .lnb');

    $lnb.css('display','none');

    $gnb.mouseenter(function(){
        var dp = $(this).next().css('display');
        if(dp == 'none'){
            $lnb.slideUp();
            $(this).next().slideDown();
        }
    });

    $navWrap.mouseleave(function(){
        $lnb.slideUp();
    });
    
 // 2020-04-29 로그인 시 보여지는 nav Drop
    var $nav2 = $('.navWrapper'),
        $gnb2 = $('.gnbWrapper>.alignNav>.gnb2'),
        $lnb2 = $('.lnbWrapper>.alignNav>.lnb2');

    $lnb2.css('display','none');
    $gnb2.mouseenter(function(){
        $lnb2.slideDown();
    });
    $nav2.mouseleave(function(){
        $lnb2.slideUp();
    });


});

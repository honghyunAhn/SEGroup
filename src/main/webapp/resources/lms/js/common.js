// common.js
$(function() {
    // 반응형
    var responsive480 = window.matchMedia("screen and (max-width : 480px)"),
        responsive1024 = window.matchMedia("screen and (max-width : 1024px)");

    //기기의 너비가 480px 이하시 작동하는 기능
    if (responsive480.matches) {
        //(모바일) 탭 타이틀 2줄 넘어갈 때 개별 스타일 지정
        var tabHeight = $('.calss-tabMenu .tabGroup>li').height();
        //(모바일) 탭 타이틀 2줄 넘어갈 때 개별 스타일 지정 끝

    };

    if (responsive1024.matches) {
        //기기의 너비가 1024px 이하시 작동하는 기능

        // 모바일 네비 >> ▤ 클릭 기능
        $(".mobile-headerWrap .bars").on("click", function() {
            var mobileNav = $('.mobile-headerWrap .m-navBg').css("display");
            $(".mobile-headerWrap .m-navBg").slideToggle();

            if (mobileNav == "none") {
                //not-scroll : 모바일 네비 활성화시 background 스크롤 금지
                $('html, body').addClass("not-scroll");

                $('.mobile-header>.nav-menu>.bars').attr('class', 'img-icon times');

                // 풀메뉴 제외한 나머지 영역(BackGround)클릭시 메뉴 닫기
                $('.mobile-headerWrap>.m-navBg').click(function(e) {
                    if (!$('.mobile-headerWrap .m-navBg').has(e.target).length) {
                        $('html, body').removeClass("not-scroll");
                        $('.mobile-headerWrap .m-navBg').hide();
                        $('.mobile-header>.nav-menu>.times').attr('class', 'img-icon bars');
                    }
                });
            } else if (mobileNav == "block") {
                $('html, body').removeClass("not-scroll");
                // console.log('풀메뉴닫기');
                $('.mobile-header>.nav-menu>.times').attr('class', 'img-icon bars');
            }
        });
        // 모바일 네비 >> ▤ 클릭 기능 끝

        //모바일 네비 >> 아코디언 메뉴 (중분류 메뉴 클릭시 소분류 메뉴 up and down)
        $('.m-navGroup .lnb').on('click',function(){
            var mobileSubMenu = $(this).find('.menu-sub').css("display");
            if(mobileSubMenu == "none"){
                $('.menu-sub').hide()
                $('.menu-sub .angle-down').removeClass('angle-down').addClass('angle-right');
                $(this).find('.menu-sub').slideDown();
                $(this).find('.angle-right').removeClass('angle-right').addClass('angle-down');
        } else if(mobileSubMenu == "block"){
            $('.angle-down').removeClass('angle-down').addClass('angle-right');
            $(this).children('.menu-sub').hide();
        }
        });
        //모바일 네비 >> 아코디언 메뉴 (중분류 메뉴 클릭시 소분류 메뉴 up and down) 끝

        //모바일 네비 >> user UI 클릭 기능
        $('.mobile-headerWrap .user').on('click', function() {
            $(this).parents('.mobile-header').next('.mobile-hdr-loginWrap').slideToggle();
        });
        //모바일 네비 >> user UI 클릭 기능 끝

        // 네비(header) 스크롤시 최상단 고정 + TopButton 스크롤탑
        $(window).scroll(function() {
            var scroll = $(this).scrollTop();
            //모바일 네비(header) 스크롤시 최상단에 고정
            if (scroll > 40) {
                $('.mobile-headerWrap').addClass('mobile-headerWrap-fixed');
            } else {
                $('.mobile-headerWrap').removeClass('mobile-headerWrap-fixed');
            };
            //모바일 네비(header) 스크롤시 최상단에 고정 끝

        });
        // 네비(header) 스크롤시 최상단 고정 + TopButton 스크롤탑 끝
    };
    //기기의 너비가 1024px 이하시 작동하는 기능 끝

    //20-08-18 탑 배너 회사소개 slideDown >> 태블릿전용 탑배너 회사소개 삭제
    // var getHeight = $('.top-bannerWrap').css("height");
    //기기 너비에 따라 높이값이 변경되므로 속성값 가져와 스타일 지정하기
    // console.log(getHeight);
    // $(".btn-down>.angle-down").on("click", function() {
    //     $(".top-bannerWrap").animate({
    //         "height": 940
    //     }, 1000);
    //     $(".angle-down").hide();
    //     $(".btn-down>.close").show();
    // });
    // $(".top-bannerWrap .times").click(function() {
    //     $(".top-bannerWrap").css({
    //         "height": getHeight,
    //         "backgroundPosition": "top"
    //     });
    //     $(".btn-down>.times").hide();
    //     $(".btn-down>.angle-down").show();
    // });
    //탑 배너 회사소개 slideDown 끝


    //로그아웃 클릭시 로그인버튼 및 사용자 환영 UI 활성화
    $(".logout").click(function() {
        var confirmLogout = confirm("로그아웃하시겠습니까?");
        if (confirmLogout == true) {
            alert("로그아웃되었습니다.");
            $("li.d-b").hide();
            $("li.d-n").show();
            //모바일 Nav
            $('.mobile-user .welcome').text('로그인이 필요합니다.');

            // return true;
        } else {
            return false;
        }
    });
    //로그아웃 클릭시 로그인버튼 및 사용자 환영 UI 활성화 끝


    // 공지 슬라이드 기능 시작

    // 공지 슬라이딩 >> 자동재생 기능 (3초에 1번)
    var ticker = function() {
        timer = setTimeout(function() {
            $('.topMenu-notice .notice:first').animate({
                marginTop: '-20px'
            }, 400, function() {
                $(this).detach().appendTo('.topMenu-notice').removeAttr('style');
            });
            ticker();
        }, 3000);
    };
    // 공지 슬라이딩 >> 자동재생 기능 (3초에 1번) 끝

    // 공지 슬라이딩 >> 이전버튼 기능
    $(document).on('click', '.prev', function() {
        $('.topMenu-notice .notice:last').hide().prependTo($('.topMenu-notice')).slideDown();
        clearTimeout(timer);
        ticker();
    });
    // 공지 슬라이딩 >> 이전버튼 끝

    // 공지 슬라이딩 >> 다음버튼 기능
    $(document).on('click', '.next', function() {
        $('.topMenu-notice .notice:first').animate({
            marginTop: '-20px'
        }, 400, function() {
            $(this).detach().appendTo('.topMenu-notice').removeAttr('style');
        });
        clearTimeout(timer);
        ticker();
    });
    // 공지 슬라이딩 >> 다음버튼 끝


    // 공지 슬라이딩 >> 자동재생 기능 (3초에 1번) >> 마우스를 올렸을 때 재생 정지
    var tickerover = function(event) {
        $('.topMenu-notice').mouseover(function() {
            clearTimeout(timer);
        });
        $('.topMenu-notice').mouseout(function() {
            ticker();
        });
    };
    // 공지 슬라이딩 >> 자동재생 기능 (3초에 1번) >> 마우스를 올렸을 때 재생 정지 끝

    tickerover();
    ticker();

    // 공지 슬라이드 기능 끝

    //topButton 스크롤탑
    $(window).scroll(function() {
        var scroll = $(this).scrollTop();

        if (scroll > 200) {
            $('.top-btn').fadeIn();
        } else {
            $('.top-btn').fadeOut();
        }

    });

    $('.top-btn').click(function() {
        $('html, body').animate({
            scrollTop: 0
        }, 100);
        return false;
    });
    //topButton 스크롤탑 끝

    //PC 네비 마우스오버시 메뉴 드롭 기능
    var $nav = $('.subPage_header .subNav .navGroup>li');
    var $gnb = $('.subPage_header .subNav .navGroup .gnb');
    var $lnb = $('.subPage_header .subNav .navGroup .lnb');

    $nav.on("mouseenter", function() {
        var dp = $(this).children().next().css('display');
        if (dp == 'none') {
            $lnb.hide();
            $(this).children().next().slideDown();
        }
    });
    $nav.on("mouseleave", function() {
        $lnb.hide();
    });
    //PC 네비 마우스오버시 메뉴 드롭 기능 끝

    //PC 네비 전체메뉴보기 기능
    $(".btn-toggle").on("click", function() {
        var fullWrapper = $('.fullWrapper').css("display");
        // console.log(fullWrapper);
        $(".fullWrapper").slideToggle();
        if (fullWrapper == "none") {
            // console.log('풀메뉴실행');
            $('.btn-toggle>.bars').attr('class', 'img-icon times');
            $('.hide-show-txt').text('전체 메뉴 닫기');
        } else if (fullWrapper == "block") {
            // console.log('풀메뉴닫기');
            $('.btn-toggle>.times').attr('class', 'img-icon bars');
            $('.hide-show-txt').text('전체 메뉴 보기');
            //    if(!$('.fullWrapper').has(e.target).length) {
            //     $(".fullWrapper").hide();
            // }
        }
    });

    // 소메뉴 hover시 중메뉴에 style적용
    $('.menu-title-division .menu-sub li').on("mouseenter",function(){
        $(this).parent('.menu-sub').parent('.lnb').children('a').addClass('lnb-hover');
        $(this).parent('.menu-sub').parent('.lnb').addClass('lnb-hover2');
    });
    $('.menu-title-division .menu-sub li').on("mouseleave",function(){
        $(this).parent('.menu-sub').parent('.lnb').children('a').removeClass('lnb-hover');
        $(this).parent('.menu-sub').parent('.lnb').removeClass('lnb-hover2');
    });
    // 소메뉴 hover시 중메뉴에 style적용 끝

    //PC 네비 전체메뉴보기 기능 끝



    //서브페이지 탭 ( 과정정보탭 /소메뉴탭 )
    var $tab = $('.section div.class-tabMenu>.tabGroup>li'),
        $sub = $('.section div.class-tabMenu>.subGroup>div'),
        i = 0;
    $tab.click(function() {
        i = $(this).index();
        $sub.hide();
        $sub.eq(i).show();
        $('.section .tabGroup>li*').removeClass('active');
        $(this).addClass('active');
        return false;
    });
    //서브페이지 탭 ( 과정정보탭 /소메뉴탭 ) 끝


    // 서브페이지 과정명 >> 숨김 (아코디언) 탭
    $(".open-class").on("click", function() {
        var openCtt = $(this).parent('.class-list').next('.open-ctt').css("display");
        // console.log(fullWrapper);

        $(this).parent('.class-list').next('.open-ctt').slideToggle();
        if (openCtt == "none") {
            // console.log('상세보기');
            // console.log(this);
            $(this).find('.sort-up').attr('class', 'img-icon sort-down');
            $(this).find('.hide-show-txt').text('닫기');
        } else if (openCtt == "block") {
            // console.log('상세닫기');
            $(this).find('.sort-down').attr('class', 'img-icon sort-up');
            $(this).find('.hide-show-txt').text('상세');
        }
    });
    // 서브페이지 과정명 >> 숨김 (아코디언) 탭 끝

    // 게시판 목록 중 열린 탭 하이라이트(bgc #ebeffa)처리
    $(".board-list").on("click", function() {
        var openAnswer = $(this).next('.open-asw').css("display");

        $(this).next('.open-asw').slideToggle();

        if (openAnswer == "none") {
            $(this).addClass('highlight');
        } else if (openAnswer == "block") {
            $(this).removeClass('highlight');
        }
    });
    // 게시판 목록 중 열린 탭 하이라이트(bgc #ebeffa)처리 끝

    //sub06-02 plus-tabGroup 5개 초과시 탭 스타일 변경
    var tabPlus = $('.section.sub06-02 .tabGroup>li').length;
    //console.log('tab의 갯수는' + tabPlus);

    if(tabPlus > 5){
        $('.section.sub06-02 .tabGroup').addClass('plus-tabGroup');
    }else if(tabPlus < 5){
        $('.section.sub06-02 .tabGroup').removeClass('plus-tabGroup');
    }
    //sub06-02 plus-tabGroup 5개 초과시 탭 스타일 변경 끝



    // modal-popup layer
    $('.modal-popup').click(function() {
        // 모달 열기
        $('html, body').addClass("not-scroll");
        $('.modal').show()

        // 모달 >> 탭 기능
        var $modaltab = $('.section div.class-tabMenu>.modal-tabGroup>li'),
            $modalsub = $('.section div.class-tabMenu>.modal-subGroup>div'),
            i = 0;

        $modaltab.on('click', function() {
            i = $(this).index();
            $modalsub.hide();
            $modalsub.eq(i).show();
            $('.section .modal-tabGroup>li*').removeClass('active');
            $(this).addClass('active');
        });
        // 모달 >> 탭 기능 끝

        //모달 열면 탭 활성화 초기화(index 0 = active)
        $('.modal-tabGroup>li').removeClass('active');
        $('.modal-tabGroup>li:first').addClass('active');
        $('.modal-subGroup>div').hide();
        $('.modal-subGroup>div:first').show();
        //모달 열면 탭 활성화 초기화(index 0 = active) 끝
    });

    $('.modal .close-modal').click(function() {
        // 모달 닫기
        $('html, body').removeClass("not-scroll");
        $('.modal').hide();

        //모달 닫으면 기존 탭 활성화 초기화(index 0 = active)
        $('.section .tabGroup>li:first').addClass('active');
        $('.section .subGroup>div:first').show();
        //모달 닫으면 기존 탭 활성화 초기화(index 0 = active) 끝
    });
    //modal-popup layer 끝

    //2020-03-25 추가 나의강의실-학습현황 원형그래프 시작
    $(window).on('load',function(){
    //$('.chart').each(function(i){ //여러개일 경우를 대비하여 each문 사용

            var j = $('.chart .calStatus').eq(i).text(),
                degRight = 0,
                degLeft = 180;
                j = parseInt(j);

            $('.chart .calStatus').eq(i).text('0%');
            $({percent:0}).delay(500).animate({percent : j}, {
                duration : 1500,
                progress : function(){
                    var now = parseInt(this.percent),
                        deg = now * 360 / 100; //환산식
                    degRight = Math.min(180, deg);
                    degLeft = Math.max(180, deg);

                    $('.chart .calStatus').eq(i).text(now +'%');

                    $('.chart .right li').eq(i).css({
                        transform : 'rotate('+degRight+'deg)'
                    });
                    $('.chart .left li').eq(i).css({
                        transform : 'rotate('+degLeft+'deg)'
                    });
                }
            });
    //});
        // 나의강의실-수료기준메시지 시작
        var score = $('.sumCondition').text(),
            score = parseInt(score);

        $('.sumCondition').text(score +'점');

        if(score>=80){
            $('.showTxt .cMain').show();
            $('.showTxt .cDanger').hide();
        }else{
            $('.showTxt .cMain').hide();
            $('.showTxt .cDanger').show();
        }
        // 나의강의실-수료기준메시지 끝
        
    });
    //나의강의실-학습현황 원형그래프 끝




});

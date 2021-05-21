// rainbow_script.js

$(function() {
    // index >> 이벤트 배너 이미지 슬라이더
    var swiper = new Swiper('.swiper-container', {
        slidesPerView: 3,
		spaceBetween: 20,
        speed: 1000,
        autoplay: {
            delay: 6000,
            disableOnInteraction: false,
        },
        pagination: {
            el: '.swiper-pagination',
            clickable: true,
        },
        breakpoints: {
            // when window width is >= 320px
        	640: {
                slidesPerView: 1,
                spaceBetween: 20,
            },
            1024: {
                slidesPerView: 2,
                spaceBetween: 20,
            },
            1200: {
                slidesPerView: 3,
                spaceBetween: 20,
            }
          }
    });

    // index >> nav
    $('#showNav').click(function() {
        $(this).parents('.header').next('.fullWrapper').show();
        // sub >> nav
        // $(this).parents('.header_sub').next('.fullWrapper').show();
        $('body').addClass('not-scroll');
    });
    $('#hideNav').click(function() {
        $(this).parents('.fullWrapper').hide();
        $('body').removeClass('not-scroll');
    });

    // main Header
        var $nav = $('.container_rainbow>.headerWrap');
        var $gnb = $('.container_rainbow>.headerWrap>.header-menuWrap>.point_bgTxt01');
        var $lnb = $('.container_rainbow>.headerWrap>.header-menuWrap>.header-subMenuWrap');
        $lnb.hide();
        $nav.mouseenter(function() {
        	$lnb.show();
        });
        $nav.mouseleave(function() {
        	$lnb.hide();
        });
//        $nav.mouseenter(function() {
//            $lnb.slideDown();
//        });
//        $nav.mouseleave(function() {
//            $lnb.slideUp();
//        });
        $lnb.find('.hdrSubMenu').mouseenter(function(){
            $(this).addClass('point_fc01');
        });
        $lnb.find('.hdrSubMenu').mouseleave(function(){
            $(this).removeClass('point_fc01');
        });

    // index >> fieldWrap
    $('.fieldWrap .tabGroup li:first-child').addClass('active');
    $('.fieldWrap').on('click', '.tabGroup>li', function() {
        var index = $(this).parent().children().index(this);
        $(this).siblings().removeClass('active');
        $(this).addClass('active');
        $(this).parent().next('.subGroup').children().hide().eq(index).show();
    });
    // index >> fieldWrap(mobile)
    var $mTab = $('.tabGroup-mobile .mobile-tab'),
        $mSub = $('.tabGroup-mobile .mobile-sub');
    $mSub.css('display', 'none');
    $mTab.click(function() {
        var dp = $(this).next().css('display');
        if (dp == 'none') {
            $mSub.hide();
            $(this).next().slideDown();
            // }else if(dp == 'block'){
            //     $(this).next().slideUp();
        }
    });

    // myClass >> learningStatus-tabMenu
    var $learningTab = $('.section_sub05-01 .class-tabMenu .tabGroup>li'),
        $learningSub = $('.section_sub05-01 .class-tabMenu .subGroup>.tab-sub'),
        i = 0;
    $learningTab.click(function() {
        i = $(this).index();
        $learningSub.hide();
        $learningSub.eq(i).show();
        $learningTab.removeClass('active');
        $(this).addClass('active');
        return false;
    });

    // myClass >> myClass-tabMenu
    var $myClassTab = $('.myClass-tabMenu .myClass-tabGroup>li'),
        $myClassSub = $('.myClass-tabMenu .myClass-subGroup>.tab-sub'),
        i = 0;
    $myClassTab.click(function() {
        i = $(this).index();
        $myClassSub.hide();
        $myClassSub.eq(i).show();
        $myClassTab.removeClass('active');
        $(this).addClass('active');
        return false;
    });

    $('.modal-popup').click(function() {
        // 모달 열기
        $('html, body').addClass("not-scroll");
        $('.modal').show()
    });
    $('.modal .close-modal').click(function() {
        // 모달 닫기
        $('html, body').removeClass("not-scroll");
        $('.modal').hide();
    });
    // modal-popup layer 끝

    // footer >> topButton 스크롤탑
    $('.scrollToTop_RB').click(function() {
        $('html, body').animate({
            scrollTop: 0
        }, 300);
        return false;
    });
    $(window).scroll(function() {
        var scroll = $(this).scrollTop();

        if (scroll > 150) {
            $('.scrollToTop_RB').fadeIn();
        } else {
            $('.scrollToTop_RB').fadeOut();
        }
    });

    // subPage_게시판 >> sub04_FAQ
    $(".open-answer").on("click", function() {
        var openAnswer = $(this).next('.open-asw').css("display");
        $(this).next('.open-asw').slideToggle();
    });



    // 반응형
    var responsive480 = window.matchMedia("screen and (max-width : 480px)"),
    	responsive767 = window.matchMedia("screen and (max-width : 767px)"),
        responsive1024 = window.matchMedia("screen and (max-width : 1024px)");

    if (responsive1024.matches) {
        
    };
    
    if (responsive767.matches) {
    	
    };
    
    if (responsive480.matches) {
    	
    };
    
  //form태그 객체화하는 함수
    $.fn.serializeObject = function() {
      	"use strict"
      	var result = {}
      	var extend = function(i, element) {
      		var node = result[element.name]
      		if("undefined" !== typeof node && node !== null) {
      			if($.isArray(node)) {
      				node.push(element.value)
      			}else{
      				result[element.name] = node
      				//result[element.name] = [node, element.value]
      			}
      		}else{
      			result[element.name] = element.value
      		}
      	}
      	$.each(this.serializeArray(), extend)
      	return result
      }
    $('.modal-popup').click(function() {
  	    // 모달 열기
  	    $('html, body').addClass("not-scroll");
  	    $('.modal').show()
  	});
    $('.modal .close-modal').click(function() {
  	    // 모달 닫기
  	    $('html, body').removeClass("not-scroll");
  	    $('.modal').hide();
  	});
  	// modal-popup layer 끝
  });
  //timestamp -> date 형식변환
  function getDateFormat(timestamp) {
  	
  	var dateVal = new Date(timestamp);
  	var year = dateVal.getFullYear();
  	var month = dateVal.getMonth() + 1;
  	var day = dateVal.getDate();
  	var time = dateVal.getHours();
  	var min = dateVal.getMinutes();
  	var sec = dateVal.getSeconds();
  	var formattedVal = year + '-' + month + '-' + day + ' ' + time + ':' + min + ':' + sec;
  	
  	return formattedVal;
  }
$(document).ready(function () {



    $('.master_bottom_menu li').click(function(){
		var index = $('.master_bottom_menu ul li').index(this);
        $('.master_bottom_menu li:eq(' + index + ')').addClass('choice_menu');
        $('.master_bottom_menu li').not(':eq(' + index + ')').removeClass('choice_menu');
    })
    $('.master_bottom_menu_five li').click(function(){
		var index = $('.master_bottom_menu_five ul li').index(this);
        $('.master_bottom_menu_five li:eq(' + index + ')').addClass('choice_menu');
        $('.master_bottom_menu_five li').not(':eq(' + index + ')').removeClass('choice_menu');
    })

	$('.ham_menu_con .photogal').click(function(){
		var index = $('.ham_menu_con ul li').index(this);
		//console.log(index)
		$('.ham_menu_con ul li:eq( '+ index + ')').find('.photo_con_down').slideToggle();
		$(this).find('p').toggleClass('ham_open');
	})

	$('.mh_allmenu, .ham_menu_con span').click(function(){
		$('.hidden_hamburger').animate({width:'toggle'},0);
	})

	$('.ham_first_step ul li').click(function(){
		var index = $('.ham_first_step ul li').index(this);
		//console.log(index)
		$('.ham_menu_con:eq(' + index + ')').css('display', 'block');
		$('.ham_menu_con').not(':eq(' + index + ')').css('display', 'none');
	})
 
	$('.hidden_hamburger').css('display' , 'none')
    
	$('.main_top_m > li a').mouseenter(function(e){
		var depth2 = $(this).next(".depth2").clone();
		if(depth2.length!=0){
			$('.sub_top_hidden').html(depth2.html());
			$(".sub_top_hidden").stop().fadeOut("fast");
			var obj =  $(this).next();
			var hei = obj.outerHeight();
			if($(this).next("div").find("ol").length==0){
				hei = 50;
			}else{
				var li_length = 0;
				$.each($(this).next("div").find("ol"),function(index,item){
					if(li_length < $(this).find("li").length){
						li_length = $(this).find("li").length; 
					}
				});
				hei = 50+(li_length*25);
			}
			$(".sub_top_hidden").show();
			$(".sub_top_hidden").stop().animate({
				height:hei
			},{
				duration:300,
				queue:false,
				complete:function(){
					$(".sub_top_hidden").stop().fadeIn("fast");
				}
			})
		}
	})
	
	$('.sub_top_hidden').mouseenter(function(e){
		$(".sub_top_hidden").stop().fadeIn("fast");
	})
	
	$('.main_top_m, .sub_top_hidden').off("mouseleave").mouseleave(function(){
		$(".sub_top_hidden").stop().fadeOut("fast");
		$(".sub_top_hidden").stop().animate({
			height:0
		},{
			duration:300,
			queue:false,
			complete:function(){
				$(".sub_top_hidden").hide();
			}
		})
	})

  //   $('.back_sub_main').click(function(){
		// $('.hidden_banner').slideToggle();
  //   })
    

  //????????? ?????? ??? ????????? ?????????
  $(".ham_first_step > ul > li").click(function() {
		  $(".ham_first_step > ul > li").removeClass("ham_on");
		  $(this).addClass("ham_on");
		});


  // main_top_banner_toggle
  $('.maing_topbanner_arrow').click(function(){
    $('.back_sub_main').toggleClass('main_topbanner'); 
    $('.maing_topbanner_arrow').toggleClass('arrow_bottom');
  });

  // mobile top banner toggle
  $('.mobile_topbanner_arrow').click(function(){
    $('.mobile_banner').toggleClass('mobile_banner_h'); 
    $('.mobile_topbanner_arrow').toggleClass('mobile_arrow_bottom');
  });


	$( window ).resize(function() {
	   var width = $(document).width();
		if(width > 750) { 
			$('.hidden_hamburger').css('display' , 'none');	   
		}
	});

	//? ??????
	$(document).on("click",".que_icon",function() {
	  $(this).next().fadeIn();
	});

	//?????? close ?????? ?????????
	$(document).on("click",".form_close",function() {
	  $(this).parent().fadeOut();
	});

	//??????????????? ?????? ????????????
	$(document).on("change",".select_gradu",function() {
		var val_str = $(this).val();
		if( val_str == 'B1001' ) {
		  $(this).parent().nextAll(".gradu_con").slideDown();
		  $(this).parent().nextAll(".gradu_con").find("input").removeClass("nullable");
		} else {
		  $(this).parent().nextAll(".gradu_con").slideUp();
		  if(!$(this).parent().nextAll(".gradu_con").find("input").hasClass("nullable")){
			  $(this).parent().nextAll(".gradu_con").find("input").addClass("nullable");
		  }
		  $(this).parent().nextAll(".gradu_con").find("input").val("");
		}
	});


		// ????????????
	$(".check_box").click(function() {
		var c_class = $(this).attr("class");
		if (c_class.match('check_box_a')) {
			$(this).removeClass("check_box_a");
			
			if (checkedConfirm() > 0) {
				$(".ch_lg").removeClass("check_box_a");
			}
		} else {
			$(this).addClass("check_box_a");
			
			if (checkedConfirm() == 0) {
				$(".ch_lg").addClass("check_box_a");
			}
		}
	});
	
	// ??????????????????
	function checkedConfirm() {
		var falseFlg = 0;
		$.each($('.agree_box .agree_line b.check_box'), function(index, box) {
			if ($(box).hasClass('check_box_a') == false) {
				falseFlg++;
			}
		});
		return falseFlg;
	}

	// ????????????
	$(".ch_lg").click(function() {
	  var ca_class = $(this).attr("class");
	  if( ca_class.match('check_box_a') ) {
		$(".check_box, .ch_lg").removeClass("check_box_a");
	  } else {
		$(".check_box, .ch_lg").addClass("check_box_a");
	  }
	});

	//???????????? ??????
	$(".see_more").click(function() {
	  var sm_c = $(this).attr("class");
	  $(window).scrollTop(0);
	  var w_height = $("body").height();	  
	  $(".agree_pop_bk").height(w_height).show();
	  if( sm_c.match("sm1") ) {
	    $(".agree_all_01").show();
	  } else if( sm_c.match("sm2") ) {
		$(".agree_all_02").show();
	  } else {
	    $(".agree_all_03").show();
	  }
	});

	$(".agree_pop_bk").click(function() {
	  $(".agree_all").hide();
	  $(this).hide();
	});

	//???????????? ????????? ? 
	$(".file_info").click(function() {
	  $(".file_pop").fadeIn();
	});

	//???????????? ?????? ??????
	$(".apply_check").click(function() {
		  $(".apply_inp").removeAttr("disabled");
		});
	
	//???????????? ?????? ??????
	$(".apply_none").click(function() {
	  $(".apply_inp").attr("disabled","disabled");
	  $(".apply_inp").val("");
	});

	//K-Move ?????? ??????
	$(".k_move_check").click(function() {
		  $(".k_move_inp").removeAttr("disabled");
		});
	
	//K-Move ?????? ??????
	$(".k_move_none").click(function() {
	  $(".k_move_inp").attr("disabled","disabled");
	  $(".k_move_inp").val("");
	});

	//???????????? ?????? ??????
	$(".li_check").click(function() {
	  $(".li_inp").removeClass("disabled");
	});
	//???????????? ?????? ??????
	$(".li_none").click(function() {
	  $(".li_inp").addClass("disabled","disabled");
	  $(".li_inp").val("");
	});

});





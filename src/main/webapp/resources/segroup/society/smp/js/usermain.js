;(function() {

	'use strict';

	var mobileMenuOutsideClick = function() {

		$(document).click(function(e) {
			var container = $("#gtco-offcanvas, .js-gtco-nav-toggle");
			if (!container.is(e.target) && container.has(e.target).length === 0) {
				$('.js-gtco-nav-toggle').addClass('gtco-nav-white');

				if ($('body').hasClass('offcanvas')) {

					$('body').removeClass('offcanvas');
					$('.js-gtco-nav-toggle').removeClass('active');

				}


			}
		});

	};


	var formTab = function() {

		$('.tab-menu a').on('click', function(event) {
			var $this = $(this),
				data = $this.data('tab');

			$('.tab-menu li').removeClass('active');
			$this.closest('li').addClass('active')

			$('.tab .tab-content-inner').removeClass('active');
			$this.closest('.tab').find('.tab-content-inner[data-content="' + data + '"]').addClass('active');

			event.preventDefault();

		});

	};

	var offcanvasMenu = function() {

		$('#page').prepend('<div id="gtco-offcanvas" />');
		$('#page').prepend('<a href="#" class="js-gtco-nav-toggle gtco-nav-toggle gtco-nav-white"><i></i></a>');
		var clone1 = $('.menu-1 > ul').clone();
		$('#gtco-offcanvas').append(clone1);
		var clone2 = $('.menu-2 > ul').clone();
		$('#gtco-offcanvas').append(clone2);

		$('#gtco-offcanvas .has-dropdown').addClass('offcanvas-has-dropdown');
		$('#gtco-offcanvas')
			.find('li')
			.removeClass('has-dropdown');

		// Hover dropdown menu on mobile
		$('.offcanvas-has-dropdown').mouseenter(function() {
			var $this = $(this);

			$this
				.addClass('active')
				.find('ul')
				.slideDown(500, 'easeOutExpo');
		}).mouseleave(function() {

			var $this = $(this);
			$this
				.removeClass('active')
				.find('ul')
				.slideUp(500, 'easeOutExpo');
		});


		$(window).resize(function() {

			if ($('body').hasClass('offcanvas')) {

				$('body').removeClass('offcanvas');
				$('.js-gtco-nav-toggle').removeClass('active');

			}
		});
	};


	var burgerMenu = function() {

		$('body').on('click', '.js-gtco-nav-toggle', function(event) {
			var $this = $(this);


			if ($('body').hasClass('overflow offcanvas')) {
				$('body').removeClass('overflow offcanvas');
			} else {
				$('body').addClass('overflow offcanvas');
			}
			$this.toggleClass('active');
			event.preventDefault();

		});
	};



	var contentWayPoint = function() {
		var i = 0;

		// $('.gtco-section').waypoint( function( direction ) {


		$('.animate-box').waypoint(function(direction) {

			if (direction === 'down' && !$(this.element).hasClass('animated-fast')) {

				i++;

				$(this.element).addClass('item-animate');
				setTimeout(function() {

					$('body .animate-box.item-animate').each(function(k) {
						var el = $(this);
						setTimeout(function() {
							var effect = el.data('animate-effect');
							if (effect === 'fadeIn') {
								el.addClass('fadeIn animated-fast');
							} else if (effect === 'fadeInLeft') {
								el.addClass('fadeInLeft animated-fast');
							} else if (effect === 'fadeInRight') {
								el.addClass('fadeInRight animated-fast');
							} else {
								el.addClass('fadeInUp animated-fast');
							}

							el.removeClass('item-animate');
						}, k * 200, 'easeInOutExpo');
					});

				}, 100);

			}

		}, {
			offset : '85%'
		});
	// }, { offset: '90%'} );
	};


	var dropdown = function() {

		$('.has-dropdown').mouseenter(function() {

			var $this = $(this);
			$this
				.find('.dropdown')
				.css('display', 'block')
				.addClass('animated-fast fadeInUpMenu');

		}).mouseleave(function() {
			var $this = $(this);

			$this
				.find('.dropdown')
				.css('display', 'none')
				.removeClass('animated-fast fadeInUpMenu');
		});

	};


	var owlCarousel = function() {

		var owl = $('.owl-carousel-carousel');
		owl.owlCarousel({
			items : 3,
			loop : true,
			margin : 20,
			nav : true,
			dots : true,
			smartSpeed : 800,
			autoHeight : true,
			navText : [
				"<i class='ti-arrow-left owl-direction'></i>",
				"<i class='ti-arrow-right owl-direction'></i>"
			],
			responsive : {
				0 : {
					items : 1
				},
				600 : {
					items : 2
				},
				1000 : {
					items : 3
				}
			}
		});


		var owl = $('.owl-carousel-fullwidth');
		owl.owlCarousel({
			items : 1,
			loop : true,
			margin : 20,
			nav : true,
			dots : true,
			smartSpeed : 800,
			autoHeight : true,
			navText : [
				"<i class='ti-arrow-left owl-direction'></i>",
				"<i class='ti-arrow-right owl-direction'></i>"
			]
		});




	};



	var goToTop = function() {

		$('.js-gotop').on('click', function(event) {

			event.preventDefault();

			$('html, body').animate({
				scrollTop : $('html').offset().top
			}, 500, 'easeInOutExpo');

			return false;
		});

		$(window).scroll(function() {

			var $win = $(window);
			if ($win.scrollTop() > 200) {
				$('.js-top').addClass('active');
			} else {
				$('.js-top').removeClass('active');
			}

		});

	};


	// Loading page
	var loaderPage = function() {
		$(".gtco-loader").fadeOut("slow");
	};

	var counter = function() {
		$('.js-counter').countTo({
			formatter : function(value, options) {
				return value.toFixed(options.decimals);
			},
		});
	};

	var counterWayPoint = function() {
		if ($('#gtco-counter').length > 0) {
			$('#gtco-counter').waypoint(function(direction) {

				if (direction === 'down' && !$(this.element).hasClass('animated')) {
					setTimeout(counter, 400);
					$(this.element).addClass('animated');
				}
			}, {
				offset : '90%'
			});
		}
	};


	$(function() {
		mobileMenuOutsideClick();
		formTab();
		offcanvasMenu();
		burgerMenu();
		contentWayPoint();
		dropdown();
		owlCarousel();
		goToTop();
		loaderPage();
		counterWayPoint();
		getNotice();
		getMainPageBoard();
	});
	/**
	 * @Method Name : getMainPageBoard
	 * @Date : 2018. 9. 05.
	 * @User : 여명환
	 * @Param : User의 gisu_seq
	 * @Return : 사용자의 기수에 해당하는 일정 공지
	 * @Method 설명 : 
	 */
	
	var getMainPageBoard = function() { //일정 공지 가져오기
		var schedule = document.getElementById("board");

		$.ajax({
			type : "post",
			url : "/smp/get_specific_user_gisu", //로그인한 사용자의 gisu_seq 정보 조회
			success : function(gisu_info) {
				$.ajax({
					type : "post",
					url : "/smp/user/get_mainpage_board",
					data : {
						'gisu_seq' : gisu_info.gisu_seq
					},
					dataType : 'json',
					success : function(result) {
						drawBoardList(result);
						
					}
				});
			},
			error : function(data) {
				$("#board").html("");
			}
		});

	}
	function drawBoardList(result){ //해당 gisu_seq에 해당하는 일정 정보 출력
		var event;
		var script = "<ul>";
		
		for(var i in result){
			event = {
				title : result[i].board_content_title, //공지제목
				date : result[i].board_content_udt_dt, //공지 날짜
			};
			script+='<li><span class="board-span-title">' + event.title + '</span><span style="display: block; float: right;">'+ event.date + '</span></li>';
		}
		script+= '</ul>';
		$("#board").html(script);
	}
	/**
	 * @Method Name : getNotice
	 * @Date : 2018. 8. 31.
	 * @User : 김진환
	 * @Param : User의 gisu_seq
	 * @Return : 사용자의 기수에 해당하는 일정 공지
	 * @Method 설명 : 
	 */
	
	var getNotice = function() { //일정 공지 가져오기
		var schedule = document.getElementById("schedule");

		$.ajax({
			type : "post",
			url : "/smp/get_specific_user_gisu", //로그인한 사용자의 gisu_seq 정보 조회
			success : function(gisu_info) {
				$("#gisu_num").html(gisu_info.gisu_num+"기");
				$.ajax({
					type : "post",
					url : "/smp/selectAll",
					data : {
						'gisu_seq' : gisu_info.gisu_seq
					},
					dataType : 'json',
					success : function(result) {
						eventList(result);
						
					}
				});
			},
			error : function(data) {
				$("#schedule").html("");
			}
		});

	}

	function eventList(result){ //해당 gisu_seq에 해당하는 일정 정보 출력
		var eventData = [];
		var event;
		var script = "<ul>";
		var today = new Date();
		  var mm = today.getMonth()+1; 
		  var yyyy = today.getFullYear();
		  if(mm<10) {
		      mm='0'+mm
		  } 
		  today = yyyy+'-'+mm;
		var monthEvent = [];
		for(var i in result){
			event = {
				title : result[i].smp_sch_ct,    				//이벤트 제목
				start : result[i].smp_sch_st, 					//이벤트 시작일
				end : result[i].smp_sch_et, 					//이벤트 종료일 smp_sch_et
				smp_sch_seq : result[i].smp_sch_seq, 			//이벤트 번호
				smp_sch_title : result[i].smp_sch_title, 		//이벤트 과목
				gisu_seq : result[i].gisu_seq, 					//기수
				smp_sch_ins_id : result[i].smp_sch_ins_id,		//이벤트 등록인
				smp_sch_ins_dt : result[i].smp_sch_ins_dt,		//이벤트 등록날짜
				smp_sch_udt_id : result[i].smp_sch_udt_id,		//이벤트 수정인
				smp_sch_udt_dt : result[i].smp_sch_udt_dt,		//이벤트 수정 날짜
			};
			
			script+='<li><span class="title_1"><a href="' + '#' + '">' + event.title + '</a></span><span class="time">'+ event.start +  ' ~ ' + event.end + '</span></li>';
			
			
		}
		script+= '</ul>';
		$("#schedule").html(script);
	}



}());


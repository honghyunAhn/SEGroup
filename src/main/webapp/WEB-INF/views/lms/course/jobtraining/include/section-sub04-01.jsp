<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>     
<!DOCTYPE html>
<html lang="ko">

<script src="<c:url value="/resources/lms/js/jquery3.4.1.js" />"></script>
<!-- Pagination을 위한 js -->
<script type="text/javascript" src="/resources/js/jquery.twbsPagination.js"></script>

<script>

	$(function(){
		



		//페이징 처리를 위한 카테고리 설정 임시 변수
		var tmp_cate = "";
		var tmp_parent_cate = "";
		
		
		
		//과정리스트 가져오기 끝		
		function getCourseList(parent_cate_opt, cate_opt, search, display_list){

			var startPage = $('#startPage').val();
			
			$.ajax({
				contentType : "application/json",
				dataType : "json",
				type	: "get",
				url		: "/lms/course/selectBoard",
				data    : {
					"grand" : "취업연계",
					"parent_category_opt" : parent_cate_opt,
					"category_opt" : cate_opt,
					"search" : search,
					"startPage" : startPage,
					"display_list" : display_list
				},
				success	: function(data) {

					var content = "";
	
					$.each(data, function(index, courseList){
						
						content += '<li class="class-list cl0' + (index + 1) + ' load-sub04-01-01">';
						content +=		'<div class="c-ttl subject">';
						content += 			'<a class="courseDetail">';
						/* alt에 원본명을 넣으려 하였으나, 원본명이 db에 저장되지 않음. 경로에 대한 확인 필요 */
						content += 				'<img src="' + courseList.photo_url + '" alt="' + courseList.name + '" class="c-img">';
						/* alt에 원본명을 넣으려 하였으나, 원본명이 db에 저장되지 않음. */
						content += 					'<div class="class-title-wrap">';
						content += 						'<div class="filterWrap d-flex">';


						/* 아이콘 표시를 위한 forEach문 시작 */						
						if(courseList.icon_displays!=null){

							var display_icon = courseList.icon_displays.split(',');

							$.each(display_icon, function(index, display){
							if(display=='1'){
							content += 							'<div class="filter new">신규</div>';								
							} else if(display=='2'){
							content += 							'<div class="filter recommend">추천</div>';							
							} else if(display=='3'){
							content += 							'<div class="filter popular">인기</div>';							
							} else if(display=='4'){
							content += 							'<div class="filter book">교재</div>';							
							} else if(display=='5'){
							content += 							'<div class="filter sale">할인</div>';
							}
							});
						} else {
							content += 							'<div class="nothing"></div>';							
						}
						/* 아이콘 표시를 위한 forEach문 끝 */

						
						content += 						'</div>';
						content += 						'<div class="fz16 text-over txt-ov-2" data-value="' + courseList.course_id + '">' + courseList.name + '</div>';
						content += 					'</div>';
						content += 			'</a>';
						content += 		'</div>';
						content += 		'<div class="c-ctt c-price">';
						content += 			'<div class="tableWrap">';
						content += 				'<span class="h5 mobile-show-ttl">교육비</span>';

						if(courseList.price != 0){
							content += 				'<p class="classPrice" data-value="' + courseList.price + '">' + courseList.price.toLocaleString('en') + '원</p>';							
						} else {							
							content += 				'<p class="classPrice" data-value="' + courseList.price + '">무료</p>';							
						}

						
						/* todo -> 할인 금액에 대한 처리가 필요함 */
/* 						content += 				'<p class="fz16 discountPrice">할인금액처리</p>';  */
						/* 						할인금액에 대한 정보 */
						content += 			'</div>';
						content += 		'</div>';
						content += 		'<div class="c-ctt learnPeriod">';
						content += 			'<span class="h5 mobile-show-ttl">학습기간</span>';

						/* 학습기간에 대한 처리가 필요함 */						
						content += 			'<p class="fz16 term" data-value="'+ courseList.selp_period +'">' + courseList.selp_period +'일</p>'; 
						/* 학습기간에 대한 처리가 필요함 */						
						
						content += 		'</div>';
						
						if(courseList.tasting_url){
							content += 		'<form id="oneplayform'+index+'" action="/lms/user/oneplayer" method="post" target="_blank">';
							content += 		'<input type="hidden" name="url" value="'+ courseList.tasting_url +'">';
							content += 		'<div class="c-ctt"><a class="button btn-wh" onclick="document.getElementById(\'oneplayform'+index+'\').submit();">';
							content += 			'<div class="img-icon tv"></div>';
							content += 			'<span class="h5">맛보기</span>';
							content += 		'</a></div>';
							content += 		'</form>';
						}else{
							content += 		'<div class="c-ctt"><a class="button btn-wh" onclick="alert(\'맛보기가 설정되어 있지 않습니다.\')">';
							content += 			'<div class="img-icon tv"></div>';
							content += 			'<span class="h5">맛보기</span>';
							content += 		'</a></div>';
						}
						
						content += 		'<div class="c-ctt"><a class="button btn-pColor modal-popup">';
						content += 			'<div class="img-icon hand-point-up"></div>';						
						content += 			'<span class="h5">수강신청</span>';
						content += 		'</a></div>';
						content += '</li>';

					});

					//가져온 결과값이 없으면 검색결과가 없습니다를 출력한다.
					if(content==""){
						content += '<li class="align-middle text-center"><div>검색결과가 없습니다.</div></li>';						
					}
					
					$('.class-list-wrap.load-data').html(content);


					//뿌려주고 나서는 해당 페이지 내의 검색을 위한 세팅을 해주어야 한다.
					$('#category_opt').val(parent_cate_opt);
					$('#parent_category_opt').val(cate_opt);

					
					
					$('.courseDetail').on('click', function(){

						var course_id = $(this).children('.class-title-wrap').children('.fz16').attr('data-value');
						document.location.href = "/lms/course/jobtraining/sub04-01-01-01?course_id=" + course_id;

					});
					
					
					/* ---------------------------------------------------모달작업--------------------------------------------------- */
				    // modal-popup layer
				    $('.modal-popup').click(function() {

				    	/* 팝업정보 세팅 */				    	
				    	var classNm = $(this).parent().parent().children('.subject').children().children('.class-title-wrap').children('.fz16').html();
				    	var courseId = $(this).parent().parent().children('.subject').children().children('.class-title-wrap').children('.fz16').attr('data-value');
				    	var classPrice = $(this).parent().parent().children('.c-price').children('.tableWrap').children('.classPrice').html();
				    	var realPrice = $(this).parent().parent().children('.c-price').children('.tableWrap').children('.classPrice').attr('data-value');
/* 				    	var discountPrice = $(this).parent().parent().children('.c-price').children('.tableWrap').children('.discountPrice').html(); */
				    	var learnPeriod =  $(this).parent().parent().children('.learnPeriod').children('.term').attr('data-value');				    	
				    	
				    	
				    	/*결재정보 세팅*/
				    	$.ajax({
							contentType : "application/json",
							dataType : "json",
							type	: "get",
							url		: "/lms/course/makesignature",
							data    : {
										price:realPrice
									  },
							success	: function(data) {
								$('input[name$="price"]').val(realPrice);	
								$('input[name$="goodname"]').val(classNm);
								$('input[name$="mid"]').val(data.mid);
								$('input[name$="oid"]').val(data.oid);
								
							}
						});
				    	
				    	
				    	var user_id = '${sessionScope.user_id}';
				    	
				    	if(user_id==''||user_id==null){
				    		alert('로그인이 필요합니다.');
							document.location.href = "/lms/user/sub00-01";
				    		return;
				    	}

						//유저 정보 가져오
						$.ajax({
							contentType : "application/json",
							dataType : "json",
							type	: "get",
							url		: "/lms/course/getUserInfo",
							data    : {
								"user_id" : user_id
							},
							success	: function(userInfo) {

								//-----------------모달 기본 정보 세팅--------------------//
								$('.class-name').html(classNm);
								$('.class-price').html(classPrice);
								$('.class-id').val(courseId);								
								$('.class-term').val(learnPeriod);
								
								$('.class-pay-price').attr('data-value', realPrice);																		
								$('.class-pay-price').html(classPrice);																		
/* 								if(discountPrice.isNaN || discountPrice == '0'){
									$('.class-pay-price').html(classPrice);																		
								} else{
									$('.class-pay-price').html(discountPrice);									
								} */
								//-----------------모달 기본 정보 세팅--------------------//
						        $('.user_name').html(userInfo.user_nm);
						        $('#signNm').html(userInfo.user_nm);
								$('.user_birth').html(userInfo.user_birth);
								
								//------------------모달에 회원정보 불러오기-------------------//
								$('#getMyInfo').on('click', function(){
									/* 모달 내의 정보를 띄우는 세팅 */

/* 									모달에 성별표시 안하기로 결정
									if(userInfo.user_sex=='A0000'){
										$("input:radio[name='user_sex']:radio[value='A0000']").prop("checked",true);		
									} else{
										$("input:radio[name='user_sex']:radio[value='A0001']").prop("checked",true);		
							        } */
									
							        $('.user_email').val(userInfo.user_email);
							        $('.user_phone').val(userInfo.user_phone.replace(/(\d{3})(\d{4})(\d{4})/, '$1-$2-$3'));											        
									$('.user_belong_to').val(userInfo.user_belong_to);
							        
							        
						        	$('#post_code').val(userInfo.user_zipcode);
						        	$('#addr1').val(userInfo.user_addr1);
									$('#addr2').val(userInfo.user_addr2);

								});
								//------------------모달에 회원정보 불러오기-------------------//

								getPointInfo(user_id);
								getCardinalInfo(courseId, learnPeriod);
								

							},
							error	: function(request, status, error) {
								alert("code : "+request.status+"\n\n"+"message : "+request.responseText+"\n\n"+"error : "+error);
							}						
						});
					
						
												
					
				    	// 모달 열기
				        $('html, body').addClass("not-scroll");

				        

				        /* 모달 내의 정보를 띄우는 세팅 끝*/
				        
				        
				        $('.modal').show()

				        // 모달 >> 탭 기능
				        var $modaltab = $('.section div.class-tabMenu>.modal-tabGroup>li'),
				            $modalsub = $('.section div.class-tabMenu>.modal-subGroup>div'),
				            i = 0;

				        $modaltab.on('click', function() {
				            i = $(this).index();
				            console.log(i);
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
				        $('#agree01').prop('checked', false);
				        $('#agree02').prop('checked', false);				        
				        $('.modal').hide();

				        //모달 닫으면 기존 탭 활성화 초기화(index 0 = active)
				        $('.section .tabGroup>li:first').addClass('active');
				        $('.section .subGroup>div:first').show();
				        //모달 닫으면 기존 탭 활성화 초기화(index 0 = active) 끝
				    });
				    //modal-popup layer 끝					
					/* ---------------------------------------------------모달작업--------------------------------------------------- */
					
					
					
					/*	페이징 처리를 위한 함수호출 */
					pagingFunc(parent_cate_opt, cate_opt, search, display_list);

					
					
					
				},
				error	: function(request, status, error) {
					//alert("code : "+request.status+"\n\n"+"message : "+request.responseText+"\n\n"+"error : "+error);
				}
				
			});

		}
		//과정리스트 가져오기 끝

		$('.parent_category').on('click', function(){
	    	var parent_category_opt = $(this).attr('data-value');
	    	
	    	
	    	$('#division_menu').html(parent_category_opt);
 			$('#pagination').twbsPagination('destroy');		 
			getCourseList(parent_category_opt, "", "", "");
			tmp_parent_cate = parent_category_opt;
			tmp_cate = "";
		});		
		
		$('.category').on('click', function(){
	    	var category_opt = $(this).attr('data-value');
 			$('#pagination').twbsPagination('destroy');		 
	    	getCourseList("", category_opt, "","");
			tmp_cate = category_opt;
			tmp_parent_cate = "";	
		});		

		
		$('#searchBtn').on('click', function(){
 			$('#pagination').twbsPagination('destroy');		 

     		$('#startPage').val('1');                	
			var category_opt = $('#category_opt').val();
			var parent_category_opt = $('#parent_category_opt').val();
			
			var search = $('#keyWord').val();
			
			
			
			var icon_array = new Array();
			//검색버튼 위의 라디오 버튼 체크 여부 확인
			if($('input:checkbox[id="filter-new"]').is(":checked")){
				 icon_array.push('1');	
			}
			if($('input:checkbox[id="filter-recommend"]').is(":checked")){
				 icon_array.push('2');	
			}
			if($('input:checkbox[id="filter-popular"]').is(":checked")){
				 icon_array.push('3');	
			}
			if($('input:checkbox[id="filter-book"]').is(":checked")){
				 icon_array.push('4');	
			}
			if($('input:checkbox[id="filter-sale"]').is(":checked")){
				 icon_array.push('5');	
			}
			
			var display_list = "";
			for(var i = 0; i < icon_array.length; i++){
				display_list += icon_array[i];
				if(i!=icon_array.length-1){
					display_list += ",";
				}				
			}
			
			
			
			getCourseList(category_opt,parent_category_opt, search, display_list);
			
		});

		
		function pagingFunc(parent_cate_opt, cate_opt, search, display_list){

			var startPage = $('#startPage').val();
					

			$.ajax({
				contentType : "application/json",
				dataType : "json",
				type	: "get",
				url		: "/lms/course/pageInfo",
				data    : {
					"grand" : "취업연계",
					"parent_category_opt" : parent_cate_opt,
					"category_opt" : cate_opt,
					"search" : search,				
					"startPage" : startPage,
					"display_list" : display_list
				},
				success	: function(data) {

					var totalPages = data.totalPages;
					var visiblePages = data.visiblePages;
					var startPage = Number(data.startPage) + 1;

					pagination(totalPages, visiblePages, startPage);
					
					
				},
				error	: function(request, status, error) {
					alert("code : "+request.status+"\n\n"+"message : "+request.responseText+"\n\n"+"error : "+error);
				}						
			});
			
			
			
			
			
		}
		
		function pagination(totalPages, visiblePages, startPage){

			if(totalPages != 0 && totalPages != null){
		    	$('#pagination').twbsPagination({
			        totalPages: totalPages,
			        visiblePages: visiblePages,
			        startPage: startPage,
			        first : "",
 			        prev : '<a href="#" class="prev"><div class="img-icon angle-left floatL"></div>PREV</a>',
					next : '<a href="#" class="next"><div class="img-icon angle-right floatR"></div>NEXT</a>',
/* 
					prev : "«",
					next : "»",
 */
					last : "",
					
					
			        initiateStartPageClick : false,
			        onPageClick: function (event, page) {
			            $('#startPage').val(page);

			            var category_opt = tmp_cate;
						var parent_category_opt = tmp_parent_cate;
						var search = $('#keyWord').val();
				    	
 						var icon_array = new Array();
						//검색버튼 위의 라디오 버튼 체크 여부 확인
						if($('input:checkbox[id="filter-new"]').is(":checked")){
							 icon_array.push('1');	
						}
						if($('input:checkbox[id="filter-recommend"]').is(":checked")){
							 icon_array.push('2');	
						}
						if($('input:checkbox[id="filter-popular"]').is(":checked")){
							 icon_array.push('3');	
						}
						if($('input:checkbox[id="filter-book"]').is(":checked")){
							 icon_array.push('4');	
						}
						if($('input:checkbox[id="filter-sale"]').is(":checked")){
							 icon_array.push('5');	
						}
						
						var display_list = "";
						for(var i = 0; i < icon_array.length; i++){
							display_list += icon_array[i];
							if(i!=icon_array.length-1){
								display_list += ",";
							}				
						} 
						
						getCourseList(parent_category_opt, category_opt, search, display_list);
			            
			        }
		    	});
		 	};
		 	
		 	//pagination css 포맷에 맞게 설정하는 작업		
		 	$('.page-item').children().addClass('num');
			$('.page-item.active').children().addClass('active'); 
/* 		 	if(startPage=="1"){
 		 	 	$(".num:contains('1')").trigger("click");
	 	 	}		 	 */

		}

		
		
		function getCardinalInfo(course_id, selp_period){
						
			$.ajax({
				contentType : "application/json",
				dataType : "json",
				type	: "get",
				url		: "/lms/course/getCardinalInfo",
				data    : {
					"course_id" : course_id
				},
				success	: function(validCardinals) {

					var app_comments = "";
					app_comments += "<select class='select' id='cardinals_selectbox' style='width:200px;'>";
					app_comments += "<option value='app_date_title'>신청기간 선택</option>";

        			/* ----------오늘 날짜 정보---------- */
					var today = new Date();   
					var year = today.getFullYear(); // 년도
					var month = today.getMonth() + 1;  // 월
					var date = today.getDate();  // 날짜

					var todayInfo = year + "-" + month + "-" + date;
					
					if(validCardinals!=null&&validCardinals!=""){
						validCardinals.forEach(function(item){
    						app_comments += "<option class='app_date_list' value='" + item.id + "'>" + item.app_start_date + " ~ " + item.app_end_date + "</option>";
						});
					} else {
						/* ----------오늘 날짜 정보---------- */
/*     						var today = new Date();   
						var year = today.getFullYear(); // 년도
						var month = today.getMonth() + 1;  // 월
						var date = today.getDate();  // 날짜

						var todayInfo = year + "-" + month + "-" + date; */
						/* ----------오늘 날짜 정보---------- */
						
						/* ----------신청일 계산---------- */						
						var day = today.getDay();  // 요일
						var subDay;
						switch(day){
						case 1: subDay = 0; break;
						case 2: subDay = 1; break;
						case 3: subDay = 2; break;
						case 4: subDay = 3; break;
						case 5: subDay = 4; break;
						case 6: subDay = 5; break;						
						case 0: subDay = 6;
						}
						/* ----------신청일 계산---------- */						

						/* ----------신청일---------- */						
						var appStartDay = new Date();   
						appStartDay.setDate(appStartDay.getDate() - Number(subDay));						
						var appStartYear = appStartDay.getFullYear();
						var appStartMonth = appStartDay.getMonth() + 1;
						var appStartD = appStartDay.getDate();
						var appStartDayInfo = appStartYear + "-" + appStartMonth + "-" + appStartD;
						/* ----------신청일---------- */						

						/* ----------수강마감일---------- */												
						var appEndDay = new Date();   
						appEndDay.setDate(appEndDay.getDate() - Number(subDay) + 6);						
						var appEndYear = appEndDay.getFullYear();
						var appEndMonth = appEndDay.getMonth() + 1;
						var appEndD = appEndDay.getDate();						
						var appEndDayInfo = appEndYear + "-" + appEndMonth + "-" + appEndD;
						/* ----------수강마감일---------- */												
						
						app_comments += "<option class='app_date_list' value='none'>" + appStartDayInfo + " ~ " + appEndDayInfo + "</option>";
						
					}
					
					$('#modal_app_days').html(app_comments);    					
							            
		            $('#modal_app_days').on('change', function(){
		            	var selectedApp = $("option:selected", this).val();
		            	setLearnDates(selectedApp, validCardinals, selp_period);    
		            	
		            	/*결재날짜 갱신*/
						$('input[name$="offerPeriod"]').val($("option:selected", this).val());
		            	
		            });
		            

					
				},
				error	: function(request, status, error) {
					alert("code : "+request.status+"\n\n"+"message : "+request.responseText+"\n\n"+"error : "+error);
				}						
			});
		};
		
    	function setLearnDates(select_val, validCardinals, selp_period){

			var comments = "";
			var learn_input = '#modal_learn_days';

			/* ----------오늘 날짜 정보---------- */
			var today = new Date();   
			var year = today.getFullYear(); // 년도
			var month = today.getMonth() + 1;  // 월
			var date = today.getDate();  // 날짜

			var todayInfo = year + "-" + month + "-" + date;
			/* ----------오늘 날짜 정보---------- */
			
    		if(select_val=='app_date_title'){
    			$(learn_input).html("신청기간을 선택해주세요.");
				return;
    		} else if(select_val!='none'){
				validCardinals.forEach(function(item){
					if(item.id==select_val){
						comments += todayInfo + " ~ " + item.learn_end_date;
					}
				});

    		} else {

				
				/* ----------수강시작일-오늘날짜---------- */						
				var day = today.getDay();  // 요일
				var addDay;
				switch(day){
				case 1: addDay = 7; break;
				case 2: addDay = 6; break;
				case 3: addDay = 5; break;
				case 4: addDay = 4; break;
				case 5: addDay = 3; break;
				case 6: addDay = 2; break;						
				case 0: addDay = 1;
				}
				/* ----------수강시작일-오늘날짜---------- */						

				/* ----------수강시작일---------- */						
				var learnStartDay = new Date();   
				learnStartDay.setDate(learnStartDay.getDate() + Number(addDay) - 7);						
				var learnStartYear = learnStartDay.getFullYear();
				var learnStartMonth = learnStartDay.getMonth() + 1;
				var learnStartD = learnStartDay.getDate();
				var learnStartDayInfo = learnStartYear + "-" + learnStartMonth + "-" + learnStartD;
				/* ----------수강시작일---------- */						

				/* ----------수강끝난일---------- */												
				var endDay = new Date();   
				endDay.setDate(endDay.getDate() + Number(addDay) + (Number(selp_period) - 1) );						
				var endYear = endDay.getFullYear();
				var endMonth = endDay.getMonth() + 1;
				var endD = endDay.getDate();						
				var endDayInfo = endYear + "-" + endMonth + "-" + endD;
				/* ----------수강끝난일---------- */												
				
				comments += todayInfo + " ~ " + endDayInfo;
			}

			$(learn_input).html(comments);
    			
    	}		
		
    	function getPointInfo(user_id){

			$.ajax({
				contentType : "application/json",
				dataType : "json",
				type	: "get",
				url		: "/lms/course/getPointInfo",
				data    : {
					"user_id" : user_id
				},
				success	: function(userPoint) {
					$('.user_point').attr('data-value', userPoint.BALANCE);
					$('.user_point').html(userPoint.BALANCE.toLocaleString('en'));
				},
				error	: function(request, status, error) {
					alert("code : "+request.status+"\n\n"+"message : "+request.responseText+"\n\n"+"error : "+error);
				}						
			});    		
    		
    	}
		
		
		
		
		
		
		
    	//이곳이 사용되는 이유는 다음과 같다.
    	//header에서 외국어 하위 탭에서 과목을 선택할 경우
    	//과정상세페이지에서 leftmenu의 과목을 선택할 경우
    	//ajax 페이징처리와 별개로 페이지가 이동하는 경우에 해당되므로, 이와 같은 코드로 해결

    	var parent_menu = "${parent_menu}";
		var son_menu = "${son_menu}";

		if(parent_menu!=''&&parent_menu!=null){
			$('[data-value="' + parent_menu + '"]').trigger('click');		
		} else if(son_menu!=''&&son_menu!=null){
			$('[data-value="' + son_menu + '"]').trigger('click');		
    	} else {
    		//화면 첫 로드시에 전체 과정 리스트를 출력
    		getCourseList();
    	}
				

		

	});

</script>

<body>
        <!-- 과정명 검색 -->
        <div class="searchWrapper">
        <div class="class-searchWrap floatR">
            <form class="">
                <!-- 조건 선택 필터 / 목록 갯수 설정 -->
                <div class="filter-view-wrap d-flex">
                    <!-- 조건 선택 필터 -->
                    <div class="filterWrap">
                        <h5 class="h5">조건 선택</h5>
                        <ul class="filters d-flex" id="filters">
                            <li>
                                <input type="checkbox" value="new" id="filter-new">
                                <label class="label new" for="filter-new">신규</label>
                            </li>
                            <li>
                                <input type="checkbox" value="recommend" id="filter-recommend">
                                <label class="label recommend" for="filter-recommend">추천</label>
                            </li>
                            <li>
                                <input type="checkbox" value="popular" id="filter-popular">
                                <label class="label popular" for="filter-popular">인기</label>
                            </li>
                            <li>
                                <input type="checkbox" value="book" id="filter-book">
                                <label class="label book" for="filter-book">교재</label>
                            </li>
                            <li>
                                <input type="checkbox" value="sale" id="filter-sale">
                                <label class="label sale" for="filter-sale">할인</label>
                            </li>
                        </ul>
                    </div>
                </div>
                <div class="d-flex floatR">
                    <!-- <div class="search-filter-wrap">
                        <select name="search-filter" id="search-filter">
                            <option value="ttl" selected>제목+내용</option>
                            <option value="ttl">제목</option>
                            <option value="ctt">내용</option>
                        </select>
                    </div> -->
                    <div class="class-search-down d-flex">
                        <input type="text" class="cusPHIn input" id="keyWord" value="${param.search}" placeholder="검색어를 입력해주세요.">
                        <input type="hidden" id="parent_category_opt" value="${parent_category_opt}">
                        <input type="hidden" id="category_opt" value="${category_opt}">                         
                        <c:if test="${startpage != '' && startpag != null}">
	                        <input type="hidden" id="startPage" name="startPage" value="${startPage}">
                        </c:if>
                        <c:if test="${startpage == '' || startpag == null}">
	                        <input type="hidden" id="startPage" name="startPage" value="1">
                        </c:if>



                        <!-- 검색버튼 -->
                        <button type="button" class="button btn-wh img-icon search" id="searchBtn">

                        </button>
                    </div>
                </div>
                <!--<div class="viewWrap">
                    <select name="view-class" id="view-class">
                    <option value="10v" selected>10개씩 보기</option>
                    <option value="20v">20개씩 보기</option>
                    <option value="30v">30개씩 보기</option>
                    <option value="40v">40개씩 보기</option>
                    <option value="50v">50개씩 보기</option>
                    </select>
                </div> -->
            </form>
        </div>
        </div>

        <!-- 과정목록 -->
        <div class="class-listWrap">
            <!-- c-name을 제외한 나머지 li의 width값 123px * height80px -->
            <!-- 과정목록 : 제목 -->
            <ul class="class-list-title d-flex">
                <li class="c-name fz16">과정명</li>
                <li class="c-ctt fz16">교육비</li>
                <li class="c-ctt fz16">학습기간</li>
                <li class="c-ctt fz16">맛보기</li>
                <li class="c-ctt fz16">수강신청</li>
            </ul>
            <!-- 과정목록 : 내용
                - 목록 추가시 li.cl0$ 추가
                - 하위카테고리 분류하여 li에클래스로 지정 : C0$-0$-0$)
            -->
            <ul class="class-list-wrap load-data">
            
            <!-- 컨텐츠 뿌리는 위치 -->
            
<!--             
                외국어-영어-문법/어휘 c02-01-01
                <li class="class-list cl01 load-sub02-01-01">
                    <div class="c-ttl">
                        <a href="sub02-01-01-01.html">
                            <img src="img/c-img_02-01-01-01.jpg" alt="세상에서 가장 쉬운 영단어 Step 1" class="c-img">
                            <div class="class-title-wrap">
                                <div class="filterWrap d-flex">
                                    <div class="new">신규</div>
                                    <div class="recommend">추천</div>
                                    <div class="popular">인기</div>
                                    <div class="book">교재</div>
                                    <div class="sale">할인</div>
                                </div>
                                <div class="fz16 text-over txt-ov-2">세상에서 가장 쉬운 영단어 Step 1</div>
                            </div>
                        </a>
                    </div>
                    <div class="c-ctt c-price">
                        <div class="tableWrap">
                            <span class="h5 mobile-show-ttl">교육비</span>
                            <p class="del">90,000</p>
                            <p class="fz16">73,500</p>
                        </div>
                    </div>
                    <div class="c-ctt">
                        <span class="h5 mobile-show-ttl">학습기간</span>
                        <p class="fz16 term">1개월</p>
                    </div>
                    <div class="c-ctt"><a href="http://www.pub365.co.kr/vod/_genie/_sample/easy_word/01/001.htm" class="button btn-wh" target="_blank">
                            <div class="img-icon tv"></div>
                            <span class="h5">맛보기</span>
                        </a></div>
                    <div class="c-ctt"><a class="button btn-pColor modal-popup">
                            <div class="img-icon hand-point-up"></div>
                            <span class="h5">수강신청</span>
                        </a></div>
                </li>
                <li class="class-list cl02 load-sub02-01-01">
                    <div class="c-ttl">
                        <a href="#">
                            <img src="img/c-img_02-01-01-01.jpg" alt="세상에서 가장 쉬운 영단어 Step 2" class="c-img">
                            <div class="class-title-wrap">
                                <div class="filterWrap d-flex">
                                    <div class="new">신규</div>
                                    <div class="recommend">추천</div>
                                    <div class="popular">인기</div>
                                    <div class="book">교재</div>
                                    <div class="sale">할인</div>
                                </div>
                                <div class="fz16 text-over txt-ov-2">세상에서 가장 쉬운 영단어 Step 2</div>
                            </div>
                        </a>
                    </div>
                    <div class="c-ctt c-price">
                        <div class="tableWrap">
                            <span class="h5 mobile-show-ttl">교육비</span>
                            <p class="del"></p>
                            <p class="fz16">-</p>
                        </div>
                    </div>
                    <div class="c-ctt">
                        <span class="h5 mobile-show-ttl">학습기간</span>
                        <p class="fz16 term">1개월</p>
                    </div>
                    <div class="c-ctt"><a href="http://www.pub365.co.kr/vod/_genie/_sample/easy_word/26/001.htm" class="button btn-wh" target="_blank">
                            <div class="img-icon tv"></div>
                            <span class="h5">맛보기</span>
                        </a></div>
                    <div class="c-ctt"><a class="button btn-pColor modal-popup">
                            <div class="img-icon hand-point-up"></div>
                            <span class="h5">수강신청</span>
                        </a></div>
                </li>
 --> 
            </ul>
        </div>
    <div class="modal">
        <div class="modal-layer"></div>
        <div class="modal-content">
            <!-- modal 수강신청 1단계 include -->
              <%@include file="../../modal/modal-sub02-01-01.jsp"%>
        </div>
        <div class="modal-content" style="display:none">
            <!-- modal 수강신청 1단계 include -->
              <%@include file="../../modal/modal-sub02-01-02.jsp"%>
        </div>
        <div class="modal-content" style="display:none">
            <!-- modal 수강신청 1단계 include -->
              <%@include file="../../modal/modal-sub02-01-03.jsp"%>
        </div>
        <div class="modal-content" style="display:none">
            <!-- modal 수강신청 1단계 include -->
              <%@include file="../../modal/modal-sub02-01-04.jsp"%>
        </div>
    </div>
</body>

</html>

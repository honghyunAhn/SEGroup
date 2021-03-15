<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>    
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Soft Engineer Society</title>
    <link rel="stylesheet" type="text/css" href="<c:url value="/resources/lms/css/img-icon.css" />">
    <link rel="stylesheet" type="text/css" href="<c:url value="/resources/lms/css/style.css" />">
    <link rel="stylesheet" type="text/css" href="<c:url value="/resources/lms/css/style_responsive.css" />">
    <script src="<c:url value="/resources/lms/js/jquery-3.3.1.min.js" />"></script>
<%--     <script src="<c:url value="/resources/lms/js/common.js" />"></script> --%>
    <script type="text/javascript">
        $(function() {
            //서브 페이지 네비
            // .sub-nav .lnb>a의 클래스가 sub02-01이면
            // .menu-sub a의 클래스가 sub02-01-0$이면
            
            var icon_displays = "${courseInfo.icon_displays}";
			var target_types = "${courseInfo.target_types}";
            init(icon_displays, target_types);
            
            
            var course_id = "${courseInfo.id}";
            var selp_period = "${courseInfo.selp_period}";
            getCardinalInfo(course_id, selp_period, 'page_show');	            
            
            

            
            $(document).ready(function() {
                var location = $('.sub-nav .menu-sub .sub04-01-01');

                $(location).addClass('active');
                $(location).find('div').addClass('active');
                $(location).parent().parent().prev().addClass('active');
                $(location).parent().parent().css({
                    "display": "block"
                });
            });

			/* ---------------------------------------------------모달작업--------------------------------------------------- */
		    // modal-popup layer
		    $('.modal-popup').click(function() {

 		    	var classNm = '${courseInfo.name}';
		    	var courseId = '${courseInfo.id}';
				var classPrice = Number('${courseInfo.price}').toLocaleString('en') + "원";
		    	var realPrice = '${courseInfo.price}';
/* 		    	var discountPrice = '할인금액처리'; */
		    	var learnPeriod =  '${courseInfo.selp_period}';				    	

		    	
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

						//모달 기본 정보 세팅
						$('.class-name').html(classNm);
						$('.class-price').html(classPrice);
						$('.class-id').val(courseId);								
						$('.class-term').val(learnPeriod);
						
						$('.class-pay-price').attr('data-value', realPrice);																		
						$('.class-pay-price').html(classPrice);																		
				        $('#signNm').html(userInfo.user_nm);						
						$('.user_name').html(userInfo.user_nm);
				        $('.user_birth').html(userInfo.user_birth);
						
						$('#getMyInfo').on('click', function(){
							/* 모달 내의 정보를 띄우는 세팅 */
					        						
/* 							모달에 성별 표시 안하기로 결정
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

						getPointInfo(user_id);
						getCardinalInfo(courseId, learnPeriod, 'modal_show');
						

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
		        $('.modal').hide();

		        //모달 닫으면 기존 탭 활성화 초기화(index 0 = active)
		        $('.section .tabGroup>li:first').addClass('active');
		        $('.section .subGroup>div:first').show();
		        //모달 닫으면 기존 탭 활성화 초기화(index 0 = active) 끝
		    });
		    //modal-popup layer 끝					
			/* ---------------------------------------------------모달작업--------------------------------------------------- */            
            
          
            
            
            function init(icon_displays, target_types){

            	var point_percentage_policy = "${point_percentage_policy}";
                $('#point_percentage_policy').html('결제금액의 ' + point_percentage_policy + '% 적립');
                
				var course_price = "${courseInfo.price}";
				var price = Number(course_price).toLocaleString('en') + "원";
				$('#course_price').html(price);		    	
		    	
				var content = "";

				if(icon_displays!=null){

					var display_icon = icon_displays.split(',');

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
				}
				
				$('.filterWrap').html(content);

				
				var content2 = "";
				
/* 				if(target_types!=null && target_types!=''){					
					var types = target_types.split(',');					
					var target_array = new Array();
					
					$.each(types, function(index, target){						
						if(target=='1'){
							target_array.push('유아');
						} else if(target=='2'){
							target_array.push('초등');						
						} else if(target=='3'){
							target_array.push('중등');						
						} else if(target=='4'){
							target_array.push('전문직');						
						} else if(target=='5'){
							target_array.push('기타');						
						}						
					});
					
					for(var i = 0; i < target_array.length; i++){						
						content2 += target_array[i];						
						if(i!=target_array.length-1){
							content2 += ', ';							
						}						
					}
					
				} else {
					content2 += '지정된 대상 없음';
				}
				
				$('.target_types').html(content2);
 */				
            }
		    
        	$('.home').on('click', function(){
        		document.location.href = '/lms/main';
        	});

    		function getCardinalInfo(course_id, selp_period, flag){
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
    					
    					$('#app_dates').html(app_comments);

    					//페이지와 모달에 같은 내용을 담으면서 중복 id문제가 발생하였기 때문에, 페이지의 selectbox의 id명을 변경해주어야 한다.
    					$('#app_dates').children('#cardinals_selectbox').attr('id', 'cardinals_selectbox2');
						
    					$('#app_dates').on('change', function(){
    		            	var selectedApp = $("option:selected", this).val();
    		            	setLearnDates(selectedApp, validCardinals, '#app_dates');
    		            	setCompleteCondition(selectedApp);
    		            });	    					
    					
						$('#modal_app_days').html(app_comments);    					

    		            $('#modal_app_days').on('change', function(){
    		            	var selectedApp = $("option:selected", this).val();
    		            	
							setLearnDates(selectedApp, validCardinals, '#modal_app_days');    		            	
    		            	/*결재날짜 갱신*/
    						$('input[name$="offerPeriod"]').val($("option:selected", this).val());
    						
    		            });    		            
    					
    				},
    				error	: function(request, status, error) {
    					alert("code : "+request.status+"\n\n"+"message : "+request.responseText+"\n\n"+"error : "+error);
    				}						
    			});
    		};        	
        	
        	function setLearnDates(select_val, validCardinals, selector_id){

    			/* ----------오늘 날짜 정보---------- */
				var today = new Date();   
				var year = today.getFullYear(); // 년도
				var month = today.getMonth() + 1;  // 월
				var date = today.getDate();  // 날짜

				var todayInfo = year + "-" + month + "-" + date;
				/* ----------오늘 날짜 정보---------- */
        		
				var comments = "";
				var learn_input = '';
				
				if(selector_id == '#app_dates'){
					learn_input = '#cardinal_list';					
				} else if(selector_id == '#modal_app_days'){
					learn_input = '#modal_learn_days';
				}
				
				
				
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

        	function setCompleteCondition(selectedApp) {
        		if (selectedApp != 'none' && selectedApp != 'app_date_title') {
        			$.ajax({
            			contentType : "application/json",
        				dataType : "json",
        				type	: "get",
        				url		: "/lms/course/getCompleteCondition",
        				data    : {
        					"cardinal_id" : selectedApp
        				},
        				success	: function(result) {
        					var cardinalInfo = result[0];        					
        					$(".compPercentQuiz").html(cardinalInfo.comp_percent_quiz);
        					$(".compPercentExam").html(cardinalInfo.comp_percent_exam);
        					$(".compPercentProg").html(cardinalInfo.comp_percent_prog);
        					$(".compScoreQuiz").html(cardinalInfo.comp_score_quiz);
        					$(".compScoreExam").html(cardinalInfo.comp_score_exam);
        					$(".compScoreProg").html(cardinalInfo.comp_score_prog);
        					$(".completeTotal").html(cardinalInfo.complete_total);
        				},
        				error	: function(request, status, error) {
        					alert("code : "+request.status+"\n\n"+"message : "+request.responseText+"\n\n"+"error : "+error);
        				}
            		});
				} else {
					$(".compPercentQuiz").html("${courseInfo.comp_percent_quiz}");
					$(".compPercentExam").html("${courseInfo.comp_percent_exam}");
					$(".compPercentProg").html("${courseInfo.comp_percent_prog}");
					$(".compScoreQuiz").html("${courseInfo.comp_score_quiz}");
					$(".compScoreExam").html("${courseInfo.comp_score_exam}");
					$(".compScoreProg").html("${courseInfo.comp_score_prog}");
					$(".completeTotal").html("${courseInfo.complete_total}");
				}        		
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
        	
        	
        	
        	
        	
        });
    </script>
</head>

<body>

    <div class="skip-navigation">
        <!--웹접근성/content-->
        <p><a class="goToMain" href="#main">콘텐츠 바로가기</a></p>
    </div>

    <!-- header-include -->
    <%@include file="../../header.jsp"%>


    <div class="container eLearning sub04" id="main">
        <!-- sub02외국어-include -->
        <%@include file="../../course/jobtraining/menu/leftmenu.jsp"%>

        <div class="sub-content sub04-01-01">

            <!-- 현재 페이지 위치 표시 -->
            <div class="page-locationWrap">
                <ul class="page-location">
                    <!--
                home 메인 / category menu 대분류 / division menu 중분류 / section menu 소분류
                -->
                    <li class="img-icon home"><a href="/lms/main"></a></li>
                    <li class="img-icon chevron-right"></li>
                    <li class="category-menu"><a href="sub04-01">취업연계</a></li>
                    <!-- <li class="img-icon chevron-right"></li>
                    <li class="division-menu"><a href="sub02-01-01">문법/어휘</a></li> -->
                    <!-- <li class="img-icon chevron-right"></li>
                    <li class="section-menu"><a href="#">로그인</a></li> -->
                </ul>
                <div class="img-icon chevron-right"></div>
                <!-- <div class="sub-content sub00-01"></div> -->
            </div>
            <div class="header">
                <div class="titleBar h3">과정상세</div>
                <!-- <h3 class="h3"></h3> -->
            </div>
            <div class="section section-class-detail sub04-01-01-01">
                <!-- 과정상세 -->
                <div class="class-list class-detail sub04-01-01-01">
                    <div class="c-ttl">
                        <div class="class-title-wrap d-flex">
                            <div class="filterWrap d-flex">
								<!-- SCRIPT로 버튼 추가 -->
<!--                                 <div class="new">신규</div>
                                <div class="recommend">추천</div>
                                <div class="popular">인기</div>
                                <div class="book">교재</div>
                                <div class="sale">할인</div> -->
                            </div>
                            <div class="fz16 text-over txt-ov-2">${courseInfo.name}</div>
                        </div>
                    </div>
                    <img src="${courseInfo.photo_url}" class="c-img">
                    <div class="c-ctt c-info">
                        <ul class="info-ttl floatL">
                        	<li>신청기간</li>
                            <li>학습기간</li>
                            <li>교육시간</li>
                            <li>교육비</li>
<!--                             <li>교육대상</li> -->
                            <li>마일리지</li>
                        </ul>
                        <ul class="info-ctt floatL">
                        	<li id="app_dates"></li>
                            <li id="cardinal_list">신청기간을 선택해주세요.</li>
                            <li>${courseInfo.complete_time}시간</li>
                            <li id="course_price"></li>
                            <li class="target_types"></li>
                            <li id="point_percentage_policy"></li>
                        </ul>
                    </div>
                    <div class="info-btnWrap d-flex">
                        
                        <form id="oneplayform" action="/lms/user/oneplayer" method="post" target="_blank">
                    	<input type="hidden" name="url" value="${courseInfo.tasting_url}">
                        <a class="button btn-wh" onclick="document.getElementById('oneplayform').submit();"  style="margin: 0px;">
                            <div class="img-icon tv"></div>
                            <span class="h5">맛보기</span>
                        </a>
                        </form>
                        <a class="button btn-pColor modal-popup">
                            <div class="img-icon hand-point-up"></div>
                            <span class="h5">수강신청</span>
                        </a>
                    </div>
                </div>

            <!-- 과정정보 탭 -->
            <div class="class-tabMenu">
                <ul class="tabGroup d-flex">
                    <li class="active">과정목표</li>
                    <li>학습목차</li>
                    <li>수료요건</li>
                    <li>기타사항</li>
                </ul>
                <div class="subGroup">
                    <div class="tab-sub sub01">
                        <div class="sub-section">
						${courseInfo.purpose}


<!-- 	                        <div class="titleBar-hdr">과정소개</div>
	                        <div class="sub-segment c999">
	                                <p>
	                                    영어공부의 시작은 문법이 아닙니다. 단어입니다.
	                                    <br>문법은 왕초보 학습자들이 바로 학습하기에 어렵습니다.
	                                    <br>먼저 쉬운 기초단어를 외우고 문법을 공부하세요.
	                                    <br>
	                                    <br>미국인이 매일 쓰는 500 단어로 다시 시작하는 영어 강좌에서는
	                                    <br>미국인이 쓰는 모든 말과 글을 컴퓨터로 분석한 자료를 토대로 만든 1위~500위까지의
	                                    <br>우선순위 영단어 500개를 학습합니다.
	                                    <br>
	                                    <br>이미 다 아는 단어라고요?
	                                    <br>쉬운 단어일수록 꼭 알아야할 중요한 문법정보를 담고 있습니다.
	                                    <br>누구나 안다고 오해하는 필수기초단어를 제대로 학습할 수 있습니다.
	                                </p>
	                        </div>  -->
	                        
	                        
	                    </div>
	                    
	                    
	                    
<!--                         <div class="sub-section d-flex">
                            <div class="titleBar-hdr">교육대상</div>
                            <div class="sub-segment c999">
                                <ul>
                                    <li>1.영단어 500개 정도를 외워보고자 하는 학습자</li>
                                    <li>2. 원어민이 가장 많이 쓰이는 단어부터 하나씩 학습해 나가고자 하는 분</li>
                                </ul>
                            </div>
                        </div>
                        <div class="sub-section d-flex">
                            <div class="titleBar-hdr">교육목표</div>
                            <div class="sub-segment c999">
                                세상에서 가장 쉬운 영단어로 영어 회화를 마스터하자
                            </div>
                        </div> -->
                        
                        
                        
                    </div>

                    <div class="tab-sub sub02 hideTab">
                        <div class="sub-section d-flex">
                            <div class="titleBar-hdr">학습목차</div>
                            <div class="sub-segment c999">
                                <ul>
                                	<c:forEach var="chapter" items="${chapterInfo}" varStatus="status">
									<li>${status.count}. ${chapter.name}</li>
                                	</c:forEach>
<!--                                     <li>01. 미국인이 매일 쓰는 영단어 1위-10위</li>
                                    <li>02. 미국인이 매일 쓰는 영단어 11위-20위</li>
                                    <li>03. 미국인이 매일 쓰는 영단어 21위-30위</li>
                                    <li>04. 미국인이 매일 쓰는 영단어 31위-40위</li>
                                    <li>05. 미국인이 매일 쓰는 영단어 41위-50위</li>
                                    <li>06. 미국인이 매일 쓰는 영단어 51위-60위</li>
                                    <li>07. 미국인이 매일 쓰는 영단어 61위-70위</li>
                                    <li>08. 미국인이 매일 쓰는 영단어 71위-80위</li>
                                    <li>09. 미국인이 매일 쓰는 영단어 81위-90위</li>
                                    <li>10. 미국인이 매일 쓰는 영단어 91위-100위</li>
                                    <li>11. 미국인이 매일 쓰는 영단어 101위-110위</li>
                                    <li>12. 미국인이 매일 쓰는 영단어 111위-120위</li>
                                    <li>13. 미국인이 매일 쓰는 영단어 121위-130위</li>
                                    <li>14. 미국인이 매일 쓰는 영단어 131위-140위</li>
                                    <li>15. 미국인이 매일 쓰는 영단어 141위-150위</li>
                                    <li>16. 미국인이 매일 쓰는 영단어 151위-160위</li>
                                    <li>17. 미국인이 매일 쓰는 영단어 161위-170위</li>
                                    <li>18. 미국인이 매일 쓰는 영단어 171위-180위</li>
                                    <li>19. 미국인이 매일 쓰는 영단어 181위-190위</li>
                                    <li>20. 미국인이 매일 쓰는 영단어 191위-200위</li>
                                    <li>21. 미국인이 매일 쓰는 영단어 201위-210위</li>
                                    <li>22. 미국인이 매일 쓰는 영단어 211위-220위</li>
                                    <li>23. 미국인이 매일 쓰는 영단어 221위-230위</li>
                                    <li>24. 미국인이 매일 쓰는 영단어 231위-240위</li>
                                    <li>25. 미국인이 매일 쓰는 영단어 241위-250위</li> -->
                                </ul>
                            </div>
                        </div>
                    </div>

                    <div class="tab-sub sub03 hideTab">
                        <div class="sub-section d-flex">
                            <div class="titleBar-hdr">수료조건</div>
                            <div class="sub-segment c999">
                                <table border="1" class="table">
                                    <thead>
                                        <tr>
                                            <th colspan="2">평가방법</th>
                                            <th>비중</th>
                                            <th>배점</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td rowspan="3">평가항목</td>
                                            <td>과제</td>
                                            <td><span class="compPercentQuiz">${courseInfo.comp_percent_quiz }</span>%</td>
                                            <td><span class="compScoreQuiz">${courseInfo.comp_score_quiz }</span>점</td>
                                        </tr>
                                        <tr>
                                            <td>시험</td>
                                            <td><span class="compPercentExam">${courseInfo.comp_percent_exam }</span>%</td>
                                            <td><span class="compScoreExam">${courseInfo.comp_score_exam }</span>점</td>
                                        </tr>
                                        <tr>
                                            <td>진도율</td>
                                            <td><span class="compPercentProg">${courseInfo.comp_percent_prog }</span>%</td>
                                            <td><span class="compScoreProg">${courseInfo.comp_score_prog }</span>점</td>
                                        </tr>
                                        <tr>
                                            <td colspan=2><b class="c666">수료기준</b></td>
                                            <td colspan=2><b class="c666">총점 <span class="completeTotal">${courseInfo.complete_total}</span>점 이상</b></td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
<!--                         <div class="sub-section d-flex">
                            <div class="titleBar-hdr">기타사항</div>
                            <div class="sub-segment c999">
                                교육비에는 교재비(8,500)가 포함되어 있습니다.
                            </div>
                        </div> -->
                    </div>
                    
                    
<!--                     기타사항 칼럼 추가 -->
                    <div class="tab-sub sub02 hideTab">
                        <div class="sub-section">
<!--                             <div class="titleBar-hdr"></div> -->
                            <div class="sub-segment c999">
							${courseInfo.summary}
                            </div>
                        </div>
                    </div>
                    
                                        
                </div>
            </div>
        </div>
    </div>
    </div>

    <!-- footer-include -->
    <%@include file="../../common_footer_doitcam.jsp"%>

    <div class="modal">
        <div class="modal-layer"></div>
        <div class="modal-content">
        <!-- modal 수강신청 1단계 include -->
        <%@include file="../modal/modal-sub02-01-01.jsp"%>
        </div>
        <div class="modal-content" style="display:none">
            <!-- modal 수강신청 1단계 include -->
              <%@include file="../modal/modal-sub02-01-02.jsp"%>
        </div>
        <div class="modal-content" style="display:none">
            <!-- modal 수강신청 1단계 include -->
              <%@include file="../modal/modal-sub02-01-03.jsp"%>
        </div>
        <div class="modal-content" style="display:none">
            <!-- modal 수강신청 1단계 include -->
              <%@include file="../modal/modal-sub02-01-04.jsp"%>
        </div>


    </div>
</body>

</html>

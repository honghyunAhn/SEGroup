<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>

<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="format-detection" content="telephone=no">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <meta name="description" content="다양한 전공과 ICT·AI를 융합하여 K-Digital 인재로 컬러링 해드립니다.">
    <meta name="keywords" content="해외취업, Soft Engineer Society, SES, 소프트엔지니어소사이어티, SCIT, SWDO, E러닝, e-learning">
    <title>Rainbow 레인보우</title>
    <link rel="stylesheet" href="/resources/segroup/society/smtp/css/reset.css">
    <link rel="stylesheet" href="/resources/segroup/society/smtp/css/common.css">
    <link rel="stylesheet" href="/resources/segroup/society/smtp/css/img-icon.css">
    <link rel="stylesheet" href="/resources/segroup/society/smtp/css/swiper.min.css">
    <link rel="stylesheet" href="/resources/segroup/society/smtp/css/rainbow_style.css">
    <link rel="stylesheet" href="/resources/segroup/society/smtp/css/rainbow_style_responsive.css">
	<!-- bxSlider CSS file -->
	<link href="<c:url value="/resources/segroup/society/edu/css/jquery.bxslider.css" />" rel="stylesheet" />
	    <!-- lightSlider CSS files and JS -->
	<link rel="stylesheet"  href="/resources/segroup/society/edu/css/lightslider.css"/>
    <style>
		.content-slider li{
		}
		.content-slider img {
		    margin: 0;
		    width: 350px;
		    height: 215px;
		}
		.top_img {
			width: 100%;
			margin-top: 0px;
			margin-left: auto;
			margin-right: auto;
			display: block;
		}
    </style>
    <script src="/resources/segroup/society/smtp/js/jquery-3.3.1.min.js"></script>
    <script src="<c:url value="/resources/segroup/society/edu/js/jquery.bxslider.min.js" />"></script>
    <script src="/resources/segroup/society/edu/js/lightslider.js"></script> 
    <script src="/resources/segroup/society/smtp/js/swiper.js"></script>
    <script src="/resources/segroup/society/smtp/js/rainbow_script.js"></script>
    <script type="text/javascript">
    	
    	$(document).ready(function(){
    		
        	var state = "${message}";
    		var session = "${session}";
        	if(state=="payComplete"){
        		alert("결제에 성공하셨습니다.");
        	}else if(state=="payError"){
        		alert("결제에 실패하셨습니다.");
        	}

    		if(session == "sessionExpire") {
    			alert("세션이 만료되었습니다. 계속하려면 다시 로그인 하세요.");
    		}
    		$("#content-slider").lightSlider({
                loop:true,
              	auto:true,
                keyPress:true
            });
    		$('#image-gallery').lightSlider({
                item:1,
                slideMargin: 0,
                speed:1000,
                auto:true,
                loop:true,
                onSliderLoad: function() {
                    $('#image-gallery').removeClass('cS-hidden');
                }  
            });
    	});
    	
    	//post 페이지 이동
        function page_move(url, some_data) {
            var form = document.createElement("form");
            var input;

            form.action = url;
            form.method = "post";

            input = document.createElement("input");
            input.setAttribute("type", "hidden");
            input.setAttribute('name', "course_id");
            input.setAttribute("value", some_data);
            form.appendChild(input);
            
            document.body.appendChild(form);
            form.submit();
            form.remove();
        }
        function openWindow(aTag) {
    		url = aTag.getAttribute("href");
    		window.open(url, '_blank');
    		window.focus();
    	}

//     	function confirm_event() {
//     		if (confirm("SC IT마스터과정은 무역협회 무역아카데미와\n컨소시움으로 운영하는 과정입니다.\n\n해당 페이지로 이동하시겠습니까?") == true) { //확인
//     			window.open("https://newtradecampus.kita.net/page/user_job_CloudIT_home", '_blank');
//     			window.focus();
//     		} else { //취소
//     			return false;
//     		}
//     	}
    </script>
</head>
<body>
    <div class="container_rainbow">
        <!-- header-include -->
		<%@include file="include/rainbow_header_basic.jsp"%>
        <div class="content" id="main">
        
        	<!-- 210513 메인배너영역 슬라이드 변경 Start -->
         	<div class="mainBannerWrapper swiper-container">
                <div class="mainBannerWrap d-flex swiper-wrapper">
                	<c:forEach var="data" items="${banner_list}">
                		<div class="mainBanner swiper-slide">
 	                        <a href="https://www.softsociety.net/smtp/community/sub04-01-01.do?seq=10133">
	 	                        <img class="webBanner" src="/resources/segroup/society/smtp/img/mainBannerImg06.jpg" alt="이젠, 부산에서 해외취업하자! 해외취업 멘토링 참여하고 갤럭시 워치, 갤럭시 버즈 등 푸짐한 상품 받아가세요!">
	 	                        <img class="mobileBanner" src="/resources/segroup/society/smtp/img/mainBannerImg06_mobile.jpg" alt="이젠, 부산에서 해외취업하자! 해외취업 멘토링 참여하고 갤럭시 워치, 갤럭시 버즈 등 푸짐한 상품 받아가세요!">
 	                    	</a>
 	                    </div>
 	                    <div class="mainBanner swiper-slide">
 	                        <a href="https://www.softsociety.net/smtp/community/sub04-01-01.do?seq=10135">
	 	                        <img class="webBanner" src="/resources/segroup/society/smtp/img/mainBannerImg07.jpg" alt="취업률 94%의 비결, 멘토링으로 알아보자! 광주 해외취업 멘토링 참여하고 에어팟 프로 등 경품 받아가세요! 일정 : 2021.06.25(금) 14:00 장소 : (오프라인) 전남대학교 도서관 별관, (온라인) : Zoom ※상세 장소 및 온라인 참여 주소는 설명회 전에 개별 안내">
	 	                        <img class="mobileBanner" src="/resources/segroup/society/smtp/img/mainBannerImg07_mobile.jpg" alt="취업률 94%의 비결, 멘토링으로 알아보자! 광주 해외취업 멘토링 참여하고 에어팟 프로 등 경품 받아가세요! 일정 : 2021.06.25(금) 14:00 장소 : (오프라인) 전남대학교 도서관 별관, (온라인) : Zoom ※상세 장소 및 온라인 참여 주소는 설명회 전에 개별 안내">
 	                    	</a>
 	                    </div>
                 		
 	                    
 	                    <!-- <div class="mainBanner swiper-slide">
 	                        <a href="https://www.softsociety.net/smtp/community/sub04-01-01.do?seq=10117">
	 	                        <img class="webBanner" src="/resources/segroup/society/smtp/img/mainBannerImg03.jpg" alt="한번에 합격! 2021 부산/광주 해외취업 설명회! 부산 : 2021.07.03(토) 오전 11시 부산무역회관 / 광주 : 2021.06.25(금) 오후 2시 광주무역회관 / 디지털 ABC 또는 SWDO 검색">
	 	                        <img class="mobileBanner" src="/resources/segroup/society/smtp/img/mainBannerImg03_mobile.png" alt="한번에 합격! 2021 부산/광주 해외취업 설명회! 부산 : 2021.07.03(토) 오전 11시 부산무역회관 / 광주 : 2021.06.25(금) 오후 2시 광주무역회관 / 디지털 ABC 또는 SWDO 검색">
 	                    	</a>
 	                    </div> -->
 	                    <div class="mainBanner swiper-slide">
 	                        <!-- <div class="background" style="background-image: url(<c:out value="${data.img_full_path}"/>); background-repeat: no-repeat;"> 
 	                            <div class="opacity_bg">
 	                                <div class="bannerTextWrap">
	                                	<a href="${data.edu_ban_link}"><img class="top_img" src="${data.img_full_path}"></a>
 	                                </div>
 	                            </div>
 	                        </div> -->
 	                        <!-- <img class="webBanner" src="/resources/segroup/society/smtp/img/mainBannerImg01.jpg">
 	                        <img class="mobileBanner" src="/resources/segroup/society/smtp/img/mainBannerImg01_mobile.jpg"> -->
 	                        <div class="bannerTextWrap d-flex justify_center">
	                        	<a class="button btn_normal" href="/smtp/course/scmaster/scmaster-info?course_id=c000000526">광주과정 바로가기</a>
	                        	<a class="button btn_normal" href="/smtp/course/scmaster/scmaster-info?course_id=c000000548">부산과정 바로가기</a>
 	                        </div>
 	                        <img class="webBanner" src="/resources/segroup/society/smtp/img/mainBannerImg02.jpg" alt="페이스메이커 운영 중! 최종합격까지 함께 뛴다! 단계별 맞춤형 코칭 프로그램으로 최종 합격까지!">
 	                        <img class="mobileBanner" src="/resources/segroup/society/smtp/img/mainBannerImg02_mobile.jpg" alt="페이스메이커 운영 중! 최종합격까지 함께 뛴다! 단계별 맞춤형 코칭 프로그램으로 최종 합격까지!">
 	                    </div>
 	                    <!-- <div class="mainBanner swiper-slide">
 	                        <a href="https://www.softsociety.net/smtp/community/sub04-01-01.do?seq=10115">
	 	                        <img class="webBanner" src="/resources/segroup/society/smtp/img/mainBannerImg04.jpg" alt="Grand Open 회원가입 경품 대잔치! 2021.06.07(월)~06.30(수) 4주간 진행! 추첨을 통해 커피쿠폰 10명, 치킨추폰 10명, 피자쿠폰 10명 증정! 당첨자 공지는 7월 13일 안내 예정 ">
	 	                        <img class="mobileBanner" src="/resources/segroup/society/smtp/img/mainBannerImg04_mobile.png" alt="Grand Open 회원가입 경품 대잔치! 2021.06.07(월)~06.30(수) 4주간 진행! 추첨을 통해 커피쿠폰 10명, 치킨추폰 10명, 피자쿠폰 10명 증정! 당첨자 공지는 7월 13일 안내 예정">
 	                    	</a>
 	                    </div> -->
 	                    
 	                    <div class="mainBanner swiper-slide">
 	                        <a href="https://www.softsociety.net/smtp/community/sub04-01-01.do?seq=10130">
	 	                        <img class="webBanner" src="/resources/segroup/society/smtp/img/mainBannerImg05.jpg" alt="추천받은 지인이 과정에  최종 등록하면 선물이 팡팡! 부산/광주 해외취업연계과정 지인추천 이벤트!">
	 	                        <img class="mobileBanner" src="/resources/segroup/society/smtp/img/mainBannerImg05_mobile.jpg" alt="추천받은 지인이 과정에  최종 등록하면 선물이 팡팡! 부산/광주 해외취업연계과정 지인추천 이벤트!">
 	                    	</a>
 	                    </div>
                 	</c:forEach>
                 </div>
                 <div class="swiper-button-next"></div>
                <div class="swiper-button-prev"></div>
                <div class="swiper-pagination"></div>
             </div>            
             <!--  <div class="bannerWrapper" style="padding-top: 160px;">
            	<div class="clearfix" style="max-width:100%;">
	                <ul id="image-gallery" class="gallery list-unstyled cS-hidden">
	                	<c:forEach var="data" items="${banner_list}">
	                		<li>
	                			<a href="${data.edu_ban_link}"><img class="top_img" src="${data.img_full_path}"></a>
	                		</li>
	                	</c:forEach>
	                </ul>
	            </div>
            </div> -->
            <!-- 210513 메인배너영역 슬라이드 변경 End -->
            
            <!-- 210514 메인 모집과정 영역 수정 Start -->
			<!-- <div class="bannerWrapper">
				<div class="title_barPoint_wh fz40 margin-bottom20">모집과정</div>
				<div class="item d-flex justify_between">
			    	<ul id="content-slider" class="content-slider d-flex">
			        	<c:forEach var="data" items="${subbanner_list}">
			            <li>
			            	<a href="${data.edu_sub_ban_link}"><img src="${data.img_full_path}"></a>
			                <div class="sub_ban_nm">
			                	${data.edu_sub_ban_nm}
			                </div>
			                <div class="sub_ban_dt">
								<c:if test="${data.edu_sub_ban_st != null && data.edu_sub_ban_st != ''}">
									신청기간 : ${data.edu_sub_ban_st} ~ ${data.edu_sub_ban_et}
								</c:if>
			                </div>
						</li>
			            </c:forEach>
			        </ul>
			    </div>
			</div> -->
			<div class="courseWrapper">
				<div class="title_barPoint_wh fz40">모집과정</div>
				<div class="d-flex flexWrap courseWrap">
					<div class="course">
						<a href="/smtp/course/short-term/short-term-info?course_id=c000000543">
							<img class="course-img" src="/resources/segroup/society/smtp/img/course_thumb01.jpg">
						</a>
						<div class="course-txt">
							<div class="course-name">3주 완성! 코딩 챌린지 과정</div>
							<div class="course-term">모집마감 2021.07.04 까지</div>
						</div>
					</div>
					<div class="course">
						<a href="/smtp/course/scmaster/scmaster-info?course_id=c000000526">
							<img class="course-img" src="/resources/segroup/society/smtp/img/course_thumb02.jpg">
						</a>
						<div class="course-txt">
							<div class="course-name">[광주] SoftWare DevOps 마스터 과정</div>
							<div class="course-term">모집마감 2021.07.11 까지</div>
						</div>
					</div>
					<div class="course">
						<a href="/smtp/course/scmaster/scmaster-info?course_id=c000000548">
							<img class="course-img" src="/resources/segroup/society/smtp/img/course_thumb03.jpg">
						</a>
						<div class="course-txt">
							<div class="course-name">[부산] Digital ABC 마스터 과정</div>
							<div class="course-term">모집마감 2021.07.11 까지</div>
							<!-- 학습기간 : 2021.07.20 ~ 2022.05.26 -->
						</div>
					</div>
				</div>
				
			</div>
			
			<!-- 210525 메인 동영상 추가 Start -->
			<div class="videoWrapper">
				<video class="video01" id="video" src="/resources/segroup/society/smtp/video/softsociety02.mp4" controls></video>
			</div>
			
			<!-- 210525 메인 동영상 추가 End -->
			
			<!-- 210514 메인 썸네일 슬라이드 영역 수정 Start -->
            <div class="bannerWrapper_bg">
                <!-- <div class="title_barPoint_wh fz40"></div> -->
                <div class="bannerWrapper swiper-container">
	                <div class="d-flex swiper-wrapper">
	                	<div class="swiper-slide">
		                    <a href="/smtp/course/schedule" class="swiper-slide">
		                        <div class="bannerWrap banner01"></div>
		                        <!-- <div class="bannerTxt">2021년 연간 교육 일정을 확인하실 수 있습니다.</div> -->
		                    </a>
	                    </div>
	                    <div class="swiper-slide">
		                    <a href="http://doitcampus.com/" class="swiper-slide">
		                        <div class="bannerWrap banner02"></div>
		                        <!-- <div class="bannerTxt">나에게 맞는 강의가 궁금하다면?<br>두잇캠퍼스에서 확인해보세요.</div> -->
		                    </a>
	                    </div>
	                    <div class="swiper-slide">
		                    <a href="https://www.softsociety.net/smtp/course/short-term/short-term-info?course_id=c000000541" class="swiper-slide">
		                        <div class="bannerWrap banner03"></div>
		                        <!-- <div class="bannerTxt">아직 자격증이 없으신가요?<br>일본취업 필수과정을 확인해보세요.</div> -->
		                    </a>
	                    </div>
	                    <div class="swiper-slide">
		                    <a href="/smtp/community/sub04-05" class="swiper-slide">
		                        <div class="bannerWrap banner06"></div>
		                        <!-- 과정후기 보러가기 -->
		                    </a>
	                    </div>
	                    <div class="swiper-slide">
		                    <a href="https://blog.naver.com/scitmaster" class="swiper-slide">
		                        <div class="bannerWrap banner04"></div>
		                        <!-- 네이버블로그 바로가기 -->
		                    </a>
	                    </div>
	                    <div class="swiper-slide">
		                    <a href="https://www.youtube.com/channel/UCCsiCEQ8g6PacQLuJEYEWpw?view_as=subscriber" class="swiper-slide">
		                        <div class="bannerWrap banner05"></div>
		                        <!-- 유튜브 채널 바로가기 -->
		                    </a>
	                    </div>
	                    
	                </div>
	                <div class="swiper-pagination"></div>
	            </div>
            </div>
            <!-- 210514 메인 썸네일 슬라이드 영역 수정 End -->
            
			<!-- 바로가기배너영역 210209 추가 Start -->
            <!-- <div class="linkBannerWrapper">
                <div class="linkBannerWrap">
                    <div class="d-flex flexWrap">                        
                        <div class="linkBanner link_banner01" style="cursor: pointer;">
                            <a onclick="javascript:page_move('/smtp/course/scmaster/scmaster-info','c000000526')"></a>
                        </div>                        
                        <div class="linkBanner link_banner02">
                           <a href="/smtp/community/sub04-01"></a> 
                        </div>                        
                        <div class="linkBanner link_banner03">
                            <a href="/smtp/support/sub04-02"></a>
                        </div>                        
                        <div class="linkBanner link_banner04">
                            <a href="https://blog.naver.com/scitmaster"></a>
                        </div>                        
                        <div class="linkBanner link_banner05">
                            <a href="https://www.youtube.com/channel/UCCsiCEQ8g6PacQLuJEYEWpw?view_as=subscriber"></a>
                        </div>
                        <div class="linkBanner link_banner06">
                            <a href="/smtp/community/sub04-05"></a>
                        </div>
                    </div>
                </div>
            </div> -->
            <!-- 바로가기배너영역 210209 추가 End -->
        </div>
        <%@include file="include/common_footer_rainbow.jsp"%>
</body>
</html>
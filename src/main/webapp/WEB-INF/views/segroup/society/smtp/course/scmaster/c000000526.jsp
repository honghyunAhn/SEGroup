<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
    <script src="/resources/segroup/society/smtp/js/jquery-3.3.1.min.js"></script>
    <script src="/resources/segroup/society/smtp/js/swiper.js"></script>
    <script src="/resources/segroup/society/smtp/js/rainbow_script.js"></script>
    <script src="/resources/segroup/society/smtp/js/rainbow_script_responsive.js"></script>
    <script src="/resources/segroup/society/smtp/js/rainbow_pageInfo_common.js"></script>
    <script src="/resources/segroup/society/smtp/js/rainbow_pageInfo_longTerm.js"></script>
    <script type="text/javascript">
	  	//공통 변수
		var course_id = '${courseInfo.id}';
		var applyFormYn = '${courseInfo.applyform_yn}';
		var user_id = "${sessionScope.user_id}";
		//장기과정용 변수
		var aedDate_hyphen;
    </script>
</head>
<body>
	<div class="container_rainbow">
		<!-- SWDO 마스터 -->
		<!-- Header-include -->
		<%@include file="../../include/rainbow_header_basic.jsp"%>
<!-- 		<div id="codeTxtDiv"> -->
<%-- 			<c:out value="${courseInfo.page_codes}" escapeXml="false"/> --%>
<!-- 		</div> -->
																																																																																																																																						<div class="content sub-content sub02_content" id="main">
            <div class="background sub02-01_content bg_swdo">
                <div class="opacity_bg">
                    <!-- <div class="course-title fz40 fc_fff">
                    	&lt;SoftWare DevOps 마스터 과정&gt;
                        <br>광주/전남특화 SWDO마스터 - 글로벌SW인재양성과정
					</div> -->
                </div>
            </div>
            <!-- 과정개요 -->
            <div class="courseGuideWrap">
                <div class="title_barPoint_wh fz40">과정개요</div>
                <p class="course_textWrap fz20">
                    광주/전남 지역 해외취업인재 양성을 위해 광주해외취업협의회 광주지역 내 9개 대학과 5개의 유관기관이 협력하여 만들어진 과정으로 2018년 10월 1기를 시작으로 현재 6기 까지 교육이 진행되고 있으며, 1기 ~ 4기 94%가 연봉 3200만원 이상의 일본 유수의 기업에 취업 성공을 달성하였습니다.
                </p>
                 <div class="course-infoTable fz18">
                            <div class="d-flex">
                                <ul class="infoTh d-flex">
                                    <li class="img-icon calendar-day"></li>
                                    <li class="thTxt">모집기간</li>
                                </ul>
                                <ul class="infoTd">
                                    <li>2021.10.08(수) 까지</li>
                                </ul>
                            </div>
                            <div class="d-flex jus">
                                <ul class="infoTh d-flex">
                                    <li class="img-icon calendar"></li>
                                    <li class="thTxt">교육기간</li>
                                </ul>
                                <ul class="infoTd">
                                    <li>2021.09.28 ~ 2022.06.30</li>
                                    <li>월/화/수/목 08:30 ~ 18:00</li>
                                </ul>
                            </div>
                            <div class="d-flex">
                                <ul class="infoTh d-flex">
                                    <li class="img-icon user"></li>
                                    <li class="thTxt">수강대상</li>
                                </ul>
                                <ul class="infoTd">
                                    <li>IT/일본어 전공자, 비전공자 모두 환영합니다!</li>
                                    <li>- 2/4년제 대학 졸업자 및 예정자(2022.03)</li>
                                    <li>- 만 34세 이하 대한민국 청년</li>
                                    <li>- ICT 글로벌 커리어를 쌓고 싶은 대한민국 청년</li>
                                    <li>- 해외취업에 대한 의지가 확고한 분</li>
                                </ul>
                            </div>
                            <div class="d-flex">
                                <ul class="infoTh d-flex">
                                    <li class="img-icon hand-holding-heart"></li>
                                    <li class="thTxt">교육혜택</li>
                                </ul>
                                <ul class="infoTd">
                                    <li>- <span class="fc_point01">국민취업제도</span> 대상 과정</li>
                                    <li>- 해외취업정착지원금<span class="fc_point01">(최대 400만원 지급)</span></li>
                                    <li>- <span class="fc_point01">전액 국비지원</span>(개인부담금 없음)</li>
                                </ul>
                            </div>
                            <div class="d-flex">
                                <ul class="infoTh d-flex">
                                    <li class="img-icon won-sign"></li>
                                    <li class="thTxt">교육비</li>
                                </ul>
                                <ul class="infoTd">
                                    <li>0원(전액 국비지원)</li>
                                </ul>
                            </div>
                        </div>
            </div>
		
            <!-- 수강효과 -->
            <div class="courseEffectWrapper">
                <div class="courseEffect">
                    <div class="fz40">
                        <!-- 강조하는문구 1 (민트색) -->
                        <div class="fc_eg">
                        	“서울에서 20년간 진행된 국내 최고의 글로벌 SW인재 양성과정이 이제는 광주에서”
                        </div>
                        <!-- 강조하는문구 2 (흰색) -->
                        <div class="fc_fff">
                        	2001년부터 현재까지 20년간 해외취업인재 2500명 이상을 배출하여 일본 ICT정규직 취업성공 97%를 달성한 노하우를 가지고 있는 Soft Engineer Society에서 운영하는 과정입니다.
                        </div>
                    </div>
                    <!-- 수강효과 설명 -->
                    <div class="fz20 fc_fff">
                    </div>
                </div>
            </div>
            
            <img style="width : 100%;" src="/resources/segroup/society/smtp/img/course_sub02-01-chanllenge02.jpg" alt="단계별 맞춤형 코칭 프로그램 페이스메이커 시스템으로 최종 합격까지 함께 합니다!">
            
             <!-- 수강후기 -->
            <div class="courseReviewWrap" style="background-color:#4805c7; margin-top:120px">
                <div class="courseReview fc_fff">
                    <div class="fc_eg fz20">
                        레인보우에서는 비전공자도 충분히 수강할 수 있습니다.
                    </div>
                    <div class="fz40">
                        많은 수강생 분들이 남긴 수강후기를 확인하세요!
                    </div>
                    <div class="d-flex">
                        <div class="reviewBox">
                            <!-- <a href=""> -->
                                <div class="companyName">
                                	“IT에 대해서는 문외한이었기 때문에 <br>처음에는 많은 걱정이 앞섰지만 수업을 진행하면 할수록<br> IT에 대해 많은 흥미를 갖게 되었습니다.”
								</div>
                                <div class="studentName">SWDO마스터 4기 수료생 곽**</div>
                            <!-- </a> -->
                        </div>
                        <div class="reviewBox">
                            <!-- <a href=""> -->
                                <div class="companyName">
                                	“지금까지 해본 적 없었던 IT 분야를<br>시작한다는 점에서 SWDO 과정은<br>저에게 새로운 도전이었다고 생각합니다.<br> 
                                	앞으로 일본에서의 생활 또한 새로운 <br>시작이라는 마음가짐으로 열심히 임하고 싶습니다.”
                                </div>
                                <div class="studentName">SWDO마스터 3기 수료생 김**</div>
                            <!-- </a> -->
                        </div>
                        <div class="reviewBox">
                           <!-- <a href=""> -->
                                <div class="companyName">
                                	“다른 분들의 후기를 읽으며 과연 내가 이걸 <br>해낼 수 있을까하는 분들도 과정에 참여하여<br>함께
									생활하다 보면 어느샌가 원하는 결과를<br>손에 넣을 수 있을 것이라고 생각합니다”
                                </div>
                                <div class="studentName">SWDO마스터 3기 수료생 강**</div>
                            <!-- </a> -->
                        </div>
                    </div>
                    <!-- <div class="btn_normal btn_large btn_eg">
                        <a href="">수강후기 보러가기</a>
                    </div> -->
                </div>
            </div>
            <!-- 수강대상 -->
            <!-- <div class="courseTargetWrap" style="padding-bottom : 0">
                <div class="title_barPoint_wh fz40">수강대상</div>
                <div class="targetWrap target01">
                    <div class="fz20">
                    	<div class="fc_pp">IT/일본어 전공자, 비전공자 모두 환영합니다!</div>
                        <div class="fc_333">SWDO마스터 과정은 다음과 같은 분들을 대상으로 합니다.</div>
                    </div>
                    <div class="targetBoxWrap d-flex">
                        <div class="targetBox">
                            <div class="target_img target01"></div>
                            <div class="target_txt">
                            	전문학사 이상 졸업생 및 졸업예정자
                            </div>
                        </div>
                        <div class="targetBox">
                            <div class="target_img target02"></div>
                            <div class="target_txt">
                            	해외취업에 대한 의지가 확고한 분
                            </div>
                        </div>
                        <div class="targetBox">
                            <div class="target_img target03"></div>
                            <div class="target_txt">
                            	ICT 글로벌 커리어를 쌓고 싶은 대한민국 청년(전공무관)
                            </div>
                        </div>
                    </div>
                </div> -->
                <!-- <div class="targetWrap target02">
                    <div class="fz20">
                        레인보우에서는 다음과 같은 수준이더라도 충분히 수강할 수 있습니다.
                    </div>
                    <div class="targetBoxWrap d-flex justify_between">
                        <div class="targetBox">
                            <div class="target_img target04"></div>
                            <div class="target_txt">
                                딥러닝에 관심은 있는데 시작할 엄두가 안나는 비전공자
                            </div>
                        </div>
                        <div class="targetBox">
                            <div class="target_img target05"></div>
                            <div class="target_txt">
                                이론만 알고 적용은 해본적 없는, 못하는 애매한 입문자
                            </div>
                        </div>
                        <div class="targetBox">
                            <div class="target_img target06"></div>
                            <div class="target_txt">
                                딥러닝을 배우고 싶지만 막막한 현업자
                            </div>
                        </div>
                    </div>
                </div> -->
            </div>
            <!-- 커리큘럼 -->
            <!-- <div class="curriculumWrap">
                <div class="title_barPoint_wh fz40">커리큘럼</div>
                <div class="curriculum d-flex">
                    <div class="cc_imgWrap">
                        <div class="background">
                            <div class="opacity_bg">
                            	<div class="courseTitle fz20 fc_fff">
                                    &lt;SW DO 마스터 과정&gt;
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="cc_segWrap">
                        <div class="segmentWrap">
                            <ul class="seg-list fz20">
                            	<li>프로그래밍 기초</li>
                                <li>데이터베이스</li>
                                <li>웹 프로그래밍(Front-end, Back-end)</li>
                                <li>데이터 분석 및 머신러닝</li>
                                <li>산학연계 프로젝트</li>
                                <li>일본어 초/중/고급</li>
                                <li>자기분석 및 이력서 작성</li>
								<li>비즈니스 일본어</li>
                            </ul>
                            <div class="btnWrap d-flex">
                                <div class="btn_normal btn_large btn_pp">
                                	 <a href="/file_download?origin=Python.pdf&saved=2020122819307696.pdf&path=uploadImage" download>커리큘럼 다운받기</a>
                                </div>
                                <div class="btn_normal btn_large btn_pp_bg margin-left20 ">
                                    <a href="sub02-01-01.html">수강신청 하러가기</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div> -->
            <img style="width : 100%;" src="/resources/segroup/society/smtp/img/course_back_sub02-01-swdo02.jpg" alt="커리큘럼(ICT/외국어 외 취업역량향상 교육)">
            
            <!-- 수강기간 -->
           <!--  <div class="coursePeriodWrap">
                <div class="background">
                    <div class="opacity_bg">
                        <div class="coursePeriod">
                            <div class="title_barPoint fz40 fc_fff">수강기간</div>
                            <div class="fz20">
                                <div class="fc_eg">코로나 바이러스? 걱정마세요! </div>
                                <div class="fc_fff">
                                    코로나 바이러스 확산에 대비하여 온라인/오프라인 Blended 수업을 실시합니다.
                                </div>
                            </div>
                            <div class="d-flex justify_between applyCardinal">
                            </div>
                        </div>
                    </div>
                </div>
            </div> -->
           <img style="width : 100%;" src="/resources/segroup/society/smtp/img/course_back_sub02-01-swdo01.jpg" alt="교육시설 및 장비, 교육장소 안내">
           
           <a href="https://pf.kakao.com/_exoPxjs" class="banner_kakao">
             	<img class="mobileBanner" style="width : 100%;" src="/resources/segroup/society/smtp/img/course_mobile_banner_kakao_swdo.jpg" alt="카카오톡 채널에서 abc마스터를 검색하세요! abc마스터 채널 추가하고 다양한 혜택과 다양한 이벤트 소식을 누구보다 빠르게 받아보세요.">
             	<img class="webBanner" style="width : 100%;" src="/resources/segroup/society/smtp/img/course_banner_kakao_swdo.jpg" alt="카카오톡 채널에서 abc마스터를 검색하세요! abc마스터 채널 추가하고 다양한 혜택과 다양한 이벤트 소식을 누구보다 빠르게 받아보세요.">
             </a>
            <!-- 추천과정 -->
            <!-- <div class="RecommendationWrap">
                <div class="title_barPoint_wh fz40">추천 사전학습과정</div>
                <div class="fz20">
                	<div class="fc_pp">수강 전 무엇을 준비해야 하는지 고민되시나요?
                    </div>
                    <div class="fc_333">
                        걱정하지마세요! 단계별로 학습하여 원하는 수준까지 도달! 학습의 방향성까지 제시해드립니다!
                    </div>
                </div>
                <div class="d-flex">
                    <div class="rcmdBox">
                    	<a href="https://www.softsociety.net/smtp/course/short-term/short-term-info?course_id=c000000543">
                            <div class="rcmd_div">바로가기</div>
                            <div class="rcmd_img">
                                <img src="/upload/course/mainImg/2021052865466033.jpg" alt="코딩챌린지" style="max-width: 100%; max-height: 100%; width: 100%; height: 100%;">
                            </div>
                            <div class="rcmd_txt">
                               [오프라인] 코딩 챌린지
                            </div>
                        </a>
                    </div>
                    <div class="rcmdBox">
                    	<a href="https://www.softsociety.net/lms/course/search/movePage?course_id=c000000383&grand=ICT">
                            <div class="rcmd_div">바로가기</div>
                            <div class="rcmd_img">
                            	<img src="/upload/course/mainImg/2020082581511079.gif" alt="쉽게 배우는 Java 알고리즘 입문" style="max-width: 100%; max-height: 100%; width: 100%; height: 100%;">
                            </div>
                            <div class="rcmd_txt">
                            	[온라인] 쉽게 배우는 Java 알고리즘 입문
                            </div>
                        </a>
                    </div>
                    <div class="rcmdBox">
                    	<a href="https://www.softsociety.net/lms/course/search/movePage?course_id=c000000298&grand=%EC%99%B8%EA%B5%AD%EC%96%B4">
                            <div class="rcmd_div">바로가기</div>
                            <div class="rcmd_img">
                            	<img src="/upload/course/mainImg/2020032482073857.jpg" alt="일본어 초급" style="max-width: 100%; max-height: 100%; width: 100%; height: 100%;">
                            </div>
                            <div class="rcmd_txt">
                            	[온라인] 일본어 초급
                            </div>
                        </a>
                    </div>
                </div>
            </div> -->
        	
        	<div class="btn_normal btn_xlarge btn_swdo" style="margin: 120px auto">
            	<a class="applyBtn fz20">지원하기</a>
            	<input type="hidden" value="n000000607" name="cardinal_id">
            	<input type="hidden" value="Fri Jul 16 2021 00:00:00 GMT+0900 (대한민국 표준시)" name="aedDate">
            </div>
        </div>
		<div class="modal">
			<div class="modal-layer"></div>
				<div class="modal-content">
					<%@include file="../modal/rainbow_modal_sub02-01-01.jsp"%>
				</div> 
		</div>
		<!-- footer-include -->
        <%@include file="../../include/common_footer_rainbow.jsp"%>

</body>

</html>
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
    <script src="/resources/segroup/society/smtp/js/rainbow_pageInfo_shortTerm.js"></script>
    <script src="https://ssl.daumcdn.net/dmaps/map_js_init/postcode.v2.js"></script>

    <script type="text/javascript">
	  	//공통 변수
		var course_id = '${courseInfo.id}';
		var applyFormYn = '${courseInfo.applyform_yn}';
		var user_id = "${sessionScope.user_id}";
		//단기과정 변수
		var classNm = "${courseInfo.name}"
		var learnPeriod = "${courseInfo.selp_period}"
    </script>
</head>
<body>
    <div class="container_rainbow">
		<!-- Python기반 데이터 사이언스 기초 -->
		<!-- Header-include -->
		<%@include file="../../include/rainbow_header_basic.jsp"%>
<!-- 		<div id="codeTxtDiv"> -->
<%-- 			<c:out value="${courseInfo.page_codes}" escapeXml="false"/> --%>
<!-- 		</div> -->
																																																																																																																																						<div class="content sub-content sub02_content" id="main">
            <div class="background sub02-01_content">
                <div class="opacity_bg">
                    <div class="course-title fz40 fc_fff">
                    	Python기반 데이터 사이언스 기초
					</div>
                </div>
            </div>
            <!-- 과정개요 -->
            <div class="courseGuideWrap">
                <div class="title_barPoint_wh fz40">과정개요</div>
                <p class="course_textWrap fz20">
                	 이 강좌는 AI를 위한 파이썬 프레임 워크인 텐서플로나 케라스를 이용하여 머신러닝과 딥러닝을 공부하기 전 필수적으로 학습해야 할 Numpy모듈에 대하여 배웁니다.
                    <br>
                    머신러닝과 딥러닝에서는 주어진 1차 함수의 종속함수를 예측하는 것이 중요한데, 이때 필요한 것이 선형대수학입니다.<br>Numpy는 선형대수학을 쉽게 이해하고 구현할 수 있도록 만든 파이썬 모듈로써, 수학적인 이론을 함수를 통해 결과를 도출해주며, 관련 전공이 아니어도, 수학을 전혀 알지 못하는 분들도 재미있게 공부할 수 있습니다.
		    	</p>
            </div>

            <!-- 수강효과 -->
            <div class="courseEffectWrapper">
                <div class="courseEffect">
                    <div class="fz40">
                        <!-- 강조하는문구 1 (민트색) -->
                        <div class="fc_eg">
                        	글로벌 기업이 선택한 언어 “파이썬”
                        </div>
                        <!-- 강조하는문구 2 (흰색) -->
                        <div class="fc_fff">
                        	수학적인 이론을 함수를 통해 결과를 도출!
                        </div>
                    </div>
                    <!-- 수강효과 설명 -->
                    <div class="fz20 fc_fff">
                    	쉬운 내용이지만 머신러닝을 학습하고자 할 때 필수적인 내용입니다.
                        이 강좌를 통해 데이터를 이해하고 다루는 능력을 기르고, 데이터 중심으로 다변하는 산업에서 경쟁력을 키우세요.
                    </div>
                </div>
            </div>
            <!-- 수강대상 -->
            <div class="courseTargetWrap">
                <div class="title_barPoint_wh fz40">수강대상</div>
                <div class="targetWrap target01">
                    <div class="fz20">
                        <div class="fc_pp">제가 들어도 될까요?</div>
                        <div class="fc_333">슈어 와이낫? 물론이죠! 레인보우는 다음과 같은 분들을 대상으로 합니다.</div>
                    </div>
                    <div class="targetBoxWrap d-flex">
                        <div class="targetBox">
                            <div class="target_img target01"></div>
                            <div class="target_txt">
                                Python을 배우고 이후 AI 학습시 필요한 Numpy,<br>시각화에 대한 지식을 필요로 하는 초보자
                            </div>
                        </div>
                        <div class="targetBox">
                            <div class="target_img target02"></div>
                            <div class="target_txt">
                                AI를 하기 전 기초적인 선형대수학에 대한 개념이 필요한 자
                            </div>
                        </div>
                        <!-- <div class="targetBox">
                            <div class="target_img target03"></div>
                            <div class="target_txt">
                                별들을 시인의 슬퍼하는 그리고 않은 까닭입니다.
                                릴케 별 가난한 겨울이 너무나 벌레는
                            </div>
                        </div> -->
                    </div>
                </div>
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
            <!-- 수강기간 -->
            <div class="coursePeriodWrap">
                <div class="background">
                    <div class="opacity_bg">
                        <div class="coursePeriod">
                            <div class="title_barPoint fz40 fc_fff">수강기간</div>
                            <div class="fz20">
                                <div class="fc_eg">직장이나 학교 때문에 결석이 결정이시라구요?</div>
                                <div class="fc_fff">
                                	걱정하지마세요! 한 두번 결석하더라도 따라갈 수 있도록, 결석 시 당일 강의 영상을 제공해드립니다.
                                </div>
                            </div>
                            <div class="d-flex justify_between">
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- 커리큘럼 -->
            <div class="curriculumWrap">
                <div class="title_barPoint_wh fz40">커리큘럼</div>
                <div class="curriculum d-flex">
                    <div class="cc_imgWrap">
                        <div class="background">
                            <div class="opacity_bg">
                                <div>
                                	<img src="/upload/course/mainImg/2020122963527171.jpg" alt="파이썬 기반 데이터 사이언스" style="max-width: 100%; max-height: 100%; width: 100%; height: 100%;">
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="cc_segWrap">
                        <div class="segmentWrap">
                            <ul class="seg-list fz20">
                                <li>- 파이썬과 넘파이 소개</li>
                                <li>- 환경설정 및 모듈 설치</li>
                                <li>- 넘파이 배열</li>
                                <li>- 배열 생성</li>
                                <li>- 데이터 타입</li>
                                <li>- 배열 연산(산술연산, 비교연산, 집계)</li>
                                <li>- 배열 복사와 정렬</li>
                                <li>- Subset, sliceing, indexing, broadcasting</li>
                                <li>- 배열 변환(전치, 결합 등)</li>
                                <li>- Numpy와 Matplotlib을 이용한 간단한 시각화</li>
                            </ul>
                            <div class="btnWrap d-flex">
                                <div class="btn_normal btn_large btn_pp" onclick='location.href="/file_download?origin=Python기반 데이터 사이언스 기초_v01.pdf&saved=2020122819307696.pdf&path=uploadImage"'>
                                	<a href="/file_download?origin=Python기반 데이터 사이언스 기초_v01.pdf&saved=2020122819307696.pdf&path=uploadImage" download>커리큘럼 다운받기</a>
                                </div>
<!--                                 <div class="btn_normal btn_large btn_pp_bg margin-left20 "> -->
<!--                                     <a href="sub02-01-01.html">수강신청 하러가기</a> -->
<!--                                 </div> -->
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- 수강후기 -->
            <!-- <div class="courseReviewWrap">
                <div class="courseReview fc_fff">
                    <div class="fc_eg fz20">
                        레인보우에서는 비전공자도 충분히 수강할 수 있습니다.
                    </div>
                    <div class="fz40">
                        많은 수강생 분들이 남긴 수강후기를 확인하세요!
                    </div>
                    <div class="d-flex">
                        <div class="reviewBox">
                            <a href="">
                                <div class="companyName">취업회사명</div>
                                <div class="studentName">SCIT 30기 홍길동</div>
                            </a>
                        </div>
                        <div class="reviewBox">
                            <a href="">
                                <div class="companyName">취업회사명</div>
                                <div class="studentName">SCIT 30기 홍길동</div>
                            </a>
                        </div>
                        <div class="reviewBox">
                            <a href="">
                                <div class="companyName">취업회사명</div>
                                <div class="studentName">SCIT 30기 홍길동</div>
                            </a>
                        </div>
                    </div>
                    <div class="btn_normal btn_large btn_eg">
                        <a href="">수강후기 보러가기</a>
                    </div>
                </div>
            </div> -->
            <!-- 추천과정 -->
            <div class="RecommendationWrap">
                <div class="title_barPoint_wh fz40">추천과정</div>
                <div class="fz20">
                    <div class="fc_pp">다음 과정은 뭘 들을지 고민되시나요?
                    </div>
                    <div class="fc_333">
                        걱정하지마세요! 단계별로 학습하여 원하는 수준까지 도달! 학습의 방향성까지 제시해드립니다!
                    </div>
                </div>
                <div class="d-flex">
                    <div class="rcmdBox">
                        <a href="/smtp/course/short-term/short-term-info?course_id=c000000535">
                            <div class="rcmd_div">
                                PREV STEP
                            </div>
                            <div class="rcmd_img">
                                <img src="/upload/course/mainImg/2020122974661446.jpg" alt="입문:이제부터 파이썬" style="max-width: 100%; max-height: 100%; width: 100%; height: 100%;">
                            </div>
                            <div class="rcmd_txt">
                                &lt;입문 : 이제부터파이썬&gt;
                                <br>딥러닝을 위한 파이썬 기초과정
                            </div>
                        </a>
                    </div>
                    <div class="rcmdBox">
                    	<a href="/smtp/course/short-term/short-term-info?course_id=c000000537">
                            <div class="rcmd_div">
                                NEXT STEP
                            </div>
                            <div class="rcmd_img">
                                <img src="/upload/course/mainImg/2020122997552581.jpg" alt="파이썬 데이터분석 시각화" style="max-width: 100%; max-height: 100%; width: 100%; height: 100%;">
                            </div>
                            <div class="rcmd_txt">
                            	Python으로 배우는 데이터분석과 시각화
                            </div>
                        </a>
                    </div>
                    <div class="rcmdBox">
                    	<a href="/smtp/course/short-term/short-term-info?course_id=c000000538">
                            <div class="rcmd_div">
                                NEXT STEP
                            </div>
                            <div class="rcmd_img">
                                <img src="/upload/course/mainImg/2020122924831146.jpg" alt="AI개요와 딥러닝 개념" style="max-width: 100%; max-height: 100%; width: 100%; height: 100%;">
                            </div>
                            <div class="rcmd_txt">
                                AI개요와 딥러닝 개념
                            </div>
                        </a>
                    </div>
                </div>
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
    </div>
</body>

</html>
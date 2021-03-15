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
		var classNm = "${courseInfo.name}";
		var learnPeriod = "${courseInfo.selp_period}";
    </script>
</head>
<body>
    <div class="container_rainbow">
		<!-- 코딩 한 줄 없는 AI 활용하기 -->
		<!-- Header-include -->
		<%@include file="../../include/rainbow_header_basic.jsp"%>
<!-- 		<div id="codeTxtDiv"> -->
<%-- 			<c:out value="${courseInfo.page_codes}" escapeXml="false"/> --%>
<!-- 		</div> -->
																																																																																																																																						<div class="content sub-content sub02_content" id="main">
            <div class="background sub02-01_content">
                <div class="opacity_bg">
                    <div class="course-title fz40 fc_fff">
                    	코딩 한 줄없는 AI활용하기
					</div>
                </div>
            </div>
            <!-- 과정개요 -->
            <div class="courseGuideWrap">
                <div class="title_barPoint_wh fz40">과정개요</div>
                <p class="course_textWrap fz20">
                    이 강좌는 마이크로소프트에서 개발한 머신러닝 모델 개발 툴인 Azure(에저) Marchine Learning Studio를 활용하여 다양한 분야에서 적용 가능한 머신러닝 모델 개발 방법 및 알고리즘을 학습합니다.<br>
                    MS Azure Machine Learning Studio는 시각화된 도구로 프로그램 코딩에 대한 기초 지식이 없는 IT비전문가라 하더라도 클릭 몇 번으로 쉽게 머신러닝 모델을 개발할 수 있습니다.<br>
                    AI 기술을 클라우드에서 쉽게 사용할 수 있는 방법을 제시하고, 다양한 종류의 데이터를 기반으로 실제 비즈니스에 적용할 수 있는 머신러닝 모델을 개발해봄으로써 비즈니스에 어떤 변화를 줄 수 있는지를 실제 사례를 통해 확인할 수 있습니다.
                </p>
            </div>

            <!-- 수강효과 -->
            <div class="courseEffectWrapper">
                <div class="courseEffect">
                    <div class="fz40">
                        <!-- 강조하는문구 1 (민트색) -->
                        <div class="fc_eg">
                        	실전 머신러닝!
                        </div>
                        <!-- 강조하는문구 2 (흰색) -->
                        <div class="fc_fff">
                        	다양한 분야에 적용 가능한 머신러닝 모델 개발 방법 및 알고리즘까지!
                        </div>
                    </div>
                    <!-- 수강효과 설명 -->
                    <div class="fz20 fc_fff">
                    	이 강좌를 통해 보다 고차원적인 인공지능 응용프로그램 개발을 하시고자 하는 분들에게는 머신러닝 개발 프로세스 및 알고리즘 학습에 한층 더 쉽게 다가갈 수 있을 것으로 기대합니다.
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
                                머신러닝 및 알고리즘에 대한 기초지식이 필요한 자
                            </div>
                        </div>
                        <div class="targetBox">
                            <div class="target_img target02"></div>
                            <div class="target_txt">
                                머신러닝 응용프로그램 개발 분야로 입문을 하고자하는 자
                            </div>
                        </div>
                        <!-- <div class="targetBox">
                            <div class="target_img target03"></div>
                            <div class="target_txt">
                                AI를 활용한 관련 서비스 업무중인 자
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
                                	<img src="/upload/course/mainImg/2020122974107101.jpg" alt="코딩한줄없는 AI" style="max-width: 100%; max-height: 100%; width: 100%; height: 100%;">
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="cc_segWrap">
                        <div class="segmentWrap">
                            <ul class="seg-list fz20">
                            	<li>- MS Azure Machine Learning Studio 환경 구성하기</li>
                                <li>- Kaggle을 활용한 분석 데이터 수집</li>
                                <li>- 머신러닝 개론</li>
                                <li>- 도매상 고객 분류하기(비지도학습 - Clustering)</li>
                                <li>- 자동차 신모델 가격추측(지도학습 - Regression)</li>
                                <li>- 붓꽃 품종판별 예측(비지도학습 - Clustering, 지도학습 - Classification)</li>
                                <li>- 연봉 추정(지도학습 - Classification)</li>
                                <li>- 심장병 판별(지도학습 - Classification)</li>
                                <li>- 비행기 연착확률(지도학습 - Classification)</li>
                                <li>- 비행기 연착 데이터 분석을 통한 비행기 연착추측과 데이터 전처리 실습</li>
                            </ul>
                            <div class="btnWrap d-flex">
                                <div class="btn_normal btn_large btn_pp" onclick='location.href="/file_download?origin=코딩한줄 없는 AI 활용.pdf&saved=2020122862169521.pdf&path=uploadImage"'>
                                	<a href="/file_download?origin=코딩한줄 없는 AI 활용.pdf&saved=2020122862169521.pdf&path=uploadImage" download>커리큘럼 다운받기</a>
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
<!--             <div class="RecommendationWrap"> -->
<!--                 <div class="title_barPoint_wh fz40">추천과정</div> -->
<!--                 <div class="fz20"> -->
<!--                     <div class="fc_pp">다음 과정은 뭘 들을지 고민되시나요? -->
<!--                     </div> -->
<!--                     <div class="fc_333"> -->
<!--                         걱정하지마세요! 단계별로 학습하여 원하는 수준까지 도달! 학습의 방향성까지 제시해드립니다! -->
<!--                     </div> -->
<!--                 </div> -->
<!--                 <div class="d-flex"> -->
<!--                     <div class="rcmdBox"> -->
<!--                         <a href="/smtp/course/short-term/short-term-info?course_id=c000000535"> -->
<!--                             <div class="rcmd_div"> -->
<!--                                 PREV STEP -->
<!--                             </div> -->
<!--                             <div class="rcmd_img"> -->
<!--                                 <img src="/upload/course/mainImg/2020122974661446.jpg" alt="입문:이제부터 파이썬" style="max-width: 100%; max-height: 100%; width: 100%; height: 100%;"> -->
<!--                             </div> -->
<!--                             <div class="rcmd_txt"> -->
<!--                                 &lt;입문 : 이제부터파이썬&gt; -->
<!--                                 <br>딥러닝을 위한 파이썬 기초과정 -->
<!--                             </div> -->
<!--                         </a> -->
<!--                     </div> -->
<!--                     <div class="rcmdBox"> -->
<!--                     	<a href="/smtp/course/short-term/short-term-info?course_id=c000000538"> -->
<!--                             <div class="rcmd_div"> -->
<!--                                 NEXT STEP -->
<!--                             </div> -->
<!--                             <div class="rcmd_img"> -->
<!--                                 <img src="/upload/course/mainImg/2020122924831146.jpg" alt="AI개요와 딥러닝 개념" style="max-width: 100%; max-height: 100%; width: 100%; height: 100%;"> -->
<!--                             </div> -->
<!--                             <div class="rcmd_txt"> -->
<!--                                 AI개요와 딥러닝 개념 -->
<!--                             </div> -->
<!--                         </a> -->
<!--                     </div> -->
<!--                 </div> -->
<!--             </div> -->
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
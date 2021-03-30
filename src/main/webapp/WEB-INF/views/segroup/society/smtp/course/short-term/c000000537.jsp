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
		<!-- Python으로 배우는 데이터 분석과 시각화 -->
		<!-- Header-include -->
		<%@include file="../../include/rainbow_header_basic.jsp"%>
<!-- 		<div id="codeTxtDiv"> -->
<%-- 			<c:out value="${courseInfo.page_codes}" escapeXml="false"/> --%>
<!-- 		</div> -->
																																																																																																		<div class="content sub-content sub02_content" id="main">
            <div class="background sub02-01_content">
                <div class="opacity_bg">
                    <div class="course-title fz40 fc_fff">
                        Python으로 배우는 데이터 분석과 시각화
                    </div>
                </div>
            </div>
            <!-- 과정개요 -->
            <div class="courseGuideWrap">
                <div class="title_barPoint_wh fz40">과정개요</div>
                <p class="course_textWrap fz20">
                    Pandas는 Python으로 작성된 라이브러리입니다.
                    대량의 데이터를 표 형태인 Dataframe으로 작성하여 빅데이터를 가공하고 분석하거나 머신러닝을 위해서 데이터 전처리를 할 때 많이 사용됩니다.
                    <br>데이터를 처리하는데 엑셀도 많이 사용되지만 엑셀을 이용하여 많은 양의 데이터를 처리하려면 성능이 매우 떨어지는 등의 한계가 있기 때문에 프로그래밍 작업으로 데이터 처리를 하고자 할 때에는 Pandas가 훨씬 성능이 좋습니다.
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
                            대량의 데이터 분석 및 시각화!
                        </div>
                    </div>
                    <!-- 수강효과 설명 -->
                    <div class="fz20 fc_fff">
                        Pandas의 기초적인 사용방법에서부터 실생활에서 많이 사용되는 공공데이터 분석 및 시각화 하는 방법 까지!<br>
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
                                데이터 분석과 시각화에 대해 흥미가 있는 개발자
                            </div>
                        </div>
                        <div class="targetBox">
                            <div class="target_img target02"></div>
                            <div class="target_txt">
                                실무에서 사용되는 데이터를 분석하고 시각화 하는 방법에 대해 궁금한 대학생 또는 초급 개발자
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
                                    <img src="/upload/course/mainImg/2020122997552581.jpg" alt="입문 : 이제부터파이썬" style="max-width: 100%; max-height: 100%; width: 100%; height: 100%;">
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="cc_segWrap">
                        <div class="segmentWrap">
                            <ul class="seg-list fz20">
                                <li>- 개발환경 설정 및 Numpy, Pandas 모듈 설치</li>
                                <li>- 데이터 프레임과 시리즈 작성</li>
                                <li>- 데이터 프레임 다루기</li>
                                <li>- 판다스 자료형</li>
                                <li>- 데이터의 추출</li>
                                <li>- 데이터 정제(누락값 처리, 중복 데이터 처리 등)</li>
                                <li>- 피벗의 사용</li>
                                <li>- 그룹 연산(group by와 agg함수를 이용한 데이터 집계)</li>
                                <li>- 데이터 필터링</li>
                                <li>- 시계열 데이터 다루기</li>
                                <li>- 사례 별 데이터 처리방법</li>
                                <li>- matplotlib을 이용한 시각화</li>
                            </ul>
                            <div class="btnWrap d-flex">
                                <div class="btn_normal btn_large btn_pp" onclick='location.href="/file_download?origin=파이썬으로 배우는 데이터분석과 시각화.pdf&saved=2021030833707954.pdf&path=uploadImage"'>
                                    <a href="#" onclick="return false;">커리큘럼 다운받기</a>
                                </div>
                                 <!-- <div class="btn_normal btn_large btn_pp_bg margin-left20 ">
                                    <a href="sub02-01-01.html">수강신청 하러가기</a>
                                </div> -->
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
                                <img src="/upload/course/mainImg/2020122974661446.jpg" alt="입문 : 이제부터파이썬" style="max-width: 100%; max-height: 100%; width: 100%; height: 100%;">
                            </div>
                            <div class="rcmd_txt">
                                &lt;입문 : 이제부터파이썬&gt;
                                <br>딥러닝을 위한 파이썬 기초과정
                            </div>
                        </a>
                    </div>
                    <div class="rcmdBox">
                        <a href="/smtp/course/short-term/short-term-info?course_id=c000000539">
                            <div class="rcmd_div">
                                NEXT STEP
                            </div>
                            <div class="rcmd_img">
                                <img src="/upload/course/mainImg/2020122974107101.jpg" alt="코딩 한 줄 없는 AI활용하기" style="max-width: 100%; max-height: 100%; width: 100%; height: 100%;">
                            </div>
                            <div class="rcmd_txt">
                                코딩 한 줄 없는 AI활용하기
                            </div>
                        </a>
                    </div>
                    <div class="rcmdBox">
                        <a href="/smtp/course/short-term/short-term-info?course_id=c000000540">
                            <div class="rcmd_div">
                                NEXT STEP
                            </div>
                            <div class="rcmd_img">
                                <img src="/upload/course/mainImg/2020122988284586.jpg" alt="Python을 이용한 웹스크래핑" style="max-width: 100%; max-height: 100%; width: 100%; height: 100%;">
                            </div>
                            <div class="rcmd_txt">
                                Python을 이용한 웹스크래핑
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
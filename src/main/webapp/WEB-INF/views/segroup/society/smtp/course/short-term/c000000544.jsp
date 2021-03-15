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
		<!-- 일본취업 스킬업 -->
		<!-- Header-include -->
		<%@include file="../../include/rainbow_header_basic.jsp"%>
<!-- 		<div id="codeTxtDiv"> -->
<%-- 			<c:out value="${courseInfo.page_codes}" escapeXml="false"/> --%>
<!-- 		</div> -->
																																																																																																																																						<div class="content sub-content sub02_content" id="main">
            <div class="background sub02-11_content">
                <div class="opacity_bg">
                    <div class="course-title fz40 fc_fff">
                    	일본취업 스킬업
					</div>
                </div>
            </div>
            <!-- 과정개요 -->
            <div class="courseGuideWrap">
                <div class="title_barPoint_wh fz40">과정개요</div>
                <p class="course_textWrap fz20">
                	일본어 우수자를 대상으로 취업전략교육을 집중적으로 실시하는 단기과정입니다.
                	<br>
                	취업준비가 막막하여 계획이 세워지지 않거나, 자격요건은 충분한 것 같은데 서류전형에서 탈락하거나, 실전 면접에 약한 분들에게 본 과정의 수강을 추천 드립니다.
                </p>
            </div>

            <!-- 수강효과 -->
            <div class="courseEffectWrapper">
                <div class="courseEffect">
                    <div class="fz40">
                        <!-- 강조하는문구 1 (민트색) -->
                        <div class="fc_eg">
                        	“자기분석부터 모의면접까지”
                        </div>
                        <!-- 강조하는문구 2 (흰색) -->
                        <div class="fc_fff">
                        	이력서 작성의 기초인 자기분석법부터
                        	<br>
                        	실전 면접에서 당당히 합격할 수 있는 면접 대비 방법까지,
                        	<br>
							취업성공으로 이어질 여러분들의 잠재력을 끌어올려드립니다.
                        </div>
                    </div>
                    <!-- 수강효과 설명 -->
                    <div class="fz20 fc_fff">
                    	2021년 상반기 Bridge JOB Fair에 대비한 맞춤 취업전략도 함께 알려드립니다.
                    </div>
                </div>
            </div>
            <!-- 수강대상 -->
            <div class="courseTargetWrap">
                <div class="title_barPoint_wh fz40">수강대상</div>
                <div class="targetWrap target01">
                    <div class="fz20">
                    </div>
                    <div class="targetBoxWrap d-flex">
                        <div class="targetBox">
                            <div class="target_img target01"></div>
                            <div class="target_txt">
                            	일본어 공인시험 성적소지자(JLPT N2이상/또는 그에 상응하는 레벨)
                            </div>
                        </div>
                        <div class="targetBox">
                            <div class="target_img target02"></div>
                            <div class="target_txt">
                            	희망직무 관련 전공자 또는 자격증 소지자 (일본어, 정보통신공학, 경영학, 기전계 등)
                            </div>
                        </div>
                        <div class="targetBox">
                            <div class="target_img target03"></div>
                            <div class="target_txt">
                            	직무관련 교육 없이 취업정보를 학습하여 바로 취업하고자 하는 예비 사회인
                            </div>
                        </div>
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
                            	<div class="courseTitle fz20 fc_fff">
                            		&lt;일본취업 스킬업&gt;
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="cc_segWrap">
                        <div class="segmentWrap">
                            <ul class="seg-list fz20">
                            	<li>Biz 일본어 (경어, 메일작성)</li>
                                <li>취업전략</li>
                                <li>- 자기분석</li>
                                <li>- 이력서, 포트폴리오/자기PR영상</li>
                                <li>- 기업별 채용전형 대비(SPI/작문/평가대비)</li>
                                <li>- 면접전략, 모의면접</li>
                            </ul>
<!--                             <div class="btnWrap d-flex"> -->
<!--                                 <div class="btn_normal btn_large btn_pp"> -->
<!--                                 	 <a href="/file_download?origin=Python.pdf&saved=2020122819307696.pdf&path=uploadImage" download>커리큘럼 다운받기</a> -->
<!--                                 </div> -->
<!--                                 <div class="btn_normal btn_large btn_pp_bg margin-left20 "> -->
<!--                                     <a href="sub02-01-01.html">수강신청 하러가기</a> -->
<!--                                 </div> -->
<!--                             </div> -->
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
<!--                     	<a href="/smtp/course/short-term/short-term-info?course_id=c000000536"> -->
<!--                             <div class="rcmd_div"> -->
<!--                                 NEXT STEP -->
<!--                             </div> -->
<!--                             <div class="rcmd_img"> -->
<!--                             	<img src="/upload/course/mainImg/2020122963527171.jpg" alt="Python기반 데이터 사이언스 기초" style="max-width: 100%; max-height: 100%; width: 100%; height: 100%;"> -->
<!--                             </div> -->
<!--                             <div class="rcmd_txt"> -->
<!--                             	Python기반 데이터 사이언스 기초 -->
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
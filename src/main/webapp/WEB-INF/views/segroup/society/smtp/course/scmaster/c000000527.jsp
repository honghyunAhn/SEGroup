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
		<!-- 미융복합 SW인력 양성과정 -->
		<!-- Header-include -->
		<%@include file="../../include/rainbow_header_basic.jsp"%>
<!-- 		<div id="codeTxtDiv"> -->
<%-- 			<c:out value="${courseInfo.page_codes}" escapeXml="false"/> --%>
<!-- 		</div> -->
																																																																																																																																						<div class="content sub-content sub02_content" id="main">
            <div class="background sub02-01_content">
                <div class="opacity_bg">
                    <div class="course-title fz40 fc_fff">
                    	미 융복합 SW인력 양성과정
					</div>
                </div>
            </div>
            <!-- 과정개요 -->
            <div class="courseGuideWrap">
                <div class="title_barPoint_wh fz40">과정개요</div>
                <p class="course_textWrap fz20">
                	한미 양국 간의 문화교류 프로그램으로, 대학 및 사회에서 배운 지식과 경력을 기반으로 하여 미국 내 기업에서 유급 인턴으로 일하며 영어는 물론 실무 지식 습득 및 업무경험을 쌓도록 제공하는 과정입니다.
                	<br>
 미국 인턴십 취업을 위해 외국어 교육에 집중을 하는 동시에 직무를 수행하는데 부족하지 않도록 디지털 역량강화 교육과 기업매칭 서비스를 제공합니다.
                </p>
            </div>

            <!-- 수강효과 -->
            <div class="courseEffectWrapper">
                <div class="courseEffect">
                    <div class="fz40">
                        <!-- 강조하는문구 1 (민트색) -->
                        <div class="fc_eg">
                        	“미국 유급 인턴십 취업을 위한 단계 Lv.0 부터 Lv.10까지”
                        </div>
                        <!-- 강조하는문구 2 (흰색) -->
                        <div class="fc_fff">
                        	미국, 일본 등 해외취업률 90%이상 달성을 자랑하는 Soft Engineer Society에서 도와드립니다. 
                        </div>
                    </div>
                    <!-- 수강효과 설명 -->
                    <div class="fz20 fc_fff">
                    	한국무역협회(KITA)와 컨소시움으로 운영 하는 신뢰도 높은 기관에서 정부지원금으로 직무교육과 영어 교육을 받는 동시에 인턴십 취업을 준비하는 과정입니다.
                    </div>
                </div>
            </div>
            <!-- 수강대상 -->
            <div class="courseTargetWrap">
                <div class="title_barPoint_wh fz40">수강대상</div>
                <div class="targetWrap target01">
                    <div class="fz20">
                        <div class="fc_333">해당 과정은 다음과 같은 분들을 대상으로 합니다.</div>
                    </div>
                    <div class="targetBoxWrap d-flex">
                        <div class="targetBox">
                            <div class="target_img target01"></div>
                            <div class="target_txt">
                            	미국 외 국가 대학 졸업예정자
                            </div>
                        </div>
                        <div class="targetBox">
                            <div class="target_img target02"></div>
                            <div class="target_txt">
                            	미국 외 국가 졸업 1년 이내인 자
                            </div>
                        </div>
                        <div class="targetBox">
                            <div class="target_img target03"></div>
                            <div class="target_txt">
                            	미국 외 국가 졸업 후 경력 1년 이상인 자
                            </div>
                        </div>
                    </div>
                </div>
                <div class="targetWrap target02">
                    <div class="fz20">
                    	위 3가지 조건 중 1가지를 충족하는 자로서, 인턴십으로 갈 직무와 전공/경력이 관련이 있어야 합니다.
                    </div>
<!--                     <div class="targetBoxWrap d-flex justify_between"> -->
<!--                         <div class="targetBox"> -->
<!--                             <div class="target_img target04"></div> -->
<!--                             <div class="target_txt"> -->
<!--                                 딥러닝에 관심은 있는데 시작할 엄두가 안나는 비전공자 -->
<!--                             </div> -->
<!--                         </div> -->
<!--                         <div class="targetBox"> -->
<!--                             <div class="target_img target05"></div> -->
<!--                             <div class="target_txt"> -->
<!--                                 이론만 알고 적용은 해본적 없는, 못하는 애매한 입문자 -->
<!--                             </div> -->
<!--                         </div> -->
<!--                         <div class="targetBox"> -->
<!--                             <div class="target_img target06"></div> -->
<!--                             <div class="target_txt"> -->
<!--                                 딥러닝을 배우고 싶지만 막막한 현업자 -->
<!--                             </div> -->
<!--                         </div> -->
<!--                     </div> -->
                </div>
            </div>
            <!-- 수강기간 -->
            <div class="coursePeriodWrap">
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
            </div>
            <!-- 커리큘럼 -->
            <div class="curriculumWrap">
                <div class="title_barPoint_wh fz40">커리큘럼</div>
                <div class="curriculum d-flex">
                    <div class="cc_imgWrap">
                        <div class="background">
                            <div class="opacity_bg">
                            	<div class="courseTitle fz20 fc_fff">
                            		미 융복합 SW인력 양성과정
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="cc_segWrap">
                        <div class="segmentWrap">
                            <ul class="seg-list fz20">
                            	<li>General English</li>
                                <li>Business English</li>
                                <li>영문 이력서 작성</li>
                                <li>영어 인터뷰 준비</li>
                                <li>Microsoft Office (Word, Excel, Powerpoint)</li>
                                <li>Design Tool</li>
                                <li>Web Service 기획</li>
								<li>Web Front-end</li>
								<li>Azure를 이용한 데이터 분석</li>
								<li>R 프로그래밍</li>
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
<!--                 <div class="title_barPoint_wh fz40">추천 사전학습과정</div> -->
<!--                 <div class="fz20"> -->
<!--                 	<div class="fc_pp">수강 전 무엇을 준비해야 하는지 고민되시나요? -->
<!--                     </div> -->
<!--                     <div class="fc_333"> -->
<!--                         걱정하지마세요! 단계별로 학습하여 원하는 수준까지 도달! 학습의 방향성까지 제시해드립니다! -->
<!--                     </div> -->
<!--                 </div> -->
<!--                 <div class="d-flex"> -->
<!--                     <div class="rcmdBox"> -->
<!--                     	<a href="https://www.softsociety.net/smtp/course/short-term/short-term-info?course_id=c000000543"> -->
<!--                             <div class="rcmd_div"> -->
<!--                                 바로가기 -->
<!--                             </div> -->
<!--                             <div class="rcmd_img"> -->
<!--                                 <img src="/upload/course/mainImg/2021010617412648.jpg" alt="sw do 사전학습반" style="max-width: 100%; max-height: 100%; width: 100%; height: 100%;"> -->
<!--                             </div> -->
<!--                             <div class="rcmd_txt"> -->
<!--                                [오프라인] SW DO 사전학습반 -->
<!--                             </div> -->
<!--                         </a> -->
<!--                     </div> -->
<!--                     <div class="rcmdBox"> -->
<!--                     	<a href="https://www.softsociety.net/lms/course/search/movePage?course_id=c000000383&grand=ICT"> -->
<!--                             <div class="rcmd_div"> -->
<!--                                 바로가기 -->
<!--                             </div> -->
<!--                             <div class="rcmd_img"> -->
<!--                             	<img src="/upload/course/mainImg/2020082581511079.gif" alt="쉽게 배우는 Java 알고리즘 입문" style="max-width: 100%; max-height: 100%; width: 100%; height: 100%;"> -->
<!--                             </div> -->
<!--                             <div class="rcmd_txt"> -->
<!--                             	[온라인] 쉽게 배우는 Java 알고리즘 입문 -->
<!--                             </div> -->
<!--                         </a> -->
<!--                     </div> -->
<!--                     <div class="rcmdBox"> -->
<!--                     	<a href="https://www.softsociety.net/lms/course/search/movePage?course_id=c000000298&grand=%EC%99%B8%EA%B5%AD%EC%96%B4"> -->
<!--                             <div class="rcmd_div"> -->
<!--                                 바로가기 -->
<!--                             </div> -->
<!--                             <div class="rcmd_img"> -->
<!--                             	<img src="/upload/course/mainImg/2020032482073857.jpg" alt="일본어 초급" style="max-width: 100%; max-height: 100%; width: 100%; height: 100%;"> -->
<!--                             </div> -->
<!--                             <div class="rcmd_txt"> -->
<!--                             	[온라인] 일본어 초급 -->
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
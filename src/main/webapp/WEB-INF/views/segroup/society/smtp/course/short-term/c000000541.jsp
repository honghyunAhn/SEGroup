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
        document.domain='softsociety.net';
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
		<!-- 일본취업을 위한 JPT&SJPT -->
		<!-- Header-include -->
		<%@include file="../../include/rainbow_header_basic.jsp"%>
<!-- 		<div id="codeTxtDiv"> -->
<%-- 			<c:out value="${courseInfo.page_codes}" escapeXml="false"/> --%>
<!-- 		</div> -->
																																																																																																																																						<div class="content sub-content sub02_content" id="main">
            <div class="background sub02-11_content">
                <div class="opacity_bg">
                    <div class="course-title fz40 fc_fff">
                    	일본취업을 위한 JPT&SJPT
					</div>
                </div>
            </div>
            <!-- 과정개요 -->
            <div class="courseGuideWrap">
                <div class="title_barPoint_wh fz40">과정개요</div>
                <p class="course_textWrap fz20">
                    본 과정은 일본취업을 원활히 하기 위한 일본어 단기과정입니다.
                    <br>
                    객관적인 일본어 역량지표를 획득하는 것을 목표로, 면접대비를 위해 회화력을 강화하며 코로나 19로 인한 JPLT(일본어능력시험) 실시 취소 등에 따른 대안으로 향후 수시로 개설될 예정입니다.
                    <br>
                    현재, 일본취업을 희망하는 인원 혹은 일본어 자격증이 없거나 점수 갱신이 필요한 인원은 본 단기과정을 준비하시는 것을 추천합니다.
                    <br>
                    ※취업연계과정 수강 중인 연수생은 일본어 평가성적에 추가 반영 가능(자세한 사항은 가정 담당자와 상담要)
                </p>
            </div>

            <!-- 수강효과 -->
            <div class="courseEffectWrapper">
                <div class="courseEffect">
                    <div class="fz40">
                        <!-- 강조하는문구 1 (민트색) -->
                        <div class="fc_eg">
                        	면접 전문 원어민 강사 투입!
                        </div>
                        <!-- 강조하는문구 2 (흰색) -->
                        <div class="fc_fff">
                        	맞춤형 수업을 위한 강사 1:1 피드백!
                        </div>
                    </div>
                    <!-- 수강효과 설명 -->
                    <div class="fz20 fc_fff">
                    	일본기업면접 대비를 위한 회화력 강화를 위해
                    	<br>
                    	긴 시간 일본취업 지도 경력의 전문강사가 사례 및 자연스러운 스피치 기술 등을 전수합니다.
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
                            	취업연계과정 연수생
                            </div>
                        </div>
                        <div class="targetBox">
                            <div class="target_img target02"></div>
                            <div class="target_txt">
                            	일본취업 희망자
                            </div>
                        </div>
                        <div class="targetBox">
                            <div class="target_img target03"></div>
                            <div class="target_txt">
                            	日자격증 갱신 필요자
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
<!--                             <div class="fz20"> -->
<!--                                 <div class="fc_eg">직장이나 학교 때문에 결석이 결정이시라구요?</div> -->
<!--                                 <div class="fc_fff"> -->
<!--                                 	걱정하지마세요! 한 두번 결석하더라도 따라갈 수 있도록, 결석 시 당일 강의 영상을 제공해드립니다. -->
<!--                                 </div> -->
<!--                             </div> -->
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
                                	 <img src="/upload/course/mainImg/2020122993650209.jpg" alt="JPT/SJPT" style="max-width: 100%; max-height: 100%; width: 100%; height: 100%;">
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="cc_segWrap">
                        <div class="segmentWrap">
                            <ul class="seg-list fz20">
                            	<li><strong>■ JPT클래스(600/800점)</strong></li>
                                <li>- 청해 : 사진묘사/질의응답/회화문/설명문 등 문제풀이</li>
                                <li>- 독해 : 정답찾기/오문정정/공란메우기/독해 등 문제풀이</li>
                                <li>- 문제유형별 풀이방법(스킬) 반복 지도</li>
                                <li>- 모의고사 등 과제 제공</li>
                                <li>- 채점 및 결과 피드백</li>
                                <li>- 취약파트에 대한 풀이 강도 UP</li>
                                <li class="margin-top20">
                                    <strong>■ SJPT클래스(예상 레벨 5~10)</strong>
                                </li>
                                <li>- SJPT 교재방식으로의 회화연습</li>
                                <li>- 발음 체크</li>
                                <li>- 청해력 체크</li>
                                <li>- 모의테스트</li>
                                <li>- 日드라마로 배우는 실생활 회화</li>
                                <li>- 채점 및 결과 피드백</li>
                                <li>- 취약파트에 대한 원어민 강사의 집중지도</li>
                            </ul>
                            <div class="btnWrap d-flex">
                            	<div class="btn_normal btn_large btn_pp" onclick='location.href="/file_download?origin=일본취업을_위한_JPT_SJPT.pdf&saved=2020122979017540.pdf&path=uploadImage"'>
                            		<a href="/file_download?origin=일본취업을_위한_JPT_SJPT.pdf&saved=2020122979017540.pdf&path=uploadImage" download>커리큘럼 다운받기</a>
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
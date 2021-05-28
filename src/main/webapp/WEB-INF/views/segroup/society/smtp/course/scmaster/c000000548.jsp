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
		<!-- ABC 마스터 -->
		<!-- Header-include -->
		<%@include file="../../include/rainbow_header_basic.jsp"%>
<!-- 		<div id="codeTxtDiv"> -->
<%-- 			<c:out value="${courseInfo.page_codes}" escapeXml="false"/> --%>
<!-- 		</div> -->
																																																																																																																																						<div class="content sub-content sub02_content" id="main">
            <div class="background sub02-01_content">
                <div class="opacity_bg">
                    <div class="course-title fz40 fc_fff">
                    	&lt;Digital ABC 마스터 과정&gt;
					</div>
                </div>
            </div>
            <!-- 과정개요 -->
            <div class="courseGuideWrap">
                <div class="title_barPoint_wh fz40">과정개요</div>
                <p class="course_textWrap fz20">
					2001년 이후 한국무역협회와 함께 글로벌 ICT 전문 인력을 양성해온 Soft Engineer Society는 
					지역청년을 위한 교육센터를 광주(2018)에 이어 부산(2021)에 개소합니다.
					부산교육센터에서 첫 번째로 런칭하는 교육과정은 지년 21년간 취업률 97%를 기록했던 일본 ICT 직무 취업연계과정인 
「Digital ABC 마스터」 과정(K-MOVE 스쿨)입니다. 
					<br>
프로그래밍, 디지털/AI, 외국어(일본어) 등의 커리큘럼으로 구성되며 글로벌 ICT기업 정규직 취업을 목표로 하고 있습니다.
				</p>
            </div>
            <!-- 수강효과 -->
            <div class="courseEffectWrapper">
                <div class="courseEffect">
                    <div class="fz40">
                        <!-- 강조하는문구 1 (민트색) -->
                        <div class="fc_eg">
                        	미래지향 글로벌 인재로 거듭날 수 있는 기회!
                        </div>
                        <!-- 강조하는문구 2 (흰색) -->
                        <div class="fc_fff">
                        	<span style="font-size: 60px;">A</span>I, 
                        	<span style="font-size: 60px;">B</span>ig-data, 
                        	<span style="font-size: 60px;">C</span>loud 
                        	<span style="font-size: 60px;">마스터</span>하고,<br>
                        	글로벌 기업에서 커리어를 시작하자!                       	
                        </div>
                    </div>
                    <!-- 수강효과 설명 -->
                    <div class="fz20 fc_fff">
                    	#해외취업 #일본취업 #SW취업 #부산현지교육과정
                    </div>
                </div>
            </div>
            <!-- 수강대상 -->
            <div class="courseTargetWrap">
                <div class="title_barPoint_wh fz40">수강대상</div>
                <div class="targetWrap target01">
                    <div class="fz20">
                    	<div class="fc_pp">IT/일본어 전공자, 비전공자 모두 환영합니다!</div>
						<div class="fc_333">ABC 마스터과정은 다음과 같은 분들을 대상으로 합니다.</div>
                    </div>
                    <div class="targetBoxWrap d-flex">
                        <div class="targetBox">
                            <div class="target_img target01"></div>
                            <div class="target_txt">
                            	- 2/4년제 대학 졸업자 및 예정자(2022. 03)
                            </div>
                        </div>
                        <div class="targetBox">
                            <div class="target_img target02"></div>
                            <div class="target_txt">
                            - 만 34세 이하 대한민국 청년
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
<!--                             	<div class="fc_eg">코로나 바이러스? 걱정마세요!</div> -->
<!-- 								<div class="fc_fff"> -->
<!-- 									코로나 바이러스 확산에 대비하여 온라인/오프라인 Blended 수업을 실시합니다. -->
<!-- 								</div> -->
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
									&lt;Digital ABC 마스터 과정&gt;
								</div>
                            </div>
                        </div>
                    </div>
                    <div class="cc_segWrap d-flex justify_center">
                        <div class="segmentWrap">
                            <ul class="seg-list fz20">
								<li><strong>■ ICT 교육</strong></li>
								<li>
									컴퓨터 활용 기초부터 프로그래밍 언어를 활용한 웹 개발,
									<br>
									클라우드 기반의 서비스 관리,
									데이터를 활용한 AI 분야까지
									<br>
									배울 수 있습니다.
									<br>
									이론 수업과 단계별 실습을 통해 다양한 기술을 경험하고
									<br> 
									ICT분야 진출하기 위한 직무능력을 갖추게 됩니다.
								</li>
								<li><br></li>
								<li>- 컴퓨터 활용 기초</li>
								<li>- 프로그래밍 언어</li>
								<li>- 자료구조와 알고리즘</li>
								<li>- 웹 프로그래밍</li>
								<li>- 프레임워크 활용</li>
								<li>- 리눅스 서버 운영</li>
								<li>- 클라우드 기반 서비스 관리</li>
								<li>- 데이터 분석 및 시각화</li>
								<li>- AI 활용</li>
								<li>- 프로젝트 분석 및 설계</li>
								<li>- 기술면접대비</li>
								<li>- 포트폴리오 작성</li>
								<li class="margin-top20"></li>
								<li><strong>■ 외국어 교육</strong></li>
								<li>
									일본어 기초 문법과 회화부터 면접을 위한 비즈니스
									<br>
									일본어까지 취업에 최적화된 교육을 제공합니다.
									<br>
									개개인의 일본어 역량을 파악하고 소그룹으로 나누어
									<br>
									레벨에 맞게 교육을 진행합니다. 
								</li>
								<li><br></li>
								<li>- 기초 문법 및 회화</li>
								<li>- 어휘/작문/독해</li>
								<li>- 주제별 회화능력 향상</li>
								<li>- 비즈니스 문서 작성</li>
								<li>- 비즈니스 회화</li>
								<li>- 프레젠테이션</li>
								<li>- JPT 특별시험</li>
								<li>- 이력서 작성</li>
								<li>- 모의면접</li>
								<li>- 일본기업 문화</li>
								<li class="margin-top20"></li>
								<li><strong>정규 교육 외 취업역량향상을 위해 다음과 같은 교육을 실시합니다.</strong></li>
								<li>- 일본 ICT산업 재직자(졸업자 등) 초청 특강 및 토크콘서트</li>
								<li>- 일본취업 커리어 관리</li>
								<li>- 개별 면접 코칭 및 매너</li>
								<li>- 기술 트랜드 특강</li>
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
            
            <img style="width : 100%;" src="/resources/segroup/society/smtp/img/course_back_sub02-01-digitalAbc01.jpg" alt="O2O 교육 플랫폼, 교육시설 및 장비, 교육장소 안내 및 과정FAQ">
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
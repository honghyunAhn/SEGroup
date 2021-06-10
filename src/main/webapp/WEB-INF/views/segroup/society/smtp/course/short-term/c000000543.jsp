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
		<!-- 코딩챌린지 -->
		<!-- Header-include -->
		<%@include file="../../include/rainbow_header_basic.jsp"%>
<!-- 		<div id="codeTxtDiv"> -->
<%-- 			<c:out value="${courseInfo.page_codes}" escapeXml="false"/> --%>
<!-- 		</div> -->
																																																																																																																																						<div class="content sub-content sub02_content" id="main">
            <div class="background sub02-01_content bg_challenge">
                <div class="opacity_bg">
                    <!-- <div class="course-title fz40 fc_fff">
						 &lt;SoftWare DevOps 마스터 사전학습과정&gt;
						<br>광주/전남특화 SWDO마스터 - 글로벌SW인재양성과정 
					</div> -->
                </div>
            </div>
            <!-- 과정개요 -->
            <div class="courseGuideWrap">
                <div class="title_barPoint_wh fz40">과정개요</div>
                <p class="course_textWrap fz20">
		        	AI 빅데이터, 딥러닝, 4차산업혁명 등 말만 들어도 머리 아프죠? 😱<br>
		        	뉴스, 미디어, 소셜 등에서 매일 같이 쏟아지는 IT 관련 뉴스들.. 세상이 뭔가 크게 바뀌고 있는데..<br>
		        	그게 뭔지는 잘 모르겠고😰 IT분야인건 맞는 것 같은데 문과생에게는 너무나 먼 얘기?<br>
		        	코린이, 웹린이👶 복잡하게 묻지도 따지지도 말고! 코딩챌린지 과정을 시작하자! 🙌
		    	</p>
            </div>
			<!-- 수강효과 -->
            <div class="courseEffectWrapper">
                <div class="courseEffect">
                    <div class="fz40">
                        <!-- 강조하는문구 1 (민트색) -->
                        <div class="fc_eg">
							회차별로 진행되는 프로그래밍 첫걸음 !! 
                        </div>
                        <!-- 강조하는문구 2 (흰색) -->
                        <div class="fc_fff">
                        	챌린지 3개 달성하고 수강료 50% 환급받자!👍
                        </div>
                    </div>
                    <!-- 수강효과 설명 -->
                    <div class="fz20 fc_fff">
                    	출석률(90% 이상), 수업 성실도(90% 이상), 평가 스코어(80점 이상)<br>챌린지 3개 달성시 수강료 무려 50%나 환급!! ㄴ😮ㄱ
                    </div>
                </div>
            </div>
			<img style="width : 100%;" src="/resources/segroup/society/smtp/img/course_sub02-01-chanllenge01.jpg" alt="코딩 챌린지 과정을 선택해야하는 이유">
            
            <!-- 커리큘럼 -->
            <div class="curriculumWrap">
                <div class="title_barPoint_wh fz40">커리큘럼</div>
                <div class="curriculum d-flex">
                    <div class="cc_imgWrap">
                        <div class="background">
                            <div class="opacity_bg">
                            	<div class="courseTitle fz20 fc_fff">
                                    &lt;코딩 챌린지&gt;
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="cc_segWrap">
                        <div class="segmentWrap">
                            <ul class="seg-list fz20">
                                <li>■ ICT 기초프로그래밍 완전정복 (프로그래밍의 이해, 알고리즘 구현 등)</li>
		                        <li>1. 프로그래밍 기초 - 기본 알고리즘, 자료형, 연산자, 제어문, 배열</li>
		                        <li>2. 객체지향프로그래밍 - 객체지향 프로그래밍의 개요와 특징 </li>
		                        <li>3. 4차산업혁명을 대비한 프로그램밍의 이해</li>
		                        <li>4. 기본 알고리즘 구현을 위한 코딩</li>
		                        <li><br></li>
		                        <li>■ 히라가나부터 현장 일본어까지 준비 기초회화 완전정복</li>
								<li>1. 기초문법, 회화, 어휘, 독해</li>
								<li>2. 일본 직장내에티켓 - 일본 기업문화의 이해</li>
								<li>3. 일본 문화 - 일본 생활문화의 이해</li>
								<li>4. 일본 IT 기초 회화 - 일본 IT 기업문화의 특징 및 이해</li>
								<li><br></li>
								<li>■ 미국정복첫걸음 실전 영어</li>
								<li>1. 현지에서 바로 사용하는 말하기 </li>
								<li>2. 엘크 그로브 빌리지 </li>
								<li>3. IL 취업전략</li>
								<li>4. 비즈니스 잉글리쉬</li>
                            </ul>
<!--                             <div class="btnWrap d-flex"> -->
<!--                                 <div class="btn_normal btn_large btn_pp"> -->
<!--                                     <a href="/file_download?origin=Python.pdf&saved=2020122819307696.pdf&path=uploadImage" download>커리큘럼 다운받기</a> -->
<!--                                 </div> -->
<!--                                 <div class="btn_normal btn_large btn_pp_bg margin-left20 "> -->
<!--                                     <a href="sub02-01-01.html">수강신청 하러가기</a> -->
<!--                                 </div> -->
<!--                             </div> -->
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- 수강대상 -->
            <div class="courseTargetWrap">
                <div class="title_barPoint_wh fz40">수강대상</div>
                <div class="targetWrap target01">
                    <div class="fz20">
                    	<div class="fc_pp">문과생, 초보자도 무섭지 않아요!</div>
		            	<div class="fc_333">누구나 쉽게 접근할수 있는 난이도 조절 진행 방식과 디테일한 강의 코치!</div>
                    </div>
                    <div class="targetBoxWrap d-flex">
                        <div class="targetBox">
                            <div class="target_img target01"></div>
                            <div class="target_txt">
                                IT 분야 및 프로그래에 대한 관심 대상자
                            </div>
                        </div>
                        <div class="targetBox">
                            <div class="target_img target02"></div>
                            <div class="target_txt">
								해외취업 진출 분야 선택시 IT직군 진출자 
                            </div>
                        </div>
                        <div class="targetBox">
                            <div class="target_img target03"></div>
                            <div class="target_txt">
                            	대학생/취준생/졸업생/직장인등 역량개발이 필요한자
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
                                <div class="fc_eg">코로나 바이러스? 걱정마세요!</div>
                                <div class="fc_fff">
                                	코로나 바이러스 확산에 대비하여 서울/광주/부산 통합 실시간 온라인/오프라인 Blended 수업을 실시합니다.                              	
                                </div>
                            </div>
                            <div class="fc_fff"><br>※ 오프라인 수업 진행시 각 지역 교육장소 출석 상기 일정은 사정에 따라 변동이 있을 수 있습니다.</div>
                            <div class="d-flex justify_between applyCardinal">
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
                        <a href="https://www.softsociety.net/lms/course/search/movePage?course_id=c000000383&grand=ICT">
                            <div class="rcmd_div">
                            	바로가기
                            </div>
                            <div class="rcmd_img">
                            	<img src="/upload/course/mainImg/2020082581511079.gif" alt="쉽게 배우는 Java 알고리즘 입문" style="max-width: 100%; max-height: 100%; width: 100%; height: 100%;">
                            </div>
                            <div class="rcmd_txt">
                                [온라인] 쉽게 배우는 JAVA 알고리즘 입문
                            </div>
                        </a>
                    </div>
                    <div class="rcmdBox">
                    	<a href="https://www.softsociety.net/lms/course/search/movePage?course_id=c000000298&grand=%EC%99%B8%EA%B5%AD%EC%96%B4">
                            <div class="rcmd_div">
                            	바로가기
                            </div>
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
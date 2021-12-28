<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
	<%@include file="../../../include/rainbow_head.jsp"%>
    <script src="/resources/segroup/society/smtp/js/rainbowScript_courseDetail.js"></script>
    <script type="text/javascript">
	    const dDay = new Date("${courseInfo.APP_END_DATE}"+", 23:59:59").getTime();
		const endDate = new Date();
		
		$(function() {
			app_final_day("${courseInfo.APP_END_DATE}");
			class_time("${courseInfo.LEARN_START_DATE}", "${courseInfo.LEARN_END_DATE}", "${courseInfo.CLASS_DAY}", "${courseInfo.CLASS_START_TIME}", "${courseInfo.CLASS_END_TIME}" , "${courseInfo.SELP_PERIOD}");
			graduation("${courseInfo.LEARN_END_DATE}");
			period("${courseInfo.APP_START_DATE}")
			expenses("${courseInfo.PRICE}", "${edu_curriculum_pay.PAY_CRC_AMOUNT}");
		});
    </script>
</head>

<body>
    <div class="container_rainbow container-courseDetail bgc_eee">
    	<%@include file="../../../include/rainbow_header.jsp"%>
        <div class="content course-detail course-point01" id="main">
            <div class="mainBackVideoWrap" onclick="togglePlay()">
                <div class="background_video video_main">
                    <video src="/resources/segroup/society/smtp/video/02ICT_Office.mp4" width='100%' autoplay loop muted>
                    </video>
                    <div class="opacity_bg op08" id="scrollFixed01">
                        <div class="bannerTextWrap fz20 fc_fff">
                            <div class="fc_point">해외취업과정</div>
                            <h2 class="h2">미국 디지털 e-커머스 인재양성 과정</h2>
                        </div>
                    </div>
                </div>
                <div class="rainbow-sideBg bg05 leftSide"></div>
            </div>
            <div class="detail-menuWrapper" id="scrollFixed02">
                <ul class="detail-menuWrap d-flex">
                    <li class="detailMenu active" data-link="#cd-section01">과정소개</li>
                    <li class="detailMenu" data-link="#cd-section02">커리큘럼</li>
                    <li class="detailMenu" data-link="#cd-section05">과정FAQ</li>
                </ul>
            </div>
            <div class="course-detail-container d-flex">
                <div class="course-detailWrap">
                    <div class="courseSectionWrapper">
                        <!-- 과정 소개 -->
                        <div class="courseSectionWrap" id="cd-section01">
                            <div class="course-section">
                                <h2 class="h2 title">과정 소개</h2>
                                <p class="section-txt section-txt01 margin-top20">
                                    광주무역회관 ICT교육센터에서 운영 중인 미국 디지털 e-커머스 인재양성과정을 소개합니다.👏<br>
                                    본 과정은 소셜커머스 및 최신 ICT 기술(빅데이터, 마케팅)을 통한 새로운 인재 양성 과정으로 ICT, 기획, 마케팅과 레벨에 맞는 비즈니스 영어
                                    교육을 통해 미국 인턴쉽 진출의 기회를 잡으세요! 🚀
                                </p>
                            </div>
                            <div class="course-detailBox bgc_point">
                                <h3 class="h3">
                                    미국 디지털 커머스 과정이 광주에 왔다! 광주에서 미국으로 진출!
                                </h3>
                                <p>
                                    미국 전역에서 확보된 30여개의 현지 기업에서의 인턴쉽 기회를 잡으세요!
                                </p>
                            </div>
                            <div class="course-section">
                                <div class="course-infoTable">
                                    <div class="d-flex">
                                        <ul class="infoTh d-flex">
                                            <li class="img-icon calendar-day"></li>
                                            <li class="thTxt">모집기간</li>
                                        </ul>
                                        <ul class="infoTd">
                                            <li class="endDay"></li>
                                        </ul>
                                    </div>
                                    <div class="d-flex jus">
                                        <ul class="infoTh d-flex">
                                            <li class="img-icon calendar"></li>
                                            <li class="thTxt">교육기간</li>
                                        </ul>
                                        <ul class="infoTd">
                                           <li class="learn_period"></li>
                                            <li id="learnTime"></li>
                                        </ul>
                                    </div>
                                    <div class="d-flex">
                                        <ul class="infoTh d-flex">
                                            <li class="img-icon user"></li>
                                            <li class="thTxt">수강대상</li>
                                        </ul>
                                        <ul class="infoTd">
                                            <li>컴퓨터공학/경영/영어 전공자, 비전공자 모두 환영합니다!</li>
                                            <li>- 미국 외 타 국가에서 대학을 졸업한 자 </li>
                                            <li>- J1인턴십 경험이 없는 자 </li>
                                            <li>- 졸업예정자 및 졸업 후 1년 이내인 자(2021년 2월 ~ 2022년 2월 졸업자)</li>
                                            <li>- 대학 졸업 후 1년이 경과하였을 시, 전공 관련 경년 1년 이상인 자</li>
                                            <li>- 비전공 출신자의 경우 관련 취업분야 경력 5년 이상인 자</li>

                                            <li class="fc_point">[ 지원가능 전공범위 ]</li>
                                            <li>
                                                - 멀티미디어, 모바일, 응용소프트웨어, 시스템경엉, 인터넷 정보, 정보통신
                                                컴퓨터 정보 등 관련 공학 계열
                                            </li>
                                            <li>
                                                - 경영학, 광고기획, 금융경영, 마케팅 경영, 미디어/방송영상, 유통물류,
                                                e비즈니스 등 관련 사회계열
                                            </li>

                                            <li class="fc_point">[ 우대사항 ]</li>
                                            <li>-공인 어학성적 소지자(TOEIC 850점 이상)</li>
                                            <li>-전공 관련 자격증 소지자(국가자격증, 국제인증 자격증 등)</li>
                                            <li>-채용 직무 분야의 관련 경력이 있는 경우</li>
                                            <li>-만 34세 이하 대한민국 청년</li>

                                        </ul>
                                    </div>
                                    <div class="d-flex">
                                        <ul class="infoTh d-flex">
                                            <li class="img-icon hand-holding-heart"></li>
                                            <li class="thTxt">교육혜택</li>
                                        </ul>
                                        <ul class="infoTd">
                                            <li>- <span class="fc_point">국민취업제도</span> 대상 과정</li>
                                            <li>- 광주시 외 타지역 거주자 주거 이전 시
                                                <span class="fc_point">보증금 일부지원</span>(수료 후 지원금 반납)
                                            </li>
                                        </ul>
                                    </div>
                                    <div class="d-flex">
                                        <ul class="infoTh d-flex">
                                            <li class="img-icon won-sign"></li>
                                            <li class="thTxt">교육비</li>
                                        </ul>
                                        <ul class="infoTd">
                                            <li>0원</li>
                                            <li>&lt;비자발급 안내&gt;</li>
                                            <li>비자발급일 : 2022년 01 ~ 02월</li>
                                            <li>비자수속비 : $4,000(12개월) / $4,500(18개월)</li>
                                            <li>출국예정일 : 2022년 02월 이후</li>
                                            <li class="fc_999">
                                                ※ 교육비는 무료로 진행되며, 비자수속비는 별도입니다. 자세한 사항은 문의 바랍니다.
                                            </li>
                                        </ul>
                                    </div>
                                    <div class="d-flex">
                                        <ul class="infoTh d-flex">
                                            <li class="img-icon bullseye-arrow"></li>
                                            <li class="thTxt">교육목표</li>
                                        </ul>
                                        <ul class="infoTd">
                                            <li>미국 글로벌 ICT, e-커머스 기업에서 즉시 활용 가능한 현장중심형 인재양성</li>
                                        </ul>
                                    </div>
                                    <div class="d-flex">
                                        <ul class="infoTh d-flex">
                                            <li class="img-icon phone-alt"></li>
                                            <li class="thTxt">과정문의</li>
                                        </ul>
                                        <ul class="infoTd">
                                            <li>062-942-6260 / 02-6000-5376</li>
                                            <li>swmaster@softsociety.net</li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                            <div class="course-section textAlign_center margin-top20">
                                <h3 class="section-txt section-txt20">
                                    외국어가 막막하고 두렵다구요? 걱정마세요💖
                                    <br>.<br>.<br>.<br>
                                </h3>
                                <p class="section-txt margin-top20">
                                    영어 초/중/고급, 비즈니스 회화, IT용어 등<br>
                                    개개인의 외국어 역량을 파악하고 소그룹으로 나누어 레벨에 맞게 교육을 진행합니다!
                                </p>
                            </div>
                            <div class="course-section textAlign_center margin-top40">
                                <h3 class="section-txt section-txt20">
                                    💻 ICT 교육은 정확히 무엇을 배우나요?
                                    <br>.<br>.<br>.<br>
                                </h3>
                                <p class="section-txt margin-top20">
                                    객체지향 프로그래밍, 알고리즘, 기획/분석설계, 팀 프로젝트, 디지털/AI, 데이터 분석,<br>
                                    디지털 마케팅 등 경험 많은 교수진의 수업을 들으며 프로그래밍 세계에 빠져보세요!<br><br>
                                    개인 PC가 없어도 괜찮아요!<br> 희망자에 한해 노트북을 대여해드립니다!
                                </p>
                            </div>
                            <div class="course-section textAlign_center margin-top40">
                                <h3 class="section-txt section-txt20">
                                    이력서, 포트폴리오 혼자서는 힘들잖아요.😥
                                    <br>.<br>.<br>.<br>
                                </h3>
                                <p class="section-txt margin-top20">
                                    모의면접(기술/인성), 이력서/포트폴리오 작성, 기업별 전략 교육, 현지 정착(근로기준법, 기업문화), 자기 분석 등<br>
                                    탄탄한 해외취업대비 전략으로 저희가 도와드릴게요!<br>
                                    <br>
                                    <h3 class="h3">여기서 끝이 아니죠! 멘토링 서비스까지👀?</h3><br>
                                    해외취업에 성공한 멘토와의 만남 등 멘토링 서비스까지 제공해드립니다!
                                </p>
                            </div>
                        </div>
                        <!-- 커리큘럼 -->
                        <div class="courseSectionWrap" id="cd-section02">
                            <div class="course-section">
                                <h2 class="h2 title">커리큘럼</h2>
                                <p class="section-txt margin-top20">

                                    본 과정은 해외취업 진출 분야 선택시 IT직군 진출자, 대학생/취준생/졸업생/직장인등 역량개발이 필요한자를 대상으로 취업전략교육을 집중적으로 실시하는
                                    단기과정입니다.
                                </p>
                                <div class="courseTableWrap">
                                    <ul class="courseTable">
                                        <li class="courseTr">
                                            <div class="fc_point">상세 커리큘럼</div>
                                            <ul class="courseTd">
                                                <li><strong>
                                                        ■ 디지털 커머스 인재에게 반드시 필요한 IT & 빅데이터 완전 정복!
                                                    </strong></li>
                                                <li>1. 오피스 스킬(워드, 엑셀, 파워포인트 등)</li>
                                                <li>2. 프론트엔드 프로그래밍 역량</li>
                                                <li>- HTML, CSS5, Javascript, Jquery, 웹서버, Ajax, Node js, 프로젝트</li>
                                                <li>3. 데이터 분석의 모든 것 </li>
                                                <li>- 소셜 온라인 마케팅(블로그, 유튜브 인스타그램), 구글 애널리틱스 분석</li>
                                                <li>- 데이터 기반 통계학, 코딩 없는 머신러닝, 데이터 전처리, 지도/비지도 학습</li>

                                                <li><strong>■ 실전 비즈니스 영어회화를 통한 회화 역량 레벨업!
                                                    </strong></li>
                                                <li>1. 레벨별 실생활 영어 회화</li>
                                                <li>2. 취업 멘토링 (이력서 / 자기소개 영상 / 영어 TEST / 기업, 비자 인터뷰)</li>
                                                <li>3. 비즈니스 영어회화, Writing</li>


                                                <li><strong>■ 취업 멘토링을 통한 높은 합격률!
                                                    </strong></li>
                                                <li>1. 1:1 멘토링 케어</li>
                                                <li>2. 미국 유수의 자체 기업 발굴을 통한 인턴쉽 진출!</li>
                                                <li>3. 광주 무역회관의 쾌적한 교육환경</li>
                                            </ul>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                        <div class="courseSectionWrap" id="cd-section05">
                            <div class="course-section">
                                <h2 class="h2 title">과정FAQ</h2>
                                <p class="section-txt">
                                    강의에 대해 궁금한 점이 있으신가요? 🙋‍♀️🙋‍♂️<br>
                                    기타 궁금한 사항은 FAQ 게시판에 문의 주시면 빠른 답변이 가능합니다.
                                </p>
                                <div class="course-faqWrap">
                                    <ul class="faqGroup">
                                        <li class="faq">
                                            <div class="questionWrap d-flex justify_between" onclick="">
                                                <div class="question">
                                                    <span class="fc_point">Q. </span>미국에서 대학을 나온 경우에는 지원할 수 있는 방법이 없나요?
                                                </div>
                                                <div class="img-icon angle-down"> </div>
                                            </div>
                                            <div class="answerWrap">
                                                미국에서 대학을 나왔지만 졸업 이전이거나 이후 미국 외 국가 대학 학위가 있거나 인턴십 지원 분야 관련 경력이 미국 외 지역에서
                                                5년이면 지원 가능합니다.
                                            </div>
                                        </li>
                                        <li class="faq">
                                            <div class="questionWrap d-flex justify_between">
                                                <div class="question">
                                                    <span class="fc_point">Q. </span>가족이 미국 시민권자인데 J-1 비자 발급이 가능한가요?
                                                </div>
                                                <div class="img-icon angle-down"> </div>
                                            </div>
                                            <div class="answerWrap">
                                                지원자가 대한민국 국적 소지자이고 자격이 갖추어져 있다면 발급 가능합니다.
                                            </div>
                                        </li>
                                        <li class="faq">
                                            <div class="questionWrap d-flex justify_between">
                                                <div class="question">
                                                    <span class="fc_point">Q. </span>어떤 비자를 발급받게 되는 것인가요?
                                                </div>
                                                <div class="img-icon angle-down"> </div>
                                            </div>
                                            <div class="answerWrap">
                                                J-1 Intern/Trainee 비자입니다.
                                            </div>
                                        </li>
                                        <li class="faq">
                                            <div class="questionWrap d-flex justify_between">
                                                <div class="question">
                                                    <span class="fc_point">Q. </span>미국에서 J-1 비자를 받고 인턴십을 한 경험이 있는데 신청 가능한가요?
                                                </div>
                                                <div class="img-icon angle-down"> </div>
                                            </div>
                                            <div class="answerWrap">
                                                아래 조건을 충족하면 가능합니다.<br><br>
                                                <p class="fc_point">J-1 Intern</p>

                                                1) 이전보다 높은 수준의 개발 또는 다른 분야의 전문성을 개발하기 위한 경우<br>
                                                2) 미국 외 국가 대학에 풀타임으로 등록되어 있는 경우 또는 대학 졸업 후 1년 이내에 보다 상위권 학위과정인 경우<br><br>

                                                <p class="fc_point">J-1 Trainee</p>

                                                1) 이전보다 높은 수준의 기술개발 또는 다른 분야의 전문성을 위한 경우<br>
                                                2) 2년 본국 거주의무를 마친 경우<br>
                                            </div>
                                        </li>
                                        <li class="faq">
                                            <div class="questionWrap d-flex justify_between">
                                                <div class="question">
                                                    <span class="fc_point">Q. </span>J-1 Intern 비자와 J-1 Trainee 비자의 차이는
                                                    무엇인가요?
                                                </div>
                                                <div class="img-icon angle-down"> </div>
                                            </div>
                                            <div class="answerWrap">
                                                두 비자는 체류 기간의 차이가 있고 대학생/경력자인지 자격에 차이가 있습니다.<br><br>
                                                J-1 intern 비자는 대학 재학 혹은 졸업한 지 1년 이내 신청 가능, 최대 12개월까지 체류<br>
                                                J-1 Trainee 비자는 비전공자이지만 지원분야 관련 경력 5년 이상, 혹은 경력이 1년 이상이면 최대 18개월까지 체류 가능
                                            </div>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                            <div class="course-detailBanner">
                                <a href="">
                                    <div class="addKakaoBanner">
                                        <div class="d-flex justify_center">
                                            <div class="img-icon kakao-icon80"></div>
                                            <div class="textWrap">
                                                <h2 class="h2">카카오톡 채널에서 <span>"소프트엔지니어소사이어티"</span> 를 검색하세요!</h2>
                                                <p>
                                                    <span>"소프트엔지니어소사이어티"</span> 채널 추가하고 다양한 혜택과 다양한 이벤트 소식을 누구보다 빠르게
                                                    받아보세요.
                                                </p>
                                            </div>
                                        </div>

                                    </div>
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="course-applyWrap" id="scrollFixed03">
                    <div class="courseImgWrap">
                        <div class="courseImg">
                            <img src="/resources/segroup/society/smtp/img/course01-04.jpg" alt="">
                            <div class="bgc_point fz18 courseCount">2021.10.24(일) 까지</div>
                        </div>
                    </div>
                    <ul class="courseTxtWrap">
                        <li class="cs-title">
                            <div class="fc_point">해외취업과정</div>
                            <div class="fz20">미국 디지털 e-커머스 인재양성 과정</div>
                        </li>
                        <li class="cs-price">
                        	<div class="course-price"><span class="expenses"></span></div>
                            <div class="crc_price"></div>
                        </li>
                        <li class="cs-term">
                            <div class="d-flex">
                                <div class="img-icon calendar"></div>
                                <div class="margin-left5">교육기간 : <span class="learn_period"></span></div>
                            </div>
                        </li>
                    </ul>
                   <button id="applyBtn" class="btn_normal bgc_point course-apply h2 applyBtn">
                        수강신청하기
                    </button>
                </div>
            </div>
            <div class="course-navWrap bgc_333">
                <div class="d-flex justify_between">
                    <button class="btn_normal bgc_point course-apply fz20 applyBtn">
                        수강신청하기
                    </button>
                    <a class="d-flex justify_center inquiry" href="https://pf.kakao.com/_sxoRxjs">
                        <div class="img-icon kakao-icon40"></div>
                        <div class="fc_333">문의하기</div>
                    </a>
                </div>
            </div>
        </div>
		<input type="hidden" id="cardinal_id" value="${courseInfo.CARDINAL_ID}"/>
        <input type="hidden" id="course_id" value="${courseInfo.COURSE_ID}"/>
		<%@include file="../../../include/banner_full.jsp"%>
		<%@include file="../../../include/rainbow_footer.jsp"%>
    </div>

</body>

</html>
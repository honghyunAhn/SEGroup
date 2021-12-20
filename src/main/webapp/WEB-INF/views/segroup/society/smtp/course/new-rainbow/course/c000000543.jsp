<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <%@include file="../../../include/rainbow_head.jsp" %>
    <script src="/resources/segroup/society/smtp/js/rainbowScript_courseDetail.js"></script>
    <script type="text/javascript">
	    const dDay = new Date("${courseInfo.APP_END_DATE}"+", 23:59:59").getTime();
		const endDate = new Date();
		
		$(function() {
			app_final_day("${courseInfo.APP_END_DATE}");
			class_time("${courseInfo.LEARN_START_DATE}", "${courseInfo.LEARN_END_DATE}", "${courseInfo.CLASS_DAY}", "${courseInfo.CLASS_START_TIME}", "${courseInfo.CLASS_END_TIME}" , "${courseInfo.SELP_PERIOD}");
			graduation("${courseInfo.LEARN_END_DATE}");
			period("${courseInfo.APP_START_DATE}")
			expenses("${courseInfo.PRICE}");
			purpose("${courseInfo.PURPOSE}");
		});
    </script>
</head>

<body>
    <div class="container_rainbow container-courseDetail bgc_eee">
    	<%@include file="../../../include/rainbow_header.jsp" %>
        <div class="content course-detail course-point01" id="main">
            <div class="mainBackVideoWrap" onclick="togglePlay()">
                <div class="background_video video_main">
                    <video src="/resources/segroup/society/smtp/video/02ICT_Office.mp4" width='100%' autoplay loop muted>
                        <!-- <source src="video/01main_Earth.mp4" type="video/"> -->
                    </video>
                    <div class="opacity_bg op08" id="scrollFixed01">
                        <div class="bannerTextWrap fz20 fc_fff">
                            <div class="fc_point">해외취업과정</div>
                            <h2 class="h2">코딩챌린지(사전학습반)</h2>
                        </div>
                    </div>
                </div>
                <div class="rainbow-sideBg bg05 leftSide"></div>
            </div>
            <div class="detail-menuWrapper" id="scrollFixed02">
                <ul class="detail-menuWrap d-flex">
                    <li class="detailMenu active" data-link="#cd-section01">과정소개</li>
                    <li class="detailMenu" data-link="#cd-section02">커리큘럼</li>
                    <li class="detailMenu" data-link="#cd-section03">강사소개</li>
                    <li class="detailMenu" data-link="#cd-section04">과정후기</li>
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
                                    AI 빅데이터, 딥러닝, 4차산업혁명 등 말만 들어도 머리 아프죠?<br>
                                    뉴스, 미디어, 소셜 등에서 매일 같이 쏟아지는 IT 관련 뉴스들.. 세상이 뭔가 크게 바뀌고 있는데..
                                    그게 뭔지는 잘 모르겠고😰 IT분야인건 맞는 것 같은데 문과생에게는 너무나 먼 얘기?<br>복잡하게 묻지도 따지지도 말고! 우리 같이 코딩챌린지 과정
                                    시작해요! 🙌
                                </p>
                            </div>
                            <div class="course-detailBox bgc_point">
                                <h3 class="h3">
                                    코린이, 웹린이도 무섭지 않아요! 👶
                                </h3>
                                <p>
                                    누구나 쉽게 접근할수 있는 난이도 조절 진행 방식과 디테일한 강의 코치!
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
                                            <li><span class="learn_period"></span><span class="self_period"></span></li>
                                            <li><span id="learnTime"></span></li>
                                        </ul>
                                    </div>
                                    <div class="d-flex">
                                        <ul class="infoTh d-flex">
                                            <li class="img-icon user"></li>
                                            <li class="thTxt">수강대상</li>
                                        </ul>
                                        <ul class="infoTd">
                                            <li>IT 분야 및 프로그래에 대한 관심 대상자</li>
                                            <li>해외취업 진출 분야 선택시 IT직군 진출자</li>
                                            <li>대학생/취준생/졸업생/직장인등 역량개발이 필요한자</li>
                                        </ul>
                                    </div>
                                    <!-- <div class="d-flex">
                                        <ul class="infoTh d-flex">
                                            <li class="img-icon hand-holding-heart"></li>
                                            <li class="thTxt">교육혜택</li>
                                        </ul>
                                        <ul class="infoTd">
                                            <li>- <span class="fc_point">국민취업제도</span> 대상 과정</li>
                                            <li>- 해외취업정착지원금<span class="fc_point">(최대 400만원 지급)</span</i> <li>- 부산시 외 타
                                                    지역 거주자 주거 이전 시
                                                    <span class="fc_point">보증금 일부지원</span>(수료 후 지원금 반납)
                                            </li>
                                        </ul>
                                    </div> -->
                                    <div class="d-flex">
                                        <ul class="infoTh d-flex">
                                            <li class="img-icon won-sign"></li>
                                            <li class="thTxt">교육비</li>
                                        </ul>
                                        <ul class="infoTd">
                                            <li class="expenses"></li>
                                            <!-- <li class="fc_point">
                                                &lt;교육비 할인 제도&gt;
                                            </li>
                                            <li>
                                                1. MOU 대학교 추천(대학교 추천서 제출 시) : <span
                                                    class="course-price">1,000,000원</span>→
                                                0원
                                            </li>
                                            <li>
                                                2. 코딩챌린지(사전학습반) 과정 수료 : <span class="course-price">1,000,000원</span>→
                                                500,000원
                                            </li>
                                            <li>
                                                3. 기타 협약기관 추천 : <span class="course-price">1,000,000원</span>→
                                                500,000원
                                            </li>
                                            <li class="fc_999">
                                                ※ 교육비 할인 중복 적용은 안되며 자세한 사항은 문의 바랍니다.
                                            </li> -->
                                        </ul>
                                    </div>
                                    <div class="d-flex">
                                        <ul class="infoTh d-flex">
                                            <li class="img-icon bullseye-arrow"></li>
                                            <li class="thTxt">교육목표</li>
                                        </ul>
                                        <ul class="infoTd">
                                            <!-- <li>1) 프로그래밍 언어의 특성을 적용하여 애플리케이션을 구현할 수 있다.</li>
                                            <li>2) 특정 데이터를 저장하기 위한 DB Object를 생성하고 입력, 수정, 조회, 삭제 등의 SQL명령문을 작성할 수 있다.
                                            </li>
                                            <li>3) 응용프로그램과 데이터베이스를 연동하는 방법을 익히고 대용량 DB를 다룰 수 있다.</li>
                                            <li>4) 웹 프론트 기술을 이해하고, 이를 활용한 웹 프론트를 설계할 수 있다.</li>
                                            <li>5) 업무 프로세스를 확인하여 서비스의 구현에 필요한 업무 구현 능력을 기른다.</li> -->
                                            <li>-</li>
                                        </ul>
                                    </div>
                                    <div class="d-flex">
                                        <ul class="infoTh d-flex">
                                            <li class="img-icon bullseye-arrow"></li>
                                            <li class="thTxt">과정문의</li>
                                        </ul>
                                        <ul class="infoTd">
                                            <li>062-942-6260</li>
                                            <li>swmaster@softsociety.net</li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                            <div class="course-detailBox bgc_333 fc_fff">
                                <p class="section-txt margin-top20 textAlign_center">
                                    <span class="h3">
                                        회차별로 진행되는 프로그래밍 첫걸음!<br>
                                        챌린지 3개 달성하고 수강료 50% 환급받으세요! 🏁
                                    </span>
                                    <br><br>
                                    출석률(90% 이상), 수업 성실도(90% 이상), 평가 스코어(80점 이상)<br> 챌린지 3개 달성시 수강료 50% 환급!
                                </p>
                            </div>
                            <div class="course-section textAlign_center">
                                <h3 class="section-txt section-txt20">
                                    🌈비전공자, 코린이, 웹린이 어서오세요!💖
                                    <br>.<br>.<br>.<br>
                                </h3>
                                <p class="section-txt margin-top20">
                                    컴퓨터에 대해 단 1도 모르지만 시대 흐름에 맞춰 자기 역량을 개발하고 싶은 분에게 추천드립니다!
                                    <br>막막하고 두렵다구요?<br>
                                    쉽게 접근할 수 있는 난이도 조절 진행 방식으로 걱정없이 코딩 챌린지과정으로 즐겁게 프로그래밍에 첫발을 내딛으세요!
                                </p>
                            </div>
                            <div class="course-section textAlign_center margin-top40">
                                <h3 class="section-txt section-txt20">
                                    💻 100% 실시간 온라인 수업!
                                    <br>.<br>.<br>.<br>
                                </h3>
                                <p class="section-txt margin-top20">
                                    오래된 녹화방송은 가라! 코로나 시대! 언택트 비대면 완벽 대응!<br>
                                    실시간 온라인 수업을 통해 경험 많은 교수진의 수업을 들으며 프로그래밍 세계에 빠져보세요!<br>
                                    개인 PC가 없어도 괜찮아요!<br> 희망자에 한해 노트북을 대여해드립니다!
                                </p>
                            </div>
                            <div class="course-section textAlign_center margin-top40">
                                <h3 class="section-txt section-txt20">
                                    해외IT진출 노하우 보유!🚀
                                    <br>.<br>.<br>.<br>
                                </h3>
                                <p class="section-txt margin-top20">
                                    서울 코엑스, 광주무역회관에 이어 부산무역회관까지!<br>
                                    21년간 2,700여명의 학생들에 대해 IT직무/외국어비즈니스 교육부터 취업준비까지 한번에!<br>
                                    매년 상/하반기 브릿지 도쿄 잡페어 개최(200여개사의 풀, 평균 50개 기업)
                                </p>
                            </div>
                            <div class="course-section textAlign_center margin-top40">
                                <h3 class="section-txt section-txt20">
                                    💰 챌린지를 통한 수강료 환급!
                                    <br>.<br>.<br>.<br>
                                </h3>
                                <p class="section-txt margin-top20">
                                    코딩 챌린지 과정을 통해 IT, 외국어도 배우고, 수강료도 환급받자!<br>
                                    보상이 확실한 교육 프로그램 "코딩챌린지"<br>
                                    <br>
                                    <h3 class="h3">수강료는 어떻게 환급받나요?👀</h3><br>
                                    출석률(90%이상), 수업성실도(90%이상), 평가스코어(80점 이상)<br>
                                    챌린지 3개 달성시 수강료 50%를 환급해드립니다!
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
                                                        ■ ICT 기초프로그래밍 완전정복 (프로그래밍의 이해, 알고리즘 구현 등)
                                                    </strong></li>
                                                <li>1. 프로그래밍 기초 - 기본 알고리즘, 자료형, 연산자, 제어문, 배열</li>
                                                <li>2. 객체지향프로그래밍 - 객체지향 프로그래밍의 개요와 특징</li>
                                                <li>3. 4차산업혁명을 대비한 프로그램밍의 이해</li>
                                                <li>4. 기본 알고리즘 구현을 위한 코딩</li>
                                                <li><strong>
                                                        ■ 히라가나부터 현장 일본어까지 준비 기초회화 완전정복
                                                    </strong></li>
                                                <li>1. 기초문법, 회화, 어휘, 독해</li>
                                                <li>2. 일본 직장내에티켓 - 일본 기업문화의 이해</li>
                                                <li>3. 일본 문화 - 일본 생활문화의 이해</li>
                                                <li>4. 일본 IT 기초 회화 - 일본 IT 기업문화의 특징 및 이해</li>
                                            </ul>
                                        </li>
                                    </ul>
                                </div>
                            </div>

                            <div class="course-section margin-top40">
                                <h3 class="h3 section-subTitle">
                                    🤔 아직도 고민되시나요?
                                </h3>
                                <p class="section-txt margin-top10">
                                    단계별 맞춤형 코칭 프로그램 "페이스 메이커 시스템"으로 최종합격까지 함께합니다! 🏃
                                </p>
                                <div class="courseTableWrap">
                                    <ul class="courseTable">
                                        <li class="courseTr">
                                            <div class="fc_point">01. 학습준비</div>
                                            <ul class="courseTd">
                                                <li>- 비전공자를 위한 학습 로드맵 안내</li>
                                                <li>- IT와 일본어 처음 시작하기</li>
                                            </ul>
                                        </li>
                                        <li class="courseTr">
                                            <div class="fc_point">02. 학습 서포트</div>
                                            <ul class="courseTd">
                                                <li>- 강의 녹화분 다시듣기로 놓친 부분 한번 더!</li>
                                                <li>- 모르는건 언제든 질문할 수 있는 Q&A 채널</li>
                                                <li>- 부진과목 보충수업으로 마지막까지!</li>
                                                <li>- 일본어 기술면접 대비</li>
                                                <li>- 모의면접으로 일본어 실전에 강해지기</li>
                                            </ul>
                                        </li>
                                        <li class="courseTr">
                                            <div class="fc_point">03. 취업서포트</div>
                                            <ul class="courseTd">
                                                <li>- 현업 선배가 알려주는 일본기업 이야기</li>
                                                <li>- 이력서 첨삭과 면접 코칭</li>
                                                <li>- 채용기업 분석 자료 제공</li>
                                            </ul>
                                        </li>
                                        <li class="courseTr">
                                            <div class="fc_point">04. 사후관리</div>
                                            <ul class="courseTd">
                                                <li>- 내정 후 입사까지 모니터링</li>
                                                <li>- 현지 선배들과 네트워킹으로 필요할 때 도움받기</li>
                                            </ul>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </div>

                        <!-- 강사소개 -->
                        <div class="courseSectionWrap" id="cd-section03">
                            <div class="course-section">
                                <h2 class="h2 title">강사소개</h2>
                                <div class="course-teacher d-flex justify_center">
                                    <div class="course-tcImg img-icon user-blank">
                                        <img src="" alt="">
                                    </div>
                                    <div class="course-tcTxtWrap">
                                        <strong>"한걸음씩 천천히 따라오시다 보면 어느새 전공자가 되어있을겁니다."</strong>
                                        <h5 class="fc_999 margin-top10">
                                            - ICT교강사 '이종호'
                                        </h5>
                                    </div>
                                </div>

                                <div class="course-section">
                                    <h3 class="h3 section-subTitle">강사의 다른 강의를 만나보세요! 😀</h3>
                                    <ul class="courseList d-flex flexWrap">
                                        <li class="cs_ict">
                                            <a href="/smtp/course/new-rainbow/course?course_id=c000000543">
                                                <div class="courseImg"><img src="" alt=""></div>
                                                <div class="courseTxt">
                                                    <div class="fc_666">코딩 챌린지 과정 1기</div>
                                                    <div class="fc_999">4주 완성! 사전학습 종합반</div>
                                                </div>
                                            </a>
                                        </li>
                                        <li class="cs_ict">
                                            <a href="/smtp/course/new-rainbow/course?course_id=c000000526">
                                                <div class="courseImg"><img src="" alt=""></div>
                                                <div class="courseTxt">
                                                    <div class="fc_666">SoftWare DevOps MASTER 8기</div>
                                                    <div class="fc_999">SW/AI 해외취업연계과정</div>
                                                </div>
                                            </a>
                                        </li>
                                        <li class="cs_ict">
                                            <a href="/smtp/course/new-rainbow/course?course_id=c000000548">
                                                <div class="courseImg"><img src="" alt=""></div>
                                                <div class="courseTxt">
                                                    <div class="fc_666">Digital Ai Big-data Cloud Master 1기</div>
                                                    <div class="fc_999">SW/AI 해외취업연계과정</div>
                                                </div>
                                            </a>
                                        </li>
                                        <li class="cs_ict">
                                            <a href="/smtp/course/new-rainbow/course?course_id=c000000543">
                                                <div class="courseImg"><img src="" alt=""></div>
                                                <div class="courseTxt">
                                                    <div class="fc_666">Smart Cloud IT MASTER 42기</div>
                                                    <div class="fc_999">SW/AI 해외취업연계과정</div>
                                                </div>
                                            </a>
                                        </li>
                                        <li class="cs_ict">
                                            <a href="/smtp/course/new-rainbow/course?course_id=c000000543">
                                                <div class="courseImg"><img src="" alt=""></div>
                                                <div class="courseTxt">
                                                    <div class="fc_666">Smart Cloud IT MASTER 42기</div>
                                                    <div class="fc_999">SW/AI 해외취업연계과정</div>
                                                </div>
                                            </a>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                        <div class="courseSectionWrap" id="cd-section04">
                            <div class="course-section">
                                <h2 class="h2 title">과정후기</h2>
                                <p id="noneReview" class="noneReview fc_999">
                                    등록된 과정 후기가 없습니다.
                                </p>
                                <ul class="course-reviewWrap">
                                    <li class="course-review d-flex">
                                        <div class="img-icon user-blank40">
                                            <img src="" alt="">
                                        </div>
                                        <div class="course-rvTxtWrap">
                                            <strong>
                                                IT에 대해서는 문외한이었기 때문에 처음에는 많은 걱정이 앞섰지만 수업을 진행하면 할수록 IT에 대해 많은 흥미를 갖게
                                                되었습니다.
                                            </strong>
                                            <h5 class="fc_999">
                                                - 수료생 곽**
                                            </h5>
                                        </div>

                                    </li>
                                    <li class="course-review d-flex">
                                        <div class="img-icon user-blank40">
                                            <img src="" alt="">
                                        </div>
                                        <div class="course-rvTxtWrap">
                                            <strong>
                                                지금까지 해본 적 없었던 IT 분야를 시작한다는 점에서 이 과정은 저에게 새로운 도전이었다고 생각합니다.
                                                앞으로 일본에서의 생활 또한 새로운 시작이라는 마음가짐으로 열심히 임하고 싶습니다.
                                            </strong>
                                            <h5 class="fc_999">
                                                - 수료생 김**
                                            </h5>
                                        </div>
                                    </li>
                                    <li class="course-review d-flex">
                                        <div class="img-icon user-blank40">
                                            <img src="" alt="">
                                        </div>
                                        <div class="course-rvTxtWrap">
                                            <strong>
                                                다른 분들의 후기를 읽으며 과연 내가 이걸 해낼 수 있을까하는 분들도 과정에 참여하여
                                                함께 생활하다 보면 어느샌가 원하는 결과를 손에 넣을 수 있을 것이라고 생각합니다
                                            </strong>
                                            <h5 class="fc_999">
                                                - 수료생 강**
                                            </h5>
                                        </div>
                                    </li>
                                    <li class="course-review d-flex">
                                        <div class="img-icon user-blank40">
                                            <img src="" alt="">
                                        </div>
                                        <div class="course-rvTxtWrap">
                                            <strong>
                                                IT에 대해서는 문외한이었기 때문에 처음에는 많은 걱정이 앞섰지만 수업을 진행하면 할수록 IT에 대해 많은 흥미를 갖게
                                                되었습니다.
                                            </strong>
                                            <h5 class="fc_999">
                                                - 수료생 곽**
                                            </h5>
                                        </div>

                                    </li>
                                    <li class="course-review d-flex">
                                        <div class="img-icon user-blank40">
                                            <img src="" alt="">
                                        </div>
                                        <div class="course-rvTxtWrap">
                                            <strong>
                                                지금까지 해본 적 없었던 IT 분야를 시작한다는 점에서 이 과정은 저에게 새로운 도전이었다고 생각합니다.
                                                앞으로 일본에서의 생활 또한 새로운 시작이라는 마음가짐으로 열심히 임하고 싶습니다.
                                            </strong>
                                            <h5 class="fc_999">
                                                - 수료생 김**
                                            </h5>
                                        </div>
                                    </li>
                                    <li class="course-review d-flex">
                                        <div class="img-icon user-blank40">
                                            <img src="" alt="">
                                        </div>
                                        <div class="course-rvTxtWrap">
                                            <strong>
                                                IT에 대해서는 문외한이었기 때문에 처음에는 많은 걱정이 앞섰지만 수업을 진행하면 할수록 IT에 대해 많은 흥미를 갖게
                                                되었습니다.
                                            </strong>
                                            <h5 class="fc_999">
                                                - 수료생 곽**
                                            </h5>
                                        </div>

                                    </li>

                                </ul>
                                <div id="moreReview" class="course-reviewMore">과정 후기 더 보기</div>
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
                                                    <span class="fc_point">Q. </span>과정 지원 자격은 어떻게 되나요?
                                                </div>
                                                <div class="img-icon angle-down"> </div>
                                            </div>
                                            <div class="answerWrap">
                                                디지털 ABC마스터 과정은 만 34세 미만,
                                                전문대 졸업자(교육과정 내 졸업예정자 포함) 이상의 대한민국 청년 미취업자를 대상으로 합니다.
                                            </div>
                                        </li>
                                        <li class="faq">
                                            <div class="questionWrap d-flex justify_between">
                                                <div class="question">
                                                    <span class="fc_point">Q. </span>비전공자도 지원 가능한가요?
                                                </div>
                                                <div class="img-icon angle-down"> </div>
                                            </div>
                                            <div class="answerWrap">
                                                비전공자도 지원 가능합니다. 각종 IT관련 자격증 및 정보처리(산업)기사 소지자, 외국어 공인 시험 성적 소지자는
                                                선발과정에
                                                가점이
                                                부여되며 미소지자인 경우 목표의식이 분명하면 기회가 제공됩니다.
                                            </div>
                                        </li>
                                        <li class="faq">
                                            <div class="questionWrap d-flex justify_between">
                                                <div class="question">
                                                    <span class="fc_point">Q. </span>과정 입학 준비를 위해 무엇을 준비해야 하나요?
                                                </div>
                                                <div class="img-icon angle-down"> </div>
                                            </div>
                                            <div class="answerWrap">
                                                본인의 적성 및 향후 진로에 ABC 마스터 과정이 적합한지를 신중히 판단하고 본인의 목표와 동기의식이 뚜렷해야 합니다.
                                                그리고
                                                지원의사
                                                결정 후 남은 기간을 이용해 본인에게 부족한 학습을 사전에 준비하는 과정이 도움이 됩니다.(ex. 일본어 기초, ICT
                                                기초,
                                                정보처리기사 필기/실기 공부 등)
                                                <h5 class="h5 fc_999">
                                                    ※ ICT/일본어 모두 비전공자라면 SES의 사전학습반 수강을 추천합니다.
                                                </h5>
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
                                                <h2 class="h2">카카오톡 채널에서 <span>"코딩챌린지"</span> 를 검색하세요!</h2>
                                                <p>
                                                    <span>"코딩챌린지"</span> 채널 추가하고 다양한 혜택과 다양한 이벤트 소식을 누구보다 빠르게
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
                            <img src="/resources/segroup/society/smtp/img/course01-01.jpg" alt="">
                            <div class="bgc_point fz18 courseCount">개설 준비 중인 과정입니다.</div>
                        </div>
                    </div>
                    <ul class="courseTxtWrap">
                        <li class="cs-title">
                            <div class="fc_point">해외취업과정</div>
                            <div class="fz20">코딩챌린지(사전학습반)</div>
                        </li>
                        <li class="cs-price">
                            <div class="course-price">￦ <span class="expenses"></span></div>
                            <span class="h2">￦&nbsp;<span class="mou_price"></span></span>&nbsp;<span class="fc_999">(교육비 할인 제도 적용시)</span>
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
                    <a class="d-flex justify_center inquiry" href="">
                        <div class="img-icon kakao-icon40"></div>
                        <div class="fc_333">문의하기</div>
                    </a>
                </div>
            </div>
        </div>
        <input type="hidden" id="cardinal_id" value="${courseInfo.CARDINAL_ID}"/>
        <input type="hidden" id="course_id" value="${courseInfo.COURSE_ID}"/>
		<%@include file="../../../include/banner_full.jsp" %>
		<%@include file="../../../include/rainbow_footer.jsp" %>
    </div>

</body>

</html>
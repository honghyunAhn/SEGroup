<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <%@include file="../../include/rainbow_head.jsp"%>
    <script src="/resources/segroup/society/smtp/js/rainbowScript_courseDetail.js"></script>
    <script type="text/javascript">
        const dDay = new Date("September 30,2021, 23:59:59").getTime();
    </script>
</head>

<body>
    <div class="container_rainbow container-courseDetail bgc_eee">
    	<%@include file="../../include/rainbow_header.jsp"%>
        <div class="content course-detail course-point02" id="main">
            <div class="mainBackVideoWrap" onclick="togglePlay()">
                <div class="background_video video_main">
                    <video src="/resources/segroup/society/smtp/video/02ICT_Office.mp4" width="100%" autoplay loop muted>
                        <!-- <source src="video/01main_Earth.mp4" type="video/"> -->
                    </video>
                    <div class="opacity_bg op08" id="scrollFixed01">
                        <div class="bannerTextWrap fz20 fc_fff">
                            <div class="fc_point">내일배움카드 과정</div>
                            <h2 class="h2">파이썬 기초 과정</h2>
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
                        <!-- 과정소개 -->
                        <div class="courseSectionWrap" id="cd-section01">
                            <div class="course-section">
                                <h2 class="h2 title">과정 소개</h2>
                                <p class="section-txt margin-top20">
                                    본 과정은 파이썬 언어를 기반으로 빅데이터 분석을 하고, 처리된 결과를 시각화한 후 이를 통해 업무 분석을 할 수 있는 능력을 키워 취업에 도움을 줄
                                    수 있도록 설계된 교육과정입니다. 또한, 데이터에 대한 insight를 높이고 데이터가 가지고 있는 오류를 파악하여 이를 정제한 후 분석하고 시각화는
                                    방법을 학습하게 됩니다.
                                </p>
                                <p class="section-detailBox bgc_eee margin-top20 textAlign_center">
                                    <span class="h3">
                                        🏆 산업인력공단 3년 연속 우수기관 선정 (2018 ~ 2021) 🏆
                                    </span>
                                </p>
                                <p class="section-txt margin-top20 textAlign_center">
                                    <span class="h3">
                                        소프트 엔지니어 소사이어티가 당신의 취업그레이드를 책임집니다! ✨
                                    </span>
                                    <br>
                                    2001년부터 대한민국 5대 경제단체인 무역협회 무역아카데미의 글로벌 IT 해외취업과정 운영!<br>
                                    <span class="fz18 fc_point">현재까지 약 2,800여 명의 취업실적</span>으로 쌓아온 IT 강의 노하우!
                                </p>
                            </div>

                            <div class="course-detailBox bgc_point">
                                <h3 class="h3">
                                    파이썬 기반 데이터분석 과정과 함께 나도 데이터분석 전문가! 🚀
                                </h3>
                                <p>
                                    파이썬 언어 습득! 딥러닝으로의 연계까지!
                                    AI, BigData, Deep running, Python
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
                                            <li>~ 2021.09.30 까지</li>
                                        </ul>
                                    </div>
                                    <div class="d-flex jus">
                                        <ul class="infoTh d-flex">
                                            <li class="img-icon calendar"></li>
                                            <li class="thTxt">교육기간</li>
                                        </ul>
                                        <ul class="infoTd">
                                            <li>2021.10.04 ~ 2021.12.04(2개월)</li>
                                            <li>월~금 10:00 ~ 16:00 (점심시간 12:00 ~ 13:00)</li>
                                        </ul>
                                    </div>
                                    <div class="d-flex">
                                        <ul class="infoTh d-flex">
                                            <li class="img-icon user"></li>
                                            <li class="thTxt">수강대상</li>
                                        </ul>
                                        <ul class="infoTd">
                                            <li>내일배움카드가 발급가능한 대한민국 국적의 취준생, 재직자 모두 가능합니다!</li>
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
                                            <li class="thTxt">교 육 비</li>
                                        </ul>
                                        <ul class="infoTd">
                                            <li>취업준비생, 직장인 : <span class="fc_point">100% 국비지원!</span> (내일배움카드제)</li>
                                            <li>
                                                일반 : 상담 후, 다양한 교육 할인 혜택을 받으세요!
                                            </li>
                                            <li class="fc_999">
                                                ※ 교육비 할인 관련 사항은 문의 바랍니다.
                                            </li>
                                        </ul>
                                    </div>
                                    <div class="d-flex">
                                        <ul class="infoTh d-flex">
                                            <li class="img-icon bullseye-arrow"></li>
                                            <li class="thTxt">교육목표</li>
                                        </ul>
                                        <ul class="infoTd">
                                            <li>1) 파이썬 언어의 문법을 확실히 이해하고 다양한 응용 프로그램을 개발할 수 있다.</li>
                                            <li>2) 빅데이터 분석에 필요한 데이터를 생성 주체 및 활용 유형 등에 따라 식별하여 분류할 수 있다.</li>
                                            <li>3) 분석에 필요한 대용량 데이터를 웹을 통해 수집할 수 있다.</li>
                                            <li>4) 수집 대상 데이터의 유형별 접근 방식에 따라 데이터를 수집하는 모듈을 작성할 수 있다.</li>
                                            <li>5) 학습 데이터 특징에 맞는 학습 데이터 입력 형식을 설계할 수 있다.</li>
                                            <li>6) 학습 데이터와 검증 데이터를 구분할 수 있다.</li>
                                            <li>7) 학습 모델에 사용되는 시뮬레이터를 구동하고 설정을 조정할 수 있다.</li>
                                            <li>8) 학습 데이터에 따라 기계 학습을 할 수 있다.</li>
                                            <li>9) 학습 목적에 맞도록 학습의 최적화 하는 인자를 설계할 수 있다.</li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                            <div class="course-detailBox bgc_333 fc_fff">
                                <h3 class="h3">
                                    파이썬 과정 수강 핵심 포인트! &#127919;
                                </h3>
                                <p class="margin-top10">
                                    데이터분석, AI, 머신러닝, 웹 개발 등에 활용성이 높고
                                    생초보자도! 입문자도!<br>
                                    직관적으로 이해하기 쉬운 설계로 두 달간의 집중 학습을 통하여 파이썬을 통해 개발자로의 역량 업그레이드!
                                </p>
                            </div>
                            <div class="course-section textAlign_center">
                                <h3 class="section-txt section-txt20">
                                    저도 할 수 있을까요 😵?
                                    <br>.<br>.<br>.<br>
                                </h3>
                                <p class="section-txt margin-top20">
                                    복잡한 문법은 이제 그만! 💣<br>
                                    C, C++에 비해 문법이 쉽고 따라 하기 쉬워요!<br>
                                    집중 훈련과정을 거치면 혼자서도 독학이 가능합니다!
                                </p>
                            </div>
                            <div class="course-section textAlign_center margin-top40">
                                <h3 class="section-txt section-txt20">
                                    👀 파이썬이 뭐지?
                                    <br>.<br>.<br>.<br>
                                </h3>
                                <p class="section-txt margin-top20">
                                    #파이썬이란? 1990년 네덜란드 개발자 귀도 반 로섬이 만든 언어입니다.<br>
                                    이전에 개발된 언어들과의 가장 큰 차이점은 가장 인간다운 언어로서 실행 값을 바로 확인할 수 있고,<br> 언어체계도 직관적으로 이해할 수 있습니다.
                                </p>
                                <p class="section-txt margin-top20">
                                    <img width="100%" src="/resources/segroup/society/smtp/img/course02-01-01.png"
                                        alt="구글, 넷플릭스, 나사, 인스타 그램, 유튜브, 드롭박스">
                                    파이썬은 기업의 실무를 위한 최적의 언어입니다!<br>
                                    구글, 넷플릭스, 나사, 인스타 그램, 유튜브, 드롭박스 등이 파이썬 기반으로
                                    제작되었습니다.<br> 정말 쉽지만 엄청난 파워를 가진 언어가 아닐까요?

                                    파이썬 수업 듣고 개발 역량 업그레이드! 🙋🙋‍♂️
                                </p>
                            </div>
                            <div class="course-section textAlign_center margin-top40">
                                <h3 class="section-txt section-txt20">
                                    이 강의만의 특별한 혜택이 있나요? 🎁
                                    <br>.<br>.<br>.<br>
                                </h3>
                                <p class="section-txt margin-top20">
                                    총 4권의 파이썬 교재를 무료로 제공합니다!<br>
                                    🧡 <span class="fc_point02">"Do it! 점프 투 파이썬"</span> 🧡<br>
                                    💛 <span class="fc_point03">"파이썬 머신러닝 판다스 데이터 분석"</span> 💛<br>
                                    💚 <span class="fc_point04">"다시 미분 적분"</span> 💚<br>
                                    💙 <span class="fc_point05">"파이썬으로 웹 크롤러 만들기"</span> 💙<br>
                                </p>
                                <p class="section-txt margin-top20">
                                    혼자 코딩을 하다 보면 막히는 부분이 분명 발생합니다.<br>
                                    특히나 처음 접하시는 분들이라면 더욱 그럴 수 있죠.<br>
                                    하지만 걱정하지마세요!<br>
                                    ✨빠른 피드백과 전문 교강사진의 파이썬 노하우까지 알려드릴게요! 🤫
                                </p>
                            </div>
                        </div>
                        <!-- 커리큘럼 -->
                        <div class="courseSectionWrap" id="cd-section02">
                            <div class="course-section">
                                <h2 class="h2 title">커리큘럼</h2>
                                <p class="section-txt margin-top20">
                                    이 과정은 파이썬 언어를 기반으로 빅데이터 분석을 하고, 처리된 결과를 시각화한 후 이를 통해 업무 분석을 할 수 있는 능력을 키워 취업에 도움을 줄
                                    수 있도록 최적화된 교육과정입니다.
                                </p>
                                <div class="courseTableWrap">
                                    <ul class="courseTable">
                                        <li class="courseTr">
                                            <div class="fc_point">상세 커리큘럼</div>
                                            <ul class="courseTd">
                                                <li>Python Language & Algorithm</li>
                                                <li>파이썬 데이터 분석 패키지 (Numpy, Pandas)</li>
                                                <li>빅데이터를 위한 선형대수학과 기초통계 이론 및 실습</li>
                                                <li>Web Scraping Data의 분석 기법</li>
                                                <li>Data 분석과 시각화</li>
                                                <li>자기 분석 및 이력서 작성/기술면접 대비 특강</li>
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
                                            <a href="/smtp/course/new-rainbow/new-rainbow-info?course_id=course-detail">
                                                <div class="courseImg"><img src="" alt=""></div>
                                                <div class="courseTxt">
                                                    <div class="fc_666">코딩 챌린지 과정 1기</div>
                                                    <div class="fc_999">4주 완성! 사전학습 종합반</div>
                                                </div>
                                            </a>
                                        </li>
                                        <li class="cs_ict">
                                            <a href="/smtp/course/new-rainbow/new-rainbow-info?course_id=course-detail">
                                                <div class="courseImg"><img src="" alt=""></div>
                                                <div class="courseTxt">
                                                    <div class="fc_666">SoftWare DevOps MASTER 8기</div>
                                                    <div class="fc_999">SW/AI 해외취업연계과정</div>
                                                </div>
                                            </a>
                                        </li>
                                        <li class="cs_ict">
                                            <a href="/smtp/course/new-rainbow/new-rainbow-info?course_id=course-detail">
                                                <div class="courseImg"><img src="" alt=""></div>
                                                <div class="courseTxt">
                                                    <div class="fc_666">Digital Ai Big-data Cloud Master 1기</div>
                                                    <div class="fc_999">SW/AI 해외취업연계과정</div>
                                                </div>
                                            </a>
                                        </li>
                                        <li class="cs_ict">
                                            <a href="/smtp/course/new-rainbow/new-rainbow-info?course_id=course-detail">
                                                <div class="courseImg"><img src="" alt=""></div>
                                                <div class="courseTxt">
                                                    <div class="fc_666">Smart Cloud IT MASTER 42기</div>
                                                    <div class="fc_999">SW/AI 해외취업연계과정</div>
                                                </div>
                                            </a>
                                        </li>
                                        <li class="cs_ict">
                                            <a href="/smtp/course/new-rainbow/new-rainbow-info?course_id=course-detaill">
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
                        <!-- 과정후기 -->
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
                        <!-- 과정FAQ -->
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
                                                비전공자도 지원 가능합니다. 각종 IT관련 자격증 및 정보처리(산업)기사 소지자, 외국어 공인 시험 성적 소지자는 선발과정에
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
                                                본인의 적성 및 향후 진로에 ABC 마스터 과정이 적합한지를 신중히 판단하고 본인의 목표와 동기의식이 뚜렷해야 합니다. 그리고
                                                지원의사
                                                결정 후 남은 기간을 이용해 본인에게 부족한 학습을 사전에 준비하는 과정이 도움이 됩니다.(ex. 일본어 기초, ICT 기초,
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
                                                <h2 class="h2">카카오톡 채널에서 <span>"소프트엔지니어소사이어티"</span> 를 검색하세요!</h2>
                                                <p>
                                                    <span>"소프트엔지니어소사이어티"</span> 채널 추가하고 다양한 혜택과 다양한 이벤트 소식을 누구보다 빠르게
                                                    받아보세요.
                                                </p>
                                            </div>
                                        </div>

                                    </div>
                                    <!-- <img src="img/banner_kakao.jpg"
                                        alt="카카오톡 채널에서 '소프트엔지니어소사이어티'를 추가하세요. 소프트엔지니어소사이어티 채널 추가하고 다양한 혜택과 다양한 이벤트 소식을 누구보다 빠르게 받아보세요."
                                        class="addKakaoBanner"> -->
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="course-applyWrap" id="scrollFixed03">
                    <div class="courseImgWrap">
                        <div class="courseImg">
                            <img src="/resources/segroup/society/smtp/img/course_thumb03.jpg" alt="">
                            <div class="bgc_point fz18 courseCount">모집마감일 : 2021.09.30 까지</div>
                        </div>
                    </div>
                    <ul class="courseTxtWrap">
                        <li class="cs-title">
                            <div class="fc_point">내일배움카드과정</div>
                            <div class="fz20">파이썬 기초 과정</div>
                        </li>
                        <li class="cs-price">
                            <div class="course-price">￦ 1,700,000</div>
                            <span class="h2">￦&nbsp;400,000</span>&nbsp;<span class="fc_999">(내일배움카드 결제시)</span>
                        </li>
                        <li class="cs-term">
                            <div class="d-flex">
                                <div class="img-icon calendar"></div>
                                <div class="margin-left5">교육기간 : 2021.10.04 ~ 2021.12.04</div>
                            </div>
                        </li>
                    </ul>
                    <button id="applyBtn" class="btn_normal bgc_point course-apply h2">
                        수강신청하기
                    </button>
                </div>
            </div>
            <div class="course-navWrap bgc_333">
                <div class="d-flex justify_between">
                    <button class="btn_normal bgc_point course-apply fz20">
                        수강신청하기
                    </button>
                    <a class="d-flex justify_center inquiry" href="">
                        <div class="img-icon kakao-icon40"></div>
                        <div class="fc_333">문의하기</div>
                    </a>
                </div>
            </div>
        </div>
        <%@include file="../../include/banner_full.jsp"%>
        <%@include file="../../include/rainbow_footer.jsp"%>
    </div>

</body>

</html>
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
    		expenses("${courseInfo.PRICE}");
    	});
    </script>
</head>

<body>
    <div class="container_rainbow container-courseDetail bgc_eee">
    	<%@include file="../../../include/rainbow_header.jsp"%>
        <div class="content course-detail course-point03" id="main">
            <div class="mainBackVideoWrap" onclick="togglePlay()">
                <div class="background_video video_main">
                    <video src="/resources/segroup/society/smtp/video/05fair_Meeting.mp4" width="100%" autoplay loop muted>
                        <!-- <source src="video/01main_Earth.mp4" type="video/"> -->
                    </video>
                    <div class="opacity_bg op08" id="scrollFixed01">
                        <div class="bannerTextWrap fz20 fc_fff">
                            <div class="fc_point">글로벌 잡매칭</div>
                            <h2 class="h2">일본취업 스킬업</h2>
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
                                    본 과정은 일본어 우수자를 대상으로 취업전략교육을 집중적으로 실시하는 단기과정입니다. 취업준비가 막막하여 계획이 세워지지 않거나, 자격요건은 충분한 것
                                    같은데 서류전형에서 탈락하거나, 실전 면접에 약한 분들에게 본 과정의 수강을 추천 드립니다.
                                </p>
                                <p class="section-txt margin-top20 textAlign_center">
                                    <span class="h3">
                                        자기분석부터 모의면접까지! ✨
                                    </span>
                                    <br>
                                    이력서 작성의 기초인 자기분석법부터 실전 면접에서 당당히 합격할 수 있는 면접 대비 방법까지,<br> 취업성공으로 이어질 여러분들의 잠재력을
                                    끌어올려드립니다.
                                </p>
                            </div>

                            <div class="course-detailBox bgc_point">
                                <h3 class="h3">
                                    쉿! 지금 신청하시면 이런 혜택이 있어요!🤫
                                </h3>
                                <p>
                                    2022년 상반기 Bridge JOB Fair에 대비한 맞춤 취업전략도 함께 알려드릴게요!
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
                                            <li>일본어 공인시험 성적소지자(JLPT N2이상/또는 그에 상응하는 레벨)</li>
                                            <li>희망직무 관련 전공자 또는 자격증 소지자 (일본어, 정보통신공학, 경영학, 기전계 등)</li>
                                            <li>직무관련 교육 없이 취업정보를 학습하여 바로 취업하고자 하는 예비 사회인</li>
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
                                            <li><span class="expenses"></span>원</li>
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
                                </div>
                            </div>
                            <!-- <div class="course-detailBox bgc_333 fc_fff">
                                <h3 class="h3">
                                    과정 핵심 포인트! &#127919;
                                </h3>
                                <p class="margin-top10">
                                    😰 비전공자라고 두렵다구요?<br><br>
                                    2001년부터 현재까지 약 20년 동안 비전공자를 대상으로 한 IT취업전문기관이 있다!?<br>
                                    지금까지 2,800여 명 IT해외취업 진출 노하우를 가진 산업인력공단 우수기관!<br><br>
                                    JAVA를 배워 취업에 도전하고싶다면 지금 당장 상담 문의하세요! 👋
                                </p>
                            </div>
                            <div class="course-section textAlign_center">
                                <h3 class="section-txt section-txt20">
                                    전세계 프로그래머들의 바이블! 📚
                                    <br>.<br>.<br>.<br>
                                </h3>
                                <p class="section-txt margin-top20">
                                    기초를 튼튼하게!<br>
                                    JAVA를 배우지 않고 프로그래머가 될 수는 없죠!<br>
                                    모든 길은 첫 단추는 JAVA부터 확실히 마스터 후에 점차 넓혀 나가야 합니다!
                                </p>
                            </div>
                            <div class="course-section textAlign_center margin-top40">
                                <h3 class="section-txt section-txt20">
                                    💻 오프라인/온라인 완벽 강의!
                                    <br>.<br>.<br>.<br>
                                </h3>
                                <p class="section-txt margin-top20">
                                    현재 코로나로 인해 오프라인 수업이 어려울 경우,<br>
                                    실시간 라이브 수업이 될 수 있도록 준비되어있습니다.<br>
                                    생생한 현장감, 빠른 피드백으로 JAVA 마스터에 도전하세요!
                                </p>
                            </div>
                            <div class="course-section textAlign_center margin-top40">
                                <h3 class="section-txt section-txt20">
                                    이 강의만의 특별한 혜택이 있나요? 🎁
                                    <br>.<br>.<br>.<br>
                                </h3>
                                <p class="section-txt margin-top20">
                                    수업에 필요한 모든 교재를 무상으로 제공합니다!<br>
                                    🧡 <span class="fc_point02">"Do it! 자바 프로그래밍 입문"</span> 🧡<br>
                                    💛 <span class="fc_point03">"Do it! HTML + CSS + 자바스크립트 웹표준 정석"</span> 💛<br>
                                    💚 <span class="fc_point04">"Do it! 오라클로 배우는 데이터베이스 입문"</span> 💚<br>
                                </p>
                                <p class="section-txt margin-top20">
                                    혼자 코딩을 하다 보면 막히는 부분이 분명 발생합니다.<br>
                                    특히나 처음 접하시는 분들이라면 더욱 그럴 수 있죠.<br>
                                    하지만 걱정하지마세요!<br><br>
                                    강사만족도 최상위 점수 획득!🏆<br>
                                    ✍ 발빠른 피드백과 세세한 강의법!<br>
                                    개인별 평가 및 맞춤 지도까지!✨<br>
                                    10년 이상의 경력과 노하우를 가진 교강사진이 여러분과 함께합니다! 🤫
                                </p>
                            </div> -->
                        </div>
                        <!-- 커리큘럼 -->
                        <div class="courseSectionWrap" id="cd-section02">
                            <div class="course-section">
                                <h2 class="h2 title">커리큘럼</h2>
                                <p class="section-txt margin-top20">
                                    본 과정은 일본어 우수자를 대상으로 취업전략교육을 집중적으로 실시하는 단기과정입니다.
                                </p>
                                <div class="courseTableWrap">
                                    <ul class="courseTable">
                                        <li class="courseTr">
                                            <div class="fc_point">상세 커리큘럼</div>
                                            <ul class="courseTd">
                                                <li><strong>Biz 일본어</strong></li>
                                                <li>- 경어, 메일작성</li>
                                                <li><strong>취업전략</strong></li>
                                                <li>- 자기분석</li>
                                                <li>- 이력서, 포트폴리오/자기PR영상</li>
                                                <li>- 기업별 채용전형 대비(SPI/작문/평가대비)</li>
                                                <li>- 면접전략, 모의면접</li>
                                            </ul>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                            <!-- <div class="course-section margin-top40">
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
                            </div> -->
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
                                        <strong>"집중적으로 실시하는 취업전략교육으로 취업 준비에 날개를 달아드립니다. "</strong>
                                        <h5 class="fc_999 margin-top10">
                                            - 일본어 교강사 ㅇㅇㅇ
                                        </h5>
                                    </div>
                                </div>

                                <!-- <div class="course-section">
                                    <h3 class="h3 section-subTitle">강사의 다른 강의를 만나보세요! 😀</h3>
                                    <ul class="courseList d-flex flexWrap">
                                        <li class="cs_ict">
                                            <a href="course-detail.html">
                                                <div class="courseImg"><img src="" alt=""></div>
                                                <div class="courseTxt">
                                                    <div class="fc_666">코딩 챌린지 과정 1기</div>
                                                    <div class="fc_999">4주 완성! 사전학습 종합반</div>
                                                </div>
                                            </a>
                                        </li>
                                        <li class="cs_ict">
                                            <a href="course-detail.html">
                                                <div class="courseImg"><img src="" alt=""></div>
                                                <div class="courseTxt">
                                                    <div class="fc_666">SoftWare DevOps MASTER 8기</div>
                                                    <div class="fc_999">SW/AI 해외취업연계과정</div>
                                                </div>
                                            </a>
                                        </li>
                                        <li class="cs_ict">
                                            <a href="course-detail.html">
                                                <div class="courseImg"><img src="" alt=""></div>
                                                <div class="courseTxt">
                                                    <div class="fc_666">Digital Ai Big-data Cloud Master 1기</div>
                                                    <div class="fc_999">SW/AI 해외취업연계과정</div>
                                                </div>
                                            </a>
                                        </li>
                                        <li class="cs_ict">
                                            <a href="course-detail.html">
                                                <div class="courseImg"><img src="" alt=""></div>
                                                <div class="courseTxt">
                                                    <div class="fc_666">Smart Cloud IT MASTER 42기</div>
                                                    <div class="fc_999">SW/AI 해외취업연계과정</div>
                                                </div>
                                            </a>
                                        </li>
                                        <li class="cs_ict">
                                            <a href="course-detail.html">
                                                <div class="courseImg"><img src="" alt=""></div>
                                                <div class="courseTxt">
                                                    <div class="fc_666">Smart Cloud IT MASTER 42기</div>
                                                    <div class="fc_999">SW/AI 해외취업연계과정</div>
                                                </div>
                                            </a>
                                        </li>
                                    </ul>
                                </div> -->
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
                            <div class="bgc_point fz18 courseCount">개설 준비 중인 과정입니다.</div>
                        </div>
                    </div>
                    <ul class="courseTxtWrap">
                        <li class="cs-title">
                            <div class="fc_point">글로벌 잡매칭</div>
                            <div class="fz20">일본취업 스킬업</div>
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
                    <a class="d-flex justify_center inquiry" href="">
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
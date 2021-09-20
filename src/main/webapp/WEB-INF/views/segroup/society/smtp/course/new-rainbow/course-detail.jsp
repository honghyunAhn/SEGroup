<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <%@include file="../../include/rainbow_head.jsp"%>
    <script src="/resources/segroup/society/smtp/js/rainbowScript_courseDetail.js"></script>
    <script type="text/javascript">
        const dDay = new Date("July 22,2021, 23:59:59").getTime();
    </script>
</head>

<body>
    <div class="container_rainbow container-courseDetail bgc_eee">
    	<%@include file="../../include/rainbow_header.jsp"%>
        <div class="content course-detail course-point01" id="main">
            <div class="mainBackVideoWrap" onclick="togglePlay()">
                <div class="background_video video_main">
                    <video src="/resources/segroup/society/smtp/video/02ICT_Office.mp4" width='100%' autoplay loop muted>
                        <!-- <source src="video/01main_Earth.mp4" type="video/"> -->
                    </video>
                    <div class="opacity_bg op08" id="scrollFixed01">
                        <div class="bannerTextWrap fz20 fc_fff">
                            <div class="fc_point">해외취업과정</div>
                            <h2 class="h2">Digital ABC 마스터</h2>
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
                                    2001년 이후 한국무역협회와 함께 글로벌 ICT 전문 인력을 양성해온 Soft Engineer Society는 지역청년을 위한 교육센터를
                                    광주(2018)에
                                    이어 부산(2021)에 개소합니다. 부산교육센터에서 첫 번째로 런칭하는 교육과정은 지난 21년간 취업률 97%를 기록했던 일본 ICT 직무
                                    취업연계과정인
                                    「Digital ABC 마스터」 과정(K-MOVE 스쿨)입니다.
                                    프로그래밍, 디지털/AI, 외국어(일본어) 등의 커리큘럼으로 구성되며 글로벌 ICT기업 정규직 취업을 목표로 하고 있습니다.
                                </p>
                            </div>
                            <div class="course-detailBox bgc_point">
                                <h3 class="h3">
                                    미래지향 글로벌 인재로 거듭날 수 있는 기회! &#128588;
                                </h3>
                                <p>
                                    AI, Big-data, Cloud 마스터하고, 글로벌 기업에서 커리어를 시작하자!
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
                                            <li>2021.07.11(일) 까지</li>
                                        </ul>
                                    </div>
                                    <div class="d-flex jus">
                                        <ul class="infoTh d-flex">
                                            <li class="img-icon calendar"></li>
                                            <li class="thTxt">교육기간</li>
                                        </ul>
                                        <ul class="infoTd">
                                            <li>2021.07.20 ~ 2022.05.26</li>
                                            <li>월/화/수/목 08:30 ~ 18:00</li>
                                        </ul>
                                    </div>
                                    <div class="d-flex">
                                        <ul class="infoTh d-flex">
                                            <li class="img-icon user"></li>
                                            <li class="thTxt">수강대상</li>
                                        </ul>
                                        <ul class="infoTd">
                                            <li>IT/일본어 전공자, 비전공자 모두 환영합니다!</li>
                                            <li>- 2/4년제 대학 졸업자 및 예정자(2022.03)</li>
                                            <li>- 만 34세 이하 대한민국 청년</li>
                                        </ul>
                                    </div>
                                    <div class="d-flex">
                                        <ul class="infoTh d-flex">
                                            <li class="img-icon hand-holding-heart"></li>
                                            <li class="thTxt">교육혜택</li>
                                        </ul>
                                        <ul class="infoTd">
                                            <li>- <span class="fc_point">국민취업제도</span> 대상 과정</li>
                                            <li>- 해외취업정착지원금<span class="fc_point">(최대 400만원 지급)</span></li> 
                                            <li>- 부산시 외 타지역 거주자 주거 이전 시
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
                                            <li>1,000,000원</li>
                                            <li class="fc_point">
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
                                            </li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- 커리큘럼 -->
                        <div class="courseSectionWrap" id="cd-section02">
                            <div class="course-section">
                                <h2 class="h2 title">커리큘럼</h2>
                                <div class="course-curriculumWrap">
                                    <ul class="curriculum">
                                        <li class="curriculum-title h3 fc_point04">ICT 교육</li>
                                        <li class="curriculum-txt">
                                            ICT 교육은 컴퓨터 활용 기초부터 프로그래밍 언어를 활용한 웹 개발,
                                            클라우드 기반의 서비스 관리, 데이터를 활용한 AI 분야까지 배울 수 있습니다.
                                            이론 수업과 단계별 실습을 통해 다양한 기술을 경험하고 ICT분야 진출하기 위한 직무능력을 갖추게 됩니다.
                                        </li>
                                        <li class="curriculum-boxWrap d-flex">
                                            <div class="curriculum-box">
                                                <div class="fz16 cc-boxTitle">기본교육</div>
                                                <ul class="cc-boxContent">
                                                    <li>컴퓨터 활용 기초</li>
                                                    <li>프로그래밍 언어</li>
                                                    <li>자료구조와 알고리즘</li>
                                                    <li>웹 프로그래밍</li>
                                                    <li>프레임워크 활용</li>
                                                </ul>
                                            </div>
                                            <div class="curriculum-box">
                                                <div class="fz16 cc-boxTitle">특화교육</div>
                                                <ul class="cc-boxContent">
                                                    <li>리눅스 서버 운영</li>
                                                    <li>클라우드 기반 서비스 관리</li>
                                                    <li>데이터 분석 및 시각화</li>
                                                    <li>AI 활용</li>
                                                </ul>
                                            </div>
                                            <div class="curriculum-box">
                                                <div class="fz16 cc-boxTitle">취업교육</div>
                                                <ul class="cc-boxContent">
                                                    <li>프로젝트 분석 및 설계</li>
                                                    <li>기술면접대비</li>
                                                    <li>포트폴리오 작성</li>
                                                </ul>
                                            </div>
                                        </li>
                                    </ul>
                                    <ul class="curriculum">
                                        <li class="curriculum-title h3 fc_point02">외국어 교육</li>
                                        <li class="curriculum-txt">
                                            외국어 교육은 일본어 기초 문법과 회화부터 면접을 위한 비즈니스 일본어까지 취업에 최적화된 교육을 제공합니다.
                                            개개인의 일본어 역량을 파악하고 소그룹으로 나누어 레벨에 맞게 교육을 진행합니다.
                                        </li>
                                        <li class="curriculum-boxWrap d-flex">
                                            <div class="curriculum-box">
                                                <div class="fz16 cc-boxTitle">일본어 초·중급</div>
                                                <ul class="cc-boxContent">
                                                    <li>기초 문법 및 회화</li>
                                                    <li>어휘/작문/독해</li>
                                                    <li>주제별 회화능력 향상</li>
                                                </ul>
                                            </div>
                                            <div class="curriculum-box">
                                                <div class="fz16 cc-boxTitle">비즈니스 일본어</div>
                                                <ul class="cc-boxContent">
                                                    <li>비즈니스 문서 작성</li>
                                                    <li>비즈니스 회화</li>
                                                    <li>프레젠테이션</li>
                                                </ul>
                                            </div>
                                            <div class="curriculum-box">
                                                <div class="fz16 cc-boxTitle">취업교육</div>
                                                <ul class="cc-boxContent">
                                                    <li>JPT 특별시험</li>
                                                    <li>이력서 작성</li>
                                                    <li>모의면접</li>
                                                    <li>일본기업 문화</li>
                                                </ul>
                                            </div>
                                        </li>
                                    </ul>
                                    <ul class="curriculum">
                                        <li class="curriculum-title h3 fc_point05">취업 역량 향상</li>
                                        <li class="curriculum-txt">
                                            정규 교육 외 취업역량향상을 위해 다음과 같은 교육을 실시합니다.
                                        </li>
                                        <li class="curriculum-boxWrap d-flex">
                                            <div class="curriculum-box">
                                                <div class="fz16 cc-boxTitle">특강</div>
                                                <ul class="cc-boxContent">
                                                    <li>일본 ICT산업 재직자(졸업자) 초청 특강 및 토크콘서트</li>
                                                    <li>기술 트렌드 특강</li>
                                                </ul>
                                            </div>
                                            <div class="curriculum-box">
                                                <div class="fz16 cc-boxTitle">개별 코칭</div>
                                                <ul class="cc-boxContent">
                                                    <li>개별 면접 코칭 및 매너</li>
                                                    <li>일본취업 커리어 관리</li>
                                                </ul>
                                            </div>
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
                                            <a href="/smtp/course/new-rainbow/new-rainbow-info?course_id=course-detail">
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
                                <a href="https://pf.kakao.com/_sxoRxjs">
                                    <div class="addKakaoBanner">
                                        <div class="d-flex justify_center">
                                            <div class="img-icon kakao-icon80"></div>
                                            <div class="textWrap">
                                                <h2 class="h2">카카오톡 채널에서 <span>"abc마스터"</span> 를 검색하세요!</h2>
                                                <p>
                                                    <span>"abc마스터"</span> 채널 추가하고 다양한 혜택과 다양한 이벤트 소식을 누구보다 빠르게 받아보세요.
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
                            <div class="bgc_point fz18 courseCount">모집마감일 : 21.07.22 까지</div>
                        </div>
                    </div>
                    <ul class="courseTxtWrap">
                        <li class="cs-title">
                            <div class="fc_point">해외취업과정</div>
                            <div class="fz20">Digital ABC 마스터</div>
                        </li>
                        <li class="cs-price">
                            <div class="course-price">￦ 1,000,000</div>
                            <span class="h2">￦&nbsp;0</span>&nbsp;<span class="fc_999">(교육비 할인 제도 적용시)</span>
                        </li>
                        <li class="cs-term">
                            <div class="d-flex">
                                <div class="img-icon calendar"></div>
                                <div class="margin-left5">교육기간 : 2021.07.20 ~ 2022.05.26</div>
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
                    <a class="d-flex justify_center inquiry" href="https://pf.kakao.com/_sxoRxjs">
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
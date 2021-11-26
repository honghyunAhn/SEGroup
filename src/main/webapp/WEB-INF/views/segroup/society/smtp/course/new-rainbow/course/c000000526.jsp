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
        <div class="content course-detail course-point01" id="main">
            <div class="mainBackVideoWrap" onclick="togglePlay()">
                <div class="background_video video_main">
                    <video src="/resources/segroup/society/smtp/video/02ICT_Office.mp4" width='100%' autoplay loop muted>
                        <!-- <source src="video/01main_Earth.mp4" type="video/"> -->
                    </video>
                    <div class="opacity_bg op08" id="scrollFixed01">
                        <div class="bannerTextWrap fz20 fc_fff">
                            <div class="fc_point">해외취업과정</div>
                            <h2 class="h2">광주 SoftWareDevOps MASTER</h2>
                        </div>
                    </div>
                </div>
                <div class="rainbow-sideBg bg05 leftSide"></div>
            </div>
            <div class="detail-menuWrapper" id="scrollFixed02">
                <ul class="detail-menuWrap d-flex">
                    <li class="detailMenu active" data-link="#cd-section01">과정소개</li>
                    <li class="detailMenu" data-link="#cd-section02">커리큘럼</li>
                    <!-- <li class="detailMenu" data-link="#cd-section03">강사소개</li> -->
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
                                    광주/전남 지역 해외취업인재 양성을 위해 광주해외취업협의회 광주지역 내 9개 대학과 5개의 유관기관이 협력하여 만들어진 과정으로 2018년 10월
                                    1기를 시작으로 현재 6기 까지 교육이 진행되고 있으며, 1기 ~ 4기 94%가 연봉 3,200만원 이상의 일본 유수의 기업에 취업 성공을
                                    달성하였습니다.
                                </p>
                            </div>
                            <div class="course-detailBox bgc_point">
                                <h3 class="h3">
                                    서울에서 20년간 진행된 국내 최고의 글로벌 SW인재 양성과정을 이제는 광주에서!🚀
                                </h3>
                                <p class="margin-top20">
                                    2001년부터 현재까지 20년간 해외취업인재 2500명 이상을 배출하여 일본 ICT정규직<br>
                                    취업성공 97%를 달성한 노하우를 가지고 있는 Soft Engineer Society에서 운영하는 과정입니다.
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
                                            <li>IT/일본어 전공자, 비전공자 모두 환영합니다!</li>
                                            <li>- 2/4년제 대학 졸업자 및 예정자(2022.03)</li>
                                            <li>- 만 34세 이하 대한민국 청년</li>
                                            <li>- ICT 글로벌 커리어를 쌓고 싶은 대한민국 청년</li>
                                            <li>- 해외취업에 대한 의지가 확고한 분</li>
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
                                            <li>- <span class="fc_point">전액 국비지원</span>(개인부담금 없음)
                                            </li>
                                        </ul>
                                    </div>
                                    <div class="d-flex">
                                        <ul class="infoTh d-flex">
                                            <li class="img-icon won-sign"></li>
                                            <li class="thTxt">교육비</li>
                                        </ul>
                                        <ul class="infoTd">
                                            <li><span class="expenses"></span>원(전액 국비지원)</li>
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
                            <div class="course-section textAlign_center margin-top40">
                                <h3 class="section-txt section-txt20">
                                    💻 오프라인/온라인 완벽 강의!
                                    <br>.<br>.<br>.<br>
                                </h3>
                                <p class="section-txt margin-top20">
                                    오래된 녹화방송은 가라! 코로나 시대! 언택트 비대면 완벽 대응!<br>
                                    개인 PC가 없어도 괜찮아요!<br> 희망자에 한해 노트북을 대여해드립니다!
                                </p>
                            </div>
                            <div class="course-section textAlign_center margin-top40">
                                <h3 class="section-txt section-txt20">
                                    해외IT진출 노하우 보유!🚀
                                    <br>.<br>.<br>.<br>
                                </h3>
                                <p class="section-txt margin-top20">
                                    서울 코엑스, 부산무역회관, 광주무역회관까지!<br>
                                    21년간 2,700여명의 학생들에 대해 IT직무/외국어비즈니스 교육부터 취업준비까지 한번에!<br>
                                    매년 상/하반기 브릿지 도쿄 잡페어 개최(200여개사의 풀, 평균 50개 기업)
                                </p>
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
                                                - 4기 수료생 곽**
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
                                                - 3기 수료생 김**
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
                                                - 3기 수료생 강**
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
                                                SWDO마스터 과정 지원자격은 전문대졸(예정포함)이상의 취업희망자를 대상으로 하며, 전공은 불문입니다. 각종 IT관련 자격증 및
                                                정보처리기사 소지자, 외국어 공인 시험 성적 소지자 또한 선발과정에 유리하지만, 자격증 미 소지자라고해서 불합격처리 되는 것은
                                                아닙니다.
                                                또한 SWDO마스터 과정의 협력대학(MOU체결대학)의 추천학생은 선발면접 전형에 가산점이 있고, 각 선발 기수의 사전학습반을
                                                무사히 수료한 지원자의 경우도 가산점이 있습니다.
                                            </div>
                                        </li>
                                        <li class="faq">
                                            <div class="questionWrap d-flex justify_between">
                                                <div class="question">
                                                    <span class="fc_point">Q. </span>하루 수업은 어떻게 진행되는지 궁금합니다.
                                                </div>
                                                <div class="img-icon angle-down"> </div>
                                            </div>
                                            <div class="answerWrap">
                                                하루 수업은 오전 8시 30분부터 오후 6시까지 총 7시간(점심 식사시간 제외)에 걸쳐 이뤄지며, 8시 30분, 18시에
                                                출석체크가 이루어집니다. 7시간의 수업은 IT 3시간, 외국어 2~3시간(변동 가능), Review 1~2시간으로 구성되며 중간에
                                                점심식사시간(변동 가능)이 있습니다.
                                                외국어 수업은 입학 후 이뤄지는 테스트 및 면접을 통해 수준별 분반으로 수업이 진행됩니다.
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
                                                SWDO마스터 과정 입학을 위한 사전준비로는 우선 본인의 적성 및 향후 진로에 SWDO마스터 과정이 적합한지를 신중히 판단하는
                                                것을 들 수 있겠습니다. SWDO마스터 과정 커리큘럼은 강한 의지와 체력을 필요로 합니다. 기본 교육 커리큘럼을 충분히 소화하기
                                                위해서는 본인의 목표와 동기의식이 뚜렷해야 한다는 점을 간과해서는 안됩니다. SWDO마스터 과정 입학의사가 일단 뚜렷해 졌다면
                                                입학까지 남은 기간을 이용해 본인에게 부족한 학습을 사전에 준비하는 과정도 도움이 됩니다.
                                                <div class="d-flex margin-top20">
                                                    <h5 class="h5 fc_999">
                                                        ※ ICT/일본어 모두 비전공자라면 "코딩챌린지(사전학습반)" 과정을 추천합니다.
                                                    </h5>
                                                    <a style="width:100px" href="rainbow-course01-01.html"
                                                        class="margin-left10 btn_normal btn_small bgc_point">과정 바로가기</a>
                                                </div>
                                            </div>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                            <div class="course-detailBanner">
                                <a href="https://pf.kakao.com/_exoPxjs">
                                    <div class="addKakaoBanner">
                                        <div class="d-flex justify_center">
                                            <div class="img-icon kakao-icon80"></div>
                                            <div class="textWrap">
                                                <h2 class="h2">카카오톡 채널에서 <span>"swdo마스터"</span> 를 검색하세요!</h2>
                                                <p>
                                                    <span>"swdo마스터"</span> 채널 추가하고 다양한 혜택과 다양한 이벤트 소식을 누구보다 빠르게
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
                            <img src="/resources/segroup/society/smtp/img/course_thumb03.jpg" alt="">
                            <div class="bgc_point fz18 courseCount">개설 준비 중인 과정입니다.</div>
                        </div>
                    </div>
                    <ul class="courseTxtWrap">
                        <li class="cs-title">
                            <div class="fc_point">해외취업과정</div>
                            <div class="fz20">광주 SoftWareDevOps MASTER</div>
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
		<%@include file="../../../include/banner_full.jsp"%>
		<%@include file="../../../include/rainbow_footer.jsp"%>
    </div>
</body>
</html>
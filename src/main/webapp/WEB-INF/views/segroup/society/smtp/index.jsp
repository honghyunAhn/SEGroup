<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <%@include file="include/rainbow_head.jsp"%>
</head>

<body>
    <div class="container_rainbow">
    	<%@include file="include/rainbow_header.jsp"%>
        <div class="content" id="main">
            <!-- 메인배너 -->
            <div class="mainBackVideoWrap" onclick="togglePlay()">
                <div class="background_video video_main">
                    <video src="/resources/segroup/society/smtp/video/01main_Earth.mp4" width='100%' autoplay loop muted></video>
                    <div class="opacity_bg op08">
                        <div class="bannerTextWrap fz20 fc_fff">
                            <div class="fc_point03">Blended-rainbow Program</div>
                            <h2 class="h2">디지털 융합 인재양성</h2>
                            <p class="op06 margin-top20">
                                “Design convergence talent”<br>Fostering multiple intelligences in design convergence
                                talents.
                            </p>
                            <div class="margin-top20">다양한 전공과 ICT·AI를 융합하여 K-Digital 인재로 컬러링 해드립니다.</div>
                        </div>
                    </div>
                </div>
                <div class="rainbow-sideBg bg01 rightSide"></div>
            </div>
            <div class="courseContainer">
                <div class="courseWrapper">
                    <div class="courseWrap textAlign_center">
                        <div class="textWrap">
                            <h2 class="h2">Blended-rainbow Program 모집과정</h2>
                            <p class="fz20">다양한 전공의 인재를 21세기형 ICT융합인재로 양성하여 해외 유수의 기업에서 활동할 기회를 제공하고,<br>기업 및 산업계간의 글로벌
                                협력을
                                통하여 새로운 가치를 창출하는 네트워크를 확대해 가는 것을 목표로 합니다.</p>
                        </div>
                        <div class="courseListWrap d-flex flexWrap">
                            <div class="course bgc_point01">
                                <div class="courseTitle">
                                    <div class="img-icon university"></div>
                                    <div>해외취업캠퍼스 </div>
                                </div>
                                <ul class="courseList fc_333">
                                    <li><a href="">코딩챌린지(사전학습반)</a></li>
                                    <li><a href="">광주 SWDO MASTER</a></li>
                                    <li><a href="">부산 ABC MASTER</a></li>
                                </ul>
                                <div class="btn_moreList">
                                    <a href="/smtp/course/new-rainbow/new-rainbow-info?course_id=rainbow-cousre01">과정 더 보기 &nbsp;&gt;</a>
                                </div>
                            </div>
                            <div class="course bgc_point02">
                                <div class="courseTitle">
                                    <div class="img-icon credit-card"></div>
                                    <div>내일배움카드 과정</div>
                                </div>
                                <ul class="courseList fc_333">
                                    <li><a href="/smtp/course/new-rainbow/new-rainbow-info?course_id=rainbow-course02-01">파이썬 기초 과정</a></li>
                                    <li><a href="/smtp/course/new-rainbow/new-rainbow-info?course_id=rainbow-course02-02">JAVA기반 웹 개발자 과정</a></li>
                                </ul>
                                <div class="btn_moreList">
                                    <a href="/smtp/course/new-rainbow/new-rainbow-info?course_id=rainbow-cousre02">과정 더 보기 &nbsp;&gt;</a>
                                </div>
                            </div>
                            <div class="course bgc_point03">
                                <div class="courseTitle">
                                    <div class="img-icon id-card"></div>
                                    <div>자격증 코스</div>
                                </div>
                                <ul class="courseList fc_333">
                                    <li><a href="">토익/토플 접수</a></li>
                                    <li><a href="">일본취업 스킬업</a></li>
                                    <li><a href="">정보처리자격증</a></li>
                                </ul>
                                <div class="btn_moreList">
                                    <a href="/smtp/course/new-rainbow/new-rainbow-info?course_id=rainbow-cousre03">과정 더 보기 &nbsp;&gt;</a>
                                </div>
                            </div>
                            <div class="course bgc_point04">
                                <div class="courseTitle">
                                    <div class="img-icon globe-stand"></div>
                                    <div>글로벌 잡매칭</div>
                                </div>
                                <ul class="courseList fc_333">
                                    <li><a href="">브릿지 잡페어</a></li>
                                </ul>
                                <div class="btn_moreList">
                                    <a href="/smtp/course/new-rainbow/new-rainbow-info?course_id=rainbow-cousre04">과정 더 보기 &nbsp;&gt;</a>
                                </div>
                            </div>
                        </div>
                        <div class="btn_allList">
                            <a href="/smtp/course/new-rainbow/new-rainbow-info?course_id=course-list">전체 과정 보기 &nbsp;&gt;</a>
                        </div>
                    </div>
                    <%@include file="include/banner_full.jsp"%>
                </div>
                <!-- <div class="rainbow-sideBg bg02 rightSide"></div> -->
            </div>

            <div class="companyIntroWrapper">
                <div class="companyIntroWrap">
                    <div class="textWrap textAlign_center">
                        <h2 class="h2">Soft Engineer Society는<br>다양한 전공의 인재들을 ICT와 융합, 글로벌 인재를 양성합니다.</h2>
                    </div>
                    <div class="companyIntro d-flex flexWrap margin-top40">
                        <video src="/resources/segroup/society/smtp/video/softsociety.mp4" controls></video>
                        <div class="introWrap">
                            <ul class="intro">
                                <li class="fz20">21세기형 융복합 ICT 인재 양성</li>
                                <li>과학기술정보통신부 지정 SW전문인력양성기관 지정</li>
                                <li>한국무역협회 컨소시움, 해외진출 ICT 인재양성과정 운영(Since2001)</li>
                            </ul>
                            <ul class="intro">
                                <li class="fz20">글로벌 인프라 구축</li>
                                <li>한일간 ICT 인재교류회 사무국 운영</li>
                                <li>공인시험센터 운영 : 토익, 토플, 오픽</li>
                                <li>해외위탁기업 제휴 교육 운영 및 관리</li>
                            </ul>
                            <ul class="intro">
                                <li class="fz20">전문분야</li>
                                <li>ICT 인재양성(온·오프라인 교육, 강의)</li>
                                <li>영어/일본어 비즈니스 랭귀지 코스 운영</li>
                                <li>해외취업연계, 기업지원 컨설팅, 취업특강 등</li>
                                <li>평생교육시설운영(ICT지식, 인력개발)</li>
                            </ul>
                            <ul class="intro">
                                <li class="fz20">국내·외 ICT 인재 기업 매칭</li>
                                <li>해외취업 플랫폼 구축, 채용시스템 운영(Find Job System)</li>
                                <li>일본 도쿄 잡페어 정례 개최 및 운영(약 1,800명 해외 진출)</li>
                                <li>산업인력공단 지정 해외 취업 우수기관(2015 ~ 현재)</li>
                            </ul>
                        </div>
                    </div>
                </div>
                <div class="rainbow-sideBg bg03 leftSide"></div>
            </div>

            <div class="managementWrapper">
                <div class="managementWrap textAlign_center">
                    <div class="textWrap">
                        <h2 class="h2">여러분의 취업을 응원합니다.</h2>
                    </div>
                    <div class="d-flex flexWrap fz20">
                        <div class="management">
                            <div class="picture img-icon user-blank"><img src="/resources/segroup/society/smtp/img/222.jpg" alt="ICT교강사 이종호"></div>
                            <p class="mainTxt">
                                한걸음씩 천천히 따라오시다 보면 어느새 전공자가 되어있을겁니다.
                            </p>
                            <p class="writer">
                                <span class="fc_point05">ICT교강사</span> 이종호
                            </p>
                        </div>
                        <div class="management">
                            <div class="picture img-icon user-blank">
                                <img src="" alt="취업팀 나가오 히사미">
                            </div>
                            <p class="mainTxt">
                                취업은 혼자하는게 아닙니다. 매칭 플랫폼으로 다양한 분야에 도전하세요.
                            </p>
                            <p class="writer">
                                <span class="fc_point02">취업팀</span> 나가오 히사미
                            </p>
                        </div>
                        <div class="management">
                            <div class="picture img-icon user-blank"><img src="" alt="취업운영팀 고인혁"></div>
                            <p class="mainTxt">
                                교육기간동안 가장 중요한 학사관리! 책임지고 역량을 강화시켜드립니다.
                            </p>
                            <p class="writer">
                                <span class="fc_point06">취업운영팀</span> 고인혁
                            </p>
                        </div>
                        <div class="management">
                            <div class="picture img-icon user-blank"><img src="" alt="SCIT 38기 졸업생 홍O동"></div>
                            <p class="mainTxt">
                                한걸음씩 천천히 따라오시다 보면 어느새 전공자가 되어있을겁니다.
                            </p>
                            <p class="writer">
                                SCIT 38기 졸업생 홍O동
                            </p>
                        </div>
                        <div class="management">
                            <div class="picture img-icon user-blank"><img src="" alt="SCIT 38기 졸업생 홍O동"></div>
                            <p class="mainTxt">
                                취업은 혼자하는게 아닙니다. 매칭 플랫폼으로 다양한 분야에 도전하세요.
                            </p>
                            <p class="writer">
                                SCIT 38기 졸업생 홍O동
                            </p>
                        </div>
                        <div class="management">
                            <div class="picture img-icon user-blank"><img src="" alt="SCIT 38기 졸업생 홍O동"></div>
                            <p class="mainTxt">
                                교육기간동안 가장 중요한 학사관리! 책임지고 역량을 강화시켜드립니다.
                            </p>
                            <p class="writer">
                                SCIT 38기 졸업생 홍O동
                            </p>
                        </div>
                    </div>
                </div>
                <div class="rainbow-sideBg bg04 rightSide"></div>
            </div>

            <div class="partnerWrapper">
                <div class="partnerWrap">
                    <div class="textWrap textAlign_center">
                        <h2 class="h2">Soft Engineer Society와 함께하는 파트너</h2>
                        <p class="fz20">Soft Engineer Society는 다양한 글로벌 기업들과의 협력을 통하여 새로운 가치 창출을 목표로 합니다.</p>
                    </div>
                    <ul class="partner d-flex flexWrap">
                        <li class="partnerImg"><img src="/resources/segroup/society/smtp/img/img-logo_01.png" alt="한국무역협회 무역아카데미"></li>
                        <li class="partnerImg"><img src="/resources/segroup/society/smtp/img/img-logo_02.png" alt="한국산업인력공단"></li>
                        <li class="partnerImg"><img src="/resources/segroup/society/smtp/img/img-logo_03.png" alt="고용노동부"></li>
                        <li class="partnerImg"><img src="/resources/segroup/society/smtp/img/img-logo_04.png" alt="과학기술정보통신부"></li>
                        <li class="partnerImg"><img src="/resources/segroup/society/smtp/img/img-logo_05.png" alt="광주광역시"></li>
                        <li class="partnerImg"><img src="/resources/segroup/society/smtp/img/img-logo_06.png" alt="한국산업기술대학교"></li>
                        <li class="partnerImg"><img src="/resources/segroup/society/smtp/img/img-logo_07.png" alt="전남대학교"></li>
                        <li class="partnerImg"><img src="/resources/segroup/society/smtp/img/img-logo_08.png" alt="호남대학교"></li>
                        <li class="partnerImg"><img src="/resources/segroup/society/smtp/img/img-logo_09.png" alt="조선대학교"></li>
                        <li class="partnerImg"><img src="/resources/segroup/society/smtp/img/img-logo_10.png" alt="Rakuten"></li>
                        <li class="partnerImg"><img src="/resources/segroup/society/smtp/img/img-logo_11.png" alt="IBM"></li>
                        <li class="partnerImg"><img src="/resources/segroup/society/smtp/img/img-logo_12.png" alt="Amazon"></li>
                        <li class="partnerImg"><img src="/resources/segroup/society/smtp/img/img-logo_13.png" alt="SoftBank"></li>
                        <li class="partnerImg"><img src="/resources/segroup/society/smtp/img/img-logo_14.png" alt="Shima Seiki"></li>
                        <li class="partnerImg"><img src="/resources/segroup/society/smtp/img/img-logo_15.png" alt="Cocone"></li>
                        <li class="partnerImg"><img src="/resources/segroup/society/smtp/img/img-logo_16.png" alt="Kissco"></li>
                    </ul>
                </div>
                <div class="rainbow-sideBg bg05 leftSide"></div>
            </div>
        </div>
        <%@include file="include/rainbow_footer.jsp"%>
    </div>

</body>

</html>
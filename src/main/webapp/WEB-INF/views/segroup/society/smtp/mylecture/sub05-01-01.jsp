<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
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
    
	<!-- 레인보우 기본 세팅 -->
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
    
	<!-- 탭당 스크립트 소스 -->
	<!-- 출결관리 -->
    <script src="/resources/segroup/society/smtp/js/rainbow_attendance_script.js"></script>
	<!-- 성적관리 -->
	<script src="/resources/segroup/society/smtp/js/rainbow_score_script.js"></script>
	<!-- 온라인 시험 -->
	<script src="/resources/segroup/society/smtp/js/rainbow_exam_script.js"></script>
	<!-- 온라인 과제 -->
	<script src="/resources/segroup/society/smtp/js/rainbow_report_script.js"></script>
	
    <!-- 과정공지사항 -->
    <script src="/resources/segroup/society/smtp/js/rainbow_courseNotice_script.js"></script>
    <!-- QnA -->
    <script src="/resources/segroup/society/smtp/js/rainbow_qna_script.js"></script>
    <!-- 설문조사 -->
    <script src="/resources/segroup/society/smtp/js/rainbow_survey_script.js"></script>
    
	<!-- 추가 라이브러리 및 css -->
	<link rel="stylesheet" href="<c:url value="/resources/css/user_02_myPage_style.css" />">
	<!-- chart -->
	<script src="<c:url value="/resources/js/Chart.js" />"></script> 
	<script src="<c:url value="/resources/js/user_02_myPage_script.js" />"></script>
	<!-- fullcalendar -->
	<link href='/resources/js/ext/fullcalendar/css/fullcalendar.css' rel='stylesheet' />
	<link rel="stylesheet" href="<c:url value="/resources/css/fullcalendar-main.css" />"> 
	<script src="<c:url value="/resources/js/fullcalendar-main.js" />"></script>
	<!-- Pagination -->
	<script type="text/javascript" src="/resources/js/jquery.twbsPagination.js"></script>
    <script type="text/javascript">
    	var course_name = '${classInfo.NAME}';
    	var cardinal_name = '${classInfo.CARDINAL_NAME}';
    </script>
</head>

<body>
    <div class="container_rainbow rainbow_myClass">
        <!-- Header-include -->
        <%@include file="../include/rainbow_header_basic.jsp" %>

        <div class="content sub-content content_myClsss" id="main">
            <div class="background">
                <div class="opacity_bg">
                    <!-- 메인배너 -->
                    <div class="bannerTextWrap fc_fff">
                        <div class="fz20">
                            나의강의실
                        </div>
                        <div class="horizonBar bgc_pp"></div>
                    </div>

                </div>
            </div>
            <div class="section section_sub05-01">
                <div class="myClass-tabMenu">
                    <div class="bgc_pb fc_fff">
                        <ul class="myClass-tabGroup d-flex justify_center">
                            <li class="active">출결관리</li>
                            <li>성적관리</li>
                            <li>온라인과제</li>
                            <li>온라인시험</li>
                            <li>공지사항</li>
                            <li onclick="qnaMain()">QnA</li>
                            <li>설문조사</li>
                        </ul>
                    </div>
                    <div class="myClass-subGroup">
						<!-- 출결관리 -->
                        <div class="tab-sub tab-sub01">
                        	<div id='calendar'></div>
                        	<br><br>
                        	<div class="tabTableWrap article">
                        		<table class='sisuTable tab_table table'></table>
                        	</div>
                        </div>
                        <!-- 성적관리 -->
                        <div class="tab-sub tab-sub02">
                        	<div class="articleWrapper" id="score">
                        		<div class="articleWrap">
			                        <div class="article">
			                            <div class="articleSubHdr">종합성적</div>
			                            	<div class="layout_half d-flex justify_between">
				                                <div class="graphWrap article tabTableWrap" style="width: 50%;">
				                                    <canvas class="graph" id="myChart" style="-moz-user-select: none; -webkit-user-select: none; -ms-user-select: none;"></canvas>
				                                </div>
				                                <div class="tabTableWrap article add1" style="width: 50%;"></div>
			                            	</div>
			                            <div class="d-flex">
				                            <div class="tabTableWrap article add2"></div>
			                            </div>
			                        </div>                        
			                    </div>
                        	</div>
                        </div>
                        <!-- 온라인과제 -->
                        <div class="tab-sub tab-sub03">
                            <div class="sub-segment table">
                                <ul class="class-list-title thead d-flex">
                                    <li class="c-table-num">No.</li>
                                    <li class="c-table-name-wide">과제명</li>
                                    <li class="c-table-02">과제기간</li>
                                    <li class="c-table-01">진행여부</li>
                                    <li class="c-table-01">점수</li>
                                </ul>
                                <ul class="class-list-wrap report">
                                    
                                </ul>
                            </div>
<!--                             <div class="page"> -->
<!--                                 <ul class="pagination d-flex justify_between"> -->
<!--                                     <li> -->
<!--                                         <a href="#" class="prev"> -->
<!--                                             <div class="img-icon angle-left floatL"></div>PREV -->
<!--                                         </a> -->
<!--                                     </li> -->
<!--                                     <li><a href="#" class="active num">1</a></li> -->
<!--                                     <li><a href="#" class="num">2</a></li> -->
<!--                                     <li><a href="#" class="num">3</a></li> -->
<!--                                     <li><a href="#" class="num">4</a></li> -->
<!--                                     <li><a href="#" class="num">5</a></li> -->
<!--                                     <li> -->
<!--                                         <a href="#" class="next"> -->
<!--                                             <div class="img-icon angle-right floatR"></div>NEXT -->
<!--                                         </a> -->
<!--                                     </li> -->
<!--                                 </ul> -->
<!--                             </div> -->
                        </div>
                        <!-- 온라인시험 -->
                        <div class="tab-sub tab-sub04">
							<div class="sub-segment table">
								<ul class="class-list-title thead d-flex">
                                    <li class="c-table-num">No.</li>
                                    <li class="c-table-name-wide">시험명</li>
                                    <li class="c-table-02">시험기간</li>
                                    <li class="c-table-01">제출여부</li>
                                    <li class="c-table-01">점수</li>
                                </ul>
                                <ul class="class-list-wrap exam">
                                </ul>
							</div>
                        </div>
                        <!-- 공지사항 -->
                        <div class="tab-sub tab-sub05">
                        	<%@include file="include/section_courseNotice_sub05-01-01.jsp" %>
                        </div>
                        <!-- QnA -->
                        <div class="tab-sub tab-sub06 qnaTab">
                        	<%@include file="include/section_qna_sub05-01-01.jsp" %>
                        </div>
                        <!-- 설문조사 -->
                        <div class="tab-sub tab-sub07">
                            <div class="sub-segment table">
                                <ul class="class-list-title thead d-flex">
                                    <li class="c-table-num">No.</li>
                                    <li class="c-table-03">과정</li>
                                    <li class="c-table-name-w">설문조사명</li>
                                    <li class="c-table-02">설문기간</li>
                                    <li class="c-table-01">진행여부</li>
                                </ul>
                                <ul class="class-list-wrap survey"></ul>
                            </div>
                            <!-- <div class="page">
                                <ul class="pagination d-flex justify_between">
                                    <li>
                                        <a href="#" class="prev">
                                            <div class="img-icon angle-left floatL"></div>PREV
                                        </a>
                                    </li>
                                    <li><a href="#" class="active num">1</a></li>
                                    <li><a href="#" class="num">2</a></li>
                                    <li><a href="#" class="num">3</a></li>
                                    <li><a href="#" class="num">4</a></li>
                                    <li><a href="#" class="num">5</a></li>
                                    <li>
                                        <a href="#" class="next">
                                            <div class="img-icon angle-right floatR"></div>NEXT
                                        </a>
                                    </li>
                                </ul>
                            </div> -->
                        </div>
                    </div>
                </div>
            </div>
        </div>
		<!-- hidden val -->
		<input type="hidden" name="course_id" value="${course_id}"/>
		<input type="hidden" name="cardinal_id" value="${cardinal_id}"/>
		<input type="hidden" name="user_id" value="${user_id}"/>

        <!-- footer-include -->
        <%@include file="../include/common_footer_rainbow.jsp" %>
    </div>
</body>

</html>

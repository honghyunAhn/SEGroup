<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="util" uri="http://www.aracomm.com/customtag/util" %>

<sec:authentication property="principal" var="principal" />
<c:set var="contextPathsub" value='${fn:split(requestScope["javax.servlet.forward.request_uri"],"/")}'/>
<c:set var="islogin" value="false"/>
<sec:authorize access="isAuthenticated()"><c:set var="islogin" value="true"/></sec:authorize>
<c:set var="isMobile" value="false"/>
<c:if test="${currentDevice.mobile }"><c:set var="isMobile" value="true"/></c:if>

	<!-- 1.1. 헤더 -->
<%-- 			<div id="header"  class="header">
				<div class="area-top">
					<h1 class="header-logo affixed-element-top"><a href="/" title="메인으로"><img src="/resources/images/logo.png" alt="창비교육 원격교육연수원"/></a></h1>
					<form class="header-search" action="<c:url value="/search"/>">
						<span class="cusPlaceHolder">
							<input type="text" name="keyword" class="cusPHIn" data-placeholder="과정명 또는 강사를 검색하세요." value="<c:out value="${param.keyword }"/>">
						</span>
						<button type="submit"><span class="sr-only">검색</span></button>
					</form>
					<p class="header-keyword">
						<span class="txtBox arrowR">인기 검색어</span>
						<span class="hitkeywords">
						</span>
						<!--//
							1. 검색어 선택시 - 방법1) 해당 검색 결과 페이지로 이동  VS 방법2) 검색 창에 해당 검색어 값 임력
							어떤 방법을 쓰던지 자바스크립트 에러시 대체 콘텐츠 제공을 위해 a태그 href속성에 해당 키워드의 검색페이지로 바로 이동할 수 있는 경로 값을 삽입 함
							2. 타이틀에 검색어 및 작동 방식 설명 삽입
						//-->
					</p>
				</div><!--//.header>.area-top-->
				<div class="area-menu affixed-element-top">
					<div class="gnb">
						<ul class="menu-d1">
							<li class="menu-item"><a class="<c:if test="${fn:contains(contextPathsub[0],'mypage')}">on</c:if>" id="Myroom" href="javascript:authAlertMove('/mypage/lecture/lecture1')"><span class="menu-title">나의 강의실</span></a></li>
							<li class="menu-item"><a class="<c:if test="${fn:contains(contextPathsub[0],'learn')}">on</c:if>" id="Course" href="/learn/course/course?course_code=0"><span class="menu-title">연수 신청</span></a></li>
							<li class="menu-item"><a class="<c:if test="${fn:contains(contextPathsub[0],'guide')}">on</c:if>" id="Guide" href="/guide/training/guide"><span class="menu-title">연수 안내</span></a></li>
							<li class="menu-item"><a class="<c:if test="${fn:contains(contextPathsub[0],'teacher')}">on</c:if>" id="Teacher" href="/teacher/list"><span class="menu-title">강사 소개</span></a></li>
							<li class="menu-item"><a class="<c:if test="${fn:contains(contextPathsub[0],'teacher')}">on</c:if>" id="Teacher" href="/teacher/list"><span class="menu-title">커뮤니티</span></a></li>
							<li class="menu-item"><a class="<c:if test="${fn:contains(contextPathsub[0],'serviceCenter')}">on</c:if>" id="Help" href="/serviceCenter/bbs/notice?board_type=1"><span class="menu-title">고객 센터</span></a></li>
						</ul>
						<!--//
							페이지 네비게이션을 위해 각 메뉴 링크 id 로 해당 페이지 도메인 값을 사용
							(우선 임시 도메인 값을 임의로 적용함)
						//-->
						<c:if test="${not empty principal }">
						<sec:authorize access="isAnonymous()">
						<p class="topmenu">
							<a href="javascript:popupOpen('layerLogin')">로그인</a>
							<a href="<c:url value="/member/join1"/>">회원 가입</a>
						</p>
						</sec:authorize>
						<sec:authorize access="isAuthenticated()">
							<c:choose>
								<c:when test="${currentDevice.mobile }">
									<p class="topmenu">
										<a href="<c:url value="/user/signout"/>">로그아웃</a>
										<a href="<c:url value="/mypage/private/privateedit"/>">개인 정보 수정</a>
									</p>
								</c:when>
								<c:otherwise>
									<p class="topmenu login-util">
										<span><strong><util:strcut len="18" value="${principal.name}"/></strong> 님</span>
										<i>I</i><a href="<c:url value="/user/signout"/>">로그아웃</a><i>I</i><a href="<c:url value="/mypage/private/privateedit"/>">개인 정보 수정</a>
									</p>
								</c:otherwise>
							</c:choose>
						</sec:authorize>
						</c:if>
						<c:if test="${empty principal }">
						<p class="topmenu">
							<a href="javascript:popupOpen('layerLogin')">로그인</a>
							<a href="<c:url value="/member/join1"/>">회원 가입</a>
						</p>
						</c:if>
						<a class="btn-toggle" href="#fullmenu"><strong class="alt-txt"> 전체 메뉴</strong></a>
					</div><!--// .gnb-->
					<div id="fullmenu" class="off">
						<%@ include file="/WEB-INF/views/common/header/fullmenu.jsp"%>
					</div><!--// #.fullmenu -->
				</div><!--//.header>.area-menu-->
				<hr/>
			</div --%><!--//.header#header-->
	<!--// 1.1. 헤더 END -->
	
	<!-- 지민 헤더 -->
	 <div class="header-include">
        <!-- 슬라이드다운 탑배너 : 회사소개 -->
        <div class="top-bannerWrap">
            <div class="top-banner"></div>
            <div class="btn-down">
                <div class="img-icon angle-down"></div>
                <div class="img-icon times close"></div>
            </div>
        </div>
        
        <!-- Mobile Start -->
        <div class="mobile-headerWrap"> 
            <div class="mobile-header d-flex">
                <div class="nav-menu">
                    <div class="img-icon bars"></div>
                </div>
                
                <h1 class="header-logo">
                    <a href="<c:url value="/"/>" title="메인"> 
                        <img src="../../../resources/css/img/society_logo.png" alt="회사로고">
                    </a>
                </h1>
            <!--     로그인 하면 나의강의실로 연결 -->
               <div class="img-icon user" onclick='location.href="/lms/user/sub07-01-01"' >                     
               </div>
            </div>
            <div class="mobile-hdr-loginWrap">
                <ul class="user-menu d-flex">
                    <li class="logon d-n h5"><a href="<c:url value="/loginPage"/>">로그인</a></li>
                    <li class="myclass d-b h5"><a href="<c:url value="/mypage/lecture/lecture1"/>">나의 강의실</a></li>
                    <li class="logout d-b h5"><a href="<c:url value="/user/signout"/>">로그아웃</a></li>
                    <li class="join d-n h5"><a href="<c:url value="/member/join1"/>">회원가입</a></li>
                </ul>
            </div>
            <div class="m-navBg">
                <div class="m-navGroup">
                    <div class="mobile-user">
                        <p class="user-msg welcome d-b">
                            <span class="user-name">홍길동</span>님 환영합니다.
                        </p>
                        <ul class="user-menu d-flex">
                            <li class="logon d-n h5"><a href="<c:url value=""/>">로그인</a></li>
                            <li class="myclass d-b h5"><a href="<c:url value="/mypage/lecture/lecture1"/>">">나의 강의실</a></li>
                            <li class="logout d-b h5"><a href="<c:url value="/user/signout"/>">로그아웃</a></li>
                            <li class="join d-n h5"><a href="<c:url value="/member/join1"/>">회원가입</a></li>
                        </ul>
                    </div>
                    <div class="mobile-navGroup">
                        <ul class="menu-title-division">
                            <li class="gnb fz14"><a href="sub01-01.html">IT</a></li>
                            <li class="lnb fz14">
                                <a href="sub01-01.html">- 프로그래밍 언어</a>
                            <li class="lnb fz14">
                                <a href="sub01-02.html">- 프로그래밍 활용</a>
               
                            </li>
                            <li class="lnb fz14">
                                <a href="sub01-03.html">- AI/빅데이터</a>
                          
                            </li>
                            <li class="lnb fz14">
                                <a href="sub01-04.html">- 기타</a>
                         
                            </li>
                        </ul>
                        <ul class="menu-title-division">
                            <li class="gnb fz14"><a href="sub02-01.html">외국어</a></li>
                            <li class="lnb fz14">
                                <a href="sub02-01.html">- 영어></a>
                         
                            </li>
                            <li class="lnb fz14">
                                <a href="sub02-02.html">- 일본어</a>
                         
                            </li>
                            <li class="lnb fz14">
                                <a href="sub02-03.html">- 중국어</a>
                            </li>
                        </ul>
                        <ul class="menu-title-division">
                            <li class="gnb fz14"><a href="sub03-01.html">직무역량</a></li>
                            <li class="lnb fz14"><a href="sub03-01.html">- 경영/금융</a></li>
                            <li class="lnb fz14"><a href="sub03-02.html">- 리더십/코칭</a></li>
                            <li class="lnb fz14"><a href="sub03-03.html">- 마케팅/CS</a></li>
                            <li class="lnb fz14"><a href="sub03-04.html">- 자기관리/대인관계</a></li>
                        </ul>
                        <ul class="menu-title-division">
                            <li class="gnb fz14"><a href="sub04-01.html">취업연계/단기교육></a></li>
                            <li class="lnb fz14">
                                <a href="sub04-01.html">- 취업연계 과정</a>
                            </li>
                            <li class="lnb fz14">
                                <a href="sub04-02.html">- 단기교육 과정</a>
                            </li>
                        </ul>
                        <ul class="menu-title-division">
                            <li class="gnb fz14"><a href="/serviceCenter/bbs/notice?board_type=1">커뮤니티</a></li>
                            <li class="lnb fz14">
                                <a href="sub05-01-01.html">- 자료실</a>
                            </li>
                            <li class="lnb fz14">
                                <a href="/serviceCenter/bbs/notice?board_type=1">- 공지사항/이벤트</a>
                            </li>
                            <li class="lnb fz14"><a href="sub05-03.html">- 수강후기/인터뷰</a></li>
                            <li class="lnb fz14"><a href="sub05-04.html">- 특강/설명회</a></li>
                            <li class="lnb fz14"><a href="sub05-05.html">- 자유게시판</a></li>
                        </ul>
                        <ul class="menu-title-division">
                            <li class="gnb fz14">
                            	<a href="/serviceCenter/bbs/faq?board_type=3&faq_code=0">고객센터></a>
                            </li>
                            <li class="lnb fz14">
                            	<a href="/serviceCenter/remote/remote">고객지원</a>
                            </li>
                            <li class="lnb fz14">
                                <a href="sub06-02-01.html">- FAQ</a>
                            </li>
                            
                            <li class="lnb fz14">
                                <a href="sub06-04-01.html">- 단체/제휴문의</a>
                            </li>
                            <li class="lnb fz14">
                                <a href="<c:url value="/serviceCenter/tocome"/>">- 오시는길</a>
                            </li>
                        </ul>
                        <ul class="menu-title-division bl">
                            <li class="gnb fz14"><a href="<c:url value="/mypage/lecture/lecture1"/>" >나의강의실</a></li>
                            <li class="lnb fz14"><a href="sub07-01-01.html">- 학습현황</a></li>
                            <li class="lnb fz14"><a href="sub07-02.html">- 결제현황/환불</a></li>
                            <li class="lnb fz14"><a href="sub07-03.html">- 마일리지</a></li>
                            <li class="lnb fz14"><a href="<c:url value="/mypage/private/privateedit"/>">- 개인정보수정</a></li>
                            <li class="lnb fz14"><a href="<c:url value="/mypage/private/secessioncertification"/>">- 회원탈퇴</a></li>
                        </ul>
                    </div>
                </div>
            </div>
        </div> <!-- Mobile End -->
        
        <!-- userMenu / header -->
        <div class="hdrWrap topMenu-wrapper">
            <header class="header">
                <div class="header-topMenu-wrap  d-flex">
                    <div class="topMenu-notice-wrap d-flex">
                        <div class="listWrap block">
                            <div class="topMenu-notice">
                            	<div class="notice"></div>
                                <div>
                                    <a href="" class="text-over">
                                        &#91;공지1&#93; 세일 강좌는 &#91;과학 탐험가&#93;Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor.
                                    </a>
                                </div>
                            </div>
                        </div>

                        <div class="button-wrap navi">
                            <div class="btn-prev prev floatL img-icon angle-left" title="이전"></div>
                            <div class="btn-next next floatL img-icon angle-right" title="다음"></div>
                        </div>
                    </div>
                    <ul class="user-menu d-flex">
                   <%--  <c:if test="${not empty principal }"> --%>
                      <!--   로그인시 바뀌는 부분

                        (1)로그인 전
                        : (.logon)로그인, (.join)회원가입 버튼 표시됨

                        (2) 로그인 후
                        : (.welcome)사용자환영(>.user-name에 사용자이름 넣어주기),(.myclass)나의강의실,(.logout)로그아웃 버튼 표시됨 -->
                       	
                        
                        <sec:authorize access="isAnonymous()">
                        <li class="logon d-n h5"><a href="<c:url value="/loginPage"/>">로그인</a></li>
                        <li class="join d-n h5"><a href="<c:url value="/member/join1"/>">회원가입</a></li>
                        </sec:authorize>
                        <sec:authorize access="isAuthenticated()">
                        	<c:choose>
                        		<c:when test="${currentDevice.mobile}">
                        			<li class="logout d-b h5"><a href="<c:url value="/user/signout"/>">로그아웃</a></li>	
                        			<a href="<c:url value="/mypage/private/privateedit"/>">개인 정보 수정</a>
                        		</c:when>
                        		<c:otherwise>
                        			<!-- <li class="welcome d-b h5"> -->
                            			<span class="user-name"><util:strcut len="18" value="${principal.name}"/>님 환영합니다.</span>
                            			<a href="<c:url value="/user/signout"/>">로그아웃</a>
                            			 <%-- <li class="logout d-b h5"><a href="<c:url value="/user/signout"/>">로그아웃</a></li> --%>
                            			 <li class="myclass d-b h5"></li>
                            			 <a href="<c:url value="/mypage/lecture/lecture1"/>">나의 강의실</a>
                            			 
                            			 
                            			 <%-- <a href="<c:url value="/mypage/lecture/lecture1"/>" class="myclass d-b h5">나의 강의실</a> --%>
                        			<!-- </li>	 -->	
                        		</c:otherwise>
                        	</c:choose>
                        </sec:authorize>
                        
                    <%--   </c:if> --%>
                    </ul>
                </div>
            </header>
        </div>
        <div class="hdrWrap midMenu-wrapper">

            <header class="header">
                <div class="header-wrap">
                    <h1 class="header-logo">
                        <a href="/" title="메인">
                            <img src="../../../resources/css/img/society_logo.png" alt="회사로고">
                        </a>
                    </h1>
                   <!--  검색어입력 -->
                    <form class="header-search d-flex">
                        <input type="text" class="cusPHIn" data-placeholder="과정명 또는 강사를 검색하세요." value="<c:out value="${param.keyword }"/>"> 
                        <!-- 검색버튼 -->
                        <button class="button img-icon search"></button>
                    </form>

                    <ul class="header-sns d-flex">
                        <li>
                            <a href="">
                                <img src="../../../resources/css/img/header-sns-youtube.png" alt="유튜브" title="유튜브">
                            </a>
                        </li>
                        <li class="menu-divBar">|</li>
                        <li>
                            <a href="https://blog.naver.com/e-tradecampus" target="_blank">
                                <img src="../../../resources/css/img/header-sns-naverBlog.png" alt="네이버 블로그" title="네이버 블로그">
                            </a>
                        </li>
                        <li class="menu-divBar">|</li>
                        <li>
                            <a href="https://cafe.naver.com/goitjapan" target="_blank">
                                <img src="../../../resources/css/img/header-sns-naverCafe.png" alt="네이버 카페" title="네이버 카페">
                            </a>
                        </li>
                    </ul>
                </div>
            </header>
        </div>

        <!-- nav fullWrapper 삽입 -->

        <div class="navWrap">
            <nav class="nav">
                <!-- 메뉴바 클릭시 full menu 슬라이드 다운 -->
                <div class="nav-menu">
                    <div class="btn-toggle">
                        <div class="img-icon bars"></div>
                        <div class="hide-show-txt fz14">
                          		  전체 메뉴 보기
                        </div>
                    </div>

                    <!-- drop nav -->
                    <ul class="navGroup d-flex">
                        <!-- ↓ IT -->
                        <li class="gnb sub01 fz16">
                            <a href="sub01-01.html">IT</a>
                            <ul class="lnb fz14">
                                <li><a href="sub01-01.html">프로그래밍 언어</a></li>
                                <li><a href="sub01-02.html">프로그래밍 활용</a></li>
                                <li><a href="sub01-03.html">AI/빅데이터</a></li>
                                <li><a href="sub01-04.html">기타</a></li>
                            </ul>
                        </li>
                        <!-- ↓ 외국어 -->
                        <li class="gnb sub02 fz16">
                            <a href="sub02-01.html">외국어</a>
                            <ul class="lnb fz14">
                                <li><a href="sub02-01.html">영어</a></li>
                                <li><a href="sub02-02.html">일본어</a></li>
                                <li><a href="sub02-03.html">중국어</a></li>
                            </ul>
                        </li>
                        <!-- ↓ 직무역량 -->
                        <li class="gnb sub03 fz16">
                            <a href="sub03-01.html">직무역량</a>
                            <ul class="lnb fz14">
                                <li><a href="sub03-01.html">경영/금융</a></li>
                                <li><a href="sub03-02.html">리더십/코칭</a></li>
                                <li><a href="sub03-03.html">마케팅/CS</a></li>
                                <li><a href="sub03-04.html">자기관리/대인관계</a></li>
                            </ul>
                        </li>
                        <!-- ↓ 취업연계 -->
                        <li class="gnb sub04 fz16">
                            <a href="sub04-01.html">취업연계/단기교육</a>
                            <ul class="lnb fz14">
                                <li><a href="sub04-01.html">취업연계 과정</a></li>
                                <li><a href="sub04-02.html">단기교육 과정</a></li>
                            </ul>
                        </li>
                        <!-- ↓ 커뮤니티 -->
                        <li class="gnb sub05 fz16">
                            <a href="/serviceCenter/bbs/notice?board_type=1">커뮤니티</a>
                            <ul class="lnb fz14">
                                <li><a href="sub05-01-01.html">자료실</a></li>
                                <li><a href="/serviceCenter/bbs/notice?board_type=1&notice_type=1">공지사항/이벤트</a></li>
                                <li><a href="sub05-03.html">수강후기/인터뷰</a></li>
                                <li><a href="sub05-04.html">특강/설명회</a></li>
                                <li><a href="sub05-05.html">자유게시판</a></li>
                            </ul>
                        </li>
                        <!-- ↓ 고객센터 -->
                        <li class="gnb sub06 fz16">
                            <a href="/serviceCenter/bbs/faq?board_type=3&faq_code=0">고객센터</a>
                            <ul class="lnb fz14">
                                <!-- <li><a href="/learn/course/course?course_code=0">연수신청(임시)</a></li> -->
                                <li><a href="/serviceCenter/bbs/faq?board_type=3&faq_code=0">FAQ</a></li>
                                <li><a href="/serviceCenter/remote/remote">원격지원/1:1상담</a></li>
                                <li><a href="<c:url value="/serviceCenter/alliance/alliance"/>">단체/제휴문의</a></li>
                                <li><a href="<c:url value="/serviceCenter/tocome"/>">오시는길</a></li>
                            </ul>
                        </li>
                    </ul>
                </div>
            </nav>
        </div>
        <div class="fullWrapper">
            <div class="full-background">
                <div class="close-menu">x</div>
                <div class="full-navGroup">
                    <ul class="menu-title-division">
                        <li class="gnb fz14"><a href="sub01-01.html">IT</a></li>
                        <li class="lnb fz14">
                            <a href="sub01-01.html">프로그래밍 언어</a>
                            <ul class="menu-sub h5">
                                <li><a href="sub01-01-01.html">C</a></li>
                                <li><a href="sub01-01-02.html">C++</a></li>
                                <li><a href="sub01-01-03.html">C#</a></li>
                                <li><a href="sub01-01-04.html">Java</a></li>
                                <li><a href="sub01-01-05.html">JavaScript</a></li>
                                <li><a href="sub01-01-06.html">PHP</a></li>
                                <li><a href="sub01-01-07.html">파이썬</a></li>
                                <li><a href="sub01-01-08.html">기타</a></li>
                            </ul>
                        <li class="lnb fz14">
                            <a href="sub01-02.html">프로그래밍 활용</a>
                            <ul class="menu-sub h5">
                                <li><a href="sub01-02-01.html">PHP</a></li>
                                <li><a href="sub01-02-02.html">파이썬</a></li>
                                <li><a href="sub01-02-03.html">리눅스</a></li>
                                <li><a href="sub01-02-04.html">기타</a></li>
                            </ul>
                        </li>
                        <li class="lnb fz14">
                            <a href="sub01-03.html">AI/빅데이터</a>
                            <ul class="menu-sub h5">
                                <li><a href="sub01-03-01.html">인공지능 프로그래밍</a></li>
                                <li><a href="sub01-03-02.html">데이터베이스</a></li>
                                <li><a href="sub01-03-03.html">R</a></li>
                                <li><a href="sub01-03-04.html">HADOOP(하둡) 프로그래밍</a></li>
                                <li><a href="sub01-03-05.html">기타</a></li>
                            </ul>
                        </li>
                        <li class="lnb fz14">
                            <a href="sub01-04.html">기타</a>
                            <ul class="menu-sub h5">
                                <li><a href="sub01-04-01.html">IOS(스위프트)</a></li>
                                <li><a href="sub01-04-02.html">안드로이드(센서)</a></li>
                                <li><a href="sub01-04-03.html">안드로이드(코틀린)</a></li>
                            </ul>
                        </li>
                    </ul>
                    <hr>
                    <ul class="menu-title-division">
                        <li class="gnb fz14"><a href="sub02-01.html">외국어</a></li>
                        <li class="lnb fz14">
                            <a href="sub02-01.html">영어</a>
                            <ul class="menu-sub h5">
                                <li><a href="sub02-01-01.html">문법/어휘</a></li>
                                <li><a href="sub02-01-02.html">비즈니스</a></li>
                                <li><a href="sub02-01-03.html">시험대비</a></li>
                                <li><a href="sub02-01-04.html">일반</a></li>
                                <li><a href="sub02-01-05.html">회화</a></li>
                            </ul>
                        </li>
                        <li class="lnb fz14">
                            <a href="sub02-02.html">일본어</a>
                            <ul class="menu-sub h5">
                                <li><a href="sub02-02-01.html">문법/어휘</a></li>
                                <li><a href="sub02-02-02.html">비즈니스</a></li>
                                <li><a href="sub02-02-03.html">시험대비</a></li>
                                <li><a href="sub02-02-04.html">일반</a></li>
                                <li><a href="sub02-02-05.html">회화</a></li>
                            </ul>
                        </li>
                        <li class="lnb fz14">
                            <a href="sub02-03.html">중국어</a>
                            <ul class="menu-sub h5">
                                <li><a href="sub02-03-01.html">문법/어휘</a></li>
                                <li><a href="sub02-03-02.html">비즈니스</a></li>
                                <li><a href="sub02-03-03.html">시험대비</a></li>
                                <li><a href="sub02-03-04.html">일반</a></li>
                                <li><a href="sub02-03-05.html">회화</a></li>
                            </ul>
                        </li>
                    </ul>
                    <hr>
                    <ul class="menu-title-division">
                        <li class="gnb fz14"><a href="sub03-01.html">직무역량</a></li>
                        <li class="lnb fz14"><a href="sub03-01.html">경영/금융</a></li>
                        <li class="lnb fz14"><a href="sub03-02.html">리더십/코칭</a></li>
                        <li class="lnb fz14"><a href="sub03-03.html">마케팅/CS</a></li>
                        <li class="lnb fz14"><a href="sub03-04.html">자기관리/대인관계</a></li>
                    </ul>
                    <hr>
                    <ul class="menu-title-division">
                        <li class="gnb fz14"><a href="sub04-01.html">취업연계/단기교육</a></li>
                        <li class="lnb fz14">
                            <a href="sub04-01.html">취업연계 과정</a>
                            <ul class="menu-sub h5">
                                <li><a href="sub04-01-01.html">국내</a></li>
                                <li><a href="sub04-01-02.html">해외</a></li>
                            </ul>
                        </li>
                        <li class="lnb fz14">
                            <a href="sub04-02.html">단기교육 과정</a>
                            <ul class="menu-sub h5">
                                <li><a href="sub04-02-01.html">백엔드(웹 개발)</a></li>
                                <li><a href="sub04-02-02.html">프론트엔드(웹 코딩)</a></li>
                                <li><a href="sub04-02-03.html">앱개발</a></li>
                                <li><a href="sub04-02-04.html">인공지능/빅데이터</a></li>
                                <li><a href="sub04-02-05.html">웹디자인</a></li>
                            </ul>
                        </li>
                    </ul>
                    <hr>
                    <ul class="menu-title-division">
                        <li class="gnb fz14"><a href="/serviceCenter/bbs/notice?board_type=1">커뮤니티</a></li>
                        <li class="lnb fz14">
                            <a href="sub05-01-01.html">자료실</a>
                            <ul class="menu-sub h5">
                                <li><a href="sub05-01-01.html">자료실</a></li>
                                <li><a href="sub05-01-02.html">학습지원프로그램</a></li>
                                <li><a href="sub05-01-03.html">동영상지원프로그램</a></li>
                                <li><a href="sub05-01-04.html">파일뷰어프로그램</a></li>
                            </ul>
                        </li>
                        <li class="lnb fz14">
                            <a href="/serviceCenter/bbs/notice?board_type=1">공지사항/이벤트</a>
                            <ul class="menu-sub h5">
                                <li><a href="/serviceCenter/bbs/notice?board_type=1">공지사항</a></li>
                                <li><a href="/serviceCenter/event/eventList">이벤트</a></li>
                            </ul>
                        </li>
                        <li class="lnb fz14"><a href="sub05-03.html">수강후기/인터뷰</a></li>
                        <li class="lnb fz14"><a href="sub05-04.html">특강/설명회</a></li>
                        <li class="lnb fz14"><a href="sub05-05.html">자유게시판</a></li>
                    </ul>
                    <hr>
                    <ul class="menu-title-division">
                        <li class="gnb fz14"><a href="/serviceCenter/bbs/faq?board_type=3&faq_code=0">고객센터</a></li>
                        <li class="lnb fz14"><a href="/learn/course/course?course_code=0">과정신청</a></li>
                        <li class="lnb fz14">
                            <a href="sub06-02-01.html">FAQ</a>
                            <ul class="menu-sub h5">
                                        <li><a href="sub06-02-01.html">전체</a></li>
                                        <li><a href="/member/join1">회원가입/변경/탈퇴</a></li>
                                        <li><a href="sub06-02-03.html">수강신청/취소</a></li>
                                    </ul>
                        </li>
                        <li class="lnb fz14">
                            <a href="/serviceCenter/remote/remote">원격지원/1:1상담</a>
                            <ul class="menu-sub h5">
                                <li><a href="sub06-03-01.html">PC원격지원</a></li>
                                <li><a href="sub06-03-02.html">1:1상담</a></li>
                            </ul>
                        </li>
                        <li class="lnb fz14">
                            <a href="<c:url value="/serviceCenter/alliance/alliance"/>">단체/제휴문의</a>
                          
                        </li>
                        <li class="lnb fz14">
                            <a href="<c:url value="/serviceCenter/tocome"/>">오시는길</a>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
    </div> 
	<!-- 지민 헤더 끝 -->
	<!--// 로그인팝업 -->
	<%-- <div class="cl-popup-overlay" id="layerLogin">
		<div class="cl-popup-wrap">
			<c:choose>
				<c:when test="${currentDevice.mobile }">
			<div class="cl-popup-box full">
				</c:when>
				<c:otherwise>
			<div class="cl-popup-box mid" style="width:800px; margin-left:-400px;">
				</c:otherwise>
			</c:choose>
				<!--
					팝업타입 별 클래스 & 스타일 제어
						1.폭 800px 이하, 높이 500px 이하 팝업 정가운데 위치)
							- class="cl-popup-box"
							- style="width:폭; height:높이; margin-left:-폭/2; margin-right: -높이/2;"
						2.폭 800px 이하, 높이 500px 이상 가로 가운데 위치
							- class="cl-popup-box mid"
							- style="width:폭; margin-left:-폭/2;"
						3.풀화면 팝업
							- class="cl-popup-box full"
				-->
				<div class="popup-header">
					<h3 class="popup-title">창비교육 원격교육연수원에 오신 선생님! 환영합니다.</h3>
				</div>
				<div class="popup-body">
					<div class="certification">
						<div class="certi">
							<h3>공인 인증서 로그인</h3>
							<span>아이디/비밀번호는 인증서 갱신, 등록, 해제 시에 필요하오니 반드시 기억하시기 바랍니다.</span>
							<a href="javascript:gPopCertForLogin()" class="btn M primary login-bt">공인 인증서 로그인</a>
							<a href="javascript:authAlertMove('<c:url value="/mypage/certificate/certificate"/>')" class="btn M primary">공인 인증서 갱신 바로 가기</a>
						</div>
					</div>
					<form class="login_wrap" id="tloginForm" method="post">
						<h3>아이디 로그인</h3>
						<input type="hidden" name="certkey">
						<input type="text" placeholder="아이디" name="username" value="${cookieValue}">
						<input type="password" placeholder="비밀번호" name="password">
						<label><input type="checkbox" name="sslLoginEnable"> 보안 로그인 사용</label>
						<label><input type="checkbox" name="saveIdChecked" value="Y"> 아이디 저장</label>
						<a href="<c:url value="/member/findId"/>" class="nth-1st help">아이디/비밀번호 찾기</a>
						<button type="button" onclick="gLogin('tloginForm')">로그인</button>
						<a href="<c:url value="/member/join1"/>" class="register">회원 가입</a>
					</form>
				</div><!--//.popup-body-->
			</div><!--//.cl-popup-box-->
		</div><!--//.cl-popup-wrap-->
		<button class="cl-popup-closer">
			<span class="sr-only">닫기</span>
		</button> --%>
	<!-- </div> --><!--//.cl-popup-overlay-->
	<!--// 로그인팝업 END -->

 <script type="text/javascript">
//action 처리 메시지
 var actionMessage = '<c:out value="${actionMessage }"/>';<%-- controller 메시지 --%>
 if (!isEmpty(actionMessage)) alert(actionMessage);

 var globals = {
 	islogin: ${islogin},
 	isMobile: ${isMobile},
 	sslAvail: '<spring:eval expression="@config['https.avail']"/>' == 'Y',
 	sslPort: '<spring:eval expression="@config['https.port']"/>'
 };
 function gLogin(formId) {
 	var isSecureChecked = $('#'+formId).find('input[name="sslLoginEnable"]').is(':checked');
 	var isCurrentSecure = (location.protocol == 'https:');

 	var loginUrl = '<c:url value="/user/signin"/>';
 	if (globals.sslAvail && isSecureChecked) {
 		loginUrl = getSecureUrl(loginUrl,globals.sslPort);
 	}

 	// 보인로그인 여부에 따라 ajax login이  유효하지 않음
 	if (globals.sslAvail && isSecureChecked && !isCurrentSecure) {
 		$('#'+formId).attr('action', loginUrl);
 		$('#'+formId).submit();
 	} else {
 		$.ajax({
 			url : loginUrl,
 			data: $('#'+formId).serialize(),
 			method: 'POST',
 			type: 'POST',
 			dataType : 'json'/*,
 			crossDomain: true,
 			beforeSend: function(xhr) {
 				xhr.setRequestHeader("Accept", "application/json");
 				xhr.setRequestHeader("X-Requested-With", "XMLHttpRequest");
 			} */
 		}).done(function(responseData) {
 			var error = responseData.error;
 			var code = responseData.code;
 			var message = responseData.message;

 			if (error) {
 				if (code === 403 || code === 201){
 					alert(message);
 				} else {
 					alert('알수 없는 오류가 발생하였습니다.');
 				}

 			} else {
 				var redirectUrl = responseData.data.redirectUrl;
 				location.replace(redirectUrl);
 			}
 		});
 	}
 };

 var idenWinForLogin;
 function gPopCertForLogin() {
 	$('#tloginForm').find('input[name="certkey"]').val('');
 	var url = '<c:url value="/iden/nice/checkplusForCertLogin"/>?iden_callback_success=onIdentitySuccessForLogin';
 	if (globals.sslAvail) {
 		url = getSecureUrl(url,globals.sslPort);
 	}
 	idenWinForLogin = popIdenWindow(url, 422, 660);
 }

 function onIdentitySuccessForLogin(iden_gbn, data) {
 	var di = data.di;
 	idenWinForLogin.close();

 	var isCurrentSecure = (location.protocol == 'https:');

 	var loginUrl = '<c:url value="/user/certsignin"/>';
 	if (globals.sslAvail) {
 		loginUrl = getSecureUrl(loginUrl,globals.sslPort);
 	}

 	// 보인로그인 여부에 따라 ajax login이  유효하지 않음
 	if (globals.sslAvail && !isCurrentSecure) {
 		var formId = 'tloginForm';
 		$('#'+formId).find('input[name="certkey"]').val(di);
 		$('#'+formId).attr('action', loginUrl);
 		$('#'+formId).submit();
 	} else {
 		$.ajax({
 			url : loginUrl,
 			data: {'certkey':di},
 			method: 'POST',
 			type: 'POST',
 			dataType : 'json'/* ,
 			crossDomain: true,
 			beforeSend: function(xhr) {
 				xhr.setRequestHeader("Accept", "application/json");
 				xhr.setRequestHeader("X-Requested-With", "XMLHttpRequest");
 			} */
 		}).done(function(responseData) {

 			var error = responseData.error;
 			var code = responseData.code;
 			var message = responseData.message;

 			if (error) {
 				if (code === 403 || code === 201){
 					alert(message);
 				} else {
 					alert('알수 없는 오류가 발생하였습니다.');
 				}

 			} else {
 				var redirectUrl = responseData.data.redirectUrl;
 				location.replace(redirectUrl);
 			}
 		});
 	}
 }

 $(document).ready(function() {
 	// 비밀번호 enter시 로그인 진행
 	$('#tloginForm input[name="password"]').keypress(function (e) {
 		if (e.which == 13) {
 			gLogin('tloginForm');
 		}
 	});

 	// 인기검색어
 	if($('.hitkeywords').length > 0) {
 		$.getJSON('<c:url value="/ajaxHitKeywords"/>', function(data) {
 			var keywords = data.keywords;
 			for(var i=0; i<keywords.length; i++) {
 				k = keywords[i];
 				$('.hitkeywords').append('<a href="<c:url value="/search"/>?keyword='+encodeURIComponent(k)+'" title="'+k+'">'+k+'</a> ');
 			}
 		});
 	}
 });
</script>
                      
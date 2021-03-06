<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!-- rainbow_header -->
<div class="headerWrap" id="header">
    <header class="header d-flex justify_between">
        <h1 class="header-logo">
            <a href="/rainbow" title="메인">
                <img src="/resources/segroup/society/smtp/img/logo-rainbow-wh_100x20px.png" alt="rainbow">
            </a>
        </h1>
        <ul class="header-menu d-flex fz16">
            <li class="hdrMenu link"><a href="/smtp/course/new-rainbow/new-rainbow-info?course_id=rainbow-cousre01">해외취업캠퍼스</a></li>
            <li class="hdrMenu link"><a href="/smtp/course/new-rainbow/new-rainbow-info?course_id=rainbow-cousre02">내일배움카드 과정</a></li>
            <li class="hdrMenu link"><a href="/smtp/course/new-rainbow/new-rainbow-info?course_id=rainbow-cousre03">자격증 코스</a></li>
            <li class="hdrMenu link"><a href="/smtp/course/new-rainbow/new-rainbow-info?course_id=rainbow-cousre04">글로벌 잡매칭</a></li>
            <li class="hdrMenu link"><a href="/smtp/course/new-rainbow/new-rainbow-info?course_id=rainbow-community">커뮤니티</a></li>
        </ul>
        <div class="img-icon bars-2line" id="showNav"></div>
    </header>
    <div class="subHeaderWrap">
        <ul class="subHeader d-flex flexWrap course-point01">
            <li><a href="/smtp/course/short-term/short-term-info?course_id=c000000543">코딩챌린지(사전학습반)</a></li>
            <li><a href="/smtp/course/scmaster/scmaster-info?course_id=c000000525">서울 SCIT MASTER</a></li>
            <li><a href="/smtp/course/scmaster/scmaster-info?course_id=c000000526">광주 SWDO MASTER</a></li>
            <li><a href="/smtp/course/scmaster/scmaster-info?course_id=c000000548">부산 ABC MASTER</a></li>
        </ul>
        <ul class="subHeader d-flex flexWrap course-point02">
            <li><a href="/smtp/course/new-rainbow/new-rainbow-info?course_id=rainbow-course02-01">파이썬 기초 과정</a></li>
            <li><a href="">JAVA기반 웹 개발자 과정</a></li>
        </ul>
        <ul class="subHeader d-flex flexWrap course-point03">
            <li><a href="">토익/토플 접수</a></li>
            <li><a href="/smtp/course/short-term/short-term-info?course_id=c000000541">일본취업을 위한 JPT & SJPT 일본어 단기과정</a></li>
            <li><a href="/smtp/course/short-term/short-term-info?course_id=c000000544">일본취업 스킬업</a></li>
            <li><a href="">정보처리산업기사</a></li>
        </ul>
        <ul class="subHeader d-flex flexWrap course-point04">
            <li><a href="/fap/user/user_main">2021 하반기 잡페어</a></li>
        </ul>
        <ul class="subHeader d-flex flexWrap course-point05">
            <li><a href="/smtp/community/sub04-01">공지사항</a></li>
            <li><a href="/smtp/support/sub04-02">FAQ</a></li>
            <li><a href="/smtp/support/sub04-04">Q&A</a></li>
            <li><a href="/smtp/community/sub04-05">졸업생 마당</a></li>
            <li><a href="/smtp/support/sub04-03">오시는 길</a></li>
        </ul>
    </div>
    <div class="fullWrapper" id="fullNav">
        <div class="full-navGroup">
            <div class="d-flex justify_between">
                <ul class="header-menu d-flex fz16 fc_fff">
                	<c:choose>
						<c:when test="${sessionScope.user_id ne null}">
							<li class="hdrMenu userInfo" id="userInfo"><span>${sessionScope.user_id} 님 환영합니다.</span></li>
				            <li class="hdrMenu logout"><a href="">로그아웃</a></li>
						</c:when>
						<c:otherwise>
					        <li class="hdrMenu login"><a href="/smtp/user/rainbow-user01-01">로그인</a></li>
					        <li class="hdrMenu join point_fc01"><a href="/smtp/user/rainbow-user01-02">회원가입</a></li>
						</c:otherwise>
					</c:choose>
                    <li class="hdrMenu"><a href="/smtp/user/rainbow-user01-03">아이디찾기</a></li>
                    <li class="hdrMenu"><a href="/smtp/user/rainbow-user01-04">비밀번호찾기</a></li>
                </ul>
                <div class="img-icon times-large-wh" id="hideNav"></div>
            </div>
            <div class="menuDivWrap d-flex flexWrap fc_fff fz16">
                <ul class="menu-title-division">
                    <li class="gnb">
                        <a href="rainbow-cousre01.html">해외취업캠퍼스</a>
                    </li>
                    <li class="lnb"><a href="">코딩챌린지(사전학습반)</a></li>
                    <li class="lnb"><a href="">서울 SCIT MASTER</a></li>
                    <li class="lnb"><a href="">광주 SWDO MASTER</a></li>
                    <li class="lnb"><a href="">부산 ABC MASTER</a></li>
                </ul>
                <ul class="menu-title-division">
                    <li class="gnb">
                        <a href="rainbow-cousre02.html">내일배움카드 과정</a>
                    </li>
                    <li class="lnb"><a href="rainbow-course02-01.html">파이썬 기초 과정</a></li>
                    <li class="lnb"><a href="">JAVA기반 웹 개발자 과정</a></li>
                </ul>
                <ul class="menu-title-division">
                    <li class="gnb">
                        <a href="rainbow-cousre03.html">자격증/단기 과정</a>
                    </li>
                    <li class="lnb"><a href="">토익/토플 접수</a></li>
                    <li class="lnb"><a href="">일본취업을 위한 JPT & SJPT 일본어 단기과정</a></li>
                    <li class="lnb"><a href="">일본취업 스킬업</a></li>
                    <li class="lnb"><a href="">정보처리산업기사</a></li>
                </ul>
                <ul class="menu-title-division">
                    <li class="gnb">
                        <a href="rainbow-cousre04.html">글로벌 잡매칭</a>
                    </li>
                    <li class="lnb"><a href="">2021 하반기 잡페어</a></li>
                </ul>
                <ul class="menu-title-division">
                    <li class="gnb">
                        <a href="rainbow-community.html">커뮤니티</a>
                    </li>
                    <li class="lnb"><a href="">공지사항</a></li>
                    <li class="lnb"><a href="">FAQ</a></li>
                    <li class="lnb"><a href="">Q&A</a></li>
                    <li class="lnb"><a href="">졸업생 마당</a></li>
                    <li class="lnb"><a href="">오시는 길</a></li>
                </ul>
                <ul class="menu-title-division">
                	<c:choose>
						<c:when test="${sessionScope.user_id ne null}">
		                    <li class="gnb">
		                        <a href="rainbow-myClass.html">나의강의실</a>
		                    </li>
		                    <li class="lnb"><a href="">학습현황</a></li>
		                    <li class="lnb"><a href="">지원현황</a></li>
		                    <li class="lnb"><a href="">서류발급</a></li>
		                    <li class="lnb"><a href="">결제현황/환불</a></li>
		                    <li class="lnb"><a href="">마일리지</a></li>
		                    <li class="lnb"><a href="">개인정보수정</a></li>
						</c:when>
					</c:choose>
                </ul>
                <form id="logoutForm" action="/smtp/logout" method="post" style="display: none">
						<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
				</form>
            </div>
        </div>
    </div>
</div>
<script>
    const navLinks = document.querySelectorAll(".link a");
    const subNav = document.querySelectorAll(".subHeaderWrap .subHeader");
    // course-list.html >> click event >> 메뉴 클릭 시 해당 페이지 메뉴 active
    for (var i = 0; i < navLinks.length; i++) {
        if (navLinks[i].href === document.URL) {
            navLinks[i].parentElement.classList.add('current')
            // nav 클릭시 subNav 노출
            for (var j = 0; j < subNav.length; j++) {
                if (i === j) {
                    subNav[j].classList.add('active')
                }
            }
        }

    }

    // [ onClick event ] --> fullNav show/hide
    const showN = document.getElementById("showNav")
    const hideN = document.getElementById("hideNav")
    const nav = document.querySelector(".fullWrapper")
    const bodyEl = document.body

    function showNav() {
        nav.style.display = "block"
        bodyEl.classList.add('not-scroll')
    }

    function hideNav() {
        nav.style.display = "none"
        bodyEl.classList.remove('not-scroll')
    }
    showN.addEventListener("click", showNav)
    hideN.addEventListener("click", hideNav)
    
    //로그아웃
    $(document).ready(function(){
		$('.logout').on("click", function() {
	         $('#logoutForm').submit();
	         return false;
	    });
	});
</script>
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
            <li class="hdrMenu link"><a href="/smtp/course/new-rainbow/new-rainbow-info?course_id=rainbow-cousre03">글로벌 잡매칭</a></li>
            <li class="hdrMenu link"><a href="/smtp/community/rainbow-community01-01">커뮤니티</a></li>
            <c:choose>
				<c:when test="${sessionScope.user_id ne null}">
                        <li class="hdrMenu link"><a href="/smtp/user/rainbow-class01-01">나의강의실</a></li>
				</c:when>
			</c:choose>
        </ul>
        <div class="img-icon bars-2line" id="showNav"></div>
    </header>
    <div class="subHeaderWrap">
        <ul class="subHeader d-flex flexWrap course-point01">
            <li><a href="/smtp/course/new-rainbow/course?course_id=c000000543">코딩챌린지(사전학습반)</a></li>
            <li><a href="/smtp/course/new-rainbow/course?course_id=c000000526">광주 SWDO MASTER</a></li>
            <li><a href="/smtp/course/new-rainbow/course?course_id=c000000548">부산 ABC MASTER</a></li>
            <li><a href="/smtp/course/new-rainbow/course?course_id=c000000527">미국 디지털 e-커머스 인재양성 과정</a></li>
        </ul>
        <ul class="subHeader d-flex flexWrap course-point02">
            <li><a href="/smtp/course/new-rainbow/course?course_id=rainbow-course02-01">파이썬 기초 과정</a></li>
            <li><a href="/smtp/course/new-rainbow/course?course_id=c000000549">JAVA기반 웹 개발자 과정</a></li>
        </ul>
        <ul class="subHeader d-flex flexWrap course-point03">
            <li><a href="/fap/user/user_main">2021 하반기 잡페어</a></li>
        </ul>
            <ul class="subHeader d-flex flexWrap course-point04">
            <li><a href="/smtp/community/rainbow-community01-01">공지사항</a></li>
            <li><a href="/smtp/community/rainbow-community02-01">FAQ</a></li>
            <li><a href="/smtp/community/rainbow-community03-01">Q&A</a></li>
            <li><a href="/smtp/community/rainbow-community04-01">졸업생 마당</a></li>
            <li><a href="/smtp/community/rainbow-community05-01">오시는 길</a></li>
        </ul>
        <c:choose>
				<c:when test="${sessionScope.user_id ne null}">
			        <ul class="subHeader d-flex flexWrap course-point05">
			            <li><a href="/smtp/user/rainbow-class01-01">학습현황</a></li>
			            <li><a href="/smtp/user/rainbow-class02-01">지원현황</a></li>
			            <li><a href="/smtp/user/rainbow-class03-01">서류발급</a></li>
			            <li><a href="/smtp/user/rainbow-user02-01">결제현황/환불</a></li>
			            <li><a href="/smtp/user/rainbow-user02-02">마일리지</a></li>
			            <li><a href="rainbow-user02-03.html">개인정보수정</a></li>
			        </ul>
		        </c:when>
        </c:choose>
    </div>
    <div class="fullWrapper" id="fullNav">
        <div class="full-navGroup">
            <div class="d-flex justify_between">
                <ul class="header-menu fz16 fc_fff">
                    <c:choose>
						<c:when test="${sessionScope.user_id ne null}">
							<li class="welcome login">
								<span class="userID">${sessionScope.user_id}</span>님 환영합니다 :)
				            </li>
				            <li class="d-flex login">
				            	<div class="hdrMenu"><a href="/smtp/user/rainbow-class01-01">나의강의실</a></div>
                        		<div class="hdrMenu" id="userlogout"><a href="">로그아웃</a></div>
				            </li>
						</c:when>
						<c:otherwise>
							<li class="d-flex logout">
                        		<div class="hdrMenu"><a href="/smtp/user/rainbow-user01-01">로그인</a></div>
                        		<div class="hdrMenu"><a href="/smtp/user/rainbow-user01-02-01">회원가입</a></div>
							</li>
						</c:otherwise>
					</c:choose>
                </ul>
                <div class="img-icon times-large-wh" id="hideNav"></div>
            </div>
            <div class="menuDivWrap d-flex flexWrap fc_fff fz16">
                <ul class="menu-title-division">
                    <li class="gnb">
                        <a href="/smtp/course/new-rainbow/new-rainbow-info?course_id=rainbow-cousre01">해외취업캠퍼스</a>
                    </li>
                    <li class="lnb"><a href="/smtp/course/new-rainbow/course?course_id=c000000543">코딩챌린지(사전학습반)</a></li>
                    <li class="lnb"><a href="/smtp/course/new-rainbow/course?course_id=c000000526">광주 SWDO MASTER</a></li>
                    <li class="lnb"><a href="/smtp/course/new-rainbow/course?course_id=c000000548">부산 ABC MASTER</a></li>
                    <li class="lnb"><a href="/smtp/course/new-rainbow/course?course_id=c000000527">미국 디지털 e-커머스 인재양성 과정</a></li>
                </ul>
                <ul class="menu-title-division">
                    <li class="gnb">
                        <a href="/smtp/course/new-rainbow/new-rainbow-info?course_id=rainbow-cousre02">내일배움카드 과정</a>
                    </li>
                    <li class="lnb"><a href="/smtp/course/new-rainbow/course?course_id=rainbow-course02-01">파이썬 기초 과정</a></li>
                    <li class="lnb"><a href="/smtp/course/new-rainbow/course?course_id=c000000549">JAVA기반 웹 개발자 과정</a></li>
                </ul>
                <ul class="menu-title-division">
                    <li class="gnb">
                        <a href="/smtp/course/new-rainbow/new-rainbow-info?course_id=rainbow-cousre03">글로벌 잡매칭</a>
                    </li>
                    <li class="lnb"><a href="/fap/user/user_main">2021 하반기 잡페어</a></li>
                </ul>
                <ul class="menu-title-division">
                    <li class="gnb">
                        <a href="/smtp/community/rainbow-community01-01">커뮤니티</a>
                    </li>
                    <li class="lnb"><a href="/smtp/community/rainbow-community01-01">공지사항</a></li>
                    <li class="lnb"><a href="/smtp/community/rainbow-community02-01">FAQ</a></li>
                    <li class="lnb"><a href="/smtp/community/rainbow-community03-01">Q&A</a></li>
                    <li class="lnb"><a href="/smtp/community/rainbow-community04-01">졸업생 마당</a></li>
                    <li class="lnb"><a href="/smtp/community/rainbow-community05-01">오시는 길</a></li>
                </ul>
                <ul class="menu-title-division">
                	<c:choose>
						<c:when test="${sessionScope.user_id ne null}">
		                    <li class="gnb">
		                        <a href="/smtp/user/rainbow-class01-01">나의강의실</a>
		                    </li>
		                    <li class="lnb"><a href="/smtp/user/rainbow-class01-01">학습현황</a></li>
		                    <li class="lnb"><a href="/smtp/user/rainbow-class02-01">지원현황</a></li>
		                    <li class="lnb"><a href="/smtp/user/rainbow-class03-01">서류발급</a></li>
		                    <li class="lnb"><a href="/smtp/user/rainbow-user02-01">결제현황/환불</a></li>
		                    <li class="lnb"><a href="/smtp/user/rainbow-user02-02">마일리지</a></li>
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
//course-list.html >> click event >> 메뉴 클릭 시 해당 페이지 메뉴 active
const navLinks = document.querySelectorAll(".link a");
const subNav = document.querySelectorAll(".subHeaderWrap .subHeader");
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
// course-list.html >> click event >> 메뉴 클릭 시 해당 서브페이지 메뉴 active
const subLinks = document.querySelectorAll(".subHeaderWrap .subHeader li a");
for (var i = 0; i < subLinks.length; i++) {
    if (subLinks[i].href === document.URL) {
        subLinks[i].parentElement.classList.add('fc_point')
    } else {
        subLinks[i].parentElement.classList.remove('fc_point')
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
   $('#userlogout').on("click", function() {
         $('#logoutForm').submit();
         return false;
});
</script>

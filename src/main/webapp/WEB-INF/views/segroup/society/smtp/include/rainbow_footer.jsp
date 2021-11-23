<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<div class="img-icon arrow-circle-up" id="scrollTop"></div>
<div class="footerWrap">
    <div class="footer d-flex justify_between">
        <div class="footer_textWrap">
            <!-- logoImg -->
            <img src="/resources/segroup/society/smtp/img/logo-rainbow-wh_100x20px.png" alt="rainbow">
            <ul class="intro intro_txt">
                <li>(주) 소프트엔지니어소사이어티</li>
                <li>서울시 강남구 영동대로513 코엑스4F ICT교육센터</li>
                <li>광주시 광산구 무진대로282 광주무역회관 7F 소프트엔지니어소사이어티아카데미</li>
                <li>부산광역시 중구 충장대로 11 부산무역회관 2F</li>
                <li>사업자등록번호 : 468-81-00409</li>
                <li>통신판매업신고번호 : 제 강남-03736호</li>
            </ul>
            <ul class="intro intro_btn d-flex">
                <li><a href="" class="btn_normal">개인정보처리방침</a></li>
            </ul>
        </div>

        <div class="footer_navWrap">
            <ul class="footerNav d-flex">
            	<li class="gnb">
                    <a href="/smtp/course/new-rainbow/new-rainbow-info?course_id=rainbow-cousre01" class="fc_point01">해외취업캠퍼스</a>
                    <ul class="lnb">
                        <li><a href="/smtp/course/new-rainbow/course?course_id=c000000543">코딩챌린지(사전학습반)</a></li>
                        <li><a href="/smtp/course/new-rainbow/course?course_id=c000000526">광주 SWDO MASTER</a></li>
                        <li><a href="/smtp/course/new-rainbow/course?course_id=c000000548">부산 ABC MASTER</a></li>
                        <li><a href="/smtp/course/new-rainbow/course?course_id=c000000527">미국 디지털 e-커머스 인재양성 과정</a></li>
                    </ul>
                </li>
                <li class="gnb">
                    <a href="/smtp/course/new-rainbow/new-rainbow-info?course_id=rainbow-cousre02" class="fc_point02">내일배움카드 과정</a>
                    <ul class="lnb">
                        <li><a href="/smtp/course/new-rainbow/course?course_id=rainbow-course02-01">파이썬 기초 과정</a></li>
                        <li><a href="/smtp/course/new-rainbow/course?course_id=c000000549">JAVA기반 웹 개발자 과정</a></li>
                    </ul>
                </li>
                <li class="gnb">
                    <a href="/smtp/course/new-rainbow/new-rainbow-info?course_id=rainbow-cousre03" class="fc_point03">글로벌 잡매칭</a>
                    <ul class="lnb">
                   		<li><a href="/fap/user/user_main">2021 하반기 잡페어</a></li>
                    </ul>
                </li>
                <li class="gnb">
                    <a href="/smtp/community/rainbow-community01-01" class="fc_point04">커뮤니티</a>
                    <ul class="lnb">
                        <li><a href="/smtp/community/rainbow-community01-01">공지사항</a></li>
                        <li><a href="/smtp/community/rainbow-community02-01">FAQ</a></li>
                        <li><a href="/smtp/community/rainbow-community03-01">Q&A</a></li>
                        <li><a href="/smtp/community/rainbow-community04-01">졸업생 마당</a></li>
                        <li><a href="/smtp/community/rainbow-community05-01">오시는 길</a></li>
                    </ul>
                </li>
                <li class="gnb">
                	<c:choose>
						<c:when test="${sessionScope.user_id ne null}">
		                 	<a href="/smtp/user/rainbow-class01-01" class="fc_point05">나의강의실</a>
		                 	<ul class="lnb">
			                    <li class="lnb"><a href="/smtp/user/rainbow-class01-01">학습현황</a></li>
			                    <li class="lnb"><a href="/smtp/user/rainbow-class02-01">지원현황</a></li>
			                    <li class="lnb"><a href="/smtp/user/rainbow-class03-01">서류발급</a></li>
			                    <li class="lnb"><a href="/smtp/user/rainbow-user02-01">결제현황/환불</a></li>
			                    <li class="lnb"><a href="/smtp/user/rainbow-user02-02">마일리지</a></li>
			                    <li class="lnb"><a href="">개인정보수정</a></li>
			                </ul>
						</c:when>
					</c:choose>
                </li>
            </ul>
        </div>
    </div>
    <!-- copyright -->
    <div class="copyright fc_999 textAlign_center">
        Copyright ⓒ 2020 (주)소프트엔지니어소사이어티(Soft Engineer Society) All right reserved.
    </div>
</div>
<script>
    // [  event ] --> scroll Top
    const scrollTop = document.getElementById("scrollTop")
    scrollTop.addEventListener("click", scrollToTop)

    function scrollToTop() {
        window.scrollTo({
            top: 0,
            behavior: 'smooth'
        });
    }
</script>
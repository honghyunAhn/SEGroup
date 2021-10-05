<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
                        <li><a href="">코딩챌린지(사전학습반)</a></li>
                        <li><a href="">광주 SWDO MASTER</a></li>
                        <li><a href="">부산 ABC MASTER</a></li>
                    </ul>
                </li>
                <li class="gnb">
                    <a href="rainbow-cousre02.html" class="fc_point02">내일배움카드 과정</a>
                    <ul class="lnb">
                        <li><a href="/smtp/course/new-rainbow/new-rainbow-info?course_id=rainbow-course02-01">파이썬 기초 과정</a></li>
                        <li><a href="/smtp/course/new-rainbow/new-rainbow-info?course_id=rainbow-course02-02">JAVA기반 웹 개발자 과정</a></li>
                    </ul>
                </li>
                <li class="gnb">
                    <a href="/smtp/course/new-rainbow/new-rainbow-info?course_id=rainbow-cousre03" class="fc_point03">자격증 코스</a>
                    <ul class="lnb">
                        <li><a href="">토익/토플 접수</a></li>
                        <li><a href="">일본취업을 위한 JPT & SJPT 일본어 단기과정</a></li>
                        <li><a href="">일본취업 스킬업</a></li>
                        <li><a href="">정보처리산업기사</a></li>
                    </ul>
                </li>
                <li class="gnb">
                    <a href="/smtp/course/new-rainbow/new-rainbow-info?course_id=rainbow-cousre04" class="fc_point04">글로벌 잡매칭</a>
                    <ul class="lnb">
                        <li><a href="">2021 하반기 잡페어</a></li>
                    </ul>
                </li>
                <li class="gnb">
                    <a href="/smtp/course/new-rainbow/new-rainbow-info?course_id=rainbow-community" class="fc_point05">커뮤니티</a>
                    <ul class="lnb">
                        <li><a href="">공지사항</a></li>
                        <li><a href="">FAQ</a></li>
                        <li><a href="">Q&A</a></li>
                        <li><a href="">졸업생 마당</a></li>
                        <li><a href="">오시는 길</a></li>
                    </ul>
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
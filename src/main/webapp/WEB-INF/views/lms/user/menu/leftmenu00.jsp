<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">

<head>
    <script type="text/javascript">
        $(function() {
            //서브 페이지 네비
            var path = window.location.href;
            // because the 'href' property of the DOM element is the absolute path
            $('.sub-nav .lnb>a').each(function() {
                if (this.href === path) {
                    //console.log('lnb일치');
                    $(this).addClass('active');
                    $(this).next().css({
                        "display": "block"
                    });
                }
            });

            $('.sub-nav .menu-sub a').each(function() {
                if (this.href === path) {
                    //console.log('menu-sub일치');
                    $(this).addClass('active').find('div').addClass('active');
                    $(this).parent().parent().prev().addClass('active');
                    $(this).parent().parent().css({
                        "display": "block"
                    });
                }
            });
        });
    </script>
</head>

<body>
    <div class="subPage_nav">
        <ul class="sub-navGroup">
            <li class="gnb sub00 fz18 bg_point"><a href="/lms/user/sub00-01">로그인/회원가입</a></li>
            <li class="lnb">
                <a href="/lms/user/sub00-01">로그인
                    <!-- <div class="img-icon angle-right angle-down"></div> -->
                </a>
            </li>
            <li class="lnb">
                <a href="/lms/user/sub00-02">회원가입
                    <!-- <div class="img-icon angle-right angle-down"></div> -->
                </a>
            </li>
            <li class="lnb">
                <a href="/lms/user/sub00-03">아이디찾기
                    <!-- <div class="img-icon angle-right angle-down"></div> -->
                </a>
            </li>
            <li class="lnb">
                <a href="/lms/user/sub00-04">비밀번호찾기
                    <!-- <div class="img-icon angle-right angle-down"></div> -->
                </a>
            </li>
        </ul>
    </div>
</body>

</html>

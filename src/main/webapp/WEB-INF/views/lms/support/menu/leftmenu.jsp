<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">

<head>
    <script type="text/javascript">
        $(function() {
            /* //서브 페이지 네비
            var path = window.location.href;
            console.log('path :', path);
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
            }); */
            
            $(function() {
                // 서브 페이지 네비 클릭이벤트 : 경로와 페이지 일치시 active활성화
                var path = window.location.href;
                // console.log('path :', path);
                $('.subPage_nav .lnb>a').each(function() {
                    if (this.href === path) {
                        $(this).addClass('active');
                    }
                });
            });
        });
    </script>
</head>

<body>
    <div class="subPage_nav sub06">
        <ul class="sub-navGroup">
            <li class="gnb sub06 fz18 sub06 bg_point"><a href="/lms/support/sub06-01-01">고객센터</a></li>
			<li class="lnb">
				<a href="/lms/support/sub06-01-01">학습자 PC 환경설정</a>
            </li>
            <li class="lnb">
                <a href="/lms/support/sub06-02">FAQ</a>
            </li>
            <li class="lnb">
                <a href="/lms/support/sub06-03">단체/제휴문의</a>
            </li>
            <li class="lnb">
                <a href="/lms/support/sub06-04">오시는길</a>
            </li>
        </ul>
    </div>
</body>

</html>

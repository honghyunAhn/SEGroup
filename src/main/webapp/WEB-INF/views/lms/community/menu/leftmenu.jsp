<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">

<head>
    <script type="text/javascript">
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
    </script>
</head>

<body>
    <div class="subPage_nav">
        <ul class="sub-navGroup">
            <li class="gnb sub06 fz18 bg_point"><a href="/lms/community/sub05-01-01">커뮤니티</a></li>
            <li class="lnb">
                <a href="/lms/community/sub05-01-01">공지사항</a>
			</li>
			<li class="lnb">
				<a href="/lms/community/sub05-01-02">이벤트</a>
			</li>
        </ul>
    </div>
</body>

</html>

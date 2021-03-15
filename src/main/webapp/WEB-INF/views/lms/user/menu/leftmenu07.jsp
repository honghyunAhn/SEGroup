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
            
             /* $('.sub-nav .menu-sub a').each(function() {
		                $(this).on('click', function(){
		
		                	alert('menu-sub클릭');
							//먼저 전체 active 상태를 해지
		                    $('.sub-nav .menu-sub a').removeClass('active').find('div').removeClass('active');
		                    $('.sub-nav .menu-sub a').parent().parent().prev().removeClass('active');					
		                    $('.sub-nav .menu-sub a').parent().parent().css({"display": "none"});                	
		                    //이후 선택한 객체를 active화
		                    $(this).addClass('active').find('div').addClass('active');
		                    $(this).parent().parent().prev().addClass('active');
		                    $(this).parent().parent().css({"display": "block"});                	
		                });//.section div.class-tabMenu>.modal-tabGroup>li
		                
            }); <<<<실행 안됨 */
    
        });
    </script>
</head>

<body>
    <div class="subPage_nav">
        <ul class="sub-navGroup">
            <li class="gnb sub07 bg_point fz18"><a href="/lms/user/sub07-01-01">나의강의실</a></li>
            <!-- 학습현황 메뉴 목록 -->
            <li class="lnb">
                <a href="/lms/user/sub07-01-01">학습현황</a>
                <!-- <ul class="menu-sub">
                    <li><a href="/lms/user/sub07-01-01"><div class="img-icon caret-right"></div>학습 중</a></li>
                    <li><a href="/lms/user/sub07-01-02"><div class="img-icon caret-right"></div>학습 예정</a></li>
                    <li><a href="/lms/user/sub07-01-03"><div class="img-icon caret-right"></div>학습 종료</a></li>
                </ul> -->
            </li>
            <li class="lnb"><a href="/lms/user/sub07-02">결제현황/환불</a></li>
            <li class="lnb"><a href="/lms/user/sub07-03">마일리지</a></li>
            <li class="lnb"><a href="/lms/user/sub07-04">개인정보수정</a></li>
            <li class="lnb"><a href="/lms/user/sub07-05">회원탈퇴</a></li>
        </ul>
    </div>
</body>

</html>
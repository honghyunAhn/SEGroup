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
    <div class="sub-nav">
        <ul class="sub-navGroup">
            <li class="gnb sub07 fz18"><a href="/smtp/user/sub07-01-01">나의강의실</a></li>
            <!-- 학습현황 메뉴 목록 -->
            
            <li class="lnb sub07"><a href="/smtp/mypage/smtp_regist?course_id=${course_id}&cardinal_id=${cardinal_id}">출결<div class="img-icon angle-right angle-down"></div></a></li>
            <li class="lnb sub07"><a href="/smtp/user/smtpScore?course_id=${course_id}&cardinal_id=${cardinal_id}">성적<div class="img-icon angle-right angle-down"></div></a></li>
            <%-- <c:if test="${checkOnline eq 'blended'}">
            <li class="lnb sub07"><a href="<c:url value="/smtp/main" />">학습하기<div class="img-icon angle-right angle-down"></div></a></li>
            </c:if> --%>
            <li class="lnb sub07"><a href="/smtp/mypage/report?course=${course_id}&cardinal=${cardinal_id}">온라인 과제<div class="img-icon angle-right angle-down"></div></a></li> 
          	<li class="lnb sub07"><a href="/smtp/mypage/exam?course=${course_id}&cardinal=${cardinal_id}">온라인 시험<div class="img-icon angle-right angle-down"></div></a></li>
        </ul>
    </div>
</body>

</html>
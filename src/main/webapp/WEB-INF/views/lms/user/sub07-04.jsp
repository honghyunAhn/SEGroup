<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
	<meta name="description" content=디지털·AI, 외국어, 직무, 자격증까지! Let's Do it! Do it campus!">
    <meta name="keywords" content="디지털, AI, 빅데이터, 프로그래밍, 정보처리, 데이터베이스, 클라우드, 외국어, 영어, 일본어, 중국어, 직무, 경영, 사업전략, 리더십, 코칭, 마케팅, CS, 자기관리, 커뮤니케이션, 법정의무, 취업, 해외취업, Soft Engineer Society, SES, 소프트엔지니어소사이어티, SCIT, SWDO, E러닝, e-learning">
    <title>Let's Do it 두잇캠퍼스</title>
	<link rel="stylesheet" href="/resources/lms/css/reset.css">
	<link rel="stylesheet" href="/resources/lms/css/common.css">
	<link rel="stylesheet" type="text/css" href="<c:url value="/resources/lms/css/img-icon.css" />">
	<link rel="stylesheet" href="/resources/lms/css/style.css">
	<link rel="stylesheet" href="/resources/lms/css/style_responsive.css">
	<link rel="stylesheet" href="/resources/lms/css/renewal_style.css">
    <script src="<c:url value="/resources/lms/js/jquery-3.3.1.min.js" />"></script>
<%--     <script src="<c:url value="/resources/lms/js/common.js" />"></script> --%>
    <script type="text/javascript">
    function pwCheck() {
    	if($('#userPw').val()=='') {
			alert('비밀번호를 입력해주세요.');
			return false;
		}
    	return true;
    	
    }
    
    $(function() {
   	 var message = '${msg}';
   	    if(message != "") {
   	    	alert(message);
   	 	}
   	});
    </script>
</head>

<body>
    <div class="skip-navigation">
        <!--웹접근성/content-->
        <p><a class="goToMain" href="#main">콘텐츠 바로가기</a></p>
    </div>

    <!-- header-include -->
    <%@include file="../sub_header.jsp"%>


    <div class="container subPage_container sub07 d-flex">
        <!-- sub07 나의강의실-include -->
        <%@include file="../user/menu/leftmenu07.jsp"%>

        <div class="subPage_content sub-content margin-left20 sub07 sub07-04" id="main">
            <!-- <div class="page-locationWrap">
                <ul class="page-location">
                    
                    home 메인 / category menu 대분류 / division menu 중분류 / section menu 소분류
                   
                    <li class="img-icon home"><a href="/"></a></li>
                    <li class="img-icon chevron-right"></li>
                    <li class="category-menu"><a href="/lms/user/sub07-01-01">나의강의실</a></li>
                    <li class="img-icon  chevron-right"></li>
                    <li class="division-menu"><a href="/lms/user/sub07-04">개인정보 수정</a></li>
                    <li class="img-icon  chevron-right"></li>
                    <li class="section-menu"><a href="sub07-01-03.html">학습종료</a></li>
                </ul>
                <div class="img-icon  chevron-right"></div>
                <div class="sub-content sub00-01"></div>
            </div> -->
            <div class="header">
                <div class="titleBar h3">개인정보 수정</div>
                <!-- <h3 class="h3"></h3> -->
            </div>
            <div class="section userInfo sub07-04">
                <div class="header">
                    <h5 class="fz16">비밀번호 재확인이 필요합니다.</h5>
                </div>
                <div class="enterWrap">
                    <form class="form formStyle" id="" action="/lms/user/checkPw" method="post" onsubmit="return pwCheck();">
                        <input class="input" name="userPw" type="password" id="userPw" placeholder="비밀번호">
                        <input type="submit" class="btn_normal btn_xlarge btn_orangeD next-step input" value="확인">
                    </form>
                </div>
            </div>
        </div>
    </div>
    <!-- footer-include -->
    <%@include file="../common_footer_doitcam.jsp"%>

    <script type="text/javascript">
        $(document).ready(function() {

            // 다음단계 버튼 클릭
            $('.next-step').click(function() {
                $('.section').load('include/sub07-04-01.html');
            });
        });
    </script>
</body>

</html>

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
</head>

<body>
    <!-- <div class="skip-navigation">
        웹접근성/content
        <p><a class="goToMain" href="#main">콘텐츠 바로가기</a></p>
    </div> -->

    <!-- header-include -->
    <%@include file="../sub_header.jsp"%>

    <div class="container subPage_container sub07 d-flex">
        <!-- sub07 나의강의실-include -->
        <%@include file="../user/menu/leftmenu07.jsp"%>
        <div class="subPage_content sub-content margin-left20 sub07 sub07-05 sub07-05-01" id="main">
            <!-- 현재 페이지 위치 표시 -->
            <!-- <div class="page-locationWrap">
                <ul class="page-location">
                    
                home 메인 / category menu 대분류 / division menu 중분류 / section menu 소분류
               
                    <li class="img-icon home"><a href="/"></a></li>
                    <li class="img-icon chevron-right"></li>
                    <li class="category-menu"><a href="/lms/user/sub07-01-01">나의강의실</a></li>
                    <li class="img-icon chevron-right"></li>
                    <li class="division-menu"><a href="/lms/user/sub07-05">회원탈퇴</a></li>
                    <li class="img-icon chevron-right"></li>
                    <li class="section-menu"><a href="#">로그인</a></li>
                </ul>
                <div class="img-icon chevron-right"></div>
                <div class="sub-content sub00-01"></div>
            </div> -->

            <!-- <div class="header">
                <div class="titleBar h3">회원탈퇴</div>
                <h3 class="h3"></h3>
            </div> -->
            <div class="section userInfo">
                <div class="header">
                    <strong class="h4">안전한 회원 탈퇴를 위해, 아이디/비밀번호를 확인해주세요.</strong>
                    <h5 class="fz14">
                        비밀번호 확인 후 아이디는 즉시 탈퇴됩니다.<br>
                        탈퇴 후에는 동일한 아이디로 다시 가입할 수 없으며,<br>
                        아이디와 데이터는 복구할 수 없으니 신중하게 선택해주세요.
                    </h5>
                </div>
                <div class="enterWrap">
                    <form class="formStyle form" action="/lms/user/optout" id="optoutForm" method="POST">
                        <div class="id-passwordWrap">
                            <input class="input" type="text" id="id" placeholder="아이디" name="id" maxlength="20" autocomplete="off">
                            <div class="userPwCheck">
                                <input class="input" type="password" id="pw" placeholder="비밀번호" name="pw" maxlength="20" autocomplete="off">
                                <!-- <div class="d-none-msg">
                                    <p class="false-msg cDanger">입력하신 비밀번호가 아이디와 일치하지 않습니다.</p>
                                </div> -->
                            </div>
                        </div>

                        <button class="btn-normal btn_xlarge btn_orangeD btn-delete" type="button">
                            탈퇴하기
                        </button>
                    </form>
                </div>
                <!-- alert("탈퇴처리가 완료되었습니다.");
                    onclick="location.href='index.html'"-->

            </div>
        </div>
    </div>
    <!-- footer-include -->
    <? include 'include/footer.html' ?>
    <script type="text/javascript">
    $(function() {
   	 var message = '${msg}';
   	    if(message != "") {
   	    	alert(message);
   	 	}
   	});

        $('.btn-delete').on('click', function() {
        	var id = $('#id').val();
        	var pw = $('#pw').val();
        	if(id=="") {
        		alert("아이디를 입력해주세요.");
        		return false;
        	} else if(pw=="") {
        		alert("비밀번호를 입력해주세요.");
        		return false;
        	}
             if (confirm("탈퇴 후에는 동일한 아이디로 다시 가입할 수 없으며, 아이디와 데이터는 복구할 수 없으니 신중하게 선택해주세요. 정말 탈퇴하시겠습니까?") == true) {
        	$('#optoutForm').submit();
            
        } else {
            return;
        } 
 
        });
        

    </script>
</body>

</html>

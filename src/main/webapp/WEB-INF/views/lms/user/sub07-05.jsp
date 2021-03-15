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
    <div class="skip-navigation">
        <!--웹접근성/content-->
        <p><a class="goToMain" href="#main">콘텐츠 바로가기</a></p>
    </div>

    <!-- header-include -->
    <%@include file="../sub_header.jsp"%>


    <div class="container subPage_container sub07 d-flex">
        <!-- sub07 나의강의실-include -->
        <%@include file="../user/menu/leftmenu07.jsp"%>

        <div class="subPage_content sub-content margin-left20 sub07 sub07-05" id="main">
            <!-- 현재 페이지 위치 표시 -->
            <!-- <div class="page-locationWrap">
                <ul class="page-location">
                    
                home 메인 / category menu 대분류 / division menu 중분류 / section menu 소분류
               
                    <li class="img-icon home"><a href="/lms/user/index"></a></li>
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

            <div class="header">
                <div class="titleBar h3">회원탈퇴</div>
                <!-- <h3 class="h3"></h3> -->
            </div>
            <div class="section userInfo sub07-05">
                <div class="header">
                    <strong class="h4">회원 탈퇴 전, 아래 사항을 반드시 읽어주십시오.</strong>
                    <h5 class="fz14">
                        회원 탈퇴를 하실 경우 아래 항목의 동의 및 확인이 필요합니다.
                    </h5>
                </div>
                <form class="formStyle">
                    <!--<div class="checkWrap d-flex">
                         <div class="agree">
                            1. <span class="cDanger">기존 아이디로 재가입이 불가능</span>합니다.
                        </div>
                        <div class="check d-flex">
                        <label for="agree01" class="label">동의</label>
                        <input type="checkbox" class="check input" name="agree">
                        </div>
                    </div> 
                    <div class="checkWrap d-flex">
                        <!-- <div class="agree">
                            2. <span class="cDanger">일주일동안 재가입이 불가능</span>합니다.
                        </div>
                        <div class="check d-flex">
                        <label for="agree02" class="label">동의</label>
                        <input type="checkbox" class="check input" name="agree">
                        </div> 
                    </div> -->
                    <div class="checkWrap d-flex">
                        <div class="agree">
                            1. 수강하신 <span class="cDanger">모든 교육 이력이 삭제</span>되고, <span class="cDagner">증명서 발급이 불가</span>합니다.
                        </div>
                        <div class="check d-flex">
                        <label for="agree03" class="label">동의</label>
                        <input type="checkbox" class="check input" name="agree">
                        </div>
                    </div>
                </form>

                <!-- 탈퇴취소시 alert("회원 탈퇴가 취소되었습니다. 나의강의실로 이동합니다.");
                        onclick="location.href='sub07-01-01.html'"-->
                <!-- 미 동의시 alert("안내사항을 확인하신 후 동의해주세요."); -->
                <div class="button-wrap d-flex">
                    <button class="btn-normal btn_medium btn_orangeD btn-cancel" type="button">
                        탈퇴 취소
                    </button>
                    <button class="btn-normal btn_medium btn_default btn-agree" type="button" >
                        동의 및 확인
                    </button>
                </div>

            </div>
        </div>
    </div>
    <!-- footer-include -->
    <%@include file="../common_footer_doitcam.jsp"%>
    <script type="text/javascript">
        // '저장' 버튼 클릭시 alert으로 저장여부 되묻기
        // alert 저장 확인 클릭시 저장되었습니다 메시지 출력 후 나의강의실 홈으로 이동
        $(function() {
        	$('.btn-cancel').on('click', cancelButton);
        	$('.btn-agree').on('click', checkAgree);
        });
        
        function cancelButton() {
            alert("회원 탈퇴 취소되었습니다. 나의강의실로 이동합니다.");
            location.href = "/lms/user/sub07-01-01"
        }
        
        // 약관 및 회원 구분 선택 체크
        function checkAgree() {
        	var canPass = true;
        	$("input[name='agree']").each(function() {
        		if($(this).data('must') != 'N') {
        			if(!$(this).is(":checked")) {
        				alert('이용약관에 동의해주세요.')
        				$(this).focus();
        				canPass = false;
        				return false;
        			}
        			
        		}
        	});
        	if(canPass) {
        	location.href = "<c:url value="/lms/user/sub07-05-01" />";	
        	}
        }
    </script>
</body>

</html>

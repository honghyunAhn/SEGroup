<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="format-detection" content="telephone=no">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <meta name="description" content="다양한 전공과 ICT·AI를 융합하여 K-Digital 인재로 컬러링 해드립니다.">
    <meta name="keywords" content="해외취업, Soft Engineer Society, SES, 소프트엔지니어소사이어티, SCIT, SWDO, E러닝, e-learning">
    <title>Rainbow 레인보우</title>
    <link rel="stylesheet" href="/resources/segroup/society/smtp/css/reset.css">
    <link rel="stylesheet" href="/resources/segroup/society/smtp/css/common.css">
    <link rel="stylesheet" href="/resources/segroup/society/smtp/css/img-icon.css">
    <link rel="stylesheet" href="/resources/segroup/society/smtp/css/swiper.min.css">
    <link rel="stylesheet" href="/resources/segroup/society/smtp/css/rainbow_style.css">
    <link rel="stylesheet" href="/resources/segroup/society/smtp/css/rainbow_style_responsive.css">
    <script src="/resources/segroup/society/smtp/js/jquery-3.3.1.min.js"></script>
    <script src="/resources/segroup/society/smtp/js/swiper.js"></script>
    <script src="/resources/segroup/society/smtp/js/rainbow_script.js"></script>
    <script src="/resources/segroup/society/smtp/js/rainbow_script_responsive.js"></script>
    <script type="text/javascript">
        // '저장' 버튼 클릭시 alert으로 저장여부 되묻기
        // alert 저장 확인 클릭시 저장되었습니다 메시지 출력 후 나의강의실 홈으로 이동
        $(function() {
        	$('.btn-cancel').on('click', cancelButton);
        	$('.btn-wh').on('click', checkAgree);
        });
        
        function cancelButton() {
            alert("회원 탈퇴 취소되었습니다. 나의강의실로 이동합니다.");
            location.href = "/smtp/user/sub05-01"
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
        	location.href = '/smtp/user/sub05-07-01';	
        	}
        }
    </script>
</head>
<body>
	<div class="container_rainbow">
        <!-- Header-include -->
        <%@include file="../include/rainbow_header_basic.jsp"%>

        <div class="content sub-content sub01_content" id="main">
            <div class="section section_sub01-02-02">
                <div class="section_header">
                    <strong class="h4">회원 탈퇴 전, 아래 사항을 반드시 읽어주십시오.</strong>
                    <h5 class="fz14">
                    	회원 탈퇴를 하실 경우 아래 항목의 동의 및 확인이 필요합니다.
                    </h5>
                </div>
                <form class="formStyle">
                	<div class="checkWrap d-flex justify_center">
                        <div class="agree">
                            1. 수강하신 <span class="cDanger">모든 교육 이력이 삭제</span>되고, <span class="cDagner">증명서 발급이 불가</span>합니다.
                        </div>
                        <input type="checkbox" class="check input" name="agree">
                        <label for="agree03" class="label">동의</label>
                    </div>
                </form>
                <div class="checkWrap d-flex justify_center">
                	<input type="button" class="btn_normal btn_large btn_pp_bg btn-cancel" value="탈퇴 취소">
                    <input type="button" class="margin-left10 btn_normal btn_large btn_pp btn-agree btn-wh" value="동의/확인">
                </div>
            </div>

        </div>

        <!-- footer-include -->
        <%@include file="../include/common_footer_rainbow.jsp"%>
    </div>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">

<head>
<style>
	.labels{
		font-size:25px;
	}

</style>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="format-detection" content="telephone=no">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <meta name="description" content="다양한 전공과 ICT·AI를 융합하여 K-Digital 인재로 컬러링 해드립니다.">
    <meta name="keywords" content="해외취업, Soft Engineer Society, SES, 소프트엔지니어소사이어티, SCIT, SWDO, E러닝, e-learning">
    <title>Rainbow 레인보우</title>
    
	<!-- 레인보우 기본 세팅 -->
    <link rel="stylesheet" href="/resources/segroup/society/smtp/css/reset.css">
    <link rel="stylesheet" href="/resources/segroup/society/smtp/css/common.css">
    <link rel="stylesheet" href="/resources/lms/css/common.css">
    <link rel="stylesheet" href="/resources/segroup/society/smtp/css/img-icon.css">
    <link rel="stylesheet" href="/resources/segroup/society/smtp/css/swiper.min.css">
    <link rel="stylesheet" href="/resources/segroup/society/smtp/css/rainbow_style.css">
    <link rel="stylesheet" href="/resources/segroup/society/smtp/css/rainbow_style_responsive.css">
    <script src="/resources/segroup/society/smtp/js/jquery-3.3.1.min.js"></script>
    <script src="/resources/segroup/society/smtp/js/swiper.js"></script>
    <script src="/resources/segroup/society/smtp/js/rainbow_script.js"></script>
    <script src="/resources/segroup/society/smtp/js/rainbow_script_responsive.js"></script>
	<link rel="stylesheet" href="/resources/lms/css/reset.css">
	<link rel="stylesheet" href="/resources/lms/css/common.css">
	<link rel="stylesheet" href="/resources/lms/css/style.css">
	<link rel="stylesheet" href="/resources/lms/css/style_responsive.css">
	<link rel="stylesheet" href="/resources/lms/css/renewal_style.css">
    <script src="<c:url value="/resources/lms/js/common.js" />"></script> 
    <!-- Pagination -->
	<script type="text/javascript" src="/resources/js/jquery.twbsPagination.js"></script>
<script>

$(function() {


	$('#refund_submit').on('click', function(){

		if($('#bank').val()==''||$('#bank').val()==null){
			alert('은행이름을 기입해주세요');
			return;
		}
		if($('#account').val()==''||$('#account').val()==null){
			alert('계좌번호를 기입해주세요');
			return;
		}
		if($('#owner').val()==''||$('#owner').val()==null){
			alert('예금주를 기입해주세요');
			return;
		}
		
		if(confirm('환불정보를 수정하시겠습니까?')){
			$('#refund_form').submit();
		}

	});
	$('#refund_cancel').on('click', function(){

		var pay_user_seq = '${accInfo.PAY_USER_SEQ}';

		if(confirm('환불신청을 취소하시겠습니까?')){

			
	    	$.ajax({
				type	: "post",
				url		: "/smtp/user/paymentCancel",
				data    : {
							'pay_user_seq' : pay_user_seq
						  },
				success	: function(flag) {
					if(flag){
						alert('환불취소 성공했습니다.');
						window.location.href = "/segroup/society/smtp/user/sub07-02";
					} else{
						alert('환불취소 실패했습니다.');
						window.location.href = "/segroup/society/smtp/user/sub07-02";						
					}
				}
			});
		}

		
	});

		
	
});

</script>

</head>
<body>
	<input type="hidden" id="serverMessage" value="${message}">
    <div class="container_rainbow">
        <!-- header-include -->
    	<%@include file="../include/rainbow_header_basic.jsp" %>

        <div class="content sub-content sub05_content" id="main">
            <div class="header">
                <div class="titleBar h3">결제현황/환불</div>
                <!-- <h3 class="h3"></h3> -->
            </div>
            <div class="section section_sub05-01">
                <div class="sub-segment table">
                    <ul class="class-list-title thead d-flex">
                        <li class="c-table-02">과정명</li>
                        <li class="c-table-02">기수</li>
                        <li class="c-table-01">교육비</li>
                        <li class="c-table-01">마일리지사용</li>
                        <li class="c-table-01">결제금액</li>
                    </ul>
                    <ul class="class-list-wrap">

                        <li class="class-list d-flex text-center">
                            <div class="c-table-02 text-over-lh20" style="text-align:center; align-self:center;">${refundInfo.course_name}</div>
                            <div class="c-table-02 text-over-lh20" style="text-align:center; align-self:center;">${refundInfo.cardinal_name }</div>
                            <div class="c-table-01" style="text-align:center; align-self:center;"><fmt:formatNumber value="${refundInfo.price}" pattern="#,###" />원</div>

                            <c:if test="${refundInfo.dis_point == '' || refundInfo.dis_point == null}">
                            <div class="c-table-01" style="text-align:center; align-self:center;">0점</div>
                            </c:if>
                            
                            <c:if test="${refundInfo.dis_point != '' && refundInfo.dis_point != null}">
                            <div class="c-table-01" style="text-align:center; align-self:center;"><fmt:formatNumber value="${refundInfo.dis_point }" pattern="#,###" />점</div>
                            </c:if>

                            <c:if test="${refundInfo.real_payment != '' && refundInfo.real_payment != null}">
							<div class="c-table-01" style="text-align:center; align-self:center;"><fmt:formatNumber value="${refundInfo.real_payment }" pattern="#,###" />원</div>
                            </c:if>

                        </li>
                    </ul>
                </div>
            </div>
            <div class="section section_sub05-01">
            <form  action="/smtp/user/paybackUpdate-submit" method="post" id="refund_form" class="formStyle" style="text-align: center;">
				<input type="hidden" name="id" value="${refundInfo.learn_id}">
				<input type="hidden" name="pay_refund_seq" value="${accInfo.PAY_REFUND_SEQ}">            
				<div class="h3">환불정보입력</div>
				<div class="d-flex">
                        <label class="label" for="bank">은행명</label>
						<input type="text" class="input" style="width:60%;" id="bank" name="bank" placeholder="은행명을 입력하세요." value="${accInfo.PAY_REFUND_BANK}">
				</div>
				<div class="d-flex">
                        <label class="label" for="account">계좌번호</label>
						<input type="text" class="input" style="width:60%;" id="account" name="account" placeholder="계좌번호를을 입력하세요." value="${accInfo.PAY_REFUND_ACCNUM}">
				</div>
				<div class="d-flex">
                        <label class="label" for="owner">예금주</label>
						<input type="text" class="input" style="width:60%;" id="owner" name="owner" placeholder="예금주를 입력하세요." value="${accInfo.PAY_REFUND_ACCNAME}">
				</div>
				<div class="margin-top40">
					<input type="button" onclick="location.href='/smtp/user/sub05-04'" class="btn_normal btn_default btn_small margin-right10" style="height:30px;" value="돌아가기">
					<input type="button" id="refund_cancel" class="btn_normal btn_orangeD btn_small margin-right10" style="height:30px;" value="환불취소">
					<input type="button" id="refund_submit" class="btn_normal btn_orangeL btn_small" style="height:30px;" value="환불수정">
				</div>
            </form>
            </div>
        </div>
		<!-- footer-include -->
    	<%@include file="../include/common_footer_rainbow.jsp" %>
    </div>

</body>

</html>

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
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Let's Do it 두잇캠퍼스</title>
	<link rel="stylesheet" href="/resources/lms/css/reset.css">
	<link rel="stylesheet" href="/resources/lms/css/common.css">
	<link rel="stylesheet" type="text/css" href="<c:url value="/resources/lms/css/img-icon.css" />">
	<link rel="stylesheet" href="/resources/lms/css/style.css">
	<link rel="stylesheet" href="/resources/lms/css/style_responsive.css">
	<link rel="stylesheet" href="/resources/lms/css/renewal_style.css">
	<script src="<c:url value="/resources/lms/js/jquery-3.3.1.min.js" />"></script>
	<script src="<c:url value="/resources/lms/js/common.js" />"></script>
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

		var pay_toefl_seq = '${refundInfo.PAY_TOEFL_SEQ}';

		if(confirm('환불신청을 취소하시겠습니까?')){
			
	    	$.ajax({
				type	: "post",
				url		: "/lms/user/RefundCancel",
				data    : {
							'pay_toefl_seq' : pay_toefl_seq
						  },
				success	: function(flag) {
					if(flag){
						alert('환불취소 성공했습니다.');
						window.location.href = "/lms/user/sub07-02";
					} else{
						alert('환불취소 실패했습니다.');
						window.location.href = "/lms/user/sub07-02";						
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
    <div class="skip-navigation">
        <!--웹접근성/content-->
        <p><a class="goToMain" href="#main">콘텐츠 바로가기</a></p>
    </div>

    <!-- header-include -->
    <%@include file="../sub_header.jsp"%>


    <div class="container subPage_container sub07 d-flex" id="main">
        <!-- sub07 나의강의실-include -->
        <%@include file="../user/menu/leftmenu07.jsp"%>

        <div class="subPage_content sub-content margin-left20 sub07 sub07-02">
            <div class="header">
                <div class="titleBar h3">결제현황/환불</div>
                <!-- <h3 class="h3"></h3> -->
            </div>
            <div class="section sub07-02">
                <div class="sub-segment">
                    <ul class="class-list-title thead d-flex">
                        <li class="c-table-02">시험명</li>
                        <li class="c-table-01">시험비</li>
                        <li class="c-table-01">마일리지사용</li>
                        <li class="c-table-01">결제금액</li>
                    </ul>
                    <ul class="class-list-wrap">

                        <li class="class-list d-flex text-center">
							<div class="c-table-02 text-over-lh20" style="text-align:center; align-self:center;">${refundInfo.TOEFL_TITLE}</div>
                            <div class="c-table-01" style="text-align:center; align-self:center;"><fmt:formatNumber value="${refundInfo.TOEFL_PRICE}" pattern="#,###" />원</div>

                            <c:if test="${empty refundInfo.DIS_POINT || refundInfo.DIS_POINT == 'undefined'}">
                            <div class="c-table-01" style="text-align:center; align-self:center;">0점</div>
                            </c:if>
                            <c:if test="${not empty refundInfo.DIS_POINT && refundInfo.DIS_POINT != 'undefined'}">
                            <div class="c-table-01" style="text-align:center; align-self:center;"><fmt:formatNumber value="${refundInfo.DIS_POINT}" pattern="#,###" />점</div>
                            </c:if>

                            <c:if test="${empty refundInfo.REAL_PAY_AMOUNT || refundInfo.REAL_PAY_AMOUNT == 'undefined'}">
							<div class="c-table-01" style="text-align:center; align-self:center;">0원</div>
                            </c:if>
                            <c:if test="${not empty refundInfo.REAL_PAY_AMOUNT && refundInfo.REAL_PAY_AMOUNT != 'undefined'}">
							<div class="c-table-01" style="text-align:center; align-self:center;"><fmt:formatNumber value="${refundInfo.REAL_PAY_AMOUNT}" pattern="#,###" />원</div>
                            </c:if>
                        </li>
                    </ul>
                </div>
            </div>
            <div class="section sub07-02">
            <form  action="/lms/user/sub07-02-06-submit" method="post" id="refund_form" class="formStyle" style="text-align: center;">
				<input type="hidden" name="TOEFL_REFUND_SEQ" value="${accInfo.TOEFL_REFUND_SEQ}">
				<div class="h3">환불정보입력</div>
				<div class="d-flex">
                        <label class="label" for="bank">은행명</label>
						<input type="text" class="input" style="width:60%;" id="bank" name="bank" placeholder="은행명을 입력하세요." value="${accInfo.TOEFL_REFUND_BANK}">
				</div>
				<div class="d-flex">
                        <label class="label" for="account">계좌번호</label>
						<input type="text" class="input" style="width:60%;" id="account" name="account" placeholder="계좌번호를을 입력하세요." value="${accInfo.TOEFL_REFUND_ACCNUM}">
				</div>
				<div class="d-flex">
                        <label class="label" for="owner">예금주</label>
						<input type="text" class="input" style="width:60%;" id="owner" name="owner" placeholder="예금주를 입력하세요." value="${accInfo.TOEFL_REFUND_ACCNAME}">
				</div>
				<div class="margin-top40">
					<input type="button" onclick="location.href='/lms/user/sub07-02'" class="btn_normal btn_default btn_small margin-right10" style="height:30px;" value="돌아가기">
					<input type="button" id="refund_cancel" class="btn_normal btn_orangeD btn_small margin-right10" style="height:30px;" value="환불취소">
					<input type="button" id="refund_submit" class="btn_normal btn_orangeL btn_small" style="height:30px;" value="환불수정">
					
					
				</div>
            </form>

            </div>
        </div>
    </div>
    <!-- footer-include -->
    <%@include file="../common_footer_doitcam.jsp"%>
</body>

</html>
